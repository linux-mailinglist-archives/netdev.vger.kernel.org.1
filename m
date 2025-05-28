Return-Path: <netdev+bounces-194066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EF7AC72E7
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 23:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E025E3B1C34
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 21:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD9D20409A;
	Wed, 28 May 2025 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8KokwNk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4EB258A;
	Wed, 28 May 2025 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468815; cv=none; b=QZdReZ6VokYse1zcIy4yhshkfMOs61368C9LhIIIswu9Iq+PaEKU3L15pg9TjzxB4cu6utjhAC9Gpxo7jlIF6qF09V8PebKwsscV/DPauz4CCy6DJzbLLcx3dK8V3HbqNJA00hz/WjiHx+N8wFVNFLf0Kx3RMNq51bFrNZNtqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468815; c=relaxed/simple;
	bh=CZTRZElqhH4l12BYQJ1PByvJD18+afJisSpa39ZSYNs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=MYUQvihQwvdSGhmnXFZTY4TGB90sFT3/zaD2D6BXsvh44IoZ1OEqQMKKNcDZqyrCieieI9iPhu24V3+LZqjcwYyJYZ5HHqYUCXtKSya+OLEL0g7qnq5TXsin/eMEwFwme8PDdU9w5s9meiKMmeOzJZc5iTC84kGeErwQeONMUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8KokwNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C241C4CEE3;
	Wed, 28 May 2025 21:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748468814;
	bh=CZTRZElqhH4l12BYQJ1PByvJD18+afJisSpa39ZSYNs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=E8KokwNkldu2f0Gj6DqG3yOBBH48oHX5XBS9oypWW9WA74WwoLdNKIH6dyDGsOAOW
	 xQd/hY6eEP0eSSbwML8iIRlU2HSvxymmDSqCYCmyMftai2nSgd8w1BeDUDbe/CRGAG
	 +s+94Mcq7CoSpFI5sCrLtQA5dqXcEvwMTgWOE1jxcXTY4mnh4pI1B81o28bhHjoINU
	 FYz08jv+lQKDnz2Fu0CKGtoCd7MmzIK8byzPxo2qCdLk3VBsDlsvZBmrR6GdmBTkwa
	 aKZx12tNKWP0DbA9iChL5cZF+LKatrSFQuRFtx+5LmNpTdzfphxPJ9c204U00dtgkV
	 ZsR6UKld1s1DQ==
Date: Wed, 28 May 2025 16:46:52 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew@lunn.ch>, Marek Vasut <marex@denx.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 Woojung Huh <woojung.huh@microchip.com>, Conor Dooley <conor+dt@kernel.org>, 
 Woojung Huh <Woojung.Huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>
To: Corentin Guillevic <corentin.guillevic@smile.fr>
In-Reply-To: <20250528203152.628818-1-corentin.guillevic@smile.fr>
References: <20250528203152.628818-1-corentin.guillevic@smile.fr>
Message-Id: <174846881248.859527.7504198795486149705.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: net: dsa: microchip: add bit-banged SMI
 example


On Wed, 28 May 2025 22:31:51 +0200, Corentin Guillevic wrote:
> KSZ8863 can be configured using I2C, SPI or Microchip SMI. The latter is
> similar to MDIO, but uses a different protocol. If the hardware doesn't
> support this, SMI bit banging can help. This commit adds an device tree
> example that uses the CONFIG_MDIO_GPIO driver for SMI bit banging.
> 
> Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
> ---
>  .../bindings/net/dsa/microchip,ksz.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:246:1: [error] missing document start "---" (document-start)
./Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:246:3: [error] syntax error: expected '<document start>', but found '<block sequence start>' (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml: ignoring, error parsing file
Traceback (most recent call last):
  File "/usr/bin/yamllint", line 33, in <module>
    sys.exit(load_entry_point('yamllint==1.29.0', 'console_scripts', 'yamllint')())
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 228, in run
    prob_level = show_problems(problems, file, args_format=args.format,
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 113, in show_problems
    for problem in problems:
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 200, in _run
    for problem in get_cosmetic_problems(buffer, conf, filepath):
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 137, in get_cosmetic_problems
    for problem in rule.check(rule_conf,
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 583, in check
    yield from _check(conf, token, prev, next, nextnext, context)
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 344, in _check
    if expected < 0:
       ^^^^^^^^^^^^
TypeError: '<' not supported between instances of 'NoneType' and 'int'
./Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:246:3: but found another document
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/dsa/microchip,ksz.example.dts'
Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:246:3: but found another document
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/dsa/microchip,ksz.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1524: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250528203152.628818-1-corentin.guillevic@smile.fr

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


