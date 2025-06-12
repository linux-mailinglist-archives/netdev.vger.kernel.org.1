Return-Path: <netdev+bounces-196869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E85AD6BDA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D433A5B76
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A273E22DA0A;
	Thu, 12 Jun 2025 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="C0C3zo2+"
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (unknown [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D42253EA
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719411; cv=none; b=j+Caa3duZYJqCwVbtf9Dk6EagiB0nX7aSFDAWUhIYSdQZ1JpkFfxdTJWfJDqFMweHPJBy0L26Teh3eTHweJkt6MoC6bMqlb5PAKH9/TqIsDp6bUSkSwsoGmXkvJ4oVRi/7Z7ImaIUjZmtHJCUp0uzr9CrH+pwOl7jWeVGJV5bOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719411; c=relaxed/simple;
	bh=5d3jN3fn+I5Q7QYVsDdXTjPnMvpF2p/kdNCrBj08FiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn6JYetGDuMobjNXuPRbnhU4FkohJ4mTGPlIwrguAcRoA3+0sct4ESAFJv0UYLPVPWN7l6jBykTdKHHP6mOYdjgi30QqbADILAQ1Q4R3FhO8Rzw8p6ErCufeOr/a8s5w+BcnZRztrYnd0wLLXBZzxAYL8LCYXVJ795/6OsPBDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=C0C3zo2+; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received; s=oak1; t=
	1749718951; x=1750582952; bh=5d3jN3fn+I5Q7QYVsDdXTjPnMvpF2p/kdNC
	rBj08FiY=; b=C0C3zo2+6pwSukA00NpMmz5OyP1ZI0U2/3Y4PhMTXFogHrXHNVZ
	o+0PMbrTP0WAxF+Sf4LgX1R9KT4Qww3c0iXWQNOzqdyMLPzimoelzF7SUi7Z8Rzp
	8WLyg5DJG/8WN+McyfHZ3R1rggB9e2AxFh2WYPNgQaSkwjczbXa5x4hiPoJNzAzJ
	bRMSh0wCKwVDYm5mJjNy94iTQbCgeMLLrkqDpWWq9kvzqGtp0qJtW4nLf0mCeJ00
	5jTfuiT+nXYh9Iat/AKE4ILvjoMnoj8j4P+BAjWiM3+0SI+XljWxtknNKQM4hHbW
	ynwNZRXP4tEyDo8etwUMXeR1fmkWtJbUWPQ==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: from Antony2201.local (hal.connected.by.freedominter.net [91.132.42.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by oak.phenome.org (Postfix) with ESMTPSA;
	Thu, 12 Jun 2025 11:02:30 +0200 (CEST)
Date: Thu, 12 Jun 2025 11:02:28 +0200
From: Antony Antony <antony@phenome.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Aakash Kumar S <saakashkumar@marvell.com>, netdev@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, akamaluddin@marvell.com, devel@linux-ipsec.org
Subject: Re: [PATCH]   xfrm: Duplicate =?utf-8?Q?SP?=
 =?utf-8?Q?I_Handling_=E2=80=93?= IPsec-v3 Compliance Concern
Message-ID: <aEqXpFSawrMOO25V@Antony2201.local>
References: <20250609065014.381215-1-saakashkumar@marvell.com>
 <aElfx2P9VBN/q0A6@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aElfx2P9VBN/q0A6@gauss3.secunet.de>
X-Mutt-References: <aElfx2P9VBN/q0A6@gauss3.secunet.de>
X-Mutt-Fcc: ~/sent

On Wed, Jun 11, 2025 at 12:51:51PM +0200, Steffen Klassert wrote:
> On Mon, Jun 09, 2025 at 12:20:14PM +0530, Aakash Kumar S wrote:
> >         The issue originates when Strongswan initiates an XFRM_MSG_ALLOCSPI
> >         Netlink message, which triggers the kernel function xfrm_alloc_spi().
> >         This function is expected to ensure uniqueness of the Security Parameter
> >         Index (SPI) for inbound Security Associations (SAs). However, it can
> >         return success even when the requested SPI is already in use, leading
> >         to duplicate SPIs assigned to multiple inbound SAs, differentiated
> >         only by their destination addresses.

Is this an issue in xfrm stack without hardware offload? Does it affect packet
flow? It seems SA install will allow non uniqe SPI for incoming, even
after this. Which is the correct behaviour.

I have a feeling this is an issue due to hardware implementer's choice
of only support one option from RFC 4301 section 4.4.2?

> > 
> >         This behavior causes inconsistencies during SPI lookups for inbound packets.
> >         Since the lookup may return an arbitrary SA among those with the same SPI,
> >         packet processing can fail, resulting in packet drops.
> > 
> >         According to RFC 6071, in IPsec-v3, a unicast SA is uniquely identified
> >         by the SPI alone. Therefore, relying on additional fields
> >         (such as destination addresses, proto) to disambiguate SPIs contradicts
> >         the RFC and undermines protocol correctness.

> 
> This is not quite right, RFC 4301 says:
> 
> If the packet is addressed to the IPsec device and AH or ESP is
> specified as the protocol, the packet is looked up in the SAD.
> For unicast traffic, use only the SPI (or SPI plus protocol).
> 
> So using the potocol as as lookup key is OK.

That’s correct—the commit message should not reference RFC 6701. I would suggest instead referring to RFC 4301, specifically sections 4.1 and 4.4.2. These sections describe the three SPI uniqueness constraints allowed by the architecture for the incoming path.

- Unique SPI
- Unique (SPI + protocol (AH/ESP) + destination IP of the incoming SA)
- Unique (SPI + protocol + destination IP + source IP)

The IPsec architecture RFC 4301 explicitly allows all three options for 
incoming SAs, which is why I don’t believe anything is currently broken in 
the data path.

So it is not complaince issue. In my opinion, RFC 6071 is not standard RFC 
to be complaint with. It looks like an odd RFC among IPsec standards, what 
is IPsec-v3? IPsec IMHO should refer RFC 7296, 4303 and 4301 and related 
RFCs. We can also take this on IETF mailing list, instead of netdev.

As for SPI allocation, it is indeed permissible to be restrictive, as proposed by this patch.
However, section 4.4.2 of RFC 4301—which indirectly governs SPI 
allocation—is only applicable to unicast SAs.

So I’m also supportive of the patch, provided the commit message offers a 
clearer explanation and outlines what exactly is broken under the current 
behavior. Ideally also how to re-produce it.  This is important. I would 
love to see generic hardware supporting all 3 cases above, just like xfrm 
implementation.

PS: I am ccing more IPsec experts.
latest version of the patch is at:
https://lore.kernel.org/all/20250612055017.806273-1-saakashkumar@marvell.com/

-antony

