Return-Path: <netdev+bounces-229355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE2CBDAFC1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 21:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9713E6682
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38F8239E63;
	Tue, 14 Oct 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhSWib2N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96949659;
	Tue, 14 Oct 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468535; cv=none; b=pp20CI35pWFZMjZEgRQTSKwuWsSSUyDcb4RpNdc/7MyeSnnc/mjjNypiWIUTcsWwItT+JM1NBjvBIONRAb/8+hg6mmQeVKAv+mH+o3bQ/rOSf85bLz3AGLrfiw1bktVEvBW+LOeRinIjHjL3opnx/QwHR4f9ngDxbtIFmyaFbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468535; c=relaxed/simple;
	bh=veGq6jM3TwQRz0xvX8KQf7q8LqvH+u6ZFRfJ6M+EA70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyxSQMgIMqhodsGYw0YFBpImGufXOdA9arYhaT8g79ynahIuoZi6Vj95trVc47S0WWif6H0U1G5cUsC2b0jzB7hm9J6lsLEu7q1jgHje2UjfYCU8mypJAgTIbYHNJuo2U6C8u2R/Vl4L00Tlb2Miw6PIwvgAIH9/904AgDrL9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhSWib2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DB4C4CEE7;
	Tue, 14 Oct 2025 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760468535;
	bh=veGq6jM3TwQRz0xvX8KQf7q8LqvH+u6ZFRfJ6M+EA70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bhSWib2N4kQ1hurhElQ1NKQVKfdUTHsPCxLtNa79mGu7D2zFfDGJbj0OZ1xLh6CWL
	 f/w/4ngcSPiC3k8uD6GO5m0a5l1c95+D7/MFSW01FE2BSzi1xhtBmz8rdBJZIuc39d
	 N3AJxoMkGmKxXmqzUflVmZK4zLmdXj7DfZSIEt7Ek7mxi+P5EUFiorIwcShkwPlW09
	 A82lywN8ElRpzufRmcin4bETvvWAxQNTsrma7b5hrPUg3kSt9d+qp8AYpuyEu+3NiT
	 6xElXQ0w482qJ0cJKK1pN9UFdEMrXlZ9GG+JdChBJvSgP9yNGs2sT7OAvHsqTiBgxC
	 JDb9KbRnZy51w==
Date: Tue, 14 Oct 2025 12:02:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <20251014120213.002308f2@kernel.org>
In-Reply-To: <20251014-projector-immovably-59a2a48857cc@spud>
References: <20251010183418.2179063-1-Frank.Li@nxp.com>
	<20251014-flattop-limping-46220a9eda46@spud>
	<20251014-projector-immovably-59a2a48857cc@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 19:12:23 +0100 Conor Dooley wrote:
> On Tue, Oct 14, 2025 at 07:02:50PM +0100, Conor Dooley wrote:
> > On Fri, Oct 10, 2025 at 02:34:17PM -0400, Frank Li wrote:  
> > > Add optional clock for OSC_IN and fix the below CHECK_DTBS warnings:
> > >   arch/arm/boot/dts/nxp/imx/imx6qp-prtwd3.dtb: switch@0 (nxp,sja1105q): Unevaluated properties are not allowed ('clocks' was unexpected)
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>  
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable  
> 
> Hmm, I think this pw-bot command, intended for the dt patchwork has
> probably screwed with the state in the netdev patchwork. Hopefully I can
> fix that via

The pw-bot commands are a netdev+bpf thing :) They won't do anything
to dt patchwork. IOW the pw-bot is a different bot than the one that
replies when patch is applied.

