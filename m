Return-Path: <netdev+bounces-32838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A369079A916
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 16:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79102812AA
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1696C1171B;
	Mon, 11 Sep 2023 14:53:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CC11706
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 14:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F83AC433C9;
	Mon, 11 Sep 2023 14:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694443993;
	bh=r9uAvsPMKBSoSZ444LBXcq13Ir5ZTBEHNT1xJjzBGFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiv8gQ/ZYufnMz2KaRZus5/1orM/jtGnWu5LVFSbHJ954tPfsmPbHTIMqpgUuiugV
	 qF5A8hVnABogiH+bNSNyzHV8LnEF6gR9EkVqyAZpMaR/lYUBzHjliH1npBvhJbJim2
	 DZeKzgrqAFjbhE3r8UkoDZ4lsv68/b2nJXLBqQWhHTitFZsZrKRN1kEZIJK4MrfxcM
	 8/OLxe6fzLQgqDvTDTGxachfQjgs7QryIGdbkwum6FKbjosVVH6D8ygk+bDwEGVenu
	 OcFovyIxw403Mr+x5YiqRhr/g7zdmjPbbFkam8H25zwVDnU+XDVxIxxmhvGb6sN/Gv
	 52z0vfn5QJROQ==
Received: (nullmailer pid 1240952 invoked by uid 1000);
	Mon, 11 Sep 2023 14:53:10 -0000
Date: Mon, 11 Sep 2023 09:53:10 -0500
From: Rob Herring <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, kernel@pengutronix.de, Eric Dumazet <edumazet@google.com>, Rob Herring <robh+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Arun Ramadoss <arun.ramadoss@microchip.com>, devicetree@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next v3 1/2] dt-bindings: net: dsa: microchip: Update
 ksz device tree bindings for drive strength
Message-ID: <169444399004.1240880.4980375902161136424.robh@kernel.org>
References: <20230907090943.2385053-1-o.rempel@pengutronix.de>
 <20230907090943.2385053-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907090943.2385053-2-o.rempel@pengutronix.de>


On Thu, 07 Sep 2023 11:09:42 +0200, Oleksij Rempel wrote:
> Extend device tree bindings to support drive strength configuration for the
> ksz* switches. Introduced properties:
> - microchip,hi-drive-strength-microamp: Controls the drive strength for
>   high-speed interfaces like GMII/RGMII and more.
> - microchip,lo-drive-strength-microamp: Governs the drive strength for
>   low-speed interfaces such as LEDs, PME_N, and others.
> - microchip,io-drive-strength-microamp: Controls the drive strength for
>   for undocumented Pads on KSZ88xx variants.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/net/dsa/microchip,ksz.yaml       | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


