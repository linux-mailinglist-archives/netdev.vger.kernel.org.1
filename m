Return-Path: <netdev+bounces-60926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A104821E1B
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0021C221BA
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DF311C85;
	Tue,  2 Jan 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KXVHCBUt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9D14267
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ec7a5a4b34so54701137b3.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704207133; x=1704811933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/j/tpFFEL8fY47ZhPkW1ogVKL0JcwptmB+119/adcuQ=;
        b=KXVHCBUtPwc5W7o2ux+4o+ChhMHjxAzlnutimHD4MhZ1y9vxkIX5lcCU7xK2nm1WEs
         XxfwBhhGaDUq1SnK+yqAopY8K1sTcSq6QFniebm3ywJpWo7ktwsJbBm/UaJACXdDNgN9
         kpt2P8tkIeWnJDCdVm6crrOY8AdM8DAitKXMOKem9vS/6WWZxplgzRR3m/vZQpXMSg7C
         wF+1feVRTUZmPH2Q+bgW0Wk3JWeeJtoWL6GkPdu5iertVT2bzXd8TxUahrPKyNERQ76x
         /ee6wGlk+/o7/T0oZAT91CI711O4vLca69cbKaLPj+ra/trx/KAGBkxBJn1iD9svz8B6
         dVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207133; x=1704811933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/j/tpFFEL8fY47ZhPkW1ogVKL0JcwptmB+119/adcuQ=;
        b=WmNHap753gvDJd0Nt4x1Ed5V0Wxed9CWySOhwGIdD4ORfH228U0tt+zUgsQVnji6bK
         jMiM+4340wo3OsF26arPB+m50hgqYNCSQud8ydD6sxejsG9N2aeS6x6CNk66xrmFb3Td
         nYpKGo9DSG4YyrbvNUstYV1QMZk53F95jpaCVIvlQ/byxfXAeIPGE5AUTpcGI/kFRFhI
         Djz1Y9eGHPMBysPaM8VH4Tt8CwRJWYYdF+oO7dnAST7swiJsSfUVvDE5mLKcorRgrwQn
         +lCX4LK71dI9POGKMO52Dkppo4QG0FStBu40TDx+wSlKk+NJw1yAI3vxjHyDHxJXn6ZD
         QhtA==
X-Gm-Message-State: AOJu0YzWlYJPMHZVUdgFv4oBuig02F9k/uCPRmIQJWHwGBXiuz4pMpV4
	Ocax/CadFTFjxT1wpRuj+bBSY4OX18zSEUznYZ6mKiupjhf7
X-Google-Smtp-Source: AGHT+IGxXtMBrjImye1KOtOry0zZ9YWnJnzgRwLDeGv7SJAyYzrSz2acqPlgZtjZM/ZvRHK7uAw+vtJTvbzTVav/St8=
X-Received: by 2002:a81:5b8a:0:b0:5d7:1940:f3e9 with SMTP id
 p132-20020a815b8a000000b005d71940f3e9mr11915188ywb.81.1704207133031; Tue, 02
 Jan 2024 06:52:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231172320.245375-1-victor@mojatatu.com> <ZZPekLXICu2AUxlX@nanopsycho>
 <CAM0EoMkKmF3mhnHLt6gE2bmpuRGV7=OpzrMrOwtk3TJcDFW2JA@mail.gmail.com> <ZZQd470J2Q4UEMHv@nanopsycho>
In-Reply-To: <ZZQd470J2Q4UEMHv@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 2 Jan 2024 09:52:01 -0500
Message-ID: <CAM0EoMkUQzxtiaB9r=Tz5Wc3KfEDCfyy5ENSeb8M+iK9fs_HVQ@mail.gmail.com>
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

On Tue, Jan 2, 2024 at 9:29=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Jan 02, 2024 at 03:06:28PM CET, jhs@mojatatu.com wrote:
> >On Tue, Jan 2, 2024 at 4:59=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> The patch subject should briefly describe the nature of the change. No=
t
> >> what "we" should or should not do.
> >>
> >>
> >> Sun, Dec 31, 2023 at 06:23:20PM CET, victor@mojatatu.com wrote:
> >> >We should only add qdiscs to the blocks ports' xarray in ingress that
> >> >support ingress_block_set/get or in egress that support
> >> >egress_block_set/get.
> >>
> >> Tell the codebase what to do, be imperative. Please read again:
> >> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#d=
escribe-your-changes
> >>
> >
> >We need another rule in the doc on nit-picking which states that we
> >need to make progress at some point. We made many changes to this
> >patchset based on your suggestions for no other reason other that we
> >can progress the discussion. This is a patch that fixes a bug of which
> >there are multiple syzbot reports and consumers of the API(last one
> >just reported from the MTCP people). There's some sense of urgency to
> >apply this patch before the original goes into net. More importantly:
> >This patch fixes the issue and follows the same common check which was
> >already being done in the committed patchset to check if the qdisc
> >supports the block set/get operations.
> >
> >There are about 3 ways to do this check, you objected to the original,
> >we picked something that works fine,  and now you are picking a
> >different way with tcf_block. I dont see how tcf_block check would
> >help or solve this problem at all given this is a qdisc issue not a
> >class issue. What am I missing?
>
> Perhaps I got something wrong, but I thought that the issue is
> cl_ops->tcf_block being null for some qdiscs, isn't it?
>

