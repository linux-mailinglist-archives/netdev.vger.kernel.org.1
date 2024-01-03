Return-Path: <netdev+bounces-61258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3242822FC0
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6A21C23724
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BCD1A5A4;
	Wed,  3 Jan 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="yfp2rND3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21F71A705
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbe78430946so2036320276.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704292992; x=1704897792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vcMASy38OPd2xwaul4EF2fI0d4xCLqt/shy1f7vRiI=;
        b=yfp2rND3REknc30hp3R3eN6sxEsE/CDPkYBUeeyDwCw/MmZc1RIgvUZ79y/C2dR4gY
         S6vAcYxXvoWhNT0jAzwC19JIt7LLPB5eYqWruFjSdUMCNdEQbsVWj01SDOoqlqA9E/r7
         5FOBEvqLj+SZnjw06IyNdZxiOgZ0w/hlBar0F1dW6qy15NGRcUsHuB4AjscaNsj8Gp/5
         yhpI6oONMgbVChEBkU7/hfhAon1mS5+PamoKcGEkGizycEe1IvHP/q9e56i1I0F9bOhB
         gPFZIHao3cJFh8k8DbpfqGcHdLrYOjazVnQ2emojAXt5pNm31JtRy8QYHuuo9366CaFk
         j8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704292992; x=1704897792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vcMASy38OPd2xwaul4EF2fI0d4xCLqt/shy1f7vRiI=;
        b=pLX1V4GMCYSoIWMgqAd06U49qF3vaZTnA8TjrdVbnSaY8TEZZJAqrVJXLg8o6jfAbE
         tTxRRxhPcD8X2sOA6njVvc4nyEzZgOe8jsF38E9iZaAcKEjDZYC9PGliQMZ1/3g6eVD2
         bFbr1/mLfGoFw4/poxVq5ZfSHc3TW4udcZciJ2JvbOYAaUgC3ILntvC5kuohijW7zcHD
         ej+zHozgAmRjrsGQCQA7E5r3ckzjWVj8/4bsGkgg4MUXe2FzaVIMeXihaA5Q6ORmN1H6
         0AVgspZxGloZlH7pMkS0y6mQ855rN2PX2IZvurHibfQN2yzBBOs6TJ5UZXateLl8huZ8
         jsQw==
X-Gm-Message-State: AOJu0YyLD1dM6Z5Wmq3ZFTW3A1dAI3oxvo3H6c+qZaMm88r/9Bdk2Ab9
	mferNcS7IxqZtVJw3hk+YkCalmEs1H0vmUIxf+4THAHxyqjb
X-Google-Smtp-Source: AGHT+IFj446GNZUUPwqMFLqi0awNKzzsGSFwko9lQ5XH+SJcQn1tCJh0LilLjPIMpMHcJf5/stRtrKdTXiiJhchsYwE=
X-Received: by 2002:a25:83c4:0:b0:dbe:1ccb:751a with SMTP id
 v4-20020a2583c4000000b00dbe1ccb751amr6380962ybm.31.1704292992340; Wed, 03 Jan
 2024 06:43:12 -0800 (PST)
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
 <ZZVaIOay_IqSDabg@nanopsycho> <CAM0EoMm2Jp6faTOnFxzZi6_bMVZn2dkrkRHNEGpqQvJnWLN8-Q@mail.gmail.com>
 <ZZVuh0N_DVqFG_z3@nanopsycho>
In-Reply-To: <ZZVuh0N_DVqFG_z3@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 3 Jan 2024 09:43:00 -0500
Message-ID: <CAM0EoMm9MQC_hbzhkVu7+B_VEJpLOeZ-uPNrJJsaNs9YA7gj_g@mail.gmail.com>
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

On Wed, Jan 3, 2024 at 9:26=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Wed, Jan 03, 2024 at 03:09:14PM CET, jhs@mojatatu.com wrote:
> >On Wed, Jan 3, 2024 at 7:59=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Tue, Jan 02, 2024 at 06:06:00PM CET, jhs@mojatatu.com wrote:
> >> >On Tue, Jan 2, 2024 at 10:54=E2=80=AFAM Jiri Pirko <jiri@resnulli.us>=
 wrote:
