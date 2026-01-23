Return-Path: <netdev+bounces-252887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJT1KIenc2lnxwAAu9opvQ
	(envelope-from <netdev+bounces-252887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:53:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB6978A89
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ADFD303AAA9
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E2F2F60CB;
	Fri, 23 Jan 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="X2e2cBUk"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA62D8DB0;
	Fri, 23 Jan 2026 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187175; cv=none; b=hc/k6IsGwhGA7lxPiWZ6s5MxYARbaH+34QDx1MwGcEXqfiCqPeZkqub6uc3ZFMYQ6JnS1q3mUnpHQdEkX6M9a6YRoqglJU6UAPUhJb0SDLYhcoTCTEH6aev2dG0KhNvBQcJkWENPcEyORkw1TZhh9/kMraszCb7v+mfb14+enak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187175; c=relaxed/simple;
	bh=QQNvnGxUaxh9NMq2l8I37svC9XpWKBuEcZtJHkVSsiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5sQArEn2DCX3b2HTqb1dbm+Y6iDApQDmp69qFzTesGsecF0pwAcmQn8FScpVfYvmJHeCXgPSUTscZSGIwZEhh5zDIF7uYMvSuaZEqs7xEbSZqYy9XbvR8AItyrQyIVxrrndOWjaqW+UqmAQCzm+24cNW9PVBBRkYwRoRMtSSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=X2e2cBUk; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vjKOu-00FEMW-VK; Fri, 23 Jan 2026 17:52:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=lveKEYj3xW9x8OtJnfcIghmFfofT+bfpgJirVpnBRiU=; b=X2e2cBUkdY7sGQgayQvvGqFZ8P
	L4Nfb26f7eUf9UwjeAHkrADJgZzzkakpI4uuCy0h+614aiL3kUsmmD/ibsbVfOIkiA99htZwOF1LV
	afbQA2mlfLv40W+IkmLw6OfzAr73QQKeTupopOfeDxf1V1vDFHo9xtrlqtNfvkXs5dBMRYKm3flea
	IV6pOIamq7iYkFNAR20yDatRblXW3upvyQzmRpoGZjsPtZB+tGMjnf5SLNUO5iRWL1JwNBb7K//KR
	LsRMZNddyoXJvt47+hZy2AslWbrC5kNbhOzuCPjOak8vG9LWZlnijBvtZ9+kGALWAuPwq6N0TGBH8
	bBl9Jx6w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vjKOu-0005hw-Hu; Fri, 23 Jan 2026 17:52:48 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vjKOn-004Ea7-L1; Fri, 23 Jan 2026 17:52:41 +0100
Message-ID: <4feef462-95db-4c88-8dec-eb9ff89ede1b@rbox.co>
Date: Fri, 23 Jan 2026 17:52:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
 <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
 <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>
 <663yvkk2sh5lesfvdeerlca567xb64qbwih52bxjftob3umsah@eamuykmarrfr>
 <1b2255c7-0e97-4b37-b7ab-e13e90b7b0b9@rbox.co>
 <06936b55-b359-4e3d-bec0-b157ca32d237@rbox.co>
 <fy3ep725gwaislzz6lyu27ckswp2iyy5gj6afw6jji6c3get3l@lqa6wpptq5ii>
 <69a3d223-dd95-43df-af3a-522968d6b850@rbox.co>
 <pstj7youxwwrpj3bl2a76kh2t62by2vdakv5elqvueobw3o4pj@tnknzlqdt344>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <pstj7youxwwrpj3bl2a76kh2t62by2vdakv5elqvueobw3o4pj@tnknzlqdt344>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rbox.co:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252887-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rbox.co:mid,rbox.co:dkim]
X-Rspamd-Queue-Id: 1DB6978A89
X-Rspamd-Action: no action

On 11/24/25 12:49, Stefano Garzarella wrote:
> On Sun, Nov 23, 2025 at 10:46:22PM +0100, Michal Luczaj wrote:
>> On 11/21/25 10:21, Stefano Garzarella wrote:
>>> On Thu, Nov 20, 2025 at 10:12:20PM +0100, Michal Luczaj wrote:
>>>> On 11/19/25 20:52, Michal Luczaj wrote:
>>>>> ...
>>>>> To follow up, should I add a version of syzkaller's lockdep warning repro
>>>>> to vsock test suite? In theory it could test this fix here as well, but in
>>>>> practice the race window is small and hitting it (the brute way) takes
>>>>> prohibitively long.
>>>>
>>>> Replying to self to add more data.
>>>>
>>>> After reverting
>>>>
>>>> f7c877e75352 ("vsock: fix lock inversion in vsock_assign_transport()")
>>>> 002541ef650b ("vsock: Ignore signal/timeout on connect() if already
>>>> established")
>>>>
>>>> adding
>>>>
>>>> --- a/tools/testing/vsock/vsock_test.c
>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>> @@ -2014,6 +2014,7 @@ static void test_stream_transport_change_client(const
>>>> struct test_opts *opts)
>>>>                        perror("socket");
>>>>                        exit(EXIT_FAILURE);
>>>>                }
>>>> +               enable_so_linger(s, 1);
>>>>
>>>>                ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>>>                /* The connect can fail due to signals coming from the
>>>>
>>>> is enough for vsock_test to trigger the lockdep warning syzkaller found.
>>>>
>>>
>>> cool, so if it's only that, maybe is worth adding.
>>
>> Ok, there it is:
>> https://lore.kernel.org/netdev/20251123-vsock_test-linger-lockdep-warn-v1-1-4b1edf9d8cdc@rbox.co/
> 
> Great!
> 
>>
>> And circling back to [1], let me know if you think it's worth adding to the
>> suit. I guess it would test the case #2 from [2], but it'd take another 2s
> 
> If you think it is better to put them in vsock tests, instead of bpf,
> it's fine by me. 2s more is okay IMO.

OK, here's a followup:
https://lore.kernel.org/bpf/20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co/

[...]

>> [1]:
>> https://lore.kernel.org/netdev/fjy4jaww6xualdudevfuyoavnrbu45cg4d7erv4rttde363xfc@nahglijbl2eg/
>> [2]:
>> https://lore.kernel.org/netdev/20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co/

