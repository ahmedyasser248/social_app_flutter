import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state)
      { var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children:
              [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(
                    8.0,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                        ),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context, index,TextEditingController()),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.0,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index,TextEditingController controller) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     bottom: 10.0,
          //     top: 5.0,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //             end: 6.0,
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style:
          //                     Theme.of(context).textTheme.caption.copyWith(
          //                           color: defaultColor,
          //                         ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //             end: 6.0,
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#flutter',
          //                 style:
          //                     Theme.of(context).textTheme.caption.copyWith(
          //                           color: defaultColor,
          //                         ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  top: 15.0
              ),
              child: Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${model.postImage}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      var cubit = SocialCubit.get(context);
                      cubit.getLikers(cubit.postsId[index]).then((value) {
                        showModalBottomSheet(

                            elevation:10.0 ,
                            context: context,
                            builder: (context)=>
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                       'LIKES',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                    child: ListView.separated(itemBuilder:(context,index)=>buildLikeItem(SocialCubit.get(context).likers[index]) ,
                                    separatorBuilder: (context,index)=>SizedBox(height: 10.0,)
                                    , itemCount: SocialCubit.get(context).likers.length),
                                  ),
                                ]),

                        );
                      });

                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).comments.length}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      var cubit = SocialCubit.get(context);
                      cubit.getComments(cubit.postsId[index]).then((value){
                        showModalBottomSheet(
                          elevation: 10.0,
                          context: context,
                          builder: (context)=> Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Comments',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(itemBuilder:(context,index)=>buildCommentItem(cubit.comments[index], cubit.usersWhoCommented[index], 3, context) ,
                                    separatorBuilder: (context,index)=>SizedBox(height: 10.0,)
                                    , itemCount: SocialCubit.get(context).comments.length),
                              ),
                            ]),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).userModel!.image}',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            suffix: InkWell(
                              child: Icon(
                                Icons.send_outlined,
                                color: Colors.amber,
                              ),
                              onTap: (){
                                if(controller.text.isNotEmpty){
                                  var cubit =SocialCubit.get(context);
                                    cubit.postComment(controller.text.toString(),cubit.postsId[index]);
                                }
                              },
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.yellow,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.amber,
                                width: 2.0,
                              ),
                            ),

                            hintText: 'write  a commnet...',
                          ),
                          controller: controller,
                          validator: (String? value){
                            if(value!.isEmpty){
                              return 'write a comment first';
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 16.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: ()
                {  var cubit = SocialCubit.get(context);
                cubit.checkIfExist(cubit.postsId[index]).then((value) {
                  if(value){
                    cubit.unLikePost(cubit.postsId[index], index);
                    print(' didint liked it');
                  }else{
                    cubit.likePost(cubit.postsId[index],index);
                    print('liked it');
                  }
                });

                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
  Widget buildLikeItem(SocialUserModel model) =>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(model.image!),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            height: 1.4
          ),
        )
      ],
    ),
  );
}

Widget buildCommentItem(CommentModel commentModel,SocialUserModel userModel,maxlines,context) => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(

        radius: 25.0,
        backgroundImage: NetworkImage(userModel.image!),
      ),
      SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text(
              userModel.name!,
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all( color: Colors.black12, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: LayoutBuilder(
                    builder: (context,size){

                  final span = TextSpan(text: commentModel.comment!);
                  final tp = TextPainter(text: span, maxLines: maxlines,textDirection: TextDirection.ltr);
                  tp.layout(maxWidth: size.maxWidth);
                  if(tp.didExceedMaxLines){
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            '${commentModel.comment!}',
                            maxLines: maxlines,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                        TextButton(onPressed:(){
                          maxlines = maxlines != null? null:3;
                          SocialCubit.get(context).changeCommentState();
                        }, child: Text(
                          ' See more',
                          style: TextStyle(

                            color: Colors.blue,
                            decoration: TextDecoration.underline
                          ),
                        ),

                        )
                      ],
                    );
                  }else{
                    return RichText(text:  TextSpan(
                    style: TextStyle(
                    color: Colors.black,
                      fontSize: 15.0,
                    ),
                      children: <TextSpan>[
                      TextSpan(text: commentModel.comment!,
                      ),
                      ]
                    )
                    );
                  }
                }),
              )
            ),
          ]
        ),
      )
    ],
  ),
);
/*
RichText(text: TextSpan(
style: TextStyle(
color: Colors.black,
fontSize: 15.0,
),
children: <TextSpan>[
TextSpan(text: commentModel.comment!,
),
TextSpan(
text: '..See more',
style: TextStyle(
color: Colors.blue,
fontSize: 16.0,
overflow:TextOverflow.ellipsis
),
recognizer: TapGestureRecognizer()
..onTap=(){
maxlines = maxlines != null ? null : 3 ;
SocialCubit.get(context).changeCommentState();
}

)
]
));*/