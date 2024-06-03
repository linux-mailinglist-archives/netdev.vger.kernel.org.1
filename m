Return-Path: <netdev+bounces-100373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C6A8E7576
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A38285B03
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EB913C3EB;
	Mon,  3 Jun 2024 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SofPNvTM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664713BC38;
	Mon,  3 Jun 2024 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450385; cv=none; b=mdfA+ngktBoBguoHuZy+op9x+oO5pgE/ujkjCyAYKsvJzNBXzr7sC7zREHfCCbQ1S9SA9pY5GZYUHGq1mENIZM/NDGcBYcVCG0NlyPBVi6cAnz7EjxadPl5uT5f+nzF5pFwfCkdqiaF92uwu3n1Wf0avi7y2lDhS98+vQLq1HW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450385; c=relaxed/simple;
	bh=IRX9bS15i35u5Lzh5gYWwhiJj9f51+b0V4KCOmiUHrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnOVQAic1BrN9vE0eojIKXC4YqWbG4aFr4b3pkUGdNOyutXXlHY4IvJEAUyZszb/CSCoRJFB56zsUmlasyvhjIQf8VQF+jtldwRlZ9XnYt6G/GdEn3y0sWGR0fCQcA7MgBteW4pij0u/tQiISM6C/WldUtpVG+mWakhIT1cl8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SofPNvTM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717450383; x=1748986383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IRX9bS15i35u5Lzh5gYWwhiJj9f51+b0V4KCOmiUHrY=;
  b=SofPNvTMGgYpNYrZ90MdKu17ekO1wgW72+1+5K/JU01L1ncou75nKjd1
   vCu8NcpuQnRjJMivpJjKzM+8r7JOY31buKKBYKvXoZpgTOsxWIcPVMG4R
   eTxrwZsb3IbMHKpzFpCCIcyhfMO9ZnB7J0SICMKUQXcSqJICLj/Qj2nG5
   VRq7VIgySsxK4FFOqBQKFEvwdyn0zCzSKbcU0iyX+LNqNMWIUVHZSZwON
   0hNKlqGZuYHf/55UXhXicyXKA7PEcdfU3oS7zsgY9L9R2F5Vio5L23MLm
   zpTK2pyLNZcVWGEjM6LYveV3nLafNMljYpYBmgYDEOuy5S6k7JNA023yd
   A==;
X-CSE-ConnectionGUID: NjsM09liTFK01bT5lF2peQ==
X-CSE-MsgGUID: if43yT/TQAe53WzjctD1Bg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13841423"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13841423"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:33:03 -0700
X-CSE-ConnectionGUID: K6u+dh6NRp+yTamOVXLcKQ==
X-CSE-MsgGUID: H9QcPA1LTMyRI2OOPHRz3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37030752"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 03 Jun 2024 14:32:58 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEFIW-000MDX-0T;
	Mon, 03 Jun 2024 21:32:56 +0000
Date: Tue, 4 Jun 2024 05:27:54 +0800
From: kernel test robot <lkp@intel.com>
To: Yojana Mallik <y-mallik@ti.com>, schnelle@linux.ibm.com,
	wsa+renesas@sang-engineering.com, diogo.ivo@siemens.com,
	rdunlap@infradead.org, horms@kernel.org, vigneshr@ti.com,
	rogerq@ti.com, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, rogerq@kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: ethernet: ti: icve: Add support for
 multicast filtering
Message-ID: <202406040524.rKAgLczS-lkp@intel.com>
References: <20240531064006.1223417-4-y-mallik@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531064006.1223417-4-y-mallik@ti.com>

