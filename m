Return-Path: <netdev+bounces-303765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RwsFHYxARWq49QoAu9opvQ
	(envelope-from <netdev+bounces-303765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3066EFCDE
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:30:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SwtQnZ96;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303765-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303765-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBBF1301D046
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2D9367B7F;
	Wed,  1 Jul 2026 16:24:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E2366816;
	Wed,  1 Jul 2026 16:24:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923067; cv=none; b=RokDcQq4CdTo3l9l72E1Euabb4BFYB+X2MbL2nbuWcBITFb/DGwVGTES1TVBc47UxFUym/63QkpzS5mLtclheHdP9NYOz/daVkDgyDEocyJrk42tTGxqRaXZhgqQ1xe3t2GJrSDhRabVAwC3wUlTv58nQ4sGSuQew9K1hGkOu4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923067; c=relaxed/simple;
	bh=PkQmqwbgSjT5aMMiQj1i8sYD8hdwFPcTFD7ghp7SVAM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=DyIv7L+Snne8kHwgBU4gvnTgtmUQ5jU5qCOrLj8ChSLzXu6g0bVhCFwcpO8tHEJwXHL6+26lxJHcqfVHoalG8+Y9bz+47QgRr6j5GLcjnX2WUSGhqQpPTojEWjxOe2j6RL8yKyNPxQtR9cqfv7qLr3lYdXbSUXm9pPc+vO6N1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwtQnZ96; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A061F000E9;
	Wed,  1 Jul 2026 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782923065;
	bh=dQbBlkNyShZgl6jx6OlwULDQXonRARNTYcAllSQ/B9U=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=SwtQnZ96zoZhDDv5bku1HcaOWLPPGhIElTYWLAl7g5ozDyFVuHrDxlCKsxe2tnFK1
	 84055kA9AfD+vRLgMAx/eq68Bl0h9UTkkY3GDMYVFrt8cQZsrB89h2ETyEuxbobAGg
	 bTVJz6mmEuAnTH0Z9MKTNzsnN54hwblnw4ewbCAIA6O/tllnvzKpX3UqQjgGjBMdAH
	 +hikVObjG2l4s3QR1I2P2VtTHWhI+YYD9WBgAwtBn5slQrY845Db3sJx73xcdIm57l
	 prk40ttbIjtqy8jNtkoBXaQQlkWYWoXV+YDTCWLk8dThdnyvXprJX9y06zxh3sOTxX
	 MjRr1bENc8HaQ==
Date: Wed, 01 Jul 2026 11:24:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Richard Cochran <richardcochran@gmail.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, netdev@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Brian Masney <bmasney@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Stephen Boyd <sboyd@kernel.org>, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, kernel@collabora.com, 
 Michael Turquette <mturquette@baylibre.com>, 
 Edward-JW Yang <edward-jw.yang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
In-Reply-To: <20260701-mt8189-clocks-system-base-v1-2-2b048feea50a@collabora.com>
References: <20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com>
 <20260701-mt8189-clocks-system-base-v1-2-2b048feea50a@collabora.com>
Message-Id: <178292306474.849869.14658483953316030995.robh@kernel.org>
Subject: Re: [PATCH 02/15] dt-bindings: clock: mediatek: regroup MT8188
 dt-bindings into MT8186
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303765-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:richardcochran@gmail.com,m:chun-jie.chen@mediatek.com,m:netdev@vger.kernel.org,m:angelogioacchino.delregno@collabora.com,m:bmasney@redhat.com,m:p.zabel@pengutronix.de,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:sboyd@kernel.org,m:linux-mediatek@lists.infradead.org,m:krzk+dt@kernel.org,m:kernel@collabora.com,m:mturquette@baylibre.com,m:edward-jw.yang@mediatek.com,m:matthias.bgg@gmail.com,m:conor+dt@kernel.org,m:linux-clk@vger.kernel.org,m:louisalexis.eyraud@collabora.com,m:krzk@kernel.org,m:matthiasbgg@gmail.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,mediatek.com,collabora.com,redhat.com,pengutronix.de,lists.infradead.org,kernel.org,baylibre.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B3066EFCDE


On Wed, 01 Jul 2026 15:11:07 +0200, Louis-Alexis Eyraud wrote:
> Regroup the MT8188 clock and system clock dt-bindings into MT8186 ones
> to ease maintainability and have common files for several currently
> supported SoC or new future ones, that have the same kind of clock
> controller design.
> 
> Note:
> The `#clock-cells` property is a required property for all compatibles
> declared in MT8188 clock and system clock dt-bindings but not in MT8186
> ones.
> To avoid ABI breakage, conditional blocks to check this requirement
> for MT8188 compatibles are added, rather than enforcing it for MT8186
> compatibles.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  .../bindings/clock/mediatek,mt8186-clock.yaml      | 82 ++++++++++++++++++-
>  .../bindings/clock/mediatek,mt8186-sys-clock.yaml  | 20 ++++-
>  .../bindings/clock/mediatek,mt8188-clock.yaml      | 93 ----------------------
>  .../bindings/clock/mediatek,mt8188-sys-clock.yaml  | 58 --------------
>  4 files changed, 100 insertions(+), 153 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml:62:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260701-mt8189-clocks-system-base-v1-2-2b048feea50a@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


