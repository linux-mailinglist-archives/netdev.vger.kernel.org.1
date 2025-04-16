Return-Path: <netdev+bounces-183445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02198A90B43
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666DC3B24B6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5727A221F25;
	Wed, 16 Apr 2025 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="BhgY0wgy"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93D3221DBC;
	Wed, 16 Apr 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828047; cv=none; b=UwNx5FRGWI3zje/7imfkgCvEgllia5afn68j0FXh3+Wsz+N62v691xJRxxK4l5SGK0NBN3RzvlUWDhLG7fCLE6DOPEyMh/YJ1Mb5NtUHlaklfM7qdcHy6IkKrJJkq9NhfJMCjYzjAP8rA3UI2Y/8VVM9HA1WUojvMPMlUc/0rUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828047; c=relaxed/simple;
	bh=CMk8CUbEewKgTLh12sPS7gILCDnwaVmQSoXTw/lcDug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7vUwPSV2gRxjd6m6O/dryTtRuvfZf2QN7JFQ1aSkD7zT2JbnnmSYuMx8vgv6w7SkB5oD8yGZ/oJlGsYTX5oxWWq2JfXs6p31kRN5ndEyis4hA0zkkezVrM1y+UToisu+YLX+LHwTiVgtxifaWzctN09ggXMjwfgn7woFoQm0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=BhgY0wgy; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744828032; x=1745432832; i=wahrenst@gmx.net;
	bh=CMk8CUbEewKgTLh12sPS7gILCDnwaVmQSoXTw/lcDug=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BhgY0wgyI59w8EN9u6HyyJtVR9jRCGm8Q6B39zzBKfo3s1BffoHBdK4qbDIQWUrI
	 9Z0BlUBxMylWg2Y70g44T/6li73Zx8WFVQ1xTCJqgNdaggxnAx+aeTPsRcDQ7vOzK
	 YluJ+jGGQOytGGGNd/FYmrhJJJJqOAf7p6u+7bkXPB7R9eI3fH8mUmbxpz3yl+a4U
	 kctVC3fuFAYCxEMyecKl/Xt4HBkxGDNDKZrb/p7hjWCJ1gg3F6JA3VCil20AsQ4j5
	 N0xDJJfR0g5NlWQutqlgPzDIcnaHIj6kevfTKHN6wWctloeEzLPUBzHryzUnVNqJB
	 mxvPyeJk+G4g27onEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ycr-1u26Oy3JO7-00EHE1; Wed, 16
 Apr 2025 20:27:11 +0200
Message-ID: <3583fd06-6d27-4efe-b6e9-71926abe3b12@gmx.net>
Date: Wed, 16 Apr 2025 20:27:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v5 3/6] ARM: dts: nxp: mxs: Adjust XEA board's DTS to
 support L2 switch
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
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <20250414140128.390400-1-lukma@denx.de>
 <20250414140128.390400-4-lukma@denx.de>
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
In-Reply-To: <20250414140128.390400-4-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SC+vctnACKE6B5hrAq69IHYBfukH9rEY0Ji2sBxSNYuJFsqSUEV
 i1WgPonH8C/uJO+B+3eiaD20fW/24QHvxghvnyDuY4qXE1ApJkigBI+HFfXe824q+fgZopl
 gcLoz9ppvUr02kiYtkQpdElP3g0pvIeygD8sZDmKliOtxcsD0Pn8QT0Cl0cS1ujszup8NtA
 qIZqCQ2KwZQ5GsVPagGQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A4MnbPh7ByI=;jdM3HS90XUMKqtP2SAXbrQWNm3G
 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
 Q==

Am 14.04.25 um 16:01 schrieb Lukasz Majewski:
> The description is similar to the one used with the new CPSW driver.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