We attach these ports/netdevs only on capable qdiscs i.e ones that
have  in/egress_block_set/get() - which happen to be ingress and
clsact only.
The problem was we were blindly assuming that presence of
cl->tcf_block() implies presence of in/egress_block_set/get(). The
earlier patches surrounded this code with attribute checks and so it
worked there.

BTW: Do you have an example of a test case where we can test the class
grafting (eg using htb with tcf_block)? It doesnt have any impact on
this patcheset here but we want to add it as a regression checker on
tdc in the future if someone makes a change.

cheers,
jamal

> >
> >cheers,
> >jamal
> >
> >> >
> >> >Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking i=
nfra")
> >> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >> >Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> >Reported-by: Ido Schimmel <idosch@nvidia.com>
> >> >Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
> >> >Tested-by: Ido Schimmel <idosch@nvidia.com>
> >> >Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspot=
mail.com
> >> >Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@goog=
le.com/
> >> >Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspot=
mail.com
> >> >Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@goog=
le.com/
> >> >Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspot=
mail.com
> >> >Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@goog=
le.com/
> >> >---
> >> >v1 -> v2:
> >> >
> >> >- Remove newline between fixes tag and Signed-off-by tag
> >> >- Add Ido's Reported-by and Tested-by tags
> >> >- Add syzbot's Reported-and-tested-by tags
> >> >
> >> > net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
> >> > 1 file changed, 20 insertions(+), 14 deletions(-)
> >> >
> >> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> >> >index 299086bb6205..426be81276f1 100644
> >> >--- a/net/sched/sch_api.c
> >> >+++ b/net/sched/sch_api.c
> >> >@@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Qdisc *=
sch, struct net_device *dev,
> >> >       struct tcf_block *block;
> >> >       int err;
> >> >
> >>
> >> Why don't you just check cl_ops->tcf_block ?
> >> In fact, there could be a helper to do it for you either call the op o=
r
> >> return NULL in case it is not defined.
> >>
> >>
> >> >-      block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >> >-      if (block) {
> >> >-              err =3D xa_insert(&block->ports, dev->ifindex, dev, GF=
P_KERNEL);
> >> >-              if (err) {
> >> >-                      NL_SET_ERR_MSG(extack,
> >> >-                                     "ingress block dev insert faile=
d");
> >> >-                      return err;
> >> >+      if (sch->ops->ingress_block_get) {
> >> >+              block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NUL=
L);
> >> >+              if (block) {
> >> >+                      err =3D xa_insert(&block->ports, dev->ifindex,=
 dev,
> >> >+                                      GFP_KERNEL);
> >> >+                      if (err) {
> >> >+                              NL_SET_ERR_MSG(extack,
> >> >+                                             "ingress block dev inse=
rt failed");
> >> >+                              return err;
> >> >+                      }
> >> >               }
> >> >       }
> >> >
> >> >-      block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> >> >-      if (block) {
> >> >-              err =3D xa_insert(&block->ports, dev->ifindex, dev, GF=
P_KERNEL);
> >> >-              if (err) {
> >> >-                      NL_SET_ERR_MSG(extack,
> >> >-                                     "Egress block dev insert failed=
");
> >> >-                      goto err_out;
> >> >+      if (sch->ops->egress_block_get) {
> >> >+              block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL=
);
> >> >+              if (block) {
> >> >+                      err =3D xa_insert(&block->ports, dev->ifindex,=
 dev,
> >> >+                                      GFP_KERNEL);
> >> >+                      if (err) {
> >> >+                              NL_SET_ERR_MSG(extack,
> >> >+                                             "Egress block dev inser=
t failed");
> >> >+                              goto err_out;
> >> >+                      }
> >> >               }
> >> >       }
> >> >
> >> >--
> >> >2.25.1
> >> >

