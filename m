Return-Path: <netdev+bounces-244369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F8CB58C3
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 11:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5E9C300EDC1
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA8730649F;
	Thu, 11 Dec 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAfQy3Cm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4B306480
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765449975; cv=none; b=PpFWQODomRkV/GReqnX891wHzD6S0880aLYx4ghY1CFWM7VZomEBSu7I29pGK/qWpcov9HCzahHq9Re4zxOACKFPYTz9R1A016/g/STUpkfqv6ISQHnEu797Gd1PNpt0RTcLSDjQfs82LUdpPbh2RbxkMOTB39C2lrb4PCFhBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765449975; c=relaxed/simple;
	bh=CDEzU92iSPeV6EvWgQpqfh/Cc1pOL9vf4n+8OzbVL9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6xIxK4SrpH/PTjH+AoRnS5Gg3GaxXmMDA1Qm63MA6meNJOBukrqkdrkxZFMgz8PSSC3nFuRaS6kzgB4eKIv+L5UMdsP9/ymJCzZxti4jtPB5GRm97SIhniox1oa4VQZBQEk6Cfgzilr96+JWfYQ9dLXyo7oiL1nktMFcHSFhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAfQy3Cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D679C4CEF7;
	Thu, 11 Dec 2025 10:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765449974;
	bh=CDEzU92iSPeV6EvWgQpqfh/Cc1pOL9vf4n+8OzbVL9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAfQy3CmoEiL2ZtVXStuZMdG2RZy9Vcl9TPNfSYw4MLIVGAmvDMcbu2HWASIEmadL
	 Zufy/yNdRRtJEx3gB6dGt+jFzJwpQk1mO2oqiQArYcgxi72rjbN81cuZZzCOBnwltO
	 yvz/Fsl7kdiD282aXrg7KyWT3MAtfT86a8xgyEr7mcufwqsKUD1OsgfvkLR98p7DFx
	 6i0v/EjqO2uFM//uZ2te8um7lRdpT9oCo+98K2sPsnNSG3A8rLvuae4KrqOLVZKGtd
	 QVUQ9X34rxD1XWc3oS9JNNzH9NSiQORhyAvSjwGhevz4jD2Ie/kHY6CVwUdTFtUkGE
	 N5E0n/LTkUWcw==
Date: Thu, 11 Dec 2025 10:46:11 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] sis900: remove module version and switch to
 module_pci_driver
Message-ID: <aTqg83pPKbmY755E@horms.kernel.org>
References: <20251211075734.156837-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211075734.156837-1-enelsonmoore@gmail.com>

On Wed, Dec 10, 2025 at 11:57:34PM -0800, Ethan Nelson-Moore wrote:
> The module version is useless, and the only thing the
> sis900_init_module routine did besides pci_register_driver was to print
> the version.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Hi Ethan,

Thanks for your patch.

And I agree that not having this kind of information is current best
practice (and has been for quite some time AFAIK).  So I think this patch
is a good way to go.

Reviewed-by: Simon Horman <horms@kernel.org>

However, I also think that this is net-next material.

It's best to make that clear by targeting the net-next tree like this.

Subject: [PATCH net-next] ...

It usually isn't necessary to repost a patch just to address this.
But as it happens net-next is currently closed. So I'd like to
ask you to repost this once it re-opens.

## Form letter - net-next-closed

The merge window for v6.19 has begun and therefore net-next has closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens.

Due to a combination of the merge-window, travel commitments of the
maintainers, and the holiday season, net-next will re-open after
2nd January.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

--
pw-bot: defer

