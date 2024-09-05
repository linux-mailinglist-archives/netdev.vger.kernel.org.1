Return-Path: <netdev+bounces-125530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C296D8B4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0458EB24171
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3454919B3C1;
	Thu,  5 Sep 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="swrOoSqv"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E43176AD7;
	Thu,  5 Sep 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539730; cv=none; b=FMTKYpJLQmqBqhHKLHV+hLrVEWOMUdpE9txqZ5Hhh7ard7Hz8Vc0oUDu3gMzOmGvXxl6JAwRbL6EVj2h5GrZ0NRWrmqUjpv8AaHR2A9vsfJB9ss2WpjZ5zPk0UcfCnPSrfDnvhVipPq1LhYypW/g5+WEFul5yfZPQ2Mm4W0Z83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539730; c=relaxed/simple;
	bh=eWXnFcXSlzMYQpZW8Hy8qFqCdpL0PX9kvItTRaNmrFg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lsVW9mLAVd8sIo9E7X+rc6r7A2ICQArbJJ/96Q3uIZqwm8RZRuggWTUqrWwfLWJbb1lCTvBKHOtA9alYrdkaDWMaPfgOYLRBUg2fZOfIeGz5j9Jh1Hzl/tls3kaVeky4qOsIXk2WfMnlVI6F1xxnEZ72UzwgMj3lGSTai40PTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=swrOoSqv; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725539723; bh=FYqDZVG9wIGuqWD1evRlumoDPPlBGI6xaAt0w2ApOKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=swrOoSqvVYYpveRg3nka4qO3brIdY+TbrR7AiG6ozWQv2E08f34fIaPCbzzJL7Hol
	 CIXMM9IYm9VlcSLfABEZPHnBmOMX/bdMY0hTmjqIA5hMmhQoZ0L0aODfUmmRwN14VA
	 1VMJ+ZxfBOawcBI/w7kiIkuL7HQ6neXlQe9oTCfQ=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 8D2B8AF4; Thu, 05 Sep 2024 20:35:18 +0800
