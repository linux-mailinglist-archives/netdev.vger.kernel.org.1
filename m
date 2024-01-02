Return-Path: <netdev+bounces-60956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BD2821FED
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 18:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1EC283C1E
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297B14F98;
	Tue,  2 Jan 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1b+xOHcS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590711548D
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-35ffb15244dso60379625ab.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 09:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704215171; x=1704819971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOMGYWhKyJxWgBs07axr/N8DJNLimdynHRjwSFQxzN0=;
        b=1b+xOHcSg504eVOrjruk50Vgu1h4fyuD016YW5vtrBtU8yhvSeONlttQYZMqv3UsP2
         pyWM/nOOXng1jlxXGjYW1NBSC/otN5QECBtwBFiGHeSP7tKqmibMIDRiEPShEbIrC35j
         fqDuN8w7rBUG8ZuvnJVoKeCF7exGnz76PGnue9j39lfW2Hiy896pBrTEjIr8vkWt6Erp
         BdTOzeIP5QBuExsT36iIrxVu4W06Ih+6cw0LPeyV0d/814Y8cGbPeNfy+l0JphX2IVwT
         zv1y8xABgKd09kgthaudYU1KrpOiwJL9/IbpJoWzel5WR79yTyh1K/my1vbf9b05qzeJ
         3Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704215171; x=1704819971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOMGYWhKyJxWgBs07axr/N8DJNLimdynHRjwSFQxzN0=;
        b=cVThpjHM5E3WKlm/1O1JeNYM8ZcVoNjRLub7xtDvlLN5hjqquD4qA/cHnZgUI4K4Ub
         BONJDE8xlvZWbIXUSNHSkSKvmL7PpxTdAQRhgGotV2bn7OCEc728oa92Kb8BOAU5QN0S
         8zSvX7lYB3vwdUUG739/T3V3Vg6jFjRuC3ZtNQtFN59o7BtFQIgHDoaZhfswbouYOC5C
         m0hQGRCB2o/8aTzAf//t3OjOgac8+p3sOx2R+mST1H6wCC5E+C/j8d6rKvAb43Rzhci8
         TFMlJFb2L5kckkQZI0mgo7jdqKgix5r6/80Byb7asq3vP6/EObnM+B1+CKc7SpaVPzLK
         /jrA==
X-Gm-Message-State: AOJu0YxUxCypz0q9OwFkYEl+V9A2Oiu0X2RvtuNXBiG2qAb+5bGgmWbU
	6cbyev+l9rrHsVhxb9m4RML15oDBYPbE7mCbBUn5xTXSaBqE
X-Google-Smtp-Source: AGHT+IEpOQf30/n7e0+nGMKIRyliNycm1ntPEIY3D6hnOXNwfoXzpAZv1ZF0Wzl4atC6QdcHJe5vZEs3pQSugUu+E24=
X-Received: by 2002:a05:6e02:1baf:b0:35f:f11a:4655 with SMTP id
 n15-20020a056e021baf00b0035ff11a4655mr28061482ili.71.1704215171502; Tue, 02
 Jan 2024 09:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231172320.245375-1-victor@mojatatu.com> <ZZPekLXICu2AUxlX@nanopsycho>
 <CAM0EoMkKmF3mhnHLt6gE2bmpuRGV7=OpzrMrOwtk3TJcDFW2JA@mail.gmail.com>
 <ZZQd470J2Q4UEMHv@nanopsycho> <CAM0EoMkUQzxtiaB9r=Tz5Wc3KfEDCfyy5ENSeb8M+iK9fs_HVQ@mail.gmail.com>
 <ZZQxmg3QOxzXcrW0@nanopsycho>
In-Reply-To: <ZZQxmg3QOxzXcrW0@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 2 Jan 2024 12:06:00 -0500
Message-ID: <CAM0EoMkAx0bWO7NirsoaKHEHso_GjYL1Kedxsbgfr4cstbwmxw@mail.gmail.com>
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

