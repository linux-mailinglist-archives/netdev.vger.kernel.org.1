Return-Path: <netdev+bounces-270794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD/mOqvDwWkHWQQAu9opvQ
	(envelope-from <netdev+bounces-270794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:50:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99C2FE874
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7C0830D9A57
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBFA3806C8;
	Mon, 23 Mar 2026 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNt48Foh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732E8383C60;
	Mon, 23 Mar 2026 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305925; cv=none; b=G0YkJC/VUmxU07UXQqDSrHJlrJ8kNhbAgjNomp+ASHdA4IhjjKgETGJfSfLCWZmtYiJMZbUU0+xMYOHTTVFoQNarUDNPQjVbxaFAl7iBshz08LevvTLKS6EjNZBjQaP1Aw3tu/rdFh7qjyhWpv7u6ghLL+PxFG4KnH9konprRrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305925; c=relaxed/simple;
	bh=/4U+DFZaun0U2N53e9WcUbM+CfTDtWxXba3EGX9WYho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W86HP/fgCMF+kQ0J8u/kfj15w1gvkgJRhWq7KMmW9FsabmwTiUSziFcah/iRtRBFKbZ1T7CBifXzw4yXCUTt27NUJovtHE121LmxkFIt2S6gUyBhOyL5ZxvAFA80PczU8UhbDC8MBJKIMi2VEsEsT+AKaFSwFMHve+xrU7VzAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNt48Foh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774305924; x=1805841924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/4U+DFZaun0U2N53e9WcUbM+CfTDtWxXba3EGX9WYho=;
  b=eNt48FohUSxbDMUryFkoHmfE2HAlZkxUNNjgSK9bdnX3W28lJqJ2e/eH
   Gp89JxjBauHQ9NdCoH0XUh7+u/2/7vV8kd00nMR6UrzikKOm4CBEpgGxP
   pDh79NpnnFsMG/jwBAClhjtCLcKu8YvBB/QFmagCHr53JbCKeIhBRFT2f
   ctSmm5cf54oU3DrNiwxqhF0J+pr4SGCDiw1LbAM2UH1w77Cgokx3qqfeS
   V/NRs7dHtTw4tKu5cP57EbG85jyKpr0rSybQmhKwPgaYhQwz/EvooDdAG
   hdzFSESwiSG/NMW2k1zqpPGbA4eRnyqEXm9EMIc0N8P06nEPUXR0q0VZw
   w==;
X-CSE-ConnectionGUID: ouUa9bfXTFmpCsr+Ue8W6Q==
X-CSE-MsgGUID: DhGU+LwRRxO7Rm5zQMXxBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86685062"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86685062"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:45:23 -0700
X-CSE-ConnectionGUID: SwX5nIW0Tzan2DLFVEoosA==
X-CSE-MsgGUID: ILsyuvz8T9SoqJKqlQl9Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="262083210"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Mar 2026 15:45:20 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4o1M-000000003LU-13Qd;
	Mon, 23 Mar 2026 22:45:16 +0000
Date: Tue, 24 Mar 2026 06:44:20 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Johansen <john.johansen@canonical.com>,
	Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com,
	stable@kernel.org
Subject: Re: [PATCH net v2 04/10] list: Move on_list_rcu() to list.h and add
 on_list() also
Message-ID: <202603240630.eCfHPMhL-lkp@intel.com>
References: <20260323150505.3513839-5-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323150505.3513839-5-dhowells@redhat.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270794-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 4F99C2FE874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Howells/rxrpc-Fix-key-quota-calculation-for-multitoken-keys/20260323-234846
base:   net/main
patch link:    https://lore.kernel.org/r/20260323150505.3513839-5-dhowells%40redhat.com
patch subject: [PATCH net v2 04/10] list: Move on_list_rcu() to list.h and add on_list() also
config: arm-randconfig-004-20260324 (https://download.01.org/0day-ci/archive/20260324/202603240630.eCfHPMhL-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 054e11d1a17e5ba88bb1a8ef32fad3346e80b186)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260324/202603240630.eCfHPMhL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603240630.eCfHPMhL-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/dwc2/gadget.c:4313:13: error: conflicting types for 'on_list'
    4313 | static bool on_list(struct dwc2_hsotg_ep *ep, struct dwc2_hsotg_req *test)
         |             ^
   include/linux/list.h:392:20: note: previous definition is here
     392 | static inline bool on_list(const struct list_head *entry)
         |                    ^
>> drivers/usb/dwc2/gadget.c:4341:22: error: too many arguments to function call, expected single argument 'entry', have 2 arguments
    4341 |         if (!on_list(hs_ep, hs_req)) {
         |              ~~~~~~~        ^~~~~~
   include/linux/list.h:392:20: note: 'on_list' declared here
     392 | static inline bool on_list(const struct list_head *entry)
         |                    ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/entry +4341 drivers/usb/dwc2/gadget.c

5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4324  
8b9bc4608eefeb drivers/usb/gadget/s3c-hsotg.c Lukasz Majewski    2012-05-04  4325  /**
1f91b4cc03556b drivers/usb/dwc2/gadget.c      Felipe Balbi       2015-08-06  4326   * dwc2_hsotg_ep_dequeue - dequeue given endpoint
8b9bc4608eefeb drivers/usb/gadget/s3c-hsotg.c Lukasz Majewski    2012-05-04  4327   * @ep: The endpoint to dequeue.
8b9bc4608eefeb drivers/usb/gadget/s3c-hsotg.c Lukasz Majewski    2012-05-04  4328   * @req: The request to be removed from a queue.
8b9bc4608eefeb drivers/usb/gadget/s3c-hsotg.c Lukasz Majewski    2012-05-04  4329   */
1f91b4cc03556b drivers/usb/dwc2/gadget.c      Felipe Balbi       2015-08-06  4330  static int dwc2_hsotg_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4331  {
1f91b4cc03556b drivers/usb/dwc2/gadget.c      Felipe Balbi       2015-08-06  4332  	struct dwc2_hsotg_req *hs_req = our_req(req);
1f91b4cc03556b drivers/usb/dwc2/gadget.c      Felipe Balbi       2015-08-06  4333  	struct dwc2_hsotg_ep *hs_ep = our_ep(ep);
941fcce4ff6701 drivers/usb/dwc2/gadget.c      Dinh Nguyen        2014-11-11  4334  	struct dwc2_hsotg *hs = hs_ep->parent;
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4335  	unsigned long flags;
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4336  
1e01129373f757 drivers/usb/dwc2/gadget.c      Marek Szyprowski   2014-09-09  4337  	dev_dbg(hs->dev, "ep_dequeue(%p,%p)\n", ep, req);
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4338  
22258f4906aa87 drivers/usb/gadget/s3c-hsotg.c Lukasz Majewski    2012-06-14  4339  	spin_lock_irqsave(&hs->lock, flags);
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4340  
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02 @4341  	if (!on_list(hs_ep, hs_req)) {
22258f4906aa87 drivers/usb/gadget/s3c-hsotg.c Lukasz Majewski    2012-06-14  4342  		spin_unlock_irqrestore(&hs->lock, flags);
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4343  		return -EINVAL;
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4344  	}
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4345  
c524dd5f432a06 drivers/usb/dwc2/gadget.c      Mian Yousaf Kaukab 2015-09-29  4346  	/* Dequeue already started request */
c524dd5f432a06 drivers/usb/dwc2/gadget.c      Mian Yousaf Kaukab 2015-09-29  4347  	if (req == &hs_ep->req->req)
c524dd5f432a06 drivers/usb/dwc2/gadget.c      Mian Yousaf Kaukab 2015-09-29  4348  		dwc2_hsotg_ep_stop_xfr(hs, hs_ep);
c524dd5f432a06 drivers/usb/dwc2/gadget.c      Mian Yousaf Kaukab 2015-09-29  4349  
1f91b4cc03556b drivers/usb/dwc2/gadget.c      Felipe Balbi       2015-08-06  4350  	dwc2_hsotg_complete_request(hs, hs_ep, hs_req, -ECONNRESET);
22258f4906aa87 drivers/usb/gadget/s3c-hsotg.c Lukasz Majewski    2012-06-14  4351  	spin_unlock_irqrestore(&hs->lock, flags);
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4352  
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4353  	return 0;
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4354  }
5b7d70c6dbf2db drivers/usb/gadget/s3c-hsotg.c Ben Dooks          2009-06-02  4355  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

