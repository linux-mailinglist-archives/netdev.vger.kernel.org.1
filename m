Return-Path: <netdev+bounces-84671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60369897D7D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 03:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E21B21988
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 01:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F897492;
	Thu,  4 Apr 2024 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6xtExnG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F6FD52F
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712195268; cv=none; b=DJ1a18BW9VaiK3Mtvpdno/7mY5GmdjqIzhdXCEjQ5NJBJZI+r/jgbqOLuBY/Aor3xDORJ36X3QddXwzZSHGqy0G74bItsoiWA/YJ0QEYjNq61qDyI31gOA7TLktm9J+u4fZ3nRIjFtC1PjsJnST1Sgz2SmXRiLgkWcsW5VLDhtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712195268; c=relaxed/simple;
	bh=9N46xWif9hh0MBJJT6rUfQjHmQF7goXuFQxvhTk8gRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxmb0kiWg/IaxIBd8X/pYjwkuCAGBZtbwDlL/w5sTInb7w3zEuRo/uSCjz5RREmp3ZvWIRIAhC0c5KLYDtWuh7m9CsrujV4tE8WeZmSI4ssGe+vclmuNCMgs909sPVP0uDER6mq/lJLwAdkinOC7GwLdwss5egUJp34xPUz+y2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6xtExnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F86DC433C7;
	Thu,  4 Apr 2024 01:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712195268;
	bh=9N46xWif9hh0MBJJT6rUfQjHmQF7goXuFQxvhTk8gRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j6xtExnGsFFlKTzChZfmUzPX7QnANskds4SRvsh24CQ9+pQU2MYeQ+WXvSnjXYJEV
	 FeZiYs5jxF/56bqH51PuFW/WK4me59YtxMCDtyEfZFZ18oMmb25i8A+6ZDj6zEADLI
	 Nxaxw4TVErHr+imWRb8apLbBUSdoz2ppvjtxJ1l2Dz7qA6+OJDXvRERSKaFAgiBPM8
	 jvmakBkQ4oxwuYmeEfj1h4traCcV42FMDSX5/n6nJ/11dzv4a6iRIshjqHx356XfDO
	 aYsNb0VrAGFssx24jVmb8bVNFuCSENcUKHQmIdtytaR6jx2u48kqjASnurH0yQKobz
	 LPDuQ0qVii7EA==
Date: Wed, 3 Apr 2024 18:47:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 horms@kernel.org, anthony.l.nguyen@intel.com, Jacob Keller
 <jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 05/12] iavf: negotiate PTP
 capabilities
Message-ID: <20240403184746.178b2268@kernel.org>
In-Reply-To: <20240403131927.87021-6-mateusz.polchlopek@intel.com>
References: <20240403131927.87021-1-mateusz.polchlopek@intel.com>
	<20240403131927.87021-6-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 09:19:20 -0400 Mateusz Polchlopek wrote:
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -145,6 +145,7 @@ int iavf_send_vf_config_msg(struct iavf_adapter *adapter)
>  	       VIRTCHNL_VF_OFFLOAD_CRC |
>  	       VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM |
>  	       VIRTCHNL_VF_OFFLOAD_REQ_QUEUES |
> +	       VIRTCHNL_VF_CAP_PTP |
>  	       VIRTCHNL_VF_OFFLOAD_ADQ |

coccicheck says VIRTCHNL_VF_CAP_PTP ends up on this list twice.

