Return-Path: <netdev+bounces-216913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4CBB35F62
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF58462B0C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B947483;
	Tue, 26 Aug 2025 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jlfha4Ku"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F97393DE4;
	Tue, 26 Aug 2025 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212323; cv=none; b=AkIVHbhDOS9JTaZsi4FsH+IDLrLYn7wfyNWXIQCofQ8pYMXn4JAFVas7q8EPG2OGY+GtOJTyiswPtZNpxJz3vDyZiGCS9UASvgcaH29Ch8O9Xf1tyW5yYZxXIoHv6p8xFRV8zwoBOu1KqDgNitqk2A1fr5N2YyYD2fI57dys6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212323; c=relaxed/simple;
	bh=nnDGtdgZzrjN74DP6Dk2rfUSCsQt65c/uWyWdvfjcjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHK1dy5RgXnV146IsDM06ycYDddhZoGjK+1Jw3CbCPzThKbJjd0ixd7WcY1mReIJusIH32mxVa+QzJWgYYcgdgm/OpkN7Mx1YKqxZSSAeMtFmOfBxppWazDW88bd4uV5ubJ6EsyYZdktjdTdsm7pb+M6hV32D1bKgFCFJ1uW/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jlfha4Ku; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OV/ZWn4UMJO8MYqIEUn4hMIDYxFzl+Qbc0So399rPFI=; b=jlfha4Kum5UkcAASBKr5baU7Rj
	7aaZTINLTu1PFi3nN8RqKmoSAn1GS/5+wk/LUF3r3GLqQkruXzqLRlKBxiixs1YX6qLI7rK1gFT1X
	RPRq9PGZ0+WouQq3KLjndRUiivACCTKs3GZMTsArQ9KPy40QcJDAcDzC+g63BtsVM+1w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqt37-0065g9-Fq; Tue, 26 Aug 2025 14:45:17 +0200
Date: Tue, 26 Aug 2025 14:45:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, davem@davemloft.net,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, yzhu@maxlinear.com,
	sureshnagaraj@maxlinear.com
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: mxl: Add MxL LGM
 Network Processor SoC
Message-ID: <67fbd87c-058a-4833-b899-208d59bb03e9@lunn.ch>
References: <20250826031044.563778-1-jchng@maxlinear.com>
 <20250826031044.563778-2-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826031044.563778-2-jchng@maxlinear.com>

> +patternProperties:
> +  "^interface@[1-4]$":
> +    type: object
> +    properties:
> +      compatible:
> +        const: mxl,lgm-mac

Shouldn't you be referencing
Documentation/devicetree/bindings/net/ethernet-controller.yaml here?

How do you specify the MAC address? Link to the PHY, indicate there is
an SFP, describe LEDs?

	Andrew

