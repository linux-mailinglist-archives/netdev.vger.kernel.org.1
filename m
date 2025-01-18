Return-Path: <netdev+bounces-159569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E910A15D92
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 16:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3603166CB5
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4493619068E;
	Sat, 18 Jan 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rm7Cgj/A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB77189B91;
	Sat, 18 Jan 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737212788; cv=none; b=hfQiPYNkZ3SZu99ZNKjLo7szvoDP+4Kbdkhmi2el02rFDCFor271Fcyk7Jv1mvkMPanPRIwY9LXANLytdVTeIM15MNJHi+pV2tYwbqRAv+B6IeG798AhJvH/a/wGSv/mZmiPrrgvPA6Eh4Z6RGJrBIUQfRIfyLfT9dzqtSweFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737212788; c=relaxed/simple;
	bh=jkbgZtrM2XmBN/IkJ+4GzldpC6tPh2ZxTAkwaMzPCUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdJZ5grXsheu/SIsWh7vWO27pppPk/N+d4+Y9MYv9KTO1YqplJQKCyP+UY6mhg5m6qDe3XVJzUAHh2VJ6FnPiWaM9aR3iEF3+UtP7O9fDHraGT097vvKWZSJtvqgxu+U4pdVct3jHuZYVsY8SEe0lbEDdL9P8zH+IqUrwu9UXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rm7Cgj/A; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737212786; x=1768748786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jkbgZtrM2XmBN/IkJ+4GzldpC6tPh2ZxTAkwaMzPCUA=;
  b=Rm7Cgj/AiZ7xMYc/QWbL+fBXZ9zH/N3PLJ5DmKSL85UvOzB2XlxTVeOe
   jTftwL/+exxMskg29LnA7RLXABcuZqtQc9zo5pGgf7FRlOunK9GKwNx5z
   C4jRfDH9Ikh00E1PkF61sYxKBVPIocWfNuqccEWKFJ3b30rpRPKy0wnhx
   Xp6lVMjph9tGD4T2LAOoskBBg13tevYgFu1Y8GX8qTPeqUiPPWhMuRwVW
   lJ0KeodSgybJ7iyET2oVArVCV6cQLfuVmPFh2GyHW5ceC0F6ftkQakYrQ
   XY5QFoixSRJnBtHFRCc/m5XV+71qvQ1SIyIrTwiMxMwVZzmd5G7BvvFh3
   g==;
X-CSE-ConnectionGUID: iASFJYdUTtS6gzM4zMWhIw==
X-CSE-MsgGUID: WTv1yztKSQidoZRMCNVLsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11319"; a="40441844"
X-IronPort-AV: E=Sophos;i="6.13,215,1732608000"; 
   d="scan'208";a="40441844"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 07:06:25 -0800
X-CSE-ConnectionGUID: GVt/J22KTRigIsneYF6tCA==
X-CSE-MsgGUID: mKToLFB0S+GrKaWFyEE2XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,215,1732608000"; 
   d="scan'208";a="105876611"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Jan 2025 07:06:21 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZAOx-000UXD-0Q;
	Sat, 18 Jan 2025 15:06:19 +0000
Date: Sat, 18 Jan 2025 23:05:51 +0800
From: kernel test robot <lkp@intel.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com
Cc: oe-kbuild-all@lists.linux.dev, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.swiatkowski@linux.intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: Re: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI
 descriptor registers
Message-ID: <202501182225.DicoE2L2-lkp@intel.com>
References: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>

