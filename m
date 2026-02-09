Return-Path: <netdev+bounces-257968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD5/IHEgimnLHQAAu9opvQ
	(envelope-from <netdev+bounces-257968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 18:59:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D893D11353A
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 18:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED9403074E34
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB25130BBB6;
	Mon,  9 Feb 2026 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgj/maFW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AB2D5C97;
	Mon,  9 Feb 2026 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659715; cv=none; b=gMa4RP8PUswfGxUX2vVZHRp1lyDSBNGCX7TE2F9SiGzeyXyRCvGTadBHpG8vRr7BfmxX74aIgPp8SSePxcTDjANGoGChYliOtkXnLaTjz2Z59Th/ichy0EuZ5zdxcyGuhdjCciZTcr6/51cTyUY1rnNH8EfMtAhmZwAlRgrJBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659715; c=relaxed/simple;
	bh=EnTNUJHmSxT2WRAs+oWYX8bdwlK9D+48BwdN8Orgt7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VonZvRZ0yymNHtGWRT1EEYh2RTIdh65qvToLuTJ13pPDGkOAL6K+WLt6C1AZmNWgnrhmwdIgTH8UESSCP31rVx+IvioV4UGpcW9HOkHSwZu1UXs1LRISCTDj5PHBUnB64EZsOanJnLg2FNVrAvUwRXapCOBsAOpztSEIyclMiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgj/maFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A6FC116C6;
	Mon,  9 Feb 2026 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770659715;
	bh=EnTNUJHmSxT2WRAs+oWYX8bdwlK9D+48BwdN8Orgt7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zgj/maFW5QBdpanoskzhhOvikPz/Ns+ctuK+nd23tjE39S637yYBNIdYcQV1xLoEs
	 MAvtPqQJ96P2MTGMIooSvlQ/HM7RAEIF6Ebj4eVEON3Qcz6FblOPFj9VpqMP6aVRq7
	 1vHRNgEMLU+ttI8tLmoN9NC0AvbxXOfpWP7QTQtbtZ8SHlt5hcnvvKCGmOwxj/eNeL
	 dk3FN6gNnj5XhTov798gmAT7dFgVNNx4CmaRUbCAQYA8dZF/zEebnM0aEt6UkXwQX1
	 Isq8XWO/xVJxHsvlX+nERQP1BkQ8deSp40wNxcUcreLYay7zzYt4yRtGd/VRzOvIDW
	 gZMmZjvQdNfLg==
Date: Mon, 9 Feb 2026 11:55:14 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Yanteng Si <siyanteng@cqsoftware.com.cn>, devicetree@vger.kernel.org,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-riscv@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Yao Zi <ziyao@disroot.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, spacemit@lists.linux.dev,
	Richard Cochran <richardcochran@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	linux-arm-kernel@lists.infradead.org,
	Zhi Li <lizhi2@eswincomputing.com>, Alexandre Ghiti <alex@ghiti.fr>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Longbin Li <looong.bin@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Paul Walmsley <pjw@kernel.org>
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: Add support for
 Spacemit K3 dwmac
Message-ID: <177065971340.1488943.5040519418733629528.robh@kernel.org>
References: <20260130022705.1059214-1-inochiama@gmail.com>
 <20260130022705.1059214-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130022705.1059214-2-inochiama@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257968-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[cqsoftware.com.cn,vger.kernel.org,synopsys.com,davemloft.net,lists.infradead.org,armlinux.org.uk,bp.renesas.com,lunn.ch,disroot.org,bootlin.com,st.com,dabbelt.com,lists.linux.dev,gmail.com,foss.st.com,redhat.com,kernel.org,altera.com,eswincomputing.com,ghiti.fr,st-md-mailman.stormreply.com,cherry.de,gentoo.org,google.com,eecs.berkeley.edu];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D893D11353A
X-Rspamd-Action: no action


On Fri, 30 Jan 2026 10:27:02 +0800, Inochi Amaoto wrote:
> The GMAC IP on Spacemit K3 is almost a standard Synopsys DesignWare
> MAC (version 5.40a) with some extra clock.
> 
> Add necessary compatible string for this device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
>  .../bindings/net/spacemit,k3-dwmac.yaml       | 103 ++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/spacemit,k3-dwmac.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


