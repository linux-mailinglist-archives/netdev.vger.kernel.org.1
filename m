Return-Path: <netdev+bounces-61202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E02C822DE5
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253271C21DB8
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 13:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD681945E;
	Wed,  3 Jan 2024 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="S6zvPSqt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB21944F
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336979a566aso8703733f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 04:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704286754; x=1704891554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7iwp8HPUKvyx2NxEfz066slOT2j6Pp73iIMTkm3auA0=;
        b=S6zvPSqt02w+uac2Nrj8kzJtXW4BkbEcKHixB+Xz7amgORMGSKVcd95Ep3c7869r+P
         sAsObgr3Sm3ckxZaDWaps7vsVxAqN+nG7oXofc76GHEifrVBLUP/RzB4faQeEX0FxtfH
         KDz3onC5b9fAc+4Cgp7TivgDqnfMPJyu26IcS2HIRBEI5ZUy+YiRS81poMuEDIDhLZ6V
         CZQSJyhHdsHaYrJ4c6LtxSlxDdTOrxYqnbGIUVmH7WTzdP+PrG4z0VnpkCrugLUrzOue
         V+FCs06+G/ucF6XxYAuDhDK4G8GMfu1hODlQaIMZxUW4QJOP3em0R8vhunXRKrvhMR9k
         CL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704286754; x=1704891554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iwp8HPUKvyx2NxEfz066slOT2j6Pp73iIMTkm3auA0=;
        b=ExsdzoL1c33Q3uzv5UvZRRm+WSlMSoqT0q20HybzNAxauQj8IfR79x8Jp1Tv+JUKlu
         ccyd5NrASqC9wecwkSiHc7F5fvdIpDsGUpYgabbppNUBNbDps7RCd7Qj2EPkj96lKufP
         SyTID6xV5J7Y+DEeO1Jz/LWa013jHe15YP8QDr1csN7DnIbUZ4TuQOt1E5SfV08QPoUZ
         uQD/14iaQOETNXMARSwQa/wORaCSmkSYbD77hIG+peFgWHbry/Iefe3TzfdKJY3Nt/og
         AauzEMFk6XEbf+1e76aGtnvptNPiZojhGby025ibJl6q/n6y0+h9yAAYZxc5t/fzzCmn
         yg6A==
X-Gm-Message-State: AOJu0Yz5A0vClw9xqXoORoFvjVlhH9B3EnbjyI97xGIt5AFzTVd6lb6i
	umGnIk8TsvFGMSm4ntoEhtur1nhBPx65lJPDVe38oOx9GfuEBQ==
X-Google-Smtp-Source: AGHT+IHqza+2ASqJ8DoNcuymLVjeq3dI3mAUkx2l6PHcVW2sy3LidCvnvOlAYfkpC/iKEfEclBWD9Q==
X-Received: by 2002:a05:6000:1a4e:b0:337:2aa3:ac83 with SMTP id t14-20020a0560001a4e00b003372aa3ac83mr3621046wry.61.1704286754481;
        Wed, 03 Jan 2024 04:59:14 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id s5-20020adfe005000000b0033743c2d17dsm5547718wrh.28.2024.01.03.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:59:13 -0800 (PST)
Date: Wed, 3 Jan 2024 13:59:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiyou.wangcong@gmail.com, idosch@idosch.org, mleitner@redhat.com,
	vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com,
	netdev@vger.kernel.org, kernel@mojatatu.com,
	syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com,
	syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com,
	syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v2 1/1] net/sched: We should only add
 appropriate qdiscs blocks to ports' xarray
Message-ID: <ZZVaIOay_IqSDabg@nanopsycho>
References: <20231231172320.245375-1-victor@mojatatu.com>
 <ZZPekLXICu2AUxlX@nanopsycho>
 <CAM0EoMkKmF3mhnHLt6gE2bmpuRGV7=OpzrMrOwtk3TJcDFW2JA@mail.gmail.com>
 <ZZQd470J2Q4UEMHv@nanopsycho>
 <CAM0EoMkUQzxtiaB9r=Tz5Wc3KfEDCfyy5ENSeb8M+iK9fs_HVQ@mail.gmail.com>
 <ZZQxmg3QOxzXcrW0@nanopsycho>
 <CAM0EoMkAx0bWO7NirsoaKHEHso_GjYL1Kedxsbgfr4cstbwmxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkAx0bWO7NirsoaKHEHso_GjYL1Kedxsbgfr4cstbwmxw@mail.gmail.com>

