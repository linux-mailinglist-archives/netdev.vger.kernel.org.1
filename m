Return-Path: <netdev+bounces-102366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21250902B57
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B391F22F5B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D2415099A;
	Mon, 10 Jun 2024 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWOL5lmx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E496D14387E;
	Mon, 10 Jun 2024 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057134; cv=none; b=A6TSgAwcudyTdmERgptwt9D4rysQ06ZY86IGb5P/2ljVGJkW5KhUHtqhlPZaAKvvXfbZkMQJ5bdRDPDwseYt6Z82r/YJKiO9PQGeDsiPed4CDTP0CpkBfeU2HkySNrrlaVTCtJHvfsHLe6KOpH1POXbUOhMprmxnRWRALJmt8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057134; c=relaxed/simple;
	bh=tSuqjTp5FJnedSsZD7bF1qb7Fac29OmHUqEX5tXHTBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSn81VIph1LvFL1fRYQ2vEY9l/sQRqAyES8uzFji2YZcmw25MOWXNK+BVP6OvQ6LbQAldwzAj4d2VE5J8OjMG2ATbr/TBjobwe0So4BKaoISgS+YdXpLmPeU/v7vwTK82q6z82vsTqJxpNjkwQswhISCK81q0Km1DptVZFWsj4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWOL5lmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C4FC32789;
	Mon, 10 Jun 2024 22:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718057133;
	bh=tSuqjTp5FJnedSsZD7bF1qb7Fac29OmHUqEX5tXHTBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWOL5lmxyDn748hP7jrbXeLv865TYQusE8uDDpwwmjZhcS52obbNVz1m0Br+qX06C
	 W6RilN5tkokyu+HbkhNw2lqp8T7jjXAeUp5CVk0FXpGUppGvExeUd+ANi5yEWedmBv
	 NhWK1TS4EGodVH8kaWnPhXCNVRvAn7WW1NzzonaEEDaK4xItplyLO6ChuPbprXcaOD
	 yiwNuhcBi40t/PIzneD7QKQvGyVN0xWo1VtpKSE0uiiPDayZ+Jrlk1/xfrSkkdEXPM
	 7T3G8692P9tnvgPQiEq+S0SPi94+FXJ13sdCVxTxnOR6cOcTK9m3duRztqgEXROUGF
	 NY6jvJmjVh5sg==
Date: Mon, 10 Jun 2024 16:05:31 -0600
From: Rob Herring <robh@kernel.org>
To: Martin Schiller <ms@dev.tdt.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	martin.blumenstingl@googlemail.com, hauke@hauke-m.de,
	andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/13] dt-bindings: net: dsa: lantiq_gswip: Add
 missing phy-mode and fixed-link
Message-ID: <20240610220531.GA3144440-robh@kernel.org>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-2-ms@dev.tdt.de>
 <ae996754-c7b9-4c46-a3dd-438ab35d6c67@kernel.org>
 <c410ac7cce5fe6bf522bac6edb18440d@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c410ac7cce5fe6bf522bac6edb18440d@dev.tdt.de>

On Mon, Jun 10, 2024 at 11:07:15AM +0200, Martin Schiller wrote:
> On 2024-06-10 10:55, Krzysztof Kozlowski wrote:
> > On 06/06/2024 10:52, Martin Schiller wrote:
> > > From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > 
> > > The CPU port has to specify a phy-mode and either a phy or a
> > > fixed-link.
> > > Since GSWIP is connected using a SoC internal protocol there's no PHY
> > > involved. Add phy-mode = "internal" and a fixed-link to describe the
> > > communication between the PMAC (Ethernet controller) and GSWIP switch.
> > 
> > You did nothing in the binding to describe them. You only extended
> > example, which does not really matter if there is DTS with it.
> > 
> > Best regards,
> > Krzysztof
> 
> OK, so I'll update subject and commit message to signal that we only
> update the example code.

Either convert it or leave it alone. If you are worried about users' DTs 
being wrong due to copying a bad example, then you should care enough to 
do the conversion. Given the errors we find in examples, it's likely 
not the only problem.

Rob

