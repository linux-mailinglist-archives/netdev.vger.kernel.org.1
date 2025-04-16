Return-Path: <netdev+bounces-183444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F35A90B37
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807C33AD193
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A0219A68;
	Wed, 16 Apr 2025 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Y60CK3H7"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60341214235;
	Wed, 16 Apr 2025 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827633; cv=none; b=lkCS2YS7euxBFQLsbnMjFldvqa1JT3zkO0FrBBiPyX/QpgToCcKn0fIC5dPuym+c/EjiAhcJYvovrqI5u03WEnQDSYiNNkiHdEFnjZHfBb+BfOU2Qo2YOdXMUAHaG1qrXwt2iy9TNCSH00h3sAFGY9gxZga0IiqXyzu4XFXM2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827633; c=relaxed/simple;
	bh=9fZVP5qCPqf8i6yiN38lT2yxDswfPqHd9OevWflFDHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdUakaw73HiNVcqipoVn+RraaM0xR2lo51MsVF7OMeTAfMyqk88GXiy+Zq9CHhRHzkXWqnq7sNzGQ3xPtpza5rcNMCB77+eWzLaSkDSGlnsl6RbSWgUrEkbM2C/p2EM0twt7k9kgf1al/IT43oV3AqHvGpyNBrqX3aLIaek3ro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Y60CK3H7; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744827618; x=1745432418; i=wahrenst@gmx.net;
	bh=9fZVP5qCPqf8i6yiN38lT2yxDswfPqHd9OevWflFDHw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y60CK3H7q9OGnAnxt+/RrcUlduWqiw0cQ33LDtl9vuidJztuhmxRRBg7eeFGO5qN
	 +1ejkoo1Y6t9CebgZ7YXhycQR9fd0+cB09A7JckLrXAIjyMJvKnlNjQUF0STUdfWG
	 C7OMrNAMmoASXMp1XwGMy+tYsbgjSjElp3oxi6ijrlRaG4paRZJpHUkeSGImQKj6J
	 Q3jWRwi0yAGPOlRmIMs3a9RAhRlD26lo2APlhdaxxkrXHQU0iAiGixgngncsjEXVu
	 dZ8qUmnqvuXSwf1zC38OyX83iot76h1V0/ftPgGzcdMlbMFvZgQtD2kyFW1Rczw+j
	 90v0Q8iCRMl0nkZRRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1tJeWs14hw-00emAH; Wed, 16
 Apr 2025 20:20:18 +0200
Message-ID: <0c854b7f-190c-4477-a3ff-007427442fcb@gmx.net>
Date: Wed, 16 Apr 2025 20:20:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v5 6/6] ARM: mxs_defconfig: Enable CONFIG_FEC_MTIP_L2SW
 to support MTIP L2 switch
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Simon Horman <horms@kernel.org>
References: <20250414140128.390400-1-lukma@denx.de>
 <20250414140128.390400-7-lukma@denx.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250414140128.390400-7-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:itvxO48mTZnNJc/gAjoCazoEY4fXOsoGFv9Kn8f5bTQ48pcsNb8
 gpp7h9agbLzTu1gDahSA4I4D7uK3okJ7747WGuiWHTI2yKuE6atR+Wp9Z+TKsAADT+9QphZ
 FhWMkbesJ4hsO7hwaL5KKuMBVDxDoo5yyJs1T3QaGQmlbseuYMG4VoJbQpoMyDPv4wQIdBd
 SsH/2RbUyPYk2a5rqRbpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GWURujK0+Mc=;JMwYsdP1UXrq9lQFjwpfBw/80eX
 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
 w==

Am 14.04.25 um 16:01 schrieb Lukasz Majewski:
> This patch enables support for More Than IP L2 switch available on some
> imx28[7] devices.
>
> Moreover, it also enables CONFIG_SWITCHDEV and CONFIG_BRIDGE required
> by this driver for correct operation.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

