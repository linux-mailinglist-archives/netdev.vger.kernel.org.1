Return-Path: <netdev+bounces-61233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F142822F30
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B09B2110B
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB2B1A293;
	Wed,  3 Jan 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="J0fMuPk6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B11A27A
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e840338607so65548807b3.2
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 06:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704290966; x=1704895766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eq6/u7wFMYqMlWarwPtiUrTScgPeuGXg34ektSVYQWY=;
        b=J0fMuPk6tybJJ+Y/vr57K4ipwyYUWLsvgN5CQGUWcZil77uixYQcoKJqQOHsFmT+o/
         sT1Kt9i6/O1o8/oPgi03Bp464pvNmcjYLqyvFwpu8GHqf//2F1szV0zXWasQZNcU2fO7
         +1L4hDeMcQR/mVAnyXzhfuOTtEFtEOaRVy+SwGJsrtMiQcJuBgTo+kZpX0g+jUHWRW95
         upGph+scC37Q3Xn0Kf20uGoEOKcV/qh7+gVazbwBZ4u/wLaUBabve04Rt+vwZtO8Y9vG
         P6H1rfuRd4e3YnfC/Zu4HxTnetWrjPinKTS2PpsfklMQLaYa2VPIf5AGw1vbyjRg6DUt
         FE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704290966; x=1704895766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eq6/u7wFMYqMlWarwPtiUrTScgPeuGXg34ektSVYQWY=;
        b=Ys6w1pILP59GHoB007M8z+Ql3oqiW6AUa8+OxvetvNEMBdOWVze/zXEBbnKfpe5V8n
         MWxGCCDH10z2c1JoKy/ar+425eZJv4ctiyeEGhoLK5e0dhZJc/PmfRPUJXjbhsWkoV9G
         3ITcZtUbisImGP51dotLh+jI1AmOgoEmu2S+HfxNXZg2k8Y0Wzay9tTWF7LMVb/ieyfN
         m3/jpRa0qBojp0NbaWSm8K2Q7U+nSazRDjBgesHLZyjpSTV7BEFuO9nnuJzmxY+1tgKj
         YWt1KUqFzbFjZWKI2CiXH8/20d2PMiy8t+x80goVbOs6F5Vuji2d+tgsTT7gkuB2u9s3
         pRKA==
X-Gm-Message-State: AOJu0YxSdH2KIeH+0P5wvgss+yx0TQfCcMROCpovI/CM/IZo7sRMLWdf
	ybD3YfSP66I+A7i7KbigI/8bqf0NTkTDeXlpCyfRYBC5RjHv
X-Google-Smtp-Source: AGHT+IEpe/NP97HJdZrBavgqpsfvjFqvnoI39ADMTk03ST/u5YYIaL4OWd+WPFPZEIgq1XE/1csjQVTcTxJt+m+P+gY=
X-Received: by 2002:a81:830a:0:b0:5e8:209d:f9fd with SMTP id
 t10-20020a81830a000000b005e8209df9fdmr7803607ywf.57.1704290965713; Wed, 03
 Jan 2024 06:09:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231172320.245375-1-victor@mojatatu.com> <ZZPekLXICu2AUxlX@nanopsycho>
 <CAM0EoMkKmF3mhnHLt6gE2bmpuRGV7=OpzrMrOwtk3TJcDFW2JA@mail.gmail.com>
 <ZZQd470J2Q4UEMHv@nanopsycho> <CAM0EoMkUQzxtiaB9r=Tz5Wc3KfEDCfyy5ENSeb8M+iK9fs_HVQ@mail.gmail.com>
 <ZZQxmg3QOxzXcrW0@nanopsycho> <CAM0EoMkAx0bWO7NirsoaKHEHso_GjYL1Kedxsbgfr4cstbwmxw@mail.gmail.com>
 <ZZVaIOay_IqSDabg@nanopsycho>
In-Reply-To: <ZZVaIOay_IqSDabg@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 3 Jan 2024 09:09:14 -0500
Message-ID: <CAM0EoMm2Jp6faTOnFxzZi6_bMVZn2dkrkRHNEGpqQvJnWLN8-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/1] net/sched: We should only add appropriate
 qdiscs blocks to ports' xarray
To: Jiri Pirko <jiri@resnulli.us>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	idosch@idosch.org, mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com, 
	syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com, 
	syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com, 
	syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 7:59=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Jan 02, 2024 at 06:06:00PM CET, jhs@mojatatu.com wrote:
