Return-Path: <netdev+bounces-286809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCSjIgMwAmq/ogEAu9opvQ
	(envelope-from <netdev+bounces-286809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:37:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C3C5152CC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22B0A30234E0
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391DF43D4FA;
	Mon, 11 May 2026 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MggLitrl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F028CF6F;
	Mon, 11 May 2026 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528256; cv=none; b=laJ8AWVJboYTG/wS4lRFxHZvS4hJXz7B1NWc3AUGU643NS54jHBfl6ZJBOa5cG0WEL9u/f5FBtkeirn5vqdjA7T8I7Dxq0fbRkHydM4ju5ZwoKU9yPsbgeCKV14an3KV+iwIoymF6d7/c1yz6psrbYiGgxTEMb6vkp6CZx/BwBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528256; c=relaxed/simple;
	bh=+fkX8ch+UmTsBNPmFgIrPKzryfgs1BYRqqYMtff7BYE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=sfrpo1M/IfLtzg0k36YfpPbyt5lbDBp0DlwhKp/u4P04nluVp0LRpn9FjJvz14pABcFn+ztynxKngkXcXTXLTHi2JbaalIz/BxeGd9kr9tX2VfnOIozNxHvnNyZKOXoCTR6rEh05STHfU+dW3S/LPG0vMSfG0Mbk4ZRakLrfIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MggLitrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BE4C2BCB0;
	Mon, 11 May 2026 19:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778528255;
	bh=+fkX8ch+UmTsBNPmFgIrPKzryfgs1BYRqqYMtff7BYE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=MggLitrl4F4UBEqtDz0bNN7FylwT9KnisKRCsjOsy+658PxPQzgceX0Z6qsuoUDyo
	 2Wbuc626zqFW0ODXUeUBEvt41gtkN0KB03gfUe6Ny2gXEev4fRKceWjPJchZ4twUOU
	 rCM2Nre4eZFy0zn7PMchK6N0tBGQTGHue94gL+le3gc0B/3Y3Qqd415ELt0rGHBVAC
	 7udYYq+ZF8ePaRq5XeVk7DRjN+/Gq9mOi02VD1UQtlHIPRLb5NikJEJgrR6YbFxM6s
	 4k0GZEGfQY7TPelq0nnY+UdjcGadwjSScOKX9xjg6R8VqZLbgx+iTU5oS4hV6Hwem4
	 5ub5D4t/GXlkw==
Date: Mon, 11 May 2026 14:37:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, conor+dt@kernel.org, 
 kuba@kernel.org, devicetree@vger.kernel.org, andrew+netdev@lunn.ch, 
 edumazet@google.com, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
In-Reply-To: <CY8PR02MB924920C8825C7AE5D22EFA4483382@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB924920C8825C7AE5D22EFA4483382@CY8PR02MB9249.namprd02.prod.outlook.com>
Message-Id: <177852825232.3200669.6844878153877471816.robh@kernel.org>
Subject: Re: [PATCH net-next v2 1/9] dt-bindings: net: add onsemi's S2500
 10BASE-T1S MACPHY
X-Rspamd-Queue-Id: E0C3C5152CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286809-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Mon, 11 May 2026 18:18:55 +0000, Selvamani Rajagopal wrote:
> Add YAML device tree binding for the onsemi S2500
> IEEE 802.3cg compliant Ethernet transceiver devices.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  .../devicetree/bindings/net/onnn,s2500.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/onnn,s2500.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/onnn,s2500.yaml:22:49: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/onnn,s2500.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/net/onnn,s2500.yaml:22:49: mapping values are not allowed here
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/onnn,s2500.example.dts'
Documentation/devicetree/bindings/net/onnn,s2500.yaml:22:49: mapping values are not allowed here
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/onnn,s2500.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1639: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/CY8PR02MB924920C8825C7AE5D22EFA4483382@CY8PR02MB9249.namprd02.prod.outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


