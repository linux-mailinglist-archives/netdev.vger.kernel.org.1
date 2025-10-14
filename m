Return-Path: <netdev+bounces-229375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D644BDB4FB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C043AC51A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C842DCC13;
	Tue, 14 Oct 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac1UXg+S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063A2877FA;
	Tue, 14 Oct 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474890; cv=none; b=IskXLde4tYer1iicF+3UMowtCx1RwJjDaXHDrS9SuHLs+2C+Afu+8ldnMisgyAqyXJm2Z28xv2cJpX3b0MV1NDXaju75lUarDj2oK40+TesvxPiDtx8zbhzcVSrASfuFWo1IMC30Kiwha0bAtzjjLfspWVlzwQJK4rbpJ25161c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474890; c=relaxed/simple;
	bh=Em10QkwHKTKXlsyI+2+xjbCURDQJuQZ+0ngrcp0Ttxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLVZ+YS2IjHi0JYNjfuSNuEcm9EPfWwSd/ab4UHzSryPUXjNznEzUH+MtkNcWefwoFD7KQHNnjJJyWliLfkDd2u0bVHENt8HFSf8TIaVW2K9gDBvT/CY7BbFeD82LSBIg6PYIJMkiSTIGoxw57uy8JOFmMq5pv7TwKg9G37CWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac1UXg+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A1BC4CEE7;
	Tue, 14 Oct 2025 20:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760474889;
	bh=Em10QkwHKTKXlsyI+2+xjbCURDQJuQZ+0ngrcp0Ttxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ac1UXg+SCBy9/GWTf/+/DigHGLV9tHgtMrbSVcPYyXrhuFmiThCmMHN9AJKuNqNRL
	 Ufwo89GtcIXqjUwkdu3ynzYbGkO63J+XIJCkkYNhxXhwFaIraxXRmPVVgCpB5OxjTD
	 d+y1Y6UGQ8TXXfnUwedOEYs9+m8PTH5ZLOHJ6IEkftT19EHlmcdOf5TVHTY+aeuNs1
	 Cgmwt2YB0p9Az1C5Q8QjcVdYsNv4u9Pay4JrOzxRSSRGPxz9uyvbUUhXBR9L3XJivv
	 APhB4MK8AyEYDnP8wl0QR0Ec37I4RM/KnZFPeLgRu3Te76fy7uR2LKIAubikoL6FXJ
	 HCeltuj8/Nmfw==
Date: Tue, 14 Oct 2025 15:48:07 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: nxp,sja1105: Add optional
 clock
Message-ID: <20251014204807.GA1075103-robh@kernel.org>
References: <20251010183418.2179063-1-Frank.Li@nxp.com>
 <20251014-flattop-limping-46220a9eda46@spud>
 <20251014-projector-immovably-59a2a48857cc@spud>
 <20251014120213.002308f2@kernel.org>
 <20251014-unclothed-outsource-d0438fbf1b23@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-unclothed-outsource-d0438fbf1b23@spud>

On Tue, Oct 14, 2025 at 08:35:04PM +0100, Conor Dooley wrote:
> On Tue, Oct 14, 2025 at 12:02:13PM -0700, Jakub Kicinski wrote:
> > On Tue, 14 Oct 2025 19:12:23 +0100 Conor Dooley wrote:
> > > On Tue, Oct 14, 2025 at 07:02:50PM +0100, Conor Dooley wrote:
> > > > On Fri, Oct 10, 2025 at 02:34:17PM -0400, Frank Li wrote:  
> > > > > Add optional clock for OSC_IN and fix the below CHECK_DTBS warnings:
> > > > >   arch/arm/boot/dts/nxp/imx/imx6qp-prtwd3.dtb: switch@0 (nxp,sja1105q): Unevaluated properties are not allowed ('clocks' was unexpected)
> > > > > 
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>  
> > > > 
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > pw-bot: not-applicable  
> > > 
> > > Hmm, I think this pw-bot command, intended for the dt patchwork has
> > > probably screwed with the state in the netdev patchwork. Hopefully I can
> > > fix that via
> > 
> > The pw-bot commands are a netdev+bpf thing :) They won't do anything
> > to dt patchwork. IOW the pw-bot is a different bot than the one that
> > replies when patch is applied.
> 
> Rob's recently added it to our patchwork too.

And the issue is that both PW projects might get updated and both don't 
necessarily want the same state (like this case). So we need to 
distinguish. Perhaps like one of the following:

dt-pw-bot: <state>

or

pw-bot: <project> <state>

Rob

