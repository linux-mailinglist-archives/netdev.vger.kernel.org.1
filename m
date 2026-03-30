Return-Path: <netdev+bounces-273123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CFFIrlWymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:55:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ACF359C49
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84A5930086A3
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820033BED0F;
	Mon, 30 Mar 2026 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1pOYxzfW"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F673BF699;
	Mon, 30 Mar 2026 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867394; cv=none; b=cx1KnXvnz57WwE/M5J9U7hlz0QZsRM/bV6Ivy57WBDaktnnM3J17fcz3NVV0r9MB9q1MJAZndw3+NCXfODUWzNX6k/6r9Ef3EWNAu2bOiOhJ14rNEzzZrtNA4uiN3XwxIjIB8eOdswPMqw2+VAf7brpx06W2H+Q4eAL+WE+ijLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867394; c=relaxed/simple;
	bh=531yv0Fevuus5pVVZKvem5krvxUk0IpEdrb262gMyZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fXZuOj7zeuwOkezliwfQugJ4IPOlixywZPj128E9hXFbo7r5NCgDc6pN20XtS43GOud1ppw3Qnu5/1uZ13zIZandQqwXaif8FAF6pzHNasU5kVm1EupuPwU4CF7fDkrjezlpzVk4Jf5acFpUFkvxYNhhlTCTC2vUGfXbf/TAE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1pOYxzfW; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FijnqdE6OSWehu5JGbmzn2xyJ6RHFhLBH81LWWs9vNk=;
	b=1pOYxzfWs28lCmu4qi8ofr29DlGUrt+tVcnM4GKKfqO34Gw7wa+oczx0Dpw+04WNdebAe1c2k
	J5hmqRzGrlLZmmjwHEBiBrG7PVjRmZocajNx5X/Fk4S6CTBCD0kpj9M269XQGVBY3oAltMnuopm
	oUvmC3IrW+4Fd9oo4rGr818=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fknjz71lpzKm76;
	Mon, 30 Mar 2026 18:36:55 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 70CBA402AB;
	Mon, 30 Mar 2026 18:43:06 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 18:43:05 +0800
Message-ID: <2a013d86-70ea-473e-9c50-332f9b0bfd81@huawei.com>
Date: Mon, 30 Mar 2026 18:43:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] mptcp: fix soft lockup in mptcp_recvmsg()
To: Matthieu Baerts <matttbe@kernel.org>
CC: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <weiyongjun1@huawei.com>
References: <20260327075544.3622851-1-lixiasong1@huawei.com>
 <c23acf06-8d10-4a3c-a3df-d62860ba6b31@kernel.org>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <c23acf06-8d10-4a3c-a3df-d62860ba6b31@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj500018.china.huawei.com (7.202.194.48)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-273123-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixiasong1@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: 88ACF359C49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Matt,

On 3/27/2026 8:13 PM, Matthieu Baerts wrote:
> Hi Li,
> 
> On 27/03/2026 08:55, Li Xiasong wrote:
>> syzbot reported a soft lockup in mptcp_recvmsg() [0].
>>
>> When receiving data with MSG_PEEK | MSG_WAITALL flags, the skb is not
>> removed from the sk_receive_queue. This causes sk_wait_data() to always
>> find available data and never perform actual waiting, leading to a soft
>> lockup.
>>
>> Fix this by adding a 'last' parameter to track the last peeked skb.
>> This allows sk_wait_data() to make informed waiting decisions and prevent
>> infinite loops when MSG_PEEK is used.
> 
> Thank you for the new version!
> 
> (...)
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index cf1852b99963..60f6e6a189b7 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
> 
> (...)
> 
>> @@ -2343,7 +2347,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  
>>  		pr_debug("block timeout %ld\n", timeo);
>>  		mptcp_cleanup_rbuf(msk, copied);
>> -		err = sk_wait_data(sk, &timeo, NULL);
>> +		err = sk_wait_data(sk, &timeo, last);
> 
> sashiko is saying [1] this:
> 
>> Will this cause a soft lockup if all socket buffers in the receive queue
>> have already been peeked?
>>
>> If the queue only contains already-peeked buffers, the loop in
>> __mptcp_recvmsg_mskq() skips them using a continue statement:
>>
>>     if (flags & MSG_PEEK) {
>>         /* skip already peeked skbs */
>>         if (total_data_len + data_len <= copied_total) {
>>             total_data_len += data_len;
>>             continue;
>>         }
>>
>> This means last is never assigned and remains NULL.
>>
>> When last is NULL, sk_wait_data() checks if the receive queue tail is
>> not equal to NULL. Since the queue still contains the unconsumed buffers,
>> this evaluates to true and sk_wait_data() returns immediately without
>> sleeping.
>>
>> Does this result in an infinite loop here when MSG_PEEK and MSG_WAITALL
>> are used together?
> 
> I *think* that's a false positive. When MSG_PEEK and MSG_WAITALL are
> used together, sk_wait_data() will be call with "last" != NULL and will
> be unblocked when a new data packet (skb->len > 0) is added to the
> queue. In other words, when walking the queue in __mptcp_recvmsg_mskq,
> it should never be full of already-peeked skb. Or did I miss something?
> 
> If yes, "*last = skb" could be added before the "continue".
> 
> If no, this patch can be applied in 'net' directly:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 

Through code analysis and testing, there is indeed the special scenario
sashiko described:

when receiving data with MSG_PEEK | MSG_WAITALL while waiting for data
and calling shutdown(sock_fd, SHUT_WR) in another thread simultaneously,
mptcp_close_wake_up will wake up sk_wait_data, but sk->sk_state remains
FIN_WAIT2, leading to a busy loop with CPU at 100%, which can further
lead to soft lockup.

Adding '*last = skb' before 'continue' can properly solve it. I'll send
v4 with this fix later.

Thanks,
Li Xiasong


