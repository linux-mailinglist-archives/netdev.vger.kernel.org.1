Return-Path: <netdev+bounces-285476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMKzOb7u/GkjVgAAu9opvQ
	(envelope-from <netdev+bounces-285476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 21:57:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EBD4EE2FB
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 21:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B01F0302DA13
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251D4481AA0;
	Thu,  7 May 2026 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8LIwPDG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96628480DCA;
	Thu,  7 May 2026 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778183863; cv=none; b=G5tmraYtWR4PpRSv379XSWrYJSjj3WY+2lfnnbwkRWX9kxHqZaZ1OljoJ+2NIvZ80aUmV6TDN9bRkEwxCtuLootTLKo8ip8OpWqST+hzmeFjez6EjNOtwTzOmy3AepRVA16JkqeN8tsEJKLevYLJQBvB4c3OkrTzBSz5+7T40B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778183863; c=relaxed/simple;
	bh=FM3JyjULX1lnlZXdQ5PBZlEcLXNCfI0RfxPxmmxvNMg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fVRJsnyQ4hCo9Dk3nNQRz+Osh5J/UIisBAeu0UyHvdU57BlICQfSQEL9ehMPobAZV8x1MLDj/So5j/N4rJ208j9Bmzn+MIrav+isq1/t/cDq0KsH0LS/WdLdNfHe/v14XJb2JX5x5Aibp4K7/IBlAzparVLBKBoCj1KD416BKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8LIwPDG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778183861; x=1809719861;
  h=date:from:to:cc:subject:message-id;
  bh=FM3JyjULX1lnlZXdQ5PBZlEcLXNCfI0RfxPxmmxvNMg=;
  b=D8LIwPDGQTu5KObbo2/SXPEQzHbNYDcW4KeF5LPFO8kmYmm0xuapfdd6
   4Ue68QR0Mlv0e2lxzKmiAul3t616nW7/TX1HMTXn8AbH4HHnMwBiFf7L/
   9IPXWokSHzwZ2RTm+TyaH4VEGZDKcr860zfl3RkrxVpS9pBFAAlc82ZjC
   23408aEz1S9R9jZYXa6ZN6/nlutH1VXhJgtAXlYqaSjJxm9shoUhYighw
   uIqPA8b+du2qjzWiauV4EUNbkJUusKb6ejr3zlrKmtGi56LiAwV7YYtcG
   pH8EiCOx/bdoGxkAshbNKr6ZevNf8nQzMV7MAhs6hSAevHaq1qM0cJXmR
   Q==;
X-CSE-ConnectionGUID: Djgjx+DeT+CsJ+F5GCyZAg==
X-CSE-MsgGUID: b9rOGilfTOij3KDrCsNypw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89843716"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="89843716"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 12:57:39 -0700
X-CSE-ConnectionGUID: I+tRP0nlSeq5mV0tNF4FlQ==
X-CSE-MsgGUID: 217bik8QQIKLZ+7A8FhSDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="240549811"
Received: from lkp-server01.sh.intel.com (HELO d6e19f2f5857) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2026 12:57:37 -0700
Received: from kbuild by d6e19f2f5857 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wL4ql-000000000Pd-0Exh;
	Thu, 07 May 2026 19:57:35 +0000
Date: Fri, 08 May 2026 03:56:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [mst-vhost:balloon 4/30] Warning: mm/mempolicy.c:2527
 expecting prototype for vma_alloc_folio(). Prototype was for
 alloc_frozen_pages() instead
Message-ID: <202605080331.y1eIdVUC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 89EBD4EE2FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285476-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
head:   9f56ee36fbf6a6d336dc6a9eaeb4f8a67cb42a31
commit: 95744e0e9c4df79c6bc8ec96306b29c7a8e8984e [4/30] mm: move vma_alloc_folio to page_alloc.c
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260508/202605080331.y1eIdVUC-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260508/202605080331.y1eIdVUC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605080331.y1eIdVUC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/mempolicy.c:2527 expecting prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

