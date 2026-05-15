Return-Path: <netdev+bounces-288223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK0VIgPXBmqDoQIAu9opvQ
	(envelope-from <netdev+bounces-288223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:19:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD5A54B2F5
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D78E03005663
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8C3FB7C1;
	Fri, 15 May 2026 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUuAIplf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85F3FADF4;
	Fri, 15 May 2026 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833130; cv=none; b=YFOXYfm06HEntaWH1F2TZQ2eL6RaD8o8jDw1LJ2XCK2JWc58BE6pQ6+rnOv0s/vVujMWC+B7eOzchIOpOoHWbyEZEj4mvXvIwX6fJEoF/fiBuYUNQj7TpI4o11Ge7bWPbux87gbDvuUR9fzo0HLnul/8OZUfWfdGUm49ExiHQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833130; c=relaxed/simple;
	bh=2oizVG4O3uoNeGTVjU8VPZdS7sVqMY19d5r731hQAzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BS+4NP6TfxPuw+DF47fF0Pl6aGGPFFhLOxjHHzGU+TOnfEQCu9vlTSPD3azQPF2ztznndHtnCaXs4eOzT3eXhLfK9LHiKWaBxW3JdveOpJ+UxJKc9ZI/Nk+Ok6MImVLwinDKXS0dLiUVQye3WEXGFUf1cEB4YnnVGHRS6muy60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUuAIplf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B1DC2BCB0;
	Fri, 15 May 2026 08:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778833129;
	bh=2oizVG4O3uoNeGTVjU8VPZdS7sVqMY19d5r731hQAzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUuAIplfHLWThVdLLDFjzdWYisgqOY7Irqx+VtYdA5NZ7cfUrufOHKfcWAbo99GhW
	 Q8l4r/VQEFccdNdrslxyOpuGEI1yAfhmbfWDq/go8XgADNdNS9uSHhLplAoGcL0cbv
	 UvUPPJY7R24gFA11uhhik/Zn0RnwOGPlO0Q6fiyM2yA1oGYymirbfUfWCD7v+AEpAl
	 483JPCNE7GGVVHPYKekv9RhQEjjl5XfokVqcqqzLmK7RhnoHoVRTpRbV/CKTBmDrVs
	 azZ9KQTwre0iUC5VoymRNQaVfgc/sraBdkCV/9cFt8J5GCZzxvlLmYDpD/ZkCGUcWG
	 r+HvLzeVka4GQ==
Date: Fri, 15 May 2026 10:18:47 +0200
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
Subject: Re: [PATCH v1 3/6] dt-bindings: net: Document Infineon/Intel XMM6260
 modem
Message-ID: <20260515-precious-ginger-lori-d1fde7@quoll>
References: <20260511135703.62470-1-clamor95@gmail.com>
 <20260511135703.62470-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511135703.62470-4-clamor95@gmail.com>
X-Rspamd-Queue-Id: EAD5A54B2F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288223-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:56:58PM +0300, Svyatoslav Ryhel wrote:
> +  ap-wake-gpios:
> +    description: GPIO connected to the EINT3 pin
> +    maxItems: 1
> +
> +  cp-wake-gpios:
> +    description: GPIO connected to the EINT2 pin
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  vbat-supply:
> +    description: Supply connected to the VBAT lines.

This should be rather name of the pin on this device, not the provider
name. VBAT suggests the latter. Please double check.

Rest looks fine, with respect to Sashiko comment on description:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


