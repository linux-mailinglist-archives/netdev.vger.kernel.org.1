Return-Path: <netdev+bounces-220751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902A1B487D5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307A23B8CA3
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCC2EA72A;
	Mon,  8 Sep 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="N8qUxz9G"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8532F069E;
	Mon,  8 Sep 2025 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322514; cv=none; b=m6SL+4ITQ9FKojAOC+g7b/5gZlktTgu4IW3ybWEskscv4C7VB8wxrkimQj1n3v6wJVHRmWVsZncj6s0ZqpLJx8Nzks1eRPhlBtDl0unTrMbQ2eXBvTECwKHZAG81ivG+epWeKyFQJxG2XITNKNaEyMWlD1VgFOmiVXJxozKZD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322514; c=relaxed/simple;
	bh=MhMgcHHloqdsvpGVS4XMV4EJ/KcTgELqX1VRtRedv10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZKb7DugkDm0mUgfjdtyFF4SkgKBlvJku65IWirjEYwza+V/vqHRUaUlQWasfiXY75zOjsQV8qb75JWBVbyNqz38VV8PLYAg3XGotaJM05psYyfz6MR7wcJh+sCtYnV6gov8vMInUxQcD5WhqpSajg76C06hVeURpJ0ERcGSNdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=N8qUxz9G; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757322503;
	bh=MhMgcHHloqdsvpGVS4XMV4EJ/KcTgELqX1VRtRedv10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N8qUxz9GarM32aXEpFClgSN1X9YmPiA2/Cye3eCjKaljfvBxPtLiIRTL2SM0SAjf4
	 VQdvRKI49OiqfOQ9IAHUsCg3Y4mwaUH61Eyy8qZCH0OeU5xRiPoDSYVIvphO5QCnsu
	 WIoChJDkzakpAcbjpqctgm0FtGeW/0c/tQsNZlC7cSkOwSvww4M8EBOHGCPr/w5bPo
	 9XsIaarbsNVskh/KaMCWXvM5jBPQDWatUyAMBPjGJHv0cHtbFSxcAjrc3V0w01Eqg0
	 Go8a1IztY6bbh2sak9PiIM8uVIDdqoKplkrIB3UrgsSfjr/Nxse0wvCLx0mJJ5mZff
	 wyKaKmCtOJehQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 754826000C;
	Mon,  8 Sep 2025 09:08:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 4D922200C27;
	Mon, 08 Sep 2025 09:08:17 +0000 (UTC)
Message-ID: <f574e4b9-d0ea-46ef-bbed-8f607ab7276f@fiberby.net>
Date: Mon, 8 Sep 2025 09:08:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/11] tools: ynl-gen: generate nested array
 policies
To: Johannes Berg <johannes@sipsolutions.net>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-2-ast@fiberby.net>
 <e24f5baf-7085-4db0-aaad-5318555988b3@intel.com>
 <6e31a9e0-5450-4b45-a557-2aa08d23c25a@fiberby.net>
 <c1a4da4cb54c0436d5f67efacf6866b4bc057b3e.camel@sipsolutions.net>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <c1a4da4cb54c0436d5f67efacf6866b4bc057b3e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/8/25 7:54 AM, Johannes Berg wrote:
> On Sat, 2025-09-06 at 14:13 +0000, Asbjørn Sloth Tønnesen wrote:
>> Johannes introduced NLA_NESTED_ARRAY and the NLA_POLICY_NESTED_ARRAY()
>> macro in commit 1501d13596b9 for use in nl80211, and it's therefore
>> used in net/wireless/nl80211.c, but outside of that the macro is
>> only sparsely adopted (only by mac80211_hwsim.c and nf_tables_api.c).
>>
>> Wireguard adopts the macro in this RFC patch:
>> https://lore.kernel.org/netdev/20250904220255.1006675-2-ast@fiberby.net/
> 
 > I think the general consensus now is that preference should be towards
 > arrays being expressed by giving the attribute holding the array
 > multiple times, i.e. each occurrence of an attribute holds a single
 > entry of the array:
 >
 > [header][type1:a1][type2:b][type1:a2][type1:a3]
 >
 > resulting in an array
 >
 > [a1, a2, a3] and a separate value "b",
 >
 > rather than a nested array:
 >
 > [header][type1:[1:a1][2:a2][3:a3]][type2:b]
 >
 >
 > Of course if each entry has multiple values, then you'd still need
 > nesting:
 >
 > [header][type1:[subtype1:x1][subtype2:x2]][type1:[subtype1:y1][subtype2:y2]]
 >
 > would be an array
 >
 > [[x1, x2], [y1, y2]].

Thank you for the consensus write up. Should we prohibit indexed-array with sub-type
nest for families with a genetlink protocol?

It is currently only used in families with a netlink-raw or genetlink-legacy protocol.

> I can't get rid of the nested array types in nl80211 though, of course.

Wireguard is already in the same boat. It is not using the term, nor the policy,
but it is doing the validation in the handler through, so it can adopt a
NLA_POLICY_NESTED_ARRAY() policy, instead of a plain '{ .type = NLA_NESTED }'.

Comments on the protocol in include/uapi/linux/wireguard.h:
 > WGDEVICE_A_PEERS: NLA_NESTED
 >   0: NLA_NESTED
 >     WGPEER_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
 >     [..]
 >   0: NLA_NESTED
 >     ...
 >   ...

Given that, as Jacob pointed out, there are more families with nested arrays in
their YNL spec, than those using NLA_NESTED_ARRAY, then it appears that there
are more families already in the boat.

