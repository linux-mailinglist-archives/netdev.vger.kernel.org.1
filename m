Return-Path: <netdev+bounces-245912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9908CDA8B1
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 21:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A213015160
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 20:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416E352937;
	Tue, 23 Dec 2025 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="MLtCXIHs"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F266C352927;
	Tue, 23 Dec 2025 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766522312; cv=none; b=h+5AAMESoXCZZCOGr3feAum0Nn+YOFYGcKFtga2ndJW27hT4XjPb0bh9G+hEXqQmbfW94hLDdHRKTxu4NXN0HGK2uRGlM/paLNCX7w1ptHDZfubkD+VTM3qXPDHFoxvfCmfHJhMR0pH2ZTWORuDiMDouO2cpeClHWfk8ysVwmdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766522312; c=relaxed/simple;
	bh=6/ZdjSfm9//uCTtcZ2W0JPyeUA3JviyrCDI2XvddMm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNXjoRlxIhcpVInqHZrlpiLLBBM8CL7AxTE2sctzhlSr5MrFoUowTijvkAeSWrvpzmb9/sdva1D0HpV6woH73iQ8nbuZ4yYNdkWOpuRTF7euO/ZdGwVgAoySH7YPgB3G3pUmZ45+e7LbRCQGUEuBFBrqh2Ni+y1hvphBgTm53NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=MLtCXIHs; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vY99A-00ChTx-Sk; Tue, 23 Dec 2025 21:38:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=G04fOss7s2uzqt5OHkNCXpKNb5yp/lgsXByLaYfHCj0=; b=MLtCXIHsjhWM8CZGEHIFOg1r2e
	u2fOXvjs2rVptwJy+3tcAnrIJZMA5aB31UFjMws55kTp0bgTyCNXh0dwbINKoQiX0bi/pXLoOR5wn
	Zr61OilSOCcsjrKb8cHg+UKIQbdigqGxwca1VQ7iZUteQEAAmDtfXVumz1w4ZZC/LWFLcDhAM5Hds
	NudBMNKO9oO7Ug7HldbnJd/aeGW9s9E6EWR160HWsqoKVnsnPcYoxOtIcXiRFohIP9wGVfUtk+uGO
	RbURThITunCabFSPLXcq2HImtvGul5otlYjbVAaZiVGNkqrwyOHOhokXgeRr5Q2zCdytD5QonkIxH
	0Mf6IK9Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vY99A-0008GB-78; Tue, 23 Dec 2025 21:38:20 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vY98z-00AWJD-3F; Tue, 23 Dec 2025 21:38:09 +0100
Message-ID: <8b76f6f8-3f5c-4bea-8084-577712ec028b@rbox.co>
Date: Tue, 23 Dec 2025 21:38:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] vsock/test: Test setting SO_ZEROCOPY on
 accept()ed socket
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
 <aUpualKwJbT9W1ia@sgarzare-redhat>
 <1c877a67-778e-424c-8c23-9e4d799fac2f@rbox.co>
 <aUqWtwr0n2RO7IB-@sgarzare-redhat> <aUrIDT-Tg5SpXhlO@sgarzare-redhat>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <aUrIDT-Tg5SpXhlO@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 17:50, Stefano Garzarella wrote:
> On Tue, Dec 23, 2025 at 02:20:33PM +0100, Stefano Garzarella wrote:
>> On Tue, Dec 23, 2025 at 12:10:25PM +0100, Michal Luczaj wrote:
>>> On 12/23/25 11:27, Stefano Garzarella wrote:
>>>> On Tue, Dec 23, 2025 at 10:15:29AM +0100, Michal Luczaj wrote:
>>>>> Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
>>>>> handled by vsock's implementation.
>>>>>
>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>> ---
>>>>> tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
>>>>> 1 file changed, 33 insertions(+)
>>>>>
>>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>>>> index 9e1250790f33..8ec8f0844e22 100644
>>>>> --- a/tools/testing/vsock/vsock_test.c
>>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>>> @@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
>>>>> 	close(fd);
>>>>> }
>>>>>
>>>>> +static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
>>>>> +{
>>>>> +	int fd;
>>>>> +
>>>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>>>> +	if (fd < 0) {
>>>>> +		perror("connect");
>>>>> +		exit(EXIT_FAILURE);
>>>>> +	}
>>>>> +
>>>>> +	vsock_wait_remote_close(fd);
> 
> On a second look, why we need to wait the remote close?
> can we just have a control message?

I think we can. I've used vsock_wait_remote_close() simply as a sync
primitive. It's one line of code less.

> I'm not sure even on that, I mean why this peer can't close the
> connection while the other is checking if it's able to set zerocopy?

I was worried that without any sync, client-side close() may race
server-side accept(), but I've just checked and it doesn't seem to cause
any issues, at least for the virtio transports.

>>>>> +	close(fd);
>>>>> +}
>>>>> +
>>>>> +static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
>>>>> +{
>>>>> +	int fd;
>>>>> +
>>>>> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>>>>> +	if (fd < 0) {
>>>>> +		perror("accept");
>>>>> +		exit(EXIT_FAILURE);
>>>>> +	}
>>>>> +
>>>>> +	enable_so_zerocopy_check(fd);
>>>>
>>>> This test is passing on my env also without the patch applied.
>>>>
>>>> Is that expected?
>>>
>>> Oh, no, definitely not. It fails for me:
>>> 36 - SOCK_STREAM accept()ed socket custom setsockopt()...36 - SOCK_STREAM
>>> accept()ed socket custom setsockopt()...setsockopt err: Operation not
>>> supported (95)
>>> setsockopt SO_ZEROCOPY val 1
>>
>> aaa, right, the server is failing, sorry ;-)
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>>
>>> I have no idea what's going on :)
>>>
>>
>> In my suite, I'm checking the client, and if the last test fails only 
>> on the server, I'm missing it. I'd fix my suite, and maybe also 
>> vsock_test adding another sync point.
> 
> Added a full barrier here: 
> https://lore.kernel.org/netdev/20251223162210.43976-1-sgarzare@redhat.com

Which reminds me of discussion in
https://lore.kernel.org/netdev/151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co/
. Sorry for postponing, I've put it on my vsock-cleanups branch and kept
adding more little fixes, and it was never the right time to post the series.


