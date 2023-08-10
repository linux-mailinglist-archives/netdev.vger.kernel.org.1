Return-Path: <netdev+bounces-26564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB48778262
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 22:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365D91C20B45
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F4222F0C;
	Thu, 10 Aug 2023 20:53:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C5620FB3
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 20:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FADDC433C7;
	Thu, 10 Aug 2023 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691700810;
	bh=hjFZI1bWZhkQJAvPWDBQTHKlfTzg8WuwI3ke6THo4kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1OyGTtOTv44QirxiDCmkjPQyqlT0YUT7FARB5tvjc4qk7XCZRbqavV+XZZis6jSn
	 xIhBdZq2c1jN8PM8FK+otIZ6+O5+t43fqpzMJMyhK5qovg1aMukWUnhA59weBxc390
	 oEoyZL9YyimSiaeFuLjnqdNb+7DU+rs9r/tDuKvHLCONJSIF+j/KdSZK1WK5+cGBGG
	 NUsrPz2/9M/fbM5Uo9rxuLqf7SdYYqBkOwT9lk7PYJBl6UXCdd5Ls44QQETGUmKagV
	 mWESAdTsLFuDoSGtFYsytYxNWywHH3lDwjHTOh97y2h8uD3xm9RnjDMMfQ4Rx5fG9u
	 VecrGMg5nre5g==
Received: (nullmailer pid 1158727 invoked by uid 1000);
	Thu, 10 Aug 2023 20:53:28 -0000
Date: Thu, 10 Aug 2023 14:53:28 -0600
From: Rob Herring <robh@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: luka.perkov@sartura.hr, netdev@vger.kernel.org, conor+dt@kernel.org, pabeni@redhat.com, davem@davemloft.net, andrew@lunn.ch, krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk, hkallweit1@gmail.com, edumazet@google.com, linux-kernel@vger.kernel.org, kuba@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-controller: add
 PSGMII mode
Message-ID: <169170077839.1157642.6802176058827678901.robh@kernel.org>
References: <20230810102309.223183-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810102309.223183-1-robert.marko@sartura.hr>


On Thu, 10 Aug 2023 12:22:54 +0200, Robert Marko wrote:
> Add a new PSGMII mode which is similar to QSGMII with the difference being
> that it combines 5 SGMII lines into a single link compared to 4 on QSGMII.
> 
> It is commonly used by Qualcomm on their QCA807x PHY series.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


