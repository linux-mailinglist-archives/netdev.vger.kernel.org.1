Return-Path: <netdev+bounces-214114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 434C6B284F2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B141CE4027
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DD530F52C;
	Fri, 15 Aug 2025 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qL03k+2G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BE930F520;
	Fri, 15 Aug 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278752; cv=none; b=hhW43q4tyvjqA3JMeERI/+XlIP3D8v6M0GoJ1EQGvsIjtWv91HFkMHVCy2vnAoFFKs6vW8iW4BbFGhXaMekXGoLrmQLgqWxWwz7jSfSQgGjTXhqPj9h3A+vcPCbFecBMs8Jal4FxhUqQyNc/CrZdQdHEgR3ZZmxwAZKc3MOxeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278752; c=relaxed/simple;
	bh=rc3gQwDl8uJ25yUOpGIfNdPh1SOgU6dWcPb0iOMUP9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h35C91w0PKjxjhwwr8+tGT2EJYcuRE5zqa+c1fPHLT+i9W6sOpZEy3yUON7AKEJO46tQU/+3bGWbge2iFDQnfITt5QFG53JveY7gjY8E2eyKgGRXNpXYeix5BTBt74V+YUuxfsyeXqve6E839mkR5SXPQG1mHRsCnEpqYUC5QZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qL03k+2G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ksn5h34BezXmSLbEr4X3Fxix8hxWQhHpX8F+SeQyB+4=; b=qL03k+2GuidQpLFhFTkfsmWZiw
	dfqNunG9k6Ukh5XA1iNoeYiLBmGOwlIadaY5aD1r+ISVwolBKmY2J7recBx1y8xhki3sviKg1C1rB
	+rOScAfN2CR086M99rWLCYoLNcdbTMRs9/Y/+n6fvdvM60BnFAhMtzgHQvzmsDeLxQrQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umyBK-004qLi-4a; Fri, 15 Aug 2025 19:25:34 +0200
Date: Fri, 15 Aug 2025 19:25:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: mxl-86110: add basic support for
 led_brightness_set op
Message-ID: <d3a0eb3b-933f-4451-801a-e8ceb17f5953@lunn.ch>
References: <aJ9hUhVfzyvJK8Rt@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ9hUhVfzyvJK8Rt@pidgin.makrotopia.org>

> +	phy_lock_mdio_bus(phydev);
> +
> +	ret =  __mxl86110_modify_extended_reg(phydev,
> +					      MXL86110_COM_EXT_LED_GEN_CFG,
> +					      MXL86110_COM_EXT_LED_GEN_CFG_LFE(index),
> +					      0);
> +
> +	phy_unlock_mdio_bus(phydev);

Please add a mxl86110_modify_extended_reg() which does the
locking. There is already mxl86110_write_extended_reg() and
mxl86110_read_extended_reg().

    Andrew

---
pw-bot: cr

