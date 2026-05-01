Return-Path: <netdev+bounces-283128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9Ht4F2JQ9Gl4AgIAu9opvQ
	(envelope-from <netdev+bounces-283128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:04:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC6C4AAC3F
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C138D300F105
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 07:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96549361666;
	Fri,  1 May 2026 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNuppFfn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2BA2E92D2;
	Fri,  1 May 2026 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777619038; cv=none; b=aGKZ2Q+lqnfFLOm24eIVWmlORKksbMwtt1Ph5Ovbv2groGlAWjHW/qipfsjA95QqZd8S2q8GJ3PQRpxiQS1bYzgbPxTOYdkXaFxGKkg+JLgoBuqLCybPXDMS1Zpcic6BbLZBOPPIbfjqo5srz/df9wYD+B4S85Q+oEj+sG8jQ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777619038; c=relaxed/simple;
	bh=J2NE0RqhzseSY+hH7I95i9F1rAkWIrEhJO5X80JgKKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYuMVr5vEdWKw/7kp2fg5l2IzCzT6Wn5t7gZkOnTSItWrxlMe0oHveFE6B7ftGI4Jqj7Yv/PuSRQiQWjVksUULDcNpXSI5vqr9VfIG6F5taTU36DDvJ6O4TBwnB0N0Y7wwzTktHP/iktZauJQpNO23QlCllEjQpl75uT8ORc7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNuppFfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C95C2BCB7;
	Fri,  1 May 2026 07:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777619038;
	bh=J2NE0RqhzseSY+hH7I95i9F1rAkWIrEhJO5X80JgKKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uNuppFfnAkKGkgAeyLvATs9FRYd//93GQvNh0PXyLITMYpWYIRhZK1JSPRm9rfNYc
	 R5K6GBPlYzrDDwrEcKqeAjqstEHaFUS6TGeIcVYrSR/CNITOaoVilfLlONKZCDWg7r
	 nSla9TSVqrJtgcbk1jmONZImdL8OxXBV0FWry2iAs3sXOF8GGRVwlM9e1PutUcY8vs
	 vp+xnlXxU0/OUlDyRZHpmnkCjnFaXPo4oa+oTduVVX96//QmvWOmMmLFHCTZ7zUccJ
	 6TpkmdrLy74uCAOmD/3uC2JB0z9eLZSxtXzpZAjQF+8LMchLnsn9Q4W1CRMQ1Z4JlK
	 yZd7C3OQD3M4w==
Message-ID: <5571f831-dccb-4cfe-a618-35eec53963d7@kernel.org>
Date: Fri, 1 May 2026 09:03:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] selftests: net: add veth BQL stress test
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260429172036.1028526-1-hawk@kernel.org>
 <20260429172036.1028526-6-hawk@kernel.org>
 <20260430190058.5b20b15a@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260430190058.5b20b15a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9FC6C4AAC3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283128-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,veth_bql_test_virtme.sh:url]



On 01/05/2026 04.00, Jakub Kicinski wrote:
> On Wed, 29 Apr 2026 19:20:32 +0200 hawk@kernel.org wrote:
>> A companion wrapper (veth_bql_test_virtme.sh) launches the test inside
>> a virtme-ng VM, with .config validation to prevent silent stalls.
>>
>> Usage:
>>    sudo ./veth_bql_test.sh [--duration 300] [--nrules 100]
>>                            [--qdisc sfq] [--qdisc-opts '...']
>>                            [--bql-disable] [--normal-napi]
>>                            [--qdisc-replace]
> 
> Not convinced we need to carry this in the tree.

I agree, I will drop the selftest in V4.

The selftest have been very useful during *development* phase.
The number of options also reveal that we (Jonas and I) have been using
this beyond a selftest. The veth_bql_test_virtme.sh wrapper have been a
huge help to accelerate test-based development cycles,  but it's not a
selftest component per say. This have caught actual bugs in our BQL/DQL
API usage, but all those BUGs are fixed in code.

It makes a lot of sense to avoid having to maintain this code in tree.
I can place it somewhere on GitHub, else it can be pulled from lore.

--Jesper

