Return-Path: <netdev+bounces-202378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7807CAEDA66
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B2F1893107
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD422459F3;
	Mon, 30 Jun 2025 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="tEptvDfp"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605AC23D2B2;
	Mon, 30 Jun 2025 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751281380; cv=none; b=HicFmgWxaiDTLVKXVAkL4PUmItKy2JFQ8sUEKRWx63bKBERfboC1dziBMdp8cHwf3KIAKmEl3GXTOSPJQbJG3+NHNrSJXvf44MurZZ3OoP72FsIj2ac2ZroJ+iSzRUOPAhFKoKiCXmHBwmhQv4IGMR31U214fRKnCpWqC/VLP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751281380; c=relaxed/simple;
	bh=AlSQ9a6gEH3m835ZIvulgwzUplQSlrSnDhFVTi8drVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rc0tD4VB1exhAL4OoYgd6a5G98RsPU/ZcRl85Qs+cZf6mG9U9oLSGLVb9k9HDusCS/dMZ1An70urBJM4GU658THrN+CIS8wM6+YV22qUQKLrCsHuo6TsYNUZcLCus27b+ORLb8HW2hL1suM5KkSYDfuifQg1Lw3UgUPSdvRSHmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=tEptvDfp; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWCHg-00APYr-PG; Mon, 30 Jun 2025 13:02:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=UiDvWzuJibTX7nYpjLjXINACy88/q5T4ttTyWRwRY/I=; b=tEptvDfpnSJ+EdNd3vDiXqDCq/
	zZSpIX1DacMGukWX6wz7uCe5GCjuLfpbzGnN4kp/LGSp0g3FhkVLqhDRmg28PFFASI0xbnxDyC808
	N7hzMPY5kGWHbO4SvQdEdl5nJzeu6//Oz0C5ewshu1QcdXflhfwl0gYjrLYL5j2Eq5nbSw2oTOIfw
	LZPJKdo1F5DiEqBecTPSj51TPt7HO0qmQbkSlLph9dlvqbYLeMC3cvTxbtai4rSLwFmRcxPjGdJwK
	bJM1PbmXbrs3JLpBkajLBu4KpThvSCnqW64KPAqn/FJ45fHDyj5SPQ03OrYHnQ+O83lRngOLSvyDp
	4Qeb8ZAg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWCHf-0003Hn-SX; Mon, 30 Jun 2025 13:02:48 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWCHL-00EJVL-AU; Mon, 30 Jun 2025 13:02:27 +0200
Message-ID: <c39f22fd-9ede-4cdd-956b-29856e9db20a@rbox.co>
Date: Mon, 30 Jun 2025 13:02:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net v2 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>
 <zdiqu6pszqwb4y5o7oqzdovfvzkbrvc6ijuxoef2iloklahyoy@njsnvn7hfwye>
 <d8d4edb2-bf14-42b2-8592-79d7b014e1a7@rbox.co>
 <owafhdinyjdnol4zwpcdqsz26nfndawl53wnosdhhgmfz6t25n@2dualdqgpq3q>
 <e97b5cae-f6ef-4221-98e1-6efd7fdc6676@rbox.co>
 <4vsrtxs3uttx6w2zyk6rxescpwvrikypiw6tvjheplht6yzonc@ch6k3xlftikw>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <4vsrtxs3uttx6w2zyk6rxescpwvrikypiw6tvjheplht6yzonc@ch6k3xlftikw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 11:05, Stefano Garzarella wrote:
> On Sun, Jun 29, 2025 at 11:26:12PM +0200, Michal Luczaj wrote:
>> On 6/27/25 10:02, Stefano Garzarella wrote:
>>> On Wed, Jun 25, 2025 at 11:23:30PM +0200, Michal Luczaj wrote:
>>>> On 6/25/25 10:43, Stefano Garzarella wrote:
>>>>> On Fri, Jun 20, 2025 at 09:52:43PM +0200, Michal Luczaj wrote:
>>>>>> vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
>>>>>> transport_{g2h,h2g} may become NULL after the NULL check.
>>>>>>
>>>>>> Introduce vsock_transport_local_cid() to protect from a potential
>>>>>> null-ptr-deref.
>>>>>>
>>>>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>>>>> RIP: 0010:vsock_find_cid+0x47/0x90
>>>>>> Call Trace:
>>>>>> __vsock_bind+0x4b2/0x720
>>>>>> vsock_bind+0x90/0xe0
>>>>>> __sys_bind+0x14d/0x1e0
>>>>>> __x64_sys_bind+0x6e/0xc0
>>>>>> do_syscall_64+0x92/0x1c0
>>>>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>>>
>>>>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>>>>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>>>>>> Call Trace:
>>>>>> __x64_sys_ioctl+0x12d/0x190
>>>>>> do_syscall_64+0x92/0x1c0
>>>>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>>>
>>>>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
...
>> Oh, and come to think of it, we don't really need that (easily contended?)
>> mutex here. Same can be done with RCU. Which should speed up vsock_bind()
>> -> __vsock_bind() -> vsock_find_cid(), right? This is what I mean, roughly:
>>
>> +static u32 vsock_registered_transport_cid(const struct vsock_transport
>> __rcu **trans_ptr)
>> +{
>> +	const struct vsock_transport *transport;
>> +	u32 cid = VMADDR_CID_ANY;
>> +
>> +	rcu_read_lock();
>> +	transport = rcu_dereference(*trans_ptr);
>> +	if (transport)
>> +		cid = transport->get_local_cid();
>> +	rcu_read_unlock();
>> +
>> +	return cid;
>> +}
>> ...
>> @@ -2713,6 +2726,7 @@ void vsock_core_unregister(const struct
>> vsock_transport *t)
>> 		transport_local = NULL;
>>
>> 	mutex_unlock(&vsock_register_mutex);
>> +	synchronize_rcu();
>> }
>>
>> I've realized I'm throwing multiple unrelated ideas/questions, so let me
>> summarise:
>> 1. Hackish macro can be used to guard against calling
>> vsock_registered_transport_cid() on a non-static variable.
>> 2. We can comment the function to add some context and avoid confusion.
> 
> I'd go with 2.

All right, will do.

>> 3. Instead of taking mutex in vsock_registered_transport_cid() we can use RCU.
> 
> Since the vsock_bind() is not in the hot path, maybe a mutex is fine.
> WDYT?

I wrote a benchmark that attempts (and fails due to a non-existing CID) to
bind() 100s of vsocks in multiple threads. `perf lock con` shows that this
mutex is contended, and things are slowed down by 100+% compared with RCU
approach. Which makes sense: every explicit vsock bind() across the whole
system would need to acquire the mutex. And now we're also taking the same
mutex in vsock_assign_transport(), i.e. during connect(). But maybe such
stress testing is just unrealistic, I really don't know.


