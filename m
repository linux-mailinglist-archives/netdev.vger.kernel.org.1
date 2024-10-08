Return-Path: <netdev+bounces-133115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B238994EC2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEEA3287FF7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056A41DEFF8;
	Tue,  8 Oct 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHw2QOAL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04031DE4CD;
	Tue,  8 Oct 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393648; cv=none; b=RZNrKJCB1frEaJFD1QrUFf6/RFZZRyTAF3uGgtTAC1Ohw0+Ulkh1hShCd85jCXOPUQTvwOC8sjCQhEvnb+dcfx+Enmq0aQqRUEU/8TrMzAm/zjeKm0QYzjSS7G7ectdAhTG3WeThnXjpdknMEQure3PFE0w5/PLDngvqofdRIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393648; c=relaxed/simple;
	bh=p79jGiXG+OxbAT9GE0rpDt15shpU2r8+2KOa97rwmOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmSAHlIpcw2h0Bk4HScbCm87TFAy19e/6jnyhg3aPXo3k5RicWJc10w0isEOYETR9uASafe8ReROnwU50/HAbES7ndR8tkICnWgK3LX2CvOUKCo3Ol2MUhSfp95a90XLSmB6LKZHrOcBp5lCs+MSAscHWNgzq3qUSqocEXpYi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHw2QOAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F532C4CECD;
	Tue,  8 Oct 2024 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728393648;
	bh=p79jGiXG+OxbAT9GE0rpDt15shpU2r8+2KOa97rwmOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHw2QOALTuP987NgBuT3FoSq4iXey0rN8urT4U9UfDp28aKUDxSP4a2DenL6YioH9
	 AE56AAsJkhCdhiU4A34aIL9bUdVFLtbTlNktU3XcpqkO8ce8X/zKmG13oSmrgrLvfB
	 K2RAcX3UwDrQE1Hk1LlUsvyJydsnrToVfVyNTb7meOKj1T2GWOl8gCdr4taFqSNG8E
	 KAK+HMBHsafVnuMmCftl6lU/cIvFo0YRyypmOkiAQQ96e4fvYtjCyOF9/G0WLhBWtM
	 m965l3w1zauOZAqjR+Y699JoCjAzyktYNAwN8Q1GSJyOKkcuNLdrAQyOyC86pS4uim
	 AeGl38spIlIZw==
Date: Tue, 8 Oct 2024 14:20:44 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
 in otx2_flows.c
Message-ID: <20241008132044.GO32733@kernel.org>
References: <20241006164322.2015-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006164322.2015-1-kdipendra88@gmail.com>

On Sun, Oct 06, 2024 at 04:43:21PM +0000, Dipendra Khadka wrote:
> Adding error pointer check after calling otx2_mbox_get_rsp().
> 
> Fixes: 9917060fc30a ("octeontx2-pf: Cleanup flow rule management")
> Fixes: f0a1913f8a6f ("octeontx2-pf: Add support for ethtool ntuple filters")
> Fixes: 674b3e164238 ("octeontx2-pf: Add additional checks while configuring ucast/bcast/mcast rules")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
> v3:
>  - Included in the patch set
>  - Changed patch subject
>  - Added Fixes: tag
> v2: https://lore.kernel.org/all/20240923063323.1935-1-kdipendra88@gmail.com/
>  - Changed the subject to net
>  - Changed the typo of the vairable from bfvp to pfvf
> v1: https://lore.kernel.org/all/20240922185235.50413-1-kdipendra88@gmail.com/
>  .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 98c31a16c70b..c96f115995f8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> @@ -119,6 +119,10 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
> 
>  		rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
>  			(&pfvf->mbox.mbox, 0, &req->hdr);
> +		if (IS_ERR(rsp)) {
> +			allocated = PTR_ERR(rsp);
> +			goto exit;

This does not seem consistent with other error handling within the same
loop. I'm unsure if it is correct, but my reading that the current approach
is:

		if (IS_ERR(rsp))
			goto exit;

> +		}
> 
>  		for (ent = 0; ent < rsp->count; ent++)
>  			flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];

...

