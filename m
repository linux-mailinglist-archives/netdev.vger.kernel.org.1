Return-Path: <netdev+bounces-124158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D73F968554
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E70E281B96
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D5413AD18;
	Mon,  2 Sep 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pbqh7Mcq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697E1E51D;
	Mon,  2 Sep 2024 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274467; cv=none; b=Sp4vlcSbbQBCfGhHBRUbpO6U+TgqnOJjhFHwPYSlwj9ie8WmRI/NIdSTkcXmYK0Pj3BZWBhuOENO78THT2fKazeRpIYM9Pcf3N9quOh7aBDVnw2iKvNZoq1oEVaQlLohWLqSfMQun0qLwMuSx8Ukr3O5kcTxvfsIgbhpzOLQTqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274467; c=relaxed/simple;
	bh=1ox6/8Pljv8b73NeRXJoFS9ibX5dEGrklAxOVjdb0xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVPtw0Gv85JJ8A0TTOo9vdvA8BWtzyv4vVDXTHbcokCw8eHkDWv9sXtXf+cAiZuyopuZGLMiLb4hxo2kZdKndz3fGcEUBecS7z5c0zao8ciy2bDjHOoQ+hQ7tJb0gtmY2N+nO0Ma92M64IfNBIgmkEbaKrbKVzroP+smBOkX3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pbqh7Mcq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725274466; x=1756810466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ox6/8Pljv8b73NeRXJoFS9ibX5dEGrklAxOVjdb0xU=;
  b=Pbqh7McqCW85XCGdWNfDGwhPN0piy9sr43klN6I80Eftis899xmSqptC
   TNsBm6DzkEQyTnmanUSV9LV2GxsrtRoUD2AEwkN8oOxcd67K5D+DNJ4bi
   YSQuXSQ1dZwcBKTA0pxAJWmJnY6DTxd0RMLo4NnhxmEVL6H1fHzate/F3
   8UKRMeiT+F2TPITEAh1SkKzSsVmkZCNFApSYlsxoAczN2z4kXGYva1vq8
   4ruqLrHWxweCSa6zkAN6LJHhFtkz5LAcjeisDqV6zG+ywSgXUILHHPHwZ
   2u1+ljSI1fiOA5C0UrPZ79ic3anLD41qNYPak2TapWOkkltYTR5UUItYH
   w==;
X-CSE-ConnectionGUID: AGqcI8i0Tx6Je6kJNc/5wg==
X-CSE-MsgGUID: bn+0nEzaQaSqjxiGwla60A==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23804299"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23804299"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:54:25 -0700
X-CSE-ConnectionGUID: 8Do9u97wSAe6K19+Wlzz9A==
X-CSE-MsgGUID: Ylj5ZuI6RGeUkzBghnZv2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64931669"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 03:54:22 -0700
Date: Mon, 2 Sep 2024 12:52:21 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@intel.com>,
	Timothy Miskell <timothy.miskell@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: fix VSI lists confusion when adding VLANs
Message-ID: <ZtWY5ZJkAc3OGth0@mev-dev.igk.intel.com>
References: <20240902100652.269398-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902100652.269398-1-mschmidt@redhat.com>

On Mon, Sep 02, 2024 at 12:06:52PM +0200, Michal Schmidt wrote:
> The description of function ice_find_vsi_list_entry says:
>   Search VSI list map with VSI count 1
> 
> However, since the blamed commit (see Fixes below), the function no
> longer checks vsi_count. This causes a problem in ice_add_vlan_internal,
> where the decision to share VSI lists between filter rules relies on the
> vsi_count of the found existing VSI list being 1.
> 
> The reproducing steps:
> 1. Have a PF and two VFs.
>    There will be a filter rule for VLAN 0, refering to a VSI list
>    containing VSIs: 0 (PF), 2 (VF#0), 3 (VF#1).
> 2. Add VLAN 1234 to VF#0.
>    ice will make the wrong decision to share the VSI list with the new
>    rule. The wrong behavior may not be immediately apparent, but it can
>    be observed with debug prints.
> 3. Add VLAN 1234 to VF#1.
>    ice will unshare the VSI list for the VLAN 1234 rule. Due to the
>    earlier bad decision, the newly created VSI list will contain
>    VSIs 0 (PF) and 3 (VF#1), instead of expected 2 (VF#0) and 3 (VF#1).
> 4. Try pinging a network peer over the VLAN interface on VF#0.
>    This fails.
> 
> Reproducer script at:
> https://gitlab.com/mschmidt2/repro/-/blob/master/RHEL-46814/test-vlan-vsi-list-confusion.sh
> Commented debug trace:
> https://gitlab.com/mschmidt2/repro/-/blob/master/RHEL-46814/ice-vlan-vsi-lists-debug.txt
> Patch adding the debug prints:
> https://gitlab.com/mschmidt2/linux/-/commit/f8a8814623944a45091a77c6094c40bfe726bfdb
> 
> One thing I'm not certain about is the implications for the LAG feature,
> which is another caller of ice_find_vsi_list_entry. I don't have a
> LAG-capable card at hand to test.
> 
> Fixes: 25746e4f06a5 ("ice: changes to the interface with the HW and FW for SRIOV_VF+LAG")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> index fe8847184cb1..4e6e7af962bd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -3264,7 +3264,7 @@ ice_find_vsi_list_entry(struct ice_hw *hw, u8 recp_id, u16 vsi_handle,
>  
>  	list_head = &sw->recp_list[recp_id].filt_rules;
>  	list_for_each_entry(list_itr, list_head, list_entry) {
> -		if (list_itr->vsi_list_info) {
> +		if (list_itr->vsi_count == 1 && list_itr->vsi_list_info) {
>  			map_info = list_itr->vsi_list_info;
>  			if (test_bit(vsi_handle, map_info->vsi_map)) {
>  				*vsi_list_id = map_info->vsi_list_id;
> -- 
> 2.45.2
> 

Thanks, it for sure looks correct. Reusing VSI list when the rule is new
seems like an error. I don't know why it was needed for LAG, probably
Dave will now.

You can add in the description that bug is caused because of reusing VSI
list created for VLAN 0. All created VFs VSIs are added to VLAN 0
filter. When none zero VLAN is created on VF which is already in VLAN 0
(normal case) the VSI list from VLAN 0 is reused. It leads to a problem
because all VFs (VSIs to be sepcific) that are subscribed to VLAN 0 will
now receive a new VLAN tag traffic. This is one bug, another is the bug
that you described. Removing filters from one VF will remove VLAN filter
from the previous VF. It happens in case of reset of VF.

For example:
- creation of 3 VFs
- we have VSI list (used for VLAN 0) [0 (pf), 2 (vf1), 3 (vf2), 4 (vf3)]
- we are adding VLAN 100 on VF1, we are reusing the previous list
  because 2 is there
- VLAN traffic works fine, but VLAN 100 tagged traffic can be received
  on all VSIs from the list (for example broadcast or unicast)
- trust is turing on on VF2, VF2 is resetting, all filters from VF2 are
  removed; the VLAN 100 filter is also remove because 3 is on the list
- VLAN traffic to VF1 isn't working anymore, there is a need to recreate
  VLAN interface to readd VLAN filter

In summary, I don't see the use case when reusing VSI list which more
than one VSI on it for new rule is valid scenario.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks,
Michal 

