Return-Path: <netdev+bounces-167763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA67BA3C254
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4223A46EC
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563B61F2B94;
	Wed, 19 Feb 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVeoQbZx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D511F2B88;
	Wed, 19 Feb 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975964; cv=none; b=hgYid5Qwd7rrJnC+U0amfp+GDQ/WF3ep3Q0SKYELHDknjlCPqCjWyRK8yQ5MnSVkhigigX+nK1is4iNqO/u6JnFPDMmXhP6W+2ZJs/msaj4wIRYuib1cxJttT+8A7lUamLkun0rltCveFTWnM/UeK+pUu/sCnK7udUS0MfDQ/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975964; c=relaxed/simple;
	bh=zg41uxLeF1XqKwA/EMGTDy9ivzajg7Z1s3Ntido7yDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA1pdF6o0xmln5yyoDNYhBr+XCuRDP/iicYnEWEhIdJDvxJBREDRO8vIATV+XgbxLsWiiaUqEYuiwtg3pEg+/yJ7bdUEvWc32K1jspovpjEUurRDxLnOgdEWVlpQBGLRVXt5DfBkWSZ8oOpqz1jvA4E7PyAEaQLaxjKfuTeI6Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVeoQbZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1ACC4CED1;
	Wed, 19 Feb 2025 14:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739975963;
	bh=zg41uxLeF1XqKwA/EMGTDy9ivzajg7Z1s3Ntido7yDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVeoQbZxARTuIRRNLLoesbA03JgG5KpgfNhmlEu3lR68IBae4oYRHhWI94pSSWOy/
	 AbhMSX7vQwNXOZ7ZYQ8rl/B8iZn9sp3FymfII5MdeRiv7vmb7RlDPNWCNsDFjFVrKD
	 4EIWgbDJr7eyNPrSHARv0mOznmETq/Hjff9Pfrv5DSaZkQ+KbT+Ai7IqiAsSDe+1M5
	 U9+sVQuoZe5BD7hPeM2Qj4wGe5hLxGWj9H3z2Xp+51EJmkV87TShPXWaH/iiz7LJ/A
	 DKxZqFdufJYhkiNxvCIyli6Fm/0HbbR7j5Zzih+2MAZIteczEkZj6h8kVq/IAI1sL6
	 Ou3HiYRiEI1nQ==
Date: Wed, 19 Feb 2025 08:39:22 -0600
From: Rob Herring <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: convert ICS-43432 binding to
 YAML
Message-ID: <20250219143922.GA2527138-robh@kernel.org>
References: <20250210104748.396399-1-o.rempel@pengutronix.de>
 <20250210104748.396399-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210104748.396399-2-o.rempel@pengutronix.de>

On Mon, Feb 10, 2025 at 11:47:46AM +0100, Oleksij Rempel wrote:
> Convert the ICS-43432 MEMS microphone device tree binding from text format
> to YAML.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v2:
> - use "enum" instead "oneOf + const"
> ---
>  .../devicetree/bindings/sound/ics43432.txt    | 19 -------
>  .../bindings/sound/invensense,ics43432.yaml   | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/invensense,ics43432.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ics43432.txt b/Documentation/devicetree/bindings/sound/ics43432.txt
> deleted file mode 100644
> index e6f05f2f6c4e..000000000000
> --- a/Documentation/devicetree/bindings/sound/ics43432.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -Invensense ICS-43432-compatible MEMS microphone with I2S output.
> -
> -There are no software configuration options for this device, indeed, the only
> -host connection is the I2S interface. Apart from requirements on clock
> -frequency (460 kHz to 3.379 MHz according to the data sheet) there must be
> -64 clock cycles in each stereo output frame; 24 of the 32 available bits
> -contain audio data. A hardware pin determines if the device outputs data
> -on the left or right channel of the I2S frame.
> -
> -Required properties:
> -  - compatible: should be one of the following.
> -     "invensense,ics43432": For the Invensense ICS43432
> -     "cui,cmm-4030d-261": For the CUI CMM-4030D-261-I2S-TR
> -
> -Example:
> -
> -	ics43432: ics43432 {
> -		compatible = "invensense,ics43432";
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/invensense,ics43432.yaml b/Documentation/devicetree/bindings/sound/invensense,ics43432.yaml
> new file mode 100644
> index 000000000000..79ed8c8e8790
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/invensense,ics43432.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/invensense,ics43432.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Invensense ICS-43432-compatible MEMS Microphone with I2S Output
> +
> +maintainers:
> +  - N/A

If no one cares about this device, then we should just remove the 
binding and driver.

> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  The ICS-43432 and compatible MEMS microphones output audio over an I2S
> +  interface and require no software configuration. The only host connection
> +  is the I2S bus. The microphone requires an I2S clock frequency between
> +  460 kHz and 3.379 MHz and 64 clock cycles per stereo frame. Each frame
> +  contains 32-bit slots per channel, with 24 bits carrying audio data.
> +  A hardware pin determines whether the microphone outputs audio on the
> +  left or right channel of the I2S frame.
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - invensense,ics43432
> +      - cui,cmm-4030d-261
> +
> +  port:
> +    $ref: audio-graph-port.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ics43432: ics43432 {
> +        compatible = "invensense,ics43432";
> +
> +        port {
> +          endpoint {
> +            remote-endpoint = <&i2s1_endpoint>;
> +            dai-format = "i2s";
> +          };
> +        };
> +
> +    };
> --
> 2.39.5
> 

