Return-Path: <netdev+bounces-56492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0580F1DB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343C71C20C96
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B137764F;
	Tue, 12 Dec 2023 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ExG/pMwB"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC559A;
	Tue, 12 Dec 2023 08:07:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF8F1E0006;
	Tue, 12 Dec 2023 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702397226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJpdj69LX9IEhqohq156R8WukFK3OJVd0O9X4X2+26Y=;
	b=ExG/pMwBBumC4QhP5vNOjlnVV8KqPLC136SVSVEYTsijZN/SA06MhMXAal58wtGcNHldD6
	Cshygd0aPgzABApx931nXxMFNn+x5AVJ3PvvpV+/VwKT4fG3Ko7OwKMDQ2Uq79eYCUH1Dq
	w4gn/6mqaBezusxxrAvb0M2wzznz0CIfuawXAuhhhNWIy1CdrHCfvfvnEG+uab5AKx9o3+
	rODyBlgGn2vtxJ87A1WjnN47yCkiIMgFJcd7c+WcfFamHY4VxFVz3LQVB34ocxMMN2oCbt
	jdmlOiEODcPCRajnrnGDNyQiDurVP1/XcKwYuov2Er1yZisjPF2BbNyM6aFlGw==
Date: Tue, 12 Dec 2023 17:07:04 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: mw@semihalf.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mvpp2: add support for mii
Message-ID: <20231212170704.74565969@device.home>
In-Reply-To: <20231212141200.62579-1-eichest@gmail.com>
References: <20231212141200.62579-1-eichest@gmail.com>
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

Hi Stefan,

On Tue, 12 Dec 2023 15:12:00 +0100
Stefan Eichenberger <eichest@gmail.com> wrote:

> Currently, mvpp2 only supports RGMII. This commit adds support for MII.
> The description in Marvell's functional specification seems to be wrong.
> To enable MII, we need to set GENCONF_CTRL0_PORT3_RGMII, while for RGMII
> we need to clear it. This is also how U-Boot handles it.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks for the patch,

Maxime