On Tue, Jan 2, 2024 at 10:54=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Jan 02, 2024 at 03:52:01PM CET, jhs@mojatatu.com wrote:
> >On Tue, Jan 2, 2024 at 9:29=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Tue, Jan 02, 2024 at 03:06:28PM CET, jhs@mojatatu.com wrote:
> >> >On Tue, Jan 2, 2024 at 4:59=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> =
wrote:
> >> >>
> >> >> The patch subject should briefly describe the nature of the change.=
 Not
> >> >> what "we" should or should not do.
> >> >>
> >> >>
> >> >> Sun, Dec 31, 2023 at 06:23:20PM CET, victor@mojatatu.com wrote:
> >> >> >We should only add qdiscs to the blocks ports' xarray in ingress t=
hat
> >> >> >support ingress_block_set/get or in egress that support
> >> >> >egress_block_set/get.
> >> >>
> >> >> Tell the codebase what to do, be imperative. Please read again:
> >> >> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.htm=
l#describe-your-changes
> >> >>
> >> >
> >> >We need another rule in the doc on nit-picking which states that we
> >> >need to make progress at some point. We made many changes to this
> >> >patchset based on your suggestions for no other reason other that we
> >> >can progress the discussion. This is a patch that fixes a bug of whic=
h
> >> >there are multiple syzbot reports and consumers of the API(last one
> >> >just reported from the MTCP people). There's some sense of urgency to
> >> >apply this patch before the original goes into net. More importantly:
> >> >This patch fixes the issue and follows the same common check which wa=
s
> >> >already being done in the committed patchset to check if the qdisc
> >> >supports the block set/get operations.
> >> >
> >> >There are about 3 ways to do this check, you objected to the original=
,
> >> >we picked something that works fine,  and now you are picking a
> >> >different way with tcf_block. I dont see how tcf_block check would
> >> >help or solve this problem at all given this is a qdisc issue not a
> >> >class issue. What am I missing?
> >>
> >> Perhaps I got something wrong, but I thought that the issue is
> >> cl_ops->tcf_block being null for some qdiscs, isn't it?
> >>
> >
> >We attach these ports/netdevs only on capable qdiscs i.e ones that
> >have  in/egress_block_set/get() - which happen to be ingress and
> >clsact only.
> >The problem was we were blindly assuming that presence of
> >cl->tcf_block() implies presence of in/egress_block_set/get(). The
> >earlier patches surrounded this code with attribute checks and so it
> >worked there.
>
> Syskaller report says:
>
> KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
> CPU: 1 PID: 5061 Comm: syz-executor323 Not tainted 6.7.0-rc6-syzkaller-01=
658-gc2b2ee36250d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/17/2023
> RIP: 0010:qdisc_block_add_dev net/sched/sch_api.c:1190 [inline]
>
> Line 1190 is:
> block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>
> So the cl_ops->tcf_block =3D=3D NULL
>
> Why can't you just check it? Why do you want to check in/egress_block_set=
/get()
> instead? I don't follow :/
>

Does it make sense to add to the port xarray just because we have
cl_ops->tcf_block()? There are many qdiscs which have
cl_ops->tcf_block() (example htb) but cant be used in the block add
syntax (see question further below on tdc test).
--
$sudo tc qdisc add dev lo egress_block 21 handle 1: root htb
Error: Egress block sharing is not supported.
---

Did you look at the other syzbot reports?

> Btw, the checks in __qdisc_destroy() do also look wrong.

