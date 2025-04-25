Return-Path: <netdev+bounces-186122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174EFA9D402
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4AB3B7E9F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0A622424E;
	Fri, 25 Apr 2025 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kUQV5wnb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61A52F88;
	Fri, 25 Apr 2025 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615721; cv=none; b=uECvqoJqg0l0uWLkipaRWqx44SOtzlitU4O/MnVen1FoFcH7jeUD0PQHXpXYtxKO9699rv8ckZ7Guh8PrUIQaegfBfu2EyfMSwTfPGHDl8SI214/gN+9FiDSJeTqrfc0SxSUpvysBHJHBAmlNYR6cHpTlHyrvtkBOpbcj2rOqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615721; c=relaxed/simple;
	bh=AugyOTmnQgGbxi+Pd/KHpVFSWaroSzr5iy8gExto3L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaSMAvgwNa7fxld82eY00OCtURutrKWtg4O5InzCIH13PhWAUQ9DPNdwUjc0iVP8L86oWi+yKt1/fraxdmheGmx3GtCQ/W4IUV28HBh2ujIbLFh64AGLsrmoSC2L/8RxIQd1/1Np0acDmjsLTVCg+BCh4szicc8gxNCmrpG4WDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kUQV5wnb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+zp35SpImKTbZkH8iLkDJo1PwX/FzjZ/Dl0Q1lGceuA=; b=kUQV5wnbRaqcyfDF6s9ueGO+Up
	3fEGE1C4z1YG70GCvoLA6vgZAyjArszzEycjex+qwJ8kHN+TzGP4Tm/dV1ARxuBNaWbuFXjXoVXrS
	h8ZLKc37TYMAyehPtClfUgs0AxVxBtE9+7svQs508fdYB/bWY6wCjOcerGUSi0+7rfE0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u8QO1-00Ad0q-CG; Fri, 25 Apr 2025 23:15:05 +0200
Date: Fri, 25 Apr 2025 23:15:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: george.moussalem@outlook.com
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: qca8k: fix led devicename when using
 external mdio bus
Message-ID: <921b4a1e-caed-47a2-b5ed-d78cf67c5757@lunn.ch>
References: <20250425-qca8k-leds-v2-1-b638fd3885ca@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425-qca8k-leds-v2-1-b638fd3885ca@outlook.com>

On Fri, Apr 25, 2025 at 01:19:28PM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The qca8k dsa switch can use either an external or internal mdio bus.
> This depends on whether the mdio node is defined under the switch node
> itself and, as such, the internal_mdio_mask is populated with its
> internal phys. Upon registering the internal mdio bus, the slave_mii_bus
> of the dsa switch is assigned to this bus. When an external mdio bus is
> used, it is left unassigned, though its id is used to create the device
> names of the leds.
> This leads to the leds being named '(efault):00:green:lan' and so on as
> the slave_mii_bus is null. So let's fix this by adding a null check and
> use the devicename of the external bus instead when an external bus is
> configured.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

Before merging this, i think we need to finish the discussion here:

https://patchwork.kernel.org/project/netdevbpf/patch/20250425151309.30493-1-kabel@kernel.org/

It might be the whole internal/external bus is going away...

    Andrew

---
pw-bot: cr

