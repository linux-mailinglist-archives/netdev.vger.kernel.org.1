Return-Path: <netdev+bounces-113232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F00193D416
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C6C1C20ADB
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD517C223;
	Fri, 26 Jul 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1pi4zNZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F2D17C220;
	Fri, 26 Jul 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000105; cv=none; b=NRK1uH1GuYS6Awz9mc9RL6x7qmW/BMRzIcW9Syi7aEWqDl2Yz/7e0orB65na277uDydiuT8KBF1p9rxmSsbo8PtdlvM2Ba6Qn0xADEWj9tr+uUyJA+n8VjrdRredAqvMYKvixOUrplVfyBfRUnbAUszTo984VhGxHjIEJCDd+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000105; c=relaxed/simple;
	bh=hRkZNFtwrOf05XyNrDmkh+J3tnB4ZIPfaLmU8WdDarw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FrlOGnWV+6IHOHGMFMHo6J8v4PMEnPiWls7m6Dmm2fX2TcUqpjQkpF8MuxDljMgvAsn2gFMFmRFm9E7Eb8/akiwgoviQCTf48fPkvGjGdxZOO2LT21/V9OAI1bPBS/gAZi7S1XKHrYMkTGwZhqGEJkTUNsR0AhuX/6AKuX7qMlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1pi4zNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CEBC32786;
	Fri, 26 Jul 2024 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722000104;
	bh=hRkZNFtwrOf05XyNrDmkh+J3tnB4ZIPfaLmU8WdDarw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=I1pi4zNZ/KIVjYz+nhubP2FN7+yyaey1Znec1mFaxZEfuy7yBfPz7cxu/ZOi4Gryp
	 qQM+zaBzwZrKRJ7121k7vNu3BI+MUxMhPtU+47JMFHaURIyqTr2gS6e8DgJpk9b7sH
	 qdBH08gsY1PRzZGU9LBkj9H8lFgtllzr5QR+YKBvQ0OTly5NJsBPHVFQXaSuRVgHX5
	 NqyP82k68zVMLmQGur72itMScYaxkYQ7ozlnE2EXCt4IAX/pCo/8Zk0BWPAT3UMeJt
	 6F+8zwWnHFCd4mEBHeGTzX0yVF7QOp6ukeNw30k7YSban+qQX2ZN4b414jhOJVTrc/
	 rl4XG30ObhTAg==
Date: Fri, 26 Jul 2024 08:21:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: steen.hegelund@microchip.com, Thorsten.Kummermehr@microchip.com, 
 andrew@lunn.ch, linux-kernel@vger.kernel.org, robh+dt@kernel.org, 
 corbet@lwn.net, netdev@vger.kernel.org, Pier.Beruto@onsemi.com, 
 davem@davemloft.net, conor+dt@kernel.org, UNGLinuxDriver@microchip.com, 
 edumazet@google.com, saeedm@nvidia.com, Selvamani.Rajagopal@onsemi.com, 
 Nicolas.Ferre@microchip.com, anthony.l.nguyen@intel.com, 
 devicetree@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
 benjamin.bigler@bernformulastudent.ch, ruanjinjie@huawei.com, 
 krzysztof.kozlowski+dt@linaro.org, linux@bigler.io, horms@kernel.org, 
 vladimir.oltean@nxp.com, linux-doc@vger.kernel.org, 
 horatiu.vultur@microchip.com, Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20240726123907.566348-15-Parthiban.Veerasooran@microchip.com>
References: <20240726123907.566348-1-Parthiban.Veerasooran@microchip.com>
 <20240726123907.566348-15-Parthiban.Veerasooran@microchip.com>
Message-Id: <172200010240.1530361.10067496666538570000.robh@kernel.org>
Subject: Re: [PATCH net-next v5 14/14] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY


On Fri, 26 Jul 2024 18:09:07 +0530, Parthiban Veerasooran wrote:
> The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
> PHY to enable 10BASE-T1S networks. The Ethernet Media Access Controller
> (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
> with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
> integrated into the LAN8650/1. The communication between the Host and the
> MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
> Interface (TC6).
> 
> Reviewed-by: Conor Dooley<conor.dooley@microchip.com>
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  .../bindings/net/microchip,lan8650.yaml       | 80 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/microchip,lan8650.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/net/microchip,lan865x.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/microchip,lan8650.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240726123907.566348-15-Parthiban.Veerasooran@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


