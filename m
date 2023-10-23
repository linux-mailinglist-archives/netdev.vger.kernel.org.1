Return-Path: <netdev+bounces-43393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDAD7D2D70
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 10:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4FA1C20A5C
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B612B76;
	Mon, 23 Oct 2023 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="phezEq5x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CED125CE
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 08:58:04 +0000 (UTC)
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F327BD7C
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 01:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FM79yVJVep+HIJW89qSSuMfOMacWUUdHj2ArtvarWvU=; b=phezEq5xyNXIx8+9BxJwWtIA+l
	/0xFBX2Fa+u1GkjQF8+lqzbvv01Kef7eY0RA1bjnpeB57K4H2mIZUYQpuqo19xfTcoyMHt2rN6K1K
	bGo/lfhjOfnd0oAF6vkAjHzfa2o++RscXyyHj+ZSXfw9FXGtsn2CBhgvoUjcc4cznraemdtSHNPLv
	FcbaqllhFJqPSzeWjuzggjX2tx0uKktmxHiLzM7z8S4hC/xdCDDpjHi/K12gKgn9aPCunLozqIvPN
	E7u5xCnUqg4E4roPaJxJwnD672ugFLjpK1PHuto1B3gF91KNZA2VWu/OB/wy+GuEfKqWesz661Lmd
	V/VddbNQ==;
Received: from [192.168.1.4] (port=56549 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1quqkz-0001uZ-1m;
	Mon, 23 Oct 2023 10:57:53 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 23 Oct 2023 10:57:53 +0200
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
Date: Mon, 23 Oct 2023 10:57:50 +0200
Message-ID: <20231023085750.8537-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231023084150.GB3787187@pengutronix.de>
References: <20231023084150.GB3787187@pengutronix.de>
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

On Mon, 23 Oct 2023 10:41:50 +0200, Oleksij Rempel wrote:

> Here is KSZ8873 as initial reference:
> https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/00002348A.pdf
> 3.3.9 RMII INTERFACE OPERATION:
> "When EN_REFCLKO_3 is high, KSZ8873RLL will output a 50 MHz in REFCLKO_3.
> Register 198 bit[3] is used to select internal or external reference
> clock. Internal reference clock means that the clock for the RMII of
> KSZ8873RLL will be provided by the KSZ8873RLL internally and the
> REFCLKI_3 pin is unconnected. For the external reference clock, the
> clock will provide to KSZ8873RLL via REFCLKI_3."
> 
> KSZ9897:
> http://ww1.microchip.com/downloads/en/DeviceDoc/00002330B.pdf
> 4.11.2 REDUCED MEDIA INDEPENDENT INTERFACE (RMII)

The upper paragraph refers to the case when switch is acting as a clock
provider (regardless whether its set as internal or external reference
clock). You can see this if you look at the next paragraph:
"If KSZ8863RLL does not provide the reference clock, this 50 MHz reference 
clock with divide-by-2 (25 MHz) has to be used in X1 pin instead of the 
25 MHz crystal, since the ..."
So rmii-clk-internal property does not select whether switch is acting
as a clock provider or clock consumer which is what you are refering to
I believe? The clock provider/consumer is set via strapping pins.

Real case scenario: I have a board where switch is acting as a clock
provider, generating output to REFCLKO pin and feeding it to uC. 
This board does not have externally routed copper track from REFCLKO 
to REFCLKI, thus making the RMII interface not operable, unless the 
rmii-clk-internal bit is set.
If this bit is not set, only way to make it running is to solder a
jumper wire from REFCLKO to REFCLKI.


