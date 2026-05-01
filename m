Return-Path: <netdev+bounces-283289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O64JpMP9WnIHwIAu9opvQ
	(envelope-from <netdev+bounces-283289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 22:39:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C44AF8B9
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 22:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D5453024C90
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 20:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98F5421F1C;
	Fri,  1 May 2026 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iymdGePl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C84219F8;
	Fri,  1 May 2026 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667770; cv=none; b=Ph2DODqiWnuohOm2NmxAtROEZq52l4FkeX9ho37vPJ9RAw/KaJweIPJLyJGkpvWM/P8Awmoyqbg1+oLKA9fBs6UDxPPVEdMeYPOy//Y4lo5++dfvvZcPQLV8h/gDwKoNoreankMXKgaBqFh9C5CVnYlABcstBWiw5HZejL1eJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667770; c=relaxed/simple;
	bh=fI83m7F5K4lmSlu+bvO27xgSrkO0CqK+Zk1qlwALaw8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NdSqTCrxSftr1z61yiwIV0mH2YlJG+up636eybUXoOAjTejBNJkXKyLl0J3n2UZOrXeWHH98LMuD6/OwRFhALI9H4kcjYF5qFgVM5pPk8Zjvmu2HW7KUSp1eMX0t9J89DWwxzqFG/hzKmpmayMNuDvHrb4KpGWvUCTULRsFKXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iymdGePl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363BCC2BCB4;
	Fri,  1 May 2026 20:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777667770;
	bh=fI83m7F5K4lmSlu+bvO27xgSrkO0CqK+Zk1qlwALaw8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=iymdGePlc03SpWJr+No1VlN9yGnQeVehRP5gh4QPpDkCrr9S0shtEj777W86ckCBW
	 CJaGXIFvVLAPDWCv1GhEKHjijOVtPeSZ5os5Ulo8dYiGqYQfV337ZMUyrQWN3uGPjf
	 ZkUQ1/HK/w1We8mlmtMnX+KlsMwgqIG5cW98KWvwDOERWckZZoSFgEiVDZHVjhzOcd
	 QXQ5NZISp4W84QjXTFBcL1vcixWZ/APP3u8Iq6w28BFhtKCIhSKKNSYMOkYaq6Oain
	 uVWw3MSUyTN4NSLGcd1nElLYrBXVXFBzhQKNR01ZMNiLR/9ca+0QaLhK/KwXw31FlB
	 DiNNnuEDg6S9A==
Date: Fri, 01 May 2026 15:36:07 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: edumazet@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 Piergiorgio Beruto <Pier.Beruto@onsemi.com>, netdev@vger.kernel.org, 
 kuba@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch, 
 krzk+dt@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
In-Reply-To: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com>
Message-Id: <177766776795.356932.18256256609588920036.robh@kernel.org>
Subject: Re: [PATCH net-next 1/5] dt-bindings: net: add onsemi's
 TS2500/NCN26010 10BASE-T1S MACPHY
X-Rspamd-Queue-Id: DD1C44AF8B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283289-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[12];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,onsemi.com:email,devicetree.org:url]


On Fri, 01 May 2026 19:15:17 +0000, Selvamani Rajagopal wrote:
> Add YAML device tree binding for the onsemi NCN26010 and TS2500
> IEEE 802.3cg compliant Ethernet transceiver devices.
> 
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---
>  .../bindings/net/onnn,ncn260xx.yaml           | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/onnn,ncn260xx.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/onnn,ncn260xx.example.dtb: ethernet@0 (onnn,ncn260xx): 'pinctrl-0' is a dependency of 'pinctrl-names'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


