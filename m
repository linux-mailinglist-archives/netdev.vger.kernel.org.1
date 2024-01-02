Return-Path: <netdev+bounces-60940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD99F821F07
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7351C22362
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB35414A92;
	Tue,  2 Jan 2024 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O6bujbQj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF77C14F69
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso2972111a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 07:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704210845; x=1704815645; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V9qniKWaKPJf+lzEMdhqgVo3btu9BI0ygRsmsQ1RrMI=;
        b=O6bujbQjZ+azCrEls2T9RA/Zxh4zcAXstyQgEjP9L3MoSVfdCZzZusnnqfoVmUHeHo
         iF/MBu328YpQk/HBZ/owe6cdXZovf8/HX4FE/FkJeoaCDg03AX2//LXq17bibrAD7Cfp
         2gC8LCkngUGILqg+o/qtv97IDkaitjdBkMFhlOM/2sIPFHhj4ybJ1hMfz3/SVSPoXAU5
         pA5C4Np5LNyRXlZF23J5z2xQJal1N+czUOwlXseNMyse11Eg5nHpCB/d4qZOpsoOGkfI
         Re4jJoCkFUCRE+tQ+TZpzMs92dxi3dORMYXeVANN2zNcenF8HfmEbKAo3cgZEi5pIj1S
         TQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704210845; x=1704815645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9qniKWaKPJf+lzEMdhqgVo3btu9BI0ygRsmsQ1RrMI=;
        b=lkCOiKd+GjxJLI5K9DL0mQ77iQ5KCWXPQhOtGggHpwd5jOHBBIB1Xw8BiC0sMC6c7r
         PMR59Qbd5/5NEIGEKOpMh9+JOxIbPhfBH/q20egCFOrYR0tiefQGV7CCoJoJm7bGyQeG
         b3DQpt+qU5Zz4vQz6dRCxOIlATecqkcsvLHNo6N18dhw/krETbiKB5JmWEVCHzQXuHF7
         FdOKIVNnYjZOeFsqfQEuqm5xcHAtNBP9jSbSpF5pMYAZK4cBeEYkDPVJiU5+JRNVKJXI
         7TAa90tRUJK29S8VtZ/6TPHv5gGEPsYqZkkExnMsIag5yCMDY8rea/h0RTR9VwnRxFzk
         5HJA==
X-Gm-Message-State: AOJu0Yy6zUHxHLd0AxOdKsHcJhii6xBVG/ukKcwdzsKBTQPtWuWTBSIU
	T86fdSntz44EgDbPS0T/npgthz5niefa2w==
X-Google-Smtp-Source: AGHT+IFHUNqjyxj/mgxtxnM8gRn492FkFYpOtZDoshUS95Ju4TbK7QAtPIbMUytpPzycTwJQ8BrWAA==
X-Received: by 2002:a50:c010:0:b0:554:9bef:a1e4 with SMTP id r16-20020a50c010000000b005549befa1e4mr6726001edb.33.1704210844651;
        Tue, 02 Jan 2024 07:54:04 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m9-20020aa7c2c9000000b00552666f4745sm16011611edp.22.2024.01.02.07.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:54:04 -0800 (PST)
Date: Tue, 2 Jan 2024 16:54:02 +0100
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
Message-ID: <ZZQxmg3QOxzXcrW0@nanopsycho>
References: <20231231172320.245375-1-victor@mojatatu.com>
 <ZZPekLXICu2AUxlX@nanopsycho>
 <CAM0EoMkKmF3mhnHLt6gE2bmpuRGV7=OpzrMrOwtk3TJcDFW2JA@mail.gmail.com>
 <ZZQd470J2Q4UEMHv@nanopsycho>
 <CAM0EoMkUQzxtiaB9r=Tz5Wc3KfEDCfyy5ENSeb8M+iK9fs_HVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkUQzxtiaB9r=Tz5Wc3KfEDCfyy5ENSeb8M+iK9fs_HVQ@mail.gmail.com>

