Return-Path: <netdev+bounces-118242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7748A951046
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5FA1F24820
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D496D1AED22;
	Tue, 13 Aug 2024 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlObxjtY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69FB1AC427;
	Tue, 13 Aug 2024 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590219; cv=none; b=UhzjdNisglys4dQjSXcf6DbciM2mlIPAJGTNjz+4iEriiqYOwbkt+nw0x8PGRPDUUfB8jdGj5nsd4yoSUr/59RIO2bfgrdciukvWyo8hg6AqC9WDecQoKqKvcaOdsSXPxUA3PgXhdo3tkmW4AodrkS9mRRK1kE5cfWjQ1RHxQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590219; c=relaxed/simple;
	bh=lp7uSJRiTTBHrLo/DVE+4oyUfn9+eFpgssiOiAeRz74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnIS4X0uGPMnYmF4Rl6yRbjPB9WvN+mI6NWH+JJFz54ovg0REDZ/HdLfmNSCiIipCwOBmZ+KA7V3aMvQkpkNWd842ShgRDPuVsiVY17ydA1DZd6gqd3Vj8WeNGxOBi/A4U4kEzHuPeI4zMirco8QUbiMj6+UPwjn22nfTsFZqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlObxjtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801DBC4AF0C;
	Tue, 13 Aug 2024 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723590219;
	bh=lp7uSJRiTTBHrLo/DVE+4oyUfn9+eFpgssiOiAeRz74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OlObxjtYKz5g50GL6TE5MQVvfbAGE4f2Yk7bubkJH+8i51mL+B78bBoLkQu1jMGEL
	 R1OmAu6Kg5WDIpDcRHsV60/O8zn8mIfzN8994M17jBLMY2oYQVk8+ryNj5HQn1olNW
	 nFcUZQkZZ+mWoSSfIA17i3ttkXjaQVKkIAxWfOgeVBJoko4rAhxJkDeflY80cdvvfu
	 ZomQ0+SXA1XSg53e4ka+nvEYdkNeg3MmuJ2gQfh3v/9FU7wdzG/P1dStqfo3xafckF
	 v+r//v3NpfLINC1unM9U0u+GH1d3wdfIQ9Bcn/AVNAu8su18LUa4QxsroyMipBrI1w
	 1T0wwGldtHHGA==
Date: Tue, 13 Aug 2024 16:03:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
 linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
 linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC
 DRIVERS), imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: soc: fsl: cpm_qe: convert network.txt
 to yaml
Message-ID: <20240813160337.638eee6f@kernel.org>
In-Reply-To: <20240812165041.3815525-1-Frank.Li@nxp.com>
References: <20240812165041.3815525-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 12:50:35 -0400 Frank Li wrote:
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,cpm-enet.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,cpm-mdio.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,ucc-hdlc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt

Any preference who applies this? net or soc or Rob? No preference here,
FWIW:

Acked-by: Jakub Kicinski <kuba@kernel.org>

> Sorry, It is sent by accidently. it was already post at
> https://lore.kernel.org/imx/20240809175113.3470393-1-Frank.Li@nxp.com/T/#u

patchwork for one thing considers this a newer version of the previous
posting. So hard to tell where any discussion is expected to happen.