> >> >>
> >> >> Tue, Jan 02, 2024 at 03:52:01PM CET, jhs@mojatatu.com wrote:
> >> >> >On Tue, Jan 2, 2024 at 9:29=E2=80=AFAM Jiri Pirko <jiri@resnulli.u=
s> wrote:
> >> >> >>
> >> >> >> Tue, Jan 02, 2024 at 03:06:28PM CET, jhs@mojatatu.com wrote:
> >> >> >> >On Tue, Jan 2, 2024 at 4:59=E2=80=AFAM Jiri Pirko <jiri@resnull=
i.us> wrote:
> >> >> >> >>
> >> >> >> >> The patch subject should briefly describe the nature of the c=
hange. Not
> >> >> >> >> what "we" should or should not do.
> >> >> >> >>
> >> >> >> >>
> >> >> >> >> Sun, Dec 31, 2023 at 06:23:20PM CET, victor@mojatatu.com wrot=
e:
> >> >> >> >> >We should only add qdiscs to the blocks ports' xarray in ing=
ress that
> >> >> >> >> >support ingress_block_set/get or in egress that support
> >> >> >> >> >egress_block_set/get.
> >> >> >> >>
> >> >> >> >> Tell the codebase what to do, be imperative. Please read agai=
n:
> >> >> >> >> https://www.kernel.org/doc/html/v6.6/process/submitting-patch=
es.html#describe-your-changes
> >> >> >> >>
> >> >> >> >
> >> >> >> >We need another rule in the doc on nit-picking which states tha=
t we
> >> >> >> >need to make progress at some point. We made many changes to th=
is
> >> >> >> >patchset based on your suggestions for no other reason other th=
at we
> >> >> >> >can progress the discussion. This is a patch that fixes a bug o=
f which
> >> >> >> >there are multiple syzbot reports and consumers of the API(last=
 one
> >> >> >> >just reported from the MTCP people). There's some sense of urge=
ncy to
> >> >> >> >apply this patch before the original goes into net. More import=
antly:
> >> >> >> >This patch fixes the issue and follows the same common check wh=
ich was
> >> >> >> >already being done in the committed patchset to check if the qd=
isc
> >> >> >> >supports the block set/get operations.
> >> >> >> >
> >> >> >> >There are about 3 ways to do this check, you objected to the or=
iginal,
> >> >> >> >we picked something that works fine,  and now you are picking a
> >> >> >> >different way with tcf_block. I dont see how tcf_block check wo=
uld
> >> >> >> >help or solve this problem at all given this is a qdisc issue n=
ot a
> >> >> >> >class issue. What am I missing?
> >> >> >>
> >> >> >> Perhaps I got something wrong, but I thought that the issue is
> >> >> >> cl_ops->tcf_block being null for some qdiscs, isn't it?
> >> >> >>
> >> >> >
> >> >> >We attach these ports/netdevs only on capable qdiscs i.e ones that
> >> >> >have  in/egress_block_set/get() - which happen to be ingress and
> >> >> >clsact only.
> >> >> >The problem was we were blindly assuming that presence of
> >> >> >cl->tcf_block() implies presence of in/egress_block_set/get(). The
> >> >> >earlier patches surrounded this code with attribute checks and so =
it
> >> >> >worked there.
> >> >>
> >> >> Syskaller report says:
> >> >>
> >> >> KASAN: null-ptr-deref in range [0x0000000000000048-0x00000000000000=
4f]
> >> >> CPU: 1 PID: 5061 Comm: syz-executor323 Not tainted 6.7.0-rc6-syzkal=
ler-01658-gc2b2ee36250d #0
> >> >> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 11/17/2023
> >> >> RIP: 0010:qdisc_block_add_dev net/sched/sch_api.c:1190 [inline]
> >> >>
> >> >> Line 1190 is:
> >> >> block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >> >>
> >> >> So the cl_ops->tcf_block =3D=3D NULL
> >> >>
> >> >> Why can't you just check it? Why do you want to check in/egress_blo=
ck_set/get()
> >> >> instead? I don't follow :/
> >> >>
> >> >
> >> >Does it make sense to add to the port xarray just because we have
> >> >cl_ops->tcf_block()? There are many qdiscs which have
> >> >cl_ops->tcf_block() (example htb) but cant be used in the block add
> >> >syntax (see question further below on tdc test).
> >>
> >> The whole block usage in qdiscs other than ingress and clsact seems od=
d
> >> to me to be honest. What's the reason for that?.
> >
> >Well, you added that code so you tell me. Was the original idea to
>
> Well, I added it only for clsact and ingress. The rest is unrelated to
> me.
>

