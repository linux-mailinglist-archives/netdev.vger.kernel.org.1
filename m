Return-Path: <netdev+bounces-233970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C7C1AE33
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D777622A05
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE62262FFC;
	Wed, 29 Oct 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2a/WwHXl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95132191F9C;
	Wed, 29 Oct 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743404; cv=none; b=hFohG9GliJfJAH40VXxLinXfEbWf/kgvnE1BJ5TO7RmsQ6GbcbAzBENqvQ960Hd/mAD87QNuw2hvMl23tqpv7mY/y6NkgnRpj/nZoeIIgJCpbDw5sNSH33k9HEXphyY/G5gQZtQELY4H1TCtzF2YknVB3mfOve5y/7vZBK3gBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743404; c=relaxed/simple;
	bh=XXVdm4qZB56HCMDRrh52SXEympDTeO4eJo1Y7my8rmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODTW3Q86nrTgI6zYBKwoaYoltNMx86U+IWesMSDy11kyasVHyXd34r6Q20uQ3TOBJ/VHchveusAeqyzlk76wA2XsnbaafKPFUl+0In0Tw26vsOxoVcZjl9BCqawh1QTP04MP/A9pjNpVESKIEp3XqUScaVQpK06WtOL6tLdNIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2a/WwHXl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EHaFOsEW4OHV4iZjQzl8EwJlz/3jkuUIhirT0542vwY=; b=2a/WwHXla8jnjd3XxKrkKM0jDM
	MrLPtOsYuL95aE1Lv8bO4GI81Kb/1qRO2j3C/R04H9grEDSy7NpmP1Du0fx58eVQrnauzRIDWkda9
	aQ+nUSnNyeOQb5renPCCpQ898VW8Bmncglh9Gi7wW4Te7VXraqL2vwbvYYEHjwhp/4iY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vE5vz-00CPLc-I6; Wed, 29 Oct 2025 14:09:51 +0100
Date: Wed, 29 Oct 2025 14:09:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/4] net: mdio: change property read from
 fwnode_property_read_u32() to device_property_read_u32()
Message-ID: <ef08bee8-b171-4125-af51-b1303c577188@lunn.ch>
References: <cover.1761732347.git.buday.csaba@prolan.hu>
 <2609ecfcd2987e9d41b1e1c7c13c1b438b37e297.1761732347.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2609ecfcd2987e9d41b1e1c7c13c1b438b37e297.1761732347.git.buday.csaba@prolan.hu>

On Wed, Oct 29, 2025 at 11:23:42AM +0100, Buday Csaba wrote:
> Change fwnode_property_read_u32() in mdio_device_register_reset()
> to device_property_read_u32(), which is more appropriate here.
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