X-QQ-mid: xmsmtpt1725539718tebrv7rw3
Message-ID: <tencent_3FBF36AE969036864BB0748977C9669E3D09@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaj0aSd45lpCIQQB/+lGDZ2eDgjriY7MWap0RDnHx+QehVevXjl0
	 Of8aphvnf6o3YDhbDoc3p4yEsgL0Z2fDmlexQYXrx7gLLdpTLHK52vn/uFiKsphh59ce7iD4b2ws
	 O7XxZXV1Jho2F9pteCXHH8+vHog5l0ioy7tk7QXSPiIIYU5bE9BKYDXUVS1a5RFZKCBCyc4OZbJK
	 dnNX7mLstjyuVyxNP5qI3POAXUbkYO7knr4BUeJRWbFY65lPloWqFGH7M7w6fFrwvBRCE/oLxUqX
	 Lulo0fR4DiGbU5R0cQBdvVqGvzPuyDC8smoUBn4gAQEitZbFCtXIJF7h7iQYnASXJHBTTXPmUY+8
	 wDhfQjNc1TzQh5N4RwXfOdtDxvj7lwGNlAnpRHLvjMlN2uGTDMzK0mxElsjcr5wWEKA5PP/0j3rw
	 VzIUn52zfBWZdxY3POeaymJ55M+KW/QAOHCoR+bDwo030/gbv3MHYkjBYREA8pyy9Udy4tA1HJA7
	 wnZMtQKcY4SdjFs7mNlxnN8p7uz+2lhh5VO+dLkzgoWLFY83WEuxL4hUyUEOrQCstnKz+4y3ZDCG
	 7S0mCNaHPG68pFZp3a6p3D3PzOhJVenaJteANLLSgId7uoqqeKxtPhR40izo1L7xWljQMZ9mMtXs
	 mCI5T++YYroviruLcH8sz9tCtqz1Tvn7b1sFRGOmZHnaTzvOvDdqoIOGVz7GMjmvM7yTKm/yE1GG
	 X94gRs2O0f8uDoEKxZ+2voMTYAib9j6nAAiYAp0J3PLKmCRlFlX1a8SDIjMdDLixMV1jxhTAt8Pk
	 Mwj4lUuM3aSeJ+amOEiQDYLcofNKrPJhVH+3QKsUHRHTv1yFGklVXGL2zJyUYf4DNZTUemcqzc24
	 dAShELWjMHpQKON/+zChxkrCV1G1kctvoiIN6m4Se7b9+DhrNmOf9Zg3UZ5FPBDWwKFeMR3rIzvF
	 mHn6FrkFBFI3pYiro21+LAD3o7vhmjtO7kuVghG4k=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: matttbe@kernel.org
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	geliang@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Thu,  5 Sep 2024 20:35:19 +0800
X-OQ-MSGID: <20240905123518.101921-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <e4a13002-f471-4951-9180-14f0f8b30bd2@kernel.org>
References: <e4a13002-f471-4951-9180-14f0f8b30bd2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 4 Sep 2024 22:39:10 +0200, Matthieu Baerts wrote:
>On 04/09/2024 03:01, Edward Adam Davis wrote:
>> There are two paths to access mptcp_pm_del_add_timer, result in a race
>> condition:
>>
>>      CPU1				CPU2
>>      ====                               ====
>>      net_rx_action
>>      napi_poll                          netlink_sendmsg
>>      __napi_poll                        netlink_unicast
>>      process_backlog                    netlink_unicast_kernel
>>      __netif_receive_skb                genl_rcv
>>      __netif_receive_skb_one_core       netlink_rcv_skb
>>      NF_HOOK                            genl_rcv_msg
>>      ip_local_deliver_finish            genl_family_rcv_msg
>>      ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
>>      tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
>>      tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
>>      tcp_rcv_established                mptcp_pm_remove_addrs_and_subflows
>>      tcp_data_queue                     remove_anno_list_by_saddr
>>      mptcp_incoming_options             mptcp_pm_del_add_timer
>>      mptcp_pm_del_add_timer             kfree(entry)
>>
>> In remove_anno_list_by_saddr(running on CPU2), after leaving the critical
>> zone protected by "pm.lock", the entry will be released, which leads to the
>> occurrence of uaf in the mptcp_pm_del_add_timer(running on CPU1).
>>
>> Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
>
>Please add a Fixes tag and Cc stable.
>
>And add 'net' after PATCH in the subject:
Got it, I have added them in V3 patch.
>
>  [PATCH net v3]
>
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> ---
>>  net/mptcp/pm_netlink.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 3e4ad801786f..d4cbf7dcf983 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1430,8 +1430,10 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
>>
>>  	entry = mptcp_pm_del_add_timer(msk, addr, false);
>>  	if (entry) {
>> +		spin_lock_bh(&msk->pm.lock);
>>  		list_del(&entry->list);
>>  		kfree(entry);
>> +		spin_unlock_bh(&msk->pm.lock);
>
>Mmh, I can understand it would help to reduce issues here, but I don't
>think that's enough: in mptcp_pm_del_add_timer(), CPU1 can get the entry
>from the list under the lock, then immediately after, the free can
>happen on CPU2, while CPU1 is trying to access entry->add_timer outside
>the lock, no? Something like this:
>
>  CPU1              CPU2
>  ====              ====
>  entry = (...)
>                    kfree(entry)
>  entry->add_timer
>
>
>What about keeping a reference to add_timer inside the lock, and calling
>sk_stop_timer_sync() with this reference, instead of "entry->add_timer"?
>I'm thinking about something like that to be applied *on top* of your
>patch, WDYT?
I strongly agree. This can avoid accessing the entry outside the lock.
I have integrated your code to my patch.

BR,
Edward


