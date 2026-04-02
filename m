Return-Path: <netdev+bounces-274407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFK+IT4dzml7lAYAu9opvQ
	(envelope-from <netdev+bounces-274407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:39:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF543854F8
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB1DD30F0A35
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910D038B7A6;
	Thu,  2 Apr 2026 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9ShTm8P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB938B130;
	Thu,  2 Apr 2026 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114870; cv=none; b=pam+yBdkHbC8SJ1u0cQmshVcehW0j3BytrTiuaxS4Qf6ExIU5mfiuBu+deV3zmVy0p26KnYrsKhzP7nldGJkzMH9KPyfVOk5WNlaGkT+AwksQASMwQaUoabztcD6OsMgelrSHxda4v+YKWpy1Jc4doOJ6VZ5sjr5FrhWNcP3+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114870; c=relaxed/simple;
	bh=5bRmQu9RvXClAs1iQSBeDGNT17zARgjIP+fvVutZf3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWE7re9/cRh5PRgliGffwXLac0y4thotN6nWYYHsLFOE71rwGn3tBmWFT8gZGfXVBEE7JOPdR/QvnSYh95MrMP98jSlnskO1bWyF3u+12G/wfhjpDZBRycSKnUdJWB1vRZQaX1zFWuH+Y6MKZxaYgWAFwJ+q3B9Bj9Y3C//oO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9ShTm8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538C8C19423;
	Thu,  2 Apr 2026 07:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775114869;
	bh=5bRmQu9RvXClAs1iQSBeDGNT17zARgjIP+fvVutZf3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9ShTm8PDRbfUkdE2e8mHA6CENFhMOiZjJlaUOV+LDDB35fjc6k2zilgX/TrwmJal
	 FOvXn6YWtFw6qmigqe/nFB5W4OO1pXv9HA8amyqLS2mBan2o+6JxuTRqjpiO5M34UY
	 XsJwXuhBkdWUJCf3/7AGcEcabFjA38M7h1FIJkqsfnjXvq0JQYy487pRkXambMbyfT
	 53Qes3UBdJe6dc2+jQgoYs9wQ08TNJHATIUcv5ZlRipcllGLi+6rMEJvAS8QciMttb
	 V/SIkpejAErs+Dhn1ezID1cClJMBXtByHDUfF8N5jsbhGNrsVIrIIyLeHyxhv7ELU1
	 8iYezR9Y+rHvw==
Date: Thu, 2 Apr 2026 09:27:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH v3 2/5] dt-bindings: phy: ti: phy-gmii-sel: Add
 ti,j722s-phy-gmii-sel compatible
Message-ID: <20260402-curly-heavy-bustard-bd8c63@quoll>
References: <cover.1775045279.git.nora.schiffer@ew.tq-group.com>
 <5ac1c52827a1a246584dddb62335f9ce4715eceb.1775045279.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ac1c52827a1a246584dddb62335f9ce4715eceb.1775045279.git.nora.schiffer@ew.tq-group.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274407-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:email]
X-Rspamd-Queue-Id: DCF543854F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 02:25:22PM +0200, Nora Schiffer wrote:
> The J722S gmii-sel is mostly identical to the AM64's, but additionally
> supports SGMII. The AM64 compatible ti,am654-phy-gmii-sel is used as a
> fallback.
> 
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> ---
>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 24 ++++++++++++-------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> index be41b4547ec6d..6e12a75100eb8 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> @@ -47,15 +47,21 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - ti,am3352-phy-gmii-sel
> -      - ti,dra7xx-phy-gmii-sel
> -      - ti,am43xx-phy-gmii-sel
> -      - ti,dm814-phy-gmii-sel
> -      - ti,am654-phy-gmii-sel
> -      - ti,j7200-cpsw5g-phy-gmii-sel
> -      - ti,j721e-cpsw9g-phy-gmii-sel
> -      - ti,j784s4-cpsw9g-phy-gmii-sel
> +    oneOf:
> +      - items:

Same comments.

Best regards,
Krzysztof