Tue, Jan 02, 2024 at 06:06:00PM CET, jhs@mojatatu.com wrote:
>On Tue, Jan 2, 2024 at 10:54 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Jan 02, 2024 at 03:52:01PM CET, jhs@mojatatu.com wrote:
>> >On Tue, Jan 2, 2024 at 9:29 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Tue, Jan 02, 2024 at 03:06:28PM CET, jhs@mojatatu.com wrote:
>> >> >On Tue, Jan 2, 2024 at 4:59 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >>
>> >> >> The patch subject should briefly describe the nature of the change. Not
>> >> >> what "we" should or should not do.
>> >> >>
>> >> >>
>> >> >> Sun, Dec 31, 2023 at 06:23:20PM CET, victor@mojatatu.com wrote:
>> >> >> >We should only add qdiscs to the blocks ports' xarray in ingress that
>> >> >> >support ingress_block_set/get or in egress that support
>> >> >> >egress_block_set/get.
>> >> >>
>> >> >> Tell the codebase what to do, be imperative. Please read again:
>> >> >> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes
>> >> >>
>> >> >
>> >> >We need another rule in the doc on nit-picking which states that we
>> >> >need to make progress at some point. We made many changes to this
>> >> >patchset based on your suggestions for no other reason other that we
>> >> >can progress the discussion. This is a patch that fixes a bug of which
>> >> >there are multiple syzbot reports and consumers of the API(last one
>> >> >just reported from the MTCP people). There's some sense of urgency to
>> >> >apply this patch before the original goes into net. More importantly:
>> >> >This patch fixes the issue and follows the same common check which was
>> >> >already being done in the committed patchset to check if the qdisc
>> >> >supports the block set/get operations.
>> >> >
>> >> >There are about 3 ways to do this check, you objected to the original,
>> >> >we picked something that works fine,  and now you are picking a
>> >> >different way with tcf_block. I dont see how tcf_block check would
>> >> >help or solve this problem at all given this is a qdisc issue not a
>> >> >class issue. What am I missing?
>> >>
>> >> Perhaps I got something wrong, but I thought that the issue is
>> >> cl_ops->tcf_block being null for some qdiscs, isn't it?
>> >>
>> >
>> >We attach these ports/netdevs only on capable qdiscs i.e ones that
>> >have  in/egress_block_set/get() - which happen to be ingress and
>> >clsact only.
>> >The problem was we were blindly assuming that presence of
>> >cl->tcf_block() implies presence of in/egress_block_set/get(). The
>> >earlier patches surrounded this code with attribute checks and so it
>> >worked there.
>>
>> Syskaller report says:
>>
>> KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
>> CPU: 1 PID: 5061 Comm: syz-executor323 Not tainted 6.7.0-rc6-syzkaller-01658-gc2b2ee36250d #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>> RIP: 0010:qdisc_block_add_dev net/sched/sch_api.c:1190 [inline]
>>
>> Line 1190 is:
>> block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>>
>> So the cl_ops->tcf_block == NULL
>>
>> Why can't you just check it? Why do you want to check in/egress_block_set/get()
>> instead? I don't follow :/
>>
>
>Does it make sense to add to the port xarray just because we have
>cl_ops->tcf_block()? There are many qdiscs which have
>cl_ops->tcf_block() (example htb) but cant be used in the block add
>syntax (see question further below on tdc test).

The whole block usage in qdiscs other than ingress and clsact seems odd
to me to be honest. What's the reason for that?.


>--
>$sudo tc qdisc add dev lo egress_block 21 handle 1: root htb
>Error: Egress block sharing is not supported.
>---
>
>Did you look at the other syzbot reports?

Yeah. The block usage in other qdiscs looks very odd.


