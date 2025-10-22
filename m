Return-Path: <netdev+bounces-231690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45E8BFC9BD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E885819A77CB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775EC35BDDB;
	Wed, 22 Oct 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p64D9qNW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5935BDC8
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144018; cv=none; b=IYmSkGgZllY7sC5SPUQFizJkvzQMc6taoc/npoRKmKQyIAIZuGfaTArYQLoHI5eZiUqw7LgiFuJbqRRtAN9kpsHzj4Xpz+xZQS7nxBOhTUsS5zMs+hl22keo7JdDt5iOo+HXiyC0AoHHw+x3R8BeTt/ADmK8IZfWrTXcNK6lxLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144018; c=relaxed/simple;
	bh=nkhkR23vqQtIHVAcKE96aXuVlmhhYzhUrsNAND0yti8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZN77DaV8Dj50O7/GqxuXzQPP3kBk9+IyHOeVfQIpdkxrTGUlu5LYb36FcWO3U/5mDve6UeXOaSrvdwtR55XoCaMNC5GEnh6k+jlr9yU/dLPd0ifJNprT4v5pI8nXnWakekzEqV+sLJzIV1u7+X2li3k+KvB+ql8RoD3Yc/h12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p64D9qNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACC4C4CEE7;
	Wed, 22 Oct 2025 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761144017;
	bh=nkhkR23vqQtIHVAcKE96aXuVlmhhYzhUrsNAND0yti8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p64D9qNWqb7aK8J0gfOJV9v/eO5rduNWgM+Lp/Pl+zTqtQwDZHbCWaTsjMVsOR2rO
	 Te5JgQfMKBzQN4YUDbaHS3fmgMaR1Z0Zku4r3AzbD1ABdFgf87Z1DYacmS5rvvpxZT
	 qKWlX5Db/ceFmmTpYsoLOKhQaipyuPHao6lPtWb9MZhDLgZDWqagKFFJTXTURByyZs
	 Zjusj67aSOJvmEA35pdimChD/uZt5PJx22KT/XYMInOIrsK2c+gD2NmJdgOoopITx7
	 GSnISG2100shntnbZcfxs3ZL8eutkw7KkZP1gW/3FTk0lzj2/UqsO/SdkCCdl4qftq
	 PokvgyP7DvoLw==
Date: Wed, 22 Oct 2025 15:40:13 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next 2/2] idpf: fix typos and correct doc comments in
 idpf driver
Message-ID: <aPjszTp0QCYowpKy@horms.kernel.org>
References: <20251021184108.2390121-1-alok.a.tiwari@oracle.com>
 <20251021184108.2390121-2-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021184108.2390121-2-alok.a.tiwari@oracle.com>

On Tue, Oct 21, 2025 at 11:40:55AM -0700, Alok Tiwari wrote:

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> index 61e613066140..ffc24a825129 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> @@ -1029,7 +1029,7 @@ static void idpf_xdp_run_pass(struct libeth_xdp_buff *xdp,
>   * @rx_q: rx queue to clean
>   * @budget: Total limit on number of packets to process
>   *
> - * Returns true if there's any budget left (e.g. the clean is finished)
> + * Returns number of packets cleaned from this queue

Hi Alok,

Perhaps while this line is being updated it could
also be changed to use "Return:" or "Returns:".

Flagged by ./scripts/kernel-doc -none -Wall

>   */
>  static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
>  {
> -- 
> 2.50.1
> 

