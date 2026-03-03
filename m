Return-Path: <netdev+bounces-263113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ICDMgW3pmmXTAAAu9opvQ
	(envelope-from <netdev+bounces-263113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:25:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DA61EC9CE
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12852301C6C7
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F17B386C3E;
	Tue,  3 Mar 2026 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3rWd6fX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42538236C;
	Tue,  3 Mar 2026 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533505; cv=none; b=RGWoGNJHNK511vQ2LRGY5lyYJfL3+/jmIinZWEhth83ZnFmQvJuTmlsJREECZWbbu9cXwzVqCQ43EZ3nqZY8SKmmt7GtRlFtTLsmasfvz8fEc7g63QU341lXllq8TLRmt+zMWCGDiVWpejX7+YdykfqBiA4PUf426eieQ9Mtucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533505; c=relaxed/simple;
	bh=uxFljM7pcMFjhzJ6RseFVsjslvhZGb2NJyw+vlNRGhs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VHDI8J+geXl8hpgs/mnRsqusNY6eai9rmWF9ydqh2AWGK0lcn+lTPaddepIqWRyIQ0i5p+1wUd6rHYbkzoI4GPS71Mwa0CApj+A+3TcfItGRAuevNMvJ4vHwmV26KetdoF5BY6ScRQA2JizmJbMlJB6al4HjjHjoYs+PdJ81QKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3rWd6fX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5447C116C6;
	Tue,  3 Mar 2026 10:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772533504;
	bh=uxFljM7pcMFjhzJ6RseFVsjslvhZGb2NJyw+vlNRGhs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Y3rWd6fXtsIGM1sr8FApey+l37uLXjatv4xXSwDwaMKzooOCNEAViYiNnPpmVNDBB
	 NIXDwOaaqyvKOjx7h32Rlc9y1vDkBMYj0+GQN3xSi7PjbIcc2gO54/j3gAlaXepTig
	 80zPjuEO/Ad8Hpsn+JuOJCKd7vq+d7wHU+rh5SGsOK88Jqt4BzrFRLU/4MQDHNdchM
	 FRtebd55imzoumqqQ9ku1A6uXtwXwKqOiy4wgIP1fEDEBNlOKVAWxe4ecFZTmgjGDF
	 FTJBa2pUTL6OI/ziZhDOlVUmD2ZnzKtglgSA5BVSAztd+pR+Z8eHZMktiHVagHhr/a
	 hpDT/yu2f3xQA==
Date: Tue, 03 Mar 2026 04:25:03 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: schung@nuvoton.com, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch, 
 pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, joabreu@synopsys.com, mcoquelin.stm32@gmail.com, 
 linux-kernel@vger.kernel.org, edumazet@google.com, openbmc@lists.ozlabs.org, 
 ychuang3@nuvoton.com, linux-stm32@st-md-mailman.stormreply.com, 
 davem@davemloft.net, kuba@kernel.org, krzk+dt@kernel.org, yclu4@nuvoton.com, 
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
 peppe.cavallaro@st.com
To: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20260303092006.263715-2-a0987203069@gmail.com>
References: <20260303092006.263715-1-a0987203069@gmail.com>
 <20260303092006.263715-2-a0987203069@gmail.com>
Message-Id: <177253350380.2382800.5887598716151731479.robh@kernel.org>
Subject: Re: [PATCH net-next v13 1/3] dt-bindings: net: nuvoton: Add schema
 for Nuvoton MA35 family GMAC
X-Rspamd-Queue-Id: 45DA61EC9CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263113-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nuvoton.com,foss.st.com,lunn.ch,redhat.com,gmail.com,vger.kernel.org,synopsys.com,google.com,lists.ozlabs.org,st-md-mailman.stormreply.com,davemloft.net,kernel.org,lists.infradead.org,st.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ff700000:email,0.62.26.112:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Tue, 03 Mar 2026 17:20:04 +0800, Joey Lu wrote:
> Create initial schema for Nuvoton MA35 family Gigabit MAC.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
>  .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 131 ++++++++++++++++++
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>  2 files changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): clock-names: ['stmmaceth'] is too short
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): clocks: [[4294967295]] is too short
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.example.dtb: ethernet@ff700000 (altr,socfpga-stmmac): compatible:0: 'nuvoton,ma35d1-dwmac' was expected
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): clock-names:1: 'ptp_ref' was expected
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): clock-names: ['stmmaceth', 'pclk', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): clocks: [[4294967295, 1], [4294967295, 2], [4294967295, 3]] is too long
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/thead,th1520-gmac.example.dtb: ethernet@e7070000 (thead,th1520-gmac): compatible:0: 'nuvoton,ma35d1-dwmac' was expected
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.example.dtb: ethernet@4070000 (sophgo,cv1800b-dwmac): compatible:0: 'nuvoton,ma35d1-dwmac' was expected
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.example.dtb: ethernet@4070000 (sophgo,cv1800b-dwmac): phy-mode:0: 'internal' is not one of ['rmii', 'rgmii', 'rgmii-id', 'rgmii-txid', 'rgmii-rxid']
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.example.dtb: ethernet@4070000 (sophgo,cv1800b-dwmac): 'nuvoton,sys' is a required property
	from schema $id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260303092006.263715-2-a0987203069@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


