Return-Path: <netdev+bounces-164058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE9CA2C78E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B0E169298
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304A5246356;
	Fri,  7 Feb 2025 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLBvwhSf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D624634C;
	Fri,  7 Feb 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942943; cv=none; b=GuLSqt/6PY7d9ZxBX6AyTrsRiYYqdXfVNbatwgkPppi79VUy4qwHWPnsUubkXogN1AyMFHWTmj43zPxp95tNwhrlKui8dDS1/NiMTp3ZqxvFVaA5aYiWvcsHSWfsVcINJxvhnJQRd7N/0QAM7AJKZHAq9Y+FkQPQfcaywGm7mf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942943; c=relaxed/simple;
	bh=AoTcZ02x8NClnvVxBy2tDfppdz69+AhmvN+U95ePexs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=O958VWIP63QFM3OOXA3edBUE7tjZ7StYg1GI7kv8Ds/K+nQRrlFeSpHCviCM+gs4PxUm/30gNm9MK3NlTpT9HHfnwCmy7leaQGONVmfE8Zx/LU0VOoqu+c5yNGo6+6UnbEnfL594f12V82519tU9DCZApcst0YrKKM5zUOwGy+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLBvwhSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E38C4CED1;
	Fri,  7 Feb 2025 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738942942;
	bh=AoTcZ02x8NClnvVxBy2tDfppdz69+AhmvN+U95ePexs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FLBvwhSfVOu15xQtkURaeiaZbarhcMQ3wrmky8Vs1OYLzPBcyOjAZNDhh37+B6hTm
	 DDlkcyE63tKMGnrK31wI+oe/KHPP8vIXRxLJbFWPx1pgDwgjgfy8qLqo+PdyrzbikE
	 2Pf+b/aglcIMoAMOCHlPH4zPrroAJ0eL6HdoKLsLaaWVYwtLjXZzK7pVQdlg5pIHKl
	 l+5a/sio2Voj29XU9PUYVFrityIfTtcYIgAF8v+sSicwB8+hnVZSIL42lHpJFaffdF
	 8H04lIC0dHFHTNPsk8hJl9mbPycfr06/nH4RnrvXbZtmvj6QArwXlCtqXq+iOx2H1d
	 cTmAY2BAtZg3Q==
Date: Fri, 07 Feb 2025 09:42:21 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de, 
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
 devicetree@vger.kernel.org, Woojung Huh <woojung.huh@microchip.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
In-Reply-To: <20250207143226.2026099-2-o.rempel@pengutronix.de>
References: <20250207143226.2026099-1-o.rempel@pengutronix.de>
 <20250207143226.2026099-2-o.rempel@pengutronix.de>
Message-Id: <173894294099.518356.6333585913978220723.robh@kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: sound: convert ICS-43432 binding
 to YAML


On Fri, 07 Feb 2025 15:32:24 +0100, Oleksij Rempel wrote:
> Convert the ICS-43432 MEMS microphone device tree binding from text format
> to YAML.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/sound/ics43432.txt    | 19 -------
>  .../bindings/sound/invensense,ics43432.yaml   | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/invensense,ics43432.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/invensense,ics43432.yaml: properties:compatible:oneOf: [{'const': 'invensense,ics43432'}, {'const': 'cui,cmm-4030d-261'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250207143226.2026099-2-o.rempel@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


