Return-Path: <netdev+bounces-58282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F96815B7A
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E8FFB22228
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 19:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B96328B5;
	Sat, 16 Dec 2023 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qIxCS6VH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78942321BC;
	Sat, 16 Dec 2023 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6VHJzw+3VYHdLBkISII84W0atV0sewSa9egdxNRLIGw=; b=qIxCS6VHh6kUqzRnvpjCZwo2kO
	QesUsYQu0wAhgJHhNMT8fuPOMdyH7dVENiX4+hrVSDVI22xsN8iwYi0zeP0Xz0sqHNQZjRY9imEWX
	CALujeJPCXhFBoDtTEcCnQ1UFGzLESXPJoXzuWzg+WEmoPpOBBnQuWzidjhUh34cIiZE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEamw-0037EL-Od; Sat, 16 Dec 2023 20:57:30 +0100
Date: Sat, 16 Dec 2023 20:57:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] Add en8811h bindings documentation yaml
Message-ID: <23c99ed8-7274-4171-930f-65582d86402d@lunn.ch>
References: <20231216194321.18928-1-ericwouds@gmail.com>
 <20231216194321.18928-2-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216194321.18928-2-ericwouds@gmail.com>

On Sat, Dec 16, 2023 at 08:43:17PM +0100, Eric Woudstra wrote:
> The en8811h phy can be set with serdes polarity reversed on rx and/or tx.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  .../bindings/net/airoha,en8811h.yaml          | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/airoha,en8811h.yaml b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
> new file mode 100644
> index 000000000000..96febd8ed6fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/airoha,en8811h.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN8811H PHY
> +
> +maintainers:
> +  - Someone <someone@somemail.com>
> +
> +description:
> +  Bindings for Airoha EN8811H PHY
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +properties:
> +  airoha,rx-pol-reverse:
> +    type: boolean
> +    description:
> +      Reverse rx polarity of SERDES.
> +
> +
> +  airoha,tx-pol-reverse:
> +    type: boolean
> +    description:
> +      Reverse tx polarity of SERDES.

Is this to deal with wiring up the SERDES backwards? Is there a more
detailed description in the data sheet?

   Andrew

