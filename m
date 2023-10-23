Return-Path: <netdev+bounces-43477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D047D3721
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 14:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30AD5B20BDF
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB43F50E;
	Mon, 23 Oct 2023 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="LPScENuj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5113AE7
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:46:53 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DFBA4
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 05:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xJhy/3fJraQLw+9/fyh9mAZ0ruwWzkjN+cJMFU3tJVw=; b=LPScENuj4WK4ueKZWAaP1j7uyQ
	CGYGiVPu/BETzIU53ptI9Qvb1TyN1WSDZyb0fhuthdyqPMLqUZT/jbxBEGBMZA0ZNiHVAQS++G9j1
	I9NOSNP/nbFh9XZJwRI3YzVqXAIsIPeUpApFpxZSduHqjpvViyNxJ/TKyKgjAtXuPEVz6MgjqFuUR
	59BWvE3cuitZomYcxcnaTHGocQt9jXJhNffzwIzBorItKEhK+hqEoNVeBUDxDS80DU+2Izl8Bx3Hh
	LRiJLVxr8qzeQm1nTJF85G/RGacZMMP6uEb8tEorQ8gjI4r6irW3Szxf1BPFcmlUfX8r/DJ1ODjgz
	SP/2W56Q==;
Received: from [192.168.1.4] (port=23618 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1quuKR-0001iX-06;
	Mon, 23 Oct 2023 14:46:43 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 23 Oct 2023 14:46:42 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <olteanv@gmail.com>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
	<ante.knezic@helmholz.de>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<devicetree@vger.kernel.org>, <edumazet@google.com>, <f.fainelli@gmail.com>,
	<krzysztof.kozlowski+dt@linaro.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<o.rempel@pengutronix.de>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
	<woojung.huh@microchip.com>
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Date: Mon, 23 Oct 2023 14:46:42 +0200
Message-ID: <20231023124642.6519-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231023121924.udseyuy7t77dscwl@skbuf>
References: <20231023121924.udseyuy7t77dscwl@skbuf>
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

On  Mon, 23 Oct 2023 15:19:24 +0300, Vladimir Oltean wrote:

> I have no doubt that RMII settings are port settings. Scaling up the implementation
> to multiple ports on other switches doesn't mean that the DT binding shouldn't be
> per port.
> 
> Anyway, the per-port access to a global switch setting is indeed a common theme
> with the old Micrel switches. I once tried to introduce the concept of "wacky"
> regmap regfields for that:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230316161250.3286055-3-vladimir.oltean@nxp.com/
> 
> but I don't have hardware to test and nobody who does picked up upon the regfield
> idea, it seems.

Ok so I see about moving this to port property.

