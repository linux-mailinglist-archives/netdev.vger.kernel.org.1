Return-Path: <netdev+bounces-284987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPZcI9uC+2mEbwMAu9opvQ
	(envelope-from <netdev+bounces-284987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:05:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F1F4DF219
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8581D3001191
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9C74BC01E;
	Wed,  6 May 2026 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJhQSJJF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01934A2E0E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090705; cv=none; b=l9Jy8WJyEdsbcJklpRGXUIvr22ZyEWgnIca2HsLcTxSc51C1/cUD6wSFwFOueXrlQwQ9TPckqNs1D6bxpIWep45n9dESrgk61JsikM7QBuhNvbztD9qDJpzmdAQDKgS1a/OwMFi2DK2/O4+HEevlQ7/DneMpnXjhQu8bgZO8ucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090705; c=relaxed/simple;
	bh=W2RikdlCpHwS4MbcOM6rCR1SkRh2XHbp2hTUxvONnFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odjH5YFCIqMwWIQPbOpSKngxGcv710EYW/0eBUCDLXsezBzCyGe5V93GjGUuoEZvwhRkMByPu/b5nu7jLO1wUX5N7xf4QSBAgd2iqv3xL3yWNr9F0kHIV2dh31+r8Yp8FV0bE+NEvEacx78ktLL2GOQI9IDPI+OBjVq4hWdOq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJhQSJJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2600AC2BCB0;
	Wed,  6 May 2026 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778090704;
	bh=W2RikdlCpHwS4MbcOM6rCR1SkRh2XHbp2hTUxvONnFA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aJhQSJJFE5JUQvF9ep/JOJ3sgtRUiFBzRjOg8LtHSQVXWAAQoKRX3kLCCsZ98NmfR
	 6nkCQh9t4c4oQWrwUQqyO4Yt/tU/KB4/LPIjG0UX3fWOpadB7l4eg3Qf5Bl+4oa5pK
	 DU5PcHev2TaWuQaRTafeztsoWuDdbwOfi1I8RS+QTBXSXEtaKniFpY4fbFp4ol6R8j
	 F5mDs2+Wd9XGU8M2AIv3cdMmBj9+kxZUwzZw2yVTSLZNmLPAuAqvgPiwUZ58wgEqku
	 aOcq/tnszTUzamX7FD3Tl/39nPC2v2zmZuFSNvj+SItstbCpn86K7DAqg98I7vEEYx
	 NgIqBQiGQOJcw==
Message-ID: <b6ac0dbe-190e-4d71-9f8d-14ad57082110@kernel.org>
Date: Wed, 6 May 2026 12:05:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ipv4: Flush the FIB once per dev nexthop
 removal
Content-Language: en-US
To: Cosmin Ratiu <cratiu@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Cc: "horms@kernel.org" <horms@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
References: <20260506092704.150349-1-cratiu@nvidia.com>
 <20260506130129.GA665477@shredder>
 <8fea4084-c9ec-472a-b8ab-ecc87e537216@kernel.org>
 <3db4a02d61809143cc19a20cd6ff4086bb06b65b.camel@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <3db4a02d61809143cc19a20cd6ff4086bb06b65b.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 89F1F4DF219
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284987-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 5/6/26 11:53 AM, Cosmin Ratiu wrote:
> On Wed, 2026-05-06 at 10:26 -0600, David Ahern wrote:
>> On 5/6/26 7:01 AM, Ido Schimmel wrote:
>>> ... it would have been easier to review if split into
>>> multiple patches (not saying you should do it). Something like:
>>>
>>> 1. Change the various nexthop remove functions to return an
>>> indication if
>>> flushing is required, but keep doing the flushing in
>>> __remove_nexthop_fib(). Referring to these functions:
>>>
>>> remove_nexthop()
>>> __remove_nexthop()
>>> __remove_nexthop_fib()
>>> remove_nexthop_from_groups()
>>> remove_nh_grp_entry()
>>>
>>> 2. Act upon the flushing indication in the various callers of
>>> remove_nexthop() and remove the flushing from
>>> __remove_nexthop_fib().
>>>
>>> 3. Add __must_check annotations.
>>>
>>
>> +1. Always send the smallest patches possible to evolve the code.
>> Make
>> it easy for reviewers - and yourself should you introduce an intended
>> side effect.
> 
> I didn't split it as the whole thing is tightly coupled across multiple
> functions,

The authors of this code are telling you made a choice, and we are
asking for something easier to review. I spent more time than I should
have to reviewing this patch and trying to recall why I did the code the
way it is.


