Return-Path: <netdev+bounces-232245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CDCC0322F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3EE3ACD31
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576C634B41E;
	Thu, 23 Oct 2025 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NY8avjKB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F722773F7;
	Thu, 23 Oct 2025 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246462; cv=none; b=YfxKjlU5/tyOc3OcHjCEKh1fCVzxbiZ84QGb0WjHoNtwPBydIcZY8fOjytePFotKK9gurIRQEani2KzUsTGqPoT8jGX1mJnobD19l3FvxHzfuibL1o1f7rLe15zjxe3giScXhEKLsOTi9KjMO2VhObTjirdrawrE38LbdVM0OI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246462; c=relaxed/simple;
	bh=3x+qJWsQ2ROHmhDi9RWoQ+itit3OVqimyz6qxumZtXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIUFN7K3okPRhsWwiUJmnn8eqD9eXGGkPGTXPe5LS6IRuI95HWWLeLlYvteJ8cW2QF84sZfpfsBULFYr/VfYLhslKGMk+juLNM5rXKDEzfRbiDGVO4zgVlAGkFFEGyqk8k24xFkyIt9IiNjkxmFFkr2+AHRinIbUcxObrKSwqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NY8avjKB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=0lDCHKQYR0zGU0/u6ys1g99RZCQjr8fVoXQ2lkLt7fE=; b=NY
	8avjKB5C2MRj5p4Ye9YvXk9lvuLNmkiXGQFRa1yjvnn9v9DgIYActvJGjQvnsLRzJRJdWS4rcbqSJ
	xxJ9IVY2sfNBhooD/ZQmUukNfc9W2Dfggk402z8wr5w0XwHOD9ui6WoAPXVVBobmIrOTM/WfuaYZT
	qgoEK5x0NWGVl5E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0en-00Buko-UR; Thu, 23 Oct 2025 21:07:29 +0200
Date: Thu, 23 Oct 2025 21:07:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH net-next v3 2/5] net: macb: match skb_reserve(skb,
 NET_IP_ALIGN) with HW alignment
Message-ID: <ef986d47-10ed-49af-9576-b0c1cda7cc5b@lunn.ch>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-2-af509422c204@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251023-macb-eyeq5-v3-2-af509422c204@bootlin.com>

On Thu, Oct 23, 2025 at 06:22:52PM +0200, Théo Lebrun wrote:
> If HW is RSC capable, it cannot add dummy bytes at the start of IP
> packets. Alignment (ie number of dummy bytes) is configured using the
> RBOF field inside the NCFGR register.
> 
> On the software side, the skb_reserve(skb, NET_IP_ALIGN) call must only
> be done if those dummy bytes are added by the hardware; notice the
> skb_reserve() is done AFTER writing the address to the device.
> 
> We cannot do the skb_reserve() call BEFORE writing the address because
> the address field ignores the low 2/3 bits. Conclusion: in some cases,
> we risk not being able to respect the NET_IP_ALIGN value (which is
> picked based on unaligned CPU access performance).
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

