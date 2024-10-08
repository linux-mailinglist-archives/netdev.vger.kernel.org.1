Return-Path: <netdev+bounces-133113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B702E994EB1
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97401C253C7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962F1DE89F;
	Tue,  8 Oct 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5MC3edB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EE18C333;
	Tue,  8 Oct 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393611; cv=none; b=aZk3KYjp9QCrZINgDvPlvBsdIq5sPyOrHhKZTv3GFHHXn9//uPkIJOrfExDZQtN1i9+/0UbFI6KDkProfgHA5R2HMSqEJaJ9Hw4Zm5vA6OnqdLrUm2nbkn0vqAG4BV3ZblcSei2sozn3I2NL/MWfmQA9+olKpbiN4DQQ78Diga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393611; c=relaxed/simple;
	bh=OitgDUOVP367trg7vVeSHNToJ0hVFr5bgKklQJCIdlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nW21TroOzv+BUA2EFiWD/tm1nKrYQg8k04UDFzXUnnDoIA+cYjpEuglRpdF4aO0+sQH5YXZskRqZ70YVcqff5ZoosYztUkErhwX8t0KS8Prku28FEu382zLPDWcKFaxbTmghfKyXb2v5Q1cVN4Xbs9H2chOErNGVKncKnuAXHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5MC3edB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BCCC4CEC7;
	Tue,  8 Oct 2024 13:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728393611;
	bh=OitgDUOVP367trg7vVeSHNToJ0hVFr5bgKklQJCIdlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5MC3edBoXDdW0APCtZXrr3biuw9cfkiwUE/tr7E0xtjjcgOKN14niY1EW6c+E27g
	 vtNdODDlyTWhd9FExRiYuNOqi6XGv/D7CSXSPeOK4jqtlxE4h2lTSAWTuQLqmwXg8D
	 0G7RWI0MoRA25Q+HruTVQp/YXekk5Bqr4IsipAnNhDiCunIwbeHcgQMjx/MhVVchr9
	 lGZ80y5EoPyQylvfhKcvVFURiZxI8E5bHvrZvg7htlOJm3e7TDgFEv0oph/DlFN+AH
	 6tgGK3kMEjXMYcRbiTb3/6nTs+g9NElNH+MA8TRFnkW64HR9SpXyqe0xEltokBE1Eu
	 Hc5i6AwXk4fMQ==
Date: Tue, 8 Oct 2024 14:20:07 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
 in otx2_ethtool.c
Message-ID: <20241008132007.GM32733@kernel.org>
References: <20241006164210.1961-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006164210.1961-1-kdipendra88@gmail.com>

On Sun, Oct 06, 2024 at 04:42:09PM +0000, Dipendra Khadka wrote:
> Add error pointer check after calling otx2_mbox_get_rsp().
> 
> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
> Fixes: d0cf9503e908 ("octeontx2-pf: ethtool fec mode support")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
> v3:
>  - Included in the patch set
>  - Changed the patch subject
>  - Added Fixes: tag
> v2: Skipped for consitency in the patch set
> v1: https://lore.kernel.org/all/20240923113135.4366-1-kdipendra88@gmail.com/
>  .../net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c  | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Simon Horman <horms@kernel.org>

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 0db62eb0dab3..09317860e738 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -343,6 +343,11 @@ static void otx2_get_pauseparam(struct net_device *netdev,
>  	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
>  		rsp = (struct cgx_pause_frm_cfg *)
>  		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
> +		if (IS_ERR(rsp)) {
> +			mutex_unlock(&pfvf->mbox.lock);
> +			return;
> +		}
> +

FWIIW, a goto label would ordinarily be preferred here.
However, I see that what you have done is consistent with
existing error handling within this function.
So I think the approach you have taken is ok.

>  		pause->rx_pause = rsp->rx_pause;
>  		pause->tx_pause = rsp->tx_pause;
>  	}

...

