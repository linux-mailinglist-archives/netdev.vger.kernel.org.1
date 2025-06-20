Return-Path: <netdev+bounces-199813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11604AE1E5A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D80E3AE39F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F1F28C867;
	Fri, 20 Jun 2025 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="meFjEi4T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3381CAA6D;
	Fri, 20 Jun 2025 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432819; cv=none; b=FJeG7Hf8PCP043SSPaR5Z/mZgsh3J+BZrtLXFshUgSa8epeB99zTaIEFI83zk93d6GGoPfAFrWMUfVF9ZYaZodWrIzoApkVYeWUrCOqe52jLTFlmn2V/kswqCzx/ukbONQruVOVp2YS8NQj2vQ1OjTCxftbJtVkm7l/XXebfZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432819; c=relaxed/simple;
	bh=Bjw4igONTZMN0gbQCYTC4dWBbsRKO814NFvkJmuqDJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1txBpZvyJAfPqK2V0PRrSlRSwd4uSQz890/63vWrL6QzmVmwv1zuXE6s90+GFQtTRNVZKbDpj6xrUcQ2x7ZmR/MtlrQgIVgnfRpM6j/+OTbOsU0iUmg5nlfRYD1+pk+LZ3SzjKnEwlnIgvAooF0Dh3izcyguR8t4fewHnOa1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=meFjEi4T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=wC4XMhb/ugJMHtgboBDIqG7VsfLdmfyiCDLnrrMdqgw=; b=me
	FjEi4TjbSs2bqGS2UkhmQI6dIPZlDEJQi52eJZ9fRzQinJrdDRref7cOviQ4XhgkNpx9n0+MrHl5Y
	cMVVW/N+t//bnVy6eCvqXUX45ZpHdLcXnk3AWEauvVkq2dvwdbG1+lFzKjrTSo4KVnB3m9fHPKnTr
	3pLyTPjKZgs1W7U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uSdX5-00GWJ2-Gq; Fri, 20 Jun 2025 17:19:59 +0200
Date: Fri, 20 Jun 2025 17:19:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH 2/3] net: phy: bcm5481x: Implement MII-Lite mode
Message-ID: <f8662437-58ea-4ae5-8fbc-eb06e22f5a1c@lunn.ch>
References: <20250620134430.1849344-1-kamilh@axis.com>
 <20250620134430.1849344-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620134430.1849344-2-kamilh@axis.com>

On Fri, Jun 20, 2025 at 03:44:28PM +0200, Kamil Horák (2N) wrote:
> The Broadcom bcm54810 and bcm54811 PHYs are capable to operate in
> simplified MII mode, without TXER, RXER, CRS and COL signals as defined
> for the MII. While the PHY can be strapped for MII mode, the selection
> between MII and MII-Lite must be done by software.

Please could you say more about what mii-lite is. Rather than adding a
bool DT property, i'm asking myself should we add interface mode for
it?

Is it a mode of its own? MII normally means Fast Ethernet, 100Mbps. Is
that what MII-Lite supports? How does it differ from RMII? Should we
be calling this PHY_INTERFACE_MODE_LMII?

	Andrew

