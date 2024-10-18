Return-Path: <netdev+bounces-136988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6359A3DB9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94D71C23B68
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6508472;
	Fri, 18 Oct 2024 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEg8E1bR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3060AA954;
	Fri, 18 Oct 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252924; cv=none; b=aJPzLGaQy2REp/Wagqh3CxkTGAilgzq1QVnFpjpsI8TLC6z/8qIxskoRnXwuN9K/XBreKggJlaT0cmdDcmGqJyQ08wtGgyvh1zBOjjCBYMP1hjyZyhBTt8iIBAPP5vbjueaKewQuI3Udc/HhqHC1hs9xWOrTm0S4iC8LeSDNHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252924; c=relaxed/simple;
	bh=rzYunjPy6/Gvza09FYhriResuPfVJ8jdWjgLtSvhebk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FssVzw+z+7HvVeZRSwP/k9mQnmSHYTO0NDRhCdGlsQZ+VoL980Fkl5oVviVCyQN13SOicggjycMXUsFzFBsxiXAEZAszJeYErJm2TEFmCvkP69BY1Gk+hnesS2wCTNCzJVwy93uK/ysBQsBG13TiKeZH6bhcATqpy9CG7oNRaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEg8E1bR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C40C4CEC3;
	Fri, 18 Oct 2024 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729252923;
	bh=rzYunjPy6/Gvza09FYhriResuPfVJ8jdWjgLtSvhebk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEg8E1bRofGbP7sWUNmfpbYP446JpIEsQpd6lnlIrSydYUcbhXc0XkwUY5uIxXoJv
	 UmQe/3fJ+EDVL/hfrtUBGjthJRsHHJA6LZWidfendcZk346PH9yc+whAdjO7c3ujPy
	 Jo2+5IG3MxyZkhJE5rlrnvzpo1TV6NxyQaNSHDD/lF/7KBPqJpPCYOc3bysSbUHo5v
	 miH+jNf3u+A2YKxarvFbfLZ5qX3w/96Xwvsbz/dHdiUtbD5BfpbZ/sv9OMQTTOJiQr
	 VedbH2nQMXAOhsYxCG0MMFMOxsAhc92hk63guCdFFiqYSU7HhkoqhafoGgf5MHE5Vn
	 5PToLzSIHZwsg==
Date: Fri, 18 Oct 2024 13:01:59 +0100
From: Simon Horman <horms@kernel.org>
To: Linu Cherian <lcherian@marvell.com>
Cc: davem@davemloft.net, sgoutham@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gakula@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, jerinj@marvell.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v3 net-next 2/2] octeontx2-af: Knobs for NPC default rule
 counters
Message-ID: <20241018120159.GJ1697@kernel.org>
References: <20241017084244.1654907-1-lcherian@marvell.com>
 <20241017084244.1654907-3-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017084244.1654907-3-lcherian@marvell.com>

+ Jiri

On Thu, Oct 17, 2024 at 02:12:44PM +0530, Linu Cherian wrote:
> Add devlink knobs to enable/disable counters on NPC
> default rule entries.
> 
> Sample command to enable default rule counters:
> devlink dev param set <dev> name npc_def_rule_cntr value true cmode runtime
> 
> Sample command to read the counter:
> cat /sys/kernel/debug/cn10k/npc/mcam_rules
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v2:
> Moved out the refactoring into separate patch. 
> 
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
>  .../marvell/octeontx2/af/rvu_devlink.c        | 32 +++++++++++++
>  .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 45 +++++++++++++++++++
>  3 files changed, 79 insertions(+)

Hi Linu,

This looks like a good approach to me.
However I think you also also need to add documentation for npc_def_rule_cntr
to Documentation/networking/devlink/octeontx2.rst

Likewise, octeontx2.rst seems to be missing documentation for the existing
AF parameters npc_mcam_high_zone_percent and nix_maxlf. I did not see
if there are any more undocumented parameters for octeontx2 but I'd
appreciate if you could do so.

...