>
>> Btw, the checks in __qdisc_destroy() do also look wrong.
>
>Now I am not following, please explain. The same code structure check
>is used in fill_qdisc
>(https://elixir.bootlin.com/linux/v6.7-rc8/source/net/sched/sch_api.c#L940)
>for example to pull the block info, is that wrong?

There, you don't call tcf_block() at all, so how is that relevant?



>
>> >
>> >BTW: Do you have an example of a test case where we can test the class
>> >grafting (eg using htb with tcf_block)? It doesnt have any impact on
>> >this patcheset here but we want to add it as a regression checker on
>> >tdc in the future if someone makes a change.
>
>An answer to this will help.

Answer is "no".

>
>cheers,
>jamal
>
>
>> >cheers,
>> >jamal
>> >
>> >> >
>> >> >cheers,
>> >> >jamal
>> >> >
>> >> >> >
>> >> >> >Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
>> >> >> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> >> >> >Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >> >> >Reported-by: Ido Schimmel <idosch@nvidia.com>
>> >> >> >Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
>> >> >> >Tested-by: Ido Schimmel <idosch@nvidia.com>
>> >> >> >Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
>> >> >> >Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
>> >> >> >Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
>> >> >> >Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
>> >> >> >Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
>> >> >> >Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
>> >> >> >---
>> >> >> >v1 -> v2:
>> >> >> >
>> >> >> >- Remove newline between fixes tag and Signed-off-by tag
>> >> >> >- Add Ido's Reported-by and Tested-by tags
>> >> >> >- Add syzbot's Reported-and-tested-by tags
>> >> >> >
>> >> >> > net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
>> >> >> > 1 file changed, 20 insertions(+), 14 deletions(-)
>> >> >> >
>> >> >> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>> >> >> >index 299086bb6205..426be81276f1 100644
>> >> >> >--- a/net/sched/sch_api.c
>> >> >> >+++ b/net/sched/sch_api.c
>> >> >> >@@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
>> >> >> >       struct tcf_block *block;
>> >> >> >       int err;
>> >> >> >
>> >> >>
>> >> >> Why don't you just check cl_ops->tcf_block ?
>> >> >> In fact, there could be a helper to do it for you either call the op or
>> >> >> return NULL in case it is not defined.
>> >> >>
>> >> >>
>> >> >> >-      block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >> >> >-      if (block) {
>> >> >> >-              err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >> >> >-              if (err) {
>> >> >> >-                      NL_SET_ERR_MSG(extack,
>> >> >> >-                                     "ingress block dev insert failed");
>> >> >> >-                      return err;
>> >> >> >+      if (sch->ops->ingress_block_get) {
>> >> >> >+              block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >> >> >+              if (block) {
>> >> >> >+                      err = xa_insert(&block->ports, dev->ifindex, dev,
>> >> >> >+                                      GFP_KERNEL);
>> >> >> >+                      if (err) {
>> >> >> >+                              NL_SET_ERR_MSG(extack,
>> >> >> >+                                             "ingress block dev insert failed");
>> >> >> >+                              return err;
>> >> >> >+                      }
>> >> >> >               }
>> >> >> >       }
>> >> >> >
>> >> >> >-      block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >> >> >-      if (block) {
>> >> >> >-              err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >> >> >-              if (err) {
>> >> >> >-                      NL_SET_ERR_MSG(extack,
>> >> >> >-                                     "Egress block dev insert failed");
>> >> >> >-                      goto err_out;
>> >> >> >+      if (sch->ops->egress_block_get) {
>> >> >> >+              block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >> >> >+              if (block) {
>> >> >> >+                      err = xa_insert(&block->ports, dev->ifindex, dev,
>> >> >> >+                                      GFP_KERNEL);
>> >> >> >+                      if (err) {
>> >> >> >+                              NL_SET_ERR_MSG(extack,
>> >> >> >+                                             "Egress block dev insert failed");
>> >> >> >+                              goto err_out;
>> >> >> >+                      }
>> >> >> >               }
>> >> >> >       }
>> >> >> >
>> >> >> >--
>> >> >> >2.25.1
>> >> >> >

