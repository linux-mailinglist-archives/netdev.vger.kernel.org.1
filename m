Return-Path: <netdev+bounces-73746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BB685E18E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E899284573
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9265B80629;
	Wed, 21 Feb 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pIz92E/z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF174F8AB
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530082; cv=none; b=O+d0oG7YObgDFTgC0pd4RxOtN7zvz1vpLkEAI7/3yBSRchIi1p6l6JEavIRtY9arM7jZEPvVquXt7WokCwnH4IenQENb8GkF3yTSoiK3hx4Coqm3hhjQbQiLjzyebRH16mPTNaxgOrbmEGWk6oowN7Wx0fpuW3/KzYBOseJyauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530082; c=relaxed/simple;
	bh=iC/8RO1TBZVhZEvv1XKNeECF3fCYsqvXMGYUH+ajqsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMs6b03vZBCcOLCxTYO/BMx9gFV2Ax/1pRLyTIKbIXZWL652792YjHHqaYPjcVtDnCIR57pjRW4KzoeaaAMNFHMWGoITnnDF6aWQnMueilpv+kG1aD1095Z3ukeB8pzHVPR03TYDq5XINq0pnY2EL4TbqjadA8alxPfVC/Jm4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pIz92E/z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GvG0RSRaZqDia7OUqoLQ0ErZrf6V4r0bG22t9ZizR8M=; b=pIz92E/zrlbMKgokofL3uqnhPE
	mYYNrcxgNXE0eFQo/Tc+LnvlcxGvgK68gfgN5YApMF7FrAa8angPTIYH3sCt8SG1aEXQFb2Xbvhz9
	4m0hqhMFGEQOLkXCwiCiciptQ3vqd7pIEUnfkJyfHyUFvotPS54tm6fp8FBkm7MvoQkA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rcoir-008NVO-Ix; Wed, 21 Feb 2024 16:41:25 +0100
Date: Wed, 21 Feb 2024 16:41:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] ethtool: ignore unused/unreliable fields in
 set_eee op
Message-ID: <7472bddc-86ad-45fb-8337-4ee21ea7a941@lunn.ch>
References: <4806ef46-a162-4782-8c15-17e12ad88de7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4806ef46-a162-4782-8c15-17e12ad88de7@gmail.com>

On Wed, Feb 21, 2024 at 08:24:40AM +0100, Heiner Kallweit wrote:
> This function is used with the set_eee() ethtool operation. Certain
> fields of struct ethtool_keee() are relevant only for the get_eee()
> operation. In addition, in case of the ioctl interface, we have no
> guarantee that userspace sends sane values in struct ethtool_eee.
> Therefore explicitly ignore all fields not needed for set_eee().
> This protects from drivers trying to use unchecked and unreliable
> data, relying on specific userspace behavior.
> 
> Note: Such unsafe driver behavior has been found and fixed in the
> tg3 driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  net/ethtool/ioctl.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 1763e8b69..ff28c113b 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1513,20 +1513,13 @@ static void eee_to_keee(struct ethtool_keee *keee,
>  {
>  	memset(keee, 0, sizeof(*keee));
>  
> -	keee->supported_u32 = eee->supported;
>  	keee->advertised_u32 = eee->advertised;
> -	keee->lp_advertised_u32 = eee->lp_advertised;

This overlaps with the last patch in my series, which removes all the
_u32 members from keee. They are no longer used at the end of my
series. I added this removal patch because i kept missing a _u32, and
i wanted the compiler to tell me.

	Andrew

