Return-Path: <netdev+bounces-160412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71DA19950
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCF6188A451
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7FA215769;
	Wed, 22 Jan 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mK8ekXUB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976518FDAB
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737574995; cv=none; b=S9ueFV88taaQYG682Z4VKCGAtp1giASgRO3Gx3zLEn1t8zaBP5IklsAFrr8cjX/SWq05v3JyT1N/lWu8mtvOuWnrUI3v/1gETh/k/ygjV7WGmSzQ4DPLhZvXIxh4mpVor6W7xTlaX4zAai+c67cClcbVPaAn573i3B87VPDwB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737574995; c=relaxed/simple;
	bh=qBF5AECtnCJtJmpXFHBOPzaFhxJuA2z1Z7BD0sAPIdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqMh8ix+k7hq4l21Ze7Druksk5OCS8R85gdCtPnkwihlfUWbFDDjGU0XLwO7TPO9K0zXw+/i70C2cSr8xfRtK81TOREGYbrCifkVbn9qlt0sJ1GORRi/1NSJut9rsz2xNxjkiPTM7/n9zPRSWLL19QcUIjU0Hl1PYCSmLTmplBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mK8ekXUB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737574994; x=1769110994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qBF5AECtnCJtJmpXFHBOPzaFhxJuA2z1Z7BD0sAPIdo=;
  b=mK8ekXUBYGWt9fAmNnEiHDeViXBlRH0ofY0r63krRFVquFWsVcJv4Ca/
   Vsx/5/HEcxfVqHwVR04ifNRKPzQ119LvAqkcgLswcEajDjm10eaubFyB2
   Gk8fVDM/rj2ZUD3vnb+3TdIufISBHpru3AUJ37GyKnqb4Bk+N3XFKpIvh
   jUap/oUhyXajsF3qLXHQxxz6XE4xvr3aiym6ImWlAXrFsYYsVUAtAJhgW
   7vH53xDnu/uCNegm5MdO7nQyosLmFn1cCOPExe8VqG672r7jrV5RkLc8C
   PNpAms10m1A+TUsq7fAxEfjxMg+hhCaN9gSmtxxT7Uy5uzMcKfqtmM/mg
   Q==;
X-CSE-ConnectionGUID: pz2DVPi3TcedtX1rL1HFZg==
X-CSE-MsgGUID: KWJ/FrgMSyG9xbi0UBLmiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38155553"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38155553"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 11:43:13 -0800
X-CSE-ConnectionGUID: TTmjtc7YR/SMvhbs5frwqg==
X-CSE-MsgGUID: h2g96EbxTHCyeixHwFzB0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="107244525"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 22 Jan 2025 11:43:11 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tagd2-000aGd-1i;
	Wed, 22 Jan 2025 19:43:08 +0000
Date: Thu, 23 Jan 2025 03:42:10 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org, xudu@redhat.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	jmaxwell@redhat.com, magnus.karlsson@intel.com
Subject: Re: [Intel-wired-lan] [PATCH v4 iwl-net 3/3] ice: stop storing XDP
 verdict within ice_rx_buf
Message-ID: <202501230352.vJJRWiRa-lkp@intel.com>
References: <20250122151046.574061-4-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122151046.574061-4-maciej.fijalkowski@intel.com>

Hi Maciej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-net-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/ice-put-Rx-buffers-after-being-done-with-current-frame/20250122-231406
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20250122151046.574061-4-maciej.fijalkowski%40intel.com
patch subject: [Intel-wired-lan] [PATCH v4 iwl-net 3/3] ice: stop storing XDP verdict within ice_rx_buf
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250123/202501230352.vJJRWiRa-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250123/202501230352.vJJRWiRa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501230352.vJJRWiRa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_txrx.c:1140: warning: Function parameter or struct member 'verdict' not described in 'ice_put_rx_mbuf'


vim +1140 drivers/net/ethernet/intel/ice/ice_txrx.c

2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1126  
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1127  /**
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1128   * ice_put_rx_mbuf - ice_put_rx_buf() caller, for all frame frags
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1129   * @rx_ring: Rx ring with all the auxiliary data
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1130   * @xdp: XDP buffer carrying linear + frags part
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1131   * @xdp_xmit: XDP_TX/XDP_REDIRECT verdict storage
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1132   * @ntc: a current next_to_clean value to be stored at rx_ring
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1133   *
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1134   * Walk through gathered fragments and satisfy internal page
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1135   * recycle mechanism; we take here an action related to verdict
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1136   * returned by XDP program;
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1137   */
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1138  static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1139  			    u32 *xdp_xmit, u32 ntc, u32 verdict)
bee8fb85c01733 Maciej Fijalkowski     2025-01-22 @1140  {
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1141  	u32 nr_frags = rx_ring->nr_frags + 1;
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1142  	u32 idx = rx_ring->first_desc;
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1143  	u32 cnt = rx_ring->count;
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1144  	u32 post_xdp_frags = 1;
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1145  	struct ice_rx_buf *buf;
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1146  	int i;
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1147  
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1148  	if (unlikely(xdp_buff_has_frags(xdp)))
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1149  		post_xdp_frags += xdp_get_shared_info_from_buff(xdp)->nr_frags;
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1150  
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1151  	for (i = 0; i < post_xdp_frags; i++) {
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1152  		buf = &rx_ring->rx_buf[idx];
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1153  
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1154  		if (verdict & (ICE_XDP_TX | ICE_XDP_REDIR)) {
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1155  			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1156  			*xdp_xmit |= verdict;
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1157  		} else if (verdict & ICE_XDP_CONSUMED) {
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1158  			buf->pagecnt_bias++;
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1159  		} else if (verdict == ICE_XDP_PASS) {
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1160  			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1161  		}
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1162  
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1163  		ice_put_rx_buf(rx_ring, buf);
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1164  
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1165  		if (++idx == cnt)
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1166  			idx = 0;
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1167  	}
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1168  	/* handle buffers that represented frags released by XDP prog;
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1169  	 * for these we keep pagecnt_bias as-is; refcount from struct page
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1170  	 * has been decremented within XDP prog and we do not have to increase
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1171  	 * the biased refcnt
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1172  	 */
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1173  	for (; i < nr_frags; i++) {
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1174  		buf = &rx_ring->rx_buf[idx];
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1175  		ice_put_rx_buf(rx_ring, buf);
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1176  		if (++idx == cnt)
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1177  			idx = 0;
3dab6a1cb7698e Maciej Fijalkowski     2025-01-22  1178  	}
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1179  
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1180  	xdp->data = NULL;
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1181  	rx_ring->first_desc = ntc;
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1182  	rx_ring->nr_frags = 0;
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1183  }
bee8fb85c01733 Maciej Fijalkowski     2025-01-22  1184  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

