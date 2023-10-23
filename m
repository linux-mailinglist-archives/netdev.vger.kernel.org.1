Return-Path: <netdev+bounces-43377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277327D2C8A
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 10:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C5FB20C6E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E956FCF;
	Mon, 23 Oct 2023 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="P+mwCVUy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98681C27
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 08:22:39 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BF4C4
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GDrvwziqR8eqZvZwnWi+qqVQQ6k9JCIMHvBxTxl965k=; b=P+mwCVUySm4nRckqLrYOhl01kA
	HLudb6TV4WwftSAIOc+TksxGe578ZXhTDi9RUgjihx/vP0inPEGz4okjX7oEM4UuUcMpwJPv/1lPc
	dMbSwvxyWjRolB2f/pLOig7yHbaAp/ne8PlfkM9/7jj2z/OD/bn/ecLcPleumnjO2ewXOuDOJ/JVc
	n14rFyB/zEgXJsKhwAOKcdtKrFIvC9K54oyWk6tRULaq1DDouLwoY820OZW9/HJyBvtTN5KqN4Lj3
	06SU82R6ENFHHlObAqbaQot7Ln+giqhzHV1ccUChhNN+yItrxk1Vc6V20Tfg40ctBwgnYik2hcxJD
	spU9gP0w==;
Received: from [192.168.1.4] (port=54275 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1quqCn-0006qu-1o;
	Mon, 23 Oct 2023 10:22:33 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 23 Oct 2023 10:22:33 +0200
From: Ante Knezic <ante.knezic@helmholz.de>
To: <o.rempel@pengutronix.de>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
	<ante.knezic@helmholz.de>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<devicetree@vger.kernel.org>, <edumazet@google.com>, <f.fainelli@gmail.com>,
	<krzysztof.kozlowski+dt@linaro.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<olteanv@gmail.com>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
	<woojung.huh@microchip.com>
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Date: Mon, 23 Oct 2023 10:22:30 +0200
Message-ID: <20231023082230.17772-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231023075848.GA3786047@pengutronix.de>
References: <20231023075848.GA3786047@pengutronix.de>
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

On Mon, 23 Oct 2023 09:58:48 +0200, Oleksij Rempel wrote:

> If I see it correctly, KSZ9897R supports RMII on two ports (6 and 7)
> with configurable clock direction. See page 124 "5.2.3.2 XMII Port Control 1
> Register"
> http://ww1.microchip.com/downloads/en/DeviceDoc/00002330B.pdf

Clock direction is possible I guess with other devices as well, but I don't see
this specific property (routing REFCLKO to REFCLKI internally when switch is
used as clock provider) for any other, including KSZ9897? 
I am no expert on micrel switches, but this to me looks like something specific
only to KSZ88X3 devices as the clocking seems a bit different on KSZ9897 and
alike. KSZ88X3 may generate clock to REFCLKO but still needs this clock fed
back to REFCLKI (or will be routed internally with the "microchip-rmii-internal"
property). This is managed differently on KSZ9897?

