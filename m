Return-Path: <netdev+bounces-232233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71AEC03061
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BF81A66336
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972ED26E71B;
	Thu, 23 Oct 2025 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="hrKdJO17"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33C1DF99C;
	Thu, 23 Oct 2025 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244648; cv=none; b=VatJbuXi3O1cBOu8pUM0ulFyoDe0KvW52HgivePRTdZA2faZi+kJLQ5/k7UDgdQR0KpA57SMKv90XylFOqHv+lUbM/+YxmZYiJv6/XrzCHUhZN+YPHNoA1gZOlvVcYKNQg//FIr5M7Y7b7ypIhdVQ2SiGl4AutQw7FfKW1Vmspc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244648; c=relaxed/simple;
	bh=7I8ssdDIfyyA0rxSfkVC5GFDGKwSXlLknE2fYx3d3NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cezmy2TdUsszzUBKm8X0blKIZBtgT2jfxTuV7h6wkQXkSFD7Mdzr+dNyBdIMUlJqyv08AXP/qHtJNccHSFulwF7PuXdVMGQJ4/MJlLqDbFaGtz7z09+K6Wf2hOa9VorrIxIgffqPaRZ+OzQ1BApprtlJ4Ib82AD61Gu8OKljsU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=hrKdJO17; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761244635;
	bh=7I8ssdDIfyyA0rxSfkVC5GFDGKwSXlLknE2fYx3d3NY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hrKdJO17+K/9Uw7S6J9qiav7rgG9HsK+RUq8gdaZU/+fLDtkwU62uq032qC04Z6J4
	 8Q7CLZX374JHbTvHVeaLsq9EfkSpn8a8ZpJWtxoN66fP34xKfNG6XpaT6ODnxjeGZ/
	 8YPTxjDYckTruqZcJ2/D7MBovMEzXwwcaE3zplHkCFUafUvoCu8mci5BonOWEd/kbv
	 0pOTk59ob51F4x6tozFo6d1+hWNs98KB/8bTqi3tmU1eTF+EbqdwtuUZnO8iWHm4a1
	 d5lfiGNiSkbC+K4cj30p/dp0MADQ2MswtYdVELkXl1fRJ7BiOjQ39+B2vbzPBOrBXE
	 XtKbvbXR3OjTg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 38C1A600BF;
	Thu, 23 Oct 2025 18:37:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 0ACEB201BFA;
	Thu, 23 Oct 2025 18:37:10 +0000 (UTC)
Message-ID: <f35cb9c8-7a5d-4fb7-b69b-aa14ab7f1dd5@fiberby.net>
Date: Thu, 23 Oct 2025 18:37:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] ynl: add ignore-index flag for indexed-array
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Chuck Lever <chuck.lever@oracle.com>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20251022182701.250897-1-ast@fiberby.net>
 <20251022184517.55b95744@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20251022184517.55b95744@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/25 1:45 AM, Jakub Kicinski wrote:
 > On Wed, 22 Oct 2025 18:26:53 +0000 Asbjørn Sloth Tønnesen wrote:
 >> This patchset adds a way to mark if an indedex array is just an
 >> array, and the index is uninteresting, as previously discussed[1].
 >>
 >> Which is the case in most of the indexed-arrays in the current specs.
 >>
 >> As the name indexed-array kinda implies that the index is interesting,
 >> then I am using `ignore-index` to mark if the index is unused.
 >>
 >> This adds some noise to YNL, and as it's only few indexed-arrays which
 >> actually use the index, then if we can come up with some good naming,
 >> it may be better to reverse it so it's the default behaviour.
 >
 > C code already does this, right? We just collect the attributes
 > completely ignoring the index.

In the userspace C code, for sub-type nest the index is preserved
in struct member idx, and elided for other sub-types.

 > So why do we need to extend the spec.

For me it's mostly the naming "indexed-array". Earlier it was
"array-nest", then we renamed it to "indexed-array" because
it doesn't always contain nests.  I think it's counter-intuitive
to elide the index by default, for something called "indexed-array".
The majority of the families using it don't care about the index.

What if we called it "ordered-array", and then always counted from 1
(for families that cares) when packing in user-space code?

 > Have you found any case where the index matters and can be
 > non-contiguous (other than the known TC kerfuffle).

IFLA_OFFLOAD_XSTATS_HW_S_INFO could be re-defined as a nest,
IFLA_OFFLOAD_XSTATS_L3_STATS is the only index atm.

IFLA_INET_CONF / IFLA_INET6_CONF is on input, but those are
also special by having different types depending on direction.

I found a bunch of other ones, using a static index, but they
can also be defined as a multi-attr wrapped in an additional
outer nest, like IFLA_VF_VLAN_LIST already is.

 > FWIW another concept is what TypeValue does.
 > "Inject" the index into the child nest as an extra member.
 > Most flexible but also prolly a PITA for user space to init those
 > for requests.

Same as is done in the userspace C code for indexed-arrays with
sub-type nest. For most families it doesn't matter if the C code
inits the index or not.

