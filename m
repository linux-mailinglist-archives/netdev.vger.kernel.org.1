Return-Path: <netdev+bounces-20076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45775D8C0
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 03:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1B11C2183B
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 01:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C952C6133;
	Sat, 22 Jul 2023 01:35:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93F63A0
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 01:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FEDC433C8;
	Sat, 22 Jul 2023 01:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689989742;
	bh=r/Nk9KN99l0Bag1DYaQNMy0EOSREbOkqIPysbMSeM9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FmYbFR9pF9sEDMNWKL+Q6r4JZjbAqEaHypjjlSQSLrwFpJxTqfq3orkC7ZjVfgj0S
	 sdyo2CC8VRU2GY1kSSVTDMEnRCIPpNzsRQhYn8fnXZPngUwZTDWWc+INr817r7NCi3
	 9Z572b3JG2Fv3dKtlirbcsWT6WEu1MP39udseiqIYxgl7W/fTCGB4bC7YWVH1ybpiH
	 136HTC47aCgA1f284UQwjEWfPYTrv0zlhd7LKHfEt54cNSvVYhlvd7XqsfGTKZRsOB
	 Egi/wdUDInVu8dRXWsOLbQFIoCPRZnIj1m7wBwh5+wQnEEHllW7Gyz6MBOJvdbfhFb
	 34wBEg8kYlW+w==
Date: Fri, 21 Jul 2023 18:35:40 -0700
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
Subject: Re: [PATCH net-next v2 0/6] net: dsa: microchip: provide Wake on
 LAN support
Message-ID: <20230721183540.1fb66025@kernel.org>
In-Reply-To: <20230721135501.1464455-1-o.rempel@pengutronix.de>
References: <20230721135501.1464455-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 15:54:55 +0200 Oleksij Rempel wrote:
> - rebase against latest next

Wrong next? IDK. Still doesn't apply :S
-- 
pw-bot: cr

