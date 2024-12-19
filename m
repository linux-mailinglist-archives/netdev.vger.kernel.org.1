Return-Path: <netdev+bounces-153311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A119F7951
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FFA7A2BBE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008321766A;
	Thu, 19 Dec 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoZ5dvXA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9021FBCBE;
	Thu, 19 Dec 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603385; cv=none; b=l5jm7WZwf9jc6ZNkJNKLEX98TCbPhingRelq6R7s5dCWgqcrOiOAFtFxeVYQHr6DbroJwVrHRWc/t8ptNxw6UYS3f3u/F7i8D0O5zvT42wXy1WpdxpXN1/xlSdJY+siy4WmdMUvqsvEmB6ET5nB7cfrCl9w2s7ahuaXweh0y2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603385; c=relaxed/simple;
	bh=7eVeIysxu5g3BiktdvQyC2I620MZghcybkp12S4LnLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/e639Tgsqw5480Fgi9MFMuVA1QSYwLR3g2UKMDhYy4SyuuplCjbJabNDVi37vbj3l/bLIZCxYhZxXK3HCAHezgxxvuD5PxJNDSCU/+/OUwdFQ32dtx3Le/7jY8BPrlwO7ZA9zINuvhCtgIK8w6CTxcjd2uT58YtWDgkg9bNems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoZ5dvXA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734603381; x=1766139381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7eVeIysxu5g3BiktdvQyC2I620MZghcybkp12S4LnLs=;
  b=GoZ5dvXAwSg2NjaZa8+yAUXMcG1UC8t0jJgBfGZEdZ0EdkkOgoZCvVzH
   a3JkOWZFWCSfdpDXVq2jrJU9VX91877gx0LufSg1y2Ud288pELVdEAdI9
   nMNPUKlPxXcf7MW+HalCljjc4hyIcfQlFWbpr3mncoa4+ug6YJY71OfRw
   UUG3Y8BiwbBqdj36iD1fEMNXJOIF0BT4QjJLzAb+LyOGS/pSSr1m6cS88
   FV5+kHvrEMpCA7IQnb8qiuHi+nqMuittYTEOZOG7jiDpiKzkN6i0GDJFs
   rbwNNe0i76mqvVltMeOAJXyrF1fC+GOxolOCXkXK5wAwdRtVe33zpwpBk
   Q==;
X-CSE-ConnectionGUID: opl8FHEbQpSFoZP36q6Fgw==
X-CSE-MsgGUID: HJFpdMpDR7u5wYJRxsxuPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35006768"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="35006768"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:16:20 -0800
X-CSE-ConnectionGUID: jls0FyZtR7SpS3glc4kAjA==
X-CSE-MsgGUID: pRLPkKjdTz6FfGWE02S5Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="98052502"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:16:19 -0800
Date: Thu, 19 Dec 2024 11:13:17 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V2 net 1/7] net: hns3: fixed reset failure issues
 caused by the incorrect reset type
Message-ID: <Z2PxvUcxUsGWTQ1a@mev-dev.igk.intel.com>
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-2-shaojijie@huawei.com>
 <Z2KPw9WYCI/SZIjg@mev-dev.igk.intel.com>
 <8a789f23-a17a-456d-ba2a-de8207d65503@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a789f23-a17a-456d-ba2a-de8207d65503@redhat.com>

