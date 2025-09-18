Return-Path: <netdev+bounces-224500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87705B859D2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71E23BF977
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9981C30CB41;
	Thu, 18 Sep 2025 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+a6IybE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060C30C60A;
	Thu, 18 Sep 2025 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209329; cv=none; b=RvSIfvSun8QoDc+4/p+ipw7Bpvl8yfVo4WBSdrLaWmx+iyxh4+vV1eRTdCXQ6mNhqR9QJ40vRi6Ge2wq57lPMHMJQmBRg/rsxKmbRD/z46gU74Yd/6NAtpSVO4Iyqu9R6q0iWqhdx1wJ2GEtJVitgxoevYFeS5vafSI3gRMIfsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209329; c=relaxed/simple;
	bh=MtbgUNu+gRqm89t38yv/Q96LAM7/E7PPWZ1CBLGzIZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iR9s9Y2e1ZaM9ptk+uX0qfSaFMCxs54ZWvxHWPCjqO6zQeuFUFbk4eBOkh/L1TfHV3emojGYVyfpWS78n3CY0R6N43TQcQYdHFdtjhPNIa6QnzPni/fK9OdrX52/+GFCPjmbeQA/mTCdgKTSd6Xl5f5VZDNuxk+o1O8dbstxNXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+a6IybE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35204C4CEE7;
	Thu, 18 Sep 2025 15:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758209329;
	bh=MtbgUNu+gRqm89t38yv/Q96LAM7/E7PPWZ1CBLGzIZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r+a6IybER3eG9wgCQ04oKi7V6ewRoChGgZCQFBRpmZ24jvAo8uZT+GRPHEFVfeOWm
	 q/wcFp6gr5x2O9nrEeEp9H8nftezAZcVqgi56k+wKxY7jd7JQlm7MBYseP1VoAZxUV
	 vbWTzOzXicr2FMA0qhHwb/ufRRiaZvEcQ7cZ2nCbpXqrCLV0inCb5jflc2rOKvgUH6
	 uuWFxh68g5ZnLh72aZrnHh8gLgZJFqtO2C0EIli1Sb+4cGaA5Bl4fsk9WbQwXjAPjX
	 kMYrrWApdvDgjVXDTtJP0Hx4SFJgpniapxcLqrC2dbznpwSY+1F8WPYjozz5/VRTfD
	 PRVGBPCius3DQ==
Date: Thu, 18 Sep 2025 08:28:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Walle <michael@walle.cc>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Michael Walle
 <mwalle@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Lunn
 <andrew@lunn.ch>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Roger
 Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next] Revert "net: ethernet: ti: am65-cpsw: fixup
 PHY mode for fixed RGMII TX delay"
Message-ID: <20250918082847.66e21c0d@kernel.org>
In-Reply-To: <734CD0B0-9104-45C8-A8E5-679FC7B7A346@walle.cc>
References: <20250728064938.275304-1-mwalle@kernel.org>
	<57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
	<DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
	<d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com>
	<DBOEPHG2V5WY.Q47MW1V5ZJZE@kernel.org>
	<2269f445fb233a55e63460351ab983cf3a6a2ed6.camel@ew.tq-group.com>
	<88972e3aa99d7b9f4dd1967fbb445892829a9b47.camel@ew.tq-group.com>
	<84588371-ddae-453e-8de9-2527c5e15740@lunn.ch>
	<47b0406f-7980-422e-b63b-cc0f37d86b18@ti.com>
	<DBTGZGPLGJBX.32VALG3IRURBQ@kernel.org>
	<804f394db1151f1fb1f19739d5347b38a3930e8a.camel@ew.tq-group.com>
	<20250918075651.4676f808@kernel.org>
	<734CD0B0-9104-45C8-A8E5-679FC7B7A346@walle.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 17:11:50 +0200 Michael Walle wrote:
> [reply all this time..] 
> 
> Am 18. September 2025 16:56:51 MESZ schrieb Jakub Kicinski <kuba@kernel.org>:
> >On Mon, 04 Aug 2025 15:45:08 +0200 Matthias Schiffer wrote:  
> >> I can submit my patch for U-Boot some time this week, probably tomorrow. Do you
> >> also want me to take care of the Linux side for enabling the MAC delay?  
> >
> >What's the conclusion with this regression?
> >If we need a fix in Linux it'd be great to have it before v6.17 is cut.  
> 
> Sorry I'm on mobile, so I can't use my korg account.
> 
> But on the linux side this is fixed by the following patch:
> https://lore.kernel.org/all/20250819065622.1019537-1-mwalle@kernel.org/
> 
> You can close this in pw (if that's still in a pending state).
> 
> Thanks for taking care and sorry I haven't mentioned the follow-up patch here. 


Ah, the patch that went into the PHY tree! That explains it.

Thanks a lot for a quick response!

