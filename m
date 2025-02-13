Return-Path: <netdev+bounces-165766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB2BA334F7
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A637A309B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737DC126C05;
	Thu, 13 Feb 2025 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWPoFTjF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119531372;
	Thu, 13 Feb 2025 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411478; cv=none; b=PhMBp/GTY48MBFOB2fQgjnCALLDDPh7sSl1WZfOT+F/y5K2Z56n83qaVig6VgHbvHDyRHPQjKPDtwjyuKfUnUT/a4stwUjYVO6b0ZC6uTbEkKn+4w21PLt2QU8ZYhXFIORi/5pkvss0U9Ox8EI5mkqaZ2u6v+FZYLcM4W8JGBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411478; c=relaxed/simple;
	bh=jpyTtA/8PN2BcE77X8ALz4DktmnjmEGdfudKg8FnWAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUErzEuEM9axBuRL3p0tm+AXxSx3j+SA8apYz3vDyOlZlGaGQyUvACWpRuTBKJ3ypj11N4TFZ2DAgKZTvWKxp7EJLLp6x0Nf27BxSyGYRgMPRRi42QRY9AwhYBsCr5u9+qOaoSBSA1U6vwPyHb9BmqYZKK13nW8oxePLUiIbohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWPoFTjF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739411476; x=1770947476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jpyTtA/8PN2BcE77X8ALz4DktmnjmEGdfudKg8FnWAY=;
  b=YWPoFTjFZdhsAa9BDJxs3kjRwxh/U/QR2/Qi/bVR9hgtFN9r94hp0hyf
   QVZKrhxVhyKxITDrxpZDuLar3ooXjefZsBRSyXYHzTFxQbd/WVvK4F6Os
   wF84Q4HCNvSwdc16vGxm3/aRiv9gnik0gPSxZ44tf4myaUHulyHbQcCWI
   Lm/dZ5BzWtg/0CF9oAzipOl8f0RKEeg4Esf0nFWlcc5g239WGQAGfiC72
   sHQBQoje72+G3KAYwvlGJmu3QNvSjx1cohd4ilK2wfXLDpswXaFh5mlmS
   I+0b6QdAiqPdyA+CAeDq4rGjdYzag7xNGV4UOvKH+0bPp83O2Ifg1YgGB
   A==;
X-CSE-ConnectionGUID: cj8lBrWJQY6c4rbdX4QreA==
X-CSE-MsgGUID: QahEVbkvTBiyOf3Mo8ao3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="27691612"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="27691612"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 17:51:15 -0800
X-CSE-ConnectionGUID: J2chc262RS+tbe4y2Er5Fw==
X-CSE-MsgGUID: bn78Zj3YSumHu3UjxXw8cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143942543"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 17:51:13 -0800
Date: Wed, 12 Feb 2025 17:51:11 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 00/26] cxl: add type2 device basic support
Message-ID: <Z61QD3jwitZ2cngc@aschofie-mobl2.lan>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>

On Wed, Feb 05, 2025 at 03:19:24PM +0000, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
Hi Alejandro,

Appending a patch with the cxl-test changes needed to compile
this set. Those changes can be applied in pieces to the relevant
patches. 

Once compiled, the cxl-test module builds and cxl unit tests pass :)

Snipping your cover letter and appending the cxl-test patch.

Subject: [PATCH] type-2 v10 review - make cxl-test compile

These need to be folded into the drivers/cxl/ patches that caused
the param changes.

---
 tools/testing/cxl/test/mem.c  | 6 +++---
 tools/testing/cxl/test/mock.c | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 495199238335..a37f144a6f38 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1518,7 +1518,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	mds = cxl_memdev_state_create(dev);
+	mds = cxl_memdev_state_create(dev, 0, 0, CXL_DEVTYPE_CLASSMEM);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 
@@ -1559,13 +1559,13 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	rc = cxl_dpa_setup(cxlds, &range_info);
+	rc = cxl_dpa_setup(mds, &range_info);
 	if (rc)
 		return rc;
 
 	cxl_mock_add_event_logs(&mdata->mes);
 
-	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
+	cxlmd = devm_cxl_add_memdev(&pdev->dev, mds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 3c6a071fbbe3..3f7e8db579ac 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -196,15 +196,16 @@ int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_port_enumerate_dports, "CXL");
 
-int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
+int __wrap_cxl_await_media_ready(struct cxl_memdev_state *cxlmds)
 {
 	int rc, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+	struct cxl_dev_state *cxlds = &cxlmds->cxlds;
 
 	if (ops && ops->is_mock_dev(cxlds->dev))
 		rc = 0;
 	else
-		rc = cxl_await_media_ready(cxlds);
+		rc = cxl_await_media_ready(cxlmds);
 	put_cxl_mock_ops(index);
 
 	return rc;
-- 
2.37.3