Hi Yojana,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Yojana-Mallik/net-ethernet-ti-RPMsg-based-shared-memory-ethernet-driver/20240531-144258
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240531064006.1223417-4-y-mallik%40ti.com
patch subject: [PATCH net-next v2 3/3] net: ethernet: ti: icve: Add support for multicast filtering
config: powerpc64-randconfig-r112-20240604 (https://download.01.org/0day-ci/archive/20240604/202406040524.rKAgLczS-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce: (https://download.01.org/0day-ci/archive/20240604/202406040524.rKAgLczS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406040524.rKAgLczS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/ti/inter_core_virt_eth.c:291:32: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/ti/inter_core_virt_eth.c:291:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got void * @@
   drivers/net/ethernet/ti/inter_core_virt_eth.c:291:32: sparse:     expected void const volatile [noderef] __iomem *s
   drivers/net/ethernet/ti/inter_core_virt_eth.c:291:32: sparse:     got void *
   drivers/net/ethernet/ti/inter_core_virt_eth.c:306:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:306:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got void * @@
   drivers/net/ethernet/ti/inter_core_virt_eth.c:306:32: sparse:     expected void const volatile [noderef] __iomem *s
   drivers/net/ethernet/ti/inter_core_virt_eth.c:306:32: sparse:     got void *
   drivers/net/ethernet/ti/inter_core_virt_eth.c:392:22: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/ti/inter_core_virt_eth.c:393:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void * @@
   drivers/net/ethernet/ti/inter_core_virt_eth.c:393:49: sparse:     expected void volatile [noderef] __iomem *d
   drivers/net/ethernet/ti/inter_core_virt_eth.c:393:49: sparse:     got void *
   drivers/net/ethernet/ti/inter_core_virt_eth.c:397:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:397:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void * @@
   drivers/net/ethernet/ti/inter_core_virt_eth.c:397:22: sparse:     expected void volatile [noderef] __iomem *d
   drivers/net/ethernet/ti/inter_core_virt_eth.c:397:22: sparse:     got void *
>> drivers/net/ethernet/ti/inter_core_virt_eth.c:496:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct icve_shm_buf [noderef] __iomem *buf @@     got void * @@
   drivers/net/ethernet/ti/inter_core_virt_eth.c:496:30: sparse:     expected struct icve_shm_buf [noderef] __iomem *buf
   drivers/net/ethernet/ti/inter_core_virt_eth.c:496:30: sparse:     got void *
   drivers/net/ethernet/ti/inter_core_virt_eth.c:510:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct icve_shm_buf [noderef] __iomem *buf @@     got void * @@
   drivers/net/ethernet/ti/inter_core_virt_eth.c:510:30: sparse:     expected struct icve_shm_buf [noderef] __iomem *buf
   drivers/net/ethernet/ti/inter_core_virt_eth.c:510:30: sparse:     got void *
   drivers/net/ethernet/ti/inter_core_virt_eth.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
>> drivers/net/ethernet/ti/inter_core_virt_eth.c:153:31: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:154:31: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:193:40: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:212:40: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:280:31: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:281:31: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:291:55: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:291:55: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:306:55: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:306:55: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:325:32: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:326:41: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:379:31: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:380:31: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:392:44: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:394:45: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:392:44: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:394:45: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:397:45: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:399:46: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:397:45: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:399:46: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:401:24: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/ti/inter_core_virt_eth.c:402:33: sparse: sparse: dereference of noderef expression

vim +/__iomem +291 drivers/net/ethernet/ti/inter_core_virt_eth.c

5655a9b008b088 Yojana Mallik    2024-05-31  145  
5655a9b008b088 Yojana Mallik    2024-05-31  146  static void icve_rx_timer(struct timer_list *timer)
5655a9b008b088 Yojana Mallik    2024-05-31  147  {
5655a9b008b088 Yojana Mallik    2024-05-31  148  	struct icve_port *port = from_timer(port, timer, rx_timer);
5655a9b008b088 Yojana Mallik    2024-05-31  149  	struct napi_struct *napi;
5655a9b008b088 Yojana Mallik    2024-05-31  150  	int num_pkts = 0;
5655a9b008b088 Yojana Mallik    2024-05-31  151  	u32 head, tail;
5655a9b008b088 Yojana Mallik    2024-05-31  152  
5655a9b008b088 Yojana Mallik    2024-05-31 @153  	head = port->rx_buffer->head->index;
5655a9b008b088 Yojana Mallik    2024-05-31  154  	tail = port->rx_buffer->tail->index;
5655a9b008b088 Yojana Mallik    2024-05-31  155  
5655a9b008b088 Yojana Mallik    2024-05-31  156  	num_pkts = tail - head;
5655a9b008b088 Yojana Mallik    2024-05-31  157  	num_pkts = num_pkts >= 0 ? num_pkts :
5655a9b008b088 Yojana Mallik    2024-05-31  158  				   (num_pkts + port->icve_rx_max_buffers);
5655a9b008b088 Yojana Mallik    2024-05-31  159  
5655a9b008b088 Yojana Mallik    2024-05-31  160  	napi = &port->rx_napi;
5655a9b008b088 Yojana Mallik    2024-05-31  161  	if (num_pkts && likely(napi_schedule_prep(napi)))
5655a9b008b088 Yojana Mallik    2024-05-31  162  		__napi_schedule(napi);
5655a9b008b088 Yojana Mallik    2024-05-31  163  	else
5655a9b008b088 Yojana Mallik    2024-05-31  164  		mod_timer(&port->rx_timer, RX_POLL_JIFFIES);
5655a9b008b088 Yojana Mallik    2024-05-31  165  }
5655a9b008b088 Yojana Mallik    2024-05-31  166  
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  167  static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  168  			 void *priv, u32 src)
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  169  {
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  170  	struct icve_common *common = dev_get_drvdata(&rpdev->dev);
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  171  	struct message *msg = (struct message *)data;
5655a9b008b088 Yojana Mallik    2024-05-31  172  	struct icve_port *port = common->port;
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  173  	u32 msg_type = msg->msg_hdr.msg_type;
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  174  	u32 rpmsg_type;
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  175  
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  176  	switch (msg_type) {
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  177  	case ICVE_REQUEST_MSG:
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  178  		rpmsg_type = msg->req_msg.type;
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  179  		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  180  			msg_type, rpmsg_type);
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  181  		break;
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  182  	case ICVE_RESPONSE_MSG:
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  183  		rpmsg_type = msg->resp_msg.type;
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  184  		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  185  			msg_type, rpmsg_type);
5655a9b008b088 Yojana Mallik    2024-05-31  186  		switch (rpmsg_type) {
5655a9b008b088 Yojana Mallik    2024-05-31  187  		case ICVE_RESP_SHM_INFO:
5655a9b008b088 Yojana Mallik    2024-05-31  188  			/* Retrieve Tx and Rx shared memory info from msg */
5655a9b008b088 Yojana Mallik    2024-05-31  189  			port->tx_buffer->head =
5655a9b008b088 Yojana Mallik    2024-05-31  190  				ioremap(msg->resp_msg.shm_info.shm_info_tx.base_addr,
5655a9b008b088 Yojana Mallik    2024-05-31  191  					sizeof(*port->tx_buffer->head));
5655a9b008b088 Yojana Mallik    2024-05-31  192  
5655a9b008b088 Yojana Mallik    2024-05-31  193  			port->tx_buffer->buf->base_addr =
5655a9b008b088 Yojana Mallik    2024-05-31  194  				ioremap((msg->resp_msg.shm_info.shm_info_tx.base_addr +
5655a9b008b088 Yojana Mallik    2024-05-31  195  					sizeof(*port->tx_buffer->head)),
5655a9b008b088 Yojana Mallik    2024-05-31  196  					(msg->resp_msg.shm_info.shm_info_tx.num_pkt_bufs *
5655a9b008b088 Yojana Mallik    2024-05-31  197  					 msg->resp_msg.shm_info.shm_info_tx.buff_slot_size));
5655a9b008b088 Yojana Mallik    2024-05-31  198  
5655a9b008b088 Yojana Mallik    2024-05-31  199  			port->tx_buffer->tail =
5655a9b008b088 Yojana Mallik    2024-05-31  200  				ioremap(msg->resp_msg.shm_info.shm_info_tx.base_addr +
5655a9b008b088 Yojana Mallik    2024-05-31  201  					sizeof(*port->tx_buffer->head) +
5655a9b008b088 Yojana Mallik    2024-05-31  202  					(msg->resp_msg.shm_info.shm_info_tx.num_pkt_bufs *
5655a9b008b088 Yojana Mallik    2024-05-31  203  					msg->resp_msg.shm_info.shm_info_tx.buff_slot_size),
5655a9b008b088 Yojana Mallik    2024-05-31  204  					sizeof(*port->tx_buffer->tail));
5655a9b008b088 Yojana Mallik    2024-05-31  205  
5655a9b008b088 Yojana Mallik    2024-05-31  206  			port->icve_tx_max_buffers = msg->resp_msg.shm_info.shm_info_tx.num_pkt_bufs;
5655a9b008b088 Yojana Mallik    2024-05-31  207  
5655a9b008b088 Yojana Mallik    2024-05-31  208  			port->rx_buffer->head =
5655a9b008b088 Yojana Mallik    2024-05-31  209  				ioremap(msg->resp_msg.shm_info.shm_info_rx.base_addr,
5655a9b008b088 Yojana Mallik    2024-05-31  210  					sizeof(*port->rx_buffer->head));
5655a9b008b088 Yojana Mallik    2024-05-31  211  
5655a9b008b088 Yojana Mallik    2024-05-31  212  			port->rx_buffer->buf->base_addr =
5655a9b008b088 Yojana Mallik    2024-05-31  213  				ioremap(msg->resp_msg.shm_info.shm_info_rx.base_addr +
5655a9b008b088 Yojana Mallik    2024-05-31  214  					sizeof(*port->rx_buffer->head),
5655a9b008b088 Yojana Mallik    2024-05-31  215  					(msg->resp_msg.shm_info.shm_info_rx.num_pkt_bufs *
5655a9b008b088 Yojana Mallik    2024-05-31  216  					 msg->resp_msg.shm_info.shm_info_rx.buff_slot_size));
5655a9b008b088 Yojana Mallik    2024-05-31  217  
5655a9b008b088 Yojana Mallik    2024-05-31  218  			port->rx_buffer->tail =
5655a9b008b088 Yojana Mallik    2024-05-31  219  				ioremap(msg->resp_msg.shm_info.shm_info_rx.base_addr +
5655a9b008b088 Yojana Mallik    2024-05-31  220  					sizeof(*port->rx_buffer->head) +
5655a9b008b088 Yojana Mallik    2024-05-31  221  					(msg->resp_msg.shm_info.shm_info_rx.num_pkt_bufs *
5655a9b008b088 Yojana Mallik    2024-05-31  222  					msg->resp_msg.shm_info.shm_info_rx.buff_slot_size),
5655a9b008b088 Yojana Mallik    2024-05-31  223  					sizeof(*port->rx_buffer->tail));
5655a9b008b088 Yojana Mallik    2024-05-31  224  
5655a9b008b088 Yojana Mallik    2024-05-31  225  			port->icve_rx_max_buffers =
5655a9b008b088 Yojana Mallik    2024-05-31  226  				msg->resp_msg.shm_info.shm_info_rx.num_pkt_bufs;
5655a9b008b088 Yojana Mallik    2024-05-31  227  
5655a9b008b088 Yojana Mallik    2024-05-31  228  			mutex_lock(&common->state_lock);
5655a9b008b088 Yojana Mallik    2024-05-31  229  			common->state = ICVE_STATE_READY;
5655a9b008b088 Yojana Mallik    2024-05-31  230  			mutex_unlock(&common->state_lock);
5655a9b008b088 Yojana Mallik    2024-05-31  231  
5655a9b008b088 Yojana Mallik    2024-05-31  232  			mod_delayed_work(system_wq,
5655a9b008b088 Yojana Mallik    2024-05-31  233  					 &common->state_work,
5655a9b008b088 Yojana Mallik    2024-05-31  234  					 STATE_MACHINE_TIME);
5655a9b008b088 Yojana Mallik    2024-05-31  235  
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  236  			break;
5655a9b008b088 Yojana Mallik    2024-05-31  237  		case ICVE_RESP_SET_MAC_ADDR:
5655a9b008b088 Yojana Mallik    2024-05-31  238  			break;
9ebbebae44242d Yojana Mallik    2024-05-31  239  		case ICVE_RESP_ADD_MC_ADDR:
9ebbebae44242d Yojana Mallik    2024-05-31  240  		case ICVE_RESP_DEL_MC_ADDR:
9ebbebae44242d Yojana Mallik    2024-05-31  241  			complete(&common->sync_msg);
9ebbebae44242d Yojana Mallik    2024-05-31  242  			break;
5655a9b008b088 Yojana Mallik    2024-05-31  243  		}
5655a9b008b088 Yojana Mallik    2024-05-31  244  
5655a9b008b088 Yojana Mallik    2024-05-31  245  		break;
5655a9b008b088 Yojana Mallik    2024-05-31  246  
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  247  	case ICVE_NOTIFY_MSG:
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  248  		rpmsg_type = msg->notify_msg.type;
5655a9b008b088 Yojana Mallik    2024-05-31  249  		switch (rpmsg_type) {
5655a9b008b088 Yojana Mallik    2024-05-31  250  		case ICVE_NOTIFY_REMOTE_READY:
5655a9b008b088 Yojana Mallik    2024-05-31  251  			mutex_lock(&common->state_lock);
5655a9b008b088 Yojana Mallik    2024-05-31  252  			common->state = ICVE_STATE_RUNNING;
5655a9b008b088 Yojana Mallik    2024-05-31  253  			mutex_unlock(&common->state_lock);
5655a9b008b088 Yojana Mallik    2024-05-31  254  
5655a9b008b088 Yojana Mallik    2024-05-31  255  			mod_delayed_work(system_wq,
5655a9b008b088 Yojana Mallik    2024-05-31  256  					 &common->state_work,
5655a9b008b088 Yojana Mallik    2024-05-31  257  					 STATE_MACHINE_TIME);
5655a9b008b088 Yojana Mallik    2024-05-31  258  			break;
5655a9b008b088 Yojana Mallik    2024-05-31  259  		case ICVE_NOTIFY_PORT_UP:
5655a9b008b088 Yojana Mallik    2024-05-31  260  		case ICVE_NOTIFY_PORT_DOWN:
5655a9b008b088 Yojana Mallik    2024-05-31  261  			break;
5655a9b008b088 Yojana Mallik    2024-05-31  262  		}
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  263  		break;
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  264  	default:
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  265  		dev_err(common->dev, "Invalid msg type\n");
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  266  		break;
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  267  	}
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  268  	return 0;
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  269  }
c7f4ad97418d24 Ravi Gunasekaran 2024-05-31  270  
5655a9b008b088 Yojana Mallik    2024-05-31  271  static int icve_rx_packets(struct napi_struct *napi, int budget)
5655a9b008b088 Yojana Mallik    2024-05-31  272  {
5655a9b008b088 Yojana Mallik    2024-05-31  273  	struct icve_port *port = container_of(napi, struct icve_port, rx_napi);
5655a9b008b088 Yojana Mallik    2024-05-31  274  	u32 count, process_pkts;
5655a9b008b088 Yojana Mallik    2024-05-31  275  	struct sk_buff *skb;
5655a9b008b088 Yojana Mallik    2024-05-31  276  	u32 head, tail;
5655a9b008b088 Yojana Mallik    2024-05-31  277  	int num_pkts;
5655a9b008b088 Yojana Mallik    2024-05-31  278  	u32 pkt_len;
5655a9b008b088 Yojana Mallik    2024-05-31  279  
5655a9b008b088 Yojana Mallik    2024-05-31  280  	head = port->rx_buffer->head->index;
5655a9b008b088 Yojana Mallik    2024-05-31  281  	tail = port->rx_buffer->tail->index;
5655a9b008b088 Yojana Mallik    2024-05-31  282  
5655a9b008b088 Yojana Mallik    2024-05-31  283  	num_pkts = head - tail;
5655a9b008b088 Yojana Mallik    2024-05-31  284  
5655a9b008b088 Yojana Mallik    2024-05-31  285  	num_pkts = num_pkts >= 0 ? num_pkts :
5655a9b008b088 Yojana Mallik    2024-05-31  286  				   (num_pkts + port->icve_rx_max_buffers);
5655a9b008b088 Yojana Mallik    2024-05-31  287  	process_pkts = min(num_pkts, budget);
5655a9b008b088 Yojana Mallik    2024-05-31  288  	count = 0;
5655a9b008b088 Yojana Mallik    2024-05-31  289  	while (count < process_pkts) {
5655a9b008b088 Yojana Mallik    2024-05-31  290  		memcpy_fromio((void *)&pkt_len,
5655a9b008b088 Yojana Mallik    2024-05-31 @291  			      (void *)(port->rx_buffer->buf->base_addr +
5655a9b008b088 Yojana Mallik    2024-05-31  292  			      MAGIC_NUM_SIZE_TYPE +
5655a9b008b088 Yojana Mallik    2024-05-31  293  			      (((tail + count) % port->icve_rx_max_buffers) *
5655a9b008b088 Yojana Mallik    2024-05-31  294  			      ICVE_BUFFER_SIZE)),
5655a9b008b088 Yojana Mallik    2024-05-31  295  			      PKT_LEN_SIZE_TYPE);
5655a9b008b088 Yojana Mallik    2024-05-31  296  		/* Start building the skb */
5655a9b008b088 Yojana Mallik    2024-05-31  297  		skb = napi_alloc_skb(napi, pkt_len);
5655a9b008b088 Yojana Mallik    2024-05-31  298  		if (!skb) {
5655a9b008b088 Yojana Mallik    2024-05-31  299  			port->ndev->stats.rx_dropped++;
5655a9b008b088 Yojana Mallik    2024-05-31  300  			goto rx_dropped;
5655a9b008b088 Yojana Mallik    2024-05-31  301  		}
5655a9b008b088 Yojana Mallik    2024-05-31  302  
5655a9b008b088 Yojana Mallik    2024-05-31  303  		skb->dev = port->ndev;
5655a9b008b088 Yojana Mallik    2024-05-31  304  		skb_put(skb, pkt_len);
5655a9b008b088 Yojana Mallik    2024-05-31  305  		memcpy_fromio((void *)skb->data,
5655a9b008b088 Yojana Mallik    2024-05-31  306  			      (void *)(port->rx_buffer->buf->base_addr +
5655a9b008b088 Yojana Mallik    2024-05-31  307  			      PKT_LEN_SIZE_TYPE + MAGIC_NUM_SIZE_TYPE +
5655a9b008b088 Yojana Mallik    2024-05-31  308  			      (((tail + count) % port->icve_rx_max_buffers) *
5655a9b008b088 Yojana Mallik    2024-05-31  309  			      ICVE_BUFFER_SIZE)),
5655a9b008b088 Yojana Mallik    2024-05-31  310  			      pkt_len);
5655a9b008b088 Yojana Mallik    2024-05-31  311  
5655a9b008b088 Yojana Mallik    2024-05-31  312  		skb->protocol = eth_type_trans(skb, port->ndev);
5655a9b008b088 Yojana Mallik    2024-05-31  313  
5655a9b008b088 Yojana Mallik    2024-05-31  314  		/* Push skb into network stack */
5655a9b008b088 Yojana Mallik    2024-05-31  315  		napi_gro_receive(napi, skb);
5655a9b008b088 Yojana Mallik    2024-05-31  316  
5655a9b008b088 Yojana Mallik    2024-05-31  317  		count++;
5655a9b008b088 Yojana Mallik    2024-05-31  318  		port->ndev->stats.rx_packets++;
5655a9b008b088 Yojana Mallik    2024-05-31  319  		port->ndev->stats.rx_bytes += skb->len;
5655a9b008b088 Yojana Mallik    2024-05-31  320  	}
5655a9b008b088 Yojana Mallik    2024-05-31  321  
5655a9b008b088 Yojana Mallik    2024-05-31  322  rx_dropped:
5655a9b008b088 Yojana Mallik    2024-05-31  323  
5655a9b008b088 Yojana Mallik    2024-05-31  324  	if (num_pkts) {
5655a9b008b088 Yojana Mallik    2024-05-31  325  		port->rx_buffer->tail->index =
5655a9b008b088 Yojana Mallik    2024-05-31  326  			(port->rx_buffer->tail->index + count) %
5655a9b008b088 Yojana Mallik    2024-05-31  327  			port->icve_rx_max_buffers;
5655a9b008b088 Yojana Mallik    2024-05-31  328  
5655a9b008b088 Yojana Mallik    2024-05-31  329  		if (num_pkts < budget && napi_complete_done(napi, count))
5655a9b008b088 Yojana Mallik    2024-05-31  330  			mod_timer(&port->rx_timer, RX_POLL_TIMEOUT);
5655a9b008b088 Yojana Mallik    2024-05-31  331  	}
5655a9b008b088 Yojana Mallik    2024-05-31  332  
5655a9b008b088 Yojana Mallik    2024-05-31  333  	return count;
5655a9b008b088 Yojana Mallik    2024-05-31  334  }
5655a9b008b088 Yojana Mallik    2024-05-31  335  
5655a9b008b088 Yojana Mallik    2024-05-31  336  static int icve_ndo_open(struct net_device *ndev)
5655a9b008b088 Yojana Mallik    2024-05-31  337  {
5655a9b008b088 Yojana Mallik    2024-05-31  338  	struct icve_common *common = icve_ndev_to_common(ndev);
5655a9b008b088 Yojana Mallik    2024-05-31  339  
5655a9b008b088 Yojana Mallik    2024-05-31  340  	mutex_lock(&common->state_lock);
5655a9b008b088 Yojana Mallik    2024-05-31  341  	common->state = ICVE_STATE_OPEN;
5655a9b008b088 Yojana Mallik    2024-05-31  342  	mutex_unlock(&common->state_lock);
5655a9b008b088 Yojana Mallik    2024-05-31  343  	mod_delayed_work(system_wq, &common->state_work, msecs_to_jiffies(100));
5655a9b008b088 Yojana Mallik    2024-05-31  344  
5655a9b008b088 Yojana Mallik    2024-05-31  345  	return 0;
5655a9b008b088 Yojana Mallik    2024-05-31  346  }
5655a9b008b088 Yojana Mallik    2024-05-31  347  
5655a9b008b088 Yojana Mallik    2024-05-31  348  static int icve_ndo_stop(struct net_device *ndev)
5655a9b008b088 Yojana Mallik    2024-05-31  349  {
5655a9b008b088 Yojana Mallik    2024-05-31  350  	struct icve_common *common = icve_ndev_to_common(ndev);
5655a9b008b088 Yojana Mallik    2024-05-31  351  	struct icve_port *port = icve_ndev_to_port(ndev);
5655a9b008b088 Yojana Mallik    2024-05-31  352  
5655a9b008b088 Yojana Mallik    2024-05-31  353  	mutex_lock(&common->state_lock);
5655a9b008b088 Yojana Mallik    2024-05-31  354  	common->state = ICVE_STATE_CLOSE;
5655a9b008b088 Yojana Mallik    2024-05-31  355  	mutex_unlock(&common->state_lock);
5655a9b008b088 Yojana Mallik    2024-05-31  356  
5655a9b008b088 Yojana Mallik    2024-05-31  357  	netif_carrier_off(port->ndev);
5655a9b008b088 Yojana Mallik    2024-05-31  358  
5655a9b008b088 Yojana Mallik    2024-05-31  359  	__dev_mc_unsync(ndev, icve_del_mc_addr);
5655a9b008b088 Yojana Mallik    2024-05-31  360  	__hw_addr_init(&common->mc_list);
5655a9b008b088 Yojana Mallik    2024-05-31  361  
5655a9b008b088 Yojana Mallik    2024-05-31  362  	cancel_delayed_work_sync(&common->state_work);
5655a9b008b088 Yojana Mallik    2024-05-31  363  	del_timer_sync(&port->rx_timer);
5655a9b008b088 Yojana Mallik    2024-05-31  364  	napi_disable(&port->rx_napi);
5655a9b008b088 Yojana Mallik    2024-05-31  365  
5655a9b008b088 Yojana Mallik    2024-05-31  366  	cancel_work_sync(&common->rx_mode_work);
5655a9b008b088 Yojana Mallik    2024-05-31  367  
5655a9b008b088 Yojana Mallik    2024-05-31  368  	return 0;
5655a9b008b088 Yojana Mallik    2024-05-31  369  }
5655a9b008b088 Yojana Mallik    2024-05-31  370  
5655a9b008b088 Yojana Mallik    2024-05-31  371  static netdev_tx_t icve_start_xmit(struct sk_buff *skb, struct net_device *ndev)
5655a9b008b088 Yojana Mallik    2024-05-31  372  {
5655a9b008b088 Yojana Mallik    2024-05-31  373  	struct icve_port *port = icve_ndev_to_port(ndev);
5655a9b008b088 Yojana Mallik    2024-05-31  374  	u32 head, tail;
5655a9b008b088 Yojana Mallik    2024-05-31  375  	int num_pkts;
5655a9b008b088 Yojana Mallik    2024-05-31  376  	u32 len;
5655a9b008b088 Yojana Mallik    2024-05-31  377  
5655a9b008b088 Yojana Mallik    2024-05-31  378  	len = skb_headlen(skb);
5655a9b008b088 Yojana Mallik    2024-05-31  379  	head = port->tx_buffer->head->index;
5655a9b008b088 Yojana Mallik    2024-05-31  380  	tail = port->tx_buffer->tail->index;
5655a9b008b088 Yojana Mallik    2024-05-31  381  
5655a9b008b088 Yojana Mallik    2024-05-31  382  	/* If the buffer queue is full, then drop packet */
5655a9b008b088 Yojana Mallik    2024-05-31  383  	num_pkts = head - tail;
5655a9b008b088 Yojana Mallik    2024-05-31  384  	num_pkts = num_pkts >= 0 ? num_pkts :
5655a9b008b088 Yojana Mallik    2024-05-31  385  				   (num_pkts + port->icve_tx_max_buffers);
5655a9b008b088 Yojana Mallik    2024-05-31  386  
5655a9b008b088 Yojana Mallik    2024-05-31  387  	if ((num_pkts + 1) == port->icve_tx_max_buffers) {
5655a9b008b088 Yojana Mallik    2024-05-31  388  		netdev_warn(ndev, "Tx buffer full %d\n", num_pkts);
5655a9b008b088 Yojana Mallik    2024-05-31  389  		goto ring_full;
5655a9b008b088 Yojana Mallik    2024-05-31  390  	}
5655a9b008b088 Yojana Mallik    2024-05-31  391  	/* Copy length */
5655a9b008b088 Yojana Mallik    2024-05-31  392  	memcpy_toio((void *)port->tx_buffer->buf->base_addr +
5655a9b008b088 Yojana Mallik    2024-05-31 @393  			    MAGIC_NUM_SIZE_TYPE +
5655a9b008b088 Yojana Mallik    2024-05-31  394  			    (port->tx_buffer->head->index * ICVE_BUFFER_SIZE),
5655a9b008b088 Yojana Mallik    2024-05-31  395  		    (void *)&len, PKT_LEN_SIZE_TYPE);
5655a9b008b088 Yojana Mallik    2024-05-31  396  	/* Copy data to shared mem */
5655a9b008b088 Yojana Mallik    2024-05-31  397  	memcpy_toio((void *)(port->tx_buffer->buf->base_addr +
5655a9b008b088 Yojana Mallik    2024-05-31  398  			     MAGIC_NUM_SIZE_TYPE + PKT_LEN_SIZE_TYPE +
5655a9b008b088 Yojana Mallik    2024-05-31  399  			     (port->tx_buffer->head->index * ICVE_BUFFER_SIZE)),
5655a9b008b088 Yojana Mallik    2024-05-31  400  		    (void *)skb->data, len);
5655a9b008b088 Yojana Mallik    2024-05-31  401  	port->tx_buffer->head->index =
5655a9b008b088 Yojana Mallik    2024-05-31  402  		(port->tx_buffer->head->index + 1) % port->icve_tx_max_buffers;
5655a9b008b088 Yojana Mallik    2024-05-31  403  
5655a9b008b088 Yojana Mallik    2024-05-31  404  	ndev->stats.tx_packets++;
5655a9b008b088 Yojana Mallik    2024-05-31  405  	ndev->stats.tx_bytes += skb->len;
5655a9b008b088 Yojana Mallik    2024-05-31  406  
5655a9b008b088 Yojana Mallik    2024-05-31  407  	dev_consume_skb_any(skb);
5655a9b008b088 Yojana Mallik    2024-05-31  408  	return NETDEV_TX_OK;
5655a9b008b088 Yojana Mallik    2024-05-31  409  
5655a9b008b088 Yojana Mallik    2024-05-31  410  ring_full:
5655a9b008b088 Yojana Mallik    2024-05-31  411  	return NETDEV_TX_BUSY;
5655a9b008b088 Yojana Mallik    2024-05-31  412  }
5655a9b008b088 Yojana Mallik    2024-05-31  413  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

