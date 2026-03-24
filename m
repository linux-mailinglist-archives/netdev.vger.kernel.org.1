Return-Path: <netdev+bounces-271331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YADpM0EXw2lCoAQAu9opvQ
	(envelope-from <netdev+bounces-271331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:59:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3227A31D8F3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E08683028024
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0313C73C4;
	Tue, 24 Mar 2026 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnjEg8u6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356FE33C52E;
	Tue, 24 Mar 2026 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393080; cv=none; b=SdJ0nKnlAMoUGbdGxIHY4Ly0cCFgqhl5nnOdH077CAL4fUUhwXQVB+jEGAwnSHNg9nWUfx3yZ74mz207n1Gjze6nQhc7tg8pQhJnRbn08Xzf7OlE2r7W/yrmGyfczOh7DD7p76507YEI3ryDqjGuWVtMDP032P4Ee1v91PYackc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393080; c=relaxed/simple;
	bh=CMhGjpHVL0E5bl2i3OV14j4oPRoXe7C71tConmD/AU8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=j9YfUj7AYNFAop+H1Goq5SseZKTuMR6qw7Phx9jDx6YkUphpNI6ldnORXOplxZqed8qGLEbTTtRLSLv8RU9Qq2AuTDC0LEtSrFQwgpGK0QVOau56cSH/5e4iV/hpeC6QyZKtzzBSwGBA1Vsn/98ijO0mIx09gWSQJY02qYg7QkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnjEg8u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B6FC19424;
	Tue, 24 Mar 2026 22:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774393079;
	bh=CMhGjpHVL0E5bl2i3OV14j4oPRoXe7C71tConmD/AU8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=jnjEg8u6tA6GdcwIKvw8RwZAOd36Nn7Ho6WTpexn7SIqvHQ/6KqJu2mTfRZYSfOY6
	 9W3/xDOqV1fsI6aOI3guyoybnNgwD+gPAdDFoi7DS/+YP9ED+KZEru4Gzdj47FIFTz
	 TXZfHoOWzFClb1Z8zDhufWSVHX2m9qyO6XdiuIc5x0UTs5GkQhWOLQ13qFXJlPT/Vz
	 tXy/Cwj/N/PKebVR/ScjPK5EFyOTlWfVF7LVmVFzx1aJsnuwylvDTNz8NA0w7g9vku
	 zK9dHJGPbbQVDx1vES6D39bxf5YX0SRMzlwrSu5EA/oCZrw62PGH5Ysm+53iS/7ppO
	 hPd8xJTOqWLmg==
Date: Tue, 24 Mar 2026 17:57:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 linux-tegra@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260324121631.771628-3-jonathanh@nvidia.com>
References: <20260324121631.771628-1-jonathanh@nvidia.com>
 <20260324121631.771628-3-jonathanh@nvidia.com>
Message-Id: <177439307874.2078673.11304788250514370726.robh@kernel.org>
Subject: Re: [PATCH V2 2/3] dt-bindings: net: Fix Tegra234 MGBE PTP clock
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,gmail.com,davemloft.net,vger.kernel.org,lunn.ch];
	TAGGED_FROM(0.00)[bounces-271331-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.103.194.128:email]
X-Rspamd-Queue-Id: 3227A31D8F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 24 Mar 2026 12:16:30 +0000, Jon Hunter wrote:
> The PTP clock for the Tegra234 MGBE device is incorrectly named
> 'ptp-ref' and should be 'ptp_ref'. This is causing the following
> warning to be observed on Tegra234 platforms that use this device:
> 
>  ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
>  WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed
> 
> Although this constitutes an ABI breakage in the binding for this
> device, PTP support has clearly never worked and so fix this now
> so we can correct the device-tree for this device. Note that the
> MGBE driver still supports the legacy 'ptp-ref' clock name and so
> older/existing device-trees will still work, but given that this
> is not the correct name, there is no point to advertise this in the
> binding.
> 
> Fixes: 189c2e5c7669 ("dt-bindings: net: Add Tegra234 MGBE")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.example.dtb: ethernet@6800000 (nvidia,tegra234-mgbe): clock-names:3: 'ptp_ref' was expected
	from schema $id: http://devicetree.org/schemas/net/nvidia,tegra234-mgbe.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260324121631.771628-3-jonathanh@nvidia.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


