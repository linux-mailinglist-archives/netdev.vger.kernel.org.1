Return-Path: <netdev+bounces-229735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E1DBE0735
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D0C1344389
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC930DEAF;
	Wed, 15 Oct 2025 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qd6EZFM8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D723090FD;
	Wed, 15 Oct 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556797; cv=none; b=KSaoomnt/aLLAFH1CBTxDfdBhHvxw0KzO0ml+IZPu+xdwCRa91A+0+zt+/2koipjiWWh8m4+foxO7SRnbnlUE244yusCm1dGrxkc2eZfnGBJcC2g7J9B61G9PLuYki32l2U7dbeCfqDf6kUasTgOxCfY5VtRZ1KqDeHRW+qCBiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556797; c=relaxed/simple;
	bh=0nLHdnCC4/On7MtISTlXnOcbBRTiTvN6zWaW3stStew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lT2AklrECvDSqyB7GL+kTFQ55x5WmXeqmesLevsgDkz/jVNwlEQP+38Gf8g9Ej/aDvA83swDkt/7AltQDU2Ot7MTsj5kimKuvdT/nqaJNWf2etx1KtmoQAAMlkZ2cYTAL7YyEZYPv51MV5/dZvL/fyXnP/Xvj6dglblwa7xY8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qd6EZFM8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760556796; x=1792092796;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=0nLHdnCC4/On7MtISTlXnOcbBRTiTvN6zWaW3stStew=;
  b=Qd6EZFM8I7+IpksxkdBRt842gm+Z38fFGd15leKXtJ1FWltDPkE3TKsm
   GzKRsojdO6tlwaGaOqQvy5GZlKVcYKkS6o85RbEKj7zO50Tnz04pDBo/N
   Fv1K1ZbM9EAJ4BpLRru/V5m/CxADuREygZE8f7SqSO0kzXX0aFW8/clOO
   RAot+bgZB2bAOTvdnsN9lW0Q6azzNLCEP47jVojWLOdg/BHZDZ2O+ornF
   Z88hvAhI7BQiYg9r/TSh8RY+G6NqOKPyZj3VfxzumIRjmKM2mbzL9tXX7
   npL+a9GWcAboB7NWlmXULeIdGUr9EtB9J/3lUhK90mvSXwg8tf54xSAXa
   A==;
X-CSE-ConnectionGUID: dN01QSzyT3CGgaP8MW+HbQ==
X-CSE-MsgGUID: 9wN6uBhuR+20WwRmN/ftMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="74083454"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="74083454"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:13 -0700
X-CSE-ConnectionGUID: wEDieGhrRZKn/fDrxAOQ+w==
X-CSE-MsgGUID: VFavq+1ITUKE3FbYzIKlyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182044865"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:13 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 00/14] Intel Wired LAN Driver Updates 2025-10-15
 (ice, iavf, ixgbe, i40e, e1000e)
Date: Wed, 15 Oct 2025 12:31:56 -0700
Message-Id: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK/272gC/x2M0QpAQBAAf0X7bOuWu8SvyINYLDq6u1Dy747Hm
 Zq5wbMT9lAlNzg+xMtmI1CaQDe1dmSUPjJkKjOkyOC8oJwrWr4CfhJJYdQlaZ2rotCDIYjx7ni
 Q6x/XYDn8ATTP8wLfHVpgcgAAAA==
X-Change-ID: 20251015-jk-iwl-next-2025-10-15-914430774f51
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Mohammad Heib <mheib@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Rafal Romanowski <rafal.romanowski@intel.com>, 
 Dan Nowlin <dan.nowlin@intel.com>, Junfeng Guo <junfeng.guo@intel.com>, 
 Ting Xu <ting.xu@intel.com>, Jie Wang <jie1x.wang@intel.com>, 
 Qi Zhang <qi.z.zhang@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Rinitha S <sx.rinitha@intel.com>, Hariprasad Kelam <hkelam@marvell.com>, 
 Kohei Enju <enjuk@amazon.com>, Vitaly Lifshits <vitaly.lifshits@intel.com>, 
 =?utf-8?q?Timo_Ter=C3=A4s?= <timo.teras@iki.fi>, 
 Dima Ruinskiy <dima.ruinskiy@intel.com>, 
 Avraham Koren <Avrahamx.koren@intel.com>, jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=4446;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=0nLHdnCC4/On7MtISTlXnOcbBRTiTvN6zWaW3stStew=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoz33z6u6OizKv/F/yDsoojY+QXL9r5rdv3BKaO5xqMzy
 EamUzm9o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIl8VmP473rE/PwnZ3+Nzhmt
 fXJnt9cx8L7YKNl5rO7Gy6lfOzJX3GL4H29/k1fdxu2Mw+3utz7OV/INVnwo6bNWO3Da5qDGh0U
 FrAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

