Return-Path: <netdev+bounces-177193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E906A6E398
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4067A0FCA
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFA118C035;
	Mon, 24 Mar 2025 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAnxsScO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8A7E110
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844732; cv=none; b=df7u4Ro2DtjMgT0Qy1gB9pAfntEcrFPL3hs/wJmAqWaF3EbgmvOMObPfvXqGy+vnGeAURtlR6o0biOXi4i0CA+/n27hUPLmCnx8JuPejQySlXxO8OnqDt/Vi7BfmZaTeD7YndxJzEAWqnhL7lzDLbi2yGsniIJf59fIN2ifjznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844732; c=relaxed/simple;
	bh=aXIcNFFxtxnvG4MlW8psJSvfWndtfX4MiT457xtg+oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7PYlRPm66RESyq/fTjfELFeAm3ijRn4tdrSUGi/iiulDn3S3SNsY8BN0WHi3dM5pIrIxQFS7usnQ+iL6cOlyhcPi2QK4inks3/5MvSBeRJJxvMpqI/JMtJwyW1SUFKKOt5QwvxlWgVZtS1GrH2ge3bejsqc02pw71rLNd7AsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAnxsScO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13F3C4CEDD;
	Mon, 24 Mar 2025 19:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844731;
	bh=aXIcNFFxtxnvG4MlW8psJSvfWndtfX4MiT457xtg+oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAnxsScOWR1fG8jNNS1A0tUbVx/L2/GAum/qzTSecz5qNuoGf2S2JQa0EV2JUvvEh
	 Bc+k6gE/ldwC8VHVH1N/hTk+L/ImVnH3Y2Bv29+bGgExI0Q7ETfjTw4t9VJsNknngP
	 QzphokqGA50luSb+tkrWr/ocwPcexJx0UwvVV7JuNaPPrikTcjtmYiMxnp1s/AOgYg
	 SjyzqK+81+laa07+3niT8W0VvEkLex1mub8taDdjsqvKlv8fpbqxrTrVhYvfcRMu3f
	 us2k9YlIprWua3zgCWnDjpALlIYz1ke78nWGKo6dRkyndAEWyqkDSLdsDwW3Lsfdlm
	 hGDXjUxEaea1Q==
Date: Mon, 24 Mar 2025 19:32:08 +0000
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [RESEND,PATCH net-next v9 6/6] net: txgbe: add sriov function
 support
Message-ID: <20250324193208.GN892515@horms.kernel.org>
References: <20250324020033.36225-1-mengyuanlou@net-swift.com>
 <212BF3F0A2A3F362+20250324020033.36225-7-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <212BF3F0A2A3F362+20250324020033.36225-7-mengyuanlou@net-swift.com>

On Mon, Mar 24, 2025 at 10:00:33AM +0800, Mengyuan Lou wrote:
> Add sriov_configure for driver ops.
> Add mailbox handler wx_msg_task for txgbe.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c

...

> @@ -165,6 +173,16 @@ static void txgbe_disable_device(struct wx *wx)
>  		wx_err(wx, "%s: invalid bus lan id %d\n",
>  		       __func__, wx->bus.func);
>  
> +	if (wx->num_vfs) {
> +		/* Clear EITR Select mapping */
> +		wr32(wx, WX_PX_ITRSEL, 0);
> +		/* Mark all the VFs as inactive */
> +		for (i = 0 ; i < wx->num_vfs; i++)

nit: If you need to respin for some other reason, then " ; " -> "; "

> +			wx->vfinfo[i].clear_to_send = 0;
> +		/* update setting rx tx for all active vfs */
> +		wx_set_all_vfs(wx);
> +	}
> +
>  	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
>  	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
>  		/* disable mac transmiter */

...