> >On Tue, Jan 2, 2024 at 10:54=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Tue, Jan 02, 2024 at 03:52:01PM CET, jhs@mojatatu.com wrote:
> >> >On Tue, Jan 2, 2024 at 9:29=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> =
wrote:
> >> >>
> >> >> Tue, Jan 02, 2024 at 03:06:28PM CET, jhs@mojatatu.com wrote:
> >> >> >On Tue, Jan 2, 2024 at 4:59=E2=80=AFAM Jiri Pirko <jiri@resnulli.u=
s> wrote:
> >> >> >>
> >> >> >> The patch subject should briefly describe the nature of the chan=
ge. Not
> >> >> >> what "we" should or should not do.
> >> >> >>
> >> >> >>
> >> >> >> Sun, Dec 31, 2023 at 06:23:20PM CET, victor@mojatatu.com wrote:
> >> >> >> >We should only add qdiscs to the blocks ports' xarray in ingres=
s that
> >> >> >> >support ingress_block_set/get or in egress that support
> >> >> >> >egress_block_set/get.
> >> >> >>
> >> >> >> Tell the codebase what to do, be imperative. Please read again:
> >> >> >> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.=
html#describe-your-changes
> >> >> >>
> >> >> >
> >> >> >We need another rule in the doc on nit-picking which states that w=
e
> >> >> >need to make progress at some point. We made many changes to this
> >> >> >patchset based on your suggestions for no other reason other that =
we
> >> >> >can progress the discussion. This is a patch that fixes a bug of w=
hich
> >> >> >there are multiple syzbot reports and consumers of the API(last on=
e
> >> >> >just reported from the MTCP people). There's some sense of urgency=
 to
> >> >> >apply this patch before the original goes into net. More important=
ly:
> >> >> >This patch fixes the issue and follows the same common check which=
 was
> >> >> >already being done in the committed patchset to check if the qdisc
> >> >> >supports the block set/get operations.
> >> >> >
> >> >> >There are about 3 ways to do this check, you objected to the origi=
nal,
> >> >> >we picked something that works fine,  and now you are picking a
> >> >> >different way with tcf_block. I dont see how tcf_block check would
> >> >> >help or solve this problem at all given this is a qdisc issue not =
a
> >> >> >class issue. What am I missing?
> >> >>
> >> >> Perhaps I got something wrong, but I thought that the issue is
> >> >> cl_ops->tcf_block being null for some qdiscs, isn't it?
> >> >>
> >> >
> >> >We attach these ports/netdevs only on capable qdiscs i.e ones that
> >> >have  in/egress_block_set/get() - which happen to be ingress and
> >> >clsact only.
> >> >The problem was we were blindly assuming that presence of
> >> >cl->tcf_block() implies presence of in/egress_block_set/get(). The
> >> >earlier patches surrounded this code with attribute checks and so it
> >> >worked there.
> >>
> >> Syskaller report says:
> >>
> >> KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
> >> CPU: 1 PID: 5061 Comm: syz-executor323 Not tainted 6.7.0-rc6-syzkaller=
-01658-gc2b2ee36250d #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 11/17/2023
> >> RIP: 0010:qdisc_block_add_dev net/sched/sch_api.c:1190 [inline]
> >>
> >> Line 1190 is:
> >> block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >>
> >> So the cl_ops->tcf_block =3D=3D NULL
> >>
> >> Why can't you just check it? Why do you want to check in/egress_block_=
set/get()
> >> instead? I don't follow :/
> >>
> >
> >Does it make sense to add to the port xarray just because we have
> >cl_ops->tcf_block()? There are many qdiscs which have
> >cl_ops->tcf_block() (example htb) but cant be used in the block add
> >syntax (see question further below on tdc test).
>
> The whole block usage in qdiscs other than ingress and clsact seems odd
> to me to be honest. What's the reason for that?.

Well, you added that code so you tell me. Was the original idea to
allow grafting other qdiscs on a hierarchy? This is why i was asking
for a sample use case to add to tdc.
This was why our check is for "if (sch_ops->in/egress_block_get)"
because the check for cl_ops->tcf_block() you suggested is not correct
(it will match htb just fine for example) whereas this check will only
catch cls_act and ingress.

> >--
> >$sudo tc qdisc add dev lo egress_block 21 handle 1: root htb
> >Error: Egress block sharing is not supported.
> >---
> >
> >Did you look at the other syzbot reports?
>
> Yeah. The block usage in other qdiscs looks very odd.
>

And we have checks to catch it as you see.
TBH, the idea of having cls_ops->tcf_block for a qdisc like htb is
puzzling to me. It seems you are always creating a non-shared block
for some but not all qdiscs regardless. What is that used for?

>
> >
> >> Btw, the checks in __qdisc_destroy() do also look wrong.
> >
> >Now I am not following, please explain. The same code structure check
> >is used in fill_qdisc
> >(https://elixir.bootlin.com/linux/v6.7-rc8/source/net/sched/sch_api.c#L9=
40)
> >for example to pull the block info, is that wrong?
>
> There, you don't call tcf_block() at all, so how is that relevant?
>

Why do we need to call it? We just need it to retrieve the block id.

