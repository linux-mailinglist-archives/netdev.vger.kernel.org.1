Return-Path: <netdev+bounces-245842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB44CD908E
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 12:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34F2030012FA
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F12DE718;
	Tue, 23 Dec 2025 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="jBdoBIF9"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7FAF507;
	Tue, 23 Dec 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488244; cv=none; b=rUwMW1P8iRhIio9Ue2lo0vrIXMP4wJNaJ35Z5J2+kx1RrjhzSpteh7o1XBm4x9EQrzl+YC6gEukCVaiPeB6gJLUptFYkY0UsaK0xWDBr2H2ixKhVHnp7ruak1ibp3hR7FioR5h+5mxkDVAEs9jXnTOjFq9p3OCnZBRREJi23Y6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488244; c=relaxed/simple;
	bh=MwsYCq8gI2x45h7pTkseyQYetUXI/gUgO+tAkc3GMNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWstxKUyN+07xTT68SHqmrhnD2KLZv373W6uQDVLFQCB+Xrg7ZSt9wK2d2/xZv9BJQQlUs0z0X8SmWcbe5isUcxM3WbqlCRQ/9e0xTZYfvJ8Dx9LIyAwaJphx5tl/cG21fP3ekoLb74ciSAqqYNRTu5f05ZtCEw9QUfU99pZPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=jBdoBIF9; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vY0Hk-00BJxz-R9; Tue, 23 Dec 2025 12:10:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=PvpW4Y9MPZzO9brgOX314thROw7oVkzCt7oS9+spQp0=; b=jBdoBIF9khjVJk/GR3T5dRC2/H
	j6KF0bqDY2HjacP6lN3FIIhCHXDi/1RaCIjeXGiSspIYvMwunlbtYYJRErhaUR9JSu+cMBwlu3iyJ
	XFbfI8cFtDp2F/wbbb1vkiEe9M2cqDdsVHJlNYUwdKLuu2tSPAOMUUQDvyiOdQm0UzpKU8t6Eioem
	7OHS36yk6UyIXj6KOGlOjvYZAgfQH2TH7NlI+97/lK6k2RAIT0I/Nu4zZsceeR4uTqN4+tScLTzZf
	nAECvMGxOtde45n9veKuVMLrmHrQx0zy+mW/FMuqo3X/zAGjRa5VZiI7ppCNPLidvpHAAA3RRgqZg
	HYsovoug==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vY0Hk-0005J9-H3; Tue, 23 Dec 2025 12:10:36 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vY0Ha-009fxZ-Vo; Tue, 23 Dec 2025 12:10:27 +0100
Message-ID: <1c877a67-778e-424c-8c23-9e4d799fac2f@rbox.co>
Date: Tue, 23 Dec 2025 12:10:25 +0100
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
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <aUpualKwJbT9W1ia@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 11:27, Stefano Garzarella wrote:
> On Tue, Dec 23, 2025 at 10:15:29AM +0100, Michal Luczaj wrote:
>> Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
>> handled by vsock's implementation.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
>> 1 file changed, 33 insertions(+)
>>
>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>> index 9e1250790f33..8ec8f0844e22 100644
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
>> 	close(fd);
>> }
>>
>> +static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
>> +{
>> +	int fd;
>> +
>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>> +	if (fd < 0) {
>> +		perror("connect");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	vsock_wait_remote_close(fd);
>> +	close(fd);
>> +}
>> +
>> +static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
>> +{
>> +	int fd;
>> +
>> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>> +	if (fd < 0) {
>> +		perror("accept");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	enable_so_zerocopy_check(fd);
> 
> This test is passing on my env also without the patch applied.
> 
> Is that expected?

Oh, no, definitely not. It fails for me:
36 - SOCK_STREAM accept()ed socket custom setsockopt()...36 - SOCK_STREAM
accept()ed socket custom setsockopt()...setsockopt err: Operation not
supported (95)
setsockopt SO_ZEROCOPY val 1

I have no idea what's going on :)


