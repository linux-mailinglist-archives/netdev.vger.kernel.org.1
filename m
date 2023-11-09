Return-Path: <netdev+bounces-46787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB817E6675
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA001C20940
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50C11190;
	Thu,  9 Nov 2023 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bk/jsVoP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4203C3C
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:16:22 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745A268D;
	Thu,  9 Nov 2023 01:16:21 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B80460009;
	Thu,  9 Nov 2023 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699521380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3yh8PqTdV++lp9Hlak0Ojq8NdsXQDIGt0OtBSub/wI=;
	b=bk/jsVoPypHHxC762ajM6+kby/KFGKqJPJCv+Zh6Alhuvow3sYqqCnsqeNm+PR/poNdoIs
	FeplkxDXwNN6TBKqr2X2Jw7eKESVdroWDH/kw059/rSzHZvZcof50gyCsHih4H33DwZNNG
	ji+AVRBQTBELapFe4/QfUBjLyntZybveTS9Qj3+cQxOkf5MT2Vk+dYkOqkGJXKwNFII4LU
	FPjvO8Y0y0CgarKViiKki8CgWm/Cxc2dxVevPFfNUjLOBHF0uTHRa21oK6OqPoeZ4FQwmd
	3Cmybvpdr4gMqwtJIujNGE9qrNcBgkNRhAt6uM/A9SykbDZgDZK9xHCC2o4rYQ==
Date: Thu, 9 Nov 2023 10:16:18 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy
 support
Message-ID: <20231109101618.009efb45@fedora>
In-Reply-To: <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
	<20231108113445.24825-2-quic_luoj@quicinc.com>
	<20231108131250.66d1c236@fedora>
	<423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Thu, 9 Nov 2023 16:32:36 +0800
Jie Luo <quic_luoj@quicinc.com> wrote:

[...]

> > What I understand from this is that this PHY can be used either as a
> > switch, in which case port 4 would be connected to the host interface
> > at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
> > speed would be limited to 1G per-port, is that correct ?  
> 
> When the PHY works on the interface mode QUSGMII for quad-phy, all 4
> PHYs can support to the max link speed 2.5G, actually the PHY can
> support to max link speed 2.5G for all supported interface modes
> including qusgmii and sgmii.

I'm a bit confused then, as the USGMII spec says that Quad USGMII really
is for quad 10/100/1000 speeds, using 10b/8b encoding.

Aren't you using the USXGMII mode instead, which can convey 4 x 2.5Gbps
 with 66b/64b encoding ?

Thanks,

Maxime

