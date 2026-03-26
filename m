Return-Path: <netdev+bounces-271978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGVRAxgMxWma5wQAu9opvQ
	(envelope-from <netdev+bounces-271978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:36:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3C63337B4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE48C3075386
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4803C8706;
	Thu, 26 Mar 2026 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmSmvcLC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3550839527D;
	Thu, 26 Mar 2026 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521195; cv=none; b=lZzSFMt6WvwVoUVon8jDRdEvODoBOQQQv1+3CLzP9Y/coey8RcAL/Ent9TU89UDMp0CURmAmncdFu0BtUwj/XHpeVifUtkqx6+QMUg1ctMNZln5EUXxjK9VOWXBtTeClft/5yVr193AV1L9TmSZonpGteNdh9oFzL8udEfoRnN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521195; c=relaxed/simple;
	bh=U+D1ePS2FV3R9NNHRWgbO4ds4WQObUGHt1MWL2/Kg/8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=aWApmpSDCRANZGJ1tORNbhXl31+Ds0yMd3wy0r+0HofVydM1w0M7dV6gTGCg78SrZ+mj4bGzQPVLCi8Q1dGaaizOhnMhhrXKafKEgc5wlflZvhJNjdDWcBHqT267TVeVD0B2uLYv0NnvtP7GdZscOCFcuaGc2r+FkynV5LV8hgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmSmvcLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A2EC116C6;
	Thu, 26 Mar 2026 10:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774521194;
	bh=U+D1ePS2FV3R9NNHRWgbO4ds4WQObUGHt1MWL2/Kg/8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=DmSmvcLCJHHCiVak/qNmYcyiR3sXSVIC/Hn070doXPbYEfYjUfUGq/2Tdo5jxhWHC
	 8VoDUAe/M3IwxWyLejTC1bm1D1XGmBZS3q75IssNA11siYUKmhNUZr2iEfgb8EAels
	 p8LX6G9aqIsSic78SoC4sa+dMmTC5X8glY6Vo/TPDqo/kIYKu8HidxtCbj7TxtEOQv
	 WXnyEG3bcPzyL1H0pAuA1YEtxshAyRQgd90/4UYS2Zy6bY/9lMVxKOUKv/84/jOKpW
	 i3dV0mDT606XRCpuUVUffxK62N+KOULGQ13WQm/+vQMkSGxqu7lHlbuJn6TrpRteYO
	 bxc28TTj7u+7g==
Date: Thu, 26 Mar 2026 05:33:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 "David S. Miller" <davem@davemloft.net>, Marek Vasut <marex@denx.de>, 
 Eric Dumazet <edumazet@google.com>, Woojung Huh <woojung.huh@microchip.com>, 
 Fidelio Lawson <fidelio.lawson@exotec.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
 UNGLinuxDriver@microchip.com, Woojung Huh <Woojung.Huh@microchip.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org, 
 Vladimir Oltean <olteanv@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
 Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
In-Reply-To: <20260326-ksz87xx_errata_low_loss_connections-v1-1-79a698f43626@exotec.com>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-1-79a698f43626@exotec.com>
Message-Id: <177452119127.1921528.3944564852994197440.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: dsa: microchip: add KSZ low-loss
 cable errata properties
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271978-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,davemloft.net,denx.de,google.com,microchip.com,exotec.com,vger.kernel.org,lunn.ch,kernel.org,gmail.com,redhat.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[exotec.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B3C63337B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 26 Mar 2026 10:10:21 +0100, Fidelio Lawson wrote:
> Microchip KSZ87xx switches are affected by the "Module 3: Equalizer fix
> for short cables" erratum described in DS80000687C.
> The embedded PHY receivers are tuned for long, high-loss cables,
> which may cause signal distortion when operated with short or low-loss
> cabling such as CAT5e or CAT6. In these cases,
> the PHY may fail to establish a link due to internal over-amplification.
> 
> Two workarounds are provided by Microchip, each configuring a different
> indirect register value to adjust the PHY equalizer settings.
> 
> This patch introduces two new device tree properties to enable and
> select the appropriate workaround:
> 
>   - microchip,low-loss-errata-enable: boolean enabling the feature
>   - microchip,low-loss-errata: selects workaround 1 or 2 (default: 1)
> 
> These properties allow board designers to opt into the errata fix
> according to the targeted cable characteristics of their platform.
> 
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:90:111: [warning] line too long (121 > 110 characters) (line-length)
./Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:91:111: [warning] line too long (128 > 110 characters) (line-length)
./Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:93:111: [warning] line too long (118 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml: microchip,low-loss-errata: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260326-ksz87xx_errata_low_loss_connections-v1-1-79a698f43626@exotec.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


