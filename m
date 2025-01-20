Return-Path: <netdev+bounces-159819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5AAA1704F
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5353A6083
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272EB1E9B18;
	Mon, 20 Jan 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPoq/TnE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD4BE65
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391080; cv=none; b=AliiiVYXcB880k//W4lUKbPxz1qovpTJezDA9lTw47S1C4+S3YoDBnUb+q3M01/kvoiZRehcP1HBAPNLj6QNFMbHqAF+HNcdSNYWmxEHbJz9aUBjXWGRwaX7cCNBVLYAzCcvwcW03BQpnz/lIEzo04KURGzvRsff52rsvJZVC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391080; c=relaxed/simple;
	bh=bCEOZ7kGTrOjEenANgqdG9z+KsYk2jAcXbInvW1NJrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGd4Z2lunEqlNayri5KKulcNGetDUB9YktVcDk0lOyfoSie96626etS8/yB/lIzmNN28RP24wELeEpqiBxZUy8R4w49Ab9pcEQVW6gHgf6U60oedzeJ2Ct9l/CE5Z5YCNdCz3gUyoGt26cxVQXWJSHPKxfwlNY4F+9rsvcnMSpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPoq/TnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D84DC4CEDD;
	Mon, 20 Jan 2025 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737391079;
	bh=bCEOZ7kGTrOjEenANgqdG9z+KsYk2jAcXbInvW1NJrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPoq/TnE07WFcQ4JsRpo4fYAqy3uN1/+U0Lrk32dx2vRpUVDg9xrFLrZO0nqElJrY
	 l7JjZIHRwpsbmrrWFNLAbYujRaQJeCb4krc902JwIrb7yTJ3ypsnAUfwqfH27TTzDw
	 608z72pMengkoHhRnKJJnfJ4zWNF24aLMhWdem4yXeWUjusp8UUkF0JualY99Kf3Fe
	 ywWCZCl5PvNAWka6yS/kWlFy3KibLfr9Ts5kxJlpfHgCTB77i9cEzzGveUaouYPWJm
	 aAnJlpsCTiK2WRqvCth8Lo5eSF1M57SKVKFNzV0kX2rTtCoBhjKS36VfQn8sOZhUZZ
	 JJfbDqILvF9zA==
Date: Mon, 20 Jan 2025 16:37:55 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
	jacob.e.keller@intel.com, xudu@redhat.com, mschmidt@redhat.com,
	jmaxwell@redhat.com, poros@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v3 iwl-net 3/3] ice: stop storing XDP verdict within
 ice_rx_buf
Message-ID: <20250120163755.GA6206@kernel.org>
References: <20250120155016.556735-1-maciej.fijalkowski@intel.com>
 <20250120155016.556735-4-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120155016.556735-4-maciej.fijalkowski@intel.com>

On Mon, Jan 20, 2025 at 04:50:16PM +0100, Maciej Fijalkowski wrote:
> Idea behind having ice_rx_buf::act was to simplify and speed up the Rx
> data path by walking through buffers that were representing cleaned HW
> Rx descriptors. Since it caused us a major headache recently and we
> rolled back to old approach that 'puts' Rx buffers right after running
> XDP prog/creating skb, this is useless now and should be removed.
> 
> Get rid of ice_rx_buf::act and related logic. We still need to take care
> of a corner case where XDP program releases a particular fragment.
> 
> Make ice_run_xdp() to return its result and use it within
> ice_put_rx_mbuf().
> 
> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 60 +++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 -
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 43 -------------
>  3 files changed, 35 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 9aa53ad2d8f2..77d75664c14d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -532,10 +532,10 @@ int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
>   *
>   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
>   */
> -static void
> +static u32
>  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> -	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
> +	    union ice_32b_rx_flex_desc *eop_desc)
>  {
>  	unsigned int ret = ICE_XDP_PASS;
>  	u32 act;

nit: The Kernel doc for ice_run_xdp should also be updated to no
     longer document the rx_buf parameter.

...

