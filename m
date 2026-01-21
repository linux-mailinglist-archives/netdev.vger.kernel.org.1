Return-Path: <netdev+bounces-251797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNgNNieMcGkEYQAAu9opvQ
	(envelope-from <netdev+bounces-251797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:19:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A653657
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DC6E5485DC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7A478879;
	Wed, 21 Jan 2026 08:15:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7D4418CD;
	Wed, 21 Jan 2026 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983340; cv=none; b=kxF0nDlGf23CcEvU/LcvCdpXA7KY4Kw24mnv0rNFqzbPUPi9K7IeX5NmyG4L6DeXzpd6dj9d/PeEqKIZHb7aMLTpkZip+flPpTn1sWCDn0e5YddH1BHWBvhujN7cBmGlatMXrSY5NahWWKdhg9+EIS/D6JRE7+CaIUD8iTZVcWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983340; c=relaxed/simple;
	bh=emrIjLOeabyV6LGirlRSI+d/LxMACmtI5ia646ss2eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT4bj8CZGGA+EqOSBEMgLf1W34ETdBS0W6/zTNeVb6pKaWWqieBtwdLM4rRQ2C4ENZQ0+OmigEjxXf8OmPSBs/I3EvzHpW+OtG1bhxMBUQeA9eC56MvIa7tc42TzS/FlxgrDbFan0eawXfRNltkmamnSGZANg3pHS10+uFkMYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C18021A0D7D;
	Wed, 21 Jan 2026 09:15:30 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A994F1A0D78;
	Wed, 21 Jan 2026 09:15:30 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 15432202C4;
	Wed, 21 Jan 2026 09:15:30 +0100 (CET)
Date: Wed, 21 Jan 2026 09:15:30 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH RFC 2/4] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
Message-ID: <aXCLIjrGfLVGv+Si@lsv051416.swis.nl-cdc01.nxp.com>
References: <20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com>
 <20251214-dwmac_multi_irq-v1-2-36562ab0e9f7@oss.nxp.com>
 <176582217911.3066791.4926710165988218857.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176582217911.3066791.4926710165988218857.robh@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251797-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,foss.st.com,lists.infradead.org,kernel.org,redhat.com,davemloft.net,vger.kernel.org,nxp.com,pengutronix.de,st-md-mailman.stormreply.com,google.com,lunn.ch,lists.linux.dev,oss.nxp.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.petrous@oss.nxp.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lsv051416.swis.nl-cdc01.nxp.com:mid,devicetree.org:url,nxp.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 944A653657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Dec 15, 2025 at 12:09:39PM -0600, Rob Herring (Arm) wrote:
> 
> On Sun, 14 Dec 2025 23:15:38 +0100, Jan Petrous (OSS) wrote:
> > The DWMAC IP on supported SoCs has connected queue-based IRQ lines.
> > 
> > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> > ---
> >  .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 40 +++++++++++++++++++---
> >  1 file changed, 36 insertions(+), 4 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: ignoring, error in schema: properties: interrupt-names
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
> 	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml: properties:interrupt-names: [{'items': [{'const': 'macirq'}, {'const': 'rx-queue-0'}, {'const': 'tx-queue-0'}, {'const': 'rx-queue-1'}, {'const': 'tx-queue-1'}, {'const': 'rx-queue-2'}, {'const': 'tx-queue-2'}, {'const': 'rx-queue-3'}, {'const': 'tx-queue-3'}, {'const': 'rx-queue-4'}, {'const': 'tx-queue-4'}]}] is not of type 'object', 'boolean'
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-doc-validate", line 8, in <module>
>     sys.exit(main())
>              ~~~~^^
>   File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 66, in main
>     ret |= check_doc(f)
>            ~~~~~~~~~^^^
>   File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 37, in check_doc
>     dtsch.check_schema_refs()
>     ~~~~~~~~~~~~~~~~~~~~~~~^^
>   File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 241, in check_schema_refs
>     self._check_schema_refs(resolver, self)
>     ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
>   File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 212, in _check_schema_refs
>     self._check_schema_refs(resolver, v, parent=k, is_common=is_common,
>     ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                             has_constraint=has_constraint)
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 216, in _check_schema_refs
>     self._check_schema_refs(resolver, schema[i], parent=parent, is_common=is_common,
>     ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                             has_constraint=has_constraint)
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 203, in _check_schema_refs
>     ref_sch = resolver.lookup(schema['$ref']).contents
>               ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
>   File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 682, in lookup
>     retrieved = self._registry.get_or_retrieve(uri)
>   File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 422, in get_or_retrieve
>     registry = self.crawl()
>   File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 500, in crawl
>     id = resource.id()
>   File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 231, in id
>     id = self._specification.id_of(self.contents)
>   File "/usr/local/lib/python3.13/dist-packages/referencing/jsonschema.py", line 50, in _dollar_id
>     return contents.get("$id")
>            ^^^^^^^^^^^^
> AttributeError: 'list' object has no attribute 'get'
> Lexical error: Documentation/devicetree/bindings/net/nxp,s32-dwmac.example.dts:58.13-17 Unexpected 'snps'
> Error: Documentation/devicetree/bindings/net/nxp,s32-dwmac.example.dts:58.13-17 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.dtbs:141: Documentation/devicetree/bindings/net/nxp,s32-dwmac.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1559: dt_binding_check] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20251214-dwmac_multi_irq-v1-2-36562ab0e9f7@oss.nxp.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

It was missing closing semicolon in the example. Thanks for catch.
Fixed in v2.

/Jan


