Return-Path: <netdev+bounces-129336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFEC97EE95
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD362817A4
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D695B199923;
	Mon, 23 Sep 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQiEla8x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6A146A86;
	Mon, 23 Sep 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106971; cv=none; b=KaviWmBvuVwwV9wNHD0kImKG1Stfb5dfHxx4ilrUyIIYqUZ1nUrydFIPKM+VBKEdXJr22sVb9ekUw8ygWeI8pkGc/uB1iG9xJPdhEvL/6rRZGAGHdzOlSiFDThycgcwj9b6QhjSuvbcihdAAIez/V0K+UjKkNJ7qThJLC3TUBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106971; c=relaxed/simple;
	bh=l2jEMii5JSbv/FCwmREbX1ZvFRNHHliJQH1mbhgt5OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5GfhNeOmDpyt0Zt4RVsnlUWGooYhuX+9/t1z/B0aDcOt25yCXUFJPUvagJRj+fft1qT693UJu8RGC6Ur/bIETkQB7NyhWv295bT9nJAxwjoyZskYQiA0LmJtZJgnChtzSYNrF22fAhx8eg3N0ZrkqYk2FeoNbOm5x8Nnw006Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQiEla8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007B2C4CECD;
	Mon, 23 Sep 2024 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727106971;
	bh=l2jEMii5JSbv/FCwmREbX1ZvFRNHHliJQH1mbhgt5OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQiEla8xieiFYicSKDHbJNPPO6ukXwKDwRkeGgnmhG9MlJEWm/3YHQdhXVlCwjdp1
	 FbtbYQ2M63Y+ZsYvhJ4NF/1WlaRBv6hFjUJebl6VnuZ9LUVmT5xNuU42+oXjHmhQMU
	 giANTf322PUT/Z0Z/LDvqXGrBylVJWFgENTLzPVdB4FeHw6FKsAj6t2t5ticlOZyBi
	 qKXmVscK1ZkPsYX614asYUq9HkEFzWCAu9NL9khfmGonCmAaYLUSVQ9HW1LmqZexk9
	 /Bo/v6P8orbpz6rfGB/mzKOgIBAXOIoiuRkmxwbcltk9NWrz3LNB+49UkKcNPXFP7i
	 3dcTNXMEWiEzQ==
Date: Mon, 23 Sep 2024 16:56:06 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: net: nic: Add error pointer check in
 otx2_flows.c
Message-ID: <20240923155606.GJ3426578@kernel.org>
References: <20240922185235.50413-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922185235.50413-1-kdipendra88@gmail.com>

On Sun, Sep 22, 2024 at 06:52:35PM +0000, Dipendra Khadka wrote:
> Smatch reported following:
> '''
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:123 otx2_alloc_mcam_entries() error: 'rsp' dereferencing possible ERR_PTR()
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:201 otx2_mcam_entry_init() error: 'rsp' dereferencing possible ERR_PTR()
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:236 otx2_mcam_entry_init() error: 'frsp' dereferencing possible ERR_PTR()
> '''
> 
> Adding error pointer check after calling otx2_mbox_get_rsp.
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Hi Dipendra,

As noted by Andrew Lunn in relation to another patch [1],
this driver isn't in Staging so the subject is not correct.
And moreover, as Andrew suggested, please take a look at [2].

[1] https://lore.kernel.org/all/13fbb6c3-661f-477a-b33b-99303cd11622@lunn.ch/
[2] https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_flows.c   | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 98c31a16c70b..4b61236c7c41 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> @@ -120,6 +120,11 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
>  		rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
>  			(&pfvf->mbox.mbox, 0, &req->hdr);

nit: No blank line here please.
     Similarly in the other hunks of this patch.

>  
> +		if (IS_ERR(rsp)) {
> +			mutex_unlock(&bfvf->mbox.lock);

This doesn't compile as bfvf doesn't exit in this context.

> +			return PTR_ERR(rsp);

Looking at error handling elsewhere in the same loop, perhaps this
is appropriate instead of returning.

			goto exit;

> +		}
> +
>  		for (ent = 0; ent < rsp->count; ent++)
>  			flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
>  

...

