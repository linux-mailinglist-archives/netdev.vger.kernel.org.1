Return-Path: <netdev+bounces-249065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B63D1391C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EEC431C061F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D752E1730;
	Mon, 12 Jan 2026 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWQlcdr7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805EB2DA760;
	Mon, 12 Jan 2026 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230151; cv=none; b=NJN0LEpYN6cSJC//EIiske3/hpekSkdLCa3smNbIasNgJI8/4EBqsqXjo4Q771MJQCFEMvARbpHHg0+UOJh96t61yZu7MtEcc+OHHNKFHy5+XkAEAW5g6IlIXz1VlW1BMwhCwZHzmwKSbWBnUfBmrGf15A02ufPBkPPDKkw+XXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230151; c=relaxed/simple;
	bh=Ae7WpaO1J58wZ6XHUKdyKvVyk3a9mihKfWDlokrMAmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpGagOQOwo4mi6VXESUnc41BldVdlwhUOUWOaSxFMJxmRtL7aQXojEmm4ZUaMKGnCZAmJdPg6340cl2j+/RHggvzmsIVvP25r0QrIMvO5ICA5NEIY8S+FL8xUaCWpSlib+zAFZZ/nVbeDIWzuYxqbkTmllgc0KsSMzG7mmt0yFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWQlcdr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39072C19422;
	Mon, 12 Jan 2026 15:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768230151;
	bh=Ae7WpaO1J58wZ6XHUKdyKvVyk3a9mihKfWDlokrMAmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWQlcdr7qyhoD+qSMO/SbTyz0xX3OVS3b/SrwH0JagzlV8Vc25Wwkmo5laoMPBxSf
	 rvWo6QmO7MSJBxh3CxA7CfGrzerVem7QII7cN3vFK1dIW4HePZZa5Uw8FL58qL8/YX
	 Zquj5dyYzGy4TJAg3bpoDMIjiNxRo8gL+OGeAtXJAVt76kx7zgWRyLm7IxThQLJCnU
	 7YH5J1O3ooKSxdyMycKZmWtoHuxStvp85Mess1pV/ZyrEdy2COwwnAevlQfHq6mxlq
	 uhygBzDXvGdb4XIfnIZEzMxvt/KzsEAf+0TCjm1AR7ABTezoecuMkEcQiSVUfL+4vM
	 yCTiIi0LviCFA==
Date: Mon, 12 Jan 2026 15:02:27 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] net: ftgmac100: Various probe cleanups
Message-ID: <aWUNA823xsZfQBlw@horms.kernel.org>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
 <20260107155427.GB345651@kernel.org>
 <ec093af3-93a0-4a9a-9688-ba870d42156a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec093af3-93a0-4a9a-9688-ba870d42156a@lunn.ch>

On Wed, Jan 07, 2026 at 05:09:00PM +0100, Andrew Lunn wrote:
> > I'm slightly unclear on the providence of this patchset.
> 
> This driver needs a cleanup before aspeed fix up the mess they made
> with RGMII delays, which is going to make the probe code even more
> complex. In a fit of boredom on a train, i made these cleanup
> patches. But i don't have the hardware, so passed them onto aspeed for
> testing and bug fixing. I said they could submit them, appending their
> own Signed-off-by:

Thanks Andrew,

That satisfies my curiosity.
All good from my side.

