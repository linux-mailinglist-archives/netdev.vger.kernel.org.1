Return-Path: <netdev+bounces-221084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 828FBB4A35D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33ACB16F600
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DA82FB083;
	Tue,  9 Sep 2025 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRI7PeqQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF41F63CD
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402469; cv=none; b=QnzlaW8aTXChH+OjfUys4o6+l7xMF5VpkeNq/OXHXW2RJXKN2GwLnQE96HB/Jz3QH2FvuS8ZDGehiIzMulHKB633whzT782ZddJwIHby/2s4JZP032QVaMaPJWQgA+vm9BS36p14yVg0Q5HEPHrKg/aVoeLucOlZdpVa9jhQ3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402469; c=relaxed/simple;
	bh=l/oHFH5O7AnE6sbgdZUujNb200efan9ns/uLVdN/5d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov+divzrc1lpUNdUVqdluOC9cFRvhJ8iBn1QY7ZOSmfx+tj2FXOuTcgABFsvYs2P0WCYzcZ1fT2H2ZS9mifRBGQBwqfQe2twlKrouUPuqE0J/6DA17QaEvvF8cpLQhkVMwbVTwbVoItVpwsbsvNJH0s/88hueo7cKiwmzbA2E18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRI7PeqQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757402467; x=1788938467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l/oHFH5O7AnE6sbgdZUujNb200efan9ns/uLVdN/5d4=;
  b=mRI7PeqQDtxOkZ9lAGYy2H9a+28B2wfs5Z0JizQxsVzbNUI8VaXqY6AT
   kF69D6YuFf7m4Uykruwo8NiewcUzRIqYcE3eOp74bA8lo1tneWQA6sB1g
   WRwdWovOqqziw+jh3UIcHm+gRKZeNAASc6KixEpX+9p/bx/NDFPEwkHJj
   Rek5+mKarLrrQNXnGRRBRCYMrYMjqiTEABafBjIXISUCBhjUBvzyFP/tn
   dNUBpxDpyJx8QDTSaFpq04BylHqlcZLcxWdbhRXuabiVx7mPYDxLd0Pg8
   7wrFzH2vXaVg/HCtPdY9mrQRA8sUQQWu9JxSQ4N0zmClk8kimwg578xyK
   Q==;
X-CSE-ConnectionGUID: RRGu4t3WRZ+8gUSRP1cr7w==
X-CSE-MsgGUID: DBcQJV5mQCmTC4ERzPVMPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="85123086"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="85123086"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 00:21:07 -0700
X-CSE-ConnectionGUID: CvOgCLcYRK6GS51k5W7i1A==
X-CSE-MsgGUID: lbdUcEOzTSOr1TV7tXsu1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="178212677"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 00:21:00 -0700
Date: Tue, 9 Sep 2025 09:19:23 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net/octep_ep: Validate the VF ID
Message-ID: <aL/U+yTe08B4Qa2i@mev-dev.igk.intel.com>
References: <20250908231158.1333362-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908231158.1333362-1-kheib@redhat.com>

On Mon, Sep 08, 2025 at 07:11:58PM -0400, Kamal Heib wrote:
> Make sure that the VF ID is valid before trying to access the VF.
> 
> Fixes: 8a241ef9b9b8 ("octeon_ep: add ndo ops for VFs in PF driver")
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  .../net/ethernet/marvell/octeon_ep/octep_main.c  | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 24499bb36c00..eaafbc0a55b1 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -1124,11 +1124,24 @@ static int octep_set_features(struct net_device *dev, netdev_features_t features
>  	return err;
>  }
>  
> +static bool octep_validate_vf(struct octep_device *oct, int vf)
nit, looks like octep_is_vf_valid() fits better here.

> +{
> +	if (vf >= CFG_GET_ACTIVE_VFS(oct->conf)) {
> +		dev_err(&oct->pdev->dev, "Invalid VF ID %d\n", vf);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int octep_get_vf_config(struct net_device *dev, int vf,
>  			       struct ifla_vf_info *ivi)
>  {
>  	struct octep_device *oct = netdev_priv(dev);
>  
> +	if (!octep_validate_vf(oct, vf))
> +		return -EINVAL;
> +
>  	ivi->vf = vf;
>  	ether_addr_copy(ivi->mac, oct->vf_info[vf].mac_addr);
>  	ivi->spoofchk = true;
> @@ -1143,6 +1156,9 @@ static int octep_set_vf_mac(struct net_device *dev, int vf, u8 *mac)
>  	struct octep_device *oct = netdev_priv(dev);
>  	int err;
>  
> +	if (!octep_validate_vf(oct, vf))
> +		return -EINVAL;
> +
>  	if (!is_valid_ether_addr(mac)) {
>  		dev_err(&oct->pdev->dev, "Invalid  MAC Address %pM\n", mac);
>  		return -EADDRNOTAVAIL;

Make sense, you can add reproduction steps and what happens when the ID
is incorrect, but it is up to you.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.51.0