Well git is blaming you..

> >allow grafting other qdiscs on a hierarchy? This is why i was asking
> >for a sample use case to add to tdc.
> >This was why our check is for "if (sch_ops->in/egress_block_get)"
> >because the check for cl_ops->tcf_block() you suggested is not correct
> >(it will match htb just fine for example) whereas this check will only
> >catch cls_act and ingress.
>
> This code went off rails :/
> The point is, mixing sch_ops->in/egress_block_get existence and cl_ops->t=
cf_block
> looks awfully odd and inviting another bugs in the future.
>

What bugs? Be explicit so we can add tdc tests.

> >> >--
> >> >$sudo tc qdisc add dev lo egress_block 21 handle 1: root htb
> >> >Error: Egress block sharing is not supported.
> >> >---
> >> >
> >> >Did you look at the other syzbot reports?
> >>
> >> Yeah. The block usage in other qdiscs looks very odd.
> >>
> >
> >And we have checks to catch it as you see.
> >TBH, the idea of having cls_ops->tcf_block for a qdisc like htb is
> >puzzling to me. It seems you are always creating a non-shared block
> >for some but not all qdiscs regardless. What is that used for?
>
> No clue.
>

Well, if you cant remember a few years later then we'll look at
removing it - it will require a lot more testing like i said.

