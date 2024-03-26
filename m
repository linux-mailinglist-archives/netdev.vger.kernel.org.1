Return-Path: <netdev+bounces-82115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E214488C589
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500A4B24571
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721DB13C3DA;
	Tue, 26 Mar 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quHLfCe1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE2ED9
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464392; cv=none; b=KhTQBLvuA/SO2uluqLG3Y4Y/+uPDZKa8Er8gDtYqEd72umoTZrxHcXrA7Ku5pkep2uNnMIfNW4wK1R/HnjTXsY90azhljdguXAxKWAqZXJX3it4TKyZ+ve2+u0tzUYFfUFzAo9nMqAPlFNk/Bj0u40bfYA80WDcedvEMInDX3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464392; c=relaxed/simple;
	bh=4glZQPXtEBpStBMdhb34a1rISFybI4O1dCwDgC/RKr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoLftoRDijnbyMVn4YZtQrdVUnvEsUczyPlztAUocXLxE7ODh9+U8C67PQOTxVkhqUJB0hhLiHJ+LwYXdqsIXST+t/Ot/Uh/m+1dO1I3DJ0s8qPSrZWmyeXZ7wbYTwfFZRh9YahD1l9LDRppQKjMZ5aei8A6edaoTu1uvtGwk30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quHLfCe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AA5C43390;
	Tue, 26 Mar 2024 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464391;
	bh=4glZQPXtEBpStBMdhb34a1rISFybI4O1dCwDgC/RKr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quHLfCe11ePM5L6LqrFKEEPU/Dkdl7ahJZrrLVt6whX0QbKpwMTrSpe+gDlW6yG/8
	 PFlMcp/4NlxKPdij1l+5DBPn/P3+k7Oy46ZHQ8SKBcWGocj+uenteLE8HAfrPaDM9b
	 hiKsBn6j+5qud/8vI7/IIxn9R7hBDTrTweDiFKFEw+PGhqbTWHAGzxzCgsKq2kPk7q
	 b0mf6CmR79vbmH47T4XvjMdl7ClG4O4AB748Nua1L6V4YQjSovvJyDfWGHKxE6NjZu
	 Ec8suQ1PoScKJdo9GSY+hdVp0hwpreoPWBw1LzX4Q84qXX7mGBY9SC9eWhvHYUiLZK
	 RWk3cIJMjErrA==
Date: Tue, 26 Mar 2024 14:46:27 +0000
From: Simon Horman <horms@kernel.org>
To: John Fraker <jfraker@google.com>
Cc: netdev@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Junfeng Guo <junfeng.guo@intel.com>
Subject: Re: [PATCH net-next] gve: Add counter adminq_get_ptype_map_cnt to
 stats report
Message-ID: <20240326144627.GB403975@kernel.org>
References: <20240325223308.618671-1-jfraker@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325223308.618671-1-jfraker@google.com>

+ Jeroen de Borst, Praveen Kaligineedi, Shailend Chand, David Miller,
  Eric Dumazet, Jakub Kicinski, Paolo Abeni, Willem de Bruijn,
  Harshitha Ramamurthy, Junfeng Guo

On Mon, Mar 25, 2024 at 03:33:08PM -0700, John Fraker wrote:
> This counter counts the number of times get_ptype_map is executed on the
> admin queue, and was previously missing from the stats report.
> 
> Signed-off-by: John Fraker <jfraker@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks John,

this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

In future, please consider using ./scripts/get_maintainer.pl file.patch
to seed the CC list when posting patches to netdev.

> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> index 9aebfb843..dbe05402d 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -73,7 +73,7 @@ static const char gve_gstrings_adminq_stats[][ETH_GSTRING_LEN] = {
>  	"adminq_create_tx_queue_cnt", "adminq_create_rx_queue_cnt",
>  	"adminq_destroy_tx_queue_cnt", "adminq_destroy_rx_queue_cnt",
>  	"adminq_dcfg_device_resources_cnt", "adminq_set_driver_parameter_cnt",
> -	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt"
> +	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt", "adminq_get_ptype_map_cnt"
>  };
>  
>  static const char gve_gstrings_priv_flags[][ETH_GSTRING_LEN] = {
> @@ -428,6 +428,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  	data[i++] = priv->adminq_set_driver_parameter_cnt;
>  	data[i++] = priv->adminq_report_stats_cnt;
>  	data[i++] = priv->adminq_report_link_speed_cnt;
> +	data[i++] = priv->adminq_get_ptype_map_cnt;
>  }
>  
>  static void gve_get_channels(struct net_device *netdev,
> -- 
> 2.44.0.291.gc1ea87d7ee-goog
> 

