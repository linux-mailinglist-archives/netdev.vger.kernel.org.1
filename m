Return-Path: <netdev+bounces-288224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIuHBOfYBmrKoQIAu9opvQ
	(envelope-from <netdev+bounces-288224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:27:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E154B442
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E289F302BA77
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B84E3FA5C2;
	Fri, 15 May 2026 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdGnmdzU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077E53033FC;
	Fri, 15 May 2026 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833243; cv=none; b=rpWUH6Adp7f5YeN9yO5pTRjXlR1cNR6d+l8rQCkzL/wDKa4+/T87IDrDUvtPbTI7lDRycTODZN4UBY6WPPxCtsf6FIyAwqT4VqHjpV0t40OSuXoYjolXav/SvThCZTXAC6iLwoPPBEW6gMqhan9NOFMNUZ+pYtjBZYLVsaHgIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833243; c=relaxed/simple;
	bh=UXJ65w8VdygtsSiOLKk+/N2cT36BTANVHhYswQ/RPdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgM6kqqEAdGXY1g6RKea5OGbCNoOctGFpMgr748YXBqvOOT9A7fRn61zCRQ+8GAVzFY9PVpPshi4J6xSrtPs9YtGRIGupCg1AE7FgZMd+N5xjwIeW46BAR/AcZehdmikdR8p0j46GKkb/gRcfRJk3ATPweBbjVqtP6kSquvC1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdGnmdzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27086C2BCB0;
	Fri, 15 May 2026 08:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778833242;
	bh=UXJ65w8VdygtsSiOLKk+/N2cT36BTANVHhYswQ/RPdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TdGnmdzUXmRp4XyIhXkGePu9VPDDqo2q/PTIRIoTZP5jf7K1nghUkUrVS2LeWr3cN
	 zLLo2vmjFdoh06UoDcKYF3sBtFA/5EcmZkdBVwNyLPS1Q8Vpj0FDYrITPX0N7qEEN1
	 Vj5iCzRXFVwiDkvBdCdMp1VPQGLQ20deQTl/4PvQaowW7yJIgdjpgpAD8QgDcEUxIH
	 GAeQ7s10v77TCsa2t+WnKFkElHQnyiKP+5pDIZxD6K86X2508Q65BeKAbXiVcg9RTw
	 Ee5igPbNo+hJEBJIJhf60iuwwFqU9odPnKXKrSqgBtq5Zv2H2IW/q5mYhIYnJDtOSe
	 He7EzmFGR7JlA==
Date: Fri, 15 May 2026 10:20:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Chen <peter.chen@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 5/6] dt-bindings: phy: tegra: Document Nvidia Tegra
 XMM6260 PHY
Message-ID: <20260515-utopian-malamute-of-patience-367e8e@quoll>
References: <20260511135703.62470-1-clamor95@gmail.com>
 <20260511135703.62470-6-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511135703.62470-6-clamor95@gmail.com>
X-Rspamd-Queue-Id: 994E154B442
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288224-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:57:00PM +0300, Svyatoslav Ryhel wrote:
> Document the XMM6260 PHY used by various devices based on the Nvidia Tegra
> SoC, describing its usage
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/phy/nvidia,tegra-xmm6260.yaml    | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml
> new file mode 100644
> index 000000000000..0346433c9772
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/nvidia,tegra-xmm6260.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvidia Tegra PHY for XMM6260 modem

XMM6260 is Infineon modem, so any combination with nvidia,tegra is very
confusing.

> +
> +description:
> +  A hardware configuration used in Tegra SoCs to provide proper interaction
> +  between the application processor and the modem, as well as control over
> +  one of the SoC's USB lines for the modem.
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra-xmm6260

Also here.

What sort of phy is this? So far looks more like a software construct.

Best regards,
Krzysztof


