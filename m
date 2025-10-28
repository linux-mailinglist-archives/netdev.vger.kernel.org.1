Return-Path: <netdev+bounces-233496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E101FC146F6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504A7565763
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D104B30AD0A;
	Tue, 28 Oct 2025 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHF7eotV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D02D8365
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651956; cv=none; b=HV0lVAJe44ao4FV6s0XUJ0Bex9e+Y+xD/jb4qiCGjvzx2pkDNVLxwBIMcJT1apze/t4XHUSGpftVpCKc0JhxXLYZ9SOt2z1ZDseINapu5bNR59LGgXPPdsvpS8rAaM2eJFOg1ia22PYfnDFWIqPjmv57xjetQnh+HD8eNvCo3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651956; c=relaxed/simple;
	bh=f3X3nfeTiWH/Xuq9DwxayFrAf/Iofm6E+bfZi4+Yh84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqx5upU2AcimYSZBFDOHmScI+0SMxCaxExm3sNcb233EXuE5LlgPDxXt2dRi9LZxtr1qsXO0XJ2AqBLpR7y6phtPYm4N9NzQSCX5ac/qERP3QJ1RfM9PowhVV0vu2Mg9NZJcpaqNX/UGngGgLUQ9gtjq8OAj+iOnK0A5EMA40u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHF7eotV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0063C4CEE7;
	Tue, 28 Oct 2025 11:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761651956;
	bh=f3X3nfeTiWH/Xuq9DwxayFrAf/Iofm6E+bfZi4+Yh84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHF7eotVV9kG1byr4kGyR1WcoAmd6AAPWejWcaWcg+NM5sjKvp5nMk9Hz6mtAPBtY
	 yJW7H9lMoY6XkSRzNs8XQ4s4RWwBE2d6XZtOdNEq/xhML4LbjIKdUwgx9vCYaB+lW9
	 i+1R5+O8LUH5YBcR7ojjA9GAXL2SwxqPF6AUFmCEQxaHF7+r3UfvcE0z7ilJputdko
	 r6wOBvGJK9r+RU1l36+pbEznp3KZxhHUdQEBHhjG+psvvO4x6q8Vx2E52C1+ozLKma
	 5Lm5PeeN/toHF95kmigaW4w4irAWn5O1qyjl2Dq8xqIyM7lq/Gy7a1ZKlACwe6y0Zt
	 JiiVTkuW+cFqQ==
Date: Tue, 28 Oct 2025 11:45:52 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Dan Nowlin <dan.nowlin@intel.com>,
	Qi Zhang <qi.z.zhang@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v7 2/6] ice: add virtchnl definitions and static
 data for GTP RSS
Message-ID: <aQCs8CAj5Xz0blT_@horms.kernel.org>
References: <20251027093736.3582567-1-aleksandr.loktionov@intel.com>
 <20251027093736.3582567-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027093736.3582567-3-aleksandr.loktionov@intel.com>

On Mon, Oct 27, 2025 at 10:37:32AM +0100, Aleksandr Loktionov wrote:
> Add virtchnl protocol header and field definitions for advanced RSS
> configuration including GTPC, GTPU, L2TPv2, ECPRI, PPP, GRE, and IP
> fragment headers.
> 
> - Define new virtchnl protocol header types
> - Add RSS field selectors for tunnel protocols
> - Extend static mapping arrays for protocol field matching
> - Add L2TPv2 session ID and length+session ID field support
> 
> This provides the foundational definitions needed for VF RSS
> configuration of tunnel protocols.
> 
> Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Co-developed-by: Jie Wang <jie1x.wang@intel.com>
> Signed-off-by: Jie Wang <jie1x.wang@intel.com>
> Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Co-developed-by: Ting Xu <ting.xu@intel.com>
> Signed-off-by: Ting Xu <ting.xu@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/virt/rss.c | 91 +++++++++++++++++++++++
>  include/linux/avf/virtchnl.h              | 48 ++++++++++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/virt/rss.c b/drivers/net/ethernet/intel/ice/virt/rss.c
> index cbdbb32..71d7db6 100644
> --- a/drivers/net/ethernet/intel/ice/virt/rss.c
> +++ b/drivers/net/ethernet/intel/ice/virt/rss.c
> @@ -36,6 +36,13 @@ static const struct ice_vc_hdr_match_type ice_vc_hdr_list[] = {
>  	{VIRTCHNL_PROTO_HDR_ESP,	ICE_FLOW_SEG_HDR_ESP},
>  	{VIRTCHNL_PROTO_HDR_AH,		ICE_FLOW_SEG_HDR_AH},
>  	{VIRTCHNL_PROTO_HDR_PFCP,	ICE_FLOW_SEG_HDR_PFCP_SESSION},
> +	{VIRTCHNL_PROTO_HDR_GTPC,	ICE_FLOW_SEG_HDR_GTPC},
> +	{VIRTCHNL_PROTO_HDR_L2TPV2,	ICE_FLOW_SEG_HDR_L2TPV2},
> +	{VIRTCHNL_PROTO_HDR_PPP,	ICE_FLOW_SEG_HDR_PPP},

This patch does not compile because, amongst other things,
ICE_FLOW_SEG_HDR_PPP is not declared (here).

> +	{VIRTCHNL_PROTO_HDR_ECPRI,	ICE_FLOW_SEG_HDR_ECPRI_TP0},
> +	{VIRTCHNL_PROTO_HDR_IPV4_FRAG,	ICE_FLOW_SEG_HDR_IPV_FRAG},
> +	{VIRTCHNL_PROTO_HDR_IPV6_EH_FRAG,	ICE_FLOW_SEG_HDR_IPV_FRAG},
> +	{VIRTCHNL_PROTO_HDR_GRE,        ICE_FLOW_SEG_HDR_GRE},
>  };
>

...

