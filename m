Return-Path: <netdev+bounces-175174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3597EA63E54
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 05:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FD8188D79A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 04:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D1156F28;
	Mon, 17 Mar 2025 04:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2Duf+l9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729D10E4;
	Mon, 17 Mar 2025 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742185904; cv=none; b=DXF8zn87D1hrBhrtE0BbGkRfSjTfBb3UIhaME7jWM5CQmVD5x8qL4Nz3mc/xWkppFnDPaLkznRPW4l0AVZdCgCaonAKMGCmvWMV9a8LgiS3/CiJtjxwMphc9+VnumYlUpI9fl9cahaAJiHSt1k/2LzlgBeUBWGNiE3d1v6Vbhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742185904; c=relaxed/simple;
	bh=Z0a2dhsGygTnIpjglItX4bKcLEMQVArwLyKFp0XhQ7I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=RjLhBNAT/qMvAqJP/3VXIO+5tn8jeKue5vo1DPX1cIUSm8B0t3A6OXp4n267OKgoYDCesIypBkwjebtHt/okuvHomaZyivGECg6H7C2Ix/CYicW1rNHXL/SKBT60mqNvlAKJC8IkV5SSGrDjRirvMXobzjj6xXz6WkUPbf/K6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2Duf+l9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B52AC4CEEC;
	Mon, 17 Mar 2025 04:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742185904;
	bh=Z0a2dhsGygTnIpjglItX4bKcLEMQVArwLyKFp0XhQ7I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=J2Duf+l9JOfm66hAwT4GUElZZFPEiS5aUgZHtsKTCQxxJIYBZ8mmbA4euOKDQZm7d
	 RujhJlwwh5UKJF1upR1yRrDlQ2eH7gzcXkoaNPO9gXQ4pq3NCNaxoeSppCdpm03CBK
	 ksiJhW+a0Pw596ntBQRdv+xffFhcRmyYgdI8k9r016hyjuSEF9MkZyX3wQvDAwZe5Y
	 t0Sg7NyZgFqgJTcg5NI/P+FSI9L7F+PoNxe8gQExzpaELQ/ZfPzrik7viwNv/nH/p0
	 zOwYW3i3m52g+AEs2+GkBu5qo9fE8ttUPJ8rwXF2/lzz0Mq010mYiOT/purkAGt/2A
	 UjsNYgBY5tG1A==
Date: Sun, 16 Mar 2025 23:31:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kuba@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 BMC-SW@aspeedtech.com, conor+dt@kernel.org, ratbert@faraday-tech.com, 
 joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, 
 andrew+netdev@lunn.ch, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, davem@davemloft.net
To: Jacky Chou <jacky_chou@aspeedtech.com>
In-Reply-To: <20250317025922.1526937-4-jacky_chou@aspeedtech.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-4-jacky_chou@aspeedtech.com>
Message-Id: <174218590293.2844402.7312672269180234107.robh@kernel.org>
Subject: Re: [net-next 3/4] dt-bindings: net: ftgmac100: add rgmii delay
 properties


On Mon, 17 Mar 2025 10:59:21 +0800, Jacky Chou wrote:
> Add tx-internal-delay-ps and rx-internal-delay-ps to
> configure the RGMII delay for MAC. According to
> ethernet-controller.yaml, they use for RGMII TX and RX delay.
> 
> In Aspeed desgin, the RGMII delay is a number of ps as unit to
> set delay, do not use one ps as unit. The values are different
> from each MAC. So, here describes the property values
> as index to configure corresponding scu register.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml          | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:71:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:78:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:119:7: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250317025922.1526937-4-jacky_chou@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


