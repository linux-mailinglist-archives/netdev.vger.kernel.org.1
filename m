Return-Path: <netdev+bounces-205041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5943AAFCF6C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB913B5B1A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7262E11A9;
	Tue,  8 Jul 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9PbLbQ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE892E11C3;
	Tue,  8 Jul 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989109; cv=none; b=lv5Juoufd5tSAGXpT646DF/9c9ujnrM11/IQUS7KCQmjBswhRJov3BoNNFqAq5zQl7Hne8iLyXCwOFTJE6CRqAQNDQQWjlX9vMqkJMRvDB089HTo0dDpmjRtMiu20f/fYLkyYybU5OaweZnxOi+/qqiiN0ODXNmzs5sBPBEe8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989109; c=relaxed/simple;
	bh=oDEtOf0DaTfsiKg+dTzSTHuTGeQPH+ZbPyfhdxIehAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eW08wBY+XfVNgVtn349kE7r9sfIzH7/ZuudxD0cvllf9PWIdSR7boJG0XmwudHt9cP57g0D5pihnB4rb4cqrtFVjEm/Z25ZCqYveItltAW4H3ltr/rTyI01NJDDIBUiXMJqVoiR1ofdAru4bXgbTJTayJv9P48+Ly/KNWo/ka8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9PbLbQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D598C4CEED;
	Tue,  8 Jul 2025 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751989108;
	bh=oDEtOf0DaTfsiKg+dTzSTHuTGeQPH+ZbPyfhdxIehAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9PbLbQ9DxyvF2ZYdhO1L4fP9gUwKnXhGM1vEeabzvph5jN6AV4yyjNFpoTbw47f8
	 S+Q8aAyfjkbCC4pqyV/qXa6M7F1y3K4Bp4CO5nSq/brqJz1Zci6a2rEyTsrvDzMyNY
	 nHwAL0wmnYEM6YQF+Ij9iWqGjwWDaozG7oiav3//lv4qzSibydlDld+Ll1w8wng+m3
	 bwVM80Xtw47Kh394C0tlvIXGvzgHgG6G/pcy+Rulh9/EueQA+imWyC32h9wvtz78ay
	 U1Dh1lp4MfCN4dJ04q+S0S8YVRp1xsdKJP5ajdH4exlxyhPglxhKdE/gq20mPJuB2g
	 Wc7OXHmbYDqOA==
Date: Tue, 8 Jul 2025 16:38:24 +0100
From: Simon Horman <horms@kernel.org>
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kohei Enju <enjuk@amazon.com>
Subject: Re: [PATCH iwl-next v1] igbvf: remove unused fields from struct
 igbvf_adapter
Message-ID: <20250708153824.GM452973@horms.kernel.org>
References: <20250707180116.44657-2-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707180116.44657-2-ytohnuki@amazon.com>

On Mon, Jul 07, 2025 at 07:01:17PM +0100, Yuto Ohnuki wrote:
> Remove following unused fields from struct igbvf_adapter that are never
> referenced in the driver.
> 
> - blink_timer
> - eeprom_wol
> - fc_autoneg
> - int_mode
> - led_status
> - mng_vlan_id
> - polling_interval
> - rx_dma_failed
> - test_icr
> - test_rx_ring
> - test_tx_ring
> - tx_dma_failed
> - tx_fifo_head
> - tx_fifo_size
> - tx_head_addr
> 
> Also removed the following fields from struct igbvf_adapter since they
> are never read or used after initialization by igbvf_probe() and igbvf_sw_init().
> 
> - bd_number
> - rx_abs_int_delay
> - tx_abs_int_delay
> - rx_int_delay
> - tx_int_delay
> 
> This changes simplify the igbvf driver by removing unused fields, which
> improves maintenability.
> 
> Tested-by: Kohei Enju <enjuk@amazon.com>
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
> ---
>  drivers/net/ethernet/intel/igbvf/igbvf.h  | 25 -----------------------
>  drivers/net/ethernet/intel/igbvf/netdev.c |  7 -------
>  2 files changed, 32 deletions(-)

Less is more :)

Reviewed-by: Simon Horman <horms@kernel.org>


