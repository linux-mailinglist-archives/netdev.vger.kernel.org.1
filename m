Return-Path: <netdev+bounces-258689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIa2M8MrkGmiWgEAu9opvQ
	(envelope-from <netdev+bounces-258689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 09:01:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 275BF13B55E
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 09:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99D593014848
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B452820A4;
	Sat, 14 Feb 2026 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WR3Zi17l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24011C860A;
	Sat, 14 Feb 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771056064; cv=none; b=qZppbN0B4osD4mt6Kkq3PENrLGb+HUOKK6aLgAWqrd9in04q/Af6amddO2usURytqbaHaRBXad/bWIUSvCTHHAwC2pJY2M7+aQxq2Y3gOoczGlyWg+rkwh/ZOS+2nZXHAIEq8M5wvpENvwJf2IX+72VF9WqgeWTUDP7ApvWkrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771056064; c=relaxed/simple;
	bh=zHHZHSpFNz8VdD6TZxtjd43NGQRTsenYiTPnEOHMl00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCNDm85pT0/p6SAAjGW0yJo1FhUt7HjgKdvCl0GhjF3wIYg0dOQmobk2AfppyTKcUWNNY/ZbwF2AMgUJy8z+3RwbK1HNNRSywepvDtzmboTcq2bB1ha4fwd+rRaJxaeaIbg0Ik9qMy+cTfKsnqj0IQoKlqJniFFKeXDKtlORN5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WR3Zi17l; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771056062; x=1802592062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zHHZHSpFNz8VdD6TZxtjd43NGQRTsenYiTPnEOHMl00=;
  b=WR3Zi17l6yKhLNn8oAzrJ6IU1SFJi9wDbgRubQzq8m0D5IMFLHRfCkGH
   SoM8/GmfM9naWTcIafCDUSOQ8fw/VRaXl4RxZHLFHshS5DdUJJU7zgUWT
   VDeTDIrOn7GZ0MRmGjy3m+lHNYiDEMZE0Gi+uIw2+dlNGSKRSdp9wZs1t
   R06yxIKDN/qnqk+DdsgmCEt4jT31MTip95Sgh/K+W4sjJgKxYF2fiJ8s3
   hJzz4/Wx5NbQflmYo2MAdm0GoKRzBCycNCmdGj5XqPPAGPev/dZiDmFBy
   SOWJqwJBcogU7zkyxe8WV1m0oBdT1ah8GxQzVH6r0jJzvIlxtzWk5XfH9
   A==;
X-CSE-ConnectionGUID: VTujn0GVTYKjHnLoQTE/0Q==
X-CSE-MsgGUID: GTkqIN2dQZCrasuPib9wQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="83595507"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="83595507"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 00:01:01 -0800
X-CSE-ConnectionGUID: oNpYrDVRR7WyI3DWrXNRKg==
X-CSE-MsgGUID: leycIjwNQ5iXJiU9xiBbNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="213231962"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 14 Feb 2026 00:00:57 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrAaE-000000001nt-0zKp;
	Sat, 14 Feb 2026 08:00:54 +0000
Date: Sat, 14 Feb 2026 09:00:05 +0100
From: kernel test robot <lkp@intel.com>
To: Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, hawk@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	kernel-team@cloudflare.com, jbrandeburg@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] bnxt_en: Implement XDP RSS hash metadata extraction
Message-ID: <202602140829.b2xx1hxx-lkp@intel.com>
References: <20260213192449.1294830-3-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213192449.1294830-3-carges@cloudflare.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258689-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[cloudflare.com,broadcom.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url]
X-Rspamd-Queue-Id: 275BF13B55E
X-Rspamd-Action: no action

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.19]
[cannot apply to linus/master next-20260213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-J-Arges/bnxt_en-use-bnxt_xdp_buff-for-xdp-context/20260214-032849
base:   v6.19
patch link:    https://lore.kernel.org/r/20260213192449.1294830-3-carges%40cloudflare.com
patch subject: [PATCH 2/2] bnxt_en: Implement XDP RSS hash metadata extraction
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260214/202602140829.b2xx1hxx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260214/202602140829.b2xx1hxx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602140829.b2xx1hxx-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c:476:12: error: static declaration of 'bnxt_xdp_rx_hash' follows non-static declaration
     476 | static int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
         |            ^~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c:22:
   drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h:44:5: note: previous declaration of 'bnxt_xdp_rx_hash' with type 'int(const struct xdp_md *, u32 *, enum xdp_rss_hash_type *)' {aka 'int(const struct xdp_md *, unsigned int *, enum xdp_rss_hash_type *)'}
      44 | int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
         |     ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c:476:12: warning: 'bnxt_xdp_rx_hash' defined but not used [-Wunused-function]
     476 | static int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
         |            ^~~~~~~~~~~~~~~~


vim +/bnxt_xdp_rx_hash +476 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c

   475	
 > 476	static int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

