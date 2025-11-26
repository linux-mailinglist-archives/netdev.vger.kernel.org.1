Return-Path: <netdev+bounces-241904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7501DC8A0DD
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4D67355F70
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E6C299ABF;
	Wed, 26 Nov 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ZCz+y+EK"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B974287272
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764164003; cv=none; b=OPY0OnOVGEkVmFldxsKx70BnzaLP9XcWteBz4IAef5Y6Ppmq/3kmW+fmOWG6DU52vm4ZQZfKaz+Kr070v351+JuqxPpla6H22b15540y0v16ei26lMYrvGBIpFpkBuPMho/7o5MkYBZGiOqzlJeRchsaC2vitk0VZ80bRwQg1i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764164003; c=relaxed/simple;
	bh=8xJH7M3jDOO5XRROrKa/hhCD9agYwzD+bt2hH4MXlEM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NVueosbCIHXppKY2WBtUp98OIDMvo9NFu5iVsc2G4qqzGxjk6pisBFwD7MRn6rWoESdHagLJkEZ3e7aiC5wJtPP3QWqsr3xrPPza/U0/xAQuvjDkBfGeUZfcOHok0iO54/sSDf+LdgTU96J/7bt+sEtp4NvDh6YfBcZB+ivj1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ZCz+y+EK; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764163997;
	bh=8xJH7M3jDOO5XRROrKa/hhCD9agYwzD+bt2hH4MXlEM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ZCz+y+EK5VWPObfO9XZ89MAh9G5CZeJ4HhdLcIG8jpc5q3//pFuGLvPNMVhi4Z6Dg
	 NL5kxSDR179G2YvtRMUjv1fEG/F7XoSXen7JopXjBR/N6MIUn0DCojZuoyrTKCVgSD
	 pXK3pQuHjZ+BJXMiqiran+3R44nhvYZduqvkh5CzAFL0I/06DpLUD+FAL3pWANpX85
	 qIIrRVdRqu2G/A6adjL8Z1KgIOI6CFM3pR8bN0QbOx3qVq/O5cNfWfBgd+ktsy7WJE
	 X3bt8ADcFGvtDvFG1thI9lRvpUMrhJJ3batGriXCoUA/ZX/LCoK76aEP7Kd6AwOlpq
	 kT2xgQTSfgQCw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7FD2C600FF;
	Wed, 26 Nov 2025 13:33:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 4A0DE201077;
	Wed, 26 Nov 2025 13:32:22 +0000 (UTC)
Message-ID: <43630b97-4dd4-423a-97e3-ca6aa3b56ad4@fiberby.net>
Date: Wed, 26 Nov 2025 13:32:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Subject: Re: [PATCH net-next] netlink: specs: add big-endian byte-order for
 u32 IPv4 addresses
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Yuyang Huang <yuyanghuang@google.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251125112048.37631-1-liuhangbin@gmail.com>
 <8564b02f-18f9-4132-ab69-5ee1babeb18c@fiberby.net> <aSaf1D-N5ONmnys8@fedora>
Content-Language: en-US
In-Reply-To: <aSaf1D-N5ONmnys8@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/26/25 6:36 AM, Hangbin Liu wrote:
> Hi,
> On Tue, Nov 25, 2025 at 05:03:13PM +0000, Asbjørn Sloth Tønnesen wrote:
>> I also checked how consistently defined the fields using the ipv6 display helper are,
>> and it looks like they could use some realignment too. Obviously not for this fix.
>>
>> git grep -C6 'display-hint.*ipv6$' Documentation/netlink/specs/
> 
> The ip6gre spec shows
> -
>    name: local
>    display-hint: ipv6
> -
>    name: remote
>    display-hint: ipv6
> 
> The dump result looks good.

Those two are defined in linkinfo-gre6-attrs, which is declared as a subset-of
linkinfo-gre-attrs.

In linkinfo-gre-attrs they are declared as:

-
   name: local
   type: binary
   display-hint: ipv4-or-v6
-
   name: remote
   type: binary
   display-hint: ipv4-or-v6

I have tested with deleting one or the other's display-helper, and at least
in cli.py, this kind of display-hint overloading works.

> So for others ipv6 field, what alignment should we
> use? Should we add checks: min-len: 16? Do we need byte-order: big-endian?

IPv6 is always big-endian, the marking first becomes needed when/if we make
them an u128 type. Until then it would just be nice if either all or none
of them had the big-endian marking.

I prefer exact-len over min-len. The current tally is:

$ git grep 'len.*: 16' Documentation/netlink/specs/ | cut -d: -f2- | sed -e 's/^ *//' | sort | uniq -c
       7 exact-len: 16
       5 len: 16
       6 min-len: 16
(assuming that only IPv6 has a length of 16)

"len: 16" as used in ovs_flow's ipv6-src and ipv6-dst only works because they
are struct members, not attributes.

