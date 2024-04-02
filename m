Return-Path: <netdev+bounces-84164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC24895D61
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 22:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF98D1C230CE
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 20:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75215DBAE;
	Tue,  2 Apr 2024 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOyLDeEg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D93815E5A5
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088721; cv=none; b=Fo6oN+5P3g4tC4GnzrkBhDKcas543PAGiAYS9CB1Kq3WNIT91EZnbsvkqml50jMcbaGHmLK1JIDph3t5hZsX2yTE5IOh7s3RmGsjtbfnATXa6AIaTXQPveQ9omwgjXrqPgRrutRioiudtg4HAOlUwAR9MbvygKlMIUrxKiO6MdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088721; c=relaxed/simple;
	bh=eXiWsMvZZG2RmREpe/OR0bmezRlbNy8wjN4Mp+uGxUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqeHOMSRbaz6XT/XjjuQdyxvoASSFnEfNgUwea5TZJ7A7MTuG5vsICjQl0+h0EdC2U2qc17YAvwOBJl9yc68CdfRHgZXHsc3is1pq6TNHs2R00mKEqbHaqFQhMWpfrsggjlNyG/g6IGAVZU40gMeVymfGlyCSvUuXgPLmMx260Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOyLDeEg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712088719; x=1743624719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eXiWsMvZZG2RmREpe/OR0bmezRlbNy8wjN4Mp+uGxUs=;
  b=LOyLDeEgTNvIPgaoLBlYWBERfGWggXsrSjIGEcrCzmd1nEG+lKYRql1p
   Vj1Ph5WRtPWAk994kjyly6/orOkFkIiw39Co1qcHdfI1sPTRQZ0TPEUp6
   VbCec0f1dYcfddnLTID6dCuu6lA8gqyar64BfQJ2W5Nub71/ENmekICpq
   MOa1vDzuIs7DVkhhaz3qgMFCaFoKk3OwQnOI9Cy+0f01HnACyUrMv9tIY
   ugS0E63wqFdy8ZIFzfZfGRxDtqBozQACQRIDmXZQoqd71UyQY3AkpaeQh
   26RqqTS+jDgrtwcbKbG6+2t3gyKHYq7OwpHIJ7GBB/QChhh93YtmGA7Ny
   Q==;
X-CSE-ConnectionGUID: 4Tki0nWnSc6A8sFu7otRnQ==
X-CSE-MsgGUID: BCtoltizTm+CO2XPgYq1AQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17857944"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="17857944"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 13:11:58 -0700
X-CSE-ConnectionGUID: zvwFfhDpSyisT0fB2OUcaw==
X-CSE-MsgGUID: PiQirJWUQaGhIuJYyYoVpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18004659"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Apr 2024 13:11:55 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrkU3-0001VR-2q;
	Tue, 02 Apr 2024 20:11:52 +0000
Date: Wed, 3 Apr 2024 04:11:17 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 1/3] ethtool: provide customized dim profile
 management
Message-ID: <202404030318.707Oc9CJ-lkp@intel.com>
References: <1712059988-7705-2-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712059988-7705-2-git-send-email-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/ethtool-provide-customized-dim-profile-management/20240402-201527
base:   net-next/main
patch link:    https://lore.kernel.org/r/1712059988-7705-2-git-send-email-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v3 1/3] ethtool: provide customized dim profile management
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240403/202404030318.707Oc9CJ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404030318.707Oc9CJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404030318.707Oc9CJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ethtool/coalesce.c:363: warning: Function parameter or struct member 'extack' not described in 'ethnl_update_profile'


vim +363 net/ethtool/coalesce.c

   340	
   341	/**
   342	 * ethnl_update_profile - get a nla nest with four child nla nests from userspace.
   343	 * @dst: data get from the driver and modified by ethnl_update_profile.
   344	 * @nests: nest attr ETHTOOL_A_COALESCE_*X_*QE_PROFILE to set driver's profile.
   345	 * @mod: whether the data is modified
   346	 *
   347	 * Layout of nests:
   348	 *   Nested ETHTOOL_A_COALESCE_*X_*QE_PROFILE attr
   349	 *     Nested ETHTOOL_A_MODERATIONS_MODERATION attr
   350	 *       ETHTOOL_A_MODERATION_USEC attr
   351	 *       ETHTOOL_A_MODERATION_PKTS attr
   352	 *       ETHTOOL_A_MODERATION_COMPS attr
   353	 *     ...
   354	 *     Nested ETHTOOL_A_MODERATIONS_MODERATION attr
   355	 *       ETHTOOL_A_MODERATION_USEC attr
   356	 *       ETHTOOL_A_MODERATION_PKTS attr
   357	 *       ETHTOOL_A_MODERATION_COMPS attr
   358	 */
   359	static inline void ethnl_update_profile(struct dim_cq_moder *dst,
   360						const struct nlattr *nests,
   361						bool *mod,
   362						struct netlink_ext_ack *extack)
 > 363	{
   364		struct nlattr *tb_moder[ARRAY_SIZE(coalesce_set_profile_policy)];
   365		struct dim_cq_moder profs[NET_DIM_PARAMS_NUM_PROFILES];
   366		struct nlattr *nest;
   367		int ret, rem, i = 0;
   368	
   369		if (!nests)
   370			return;
   371	
   372		nla_for_each_nested(nest, nests, rem) {
   373			if (WARN_ONCE(nla_type(nest) != ETHTOOL_A_MODERATIONS_MODERATION,
   374				      "unexpected nest attrtype %u\n", nla_type(nest)))
   375				return;
   376	
   377			ret = nla_parse_nested(tb_moder,
   378					       ARRAY_SIZE(coalesce_set_profile_policy) - 1,
   379					       nest, coalesce_set_profile_policy,
   380					       extack);
   381			if (ret ||
   382			    !tb_moder[ETHTOOL_A_MODERATION_USEC] ||
   383			    !tb_moder[ETHTOOL_A_MODERATION_PKTS] ||
   384			    !tb_moder[ETHTOOL_A_MODERATION_COMPS]) {
   385				NL_SET_ERR_MSG(extack, "wrong ETHTOOL_A_MODERATION_* attribute\n");
   386				return;
   387			}
   388	
   389			profs[i].usec = nla_get_u16(tb_moder[ETHTOOL_A_MODERATION_USEC]);
   390			profs[i].pkts = nla_get_u16(tb_moder[ETHTOOL_A_MODERATION_PKTS]);
   391			profs[i].comps = nla_get_u16(tb_moder[ETHTOOL_A_MODERATION_COMPS]);
   392	
   393			if (dst[i].usec != profs[i].usec || dst[i].pkts != profs[i].pkts ||
   394			    dst[i].comps != profs[i].comps)
   395				*mod = true;
   396	
   397			i++;
   398		}
   399	
   400		memcpy(dst, profs, sizeof(profs));
   401	}
   402	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

