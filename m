Return-Path: <netdev+bounces-249479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4334D19BE6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 235A83024F77
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44682EDD45;
	Tue, 13 Jan 2026 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqLkAafZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C02EA490;
	Tue, 13 Jan 2026 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316854; cv=none; b=tsXKX/mSbAr02LYo6+wSwJrhLIerTNtYxG61plmxzeVB80MEcksf+6Qu241bEv3VNdStvvdOfvvoySvP0KZED2cptkeM5uX3s83zLjzBc9FgfXoFlrysfz4hP5rjLA+T/oWhn745VdLvq/XVXilOLToHbRAFa27fGh2g0vfPFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316854; c=relaxed/simple;
	bh=kCuQ0ij1Y+/unHswtDoNgzxyh96mltfgo/pfVbF3aes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiV9hr4oGP/n9YGiDF8X24N0egQ/Gv//TFCW9Kw+xF2gnTwe/KpP1mTuBe9N6jyy6WfaRI5KBYZByWlFOp65RXCYkK9YLXG84PI2nw1hfgO3FRT9opsDJXnb/DcWUAveYlB4sawojFHcdFrzb0iw481GP+5n6ZSC63FWw3Sz/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqLkAafZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7B9C116C6;
	Tue, 13 Jan 2026 15:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768316854;
	bh=kCuQ0ij1Y+/unHswtDoNgzxyh96mltfgo/pfVbF3aes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sqLkAafZPsxrqZ/vgi7qDKjRluH05Wl3wbgnaxjnw4XcFMzIaai6RTi/H581LYgdb
	 OPeOlqgMFvk7BDTMWN/K6Srb5ubcLSd27P0MhKBG/pXmELH0D+SRm74N6HtgERpVkE
	 YyjMROuWnyBEbjfHrjjVdSVqoqAQw0qGD01wlmo7WqjE68JZvNtniSqydS7x5ekhZ2
	 BeflhGUGB27RA+9G5aY0Ck+ww3mFYMbFbX7JGKrD4vJ5OQdKl7RZuss4riKcyqYu80
	 BNf+9d4mBma2GBIqv9g2ld9te6Y53AOtHMFRw9jW2rrwmZEhUCNLj6r1pe6t1L/Cir
	 PV/PImQzpruXQ==
Date: Tue, 13 Jan 2026 07:07:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 01/13] octeontx2-af: npc: cn20k: Index
 management
Message-ID: <20260113070732.6eb491de@kernel.org>
In-Reply-To: <aWYebi6adm9zD2gB@rkannoth-OptiPlex-7090>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
	<20260109054828.1822307-2-rkannoth@marvell.com>
	<20260110145842.2f81ffdc@kernel.org>
	<aWYebi6adm9zD2gB@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 15:59:02 +0530 Ratheesh Kannoth wrote:
> On 2026-01-11 at 04:28:42, Jakub Kicinski (kuba@kernel.org) wrote:
> > On Fri, 9 Jan 2026 11:18:16 +0530 Ratheesh Kannoth wrote:  
> > > +static int
> > > +npc_subbank_srch_order_parse_n_fill(struct rvu *rvu, char *options,
> > > +				    int num_subbanks)  
> >
> > Please avoid writable debugfs files,  
> I explored devlink option, but the input string is too big.
> 
> > do you really need them?  
> Customer can change subbank search order by modifying the search order
> thru this devlink.

Unclear what you're trying to say. Hope you documented this much better
in v4, otherwise this series if 7kLoC will take a very long time to
review..

