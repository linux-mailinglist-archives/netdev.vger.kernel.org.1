Return-Path: <netdev+bounces-244182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12312CB1C13
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 03:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6EB33002607
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 02:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39CD26ED4C;
	Wed, 10 Dec 2025 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="askhfrNk"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1276413635C;
	Wed, 10 Dec 2025 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765335015; cv=none; b=EzqziFGUcjW4K/nyh+kvRLh1lrW3ImuNjJR5KOjA/RrgDjjXYNdWCsF/VazumA47FfRNk2v3DP8PznA1n5tXtVEaWPJ+yzq0Q0IXTXAtQkvn157BLvauKDh8I15PrJwfVvrPpmTD6kh3bLDwRmCsmb4a83EFO95QL7fsA+HrxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765335015; c=relaxed/simple;
	bh=hmQUpgm3c0O20DMrXGIC2qrQrdi7Sr1r2ymCXEy7mYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dSQ5/oE7XJTGjjkx2CbzlI2fhj/o26TCRA9RieTMDOypMYu2qyye6EGoEHj+k5bd736PHn6scvW1zjjLmW1Ppgp+t96SmlHGq2bpTuXc0+IjVpk73UIrAv9/Q87i+SgBPZJsdiK34n5JGXJ9HJEALSPRCBE1l7jTlynH2LaLUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=askhfrNk; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jH8YEHJ1QexebVm5QngK4AIF6AG1kDsOYmA+4PwgQE4=;
	b=askhfrNkmBfnLEheaKscqtT8fpo4DdL+9pJRsot/0NFQzXxJY9xUvLU03Qvj9iCcjAOHSvas2
	Jch4m3Yl9/vSk7DIXboNknSZdjcZVDuoaSAe3cKAkq+5AQbmB54A8cezhO9Ks8ekhE9rDpVjToF
	y+344EQh9npWrFyBeWqo8uQ=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dR0WX0rGnz12LCr;
	Wed, 10 Dec 2025 10:47:52 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AA661402C1;
	Wed, 10 Dec 2025 10:50:10 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Dec 2025 10:50:08 +0800
Message-ID: <c754e0ea-2a5e-4be5-9207-93299b38d28e@huawei.com>
Date: Wed, 10 Dec 2025 10:50:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/handshake: Fix null-ptr-deref in
 handshake_complete()
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Christian Brauner
	<brauner@kernel.org>
CC: <kernel-tls-handshake@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
References: <20251209115852.3827876-1-wangliang74@huawei.com>
 <13914223-071e-4374-882b-d6ca5257b751@app.fastmail.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <13914223-071e-4374-882b-d6ca5257b751@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/12/9 22:39, Chuck Lever 写道:
>
> On Tue, Dec 9, 2025, at 6:58 AM, Wang Liang wrote:
>> A null pointer dereference in handshake_complete() was observed [1].
>>
>> When handshake_req_next() return NULL in handshake_nl_accept_doit(),
>> function handshake_complete() will be called unexpectedly which triggers
>> this crash. Fix it by goto out_status when req is NULL.
>>
>> [1]
>> Oops: general protection fault, probably for non-canonical address
>> 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
>> RIP: 0010:handshake_complete+0x36/0x2b0 net/handshake/request.c:288
>> Call Trace:
>>   <TASK>
>>   handshake_nl_accept_doit+0x32d/0x7e0 net/handshake/netlink.c:129
>>   genl_family_rcv_msg_doit+0x204/0x300 net/netlink/genetlink.c:1115
>>   genl_family_rcv_msg+0x436/0x670 net/netlink/genetlink.c:1195
>>   genl_rcv_msg+0xcc/0x170 net/netlink/genetlink.c:1210
>>   netlink_rcv_skb+0x14c/0x430 net/netlink/af_netlink.c:2550
>>   genl_rcv+0x2d/0x40 net/netlink/genetlink.c:1219
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>>   netlink_unicast+0x878/0xb20 net/netlink/af_netlink.c:1344
>>   netlink_sendmsg+0x897/0xd70 net/netlink/af_netlink.c:1894
>>   sock_sendmsg_nosec net/socket.c:727 [inline]
>>   __sock_sendmsg net/socket.c:742 [inline]
>>   ____sys_sendmsg+0xa39/0xbf0 net/socket.c:2592
>>   ___sys_sendmsg+0x121/0x1c0 net/socket.c:2646
>>   __sys_sendmsg+0x155/0x200 net/socket.c:2678
>>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>   do_syscall_64+0x5f/0x350 arch/x86/entry/syscall_64.c:94
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>   </TASK>
>>
>> Fixes: fe67b063f687 ("net/handshake: convert handshake_nl_accept_doit()
>> to FD_PREPARE()")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>   net/handshake/netlink.c | 35 ++++++++++++++++++-----------------
>>   1 file changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
>> index 1d33a4675a48..cdaea8b8d004 100644
>> --- a/net/handshake/netlink.c
>> +++ b/net/handshake/netlink.c
>> @@ -106,25 +106,26 @@ int handshake_nl_accept_doit(struct sk_buff *skb,
>> struct genl_info *info)
>>
>>   	err = -EAGAIN;
>>   	req = handshake_req_next(hn, class);
>> -	if (req) {
>> -		sock = req->hr_sk->sk_socket;
>> -
>> -		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
>> -		if (fdf.err) {
>> -			err = fdf.err;
>> -			goto out_complete;
>> -		}
>> -
>> -		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
>> -		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
>> -		if (err)
>> -			goto out_complete; /* Automatic cleanup handles fput */
>> -
>> -		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
>> -		fd_publish(fdf);
>> -		return 0;
>> +	if (!req)
>> +		goto out_status;
>> +
>> +	sock = req->hr_sk->sk_socket;
>> +
>> +	FD_PREPARE(fdf, O_CLOEXEC, sock->file);
>> +	if (fdf.err) {
>> +		err = fdf.err;
>> +		goto out_complete;
>>   	}
>>
>> +	get_file(sock->file); /* FD_PREPARE() consumes a reference. */
>> +	err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
>> +	if (err)
>> +		goto out_complete; /* Automatic cleanup handles fput */
>> +
>> +	trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
>> +	fd_publish(fdf);
>> +	return 0;
>> +
>>   out_complete:
>>   	handshake_complete(req, -EIO, NULL);
>>   out_status:
>> -- 
>> 2.34.1
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/kernel-tls-handshake/aScekpuOYHRM9uOd@morisot.1015granger.net/T/#m7cfa5c11efc626d77622b2981591197a2acdd65e


Thanks for the reminder. I hadn't noticed this email before.

I will add this in v2 patch.

------
Best regards
Wang Liang

>

