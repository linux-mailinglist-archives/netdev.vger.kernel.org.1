Return-Path: <netdev+bounces-276156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EECjNLBm1WkH6AcAu9opvQ
	(envelope-from <netdev+bounces-276156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:18:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA4B3B4767
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE2573033533
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4352A3783C3;
	Tue,  7 Apr 2026 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuFY7qaC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F86735EDBD;
	Tue,  7 Apr 2026 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593131; cv=none; b=DJymTf8HSRF3rjKyBUvzd5qC9JZs61puHVE6wQAG60mFL4np22mPhvbxM+ppLc6fzLWW5FVjpQ6pnrr0gyeuL7l1I1bb4PLOuGgNM94Nu2e/oC9Vl/6snCi+Rlojrya0Z6JaLUzAAeQHRi++NQsmUgUG/D8M4eAbJ3IiIuqh6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593131; c=relaxed/simple;
	bh=ViI5h2WhcrF75jXj/jYaTHDXaxCdUCwV5ArQTTJ6kQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWQcwGwqamh6qCV4Uz+yRgWnXbaFnu8hCebxmg6zEMelGM2niif2gg7amUmxOCVoUY4/Ylp+ldeUJcbH3dDig3iNV1k9O8X/WJUWZw0RAVhL4VHi6d6a2v4qJ3vGABcZEQC8EcAkUPX73aZXBiPa9VhXIeFlL5DRCTJ7CsHj9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuFY7qaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FCEC116C6;
	Tue,  7 Apr 2026 20:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775593131;
	bh=ViI5h2WhcrF75jXj/jYaTHDXaxCdUCwV5ArQTTJ6kQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuFY7qaCC/Rg0Rl8JdPimIsSqeVcIX7IiXwpt9VBzRTezJ2k5QbLrsME7/Beni1qZ
	 2usL3VeL5K5oJsD750+0BX+wUgETiih+y/WLjkhi+pFip7U4lNd7wYlTjTHm/ZSsvP
	 TbXf+1pjJespFsPCHsROcI4SxbWA5p38ZDKRQsUJRsq6v/cdnPgSZK0f1PDqxRmiMk
	 ORZZeyqxJPqMB3bI/AgGff6F2/svTPvzhc3Xq+Vg8mjcRuuaQe9fGE/Sd55ioG409i
	 L/1E8vjXRh9Uv/f/X3lhUI4YBXSkVqGk6dUUryRtbSBMCr6qlQ5Vw7NNTKnAilFZ0h
	 EtrPTl3hp+Kbw==
Date: Tue, 7 Apr 2026 15:18:49 -0500
From: Rob Herring <robh@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Pasi Vaananen <pvaanane@redhat.com>
Subject: Re: [PATCH net-next v2 4/5] dt-bindings: dpll: add ref-sync-sources
 property
Message-ID: <20260407201849.GA3618101-robh@kernel.org>
References: <20260328080624.593916-1-ivecera@redhat.com>
 <20260328080624.593916-5-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328080624.593916-5-ivecera@redhat.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276156-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FA4B3B4767
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 09:06:23AM +0100, Ivan Vecera wrote:
> Add ref-sync-sources phandle-array property to the dpll-pin schema
> allowing board designers to declare which input pins can serve as
> sync sources in a Reference-Sync pair.  A Ref-Sync pair consists of
> a clock reference and a low-frequency sync signal where the DPLL locks
> to the clock but phase-aligns to the sync reference.
> 
> Update both examples in the Microchip ZL3073x binding to demonstrate
> the new property with a 1 PPS sync source paired to a clock source.
> 
> Reviewed-by: Petr Oros <poros@redhat.com>
> Reviewed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  .../devicetree/bindings/dpll/dpll-pin.yaml    | 11 +++++++
>  .../bindings/dpll/microchip,zl30731.yaml      | 30 ++++++++++++++-----
>  2 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> index 51db93b77306f..7084f102e274c 100644
> --- a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> +++ b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> @@ -36,6 +36,17 @@ properties:
>      description: String exposed as the pin board label
>      $ref: /schemas/types.yaml#/definitions/string
>  
> +  ref-sync-sources:
> +    description: |
> +      List of phandles to input pins that can serve as the sync source
> +      in a Reference-Sync pair with this pin acting as the clock source.
> +      A Ref-Sync pair consists of a clock reference and a low-frequency
> +      sync signal.  The DPLL locks to the clock reference but
> +      phase-aligns to the sync reference.
> +      Only valid for input pins.  Each referenced pin must be a
> +      different input pin on the same device.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

phandle-array is really a matrix. As there are no arg cells here, for 
a list of phandles you need:

items:
  maxItems: 1

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Rob

