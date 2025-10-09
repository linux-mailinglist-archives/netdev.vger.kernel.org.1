Return-Path: <netdev+bounces-228441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B684BCAF2B
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 23:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB0B19E7E78
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 21:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0C28136F;
	Thu,  9 Oct 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SynoOySz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0255272813;
	Thu,  9 Oct 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045821; cv=none; b=GWdxlIa2CJos/i+dQjqb5PRWZBXKSDwbuFzfFSyj2V4ZVRT8gETyAxWvtl0TosvqvY4du+MrWypEqyeWasj1ya7JACjrrZygrGLj7rlnxoHY/PL7svngmvpfA5cYhIS/FEsP3v1fkf3BV5tqFOjGk8Bcou+MGekcu0pNqicGDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045821; c=relaxed/simple;
	bh=RgS44lxvbU6lDjItJfGDfhpBYiflSNB4fwxf9JnAi6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcOM3FXrVEPKDGxKRvJJ8fZXws1OSEuOqiQcxiS2XShT1VKW/kHABymVathj1Dxpq2OsXowaq6Ednk+XKXqZwUYQ17nMJid4RfYkKRX8IDPa5BBVrv3yvsJAK6Zee3ANHZXkY77/e+Na+JpNTqbEuh3/FnSjT6e+X61X15vI2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SynoOySz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760045819; x=1791581819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RgS44lxvbU6lDjItJfGDfhpBYiflSNB4fwxf9JnAi6Y=;
  b=SynoOySzyGq2n02XXj2YqdG3iiLWCFE00uA4+rXwkmKzGuLJ1xhNRp/u
   NdOfkvwXjTteYcQmOHQS2gfCihbHtnhP8MTTF+VPsECNmyTg8TGSv1pee
   ndrcEA7p7m9+Ehs+06dWXNxdOn8DcRP+ES18clUG4C/2X+fupYtdH2xIj
   6eGYw+t46NIVuEQ8C2LEoKxSdXyHn1exqG9kj7WTAJVvt9lK9Rbt8b1ZF
   UX8HivzrZnv0or8V+/ofJV/K/R1lWldiHFQR6ddDv5eHLudGzy2p2EgUf
   GwRKrc56m9rYvGFZ44V2lOh5baYKllEnOHFeMIJMly4oNylVcL5Rn17Bm
   Q==;
X-CSE-ConnectionGUID: UJUpEJtkSUiuWA1rHNahkw==
X-CSE-MsgGUID: SiU+rDQ8Qt6NDI1Oey7kyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="87726926"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="87726926"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 14:36:57 -0700
X-CSE-ConnectionGUID: ue2VzTsYTIu45ra031tL6Q==
X-CSE-MsgGUID: a2v1uV22T0GvaG+Bfk2Zkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="186082522"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Oct 2025 14:36:53 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6yJe-0001VD-2D;
	Thu, 09 Oct 2025 21:36:50 +0000
Date: Fri, 10 Oct 2025 05:36:31 +0800
From: kernel test robot <lkp@intel.com>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH] nvme/tcp: handle tls partially sent records in
 write_space()
Message-ID: <202510100505.gzOzGPbI-lkp@intel.com>
References: <20251007004634.38716-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007004634.38716-2-wilfred.opensource@gmail.com>

Hi Wilfred,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master linux-nvme/for-next v6.17 next-20251009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wilfred-Mallawa/nvme-tcp-handle-tls-partially-sent-records-in-write_space/20251009-193029
base:   net/main
patch link:    https://lore.kernel.org/r/20251007004634.38716-2-wilfred.opensource%40gmail.com
patch subject: [PATCH] nvme/tcp: handle tls partially sent records in write_space()
config: s390-randconfig-002-20251010 (https://download.01.org/0day-ci/archive/20251010/202510100505.gzOzGPbI-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510100505.gzOzGPbI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510100505.gzOzGPbI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/tcp.c:1316:22: warning: unused variable 'ctx' [-Wunused-variable]
    1316 |         struct tls_context *ctx = tls_get_ctx(queue->sock->sk);
         |                             ^~~
   1 warning generated.


vim +/ctx +1316 drivers/nvme/host/tcp.c

  1312	
  1313	static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
  1314	{
  1315		struct nvme_tcp_request *req;
> 1316		struct tls_context *ctx = tls_get_ctx(queue->sock->sk);
  1317		unsigned int noreclaim_flag;
  1318		int ret = 1;
  1319	
  1320		if (!queue->request) {
  1321			queue->request = nvme_tcp_fetch_request(queue);
  1322			if (!queue->request)
  1323				return 0;
  1324		}
  1325		req = queue->request;
  1326	
  1327		noreclaim_flag = memalloc_noreclaim_save();
  1328		if (req->state == NVME_TCP_SEND_CMD_PDU) {
  1329			ret = nvme_tcp_try_send_cmd_pdu(req);
  1330			if (ret <= 0)
  1331				goto done;
  1332			if (!nvme_tcp_has_inline_data(req))
  1333				goto out;
  1334		}
  1335	
  1336		if (req->state == NVME_TCP_SEND_H2C_PDU) {
  1337			ret = nvme_tcp_try_send_data_pdu(req);
  1338			if (ret <= 0)
  1339				goto done;
  1340		}
  1341	
  1342		if (req->state == NVME_TCP_SEND_DATA) {
  1343			ret = nvme_tcp_try_send_data(req);
  1344			if (ret <= 0)
  1345				goto done;
  1346		}
  1347	
  1348		if (req->state == NVME_TCP_SEND_DDGST)
  1349			ret = nvme_tcp_try_send_ddgst(req);
  1350	done:
  1351		if (ret == -EAGAIN) {
  1352			ret = 0;
  1353		} else if (ret < 0) {
  1354			dev_err(queue->ctrl->ctrl.device,
  1355				"failed to send request %d\n", ret);
  1356			nvme_tcp_fail_request(queue->request);
  1357			nvme_tcp_done_send_req(queue);
  1358		}
  1359	out:
  1360		memalloc_noreclaim_restore(noreclaim_flag);
  1361		return ret;
  1362	}
  1363	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

