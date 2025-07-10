Return-Path: <netdev+bounces-205832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D410B005C6
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 16:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700964802F2
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732E2741AF;
	Thu, 10 Jul 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oA07TTmn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B802273D9D;
	Thu, 10 Jul 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159024; cv=none; b=HlwboZYAPRBC8XyFOxqpg6zaqk9LbtIG/L3v2BxtDAvhP41UJl7UjNUThpuHYC9RGewrw5KW47BH2tnimZ5BmXpMl3LAFeaGWGKzFH34hmGo0WgDJIpyme00w1KYm/nKsqFfgI8Lr50NR5rDdAGXaqq5N0L5UTwQj7RoQRj5nYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159024; c=relaxed/simple;
	bh=2kQjfdPQxPBtEb3KeI6AnatP76yOBKS+FnpqYuABIHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBNzDgjZxEZ2AQU5nWwfCzYjwM4PzP38oat0QIKLoioZHKFOAJNG3J0WqtP2uhW87nLwwy6lX/xn8OsM4xnsXBikLMh9Thc1uPyxM6btY8qn/DM3LU+Pv+a3pSFqFH4VgLvMulaVWEJSXWiI49bjaDG5663sdVRqlxGIxHVOW8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oA07TTmn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7Ww2cOwuDGEIS/M+c7Fma28U5zkeof425wzCnG+SO8E=; b=oA07TTmnmPvb1XkbrWu1962aKZ
	ypVuiaK8o5am4BXurMcczrSNY7FUgDuUyQ4PfiVJpw4Zy08EQr4Diga8aMhcY+x7X/pVBciNDj5KN
	sUBZa5/KEWfi+XDkp43NdzAchonbKlYdY90D2yPHGKMO7JhRYgahPn1UQ6QaJgsIjGJE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZsbE-00180w-KA; Thu, 10 Jul 2025 16:50:12 +0200
Date: Thu, 10 Jul 2025 16:50:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Wei Fang <wei.fang@nxp.com>, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net-next 3/3] net: fec: add fec_set_hw_mac_addr() helper
 function
Message-ID: <c7c297de-d19c-4861-af85-b43b15f43d1a@lunn.ch>
References: <20250710090902.1171180-1-wei.fang@nxp.com>
 <20250710090902.1171180-4-wei.fang@nxp.com>
 <20250710155728.363bcfd6@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710155728.363bcfd6@fedora>

> > -	writel(ndev->dev_addr[3] | (ndev->dev_addr[2] << 8) |
> > -		(ndev->dev_addr[1] << 16) | (ndev->dev_addr[0] << 24),
> > -		fep->hwp + FEC_ADDR_LOW);
> > -	writel((ndev->dev_addr[5] << 16) | (ndev->dev_addr[4] << 24),
> > -		fep->hwp + FEC_ADDR_HIGH);
> > +	fec_set_hw_mac_addr(ndev);
> 
> It's more of a personal preference, but I find this implementation to
> be much more readable than the one based on
> 
>   writel((__force u32)cpu_to_be32(temp_mac[...]), ...);

It also avoids the __force, which is good.

	Andrew

