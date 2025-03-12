Return-Path: <netdev+bounces-174218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32299A5DDC8
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60408189688C
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E83523A563;
	Wed, 12 Mar 2025 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR5xSFxe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80272EAF7;
	Wed, 12 Mar 2025 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785456; cv=none; b=CgH9ShVeVu2oyMoVjMbxo1QNgeIsIJ9PPqZhOpfI4gUP9AcvCNVwABzMR8YQKVaoAMtiXAEoTBvCSSeX54/SzLRkn5RdIalz6+YNPbRG2vtnJS/f6lN2hZcJhLGoxfpfj9YlnLdMG4ug1Bs+gtYhYawR7uYUvlz8p48YyfMoseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785456; c=relaxed/simple;
	bh=q6dHWY/sgNPDiH0VHzYcttxpIZaPa92meReul5KP29Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDLGJ5z7Zt0A/nCt9HAC9oGfI09zR6LcMI09yi9bn/N40zulPFS6O5ZQ3/E5QOdQMExRKLld3GrxzRsu9AwClcg9QGxt9VVXScMZU96RqvaplwjnJYkgqAo9bkzJB0EcJt2QySMLqgZJ7oF86owWZxax65VNzoWS3G7z5sz2gI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR5xSFxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE87C4CEE3;
	Wed, 12 Mar 2025 13:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741785455;
	bh=q6dHWY/sgNPDiH0VHzYcttxpIZaPa92meReul5KP29Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OR5xSFxe1jq7JdfBvNZY3RH4RT2Rpt0GBysRIAKWCcgWDO/T0M9nGomYJsyKliHXf
	 zwYE2ek7UIs6azTnHoHuXIFXe5qcuNrX/4b3pId3eG7LH4hpAI0zETkDBPaBHmZiV8
	 6jlQ2lmmnqQ90aOnqy45rHUwE6yeTmVUSj8zDIXXfkzyK9FF0YKt1XIrizGjptW4VZ
	 YzbSWg995YF6M9BFPaCILQPrHoMdZEXr3qsNekjIlhRSrreKvGM/Vwr1neJYnamf8c
	 HeXzGOpZoUUaUWme2UmGz/s1f9HwxO/pemGX6mzhI8gFtbu9cC8PX9kWoFDLzKHkb9
	 GmqxPe2zq7lOw==
Date: Wed, 12 Mar 2025 08:17:34 -0500
From: Rob Herring <robh@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com, harini.katakam@amd.com
Subject: Re: [PATCH net-next V2 1/2] dt-bindings: net: xlnx,axi-ethernet:
 Modify descriptions and phy-mode value to support 2500base-X only
 configuration
Message-ID: <20250312131734.GA505165-robh@kernel.org>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-2-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312095411.1392379-2-suraj.gupta2@amd.com>

On Wed, Mar 12, 2025 at 03:24:10PM +0530, Suraj Gupta wrote:
> AXI 1G/2.5G Ethernet subsystem supports 1G and 2.5G speeds. Modify
> existing binding description, pcs-handle description and add
> 2500base-x in phy-mode for 2500base-X only configuration.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  .../devicetree/bindings/net/xlnx,axi-ethernet.yaml       | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> index fb02e579463c..977f55b98f31 100644
> --- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> +++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> @@ -9,10 +9,12 @@ title: AXI 1G/2.5G Ethernet Subsystem
>  description: |
>    Also called  AXI 1G/2.5G Ethernet Subsystem, the xilinx axi ethernet IP core
>    provides connectivity to an external ethernet PHY supporting different
> -  interfaces: MII, GMII, RGMII, SGMII, 1000BaseX. It also includes two
> +  interfaces: MII, GMII, RGMII, SGMII, 1000BaseX and 2500BaseX. It also includes two

Please re-wrap at 80.

>    segments of memory for buffering TX and RX, as well as the capability of
>    offloading TX/RX checksum calculation off the processor.
>  
> +  AXI 2.5G MAC is incremental speed upgrade of AXI 1G and supports 2.5G speed.
> +
>    Management configuration is done through the AXI interface, while payload is
>    sent and received through means of an AXI DMA controller. This driver
>    includes the DMA driver code, so this driver is incompatible with AXI DMA
> @@ -62,6 +64,7 @@ properties:
>        - rgmii
>        - sgmii
>        - 1000base-x
> +      - 2500base-x
>  
>    xlnx,phy-type:
>      description:
> @@ -118,8 +121,8 @@ properties:
>      type: object
>  
>    pcs-handle:
> -    description: Phandle to the internal PCS/PMA PHY in SGMII or 1000Base-X
> -      modes, where "pcs-handle" should be used to point to the PCS/PMA PHY,
> +    description: Phandle to the internal PCS/PMA PHY in SGMII or 1000base-x/
> +      2500base-x modes, where "pcs-handle" should be used to point to the PCS/PMA PHY,

And here.

>        and "phy-handle" should point to an external PHY if exists.
>      maxItems: 1
>  
> -- 
> 2.25.1
> 

