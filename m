Return-Path: <netdev+bounces-60911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B4821D5A
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3B41C22307
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3CD10A0D;
	Tue,  2 Jan 2024 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="XeOO+VpG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698861119C
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f254d1a6daso10749837b3.2
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 06:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704204400; x=1704809200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCkjXSoVrKI6ZQJpT9omgttAU1Kx0QHLeAUHNctT4Ec=;
        b=XeOO+VpGuaMtEguGR+8z4MtY0CH30a7IiAmc0ND5uPiog/IS92RuunjvjD2m7NOhGB
         20jS0Mz+bG1ybr/55q4kTOs3ZtOznUjlR8QC0enhKkPxmMQgqQKu3Dh+PhK/CjPw7e+t
         G+lVSIUPwYiVJvjk7dXvkS/cCO/NYPlS5gI69j7YgMLEc57ccj8JhtrU3nEeMqyQ+HzQ
         InwV7rEiz+628XgOfKuOXrHslPM/FSZZnVFi4WbJQETqCfDqYrgkTtfgfy1N9ejeZNeR
         uRlJe8Tsx1yAqFHULhptj7G5b+TiKXejDXDMHiPIFT0ZVCkeKHoA5gWH1hZAXu09qn1j
         tRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204400; x=1704809200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCkjXSoVrKI6ZQJpT9omgttAU1Kx0QHLeAUHNctT4Ec=;
        b=Vzl5MZUnbhPHejcZ6kxy5WpMfByl4Ktha7dWCCmBuBbxoANnwMtWjKM07mly1l9Rdo
         P7TzVv8NmAbloB5+cSNSekcIMtF1FmWNkETIs/GSdz1qu4echolCI9yYRzxa3VM3m4rz
         H8Z0piOon+Ek/4agPxWsMRyo3WTLVHcrOd194LKPlCArDewC5WAXUqx53z+Q28/xVTO5
         GavYUUJ9WGHFs+rG/6wnKvUQRvQb2ZuMmhw6DyEH54D6rbk09stS7GE2BEARDnEtdxto
         wK85hg/jQJx0IhfNVq8j37fBmf5QdsxfjyoAQ0LZ2QXvd+2QA/7uVZrbPAqMhWd2W9TW
         wkfw==
X-Gm-Message-State: AOJu0Yz/oIY+drc3RYjHk6uBWSRXJMxmN1GwncXCiXAUgJmaQEKqI0ut
	qG0R7PDlQKf5bm1OWXfwTyhvpbqUL9lagsrqsbevvo9jPGuL
X-Google-Smtp-Source: AGHT+IEiRWqbsQdhRf+pMtR4KnSg6o1TonxX6x6o3kVsmB6cd4/RyojanGzGg8gYSkF+s8GnmHYcki3J7Bhc/Rcyj7o=
X-Received: by 2002:a05:690c:2b06:b0:5ef:85cf:9dfa with SMTP id
 em6-20020a05690c2b0600b005ef85cf9dfamr3064405ywb.70.1704204399326; Tue, 02
 Jan 2024 06:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231172320.245375-1-victor@mojatatu.com> <ZZPekLXICu2AUxlX@nanopsycho>
In-Reply-To: <ZZPekLXICu2AUxlX@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 2 Jan 2024 09:06:28 -0500
Message-ID: <CAM0EoMkKmF3mhnHLt6gE2bmpuRGV7=OpzrMrOwtk3TJcDFW2JA@mail.gmail.com>
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

On Tue, Jan 2, 2024 at 4:59=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> The patch subject should briefly describe the nature of the change. Not
> what "we" should or should not do.
>
>
> Sun, Dec 31, 2023 at 06:23:20PM CET, victor@mojatatu.com wrote:
> >We should only add qdiscs to the blocks ports' xarray in ingress that
> >support ingress_block_set/get or in egress that support
> >egress_block_set/get.
>
> Tell the codebase what to do, be imperative. Please read again:
> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#desc=
ribe-your-changes
>

We need another rule in the doc on nit-picking which states that we
need to make progress at some point. We made many changes to this
patchset based on your suggestions for no other reason other that we
can progress the discussion. This is a patch that fixes a bug of which
there are multiple syzbot reports and consumers of the API(last one
just reported from the MTCP people). There's some sense of urgency to
apply this patch before the original goes into net. More importantly:
This patch fixes the issue and follows the same common check which was
already being done in the committed patchset to check if the qdisc
supports the block set/get operations.

There are about 3 ways to do this check, you objected to the original,
we picked something that works fine,  and now you are picking a
different way with tcf_block. I dont see how tcf_block check would
help or solve this problem at all given this is a qdisc issue not a
class issue. What am I missing?

cheers,
jamal

> >
> >Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infr=
a")
> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >Reported-by: Ido Schimmel <idosch@nvidia.com>
> >Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
> >Tested-by: Ido Schimmel <idosch@nvidia.com>
> >Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmai=
l.com
> >Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.=
com/
> >Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmai=
l.com
> >Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.=
com/
> >Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmai=
l.com
> >Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.=
com/
> >---
> >v1 -> v2:
> >
> >- Remove newline between fixes tag and Signed-off-by tag
> >- Add Ido's Reported-by and Tested-by tags
> >- Add syzbot's Reported-and-tested-by tags
> >
> > net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
> > 1 file changed, 20 insertions(+), 14 deletions(-)
> >
> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> >index 299086bb6205..426be81276f1 100644
> >--- a/net/sched/sch_api.c
> >+++ b/net/sched/sch_api.c
> >@@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Qdisc *sch=
, struct net_device *dev,
> >       struct tcf_block *block;
> >       int err;
> >
>
> Why don't you just check cl_ops->tcf_block ?
> In fact, there could be a helper to do it for you either call the op or
> return NULL in case it is not defined.
>
>
> >-      block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >-      if (block) {
> >-              err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
> >-              if (err) {
> >-                      NL_SET_ERR_MSG(extack,
> >-                                     "ingress block dev insert failed")=
;
> >-                      return err;
> >+      if (sch->ops->ingress_block_get) {
> >+              block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >+              if (block) {
> >+                      err =3D xa_insert(&block->ports, dev->ifindex, de=
v,
> >+                                      GFP_KERNEL);
> >+                      if (err) {
> >+                              NL_SET_ERR_MSG(extack,
> >+                                             "ingress block dev insert =
failed");
> >+                              return err;
> >+                      }
> >               }
> >       }
> >
> >-      block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> >-      if (block) {
> >-              err =3D xa_insert(&block->ports, dev->ifindex, dev, GFP_K=
ERNEL);
> >-              if (err) {
> >-                      NL_SET_ERR_MSG(extack,
> >-                                     "Egress block dev insert failed");
> >-                      goto err_out;
> >+      if (sch->ops->egress_block_get) {
> >+              block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> >+              if (block) {
> >+                      err =3D xa_insert(&block->ports, dev->ifindex, de=
v,
> >+                                      GFP_KERNEL);
> >+                      if (err) {
> >+                              NL_SET_ERR_MSG(extack,
> >+                                             "Egress block dev insert f=
ailed");
> >+                              goto err_out;
> >+                      }
> >               }
> >       }
> >
> >--
> >2.25.1
> >