>
>
> >
> >> >
> >> >BTW: Do you have an example of a test case where we can test the clas=
s
> >> >grafting (eg using htb with tcf_block)? It doesnt have any impact on
> >> >this patcheset here but we want to add it as a regression checker on
> >> >tdc in the future if someone makes a change.
> >
> >An answer to this will help.
>
> Answer is "no".

Ok, so we cant test this or this is internal use only?

I am going to repeat again here: you are holding back a bug fix (with
many reports) with this discussion. We can have the discussion
separately but let's make quick progress. If need be we can send fixes
after.

cheers,
jamal


> >
> >cheers,
> >jamal
> >
> >
> >> >cheers,
> >> >jamal
> >> >
> >> >> >
> >> >> >cheers,
> >> >> >jamal
> >> >> >
> >> >> >> >
> >> >> >> >Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev trac=
king infra")
> >> >> >> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >> >> >> >Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> >> >> >Reported-by: Ido Schimmel <idosch@nvidia.com>
> >> >> >> >Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
> >> >> >> >Tested-by: Ido Schimmel <idosch@nvidia.com>
> >> >> >> >Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.a=
ppspotmail.com
> >> >> >> >Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a2=
8@google.com/
> >> >> >> >Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.a=
ppspotmail.com
> >> >> >> >Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a9=
2@google.com/
> >> >> >> >Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.a=
ppspotmail.com
> >> >> >> >Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5=
c@google.com/
> >> >> >> >---
> >> >> >> >v1 -> v2:
> >> >> >> >
> >> >> >> >- Remove newline between fixes tag and Signed-off-by tag
> >> >> >> >- Add Ido's Reported-by and Tested-by tags
> >> >> >> >- Add syzbot's Reported-and-tested-by tags
> >> >> >> >
> >> >> >> > net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
> >> >> >> > 1 file changed, 20 insertions(+), 14 deletions(-)
> >> >> >> >
> >> >> >> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> >> >> >> >index 299086bb6205..426be81276f1 100644
> >> >> >> >--- a/net/sched/sch_api.c
> >> >> >> >+++ b/net/sched/sch_api.c
> >> >> >> >@@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Q=
disc *sch, struct net_device *dev,
> >> >> >> >       struct tcf_block *block;
> >> >> >> >       int err;
> >> >> >> >
> >> >> >>
> >> >> >> Why don't you just check cl_ops->tcf_block ?
> >> >> >> In fact, there could be a helper to do it for you either call th=
e op or
> >> >> >> return NULL in case it is not defined.
> >> >> >>
> >> >> >>
> >> >> >> >-      block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL)=
;
> >> >> >> >-      if (block) {
> >> >> >> >-              err =3D xa_insert(&block->ports, dev->ifindex, d=
ev, GFP_KERNEL);
> >> >> >> >-              if (err) {
> >> >> >> >-                      NL_SET_ERR_MSG(extack,
> >> >> >> >-                                     "ingress block dev insert=
 failed");
> >> >> >> >-                      return err;
> >> >> >> >+      if (sch->ops->ingress_block_get) {
> >> >> >> >+              block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRES=
S, NULL);
> >> >> >> >+              if (block) {
> >> >> >> >+                      err =3D xa_insert(&block->ports, dev->if=
index, dev,
> >> >> >> >+                                      GFP_KERNEL);
> >> >> >> >+                      if (err) {
> >> >> >> >+                              NL_SET_ERR_MSG(extack,
> >> >> >> >+                                             "ingress block de=
v insert failed");
> >> >> >> >+                              return err;
> >> >> >> >+                      }
> >> >> >> >               }
> >> >> >> >       }
> >> >> >> >
> >> >> >> >-      block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> >> >> >> >-      if (block) {
> >> >> >> >-              err =3D xa_insert(&block->ports, dev->ifindex, d=
ev, GFP_KERNEL);
> >> >> >> >-              if (err) {
> >> >> >> >-                      NL_SET_ERR_MSG(extack,
> >> >> >> >-                                     "Egress block dev insert =
failed");
> >> >> >> >-                      goto err_out;
> >> >> >> >+      if (sch->ops->egress_block_get) {
> >> >> >> >+              block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS=
, NULL);
> >> >> >> >+              if (block) {
> >> >> >> >+                      err =3D xa_insert(&block->ports, dev->if=
index, dev,
> >> >> >> >+                                      GFP_KERNEL);
> >> >> >> >+                      if (err) {
> >> >> >> >+                              NL_SET_ERR_MSG(extack,
> >> >> >> >+                                             "Egress block dev=
 insert failed");
> >> >> >> >+                              goto err_out;
> >> >> >> >+                      }
> >> >> >> >               }
> >> >> >> >       }
> >> >> >> >
> >> >> >> >--
> >> >> >> >2.25.1
> >> >> >> >

