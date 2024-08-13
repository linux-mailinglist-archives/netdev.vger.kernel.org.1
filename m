Return-Path: <netdev+bounces-118173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B3A950D5C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF4D281A8B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2741A3BC5;
	Tue, 13 Aug 2024 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Laq+qodc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D81C287;
	Tue, 13 Aug 2024 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578499; cv=none; b=Y4FrlpkZW+1yar6CGpGAqsitJGbv9dLUCSewHyZEIJubxkUeU/2CNSJipCD6WqN9QHWrJ55jNynr/iMVSwmE1Hv6evZ4wYWc8MCBi3CzxLGdNqsRIMSMUgio4Tjgu9GKlvJspXq0HbmyrpTsPjvJBKlBcOMoQkl5W1Z139bZzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578499; c=relaxed/simple;
	bh=9bGTubr5YdOVCwXC1TYYkAvuioa2SJyu7Quj5N+agEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orQGz+I/g4b+3tZsFjkAUoBT1m741RDr2SsTT1ihHlI+URFKhAqjV996XzWZd2MOjcyg+A+f2/jS0M6oSiOzodgtidNt1/xitClMoeJmf556hEB08AOQXh43jvqOS5mfrf9eGBp/eYwXBpf+nqKYt3K4yIQfxdvuLpAIXh+S1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Laq+qodc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1D2C4AF0C;
	Tue, 13 Aug 2024 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723578499;
	bh=9bGTubr5YdOVCwXC1TYYkAvuioa2SJyu7Quj5N+agEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Laq+qodcciDQo5f1Nn06klCTpwZbXKfLvNbrijxLmGoFZeSznBrw+aSOG3u1lgwD3
	 U3enzBsqOA41HDCjnkDnJdsdSgJgWMS541BTe/R5ZeT7qsw8PJJeW4tBgaOD6MCJK2
	 mrBe+fqHiL2kiQNTbOkPC7oUgOaoPWPj13zYZWKvEEC733JCQZZuOtfdXf6XMdmflP
	 CjUTg1HmmWx+1jjhNQ49q7AmaEvi3U7wht67VuNI+Js21Uy2cOMZ9MZW09e6zeQULK
	 vELV9Kesb5hN0j3YQ0ITOa0MzHSyYR0eOYAV/Nn7+r7SjJPAlwHP+iBmKII7cn8ChK
	 SYIIktM02g3OQ==
Date: Tue, 13 Aug 2024 13:48:17 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: convert maxim,ds26522.txt to yaml
 format
Message-ID: <20240813194817.GA1629980-robh@kernel.org>
References: <20240809143208.3447888-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809143208.3447888-1-Frank.Li@nxp.com>

On Fri, Aug 09, 2024 at 10:32:06AM -0400, Frank Li wrote:
> Convert binding doc maxim,ds26522.txt to yaml format.
> Additional changes
> - Remove spi-max-frequency because ref to
> /schemas/spi/spi-peripheral-props.yaml
> - Add address-cells and size-cells in example
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/spi@2100000/slic@2: failed to match any schema with compatible: ['maxim,ds26522']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/net/maxim,ds26522.txt | 13 ------
>  .../bindings/net/maxim,ds26522.yaml           | 40 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/maxim,ds26522.txt
>  create mode 100644 Documentation/devicetree/bindings/net/maxim,ds26522.yaml

netdev didn't pick this up, so I applied, thanks.

