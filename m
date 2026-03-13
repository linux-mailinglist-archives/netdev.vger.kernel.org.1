Return-Path: <netdev+bounces-267276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLHQKrR3s2mwWgAAu9opvQ
	(envelope-from <netdev+bounces-267276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:34:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDA327CD0B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A03683018698
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF133FE15;
	Fri, 13 Mar 2026 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcCYKwjA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C33385BC;
	Fri, 13 Mar 2026 02:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369263; cv=none; b=oneWcIAeYkuN4H41Bao/7gJ5qubHMxUEba+BGU/jMZXjfpPN+DvH168I8V6J6TOCP3GmdcrAiO7R+i0qdSF4Of7pDat/HsfbNQ5zq+ick8GnGNOIumjoyeTZyc+Uwox/6JOk0SSONr8fXIaQkSDD8J0kHST+t/nq6NXRs9KL40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369263; c=relaxed/simple;
	bh=fI4DMsqLEbxULT+64Hl2jZcUeY9iULBhKP8OUx2adlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuqgulYScQzeWunX5dOdMnDS/NDTN7QwVXkFUjU2Y9Ko5jTAlDGEYTKZmdtOZ343JN8xpjLpou+8TqgVPnWzTm0QesnhbK82Y7/G+Y9x7jXiu9+OsVCVOxmyWhXBsTIMONfEF41JeHJDl8BKsCGq1rg15sTk6BA2ZcKyoJzpJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcCYKwjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D41CC4CEF7;
	Fri, 13 Mar 2026 02:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773369262;
	bh=fI4DMsqLEbxULT+64Hl2jZcUeY9iULBhKP8OUx2adlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcCYKwjAaTbe42TPu6skNnR42pX3ozbbmWH6WAa9A+ON5RVxKNJg0YgrHdHdIlH2e
	 /SKtBOGHV52hJPL6XqnVnI/RM/P100HpyrxOb7wCh6B5AlpTImeIZVogeSpjBZA28C
	 /RDPzVL08Nq3iEGqM33KIJwkzK8MsyCeIrHHGSmoVKPgg2MD/7oc8hb+0GpQSbe7/r
	 B/2foPwYR2Uwzw30bQZP+wSmEefkG0vi9eCx4ia+eDY4gaI8CMY3YigLOW+ctNeC1W
	 IeRjERcG4zRbRscT5zZubZnp9lJYppdupwyyygvM0nNxaq14tcDX/Xq9jUyUSALKas
	 efy3yzSqXsIXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: inochiama@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	boon.khai.ng@altera.com,
	rmk+kernel@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	joabreu@synopsys.com,
	linux-stm32@st-md-mailman.stormreply.com,
	looong.bin@gmail.com,
	maxime.chevallier@bootlin.com,
	siyanteng@cqsoftware.com.cn,
	conor+dt@kernel.org,
	wens@kernel.org,
	krzk+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	pjw@kernel.org,
	edumazet@google.com,
	palmer@dabbelt.com,
	alex@ghiti.fr,
	spacemit@lists.linux.dev,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	aou@eecs.berkeley.edu,
	vladimir.oltean@nxp.com,
	dlan@kernel.org,
	me@ziyao.cc,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	pabeni@redhat.com,
	weishangjuan@eswincomputing.com,
	netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org,
	quentin.schulz@cherry.de,
	richardcochran@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v9,1/4] dt-bindings: net: Add support for Spacemit K3 dwmac
Date: Thu, 12 Mar 2026 19:34:17 -0700
Message-ID: <20260313023417.1577310-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312012232.373713-2-inochiama@gmail.com>
References: <20260312012232.373713-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267276-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,altera.com,armlinux.org.uk,lists.infradead.org,davemloft.net,lunn.ch,synopsys.com,st-md-mailman.stormreply.com,gmail.com,bootlin.com,cqsoftware.com.cn,google.com,dabbelt.com,ghiti.fr,lists.linux.dev,bp.renesas.com,vger.kernel.org,eecs.berkeley.edu,nxp.com,ziyao.cc,st.com,foss.st.com,redhat.com,eswincomputing.com,gentoo.org,cherry.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DDA327CD0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
dt-bindings: net: Add support for Spacemit K3 dwmac

The GMAC IP on Spacemit K3 is almost a standard Synopsys DesignWare MAC
(version 5.40a) with some extra clock. This patch adds the necessary
compatible string for this device, along with a new binding document
defining the required properties.

> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 38bc34dc4f09..98ebb6276bc6 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -109,6 +109,7 @@ properties:
>          - snps,dwmac-5.10a
>          - snps,dwmac-5.20
>          - snps,dwmac-5.30a
> +        - snps,dwmac-5.40a
>          - snps,dwxgmac
>          - snps,dwxgmac-2.10
>          - sophgo,sg2042-dwmac

[ ... ]

> @@ -656,6 +657,7 @@ allOf:
>                  - snps,dwmac-5.10a
>                  - snps,dwmac-5.20
>                  - snps,dwmac-5.30a
> +                - snps,dwmac-5.40a
>                  - snps,dwxgmac
>                  - snps,dwxgmac-2.10
>                  - st,spear600-gmac

Is snps,dwmac-5.40a missing from the select block? The binding document has
a comment at lines 14-17 stating:

    # Select every compatible, including the deprecated ones. This way, we
    # will be able to report a warning when we have that compatible, since
    # we will validate the node thanks to the select.

Every other snps,dwmac-* version from 3.40a through 5.30a appears in all three
locations: the select block (lines 19-43), the properties.compatible enum
(lines 95-118), and the allOf conditional block (lines 643-673). However,
snps,dwmac-5.40a only appears in the properties.compatible enum and the allOf
block.

Without the entry in the select block, a device tree node using
'snps,dwmac-5.40a' as a standalone compatible (without a vendor-specific first
entry like 'spacemit,k3-dwmac') would not be selected by this schema for
validation.

[ ... ]

