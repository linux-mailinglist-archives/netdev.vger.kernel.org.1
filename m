Return-Path: <netdev+bounces-222468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D5B54660
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A260163A77
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E519E97A;
	Fri, 12 Sep 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgxJw5iM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826822DC79E
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667762; cv=none; b=jr4vgpT50G6PaGuRZZTI//dQSvwDkq9QfdbRED+P4UQ9cnRXJljzaiV/oj4SX3Qqhs5+iMztdvVyLUnTXsJxI2ofrNimX1EEOnjsHh3h8wst5s7VErOUWaIUwQ5VWEdN3bW2sWOCLj1ZVefxtw40kMOOvh/5Oyicnkbaw+Oones=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667762; c=relaxed/simple;
	bh=kL/p2Bsx1e7gqZn5NE8Tk9hEj2FkuAQnySmNEsb4J2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob8D6mpUwf+0LFNy3me3dSg0j71X009v5ry4RjWjKz7HEmZeedFnvDpnGTMxMfylrNTwEzf8UKerQrCh7+osaPOcdW++jfDeN6MzeFwSK+uTk3G+UdYusD1K6Z3ormh+h/FzKVkr8G8RsPwjb7xoEiQstjE55Uc6lppejEcuPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgxJw5iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7CDC4CEF1;
	Fri, 12 Sep 2025 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757667762;
	bh=kL/p2Bsx1e7gqZn5NE8Tk9hEj2FkuAQnySmNEsb4J2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgxJw5iMZUE/m57Rj4X3dmhS/VmzOC7ecD4Fk+VryPGNOshk3H78yH4BV3yxecy8R
	 ldtVpbEbDudS3hdPsVGuq0vBA1DCvGQ/WTHDAyKC/cZVcJNHL4a3gE59aH+wUrhxYU
	 izwS2YhdLzOaxf/zJi9ZDiB3EnPYYk6G+xo+6/uU1zXUrC+0GSNzl9F4LcHn4ftPoT
	 Uq+ZZC6HbcigRjnzY9x43AsgbLLhzr4CIj4fAvOaw2BjeSVjszxp6CIHjcEJwGKobg
	 xY9be7BwX5ZXHopiT6RQ5GJL41Ga7GInROw5YzAXRzlgRFOCyWsRfGvrrlb37t1fH5
	 0rwJq+HZMg7Bg==
Date: Fri, 12 Sep 2025 10:02:37 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, mschmidt@redhat.com,
	Dan Nowlin <dan.nowlin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v4 2/5] ice: add virtchnl and VF context support
 for GTP RSS
Message-ID: <20250912090237.GU30363@horms.kernel.org>
References: <20250829101809.1022945-1-aleksandr.loktionov@intel.com>
 <20250829101809.1022945-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829101809.1022945-3-aleksandr.loktionov@intel.com>

On Fri, Aug 29, 2025 at 10:18:05AM +0000, Aleksandr Loktionov wrote:
> Introduce infrastructure to support GTP-specific RSS configuration
> in the ICE driver, enabling flexible and programmable flow hashing
> on virtual functions (VFs).
> 
>  - Define new virtchnl protocol header and field types for GTPC, GTPU,
>    L2TPv2, ECPRI, PPP, GRE, and IP fragment headers.
>  - Extend virtchnl.h to support additional RSS fields including checksums,
>    TEID, QFI, and IPv6 prefix matching.
>  - Add VF-side hash context structures for IPv4/IPv6 and GTPU flows.
>  - Implement context tracking and rule ordering logic for TCAM-based
>    RSS configuration.
>  - Introduce symmetric hashing support for raw and tunnel flows.
>  - Update ice_vf_lib.h and virt/rss.c to handle advanced RSS
>    configuration via virtchnl messages.
> 
> VFs can express RSS configuration for GTP flows
> using ethtool and virtchnl, laying the foundation for tunnel-aware
> RSS offloads in virtualized environments.
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

Aside from the minor comment below, this looks good to me.
So with that addressed, feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

> diff --git a/drivers/net/ethernet/intel/ice/virt/rss.c b/drivers/net/ethernet/intel/ice/virt/rss.c

...

> +/**
> + * ice_parse_raw_rss_pattern - Parse raw pattern spec and mask for RSS
> + * @vf: pointer to the VF info
> + * @proto: pointer to the virtchnl protocol header
> + * @raw_cfg: pointer to the RSS raw pattern configuration
> + *
> + * Parser function to get spec and mask from virtchnl message, and parse
> + * them to get the corresponding profile and offset. The profile is used
> + * to add RSS configuration.
> + *
> + * Return: 0 on success; negative error code on failure.
> + */
> +static int
> +ice_parse_raw_rss_pattern(struct ice_vf *vf, struct virtchnl_proto_hdrs *proto,
> +			  struct ice_rss_raw_cfg *raw_cfg)
> +{
> +	struct ice_parser_result pkt_parsed;
> +	struct ice_hw *hw = &vf->pf->hw;
> +	struct ice_parser_profile prof;
> +	u16 pkt_len;
> +	struct ice_parser *psr;
> +	u8 *pkt_buf, *msk_buf;
> +	int ret = 0;
> +
> +	pkt_len = proto->raw.pkt_len;
> +	if (!pkt_len)
> +		return -EINVAL;
> +	if (pkt_len > VIRTCHNL_MAX_SIZE_RAW_PACKET)
> +		pkt_len = VIRTCHNL_MAX_SIZE_RAW_PACKET;
> +
> +	pkt_buf = kzalloc(pkt_len, GFP_KERNEL);
> +	msk_buf = kzalloc(pkt_len, GFP_KERNEL);
> +	if (!pkt_buf || !msk_buf) {
> +		ret = -ENOMEM;
> +		goto free_alloc;
> +	}
> +
> +	memcpy(pkt_buf, proto->raw.spec, pkt_len);
> +	memcpy(msk_buf, proto->raw.mask, pkt_len);
> +
> +	psr = ice_parser_create(hw);
> +	if (IS_ERR(psr)) {
> +		ret = PTR_ERR(psr);
> +		goto parser_destroy;

I think this one should be goto free_alloc.
Else there will be a NULL pointer dereference in ice_parser_destroy().

> +	}
> +
> +	ret = ice_parser_run(psr, pkt_buf, pkt_len, &pkt_parsed);
> +	if (ret)
> +		goto parser_destroy;
> +
> +	ret = ice_parser_profile_init(&pkt_parsed, pkt_buf, msk_buf,
> +				      pkt_len, ICE_BLK_RSS, &prof);
> +	if (ret)
> +		goto parser_destroy;
> +
> +	memcpy(&raw_cfg->prof, &prof, sizeof(prof));
> +
> +parser_destroy:
> +	ice_parser_destroy(psr);
> +free_alloc:
> +	kfree(pkt_buf);
> +	kfree(msk_buf);
> +	return ret;
> +}