On Thu, Dec 19, 2024 at 10:41:53AM +0100, Paolo Abeni wrote:
> On 12/18/24 10:02, Michal Swiatkowski wrote:
> > On Tue, Dec 17, 2024 at 09:08:33AM +0800, Jijie Shao wrote:
> >> From: Hao Lan <lanhao@huawei.com>
> >>
> >> When a reset type that is not supported by the driver is input, a reset
> >> pending flag bit of the HNAE3_NONE_RESET type is generated in
> >> reset_pending. The driver does not have a mechanism to clear this type
> >> of error. As a result, the driver considers that the reset is not
> >> complete. This patch provides a mechanism to clear the
> >> HNAE3_NONE_RESET flag and the parameter of
> >> hnae3_ae_ops.set_default_reset_request is verified.
> >>
> >> The error message:
> >> hns3 0000:39:01.0: cmd failed -16
> >> hns3 0000:39:01.0: hclge device re-init failed, VF is disabled!
> >> hns3 0000:39:01.0: failed to reset VF stack
> >> hns3 0000:39:01.0: failed to reset VF(4)
> >> hns3 0000:39:01.0: prepare reset(2) wait done
> >> hns3 0000:39:01.0 eth4: already uninitialized
> >>
> >> Use the crash tool to view struct hclgevf_dev:
> >> struct hclgevf_dev {
> >> ...
> >> 	default_reset_request = 0x20,
> >> 	reset_level = HNAE3_NONE_RESET,
> >> 	reset_pending = 0x100,
> >> 	reset_type = HNAE3_NONE_RESET,
> >> ...
> >> };
> >>
> >> Fixes: 720bd5837e37 ("net: hns3: add set_default_reset_request in the hnae3_ae_ops")
> >> Signed-off-by: Hao Lan <lanhao@huawei.com>
> >> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> I haven't signed-off this patch.
> 
> Still no need to repost (yet) for this if the following points are
> solved rapidly (as I may end-up merging the series and really adding my
> SoB), but please avoid this kind of issue in the future.
> 
> >> @@ -4227,7 +4240,7 @@ static bool hclge_reset_err_handle(struct hclge_dev *hdev)
> >>  		return false;
> >>  	} else if (hdev->rst_stats.reset_fail_cnt < MAX_RESET_FAIL_CNT) {
> >>  		hdev->rst_stats.reset_fail_cnt++;
> >> -		set_bit(hdev->reset_type, &hdev->reset_pending);
> >> +		hclge_set_reset_pending(hdev, hdev->reset_type);
> > Sth is unclear for me here. Doesn't HNAE3_NONE_RESET mean that there is
> > no reset? If yes, why in this case reset_fail_cnt++ is increasing?
> > 
> > Maybe the check for NONE_RESET should be done in this else if check to
> > prevent reset_fail_cnt from increasing (and also solve the problem with
> > pending bit set)
> 
> @Michal: I don't understand your comment above. hclge_reset_err_handle()
> handles attempted reset failures. I don't see it triggered when
> reset_type == HNAE3_NONE_RESET.
> 
> >> @@ -4470,8 +4483,20 @@ static void hclge_reset_event(struct pci_dev *pdev, struct hnae3_handle *handle)
> >>  static void hclge_set_def_reset_request(struct hnae3_ae_dev *ae_dev,
> >>  					enum hnae3_reset_type rst_type)
> >>  {
> >> +#define HCLGE_SUPPORT_RESET_TYPE \
> >> +	(BIT(HNAE3_FLR_RESET) | BIT(HNAE3_FUNC_RESET) | \
> >> +	BIT(HNAE3_GLOBAL_RESET) | BIT(HNAE3_IMP_RESET))
> >> +
> >>  	struct hclge_dev *hdev = ae_dev->priv;
> >>  
> >> +	if (!(BIT(rst_type) & HCLGE_SUPPORT_RESET_TYPE)) {
> >> +		/* To prevent reset triggered by hclge_reset_event */
> >> +		set_bit(HNAE3_NONE_RESET, &hdev->default_reset_request);
> >> +		dev_warn(&hdev->pdev->dev, "unsupported reset type %d\n",
> >> +			 rst_type);
> >> +		return;
> >> +	}
> > Maybe (nit):
> > if (...) {
> > 	rst_type = 
> > 	dev_warn();
> > }
> > 
> > set_bit(rst_type, );
> > It is a little hard to follow with return in the if.
> 
> @Michal: I personally find the patch code quite readable, do you have
> strong opinions here?
> 

Sorry, I anwered and missed other replies :(

No strong opionion, only nit, I should mark that.

> >>  	set_bit(rst_type, &hdev->default_reset_request);
> >>  }
> >>  
> >> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> >> index 2f6ffb88e700..fd0abe37fdd7 100644
> >> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> >> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> >> @@ -1393,6 +1393,17 @@ static int hclgevf_notify_roce_client(struct hclgevf_dev *hdev,
> >>  	return ret;
> >>  }
> >>  
> >> +static void hclgevf_set_reset_pending(struct hclgevf_dev *hdev,
> >> +				      enum hnae3_reset_type reset_type)
> >> +{
> >> +	/* When an incorrect reset type is executed, the get_reset_level
> >> +	 * function generates the HNAE3_NONE_RESET flag. As a result, this
> >> +	 * type do not need to pending.
> >> +	 */
> >> +	if (reset_type != HNAE3_NONE_RESET)
> >> +		set_bit(reset_type, &hdev->reset_pending);
> >> +}
> > You already have a way to share the code between PF and VF, so please
> > move the same functions to common file in one direction up.
> 
> AFAICS this can't be shared short of a large refactor not suitable for
> net as the functions eligible for sharing operate on different structs
> with different layout (hclgevf_dev vs hclge_dev). Currently all the
> shared code operates on shared structs.
> 

Ok, didn't check that. Fine for me so.

> Cheers,
> 
> Paolo
> 

