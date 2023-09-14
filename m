Return-Path: <netdev+bounces-33845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D167A0755
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E031C20928
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9872375D;
	Thu, 14 Sep 2023 14:29:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151E2571;
	Thu, 14 Sep 2023 14:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5854C43395;
	Thu, 14 Sep 2023 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694701764;
	bh=AYLkWZtIY3jmYUzQ0GgKN8cnV/aC0eF2+QVOpRKVAi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNIxIrBM4MHnAXJjJZAxClc99Qy/0u600FhlcYqL+09Pkcb6jNBx8lLI/UDA9S4q0
	 /JSRuEzC3oO6ce38oyrxUQkaooYDpRr7XyEnd4VroBd5EYzHJRFLC/2Ye8gpdnh477
	 MB2MeGIjWFRRvtKIaKKBBWw/bMfKobfE932o5sfP9dnu43s4MwKx9aeBl5oslbjOZr
	 1f9H5ZcTj0byZEBz5tyTnYksceL8sQ1Qi9tXklZDslyGjNnXIMX1BrOiEHCXWzyDC2
	 VRl1P/is2+2Mm5YvMwVFAkr6OA1EV1/w/h7xes/JUPC5nHMbYa4kwYeTcXw0Il7yib
	 mNV7MAz9pbolQ==
Received: (nullmailer pid 1248236 invoked by uid 1000);
	Thu, 14 Sep 2023 14:29:21 -0000
Date: Thu, 14 Sep 2023 09:29:21 -0500
From: Rob Herring <robh@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Message-ID: <169470176101.1248181.5708025774041263558.robh@kernel.org>
References: <20230913091011.2808202-1-danishanwar@ti.com>
 <20230913091011.2808202-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913091011.2808202-2-danishanwar@ti.com>


On Wed, 13 Sep 2023 14:40:10 +0530, MD Danish Anwar wrote:
> In order to support half-duplex operation at 10M and 100M link speeds, the
> PHY collision detection signal (COL) should be routed to ICSSG
> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
> property, "ti,half-duplex-capable" is introduced for this purpose. If
> board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
> be added to eth node of ICSSG, MII port to support half duplex operation at
> that port.
> 
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


