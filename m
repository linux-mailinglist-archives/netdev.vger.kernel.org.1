Return-Path: <netdev+bounces-225646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906BDB96522
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51C33A2B61
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C03B2586CE;
	Tue, 23 Sep 2025 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KFL1NFtq"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA068253944;
	Tue, 23 Sep 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638003; cv=none; b=rakwDDlsug/H/YGo8Ezv11/oTGyCRUpSrZiFkoDc6WRfO07dFklPTyIR2qbYGkfWCurXnoymnSeLGpYyCp3btGjR62ynmy0h/fZ5SiOiMMsfJT/xsiTscry7hjCKpSmvNDefo6Vab28ncLPxhyoPyWIyzZsJ/ei7VyoieooWDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638003; c=relaxed/simple;
	bh=yJvHSwfA5ToKfP+3dMkUL1S0txFq5LORtmil5BY87eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPOGLjiW1vAWXOJo7aafoguUAapQU65XD6IXI+AmmnK4VbnFXTckI7ZH/d+w3KFyXQ6sfGuCUOs+CEaY9AOQzxP9vDOUpPsPYdd0eEQwz7UZ8V6W5i2tYfmQFTmBDSaYk1yEfAuiXeipx2g+0zlaaLZ0DNlZD1EnPXiKDjPFDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KFL1NFtq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E00901A0E8B;
	Tue, 23 Sep 2025 14:33:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B254D60690;
	Tue, 23 Sep 2025 14:33:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9FAF102F195F;
	Tue, 23 Sep 2025 16:33:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758637997; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=yJvHSwfA5ToKfP+3dMkUL1S0txFq5LORtmil5BY87eo=;
	b=KFL1NFtqPpo/sU55KEiRxYn8jki4l6W3ypQ7KajOEJYfeW5XR4RrJrpgTVI4uPqKbQeeK1
	rPQOFH96WK5zf/TzyyKClvNnsXNdn/Z401BslTuzyCRCLYKhs41B0rwXFfETdsU9l65xeI
	CvAvAg7zB7snvoXNIkzs+0jTYZA0fdJUeZFE7lXwnRg4drdUsXTDnDnlD4TsYpRr1KHyI4
	VihEAstQBL2RFw/R26ODdR77tEnT8E0vrci6r5KqIYDXCTzxn8fMYVemy/IAefkZLYCTXU
	h2dGjyVXVpf7/LXR8McYGsQ00HIOA0rD1o/ht0NkQRKl8w5Enlnhwkt4jfyZ3w==
Message-ID: <67cf2889-4f7a-4d79-807e-8909cc8a46f6@bootlin.com>
Date: Tue, 23 Sep 2025 20:02:53 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 2/5] net: phy: introduce
 PHY_INTERFACE_MODE_REVSGMII
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
 <20250922131148.1917856-3-mmyangfl@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250922131148.1917856-3-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22/09/2025 18:41, David Yang wrote:
> The "reverse SGMII" protocol name is a personal invention, derived from
> "reverse MII" and "reverse RMII", this means: "behave like an SGMII
> PHY".

Wasn't it Russell who suggested that name ? :D

> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


