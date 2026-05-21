Return-Path: <netdev+bounces-290336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULH1K73eDmoVCwYAu9opvQ
	(envelope-from <netdev+bounces-290336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:30:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA495A3531
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0740E306EB0A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B911539AD3B;
	Thu, 21 May 2026 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCYqjYat"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709B3955C4;
	Thu, 21 May 2026 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358518; cv=none; b=jJMy7MdADLZ0MXihtsRVNb9IB6tXcTbjwhmR/c3gD/V+ueIY2KUh972mTyqIZWFm4upKUIuGBfggdhLMfAcxKHUctHiGhBDcwhZszj5cKFp4prL79FfIcYT2KRb9ihHyuUX/w+jMa2z+PIi5rHS0QHfQRaDl47RoBjUzSMKDCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358518; c=relaxed/simple;
	bh=nNzhsNWYLp7Zq1XRY4aRofLDtmSg3h09L9xF3zv7xq4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YDofU5sdEAmnwZfVDj8TXcQqVghv/GAiTWIA2OKp9OWh0PlI9yMqJFoZ4K7smVklBdF8QZ1btuOztmrKQ2XHEXEoQIPMIS+F8lfnQZ1guLWnxzBDuEx6RYmslv189yLbSHP2N7Er5k62tWzuMMiOeSRF+njJGdAznajQAhK+oe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCYqjYat; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0481F000E9;
	Thu, 21 May 2026 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779358517;
	bh=LeHgpAGmkkft1lTDv1GUbcLOSox8wth2jbdG+ISuWKg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=DCYqjYat31sL+mOST1Xc8Edy59m0ameJU2o9mvxAEAytb2a/ZuIteGVExXtaYxFmh
	 uJKT0vLGRKLT2y0N5xvXWlMlk5iBg7RqLdoiL3Xaq6TkmQ6/28r3nydDHRgN9Yc1fk
	 /zmoifVpk66TTSioGzFJD7SFNo8xkqKd9Gbrlf1cH0XcnC2sMGK1+nXM6tXN3t/Lv9
	 O2105u3JCJqOzuCfuTcw0QFrhW583UUItiecZIBNNvcGA7fK1P+VuO/S1L/k5b1CVh
	 cq1E608gEhRG/kwLty7km2Fg55eIWPMgs82NMmNUL20ui/F0CFinJLENyDWSOaAH9p
	 4X7JBnUg5XIdQ==
Date: Thu, 21 May 2026 05:15:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, 
 linux-mediatek@lists.infradead.org, Russell King <linux@armlinux.org.uk>, 
 kevin-kw.huang@airoha.com, matthias.bgg@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
 kernel@collabora.com, Eric Dumazet <edumazet@google.com>, 
 macpaul.lin@mediatek.com
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
In-Reply-To: <20260521-add-airoha-an8801-support-v4-1-1e4837d30ef4@collabora.com>
References: <20260521-add-airoha-an8801-support-v4-0-1e4837d30ef4@collabora.com>
 <20260521-add-airoha-an8801-support-v4-1-1e4837d30ef4@collabora.com>
Message-Id: <177935851659.1629932.12187285243163013208.robh@kernel.org>
Subject: Re: [PATCH net-next v4 1/6] dt-bindings: net: Add support for
 Airoha AN8801R GbE PHY
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,lunn.ch,armlinux.org.uk,airoha.com,gmail.com,kernel.org,davemloft.net,vger.kernel.org,collabora.com,redhat.com,google.com,mediatek.com];
	TAGGED_FROM(0.00)[bounces-290336-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AFA495A3531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 21 May 2026 10:21:54 +0200, Louis-Alexis Eyraud wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Add a new binding to support the Airoha AN8801R Series Gigabit
> Ethernet PHY.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  .../devicetree/bindings/net/airoha,an8801.yaml     | 116 +++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/airoha,an8801.yaml: ^led@[0-2]$: Missing additionalProperties/unevaluatedProperties constraint

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260521-add-airoha-an8801-support-v4-1-1e4837d30ef4@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


