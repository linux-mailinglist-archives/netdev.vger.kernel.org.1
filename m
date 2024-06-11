Return-Path: <netdev+bounces-102714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F11E9045C5
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C377BB24C20
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F74D8A8;
	Tue, 11 Jun 2024 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW7O3OV8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5E63CB;
	Tue, 11 Jun 2024 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137846; cv=none; b=fEYUxzFbLoyhJYz5cqNMstLkQgG3H+sv318ZEtFTfyt+BU+KpBoP4bxoPgCohhcpEgBLUKmSUOCJ2CP8+wRclUdBKGGsRrSPvBk0q5ohBvSrM/d0l/BXDabVS/r0Wy0Zdn22A7N26ORO7P9WTReBrLsYRLMC2Rjh5+w8/iwOpuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137846; c=relaxed/simple;
	bh=QJUAl/HXNGAn4ey6eyXBFTC8hrQJC413PQTjAxPjThk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzspR0eMCdqVDv3FcRJo6LQcTWbq0/SFoo/LqsnabL0F1eEVwa4Qf45zJaHqE9XLp2AgmXG27miZV/Gz0phBuglzW7OM7OOB7dwx04o+hZNEsL2hWfArjR6bB3dBuydPu8SX3e4ImIhM6BUqSbZ1CfpZ1AsRn6AvltbuQCBhqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW7O3OV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43329C2BD10;
	Tue, 11 Jun 2024 20:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718137845;
	bh=QJUAl/HXNGAn4ey6eyXBFTC8hrQJC413PQTjAxPjThk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bW7O3OV8ugvr4+2JAkhQRVVzKvCrCFkqU+WdGxvW1Yl4oov2GnUwYBSXitB6a5fe7
	 hwXyKd3MnF4wByIvv+LG9Ha9IMKjtGDamPJuoATnfPbXaFkim/vfaPDAcQx4wD0CW1
	 +eh5xmSQAHaALYTYF0lHEHD47WgaiuioP8u+96T46uIOBNvLf5zSTKKh74MPoqnnkh
	 FAQEbPyBS50fjHOvID67kjMxJy6kxtruxSL6z/twRdhflXJbGYIkScG6NjBvqCooKE
	 V/LP+gY8sZWzuaTvuDVR9iwYmm4W7sbJJS7cEg4WMH0tqKE1Uzeb/TncwvmVIxwLum
	 H1CTNT0/ch8GQ==
Date: Tue, 11 Jun 2024 14:30:43 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Martin Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org, krzk+dt@kernel.org, davem@davemloft.net,
	edumazet@google.com, olteanv@gmail.com, conor+dt@kernel.org,
	kuba@kernel.org, devicetree@vger.kernel.org, pabeni@redhat.com,
	hauke@hauke-m.de, martin.blumenstingl@googlemail.com,
	f.fainelli@gmail.com, andrew@lunn.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/12] dt-bindings: net: dsa: lantiq,gswip:
 convert to YAML schema
Message-ID: <171813784153.3020916.2558169964634930233.robh@kernel.org>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-2-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611135434.3180973-2-ms@dev.tdt.de>


On Tue, 11 Jun 2024 15:54:23 +0200, Martin Schiller wrote:
> Convert the lantiq,gswip bindings to YAML format.
> 
> Also add this new file to the MAINTAINERS file.
> 
> Furthermore, the CPU port has to specify a phy-mode and either a phy or
> a fixed-link. Since GSWIP is connected using a SoC internal protocol
> there's no PHY involved. Add phy-mode = "internal" and a fixed-link to
> the example code to describe the communication between the PMAC
> (Ethernet controller) and GSWIP switch.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>  .../bindings/net/dsa/lantiq,gswip.yaml        | 202 ++++++++++++++++++
>  .../bindings/net/dsa/lantiq-gswip.txt         | 146 -------------
>  MAINTAINERS                                   |   1 +
>  3 files changed, 203 insertions(+), 146 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


