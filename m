Return-Path: <netdev+bounces-258088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABmYIRE0i2mhRgAAu9opvQ
	(envelope-from <netdev+bounces-258088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:35:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E34C111B3EC
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D115B303E3A1
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F34329E43;
	Tue, 10 Feb 2026 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPO2T1h+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54525B662;
	Tue, 10 Feb 2026 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770730510; cv=none; b=s2JVedmo3SmjBeLHRaqfpFSuz8TYHqknlzPH9s0MqVE22JnEIi5IYhqh+hj8B5pjI6kYWxrcgB5rpdJ/uCfTZjFIBy63BmWH3b8534zJc/K7XfWGG1hcDfQ25jTcRNEGdR/iqE3iUF4PT/3BpzWR1Jhd+CzTCiux6VdclzO9BHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770730510; c=relaxed/simple;
	bh=pOU4O74VvKCHJ34mMFpIVQ+S/He2Ol8rafSLir616W4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=XbJSAIvOfXHMRnl8adU1b2q00fphq1NN+7aAYynJOG8tlfaounJ5lw5UsFe5K+nAgY3jBevmXcewHFsdVaLOiCKxjuoim5T85MT/kQSJR2pGDoPm4Y1V0LqrvBWyt82UZE049dQeyZbN2ylVHCoExlJarsHMMjqm99mmo9VE74k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPO2T1h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA280C116C6;
	Tue, 10 Feb 2026 13:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770730510;
	bh=pOU4O74VvKCHJ34mMFpIVQ+S/He2Ol8rafSLir616W4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=DPO2T1h+M+Nha4vZaFiTCBZ/lAH+hR/wqUxZb5qfbGyg77+pHgj4+LRd9CqCinMKQ
	 8FF+Gs/Gkna9qwtaxuho8WLcoTbQ7XDzPChAGmfCsXtc5pAYFbLQfzUjfZR83+ikVB
	 VR16qpeIRW9bhXA4H6RnEBvcCKdz1R0X5vb96GaH33oMebEmFGeI5gIL6N0sMIh62n
	 k2efThEbB47mBL6mCkXbc8S5xfeRnl9/Bbu29gv/PcHvO4FbLf2z+Uj9xmwnQP6lV9
	 uCzp6sItHaozwRAD7tfSNtldQacJg1MmTVgq5gOY9yF/oYxlD02SHMi/UN88WtzwuD
	 03Yien9BUoOJg==
Date: Tue, 10 Feb 2026 07:35:09 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, 
 mcoquelin.stm32@gmail.com, yclu4@nuvoton.com, alexandre.torgue@foss.st.com, 
 linux-kernel@vger.kernel.org, edumazet@google.com, 
 linux-stm32@st-md-mailman.stormreply.com, schung@nuvoton.com, 
 netdev@vger.kernel.org, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, richardcochran@gmail.com, 
 davem@davemloft.net, openbmc@lists.ozlabs.org, krzk+dt@kernel.org, 
 kuba@kernel.org, ychuang3@nuvoton.com, peppe.cavallaro@st.com, 
 pabeni@redhat.com, joabreu@synopsys.com
To: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20260210052226.3005666-2-a0987203069@gmail.com>
References: <20260210052226.3005666-1-a0987203069@gmail.com>
 <20260210052226.3005666-2-a0987203069@gmail.com>
Message-Id: <177073050804.2585725.9186824856266132663.robh@kernel.org>
Subject: Re: [PATCH net-next v12 1/3] dt-bindings: net: nuvoton: Add schema
 for Nuvoton MA35 family GMAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258088-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,nuvoton.com,foss.st.com,google.com,st-md-mailman.stormreply.com,kernel.org,lists.infradead.org,davemloft.net,lists.ozlabs.org,st.com,redhat.com,synopsys.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.62.26.112:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[e7070000:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E34C111B3EC
X-Rspamd-Action: no action


On Tue, 10 Feb 2026 13:22:24 +0800, Joey Lu wrote:
> Create initial schema for Nuvoton MA35 family Gigabit MAC.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
>  .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 133 ++++++++++++++++++
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>  2 files changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): clock-names: ['stmmaceth'] is too short
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): clocks: [[4294967295]] is too short
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): compatible:0: 'altr,socfpga-stmmac' is not one of ['nuvoton,ma35d1-dwmac']
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): compatible: ['altr,socfpga-stmmac', 'snps,dwmac-3.70a', 'snps,dwmac'] is too long
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): phy-mode:0: 'sgmii' is not one of ['rmii', 'rgmii', 'rgmii-id', 'rgmii-txid', 'rgmii-rxid']
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): 'nuvoton,sys' is a required property
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): 'resets' is a required property
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): 'reset-names' is a required property
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): Unevaluated properties are not allowed ('altr,sysmgr-syscon' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.example.dtb: ethernet@4070000 (sophgo,cv1800b-dwmac): compatible:0: 'sophgo,cv1800b-dwmac' is not one of ['nuvoton,ma35d1-dwmac']
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.example.dtb: ethernet@4070000 (sophgo,cv1800b-dwmac): phy-mode:0: 'internal' is not one of ['rmii', 'rgmii', 'rgmii-id', 'rgmii-txid', 'rgmii-rxid']
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.example.dtb: ethernet@4070000 (sophgo,cv1800b-dwmac): 'nuvoton,sys' is a required property
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): clock-names:1: 'ptp_ref' was expected
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): clock-names: ['stmmaceth', 'pclk', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): clocks: [[4294967295, 1], [4294967295, 2], [4294967295, 3]] is too long
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): compatible:0: 'thead,th1520-gmac' is not one of ['nuvoton,ma35d1-dwmac']
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): reg: [[3875995648, 8192], [3959435264, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): 'nuvoton,sys' is a required property
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): 'resets' is a required property
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): 'reset-names' is a required property
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): Unevaluated properties are not allowed ('reg-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260210052226.3005666-2-a0987203069@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


