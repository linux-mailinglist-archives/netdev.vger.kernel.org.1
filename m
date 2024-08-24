Return-Path: <netdev+bounces-121652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0695DE1B
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 15:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FC41F21B7F
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7871714C7;
	Sat, 24 Aug 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+REtyjR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873216DC28
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724506349; cv=none; b=TE7OD3GrxBPggwQfnxDvtkzUiPYqUJs7W+LD+/qMjNN8JOiaa5QLdihb15n23JvSnP8heyXrlh5F2EIiSbcaRQ6opMxCKQlnJfs9K7pjacWuHMk8ZyGuloaIAg7axa/lNgOy3e8m9CSYxIGc3tOjSU0QKRKvzvoD4VgDKQ3C0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724506349; c=relaxed/simple;
	bh=yWDV6zMHCzJEYB1oaS9d3E9GAKtkhUP1/BrP+7WaSHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP+jv/sWAqXHZJ9ZrIissl2Syj6qR4ooBE1IkEsUcK1IrjAHcIbx3hQyjGB7u1RSUmiSSHT6YLTApsbYyFvqZ8XAI/f/n3/U6y0fesaBvnilmpvOBnl3JiRecAH2cGzl713ZMLbpLgv69Ok5ecO6TtcIWZ3ZtEga0wAM72Qk4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+REtyjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAA8C32781;
	Sat, 24 Aug 2024 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724506348;
	bh=yWDV6zMHCzJEYB1oaS9d3E9GAKtkhUP1/BrP+7WaSHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+REtyjROfseawkBmwNI1Pt4XlpJe6xEZpHDz22GwMIhDr+ibZneuo6IPBXPdoA/n
	 z72oKn4gQPwutl/6ZAFDwS4LpmveE7iMxMXYWi225bCrzRjRLjBUye0JAePK/svnAE
	 RHloFbG2/K7m/l0ONCWiCiTNjOpivLtArVYLYoYIlEoylwvOeLOUAp5n7+NS0Sc4q3
	 lK9i9/7oW5c4AN2YRryRJtymbXW1l+7aWjOswMuFbB47UJYlEeCYTFpdAqdCpjxT+r
	 LhyQSbUB/aECFJfYi/F92XcSybgXPO6uOzRTP+hZMYDKqVP37AinNePPKE0LYlq28o
	 3KDPtjIhiIxwQ==
Date: Sat, 24 Aug 2024 14:32:23 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v7 iwl-next 5/6] ice: Add timestamp ready bitmap for E830
 products
Message-ID: <20240824133223.GK2164@kernel.org>
References: <20240820102402.576985-8-karol.kolacinski@intel.com>
 <20240820102402.576985-13-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820102402.576985-13-karol.kolacinski@intel.com>

On Tue, Aug 20, 2024 at 12:21:52PM +0200, Karol Kolacinski wrote:
> E830 PHY supports timestamp ready bitmap.
> Enable the bitmap by refactoring tx init function.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> @@ -3344,20 +3327,13 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
>  	mutex_init(&ptp_port->ps_lock);
>  
>  	switch (hw->mac_type) {
> -	case ICE_MAC_E810:
> -	case ICE_MAC_E830:
> -		return ice_ptp_init_tx_e810(pf, &ptp_port->tx);
>  	case ICE_MAC_GENERIC:
>  		kthread_init_delayed_work(&ptp_port->ov_work,
>  					  ice_ptp_wait_for_offsets);
> -
>  		return ice_ptp_init_tx_e82x(pf, &ptp_port->tx,
>  					    ptp_port->port_num);
> -	case ICE_MAC_GENERIC_3K_E825:
> -		return ice_ptp_init_tx_eth56g(pf, &ptp_port->tx,
> -					      ptp_port->port_num);
>  	default:
> -		return -ENODEV;
> +		return ice_ptp_init_tx(pf, &ptp_port->tx, ptp_port->port_num);
>  	}

I think it would be better to maintain default as an error case
for unknown mac_type values. (completely untested!)

	switch (hw->mac_type) {
	case ICE_MAC_E810:
	case ICE_MAC_E830:
	case ICE_MAC_GENERIC_3K_E825:
		return ice_ptp_init_tx(pf, &ptp_port->tx, ptp_port->port_num);
	case ICE_MAC_GENERIC:
		kthread_init_delayed_work(&ptp_port->ov_work,
					  ice_ptp_wait_for_offsets);
		return ice_ptp_init_tx_e82x(pf, &ptp_port->tx,
					    ptp_port->port_num);
	default:
		return -ENODEV;
	}

And update the Return: section in the Kernel doc accordingly.

>  }

...