Mohammad Heib introduces a new devlink parameter, max_mac_per_vf, for
controlling the maximum number of MAC address filters allowed by a VF. This
allows administrators to control the VF behavior in a more nuanced manner.

Aleksandr and Przemek add support for Receive Side Scaling of GTP to iAVF
for VFs running on E800 series ice hardware. This improves performance and
scalability for virtualized network functions in 5G and LTE deployments.

Jacob revives one-year-old work from Jesse Brandeburg to implement the
standardized statistics interfaces from ethtool in the ice driver.

Kohei improves the behavior of the RSS indirection table for ixgbe,
ensuring it is preserved across device reset and when the device is
administratively closed and re-open.

Vitaly introduces a new private flag to control the K1 power state of ICH
network controllers supported by the e1000e driver. This flag has been
extensively discussed on the list and deemed the best available option to
provide a field workaround without impacting the many configurations that
have no issues with the K1 power state.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Aleksandr Loktionov (4):
      ice: add flow parsing for GTP and new protocol field support
      ice: add virtchnl and VF context support for GTP RSS
      ice: improve TCAM priority handling for RSS profiles
      iavf: add RSS support for GTP protocol via ethtool

Jesse Brandeburg (5):
      net: docs: add missing features that can have stats
      ice: implement ethtool standard stats
      ice: add tracking of good transmit timestamps
      ice: implement transmit hardware timestamp statistics
      ice: refactor to use helpers

Kohei Enju (1):
      ixgbe: preserve RSS indirection table across admin down/up

Mohammad Heib (2):
      devlink: Add new "max_mac_per_vf" generic device param
      i40e: support generic devlink param "max_mac_per_vf"

Przemek Kitszel (1):
      ice: Extend PTYPE bitmap coverage for GTP encapsulated flows

Vitaly Lifshits (1):
      e1000e: Introduce private flag to disable K1

 drivers/net/ethernet/intel/e1000e/e1000.h          |    1 +
 drivers/net/ethernet/intel/i40e/i40e.h             |    4 +
 drivers/net/ethernet/intel/iavf/iavf_adv_rss.h     |   31 +
 drivers/net/ethernet/intel/ice/ice_flex_type.h     |    1 +
 drivers/net/ethernet/intel/ice/ice_flow.h          |   94 +-
 drivers/net/ethernet/intel/ice/ice_protocol_type.h |   20 +
 drivers/net/ethernet/intel/ice/ice_ptp.h           |    2 +
 drivers/net/ethernet/intel/ice/ice_type.h          |    1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |   48 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |    2 +
 include/linux/avf/virtchnl.h                       |   50 +
 include/net/devlink.h                              |    4 +
 drivers/net/ethernet/intel/e1000e/ethtool.c        |   45 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |   41 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    3 +
 drivers/net/ethernet/intel/i40e/i40e_devlink.c     |   48 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   31 +-
 drivers/net/ethernet/intel/iavf/iavf_adv_rss.c     |  119 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   89 ++
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  144 ++-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c     |   99 +-
 drivers/net/ethernet/intel/ice/ice_flow.c          |  270 +++-
 drivers/net/ethernet/intel/ice/ice_lag.c           |    3 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   13 +-
 drivers/net/ethernet/intel/ice/ice_parser.c        |    3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   15 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    3 +-
 drivers/net/ethernet/intel/ice/virt/rss.c          | 1307 +++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   45 +-
 net/devlink/param.c                                |    5 +
 .../networking/devlink/devlink-params.rst          |    4 +
 Documentation/networking/devlink/i40e.rst          |   32 +
 Documentation/networking/statistics.rst            |    4 +-
 33 files changed, 2352 insertions(+), 229 deletions(-)
---
base-commit: 1c51450f1afff1e7419797720df3fbd9ccbf610c
change-id: 20251015-jk-iwl-next-2025-10-15-914430774f51

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


