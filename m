Return-Path: <netdev+bounces-129438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEF3983D99
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9F91F2145C
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 07:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B71212CD89;
	Tue, 24 Sep 2024 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzhmkftn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337784E0D;
	Tue, 24 Sep 2024 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161832; cv=none; b=Ca+rfZOjxLO1ErWeeYMxvZWA2Gh+fjqwJrWQQHaI7/+yCwdgGYVRSfAQe2+ZOkbDNH2liZmVe35HpAUJeimHKulRUJ5Epp1erGJgvKaKbvj+YfgpARsXgTYneLfirh+BtIqNU7rmTyWW5uNdOu9Qexn4CYkbh1z31m5PD0wyPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161832; c=relaxed/simple;
	bh=J1Mzwbb6R+Of/FLiZzU4w2OfGxlCEp/duydxpK93YbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpOSTTyKbPTIdAXsjvv1pNSb3ClkFVtC5sLPd03IzZmhUJdh0qYtqoND7NYYNNH/FoJGXp5/6MJct/bgUTW5UhaOb3rJutIZaLd7sa9YQJNneMex0LEARIcMBaRT35ezp4KcTnZXO1Yzru5o4Lh31B80+qY77u3BFdg3z5oM9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzhmkftn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B627BC4CEC4;
	Tue, 24 Sep 2024 07:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727161830;
	bh=J1Mzwbb6R+Of/FLiZzU4w2OfGxlCEp/duydxpK93YbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzhmkftnPKk/hCG2MVaGu6gTydQ6IRQ0CUBzv+4WDO4lYzzIZBTlK7n1uFY1B0f8G
	 zKTMSxQ1ADbSb9pHrWoc2CZYsATpSqm7l/q6n1sv3sJMScAJO6fJ7+XyTeG8Rx69Gc
	 YjPERNla8AWsk04+4vyQEbN+8FYwsAOa8zDd8Ve+6Rp/QTVWJBX48IadQIFGzEWEbE
	 pKsHgomi9UD0GGb5BASIEUvPF+c5IWXmeZNSC8xG2ZEqE3BGG6KNyK4+NaBXHBsfCz
	 4+ViVU5gOuIS9wL8tPb0joq+5VH2fCyC6YNFuFdAQgRCDsMCs2AOZ0ELT5n2us2iwx
	 D0vxw3vdUBHpA==
Date: Tue, 24 Sep 2024 08:10:26 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_ethtool.c
Message-ID: <20240924071026.GB4029621@kernel.org>
References: <20240923113135.4366-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923113135.4366-1-kdipendra88@gmail.com>

On Mon, Sep 23, 2024 at 11:31:34AM +0000, Dipendra Khadka wrote:
> Add error pointer check after calling otx2_mbox_get_rsp().
> 

Hi Dipendra,

Please add a fixes tag here (no blank line between it and your
Signed-off-by line).
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

As you have posted more than one patch for this driver, with very similar,
not overly complex or verbose changes, it might make sense to combine them
into a single patch. Or, if not, to bundle them up into a patch-set with a
cover letter.

Regarding the patch subject, looking at git history, I think
an appropriate prefix would be 'octeontx2-pf:'. I would go for
something like this:

  Subject: [PATCH net v2] octeontx2-pf: handle otx2_mbox_get_rsp errors

As for the code changes themselves, module the nits below, I agree the
error handling is consistent with that elsewhere in the same functions, and
is correct.

> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 0db62eb0dab3..36a08303752f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -343,6 +343,12 @@ static void otx2_get_pauseparam(struct net_device *netdev,
>  	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
>  		rsp = (struct cgx_pause_frm_cfg *)
>  		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
> +

nit: No blank line here.

> +		if (IS_ERR(rsp)) {
> +			mutex_unlock(&pfvf->mbox.lock);
> +			return;
> +		}
> +
>  		pause->rx_pause = rsp->rx_pause;
>  		pause->tx_pause = rsp->tx_pause;
>  	}
> @@ -1074,6 +1080,12 @@ static int otx2_set_fecparam(struct net_device *netdev,
>  
>  	rsp = (struct fec_mode *)otx2_mbox_get_rsp(&pfvf->mbox.mbox,
>  						   0, &req->hdr);
> +

Ditto.

> +	if (IS_ERR(rsp)) {
> +		err = PTR_ERR(rsp);
> +		goto end;
> +	}
> +
>  	if (rsp->fec >= 0)
>  		pfvf->linfo.fec = rsp->fec;
>  	else

-- 
pw-bot: changes-requested

