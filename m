Return-Path: <netdev+bounces-112436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3544993913A
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CE41C21645
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E87216DEAC;
	Mon, 22 Jul 2024 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec6beWYo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703216DEA8
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660500; cv=none; b=M+A8Oyk7HJ5N1Kbi/YPQ5b9D4mUppOsPczxaLiNVyNf9m0ynMk3gtP7UbbZMMSwjDNAX8sMSHEhydpZPOf32fsUoJ3i6ulxfU1dHEizO8Ac0Xo4W8heCLZISK0+h20ZJg76EeCx6zTnPe3WxEH18fsDcXiloqSaB8bqR3HQDEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660500; c=relaxed/simple;
	bh=BGMMpKXqjmnrN8BBfqoHRGbjQcStSiAQC1ZKUqXjJiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJPjJ92nZ1jWKzCQ692nckJcQGmkZrkR6PUvpBo87W5yDyf3J1kOzpt7H4YvQHiYPOeCnldiGoE/VA+hmoLxlGcgxKB9BHVgyW8JRLfZBln+zjMBoCmLqygTEATcWdJyclYZtNADlAp3tbEll43zJfsp8D/N1KTT8XEYKMGGQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec6beWYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D61C116B1;
	Mon, 22 Jul 2024 15:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721660499;
	bh=BGMMpKXqjmnrN8BBfqoHRGbjQcStSiAQC1ZKUqXjJiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ec6beWYo0z08pgi/2APpB4a2j503wFtcKMaLTYKjvhXNqpSPvMi00eTg32VnLB0Vl
	 G11SQQEJ5HNYUWTe48VES/BkrIyd3M4ZLZ/hm0BMiNHJaF46MABafJyHVvAWR3Zm7i
	 aFEo9zVL7LFbIABa9pkek8wtoQPmK8FmfRBEi1z43AwvL4nTmSR/iFliNfGfQgnOlO
	 HWWpjQbn9Dfim2W2l1KJM9jrDgH1N6iWKEP1WLt/tTbebJjI3XWKgoWmJSz0pUmr7l
	 zHCG1hb0BUtf32GK/7YURBTBPNAVwQWBuJ+cFl5vp9x2UqynORevKL7Pmjixf4p6nC
	 ZJ1aODSgSKYwA==
Date: Mon, 22 Jul 2024 16:01:36 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 05/13] ice: add parser execution main loop
Message-ID: <20240722150136.GH715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-6-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-6-ahmed.zaki@intel.com>

On Wed, Jul 10, 2024 at 02:40:07PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Implement the core work of the runtime parser via:
> - ice_parser_rt_execute()
> - ice_parser_rt_reset()
> - ice_parser_rt_pkt_buf_set()
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

> diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c

...

> +static u16 ice_ptype_resolve(struct ice_parser_rt *rt)
> +{
> +	struct ice_parser *psr = rt->psr;
> +	struct ice_ptype_mk_tcam_item *item;

nit: Please consider arranging these variables in reverse xmas tree order.

     Flagged by https://github.com/ecree-solarflare/xmastree

> +
> +	item = ice_ptype_mk_tcam_match(psr->ptype_mk_tcam_table,
> +				       rt->markers, ICE_MARKER_ID_SIZE);
> +	if (item)
> +		return item->ptype;
> +
> +	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "Could not resolve PTYPE\n");
> +	return U16_MAX;
> +}

...

