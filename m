Return-Path: <netdev+bounces-101810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A68990024F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5AD2889FF
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B5518F2C6;
	Fri,  7 Jun 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o94Qypjp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80D17571
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760263; cv=none; b=TczFoBWanmWwavCJXDXoqrNYtn/Ov0KQWuQud+kBvzN/jCRu2b4p39gNH4nrqw422yyzUV+t5zynQkyBnU+BtovvVLXGN2IDPEKhVi9sK3iBedYJgnYnNl7tQQakEtZP3ft00H10X4rrdAsVbLZwEBV79G8CCTa2TK7t2bcVk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760263; c=relaxed/simple;
	bh=kiptBnS9JUMvhBxMkWjliFSytL9F2qoeGgcaS142Giw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7ZurBSdZFBrqTEx2kuPr99BaANV6YoMOgEttQiXoyVKgwRuk8QzpRNpIBXPqosdFW4Xu6S6TxbNaOYF2yOL0rkmI2+U0DhRFAB2SiSL3bK5v121/Z6t9mNDIpAV2HM3I8H88cALEpkVL2HlGu/J1MHXaU9sw6ZO3vArDuUz3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o94Qypjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42264C2BBFC;
	Fri,  7 Jun 2024 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717760262;
	bh=kiptBnS9JUMvhBxMkWjliFSytL9F2qoeGgcaS142Giw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o94QypjpysWVa/IAq24fPx2jXexO8oSfEC21XYxwUEC3KWB8e6chZ5Wq5jYMHMRLV
	 BRecJDAzovKXyLxI6rBdWVATruts6DR4LGaEVjY9V2cekxI7mDA8Z8IR2RmauP/Gp8
	 AgjnYXFVRGnkXi7JuWcEPT8G1PB5pL3N613gUZaoIWjMkcoHeCikMRu4ahNfhfzUUs
	 LobQdLI4qgUpkHBkcLL6N8S2Q5Tilrq2Og03wiPno78UebhE+Efa3LVlcYZaqsfL81
	 SMSrlvstILwXZVi0QxPK7b2fBWKyw/EamMEKZ6sGcyAhotlhHY5RN0pA0e6J6oQNog
	 JgEsDvKvNYahQ==
Date: Fri, 7 Jun 2024 12:37:38 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: Fix VSI list rule with ICE_SW_LKUP_LAST type
Message-ID: <20240607113738.GB27689@kernel.org>
References: <20240605141744.601582-2-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605141744.601582-2-marcin.szycik@linux.intel.com>

On Wed, Jun 05, 2024 at 04:17:45PM +0200, Marcin Szycik wrote:
> Adding/updating VSI list rule, as well as allocating/freeing VSI list
> resource are called several times with type ICE_SW_LKUP_LAST, which fails
> because ice_update_vsi_list_rule() and ice_aq_alloc_free_vsi_list()
> consider it invalid. Allow calling these functions with ICE_SW_LKUP_LAST.
> 
> This fixes at least one issue in switchdev mode, where the same rule with
> different action cannot be added, e.g.:
> 
>   tc filter add dev $PF1 ingress protocol arp prio 0 flower skip_sw \
>     dst_mac ff:ff:ff:ff:ff:ff action mirred egress redirect dev $VF1_PR
>   tc filter add dev $PF1 ingress protocol arp prio 0 flower skip_sw \
>     dst_mac ff:ff:ff:ff:ff:ff action mirred egress redirect dev $VF2_PR
> 
> Fixes: 0f94570d0cae ("ice: allow adding advanced rules")
> Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


