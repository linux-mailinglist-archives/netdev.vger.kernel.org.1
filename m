Return-Path: <netdev+bounces-141211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFCF9BA0DE
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33991C20E8C
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 14:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3DB187355;
	Sat,  2 Nov 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYVmfx3z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665815A856;
	Sat,  2 Nov 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730559278; cv=none; b=qSHNyCtI6w0BYxPKib1IxsqmY7RC+PLxENHcr43RyUG/x5r/6OdA12GoJp849nFVdp72IjqngDoTKYRRjY//2B3Nmb5EqrmYcs+CUw9CLALVi2EeB7dyhxWKzEDDHdMFnaf43zE+PABF8wt1uoDZqkHApfIRrAWLSq/JyWaRx2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730559278; c=relaxed/simple;
	bh=JWsU0s/lAvc2Fk2HY0b9OTdWjv3rVfDYEP25bPd4z30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYykfMGLkCF1as7Q9DVMjE+Dmtzm+Ldr9vVi6M/YyWFz77KyItE0l8Z512u08KNZLstAf6WxMNL4N7ql9ckQxBixBZksdEcebi6W4dFc5Bc2wnCuchtdeVRrANh6+gcMElFSF1cPr1EM1pI1RvtX9/x/kEJV+1vZH40y8GM9Uw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYVmfx3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E83AC4CEC3;
	Sat,  2 Nov 2024 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730559277;
	bh=JWsU0s/lAvc2Fk2HY0b9OTdWjv3rVfDYEP25bPd4z30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYVmfx3zNNq56YhKO92+y9ZqUvMDKy01eX3enKE53TrIyHfDUexHN67uC8ywu6nmK
	 eSka+nhlVxE7lOPNw9Cis01L7o1dl+3VZQpgO51ZL6TidW4moKUNygc41I5LtYWsLf
	 qtHrYwyD+U0+dFWpCD9u4EKsbr1GEp8BCqQ5nF7Mvs9IX+/IrB6ELJ36XVCMbWUkXl
	 0SpZOTWGaNSLluOlybxyXqFLQCk8uMhGEGg5g2pZ+8/03iYOEdPzuPWYCZS7CMEevA
	 5YvbTJ9B/a0T02B808R2+OBduGAazKFhoob1Gq86A3nCF/YhDfZFa5Nw0Cmdlv6uW6
	 a+m7nh14NuDNw==
Date: Sat, 2 Nov 2024 14:54:27 +0000
From: Simon Horman <horms@kernel.org>
To: Linu Cherian <lcherian@marvell.com>
Cc: davem@davemloft.net, sgoutham@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gakula@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, jerinj@marvell.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.comi,
	jiri@resnulli.us, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 net-next 2/3] octeontx2-af: Knobs for NPC default rule
 counters
Message-ID: <20241102145427.GO1838431@kernel.org>
References: <20241029035739.1981839-1-lcherian@marvell.com>
 <20241029035739.1981839-3-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029035739.1981839-3-lcherian@marvell.com>

On Tue, Oct 29, 2024 at 09:27:38AM +0530, Linu Cherian wrote:
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

Reviewed-by: Simon Horman <horms@kernel.org>


