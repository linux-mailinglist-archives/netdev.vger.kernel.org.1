Return-Path: <netdev+bounces-201046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21245AE7E91
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570E818953FB
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C9729AB0F;
	Wed, 25 Jun 2025 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLOsQbSI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D6285C80;
	Wed, 25 Jun 2025 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846030; cv=none; b=nUCcP8t6kInCOFjr0RNAWkRrnZGj2AUHox7h/cJUPT78wWYASpWiVKtf8sxWjCOCq3Bu2yKmiHnYNdRnUhI2LJrnsXWTGM8SbieLAwqHGvcY4VLORBk/nqLUlnbJK+TjChzE3NkA2yzIbhb8+Ct2OxZsgFEZ8+VRbGeg38ODnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846030; c=relaxed/simple;
	bh=u1v/VflBVeJW0lcXjEJcOdcBO83HueedcrdPTEBh7ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdkOHoicp/Byi5ChrEdYi8fze/09tTxuD+qYF8xD+fPheAImQJOS7PmBd//+XmsYD7AW/82Azm0/iEB+xoax8refoIqjGaSj4W447ZH3l3qON3wpvO/Dk0x/DGAb8fKZ/C2+xWs1jXdrTomm3v6oTdTeR1CTCi8o2m1oDN/x+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLOsQbSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0B8C4CEEA;
	Wed, 25 Jun 2025 10:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750846030;
	bh=u1v/VflBVeJW0lcXjEJcOdcBO83HueedcrdPTEBh7ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLOsQbSITvtOzYmZHO32DSPwrP2ISGfpFAamNzc2JMW51ZFS9Ik3aAU6epRNhRsMa
	 wZW99CeKODLhus91YQsA8ZBiqMV2BzkZbrnahnWPN/3/MP3FTvybtAGxvC8+pcw0yc
	 xb/9YLHPnMq6S9S9ZPg5KUrGSc75R6qYPm9fUVGB6UsYGsVjLv/LpSTufoy9i2RhD0
	 PqBlnm19y5fc6azMxSfSaaTifB/X6RFKSGrLTLrNu9xdgmcBbPyCtO3MS+DsW0+YoG
	 5oJf8x4ETivlER6DD1eIpYDQ7GT/SQ0wVczHJf5lmypjAzVCQa5lQ/TnjIekV86Vwz
	 /sag4V0FjQQmg==
Date: Wed, 25 Jun 2025 11:07:06 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/7] net: splice: Drop unused @gfp
Message-ID: <20250625100706.GS1562@horms.kernel.org>
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
 <20250624-splice-drop-unused-v1-5-cf641a676d04@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-splice-drop-unused-v1-5-cf641a676d04@rbox.co>

On Tue, Jun 24, 2025 at 11:53:52AM +0200, Michal Luczaj wrote:
> Since its introduction in commit 2e910b95329c ("net: Add a function to
> splice pages into an skbuff for MSG_SPLICE_PAGES"), skb_splice_from_iter()
> never used the @gfp argument. Remove it and adapt callers.
> 
> No functional change intended.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Simon Horman <horms@kernel.org>