> >
> >>
> >> >
> >> >> Btw, the checks in __qdisc_destroy() do also look wrong.
> >> >
> >> >Now I am not following, please explain. The same code structure check
> >> >is used in fill_qdisc
> >> >(https://elixir.bootlin.com/linux/v6.7-rc8/source/net/sched/sch_api.c=
#L940)
> >> >for example to pull the block info, is that wrong?
> >>
> >> There, you don't call tcf_block() at all, so how is that relevant?
> >>
> >
> >Why do we need to call it? We just need it to retrieve the block id.
>
> Uff, that is my point. In the code you are pointing at, you don't use
> tcf_block() at all, therefore it is not related to our discussion, is
> it?
>

Huh? We are trying to check if it is legit to add a netdev to the
xarray. The only way it is legit is if we have ingress or clsact.
Those are the only two qdiscs with the set/get ops for blocks and the
only potential ones which we can have valid shared blocks attached. It
is related to the discussion.

> >
> >>
> >>
> >> >
> >> >> >
> >> >> >BTW: Do you have an example of a test case where we can test the c=
lass
> >> >> >grafting (eg using htb with tcf_block)? It doesnt have any impact =
on
> >> >> >this patcheset here but we want to add it as a regression checker =
on
> >> >> >tdc in the future if someone makes a change.
> >> >
> >> >An answer to this will help.
> >>
> >> Answer is "no".
> >
> >Ok, so we cant test this or this is internal use only?
> >
> >I am going to repeat again here: you are holding back a bug fix (with
> >many reports) with this discussion. We can have the discussion
> >separately but let's make quick progress. If need be we can send fixes
> >after.
>
> I don't mind. Code is a mess as it is already. One more crap won't
> hurt...
>

Ok, so your code that you added a few years ago is crap then by that
metric. You can't even remember why you added it.
You have provided no legit argument for the approach you are
suggesting and i see nothing wrong with what we did. Let's agree to
disagree in order to make progress and get the bug resolved.
Please ACK the patch and we can discuss if we need to remove the class
ops separately.

cheers,
jamal

>
> >
> >cheers,
> >jamal
> >
> >
> >> >
> >> >cheers,
> >> >jamal
> >> >
> >> >
> >> >> >cheers,
> >> >> >jamal
> >> >> >
> >> >> >> >
> >> >> >> >cheers,
> >> >> >> >jamal
> >> >> >> >
> >> >> >> >> >
> >> >> >> >> >Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev t=
racking infra")
> >> >> >> >> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >> >> >> >> >Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> >> >> >> >Reported-by: Ido Schimmel <idosch@nvidia.com>
> >> >> >> >> >Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredde=
r/
> >> >> >> >> >Tested-by: Ido Schimmel <idosch@nvidia.com>
> >> >> >> >> >Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkalle=
r.appspotmail.com
> >> >> >> >> >Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc=
3a28@google.com/
> >> >> >> >> >Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkalle=
r.appspotmail.com
> >> >> >> >> >Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc=
3a92@google.com/
> >> >> >> >> >Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkalle=
r.appspotmail.com
> >> >> >> >> >Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc=
3a5c@google.com/
> >> >> >> >> >---
> >> >> >> >> >v1 -> v2:
> >> >> >> >> >
> >> >> >> >> >- Remove newline between fixes tag and Signed-off-by tag
> >> >> >> >> >- Add Ido's Reported-by and Tested-by tags
> >> >> >> >> >- Add syzbot's Reported-and-tested-by tags
> >> >> >> >> >
> >> >> >> >> > net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
> >> >> >> >> > 1 file changed, 20 insertions(+), 14 deletions(-)
> >> >> >> >> >
> >> >> >> >> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> >> >> >> >> >index 299086bb6205..426be81276f1 100644
> >> >> >> >> >--- a/net/sched/sch_api.c
> >> >> >> >> >+++ b/net/sched/sch_api.c
> >> >> >> >> >@@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struc=
t Qdisc *sch, struct net_device *dev,
> >> >> >> >> >       struct tcf_block *block;
> >> >> >> >> >       int err;
> >> >> >> >> >
> >> >> >> >>
> >> >> >> >> Why don't you just check cl_ops->tcf_block ?
> >> >> >> >> In fact, there could be a helper to do it for you either call=
 the op or
> >> >> >> >> return NULL in case it is not defined.
> >> >> >> >>
> >> >> >> >>
> >> >> >> >> >-      block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NU=
LL);
> >> >> >> >> >-      if (block) {
> >> >> >> >> >-              err =3D xa_insert(&block->ports, dev->ifindex=
, dev, GFP_KERNEL);
> >> >> >> >> >-              if (err) {
> >> >> >> >> >-                      NL_SET_ERR_MSG(extack,
> >> >> >> >> >-                                     "ingress block dev ins=
ert failed");
> >> >> >> >> >-                      return err;
> >> >> >> >> >+      if (sch->ops->ingress_block_get) {
> >> >> >> >> >+              block =3D cl_ops->tcf_block(sch, TC_H_MIN_ING=
RESS, NULL);
> >> >> >> >> >+              if (block) {
> >> >> >> >> >+                      err =3D xa_insert(&block->ports, dev-=
>ifindex, dev,
> >> >> >> >> >+                                      GFP_KERNEL);
> >> >> >> >> >+                      if (err) {
> >> >> >> >> >+                              NL_SET_ERR_MSG(extack,
> >> >> >> >> >+                                             "ingress block=
 dev insert failed");
> >> >> >> >> >+                              return err;
> >> >> >> >> >+                      }
> >> >> >> >> >               }
> >> >> >> >> >       }
> >> >> >> >> >
> >> >> >> >> >-      block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NUL=
L);
> >> >> >> >> >-      if (block) {
> >> >> >> >> >-              err =3D xa_insert(&block->ports, dev->ifindex=
, dev, GFP_KERNEL);
> >> >> >> >> >-              if (err) {
> >> >> >> >> >-                      NL_SET_ERR_MSG(extack,
> >> >> >> >> >-                                     "Egress block dev inse=
rt failed");
> >> >> >> >> >-                      goto err_out;
> >> >> >> >> >+      if (sch->ops->egress_block_get) {
> >> >> >> >> >+              block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGR=
ESS, NULL);
> >> >> >> >> >+              if (block) {
> >> >> >> >> >+                      err =3D xa_insert(&block->ports, dev-=
>ifindex, dev,
> >> >> >> >> >+                                      GFP_KERNEL);
> >> >> >> >> >+                      if (err) {
> >> >> >> >> >+                              NL_SET_ERR_MSG(extack,
> >> >> >> >> >+                                             "Egress block =
dev insert failed");
> >> >> >> >> >+                              goto err_out;
> >> >> >> >> >+                      }
> >> >> >> >> >               }
> >> >> >> >> >       }
> >> >> >> >> >
> >> >> >> >> >--
> >> >> >> >> >2.25.1
> >> >> >> >> >

