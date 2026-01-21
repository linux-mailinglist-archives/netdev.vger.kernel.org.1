Return-Path: <netdev+bounces-252067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIPBJR9McWn2fgAAu9opvQ
	(envelope-from <netdev+bounces-252067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:58:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E855E664
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B86AD92D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010D140FDAE;
	Wed, 21 Jan 2026 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSZJesAI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E04397AAC
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032401; cv=none; b=gFbE0EtbGCTfRE82el634zq4nUo7bfWJCaid6CXCVeM2mPnqm1CvtVsF6EcSFlb82+1lyYtCaehtX85egrUj7kE4bDmcBc0SgTMDXQbeQUVoTht60gTr1V7/fBddorO+k61nNOw8wPcPIPlmfQwiFL6JhdZSd/R+hQjbrzfjHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032401; c=relaxed/simple;
	bh=sJciIfgI9AJ9r3GlB7MYX8yMUOqY3mV/7q5wOURip+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgkx7febEsqATZd1md368gGXPsC7HASh7UA4iKlwES0f88CLywknITl7NxO59P+fyBKGZtZOZyKkkhNcad48xvP5q3G5wFht8ZNtZ9a0jp9oyzcjygZ62lX3MTQINGN5zMK1S7KwQTGCCy9jcWSWvVu/CyngeWlL8s6WaXff98Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSZJesAI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769032399; x=1800568399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sJciIfgI9AJ9r3GlB7MYX8yMUOqY3mV/7q5wOURip+0=;
  b=SSZJesAImYtD+QzMfp/zVauyMMQZvTaralOy+GOnCp/Iuy5ri+naziL7
   rBQROAPJaS3L8mfSQJTBaE6lHNXTRra2kK5kXo4kkx7/GSWIJH8E7ArrW
   9KgF3rgNjAxf6SyC3fzk+akLjfJEL+OIyXJkl0LtI114EztTefjZyIgzI
   0MWgHPu4Glns5F5QDgS7qbcip++udN5BYKWhzPcDb7+4sZGYWV0dQHLcl
   L9kr3ev24nMSjvCLVi2fqi/tjz1w6vx5zeIaR3tfafVvvFMf2TMjyPfJc
   HAn1CakFMaBRcF4CgFXys/9sg1sDzc4gxBYmRFcgngr6Jdp53CmWhjmli
   A==;
X-CSE-ConnectionGUID: zrbR8uxHSaiyaNtGOHSWpQ==
X-CSE-MsgGUID: tnOtC4D1TG2HqN0e7Fhhyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="87682886"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="87682886"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 13:53:19 -0800
X-CSE-ConnectionGUID: W8WmCJgSQKC8kyFpBsG+nA==
X-CSE-MsgGUID: P1P94qleTmCbyi8u8PMkeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="210718602"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Jan 2026 13:53:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vig8W-00000000S2r-1TXE;
	Wed, 21 Jan 2026 21:53:12 +0000
Date: Thu, 22 Jan 2026 05:52:14 +0800
From: kernel test robot <lkp@intel.com>
To: Felix Maurer <fmaurer@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	bigeasy@linutronix.de, Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next 6/9] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <202601220557.VfSPsAdo-lkp@intel.com>
References: <a58f3b542fd8564c5d9576a10a9d6c9a7f318931.1769001553.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a58f3b542fd8564c5d9576a10a9d6c9a7f318931.1769001553.git.fmaurer@redhat.com>
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,smile.fr];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-252067-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: A3E855E664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Felix,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Felix-Maurer/selftests-hsr-Add-ping-test-for-PRP/20260121-221431
base:   net-next/main
patch link:    https://lore.kernel.org/r/a58f3b542fd8564c5d9576a10a9d6c9a7f318931.1769001553.git.fmaurer%40redhat.com
patch subject: [PATCH net-next 6/9] hsr: Implement more robust duplicate discard for HSR
config: alpha-randconfig-r073-20260122 (https://download.01.org/0day-ci/archive/20260122/202601220557.VfSPsAdo-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.5.0
smatch version: v0.5.0-8985-g2614ff1a
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601220557.VfSPsAdo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601220557.VfSPsAdo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/hsr/hsr_framereg.c: In function 'fill_last_seq_nrs':
>> net/hsr/hsr_framereg.c:781:22: warning: variable 'block_off' set but not used [-Wunused-but-set-variable]
     781 |         unsigned int block_off;
         |                      ^~~~~~~~~


vim +/block_off +781 net/hsr/hsr_framereg.c

   773	
   774	/* Fill the last sequence number that has been received from node on if1 by
   775	 * finding the last sequence number sent on port B; accordingly get the last
   776	 * received sequence number for if2 using sent sequence numbers on port A.
   777	 */
   778	static void fill_last_seq_nrs(struct hsr_node *node, u16 *if1_seq, u16 *if2_seq)
   779	{
   780		struct hsr_seq_block *block;
 > 781		unsigned int block_off;
   782		size_t block_sz;
   783		u16 seq_bit;
   784	
   785		spin_lock_bh(&node->seq_out_lock);
   786	
   787		// Get last inserted block
   788		block_off = (node->next_block - 1) & (HSR_MAX_SEQ_BLOCKS - 1);
   789		block_sz = hsr_seq_block_size(node);
   790		block = node->block_buf + node->next_block * block_sz;
   791	
   792		if (!bitmap_empty(block->seq_nrs[HSR_PT_SLAVE_B - 1],
   793				  HSR_SEQ_BLOCK_SIZE)) {
   794			seq_bit = find_last_bit(block->seq_nrs[HSR_PT_SLAVE_B - 1],
   795						HSR_SEQ_BLOCK_SIZE);
   796			*if1_seq = (block->block_idx << HSR_SEQ_BLOCK_SHIFT) | seq_bit;
   797		}
   798		if (!bitmap_empty(block->seq_nrs[HSR_PT_SLAVE_A - 1],
   799				  HSR_SEQ_BLOCK_SIZE)) {
   800			seq_bit = find_last_bit(block->seq_nrs[HSR_PT_SLAVE_A - 1],
   801						HSR_SEQ_BLOCK_SIZE);
   802			*if2_seq = (block->block_idx << HSR_SEQ_BLOCK_SHIFT) | seq_bit;
   803		}
   804		spin_unlock_bh(&node->seq_out_lock);
   805	}
   806	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

