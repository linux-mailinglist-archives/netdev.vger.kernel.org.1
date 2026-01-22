Return-Path: <netdev+bounces-252460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L/6Esddcmn5iwAAu9opvQ
	(envelope-from <netdev+bounces-252460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:26:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4566B3BF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3169C30E4427
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F97204C36;
	Thu, 22 Jan 2026 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiIjjTqD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2DC367F2D;
	Thu, 22 Jan 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100665; cv=none; b=dMNrBVXhLUUsb0jrfLEoSQOzVkSwnXmB9S5RGvh3WspNF9Obusb2JWb/c5uIXxGgtywvmBVtSM+JGQYFhV7IsTjVpzarW0BAbTrtihk1AoTb3hJRW2FrvnXNGW2YVu9emd2BDSB2M9RZVirIa9UBiI6t+7+GPlB4BnQ1nIkrnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100665; c=relaxed/simple;
	bh=/mtVAN0RP8289udhD8FKKzimHR1+8kf3y0daA0yHddc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqBJ0VVC6zOBU9DfLNLbAvTk8m3xYn3AeZptCrhV6ROefo8TxIBZJsEIJ4YS9pGX5wZSoRm2AKz3SE3ff5FLlT7FpMwgf9qOPlBK6sgCUJJ8q/vvP+Mv0BUB942XuYE21jwJoK3Zf/BXzQ/+kGRW0j3zf62cPnrlByRjc+VtBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiIjjTqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FA2C116C6;
	Thu, 22 Jan 2026 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769100663;
	bh=/mtVAN0RP8289udhD8FKKzimHR1+8kf3y0daA0yHddc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiIjjTqDgMnWLTZliMyOuLT+0NQqgDioGOcvDjmdYWKR4tPUnjHaLHOI+3+jvcQyk
	 83Gnz57GgeUYnmYtUoUruNOKwRrijZeShiumRaXz0J4CJ9hTruy8dDXzn464aOu8F3
	 Khb+/5PKske/lISXxpms5Z/kHqaHPxoRtK5o1Nin7CDE79IeqKUMuz7TlRbD3UHNK1
	 f/ap7r53UcnIt3OTZn72grzu0V5zwhcDMGuUr+o/4a0dhrtRfPGR+WK1usWc8em6Iz
	 TBF47e7k0HWU1InpeZcx22CLCsTjruJNz87y4VtgEZMzHUqnwv1MQinhHZBtjtDDcH
	 /+1yzQ9qsN/HA==
Date: Thu, 22 Jan 2026 10:51:02 -0600
From: Rob Herring <robh@kernel.org>
To: Damien Dejean <dam.dejean@gmail.com>
Cc: andrew@lunn.ch, krzk+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, hkallweit1@gmail.com
Subject: Re: [PATCH v2 3/4] dt-bindings: net: realtek,rtl82xx: add a property
 to set MDI polarity
Message-ID: <20260122165102.GA2564919-robh@kernel.org>
References: <20260121151506.813783-1-dam.dejean@gmail.com>
 <20260121151506.813783-3-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121151506.813783-3-dam.dejean@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-252460-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC4566B3BF
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 04:15:05PM +0100, Damien Dejean wrote:
> MDI pair polarity is usually configured by the bootloader.  However, on
> some designs the configuration is left untouched during boot and needs
> to be set by the driver.
> 
> Add the property 'realtek,mdi-cfg-polarity' to configure the polarity of
> each pair. Bit 0 to 3 configure the polarity or pairs A to D, if set to
> 1 the polarity is reversed for this pair.
> 
> Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> index c4ced671ecb8..17088c147358 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
> @@ -61,6 +61,13 @@ properties:
>      description:
>        Force normal (0) or reverse (1) order of MDI pairs.
>  
> +  realtek,mdi-cfg-polarity:
> +    description:
> +      A bitmap to describe pair polarity swap. Bit 0 to swap polarity of pair A,
> +      bit 1 to swap polarity of pair B, bit 2 to swap polarity of pair C and bit
> +      3 to swap polarity of pair D.
> +    $ref: /schemas/types.yaml#/definitions/uint32

maximum: 0xf

However, are these properties something that should be common?

Rob

