Return-Path: <netdev+bounces-183887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB92A92BA3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDF9465AB7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977F01FF1CF;
	Thu, 17 Apr 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vvurRVWW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46218A926;
	Thu, 17 Apr 2025 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917646; cv=none; b=p1CFqhCkTHPV7+gijR2Eyyj76vYB5PeYD5AVMcyxIbqnA50FY++zmYsG3oEwdtQUqOfS6H/vuNpoLbpUBJxiuY1zVzyMNsr0SZc7z2Rmkj9lkaeLHhlbIJ7VMZYEpWBZqlExKbF9UAZGTFzhqNUe7q6hoOVIbxYvqD+CMkkIpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917646; c=relaxed/simple;
	bh=NdXxvAvLKcHVz1+GSvuMhsUafy22FcYZdxHS61VgTrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVdhfDXg9TwbhQmA/LkCKJ07Em9GziRih0AKgFl+WqLN2/Ts3H3vi7QHbv+Zm7FuitL5VxQNq0/R3DMUgjikYJlH9c0+WOk+sanVt56iG99JhfDWePsXv4O850QZ5udow2nl0uOL13X7X29C5JNKG7xQ1SNoUICaUsJEmc/+Edg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vvurRVWW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gU8fYskhPIlS367wmAVX7/kmDGbQY6HIOWziUTpcsyI=; b=vvurRVWWevlR/JmkMcVRMiNfOP
	iV0KTd2bEpJD0ulRUiRyIIfhLJbxP4hM2S3AZ5Q2W6Sigt8+tIKxi5pzWUOBPX9ou9XVM1FWOHJgz
	K+OxbyV9szKD9XZxVyg33G3PetLoAsW8MzpzNUB+9MT2bSeyYgK1ecJznzMNFZ2rnxVo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5Umm-009p3w-NO; Thu, 17 Apr 2025 21:20:32 +0200
Date: Thu, 17 Apr 2025 21:20:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-phy: remove
 eee-broken flags which have never had a user
Message-ID: <6a3d0502-01dd-4ffa-aab3-3bf97a4bc2f0@lunn.ch>
References: <ee9a647e-562d-4a66-9f9b-434fed05090d@gmail.com>
 <aacd2344-d842-4d10-9ec8-a9d1d11ae8ed@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacd2344-d842-4d10-9ec8-a9d1d11ae8ed@gmail.com>

On Tue, Apr 15, 2025 at 09:55:55PM +0200, Heiner Kallweit wrote:
> These flags have never had a user, so remove support for them.

They have never been used, but they are a logical description of the
bits in the EEE registers. Do we think vendors have gotten better with
EEE and are less likely to get it wrong at these higher speeds? Are we
deleting them to just bring them back later? I don't know.

I don't think there is any maintenance burden from them, so i would
just leave them?

	Andrew

