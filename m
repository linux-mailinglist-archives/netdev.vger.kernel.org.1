Return-Path: <netdev+bounces-279226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M1eIFO54WmExQAAu9opvQ
	(envelope-from <netdev+bounces-279226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 06:38:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE87F416E59
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 06:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E19D307B003
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1D5348875;
	Fri, 17 Apr 2026 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcEizoGL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD82DD5F6;
	Fri, 17 Apr 2026 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400588; cv=none; b=F5DfpuaMjD1lPqMGOGlJL514JKhJTbVV1fi8oSRxi5KH6E87/ZzC3uAGV2T8S2TC75Fm1VK/Jwlq3HzRAZOQv9h/mnHcfG1slJNiUws6DtRCzgTCU+/MbCu80cyeI6X269BE3zywhBO68CDV4qYHxlbxAtMhOCl+rpvBBgCePgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400588; c=relaxed/simple;
	bh=p9z6malVt1ssjUUpjdOzlvkCHo7e2WH64RUFkdyqG8c=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GYNryfaaGNc7iV0ZeKsJaqFptm68qNNlQ9wcptUvQIlDh5bSQHivZbOSNArw24Suy9GD8a+STaVNIe/LFbf8PAv9bep2Scqg99s2Q4SM7jrEcIJuAhEEQhOyMaLaJfJ3qE8e0HzEAIS6sRQqhm++dpzGxvWRpgrvag3tH3c62rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcEizoGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BC0C19425;
	Fri, 17 Apr 2026 04:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400587;
	bh=p9z6malVt1ssjUUpjdOzlvkCHo7e2WH64RUFkdyqG8c=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=gcEizoGL5OQpTaApJzj+G6WhUEdLesHSt3OdWa0XYZW+EDUvbKGQ4W7PeJT+g/+1t
	 Dj2QVSVw5SdyRKKbaXbaSvjBSQfVfzHeDn3FB4V1iYjnVN0UsIULTDQoqLdT+Y0Ljj
	 xZW/N6mKZuzbsjFk11dW2x4V77fe7MV+A8ZxYJQDrWy3WhWpOIGqmochFcbi0arqM6
	 iahRgJmTeGAfx9W6liCZDKdWxYlh1gZKpG58cP039xfz8jihEATpyHS8kizBNP3pN4
	 zoOY4R7mkENx/2Q/iUIaKIkSMn9+/cgGqCGBrjWfTu8ZMf4VQmQ4U7+q3eSi3qDqIX
	 6uscZjvr3l50A==
Date: Thu, 16 Apr 2026 23:36:25 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org, 
 netdev@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20260417024523.107786-4-minda.chen@starfivetech.com>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
 <20260417024523.107786-4-minda.chen@starfivetech.com>
Message-Id: <177640058543.32784.7631250778558524141.robh@kernel.org>
Subject: Re: [net-next v2 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 JHB100 sgmii rx clk
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
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,foss.st.com,gmail.com,canonical.com,lunn.ch,davemloft.net,st-md-mailman.stormreply.com,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-279226-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE87F416E59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 17 Apr 2026 10:45:21 +0800, Minda Chen wrote:
> JHB100 SGMII interface tx/rx mac clock is split and require to
> set clock rate in 10M/100M/1000M speed. So dts need to add a
> new rx clock in code, dts and dt binding doc.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 42 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml:56:8: [warning] wrong indentation: expected 8 but found 7 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260417024523.107786-4-minda.chen@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


