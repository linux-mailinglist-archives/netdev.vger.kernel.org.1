Return-Path: <netdev+bounces-226672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EED33BA3EC9
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDC77B5748
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740572F60A1;
	Fri, 26 Sep 2025 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CawEyyL0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011F2F60C0
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894097; cv=none; b=e81OWS4qUIt74xufddtEfS4k/lAxNP4IidQ4Bj8EXX2Y9oe+mPPC0EJ9FEJJP2PDMyetq9xf8RI3LFBkW5GnmYt3VnXHOxlKJCoNDU+p9PHGm0ZgU8+7QXfha2pShAw8RxMXeahh9tNs5M2QmGhAA3r23P3lPn6oQ2/y6ERmTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894097; c=relaxed/simple;
	bh=oWKIqfp8lQ9LsSf/4D8fB8l2/iXkFavKhilsa5N0OHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeHyQKk1+eQwH/FJ+MesdyikFFqmXGVXBmCXLbWo0asn0RG7nDFpGbaCW7SkzxPSFeGEwW+ZQ1zexjNeuVlziq5le3DQVXiycgUNlO2LnQhP2gbuB3meFrHDor5Z2KjlWn95RttoxBB6x7h1/pzz0g2zFKnG+8//7+EJuytMDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CawEyyL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903F9C4CEF4;
	Fri, 26 Sep 2025 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894096;
	bh=oWKIqfp8lQ9LsSf/4D8fB8l2/iXkFavKhilsa5N0OHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CawEyyL0IrIJ6TYwumvGGAQm806W45WPUtpH0Q26SdsRSNe+i6Vj3GAL3i4ExKYSN
	 PmfgTlSbcBcrF0N37w9ONT88TnED1GTwlerJ+d+HRqEwcpy35sWFeC9C71P7+uK7OF
	 gk1nwpuzYHgxgV4SqdL6Tlg6yliKylH5nHMscQdo+mDi5kaZ8BpvvIShaCG3yu7SR5
	 VaCMOQU0FuLcp4gxXaYckvSLRjXDUaagQnt4oVG8Xq6vV/FA2PfKaoUts99mf88Biy
	 TvdTTMgYtPcBWIYc0Voc4L0wzLU0i5cRKBZ9jO94urzwlb11zp+ib0aRQJ55Qhc1KU
	 y8iDQUMLHfh+A==
Date: Fri, 26 Sep 2025 14:41:33 +0100
From: Simon Horman <horms@kernel.org>
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net 2/2] idpf: fix issue with ethtool -n command
 display
Message-ID: <aNaYDXAJnq-DkDe3@horms.kernel.org>
References: <20250925153358.143112-1-sreedevi.joshi@intel.com>
 <20250925153358.143112-3-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925153358.143112-3-sreedevi.joshi@intel.com>

On Thu, Sep 25, 2025 at 10:33:58AM -0500, Sreedevi Joshi wrote:

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c

...

> @@ -184,6 +186,29 @@ static int idpf_add_flow_steer(struct net_device *netdev,
>  	if (!rule)
>  		return -ENOMEM;
>  
> +	fltr = kzalloc(sizeof(*fltr), GFP_KERNEL);
> +	if (!fltr) {
> +		err = -ENOMEM;
> +		goto out_free_rule;
> +	}
> +
> +	/* detect duplicate entry and reject before adding rules */
> +	spin_lock_bh(&vport_config->flow_steer_list_lock);
> +	list_for_each_entry(f, &user_config->flow_steer_list, list) {
> +		if (f->fs.location == fsp->location) {
> +			err = -EEXIST;
> +			break;
> +		}
> +
> +		if (f->fs.location > fsp->location)
> +			break;
> +		parent = f;
> +	}
> +	spin_unlock_bh(&vport_config->flow_steer_list_lock);
> +
> +	if (err)
> +		goto out;
> +
>  	rule->vport_id = cpu_to_le32(vport->vport_id);
>  	rule->count = cpu_to_le32(1);
>  	info = &rule->rule_info[0];
> @@ -222,28 +247,20 @@ static int idpf_add_flow_steer(struct net_device *netdev,
>  		goto out;
>  	}
>  
> -	fltr = kzalloc(sizeof(*fltr), GFP_KERNEL);
> -	if (!fltr) {
> -		err = -ENOMEM;
> -		goto out;
> -	}

Sorry, but I'm not following why the allocation of fltr is moved.
It seems that the return path, both for error and non-error cases,
would be slightly simpler without this part of this patch.

> +	/* Save a copy of the user's flow spec so ethtool can later retrieve it */
> +	fltr->fs = *fsp;
>  
> -	fltr->loc = fsp->location;
> -	fltr->q_index = q_index;
>  	spin_lock_bh(&vport_config->flow_steer_list_lock);
> -	list_for_each_entry(f, &user_config->flow_steer_list, list) {
> -		if (f->loc >= fltr->loc)
> -			break;
> -		parent = f;
> -	}
> -
>  	parent ? list_add(&fltr->list, &parent->list) :
>  		 list_add(&fltr->list, &user_config->flow_steer_list);
>  
>  	user_config->num_fsteer_fltrs++;
>  	spin_unlock_bh(&vport_config->flow_steer_list_lock);
> +	goto out_free_rule;
>  
>  out:
> +	kfree(fltr);
> +out_free_rule:
>  	kfree(rule);
>  	return err;
>  }

...

