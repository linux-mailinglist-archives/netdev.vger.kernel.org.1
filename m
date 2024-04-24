Return-Path: <netdev+bounces-91041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0238B119F
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 20:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2851628CCE1
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C34816D4F4;
	Wed, 24 Apr 2024 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE4qNPQr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E716D4E0
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981661; cv=none; b=a+SaCBqS+zk1Mtxrl85W0Wx/NbWAf8DGUjKX+ytO5yCHyEz26upRB/gjPo+oNgb6qXiSrxFgU5Fzzs0EW1zdQUrkBOX+BgCmihjiw4OMLfnb2PsIdC4pUfqTZDlN23yIDg423O2MrY1wLa1LNEv+/J8usQDwmnew1Gz55O12jQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981661; c=relaxed/simple;
	bh=hQ8GBngsSIbRdhSyau59HqkHCog6kIfhM77Nv6lySVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh4RhwzwBKdlwfsirPd7gJ+JcFT0FFpH1VVwyr03B5gpoTXsP55RaLjDlH9Fvu4oNxfY+ICk6mNyM9qD/OWyyR+HSEYY0ZoCRqo1BKFokZoyrsDLsmWZ1f7f49MD1O30Rap7lSe8wxYrXstfyhcTlfSsFhEtGoLi0TMcmbrfOyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE4qNPQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B949C113CD;
	Wed, 24 Apr 2024 18:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713981660;
	bh=hQ8GBngsSIbRdhSyau59HqkHCog6kIfhM77Nv6lySVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PE4qNPQr/D7nT2tA9Q2OAmZ/Ko8BzPZgaZ5yWqJWUNTiz4NUHKYx1MZr9RlRc4zBI
	 92ibDA1+w13yiThV1rwPo911URCS0KVF9HC3VCSpVag8GY4Yv+WzWIIfz8RhE5gD26
	 UzfJBjBmi7pZcax7hNzS4M1mftkOrDpJVDQFhkXO4PHx7zWs9iM3xd4ftvmj7cImyt
	 7qtr37bM8NN8P2lTwJdn8m9TuJJJpvvtBugDZzEl9UydxcTTCIxWYEGhr3rO0tNVuY
	 2/jAPpfds8pidI7wkhd3zysQWbBSI3iWnIGal5o9TJVrzqVgFzdnR2nCxlC8iSONKV
	 zEI+M1eux3Kmg==
Date: Wed, 24 Apr 2024 19:00:57 +0100
From: Simon Horman <horms@kernel.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] enic: initialize 'a1' argument to vnic_dev_cmd
Message-ID: <20240424180057.GQ42092@kernel.org>
References: <20240423035154.6819-1-satishkh@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423035154.6819-1-satishkh@cisco.com>

On Mon, Apr 22, 2024 at 08:51:54PM -0700, Satish Kharat wrote:
> Always initialize the 'a1' argument passed to
> vnic_dev_cmd, keep it consistent.

Hi Satish,

I think this patch also addresses cases where a0 are passed
uninitialised, so probably that should be mentioned too.

Also, I think it would be worth explaining a bit more about
why this change is being made. Does it resolve a bug?
If not, perhaps mention why.

The comments above and below notwithstanding,
I agree that the code changes are correct.

> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> ---
>  drivers/net/ethernet/cisco/enic/vnic_dev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.c b/drivers/net/ethernet/cisco/enic/vnic_dev.c
> index 12a83fa1302d..288cbc3fa4fc 100644
> --- a/drivers/net/ethernet/cisco/enic/vnic_dev.c
> +++ b/drivers/net/ethernet/cisco/enic/vnic_dev.c
> @@ -718,14 +718,14 @@ int vnic_dev_hang_reset_done(struct vnic_dev *vdev, int *done)
>  
>  int vnic_dev_hang_notify(struct vnic_dev *vdev)
>  {
> -	u64 a0, a1;
> +	u64 a0 = 0, a1 = 0;
>  	int wait = 1000;
>  	return vnic_dev_cmd(vdev, CMD_HANG_NOTIFY, &a0, &a1, wait);
>  }
>  
>  int vnic_dev_get_mac_addr(struct vnic_dev *vdev, u8 *mac_addr)
>  {
> -	u64 a0, a1;
> +	u64 a0 = 0, a1 = 0;
>  	int wait = 1000;
>  	int err, i;
>  
> @@ -1164,7 +1164,7 @@ int vnic_dev_deinit_done(struct vnic_dev *vdev, int *status)
>  
>  int vnic_dev_set_mac_addr(struct vnic_dev *vdev, u8 *mac_addr)
>  {
> -	u64 a0, a1;
> +	u64 a0, a1 = 0;
>  	int wait = 1000;
>  	int i;
>  
> @@ -1230,6 +1230,7 @@ int vnic_dev_classifier(struct vnic_dev *vdev, u8 cmd, u16 *entry,
>  		dma_free_coherent(&vdev->pdev->dev, tlv_size, tlv_va, tlv_pa);
>  	} else if (cmd == CLSF_DEL) {
>  		a0 = *entry;
> +		a1 = 0;

Assuming this is not a bug fix, while we are here the scope of the
declaration of a0 and a1 could be reduced to this block.

>  		ret = vnic_dev_cmd(vdev, CMD_DEL_FILTER, &a0, &a1, wait);
>  	}
>  
> -- 
> 2.44.0
> 
> 

