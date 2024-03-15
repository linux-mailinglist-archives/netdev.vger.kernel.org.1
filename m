Return-Path: <netdev+bounces-80010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE05487C760
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 03:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46EE6B213AD
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 02:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85985613D;
	Fri, 15 Mar 2024 02:10:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A66FA9
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710468618; cv=none; b=oWK9WaoVQ3MR5jAbpUgDjcRNGqPc5wh25efHwmgeYPXbRrAqsidAouzY26OqbfZ5/HPzgdlGw7h/mJvNahbD9VHkqh8X8mGMyzkj3lhTyxPazK8nFPvnu3D0MQb7hjWQKrynDrSe8OCqoZ41CjyXtY0sY/W/1N/VQwi2FevScuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710468618; c=relaxed/simple;
	bh=tXn92RXtxBj+WuHnEKf9RHPkBsISgMK7zTj5lkUBcyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqpYlk5nScN1DdFAifhkExCEcev9u67km+OR9OpaV0AunyUqzHxEhPg2oWOrAOSJ85n/HGkGxhXhlgUfK05u/D5AuHl370E4EzhnDEU7G2Vff/nvjGUkmcF5Nd+jDjRabjadd6jvc+Wgabk1L4GARkoGybBT5JGiNfycXna+ISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TwnhY1RtWztQWN;
	Fri, 15 Mar 2024 10:07:57 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 6532A140123;
	Fri, 15 Mar 2024 10:10:06 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.203) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 10:10:05 +0800
From: renmingshuai <renmingshuai@huawei.com>
To: <jhs@mojatatu.com>
CC: <caowangbao@huawei.com>, <davem@davemloft.net>, <jiri@resnulli.us>,
	<liaichun@huawei.com>, <netdev@vger.kernel.org>, <renmingshuai@huawei.com>,
	<vladbu@nvidia.com>, <xiyou.wangcong@gmail.com>, <yanan@huawei.com>
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter attached to the egress
Date: Fri, 15 Mar 2024 09:56:45 +0800
Message-ID: <20240315015645.4851-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
References: <CAM0EoMmqVHGC4_YVHj=rUPj+XBS_N99rCKk1S7wCi1wJ8__Pyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100005.china.huawei.com (7.185.36.102)

>> As we all know the mirred action is used to mirroring or redirecting the
>> packet it receives. Howerver, add mirred action to a filter attached to
>> a egress qdisc might cause a deadlock. To reproduce the problem, perform
>> the following steps:
>> (1)tc qdisc add dev eth0 root handle 1: htb default 30 \n
>> (2)tc filter add dev eth2 protocol ip prio 2 flower verbose \
>>      action police rate 100mbit burst 12m conform-exceed jump 1 \
>>      / pipe mirred egress redirect dev eth2 action drop
>>
>
>I think you meant both to be the same device eth0 or eth2?

Sorry, a careless mistake. eth2 in step 2 should be eth0.
(2)tc filter add dev eth0 protocol ip prio 2 flower verbose \
     action police rate 100mbit burst 12m conform-exceed jump 1 \
     / pipe mirred egress redirect dev eth0 action drop

>> The stack is show as below:
>> [28848.883915]  _raw_spin_lock+0x1e/0x30
>> [28848.884367]  __dev_queue_xmit+0x160/0x850
>> [28848.884851]  ? 0xffffffffc031906a
>> [28848.885279]  tcf_mirred_act+0x3ab/0x596 [act_mirred]
>> [28848.885863]  tcf_action_exec.part.0+0x88/0x130
>> [28848.886401]  fl_classify+0x1ca/0x1e0 [cls_flower]
>> [28848.886970]  ? dequeue_entity+0x145/0x9e0
>> [28848.887464]  ? newidle_balance+0x23f/0x2f0
>> [28848.887973]  ? nft_lookup_eval+0x57/0x170 [nf_tables]
>> [28848.888566]  ? nft_do_chain+0xef/0x430 [nf_tables]
>> [28848.889137]  ? __flush_work.isra.0+0x35/0x80
>> [28848.889657]  ? nf_ct_get_tuple+0x1cf/0x210 [nf_conntrack]
>> [28848.890293]  ? do_select+0x637/0x870
>> [28848.890735]  tcf_classify+0x52/0xf0
>> [28848.891177]  htb_classify+0x9d/0x1c0 [sch_htb]
>> [28848.891722]  htb_enqueue+0x3a/0x1c0 [sch_htb]
>> [28848.892251]  __dev_queue_xmit+0x2d8/0x850
>> [28848.892738]  ? nf_hook_slow+0x3c/0xb0
>> [28848.893198]  ip_finish_output2+0x272/0x580
>> [28848.893692]  __ip_queue_xmit+0x193/0x420
>> [28848.894179]  __tcp_transmit_skb+0x8cc/0x970
>>
>> In this case, the process has hold the qdisc spin lock in __dev_queue_xmit
>> before the egress packets are mirred, and it will attempt to obtain the
>> spin lock again after packets are mirred, which cause a deadlock.
>>
>> Fix the issue by forbidding assigning mirred action to a filter attached
>> to the egress.
>>
>> Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>
>> ---
>>  net/sched/act_mirred.c                        |  4 +++
>>  .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++++++++++++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>> index 5b3814365924..fc96705285fb 100644
>> --- a/net/sched/act_mirred.c
>> +++ b/net/sched/act_mirred.c
>> @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>>                 NL_SET_ERR_MSG_MOD(extack, "Mirred requires attributes to be passed");
>>                 return -EINVAL;
>>         }
>> +       if (tp->chain->block->q->parent != TC_H_INGRESS) {
>> +               NL_SET_ERR_MSG_MOD(extack, "Mirred can only be assigned to the filter attached to ingress");
>> +               return -EINVAL;
>> +       }
>
>Sorry, this is too restrictive as Jiri said. We'll try to reproduce. I
>am almost certain this used to work in the old days.
>
>cheers,
>jamal
>
>PS:- thanks for the tdc test, you are a hero just for submitting that!

As Jiri said, that is really quite restrictive. It might be better to forbid mirred attached to egress filter
to mirror or redirect packets to the egress. Just like:

--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -152,6 +152,12 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
                return -EINVAL;
        }

+       if ((tp->chain->block->q->parent != TC_H_INGRESS) &&
+           (parm->eaction == TCA_EGRESS_MIRROR || parm->eaction == TCA_EGRESS_REDIR)) {
+               NL_SET_ERR_MSG_MOD(extack, "Mirred assigned to egress filter can only mirror or redirect to ingress");
+               return -EINVAL;
+       }
+
        switch (parm->eaction) {
        case TCA_EGRESS_MIRROR:
        case TCA_EGRESS_REDIR:

