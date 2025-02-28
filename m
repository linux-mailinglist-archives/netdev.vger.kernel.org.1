Return-Path: <netdev+bounces-170730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F2A49C10
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69DE27A2F1A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30C26D5A6;
	Fri, 28 Feb 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vnqjAU1Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA51C331E;
	Fri, 28 Feb 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753154; cv=none; b=svLNHXJVHJmek4AUB5qsJLYjoWVMs1ZKziOrA00DSXCIN0HHySblGJVqqOKVbiMnwj0o7g7qORSIAW3yJHBy7MT34we37EejJKbpwvv9Du/3m7SlurAFe+Aec4Pz4g6AuDaWQbpU4I/1wPQbVzhiv50+p92hIX2utRB+DTlF7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753154; c=relaxed/simple;
	bh=IShPQzQud0CPmkUWa6FmVk1k6bMZYxMrSPQMdfHu2CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1LwbOh+n71AhULR/a2jrPXCzwtwsZ7Odfg+JAfhmo8qr7Il+qIoGc7fmFkiyVtQwmSDWPT4C/z5vqFoG9YbV8g6IVtITQswTmmA5kwcT4ZIEL9Gmx6rB22c3LgttPcF8cP89VYu60Zm5emTOGVEx4U8jWn9ewisSryi7s04ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vnqjAU1Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LUZgjJhckIEQIeL4sCjPQpGF4IsNItQ+wc3CINdwt28=; b=vnqjAU1YBbf2svvN1bCNqDLvhD
	2n97xzQtDLJF/ITnq6k04j06r7cR4SVgAHT8ywACFHlD7GagTOh2iyuc7XUH/c766D0kdhrlnVins
	Pnewj/h5dbvdMy/d0Yibcv9RqQj7sjUygGKn021tZPRkuquo4NyCgBDQXAKPjhZ09vWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1to1PY-000yAO-Ft; Fri, 28 Feb 2025 15:32:20 +0100
Date: Fri, 28 Feb 2025 15:32:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v3 05/14] motorcomm:yt6801: Implement the
 .ndo_open function
Message-ID: <40d06932-3704-4eea-887f-ba286085532d@lunn.ch>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
 <20250228100020.3944-6-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228100020.3944-6-Frank.Sae@motor-comm.com>

> +static int fxgmac_open(struct net_device *netdev)
> +{
> +	struct fxgmac_pdata *priv = netdev_priv(netdev);
> +	int ret;
> +
> +	mutex_lock(&priv->mutex);

What is this mutex protecting? Where it is defined you have:

       struct mutex mutex; /* Driver lock */

which does not help at all. Why is the RTNL lock not sufficient?

	Andrew

