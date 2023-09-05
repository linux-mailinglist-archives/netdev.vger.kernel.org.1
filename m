Return-Path: <netdev+bounces-32123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C2792D61
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB89281182
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E682EDDC7;
	Tue,  5 Sep 2023 18:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922CDDB5
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 18:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B80C433B9;
	Tue,  5 Sep 2023 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693938541;
	bh=HNwxnqVLcUvUgsEtkMxU0rL9+To5Mqbb2eXIaUG0S38=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SfuVpe78aghB8DPNWXGfrTge0/smtp+UAk6OB8SWplYFRWLrpZ99hOBugQ0RDLIq6
	 toGyXtbytFqoZdQw5T0141yeHnGPx9trJQkZCK+hZpuZDalw0hnVwJ2ZKTz7Tj/b63
	 c1+bhVdRVswJzrOozTovGu0SEBDV82uuGQToq5iyz/QQEwsq7iCDR/kqTpcpsLtr1i
	 oPUhcJtpd+WUb8Zh0wnR0CYwyPxRoKFukWkvQJBgUlYwcLzoaGUVjC2kxX2vbuUsvU
	 ScCC0dtYeY2S2RtT0fQIN//Wf4EzSx2AIQlEdwCCqd5PN98sGa5NWDguDFrzGjRMHF
	 NQwv2PC9gln8g==
Received: (nullmailer pid 3757330 invoked by uid 1000);
	Tue, 05 Sep 2023 18:28:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Eric Dumazet <edumazet@google.com>, UNGLinuxDriver@microchip.com, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Arun Ramadoss <arun.ramadoss@microchip.com>, Vladimir Oltean <olteanv@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "Russell King (Oracle)" <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20230905124340.4116542-1-o.rempel@pengutronix.de>
References: <20230905124340.4116542-1-o.rempel@pengutronix.de>
Message-Id: <169393853820.3757299.10173163628142492519.robh@kernel.org>
Subject: Re: [RFC net-next v1 1/2] dt-bindings: net: dsa: microchip: Update
 ksz device tree bindings for drive strength
Date: Tue, 05 Sep 2023 13:28:58 -0500


On Tue, 05 Sep 2023 14:43:39 +0200, Oleksij Rempel wrote:
> Extend device tree bindings to support drive strength configuration for the
> ksz* switches. Introduced properties:
> - microchip,hi-drive-strength-microamp: Controls the drive strength for
>   high-speed interfaces like GMII/RGMII and more.
> - microchip,lo-drive-strength-microamp: Governs the drive strength for
>   low-speed interfaces such as LEDs, PME_N, and others.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/net/dsa/microchip,ksz.yaml          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:54:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
./Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:62:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230905124340.4116542-1-o.rempel@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


