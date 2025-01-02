Return-Path: <netdev+bounces-154724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815149FF973
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D5918835A4
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08551B0F04;
	Thu,  2 Jan 2025 12:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E51B0F18;
	Thu,  2 Jan 2025 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735821962; cv=none; b=BFXtewrkcCaSXWHCtXUDNN/8BlCtS45VGSBQHlmf/wRR96UDDwxbwQXw+Q92o3DY/k4DcrPmJugJGtfFfNhno7W3R64JKFHX+/CzCqF89Wivkhy/AWyygBdpJ8gc0HyLrtpRyMZOdUB/L3I+u7yislIz72UB7sqqeh4smP/15Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735821962; c=relaxed/simple;
	bh=wet86/KkCNfy9pyRm3WF4279DcRR//oM0inNR7tqtec=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFTJvW8dNLLWJQpGjeyBw4I+rHTqO5WEPYm4uXillB2RQ0WMyrVSco+A7jtSsEZtt46DcZ4G1+fyb0vO61Fig13v3RNTWp38NWU4UMcO9WMIz/U4uclA4n7Ut4WQcRsMERPTAma4D/StVnZ2uHqnmFi1KM4cKkFbtjIpc/hn7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YP5tT2Zz5z6K9WF;
	Thu,  2 Jan 2025 20:41:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 14A0C1401F3;
	Thu,  2 Jan 2025 20:45:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 2 Jan
 2025 13:45:55 +0100
Date: Thu, 2 Jan 2025 12:45:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v8 11/27] cxl: add function for setting media ready by a
 driver
Message-ID: <20250102124554.00002584@huawei.com>
In-Reply-To: <69033618-a872-1c3a-3f28-552603cedd8e@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
	<20241216161042.42108-12-alejandro.lucero-palau@amd.com>
	<20241224172916.000024f2@huawei.com>
	<69033618-a872-1c3a-3f28-552603cedd8e@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 27 Dec 2024 08:08:45 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 12/24/24 17:29, Jonathan Cameron wrote:
> > On Mon, 16 Dec 2024 16:10:26 +0000
> > alejandro.lucero-palau@amd.com wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> A Type-2 driver may be required to set the memory availability explicitly,
> >> for example because there is not a mailbox for doing so through a specific
> >> command.
> >>
> >> Add a function to the exported CXL API for accelerator drivers having this
> >> possibility.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>  
> > I wonder if it is worth capturing the reasoning for this a comment?  
> 
> 
> Sorry, I can not understand this.

Err. I've no idea what I was going on about. :(

Ignore that.

> 
> 
> > Either way
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >  
> >> ---
> >>   drivers/cxl/core/memdev.c | 6 ++++++
> >>   include/cxl/cxl.h         | 1 +
> >>   2 files changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> >> index c414b0fbbead..82c354b1375e 100644
> >> --- a/drivers/cxl/core/memdev.c
> >> +++ b/drivers/cxl/core/memdev.c
> >> @@ -789,6 +789,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> >>   }
> >>   EXPORT_SYMBOL_NS_GPL(cxl_release_resource, "CXL");
> >>   
> >> +void cxl_set_media_ready(struct cxl_dev_state *cxlds)
> >> +{
> >> +	cxlds->media_ready = true;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, "CXL");
> >> +
> >>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
> >>   {
> >>   	struct cxl_memdev *cxlmd =
> >> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> >> index 44664c9928a4..473128fdfb22 100644
> >> --- a/include/cxl/cxl.h
> >> +++ b/include/cxl/cxl.h
> >> @@ -44,4 +44,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
> >>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
> >>   int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> >>   int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> >> +void cxl_set_media_ready(struct cxl_dev_state *cxlds);
> >>   #endif  


