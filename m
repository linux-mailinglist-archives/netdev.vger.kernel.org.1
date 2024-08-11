Return-Path: <netdev+bounces-117487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C5594E1B3
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F341C20D1F
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C36E1494DF;
	Sun, 11 Aug 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2JtRZCQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BA1CAAF;
	Sun, 11 Aug 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723387312; cv=none; b=HwPvGG+0XDnCoqRLrXoFKWwQ6ruyL8qgrngEIEs9bYTdSCW0uvSjLOjhjznwXjn8spLUm5HF7ejffQHx6SChcJ4aTRFhvekc1Nv4RwLQLCLSP9nmyJN0qaHBwYUAWXYgW+4FMBvlnv11gGhIrtPHYMOx9hujLulcIFLxLgvJeAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723387312; c=relaxed/simple;
	bh=e9DgOEq6OLvmcRv/CH6wRxKEHV8xntvIpbRaCP8T9Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClgsFk9brj2ywi0mfBDgAkLJgpsXXTGQKsoFVz8C7RMLik3AulpYMLevEB81K96l4svkt3svj7YjZTOZ0onj6flirHWf+QJQbRgc1Nn7+1LKrPaawnN4mEWkCHBedbnmlAe4ooU9J5RQVv7NKCs9dP6YRSkin1eqs29F/eyLIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2JtRZCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD0DC32786;
	Sun, 11 Aug 2024 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723387311;
	bh=e9DgOEq6OLvmcRv/CH6wRxKEHV8xntvIpbRaCP8T9Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2JtRZCQUiBO8aEG94JtdjaLJL1ab3qWYNwtnmPDDaR1GVWCLpZUIuLzm2qf9LpsQ
	 QtHuo/VuhFaH2bn7DNb9dAWd7z/cmi26koZ5LJPCsvnjKMJGhzudAt67ADkRhXFfAe
	 nBRWsMyD2ZPzeOPEBp4XoMn6rcTkVIXwfvLFrT0aFlE2MrwZg+5+Wfjm5mt0oKnSDx
	 F1y89gru3HUTcDbHsVNfLGaMALb9/zmYZg1IvH5PNoNsb4S5tvoD4SPYjrx5tfTOTp
	 K24kZh2ELuvrd0Rcv/aaJMzD1rNJu0I/K/g1CJR3LUdDR3kONDxIEFTYPmH4LxCL8R
	 +3ZwF5RI5uL5w==
Date: Sun, 11 Aug 2024 15:41:47 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] arm: dts: st: stm32mp151a-prtt1l: Fix QSPI
 configuration
Message-ID: <20240811144147.GL1951@kernel.org>
References: <20240809082146.3496481-1-o.rempel@pengutronix.de>
 <20240810095129.GH1951@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810095129.GH1951@kernel.org>

On Sat, Aug 10, 2024 at 10:51:29AM +0100, Simon Horman wrote:
> On Fri, Aug 09, 2024 at 10:21:46AM +0200, Oleksij Rempel wrote:
> > Rename 'pins1' to 'pins' in the qspi_bk1_pins_a node to correct the
> > subnode name. The incorrect name caused the configuration to be
> > applied to the wrong subnode, resulting in QSPI not working properly.
> > 
> > To avoid this kind of regression, all references to pin configuration
> > nodes are now referenced directly using the format &{label/subnode}.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Pass

Sorry about the noise here. This was supposed to be a note to myself, that
I am not planning to review this.  It doesn't imply anything about the
patch.

