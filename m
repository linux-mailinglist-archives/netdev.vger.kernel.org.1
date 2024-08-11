Return-Path: <netdev+bounces-117489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE1294E1D1
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556071F21177
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8514A602;
	Sun, 11 Aug 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K4ZTNRk/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F5848D;
	Sun, 11 Aug 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390178; cv=none; b=YUbN2tgQxtmpq0GfBle/f4jkmsT+F/eGZG4d23xiHnCcMaALaaHc2dQqr6D74Wd/XacHwE9BLJ6egYrdSjQ98F6ZyCrckcPbGWdMKBBsPjjdahx5DO8kQhNCMWio7jRnJBYx1HUf89xHL6r5EvCCOm8WpalHwxSRagR0hJTylaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390178; c=relaxed/simple;
	bh=WUzmrG2wgWfKz+f1yGgmG65B8k6DMu8tu+wTkIhbE4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaz9fxkhupTtxMFsaXGB8uCIIc55qaVQYC3SaRckvQJz3rt57BZwS5XJYKabv9KBSV0rOhNwQElirPSRPjTHN3atOZh5/1vqSmPKOSixRoeN0r7DaKh0NAjtfTxU8UZM/JQfmiFfou5kQteuSXjlufEy6QiplwTevH63nBQeyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K4ZTNRk/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1siOTTqwXddXX2Vyg6Z5ahDYeVHQRGvP6BwJe6iJn5M=; b=K4ZTNRk/Bnjycq2T18pXaEZ2lm
	+PnlmTRuSVqhJEOGU3zo7uCpUY84z8kC+Mh7Qvh0fE8SpBZQR2GsyscEurTQayFwnm+V9K0/L8q0N
	AjVDm2JQQ31y6EA0UoxFl0jvIg7utp9Dv/7Ak2JrDYm65FjynXwmox3JHqg4CqNiZ4Io=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdAVV-004VLH-Ei; Sun, 11 Aug 2024 17:29:21 +0200
Date: Sun, 11 Aug 2024 17:29:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/3] ethtool: Add new result codes for TDR
 diagnostics
Message-ID: <00ed3f2c-e1de-4147-82e4-10f8b53e3c46@lunn.ch>
References: <20240811052005.1013512-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811052005.1013512-1-o.rempel@pengutronix.de>

On Sun, Aug 11, 2024 at 07:20:03AM +0200, Oleksij Rempel wrote:
> Add new result codes to support TDR diagnostics in preparation for
> Open Alliance 1000BaseT1 TDR support:
> 
> - ETHTOOL_A_CABLE_RESULT_CODE_NOISE: TDR not possible due to high noise
>   level.
> - ETHTOOL_A_CABLE_RESULT_CODE_RESOLUTION_NOT_POSSIBLE: TDR resolution not
>   possible / out of distance.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

