Return-Path: <netdev+bounces-165638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508B0A32E99
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD9D3A9AAE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94F5260A3C;
	Wed, 12 Feb 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOzfkl02"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DCF260A4F
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384476; cv=none; b=dgx1Oa3ColZO1DqolRqVFApgO8ZAervLFsSq3neEruHolhfOh1xvUmnN2UmP6M6m2sfgq/ekS/Oazhl90sTilRIMVt49FuaIUvM8uyuONB/p5+R6lRYRDNKCZXN8ZJZTiDKmcj/TNRXkw1wkHefKlcs5CyVLRud6gykMxmf9Ljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384476; c=relaxed/simple;
	bh=wD+92cBbxCe7rCQkfdRtFyyzmOpbJZjmX685H3g2G58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auDYy84Y6DuSDf3PsKW1UF23FmIy6bbR8ihxkxGOOSXqkg06DCsfjV5+ipRPYD1jp07xZAys99f6lrNeLFS6TG4v95u9Jh92IW+Z/hmFgMoWQCJreSExYqapCnipbMDQkNeD32JmlXFjYCtji5xaxrNHSW4rmVBFtkLjqBfIc2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOzfkl02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DB2C4CEDF;
	Wed, 12 Feb 2025 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739384475;
	bh=wD+92cBbxCe7rCQkfdRtFyyzmOpbJZjmX685H3g2G58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOzfkl02hIKMj5oI8ivS67Rjpjjlt9MDd+tTFIcWyNFZeNHDelWh6+ry0yC+zuhoW
	 96h6/vpGJtHZ6QTby8IvAivv9Fbdk3Plh7C31KauOphYIM0PKdg1xdAE4d9xqUbTzg
	 A7/SeNxV0sFJ/uJrPPQPluE3wpWI8hOb+zj2YbnC0pTXYi7Oym7nTUQgs9nFbmoAmh
	 gvePIZlYqLH/obaOZORwnE2D21RMk+vgrDtJmWjvrIHTWeyAA5uIm1KVCrnWPgAnnR
	 4MK73hWsQH/KlVp25GBgv+eJRyaSD6BmLyIJyWrksSfS/HjATBDmWcnJ6LkUugaq5Q
	 aPfW8uxuBhkkg==
Date: Wed, 12 Feb 2025 18:21:11 +0000
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	decot@google.com, willemb@google.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, madhu.chittim@intel.com
Subject: Re: [PATCH iwl-net] idpf: check error for register_netdev() on init
Message-ID: <20250212182111.GH1615191@kernel.org>
References: <20250211023851.21090-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211023851.21090-1-emil.s.tantilov@intel.com>

On Mon, Feb 10, 2025 at 06:38:51PM -0800, Emil Tantilov wrote:
> Current init logic ignores the error code from register_netdev(),
> which will cause WARN_ON() on attempt to unregister it, if there was one,
> and there is no info for the user that the creation of the netdev failed.
> 
> WARNING: CPU: 89 PID: 6902 at net/core/dev.c:11512 unregister_netdevice_many_notify+0x211/0x1a10
> ...
> [ 3707.563641]  unregister_netdev+0x1c/0x30
> [ 3707.563656]  idpf_vport_dealloc+0x5cf/0xce0 [idpf]
> [ 3707.563684]  idpf_deinit_task+0xef/0x160 [idpf]
> [ 3707.563712]  idpf_vc_core_deinit+0x84/0x320 [idpf]
> [ 3707.563739]  idpf_remove+0xbf/0x780 [idpf]
> [ 3707.563769]  pci_device_remove+0xab/0x1e0
> [ 3707.563786]  device_release_driver_internal+0x371/0x530
> [ 3707.563803]  driver_detach+0xbf/0x180
> [ 3707.563816]  bus_remove_driver+0x11b/0x2a0
> [ 3707.563829]  pci_unregister_driver+0x2a/0x250
> 
> Introduce an error check and log the vport number and error code.
> On removal make sure to check VPORT_REG_NETDEV flag prior to calling
> unregister and free on the netdev.
> 
> Add local variables for idx, vport_config and netdev for readability.
> 
> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 27 ++++++++++++++--------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c

...

> @@ -1536,12 +1540,17 @@ void idpf_init_task(struct work_struct *work)
>  	}
>  
>  	for (index = 0; index < adapter->max_vports; index++) {
> -		if (adapter->netdevs[index] &&
> -		    !test_bit(IDPF_VPORT_REG_NETDEV,
> -			      adapter->vport_config[index]->flags)) {
> -			register_netdev(adapter->netdevs[index]);
> -			set_bit(IDPF_VPORT_REG_NETDEV,
> -				adapter->vport_config[index]->flags);
> +		struct idpf_vport_config *vport_config = adapter->vport_config[index];
> +		struct net_device *netdev = adapter->netdevs[index];
> +
> +		if (netdev && !test_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags)) {
> +			err = register_netdev(netdev);
> +			if (err) {
> +				dev_err(&pdev->dev, "failed to register netdev for vport %d: %pe\n",
> +					index, ERR_PTR(err));
> +				continue;
> +			}
> +			set_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags);
>  		}
>  	}

Hi Emil,

I'm wondering if we could reduce indentation and lines longer
than 80 characters in the above like this (completely untested!):


	for (index = 0; index < adapter->max_vports; index++) {
		struct idpf_vport_config *vport_config = adapter->vport_config[index];
		struct net_device *netdev = adapter->netdevs[index];

		if (!netdev ||
		    test_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags))
		    continue;

		err = register_netdev(netdev);
		if (err) {
			dev_err(&pdev->dev, "failed to register netdev for vport %d: %pe\n",
				index, ERR_PTR(err));
			continue;
		}
		set_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags);
	}

