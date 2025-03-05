Return-Path: <netdev+bounces-172017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A842AA4FEB4
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D24D16AAEC
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2302451F3;
	Wed,  5 Mar 2025 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mot1R8g0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7320551D;
	Wed,  5 Mar 2025 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178069; cv=none; b=jKKMIcjV70lFZaLqKPjrt5Uz0KV+q9sCAgZxWdXJDhFDwG0KUZDNDurd8ftMrhJp0JGYi4gg/rJQgqNJBKkIbDJ18nGse8hsHPLZ5POjB7qfkYFWJLrAXlzixiI7DAM8gvgqjEUttYvgzhKrt3DbShT2d43019qnDqts2tQLLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178069; c=relaxed/simple;
	bh=cOl0I3/cH0eRw0BhDrssA5OJL4SDNbydbLyFqtxZWgA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=pQ9cFBG5zSxjQcbMo0XljphzUhIDtVg93NwVuViWo8k+1M+yqBx3KLL7ipvNQ7vyKSaSf0tC+/fgbX1pfiO2/V7gMdFgLbnuV+PtvcNrW98S0QZ8XlWLWbIno65Tig76h/R51ymY3gclfub6yj8NCiBKkAqbVb1iIMV0emYQn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mot1R8g0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191E2C4CEE2;
	Wed,  5 Mar 2025 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741178069;
	bh=cOl0I3/cH0eRw0BhDrssA5OJL4SDNbydbLyFqtxZWgA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=mot1R8g0Bq6HJHmLbShpe0RIfR7Oq6SFDLlA1K5ZsnCqe7w7gZhwJJgjFaucGGqo6
	 RI+s7zzzmGQJBSCLytJmqFBDtY6I/H0Nn+G01GcLNyuUb9m54opc2Z5XcEaGn8QfdE
	 0tXaPadHffc6pTRkmtX1aVKJkoodcPU+krgK5PDT+90A8dDB51h6+iCoXp7I9DppN7
	 1sDzCE2dcf43i3axrQVvq86FSHfdaH02p/vwQGzglACHaqtNnisi57HQNFL2Gi6DIF
	 KGq7Qa91S3hT5/04dgmI4AG1qw/zqu+K6wh9NmA83CEw1w3c1QrqzVPA0JjzDnvIKe
	 7MVwx7ZxQ3CSQ==
Date: Wed, 05 Mar 2025 06:34:27 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Woojung Huh <woojung.huh@microchip.com>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de, 
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
In-Reply-To: <20250305102103.1194277-2-o.rempel@pengutronix.de>
References: <20250305102103.1194277-1-o.rempel@pengutronix.de>
 <20250305102103.1194277-2-o.rempel@pengutronix.de>
Message-Id: <174117806721.1245382.8322491579922154490.robh@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: sound: convert ICS-43432 binding
 to YAML


On Wed, 05 Mar 2025 11:21:00 +0100, Oleksij Rempel wrote:
> Convert the ICS-43432 MEMS microphone device tree binding from text format
> to YAML.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> changes v4:
> - add Reviewed-by: Rob...
> changes v3:
> - add maintainer
> - remove '|' after 'description:'
> changes v2:
> - use "enum" instead "oneOf + const"
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/invensense,ics43432.yaml: maintainers:0: 'N/A' does not match '@'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250305102103.1194277-2-o.rempel@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


