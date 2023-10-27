Return-Path: <netdev+bounces-44653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C816F7D8ED6
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803722822EA
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 06:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5111FD8;
	Fri, 27 Oct 2023 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="dRZk73P+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20BA8F4B
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 06:37:57 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C11B9
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 23:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cfSheYkKgV7wYhq6XSQC0lCEKcDMBiR27jIy14VfJ9E=; b=dRZk73P+tV/kmONU7XBPReVXbD
	GPey+0NfYgarUIznoTZ5chGGFcN+tS5MJWdu7sAJa7f7CTimSpe6kpTTuDjgCfGPRUbcSlGDinK8T
	ZgsJtkds9BoJqMrIi4yWMo78K6A2LFdRk6BYrXw/PcFXBDgAl5XPxun163Nk7QpSkg5FRqat77gAq
	x4MrxJzXx/N+/v43PaNytS9pLo4CaGc71UjrnFxAPwQjX10PdvHWPTy2uvHBK4R1jYawryZVFtOZA
	CQaG5pPOkUuZ7feQTvDgjKG2WwBr0JwKjaDoo1ka7e7Acgd3rQLbmq0Kz49IxvYrYXsYl/O4GTWKN
	HzoQBZQQ==;
Received: from [192.168.1.4] (port=60910 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1qwGTb-0005tz-0O;
	Fri, 27 Oct 2023 08:37:47 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 27 Oct 2023 08:37:46 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <olteanv@gmail.com>
CC: <o.rempel@pengutronix.de>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <ante.knezic@helmholz.de>, <conor+dt@kernel.org>,
	<davem@davemloft.net>, <devicetree@vger.kernel.org>, <edumazet@google.com>,
	<f.fainelli@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <marex@denx.de>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
	<woojung.huh@microchip.com>
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Date: Fri, 27 Oct 2023 08:37:43 +0200
Message-ID: <20231027063743.28747-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231024142426.GE3803936@pengutronix.de>
References: <20231024142426.GE3803936@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

On Tue, 24 Oct 2023 16:24:26 +0200, Oleksij Rampel wrote:

> > That is correct, I guess its a matter of nomenclature, but how do you 
> > "tell" the switch whether it has REFCLKI routed externally or not if not by 
> > setting the 0xC6 bit 3? Is there another way to achieve this?
> 
> I do not see any other way to "tell" it. The only thing to change in you
> patches is a different way to tell it to the kernel.
> Instead of introducing a new devicetree property, you need to reuse
> phy-mode property.

> ...

> Since phy-mode for RMII was never set correctly, it will most probably
> break every single devicetree using KSZ switches. It is the price of fixing
> things :/

To Vladimir Oltean: What are your thoughts on this?


