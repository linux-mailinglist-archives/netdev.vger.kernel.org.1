Return-Path: <netdev+bounces-19708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E5F75BCB5
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 05:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2291C215E3
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0D1638;
	Fri, 21 Jul 2023 03:17:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0667F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 03:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E8FC433C7;
	Fri, 21 Jul 2023 03:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689909475;
	bh=lZCRel7jgN9X7NBylu6tXAt5SKl31rc26PRheAuhhVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H3vMtko7PATu6lT20kSpEDEMRsJ/nLxpR29nAIJjFi3Ua7RR2i7ZQVAj4wqxohJx3
	 aV1WQkgIZASjKisP7u1jLt7xRhfNVz9cuPm0t1qndRabVCvHI30/upQ9mxDz/D0XDe
	 qGhy7VfDJviQ8S2yB5bEKCLRlezi1WSiEOcqT2hzN8Jgq/rGMkmTNwO7xsH3Kpq8g8
	 WIHSmW048I7og4nJWLahYZYscdzGkOWAb1AmTGdKb0bTuPbYkOO02a8y6iJ8RtKbwQ
	 a/P0M7ch5gw7VmlK3r8K76ZZvmqieLvYGDRgUIRZpazzAIQNFitw9w0swmihvA+Vwg
	 bK2G4S8cemYPg==
Date: Thu, 20 Jul 2023 20:17:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
 <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
 <arun.ramadoss@microchip.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 3/6] net: dsa: microchip: ksz9477: add Wake
 on LAN support
Message-ID: <20230720201753.27563c1e@kernel.org>
In-Reply-To: <20230720132556.57562-4-o.rempel@pengutronix.de>
References: <20230720132556.57562-1-o.rempel@pengutronix.de>
	<20230720132556.57562-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 15:25:53 +0200 Oleksij Rempel wrote:
> Add WoL support for KSZ9477 family of switches. This code was tested on
> KSZ8563 chip and supports only wake on Magic Packet for now.
> Other parts needed for fully operational WoL support are in the followup
> patches.

This one doesn't apply on net-next/main.
-- 
pw-bot: cr

