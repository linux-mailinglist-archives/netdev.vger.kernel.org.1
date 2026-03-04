Return-Path: <netdev+bounces-263768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHccOoIYqGmgnwAAu9opvQ
	(envelope-from <netdev+bounces-263768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:33:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A651FF02E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00D753012520
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8523451AE;
	Wed,  4 Mar 2026 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rHjF4s7c"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A573258EE9;
	Wed,  4 Mar 2026 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623998; cv=none; b=cq/uHMb6vXjDBnfAg2rkMjh/oapOwmdPqpEl+PTHK61dmBc13KxVmGtsCdlLMADBgwkZH2Q6Wvhu5USZYNx2RUWIFLT7iERQVXRBiSNjvgmCddnUXQJhV5F/X33RubHY23wuLZlS/7KviO/FcQVuoKhDVTC3PVzCO2d32hYn5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623998; c=relaxed/simple;
	bh=wk7qrXfDrYD6cJFDXktxKGoJNqd2Xpl/v52eEJv+3MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=RPR/Toi68OL1E/Ha7P3NlHcPJgZtE/QwwBFFGXHbikVQ3L7q+Q8FGKbOMTYa7+Iaojku3hTZe4/0h1CLL1ceRCiACqnY94CvwXUymqXliQXQk36p69HcptOyqmrDjxqS6ypLdpPxi8qQ1XpfdB3SD5+kkNpOurhyrnCtGuad5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rHjF4s7c; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eEYIAbhssCXP/hvMfg0IJSwg33oSZSj04dcBiemSHFk=;
	b=rHjF4s7cSbzKNWekoCMwNPRZQr3RBfn1E5Dnrf4q6BIK/jKX6H4uf+PWJwkByyjh47eO2vmbM
	BbKe1LyMebuSgqOfYURP1oepyH/GSG03se8JNDKz/x957foLTQwn1ZV/L9wU11QkvvG0ERAxvMJ
	4IJ3QXupa7pCcWHpP2/9bRg=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fQr5b4tqBz12LCr;
	Wed,  4 Mar 2026 19:28:35 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FB444056A;
	Wed,  4 Mar 2026 19:33:12 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Mar 2026 19:33:11 +0800
Message-ID: <11702093-2cda-4d02-ac26-31d9c827c63e@huawei.com>
Date: Wed, 4 Mar 2026 19:33:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mptcp: fix soft lockup in mptcp_recvmsg()
To: Paolo Abeni <pabeni@redhat.com>
References: <20260302052651.1466983-1-lixiasong1@huawei.com>
 <64132462-e640-4ea6-82e8-48ca07a6ad44@redhat.com>
From: Li Xiasong <lixiasong1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <geliang@kernel.org>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	<mptcp@lists.linux.dev>, <netdev@vger.kernel.org>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
In-Reply-To: <64132462-e640-4ea6-82e8-48ca07a6ad44@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj500018.china.huawei.com (7.202.194.48)
X-Rspamd-Queue-Id: D7A651FF02E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-263768-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixiasong1@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Action: no action

Hi Paolo,

On 3/4/2026 5:07 PM, Paolo Abeni wrote:
> On 3/2/26 6:26 AM, Li Xiasong wrote:
>> @@ -2343,7 +2347,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  
>>  		pr_debug("block timeout %ld\n", timeo);
>>  		mptcp_cleanup_rbuf(msk, copied);
>> -		err = sk_wait_data(sk, &timeo, NULL);
>> +		err = sk_wait_data(sk, &timeo, last);
> 
> Isn't
> 		err = sk_wait_data(sk, &timeo,  skb_peek_tail(&sk->sk_receive_queue));
> 
> Enough?

Thanks for the review! In the general case, letting sk_wait_data block is
correct. The exception is within __mptcp_recvmsg_mskq, where a failure in
skb_copy_datagram_msg will cause a break in the consumption loop. This
leaves the actual processing position inconsistent with
skb_peek_tail(&sk->sk_receive_queue), and at that point, we must not wait.

> 
> Also, could you please add a paired tests-case? Thanks!
> 

Further to our discussion, a minimal reproduction case for this scenario is
available here:
https://lore.kernel.org/netdev/e91bf909-bf4d-4f90-a370-688a9424478b@huawei.com/

When running the reproduced program, you can observe the server's sy
(system) CPU usage hitting 100%.

Thanks,
Li Xiasong


