Return-Path: <netdev+bounces-254201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECCFLNLqeWkF1AEAu9opvQ
	(envelope-from <netdev+bounces-254201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:54:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5304E9FC01
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28AC4300C904
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3475C332EA7;
	Wed, 28 Jan 2026 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViEGIoH8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B792EA75E;
	Wed, 28 Jan 2026 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597551; cv=none; b=lnfqWINouIKamn3RffRzWXZCSKkHkwDwnwl6dw2Y8FEp7dTfeMQwgJRCi/4M6u8VdEtfx3a7p0ra+/IupaaaI85GiYFsOYknZrucnQtg0WBU+7nbs4FJT6w+262o6LoFeuzy6bwWxi0o2FOEpv0G/6pqZeVe2mWXapzd9yCgArw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597551; c=relaxed/simple;
	bh=tucQhTlV8za1lu8MMrRqeJJ31gz69ypAvVJoriihhkE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=vABlLNeVHXwyRZkaBeP19GAgNd07Yvv4M2TRY/oT3CFjW0jcfXYVqC3w3Tijm0XXrAdiFIah4TK0YcsjmnR2qjs9mp/YS3JyBf1tw2Hj1exyUqPxN0AEhieiuiYTmqWhhu3pYMj/jsk8Nbxvs3z86M++3bkSnOqX11J8KpGDTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViEGIoH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B58EC4CEF1;
	Wed, 28 Jan 2026 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769597550;
	bh=tucQhTlV8za1lu8MMrRqeJJ31gz69ypAvVJoriihhkE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ViEGIoH8WISDNhvOrX04vjPKG2JsdeQzC++K+VPDpBjbApVieCzQdka6GCKlJJZQM
	 kJma+zcQwuo0OVZDkJ15DjXbzkJ9jCcPYFv4ZlKyk1P9KnmzLQuxjdWdoLG47nEIi/
	 zDbiLcOCm7Dj8/UDWp4qXwoh+OOdf+L3B0wjytpMZK6giYRDkSx+hHnimaxwvwfELy
	 OLDor3AvwD6N+RNTuPJXi6Y3MM9lSyGyv0Z99LeemMHZfyE7wejSGsaHHCdxLWt2ES
	 SxedeNVs95NdSTuG1A+uh5Pq9Tj0kMP2VBUO0csiNlt3bDroJsfIcRiQ3H/JGbcUtO
	 KJ8VHi9KMczbw==
Date: Wed, 28 Jan 2026 04:52:29 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Yao Zi <ziyao@disroot.org>, 
 Longbin Li <looong.bin@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, 
 Choong Yong Liang <yong.liang.choong@linux.intel.com>, 
 Yixun Lan <dlan@gentoo.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul Walmsley <pjw@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Yanteng Si <siyanteng@cqsoftware.com.cn>, spacemit@lists.linux.dev, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Shangjuan Wei <weishangjuan@eswincomputing.com>, 
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
 Chen-Yu Tsai <wens@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Alexandre Ghiti <alex@ghiti.fr>, Jose Abreu <joabreu@synopsys.com>, 
 "David S. Miller" <davem@davemloft.net>
To: Inochi Amaoto <inochiama@gmail.com>
In-Reply-To: <20260128072931.875041-2-inochiama@gmail.com>
References: <20260128072931.875041-1-inochiama@gmail.com>
 <20260128072931.875041-2-inochiama@gmail.com>
Message-Id: <176959754960.624625.3292309980701778789.robh@kernel.org>
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: Add support for
 Spacemit K3 dwmac
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254201-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,eecs.berkeley.edu,lunn.ch,kernel.org,disroot.org,gmail.com,st-md-mailman.stormreply.com,linux.intel.com,gentoo.org,cherry.de,redhat.com,bp.renesas.com,foss.st.com,st.com,altera.com,cqsoftware.com.cn,lists.linux.dev,dabbelt.com,eswincomputing.com,google.com,bootlin.com,armlinux.org.uk,ghiti.fr,synopsys.com,davemloft.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5304E9FC01
X-Rspamd-Action: no action


On Wed, 28 Jan 2026 15:29:27 +0800, Inochi Amaoto wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.example.dtb: ethernet@cac80000 (spacemit,k3-dwmac): compatible: ['spacemit,k3-dwmac', 'snps,dwmac-5.40a'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.example.dtb: ethernet@cac80000 (spacemit,k3-dwmac): compatible: ['spacemit,k3-dwmac', 'snps,dwmac-5.40a'] does not contain items matching the given schema
	from schema $id: http://devicetree.org/schemas/net/spacemit,k3-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/spacemit,k3-dwmac.example.dtb: ethernet@cac80000 (spacemit,k3-dwmac): Unevaluated properties are not allowed ('phy-handle', 'phy-mode' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/spacemit,k3-dwmac.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260128072931.875041-2-inochiama@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


