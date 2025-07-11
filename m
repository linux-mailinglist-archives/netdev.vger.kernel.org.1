Return-Path: <netdev+bounces-206071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D4CB013E8
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 08:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884711C800C2
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 06:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A7C1C84A1;
	Fri, 11 Jul 2025 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bG9qiKML"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D61D9346;
	Fri, 11 Jul 2025 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216719; cv=none; b=P4VRWc/fZ2TfNgiGOX8qxKBi21IVXUr31UWK+UGUvHuleaGDl35x9Olx229uKKs9WVq1IuamOmURe/CriWW/SWXUz7g9qYFDDhnlT9MrVbDDr9yx9U+BxzD1PmjRlIzyk3kXkshUqGINVMzB43Fo9aORUlL6XM6S0662a3W+F3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216719; c=relaxed/simple;
	bh=zFQ/bChWZuVEShHSqJvL2qUiqDh9aSarT39gvLI3hyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pyg2ypbnpmryEivpcXfOW0HtDdIUe2ho1KJYP/UYDHc7H3BVUnSAE57V4lSMAwIIp69VYcZePHTJ3AvHhmvxXipJMvXIU6rNFeaQw4F8pKlsBWTePghZ1fBY4DTwJ36Ti07RRm/vKkIA6yeoRC2/8TgMk68aIxP3oIIt11ZuEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bG9qiKML; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752216717; x=1783752717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFQ/bChWZuVEShHSqJvL2qUiqDh9aSarT39gvLI3hyY=;
  b=bG9qiKMLxeh2RHkZpAOzGjwyrE7ggA3/+qcHAKcJLqIGFsVlKauhIsGr
   oVRdc5M+MgBL4n3yJyjHr3ymsEJPye38mpv+JcYvUqveLL/oU7GhKIx4H
   Yt0LZVfN+cBQOu+VG4whvqUUt2dTTPp+shLwZBAUUY6i6Sh7QV2N/eUyw
   WuSKAULXkGmyDdBj1f9mOLge4z/NibD2Gdkyfes+zJYP7VFOJtg2V9LdM
   7WwLRtcTr1JDcvioBUf7OW1Gq8qbRi8LduBGYee/cZFBHpQ2bE5H0vumM
   iTWkZCJO26TTHXoszSt26zJbJtVn9HpEfjooX+KO5nxWY9ue+lxKH37qi
   g==;
X-CSE-ConnectionGUID: Kpsjw3uNQcuPc9pdSkhzGQ==
X-CSE-MsgGUID: exYbGIqzTIqpfROAgQcygQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65211880"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65211880"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:51:57 -0700
X-CSE-ConnectionGUID: iJJB9U6bSoShYz0pOzh9qg==
X-CSE-MsgGUID: 9H7fL2O/TOiNrHrJ3Pt72w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="155704261"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Jul 2025 23:51:52 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua7bp-000611-27;
	Fri, 11 Jul 2025 06:51:49 +0000
Date: Fri, 11 Jul 2025 14:51:25 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v22 1/2] mailbox/pcc: support mailbox management
 of the shared buffer
Message-ID: <202507111440.1zQdhxpr-lkp@intel.com>
References: <20250710191209.737167-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710191209.737167-2-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mailbox-pcc-support-mailbox-management-of-the-shared-buffer/20250711-031525
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250710191209.737167-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH net-next v22 1/2] mailbox/pcc: support mailbox management of the shared buffer
config: i386-randconfig-014-20250711 (https://download.01.org/0day-ci/archive/20250711/202507111440.1zQdhxpr-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507111440.1zQdhxpr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507111440.1zQdhxpr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mailbox/pcc.c:496:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     496 |         if (pchan->chan.rx_alloc)
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/mailbox/pcc.c:498:6: note: uninitialized use occurs here
     498 |         if (ret)
         |             ^~~
   drivers/mailbox/pcc.c:496:2: note: remove the 'if' if its condition is always true
     496 |         if (pchan->chan.rx_alloc)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
     497 |                 ret = pcc_write_to_buffer(chan, data);
   drivers/mailbox/pcc.c:492:9: note: initialize the variable 'ret' to silence this warning
     492 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +496 drivers/mailbox/pcc.c

   476	
   477	
   478	/**
   479	 * pcc_send_data - Called from Mailbox Controller code. Used
   480	 *		here only to ring the channel doorbell. The PCC client
   481	 *		specific read/write is done in the client driver in
   482	 *		order to maintain atomicity over PCC channel once
   483	 *		OS has control over it. See above for flow of operations.
   484	 * @chan: Pointer to Mailbox channel over which to send data.
   485	 * @data: Client specific data written over channel. Used here
   486	 *		only for debug after PCC transaction completes.
   487	 *
   488	 * Return: Err if something failed else 0 for success.
   489	 */
   490	static int pcc_send_data(struct mbox_chan *chan, void *data)
   491	{
   492		int ret;
   493		struct pcc_chan_info *pchan = chan->con_priv;
   494		struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_hdr;
   495	
 > 496		if (pchan->chan.rx_alloc)
   497			ret = pcc_write_to_buffer(chan, data);
   498		if (ret)
   499			return ret;
   500	
   501		ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
   502		if (ret)
   503			return ret;
   504	
   505		pcc_hdr = pchan->chan.shmem;
   506		if (ioread32(&pcc_hdr->flags) & PCC_CMD_COMPLETION_NOTIFY)
   507			pchan->chan.irq_ack = true;
   508	
   509		ret = pcc_chan_reg_read_modify_write(&pchan->db);
   510	
   511		if (!ret && pchan->plat_irq > 0)
   512			pchan->chan_in_use = true;
   513	
   514		return ret;
   515	}
   516	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