Hi Dheeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dheeraj-Reddy-Jonnalagadda/ixgbe-Fix-endian-handling-for-ACI-descriptor-registers/20250115-114330
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250115034117.172999-1-dheeraj.linuxdev%40gmail.com
patch subject: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI descriptor registers
config: x86_64-randconfig-r133-20250118 (https://download.01.org/0day-ci/archive/20250118/202501182225.DicoE2L2-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501182225.DicoE2L2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501182225.DicoE2L2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:116:17: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:116:17: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:116:17: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:148:39: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:156:39: sparse: sparse: cast to restricted __le32

vim +116 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c

    35	
    36	/**
    37	 * ixgbe_aci_send_cmd_execute - execute sending FW Admin Command to FW Admin
    38	 * Command Interface
    39	 * @hw: pointer to the HW struct
    40	 * @desc: descriptor describing the command
    41	 * @buf: buffer to use for indirect commands (NULL for direct commands)
    42	 * @buf_size: size of buffer for indirect commands (0 for direct commands)
    43	 *
    44	 * Admin Command is sent using CSR by setting descriptor and buffer in specific
    45	 * registers.
    46	 *
    47	 * Return: the exit code of the operation.
    48	 * * - 0 - success.
    49	 * * - -EIO - CSR mechanism is not enabled.
    50	 * * - -EBUSY - CSR mechanism is busy.
    51	 * * - -EINVAL - buf_size is too big or
    52	 * invalid argument buf or buf_size.
    53	 * * - -ETIME - Admin Command X command timeout.
    54	 * * - -EIO - Admin Command X invalid state of HICR register or
    55	 * Admin Command failed because of bad opcode was returned or
    56	 * Admin Command failed with error Y.
    57	 */
    58	static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
    59					      struct ixgbe_aci_desc *desc,
    60					      void *buf, u16 buf_size)
    61	{
    62		u16 opcode, buf_tail_size = buf_size % 4;
    63		u32 *raw_desc = (u32 *)desc;
    64		u32 hicr, i, buf_tail = 0;
    65		bool valid_buf = false;
    66	
    67		hw->aci.last_status = IXGBE_ACI_RC_OK;
    68	
    69		/* It's necessary to check if mechanism is enabled */
    70		hicr = IXGBE_READ_REG(hw, IXGBE_PF_HICR);
    71	
    72		if (!(hicr & IXGBE_PF_HICR_EN))
    73			return -EIO;
    74	
    75		if (hicr & IXGBE_PF_HICR_C) {
    76			hw->aci.last_status = IXGBE_ACI_RC_EBUSY;
    77			return -EBUSY;
    78		}
    79	
    80		opcode = le16_to_cpu(desc->opcode);
    81	
    82		if (buf_size > IXGBE_ACI_MAX_BUFFER_SIZE)
    83			return -EINVAL;
    84	
    85		if (buf)
    86			desc->flags |= cpu_to_le16(IXGBE_ACI_FLAG_BUF);
    87	
    88		if (desc->flags & cpu_to_le16(IXGBE_ACI_FLAG_BUF)) {
    89			if ((buf && !buf_size) ||
    90			    (!buf && buf_size))
    91				return -EINVAL;
    92			if (buf && buf_size)
    93				valid_buf = true;
    94		}
    95	
    96		if (valid_buf) {
    97			if (buf_tail_size)
    98				memcpy(&buf_tail, buf + buf_size - buf_tail_size,
    99				       buf_tail_size);
   100	
   101			if (((buf_size + 3) & ~0x3) > IXGBE_ACI_LG_BUF)
   102				desc->flags |= cpu_to_le16(IXGBE_ACI_FLAG_LB);
   103	
   104			desc->datalen = cpu_to_le16(buf_size);
   105	
   106			if (desc->flags & cpu_to_le16(IXGBE_ACI_FLAG_RD)) {
   107				for (i = 0; i < buf_size / 4; i++)
   108					IXGBE_WRITE_REG(hw, IXGBE_PF_HIBA(i), ((u32 *)buf)[i]);
   109				if (buf_tail_size)
   110					IXGBE_WRITE_REG(hw, IXGBE_PF_HIBA(i), buf_tail);
   111			}
   112		}
   113	
   114		/* Descriptor is written to specific registers */
   115		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 > 116			IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), cpu_to_le32(raw_desc[i]));
   117	
   118		/* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
   119		 * PF_HICR_EV
   120		 */
   121		hicr = (IXGBE_READ_REG(hw, IXGBE_PF_HICR) | IXGBE_PF_HICR_C) &
   122		       ~(IXGBE_PF_HICR_SV | IXGBE_PF_HICR_EV);
   123		IXGBE_WRITE_REG(hw, IXGBE_PF_HICR, hicr);
   124	
   125	#define MAX_SLEEP_RESP_US 1000
   126	#define MAX_TMOUT_RESP_SYNC_US 100000000
   127	
   128		/* Wait for sync Admin Command response */
   129		read_poll_timeout(IXGBE_READ_REG, hicr,
   130				  (hicr & IXGBE_PF_HICR_SV) ||
   131				  !(hicr & IXGBE_PF_HICR_C),
   132				  MAX_SLEEP_RESP_US, MAX_TMOUT_RESP_SYNC_US, true, hw,
   133				  IXGBE_PF_HICR);
   134	
   135	#define MAX_TMOUT_RESP_ASYNC_US 150000000
   136	
   137		/* Wait for async Admin Command response */
   138		read_poll_timeout(IXGBE_READ_REG, hicr,
   139				  (hicr & IXGBE_PF_HICR_EV) ||
   140				  !(hicr & IXGBE_PF_HICR_C),
   141				  MAX_SLEEP_RESP_US, MAX_TMOUT_RESP_ASYNC_US, true, hw,
   142				  IXGBE_PF_HICR);
   143	
   144		/* Read sync Admin Command response */
   145		if ((hicr & IXGBE_PF_HICR_SV)) {
   146			for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
   147				raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
 > 148				raw_desc[i] = le32_to_cpu(raw_desc[i]);
   149			}
   150		}
   151	
   152		/* Read async Admin Command response */
   153		if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
   154			for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
   155				raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
   156				raw_desc[i] = le32_to_cpu(raw_desc[i]);
   157			}
   158		}
   159	
   160		/* Handle timeout and invalid state of HICR register */
   161		if (hicr & IXGBE_PF_HICR_C)
   162			return -ETIME;
   163	
   164		if (!(hicr & IXGBE_PF_HICR_SV) && !(hicr & IXGBE_PF_HICR_EV))
   165			return -EIO;
   166	
   167		/* For every command other than 0x0014 treat opcode mismatch
   168		 * as an error. Response to 0x0014 command read from HIDA_2
   169		 * is a descriptor of an event which is expected to contain
   170		 * different opcode than the command.
   171		 */
   172		if (desc->opcode != cpu_to_le16(opcode) &&
   173		    opcode != ixgbe_aci_opc_get_fw_event)
   174			return -EIO;
   175	
   176		if (desc->retval) {
   177			hw->aci.last_status = (enum ixgbe_aci_err)
   178				le16_to_cpu(desc->retval);
   179			return -EIO;
   180		}
   181	
   182		/* Write a response values to a buf */
   183		if (valid_buf) {
   184			for (i = 0; i < buf_size / 4; i++)
   185				((u32 *)buf)[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIBA(i));
   186			if (buf_tail_size) {
   187				buf_tail = IXGBE_READ_REG(hw, IXGBE_PF_HIBA(i));
   188				memcpy(buf + buf_size - buf_tail_size, &buf_tail,
   189				       buf_tail_size);
   190			}
   191		}
   192	
   193		return 0;
   194	}
   195	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

