Return-Path: <netdev+bounces-174329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB437A5E4E0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A23619C0549
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C41EB1B3;
	Wed, 12 Mar 2025 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2UQ/ONo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FAD1E9B26;
	Wed, 12 Mar 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809614; cv=none; b=QXlb/CRZTO+dgQMA2mhXqyg4NWT2YIRwHZFZyUbU2cUQMYjraoqJggDrCUQz7nBpsBY1ffcowkqV/uXygqiHB5XOjDXWnWQKj9lPMbnysJKuZdoyUMsIJXLiulTaqEtD1QzANQvODyGSNKVlB1KpgyZXak+NQ9Y4QvY4ReQhkW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809614; c=relaxed/simple;
	bh=wIWV7Qfa1ypEt4gMlcGsPNnSnDWGWRpDmCt8AWSxX3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhj+g8HCBF9JFWorZpiCCFqhtFO7wAEv/vbBhZOmejaIdHsC0NDhEL2Sf6bcMZ7KUWon4A1nPub2uBMkuDPKW2Mci6Kr4qiTS4sRrXCxDnXTO9LsLcwmCsOM+AbQOetghGtVN4Zh5eowAXpoJif1eg2GBKbgE7I2at+jVgjO9xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2UQ/ONo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741809612; x=1773345612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wIWV7Qfa1ypEt4gMlcGsPNnSnDWGWRpDmCt8AWSxX3s=;
  b=P2UQ/ONoHEabslW9os88abankrqkGCSjZbPCpccJ+64zlf1ajFQj62Lp
   B5YEjj06pJmcnX9F4DEzoFyWUt1Bdo/m007CwDuhp0VnWyE5XCt2JfGtH
   WI+KlnnVC43P+D3+tzFkx/QmPIVag+o/jV0+ml77O+1zAuHtA8Z8u6QZw
   YXgsk6kyvrM7lx7LcQBUJ3N0L+hQn6YCiY7dbRV8lDirPdr9S4i2XAgnN
   XLu+ocgNwb9x2irR0/uPJPabxs7pzzG7BHUkADev7LxDjdnr6b5dP1cY3
   a9nuV5C/DBpzDo0fOtJCQDULnww2UTHF9Jcj261vxBaCCQznE/GK2fWVQ
   w==;
X-CSE-ConnectionGUID: R+bodVigRKWwYtiDpZD/WQ==
X-CSE-MsgGUID: 7wtOtn9aTK6TNfbk1iF59A==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43109753"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="43109753"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:00:11 -0700
X-CSE-ConnectionGUID: S62y2uoZR06tFF3LdFK9Dg==
X-CSE-MsgGUID: pntIlsi7SWOYoRcJjshttg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121659649"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.10])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:00:11 -0700
Date: Wed, 12 Mar 2025 13:00:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v11 01/23] cxl: add type2 device basic support
Message-ID: <Z9HnyctYzFkVBW5u@aschofie-mobl2.lan>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-2-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310210340.3234884-2-alejandro.lucero-palau@amd.com>

On Mon, Mar 10, 2025 at 09:03:18PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Use same new initialization with the type3 pci driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/mbox.c   |  12 +--
>  drivers/cxl/core/memdev.c |  32 ++++++
>  drivers/cxl/core/pci.c    |   1 +
>  drivers/cxl/core/regs.c   |   1 +
>  drivers/cxl/cxl.h         |  97 +-----------------
>  drivers/cxl/cxlmem.h      |  88 ++--------------
>  drivers/cxl/cxlpci.h      |  21 ----
>  drivers/cxl/pci.c         |  17 ++--
>  include/cxl/cxl.h         | 206 ++++++++++++++++++++++++++++++++++++++
>  include/cxl/pci.h         |  23 +++++
>  10 files changed, 285 insertions(+), 213 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d72764056ce6..20df6f78f148 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1484,23 +1484,21 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>  
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec)

Please fixup cxl-test usage to avoid:

test/mem.c:1614:15: error: too few arguments to function ‘cxl_memdev_state_create’
 1614 |         mds = cxl_memdev_state_create(dev);
      |               ^~~~~~~~~~~~~~~~~~~~~~~


snip