Tue, Jan 02, 2024 at 03:52:01PM CET, jhs@mojatatu.com wrote:
>On Tue, Jan 2, 2024 at 9:29 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Jan 02, 2024 at 03:06:28PM CET, jhs@mojatatu.com wrote:
>> >On Tue, Jan 2, 2024 at 4:59 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> The patch subject should briefly describe the nature of the change. Not
>> >> what "we" should or should not do.
>> >>
>> >>
>> >> Sun, Dec 31, 2023 at 06:23:20PM CET, victor@mojatatu.com wrote:
>> >> >We should only add qdiscs to the blocks ports' xarray in ingress that
>> >> >support ingress_block_set/get or in egress that support
>> >> >egress_block_set/get.
>> >>
>> >> Tell the codebase what to do, be imperative. Please read again:
>> >> https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes
>> >>
>> >
>> >We need another rule in the doc on nit-picking which states that we
>> >need to make progress at some point. We made many changes to this
>> >patchset based on your suggestions for no other reason other that we
>> >can progress the discussion. This is a patch that fixes a bug of which
>> >there are multiple syzbot reports and consumers of the API(last one
>> >just reported from the MTCP people). There's some sense of urgency to
>> >apply this patch before the original goes into net. More importantly:
>> >This patch fixes the issue and follows the same common check which was
>> >already being done in the committed patchset to check if the qdisc
>> >supports the block set/get operations.
>> >
>> >There are about 3 ways to do this check, you objected to the original,
>> >we picked something that works fine,  and now you are picking a
>> >different way with tcf_block. I dont see how tcf_block check would
>> >help or solve this problem at all given this is a qdisc issue not a
>> >class issue. What am I missing?
>>
>> Perhaps I got something wrong, but I thought that the issue is
>> cl_ops->tcf_block being null for some qdiscs, isn't it?
>>
>
>We attach these ports/netdevs only on capable qdiscs i.e ones that
>have  in/egress_block_set/get() - which happen to be ingress and
>clsact only.
>The problem was we were blindly assuming that presence of
>cl->tcf_block() implies presence of in/egress_block_set/get(). The
>earlier patches surrounded this code with attribute checks and so it
>worked there.

Syskaller report says:

KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
CPU: 1 PID: 5061 Comm: syz-executor323 Not tainted 6.7.0-rc6-syzkaller-01658-gc2b2ee36250d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:qdisc_block_add_dev net/sched/sch_api.c:1190 [inline]

Line 1190 is:
block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);

So the cl_ops->tcf_block == NULL

Why can't you just check it? Why do you want to check in/egress_block_set/get()
instead? I don't follow :/

Btw, the checks in __qdisc_destroy() do also look wrong.



>
>BTW: Do you have an example of a test case where we can test the class
>grafting (eg using htb with tcf_block)? It doesnt have any impact on
>this patcheset here but we want to add it as a regression checker on
>tdc in the future if someone makes a change.
>
>cheers,
>jamal
>
>> >
>> >cheers,
>> >jamal
>> >
>> >> >
>> >> >Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
>> >> >Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> >> >Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> >> >Reported-by: Ido Schimmel <idosch@nvidia.com>
>> >> >Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
>> >> >Tested-by: Ido Schimmel <idosch@nvidia.com>
>> >> >Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
>> >> >Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
>> >> >Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
>> >> >Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
>> >> >Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
>> >> >Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
>> >> >---
>> >> >v1 -> v2:
>> >> >
>> >> >- Remove newline between fixes tag and Signed-off-by tag
>> >> >- Add Ido's Reported-by and Tested-by tags
>> >> >- Add syzbot's Reported-and-tested-by tags
>> >> >
>> >> > net/sched/sch_api.c | 34 ++++++++++++++++++++--------------
>> >> > 1 file changed, 20 insertions(+), 14 deletions(-)
>> >> >
>> >> >diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>> >> >index 299086bb6205..426be81276f1 100644
>> >> >--- a/net/sched/sch_api.c
>> >> >+++ b/net/sched/sch_api.c
>> >> >@@ -1187,23 +1187,29 @@ static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
>> >> >       struct tcf_block *block;
>> >> >       int err;
>> >> >
>> >>
>> >> Why don't you just check cl_ops->tcf_block ?
>> >> In fact, there could be a helper to do it for you either call the op or
>> >> return NULL in case it is not defined.
>> >>
>> >>
>> >> >-      block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >> >-      if (block) {
>> >> >-              err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >> >-              if (err) {
>> >> >-                      NL_SET_ERR_MSG(extack,
>> >> >-                                     "ingress block dev insert failed");
>> >> >-                      return err;
>> >> >+      if (sch->ops->ingress_block_get) {
>> >> >+              block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>> >> >+              if (block) {
>> >> >+                      err = xa_insert(&block->ports, dev->ifindex, dev,
>> >> >+                                      GFP_KERNEL);
>> >> >+                      if (err) {
>> >> >+                              NL_SET_ERR_MSG(extack,
>> >> >+                                             "ingress block dev insert failed");
>> >> >+                              return err;
>> >> >+                      }
>> >> >               }
>> >> >       }
>> >> >
>> >> >-      block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >> >-      if (block) {
>> >> >-              err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
>> >> >-              if (err) {
>> >> >-                      NL_SET_ERR_MSG(extack,
>> >> >-                                     "Egress block dev insert failed");
>> >> >-                      goto err_out;
>> >> >+      if (sch->ops->egress_block_get) {
>> >> >+              block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
>> >> >+              if (block) {
>> >> >+                      err = xa_insert(&block->ports, dev->ifindex, dev,
>> >> >+                                      GFP_KERNEL);
>> >> >+                      if (err) {
>> >> >+                              NL_SET_ERR_MSG(extack,
>> >> >+                                             "Egress block dev insert failed");
>> >> >+                              goto err_out;
>> >> >+                      }
>> >> >               }
>> >> >       }
>> >> >
>> >> >--
>> >> >2.25.1
>> >> >