Now I am not following, please explain. The same code structure check
is used in fill_qdisc
(https://elixir.bootlin.com/linux/v6.7-rc8/source/net/sched/sch_api.c#L940)
for example to pull the block info, is that wrong?

> >
> >BTW: Do you have an example of a test case where we can test the class
> >grafting (eg using htb with tcf_block)? It doesnt have any impact on
> >this patcheset here but we want to add it as a regression checker on
> >tdc in the future if someone makes a change.

An answer to this will help.

cheers,
jamal


> >cheers,
> >jamal
> >
> >> >
> >> >cheers,
> >> >jamal
> >> >
> >> >> >
> >> >> >Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev trackin=
g infra")
> >> >> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >> >> >Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >> >> >Reported-by: Ido Schimmel <idosch@nvidia.com>
> >> >> >Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
> >> >> >Tested-by: Ido Schimmel <idosch@nvidia.com>
> >> >> >Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.apps=
potmail.com
> >> >> >Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@g=
oogle.com/
> >> >> >Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.apps=
potmail.com
> >> >> >Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@g=
oogle.com/
> >> >> >Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.apps=
potmail.com
> >> >> >Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@g=
oogle.com/
> >> >> >---
> >> >> >v1 -> v2:
> >> >> >
> >> >> >- Remove newline between fixes tag and Signed-off-by tag
> >> >> >- Add Ido's Reported-by and Tested-by tags
> >> >> >- Add syzbot's Reported-and-tested-by tags
> >> >> >
> >> >> > net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
> >> >> > 1 file changed, 20 insertions(+), 14 deletions(-)
> >> >> >
> >> >> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> >> >> >index 299086bb6205..426be81276f1 100644
> >> >> >--- a/net/sched/sch_api.c
> >> >> >+++ b/net/sched/sch_api.c
> >> >> >@@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Qdis=
c *sch, struct net_device *dev,
> >> >> >       struct tcf_block *block;
> >> >> >       int err;
> >> >> >
> >> >>
> >> >> Why don't you just check cl_ops->tcf_block ?
> >> >> In fact, there could be a helper to do it for you either call the o=
p or
> >> >> return NULL in case it is not defined.
> >> >>
> >> >>
> >> >> >-      block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> >> >> >-      if (block) {
> >> >> >-              err =3D xa_insert(&block->ports, dev->ifindex, dev,=
 GFP_KERNEL);
> >> >> >-              if (err) {
> >> >> >-                      NL_SET_ERR_MSG(extack,
> >> >> >-                                     "ingress block dev insert fa=
iled");
> >> >> >-                      return err;
> >> >> >+      if (sch->ops->ingress_block_get) {
> >> >> >+              block =3D cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, =
NULL);
> >> >> >+              if (block) {
> >> >> >+                      err =3D xa_insert(&block->ports, dev->ifind=
ex, dev,
> >> >> >+                                      GFP_KERNEL);
> >> >> >+                      if (err) {
> >> >> >+                              NL_SET_ERR_MSG(extack,
> >> >> >+                                             "ingress block dev i=
nsert failed");
> >> >> >+                              return err;
> >> >> >+                      }
> >> >> >               }
> >> >> >       }
> >> >> >
> >> >> >-      block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> >> >> >-      if (block) {
> >> >> >-              err =3D xa_insert(&block->ports, dev->ifindex, dev,=
 GFP_KERNEL);
> >> >> >-              if (err) {
> >> >> >-                      NL_SET_ERR_MSG(extack,
> >> >> >-                                     "Egress block dev insert fai=
led");
> >> >> >-                      goto err_out;
> >> >> >+      if (sch->ops->egress_block_get) {
> >> >> >+              block =3D cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, N=
ULL);
> >> >> >+              if (block) {
> >> >> >+                      err =3D xa_insert(&block->ports, dev->ifind=
ex, dev,
> >> >> >+                                      GFP_KERNEL);
> >> >> >+                      if (err) {
> >> >> >+                              NL_SET_ERR_MSG(extack,
> >> >> >+                                             "Egress block dev in=
sert failed");
> >> >> >+                              goto err_out;
> >> >> >+                      }
> >> >> >               }
> >> >> >       }
> >> >> >
> >> >> >--
> >> >> >2.25.1
> >> >> >

