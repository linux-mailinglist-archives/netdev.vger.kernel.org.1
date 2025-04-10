Return-Path: <netdev+bounces-181082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7ADA83A48
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2B84A3399
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C21020C46B;
	Thu, 10 Apr 2025 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9rjA6p2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993620C03F;
	Thu, 10 Apr 2025 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268773; cv=none; b=jPgx6dlYFVVuItyUujO4OtN0/KxC1NHHHKClb1MM0WuOVvsGdv0b1lW5FbJxWoEG0hlk03d2r6HybS//7h88bWFuovJxNRslJF13NC/Maa4dUJqlOhK83nUSM4MftnYsdGHwFi2PmhgLaeSechuC9J6M+K5ReFOGo6bcCMmoRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268773; c=relaxed/simple;
	bh=0FE4KejZnNKFUdq/4vRmfxEFMg4KkheeM5BLRqN6ylo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLwmYocYasQ+dcfEOhu4MUQ9E1/jUvqkfDln71azUlbGb1MSfSaarHhxaDXifO7+ZbOdUEVFBpS9pHq0HAU0tDme4k447MJhytpnr7UyHfKjLM/5bnkWwVfQ3WJcXfw2mEBoCU0m91PiJRN8t2rSbppBix1EXQFkL02gZRSF18E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9rjA6p2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1FAC4CEDD;
	Thu, 10 Apr 2025 07:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744268772;
	bh=0FE4KejZnNKFUdq/4vRmfxEFMg4KkheeM5BLRqN6ylo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9rjA6p2kngko4993Ebi0lKRc0pBQ/AY1UAfq1K0MPOGVYlo9cgvq05AK8F6D8B3Y
	 kj5lhVoNQO9BhmJLcmMGJjH3cLw8GeB92RN468dj55YrIfEcCjacXloIqQHwvyul5/
	 ORZk/shVaiiyXVC5jdEx7pnWQ+VYPtHdsQBHkglFUOwvBKLMj1FX7ZfA722dmTymE0
	 kndmKSeuXib+2E947ZDy76JrScStSGaNYVB9Bx0RVzIEF6l2+oFzID1YHWT5Uh2TLL
	 c80TwkGqQtTs8hR/fe1NNQ/YcbcM7Try8xlw73hSoshkkMez+zUUThpk3u1TNvWFOa
	 MNQB9WSGPtYlA==
Date: Thu, 10 Apr 2025 09:06:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
Message-ID: <20250410-skylark-of-silent-symmetry-afdec9@shite>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409144250.206590-3-ivecera@redhat.com>

On Wed, Apr 09, 2025 at 04:42:38PM GMT, Ivan Vecera wrote:
> Add DT bindings for Microchip Azurite DPLL chip family. These chips
> provides 2 independent DPLL channels, up to 10 differential or
> single-ended inputs and up to 20 differential or 20 single-ended outputs.
> It can be connected via I2C or SPI busses.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  .../bindings/dpll/microchip,zl3073x-i2c.yaml  | 74 ++++++++++++++++++
>  .../bindings/dpll/microchip,zl3073x-spi.yaml  | 77 +++++++++++++++++++

No, you do not get two files. No such bindings were accepted since some
years.

>  2 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
>  create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
> new file mode 100644
> index 0000000000000..d9280988f9eb7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dpll/microchip,zl3073x-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2C-attached Microchip Azurite DPLL device
> +
> +maintainers:
> +  - Ivan Vecera <ivecera@redhat.com>
> +
> +description:
> +  Microchip Azurite DPLL (ZL3073x) is a family of DPLL devices that
> +  provides 2 independent DPLL channels, up to 10 differential or
> +  single-ended inputs and up to 20 differential or 20 single-ended outputs.
> +  It can be connected via multiple busses, one of them being I2C.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,zl3073x-i2c

I already said: you have one compatible, not two. One.

Also, still wildcard, so still a no.


> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/dpll/dpll-device.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      dpll@70 {
> +        compatible = "microchip,zl3073x-i2c";
> +        reg = <0x70>;
> +        #address-cells = <0>;
> +        #size-cells = <0>;

Again, not used. Drop.


> +        dpll-types = "pps", "eec";
> +
> +        input-pins {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          pin@0 { /* REF0P */
> +            reg = <0>;
> +            label = "Input 0";
> +            supported-frequencies = /bits/ 64 <1 1000>;
> +            type = "ext";
> +          };
> +        };
> +
> +        output-pins {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          pin@3 { /* OUT1N */
> +            reg = <3>;
> +            esync-control;
> +            label = "Output 1";
> +            supported-frequencies = /bits/ 64 <1 10000>;
> +            type = "gnss";
> +          };
> +        };
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml
> new file mode 100644
> index 0000000000000..7bd6e5099e1ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-spi.yaml

No, you do not get two files. Neither two compatibles, nor two files.
Please look at existing bindings how they do it for such devices.

Best regards,
Krzysztof


