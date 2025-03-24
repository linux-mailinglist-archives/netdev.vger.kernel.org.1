Return-Path: <netdev+bounces-177093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A410A6DD3E
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A041F169DEB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E207A25F999;
	Mon, 24 Mar 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ/KkIH6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8625C6FE;
	Mon, 24 Mar 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827311; cv=none; b=tWW/+6hIctYjLA5NWSdr6hqWORRVnUHbLqCnIxAZYwKK/hawkbjn9CiIp3NzVmqIZPePc1gRlUT+zIKofVxkrIponfRpSRtiNiA9udx43K8HiVUrfecN8mycjGFA2kOoMIc/yhlWejCZLTINMdvQkPuL1D9q3qhnnQ4SXp+JNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827311; c=relaxed/simple;
	bh=YfVWxHAYJIybK6Bu/EwqsJlpFx18mzNIBVVVkxgBMO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/8+gHvv1d6gGzDvb3Yffd6vvY4CBZxgQnMc86rWf2HNefDDlWxC3NhTneHl2HF14nraoYlD+FLVan1u/Sh33V83P3fTlpWSVtuMpCqvJooPg6EnXBpp2me5ewimDvQ6N490Q1vVO8/ctWf8W2dI70vnvwnuEAhTJpUi+1TCHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ/KkIH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BE6C4CEDD;
	Mon, 24 Mar 2025 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742827311;
	bh=YfVWxHAYJIybK6Bu/EwqsJlpFx18mzNIBVVVkxgBMO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZ/KkIH6/I5A0FhoWMGG286XrLaW83OnQG4BwgOpRHTDnmzPFDE1JRpcKkuIMUprf
	 9NwrueK9sW76wQgKTRJVC3SBIvwkzecL53izJyIwFzby/bPXkwG0sPy/8jaxcpH1PT
	 NqQP7Efw46oABDWS7hsGJgs7+p0IFa37I5DI4zT9r3aCarpZLQCUtyAyuOaJ49KEXD
	 YW9xPRECfJKk+cUeptO2NtcChT5bv3h9vX/ll8mvZYSpKbEXVei8SKac9wGJexdmy+
	 gMAHEsJmRzAtWJmr2oBJIAs9yF5sRkkSGHQqCHCrEMvcSwPsbm+JwKYKjsc2XQODUZ
	 5vzQhODbZMNNw==
Date: Mon, 24 Mar 2025 09:41:49 -0500
From: Rob Herring <robh@kernel.org>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Colin Foster <colin.foster@in-advantage.com>,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH 1/2] Revert "dt-bindings: net: mscc,vsc7514-switch:
 Simplify DSA and switch references"
Message-ID: <20250324144149.GB11614-robh@kernel.org>
References: <20250324085506.55916-1-ravi@prevas.dk>
 <20250324085506.55916-2-ravi@prevas.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324085506.55916-2-ravi@prevas.dk>

On Mon, Mar 24, 2025 at 09:55:05AM +0100, Rasmus Villemoes wrote:
> The commit log for commit 7c93392d754e ("dt-bindings: net:
> mscc,vsc7514-switch: Simplify DSA and switch references") says
> 
>   The mscc,vsc7514-switch schema doesn't add any custom port
>   properties
> 
> In preparation for adding such a custom port property, revert that
> commit.

This leaves the schema in wrong state until the next patch and doesn't 
really stand on its own. So I would combine the 2 patches.

> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  .../bindings/net/mscc,vsc7514-switch.yaml          | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml b/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
> index 86a9c3fc76c89..07de52a3a2951 100644
> --- a/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
> @@ -24,7 +24,7 @@ allOf:
>          compatible:
>            const: mscc,vsc7514-switch
>      then:
> -      $ref: ethernet-switch.yaml#/$defs/ethernet-ports
> +      $ref: ethernet-switch.yaml#
>        required:
>          - interrupts
>          - interrupt-names
> @@ -33,18 +33,28 @@ allOf:
>            minItems: 21
>          reg-names:
>            minItems: 21
> +        ethernet-ports:
> +          patternProperties:
> +            "^port@[0-9a-f]+$":
> +              $ref: ethernet-switch-port.yaml#
> +              unevaluatedProperties: false
>  
>    - if:
>        properties:
>          compatible:
>            const: mscc,vsc7512-switch
>      then:
> -      $ref: /schemas/net/dsa/dsa.yaml#/$defs/ethernet-ports
> +      $ref: /schemas/net/dsa/dsa.yaml#
>        properties:
>          reg:
>            maxItems: 20
>          reg-names:
>            maxItems: 20
> +        ethernet-ports:
> +          patternProperties:
> +            "^port@[0-9a-f]+$":
> +              $ref: /schemas/net/dsa/dsa-port.yaml#
> +              unevaluatedProperties: false
>  
>  properties:
>    compatible:
> -- 
> 2.49.0
> 

