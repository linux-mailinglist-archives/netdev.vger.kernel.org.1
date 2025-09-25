Return-Path: <netdev+bounces-226440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90851BA06A9
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5672C1672AF
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDCC2750E6;
	Thu, 25 Sep 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vt4GCLEb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA0502BE
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815196; cv=none; b=sMSC95QCBDFKeb7RJ4bHLpLOM3azXXMhFag+Q1Jcm/16dN67uQvWhCtMUDO4quKlcU89Db2iklko709A9ZJ+Oa01KQJrgClPByeBfQj4B1jBjMOcJVM1w+Z8vATHbkNEpGLnsPI6W5XyGYJAMRZ4NOr1msNHi5dS6fpMggzN2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815196; c=relaxed/simple;
	bh=zwPcnhZSu4WFro/iqyQ8l1wBHFrOqKUWijRmPd/LGQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzcwEAIskGHvWlXf3Gziy4cGgSGy4R+Qlg3WHhHHDe6NzmxZJknVIvrU6H7aQC8/T0Zm30dkgVohLOyApI/7DvO7OyHqrGKpGZ+0HFXmu8MaJb83VeLHdmSVydzQ0WXTifYBKOIowpxNiBlPtKr2k63o6YUvLFlMFJCz7QATliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vt4GCLEb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758815195; x=1790351195;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zwPcnhZSu4WFro/iqyQ8l1wBHFrOqKUWijRmPd/LGQc=;
  b=Vt4GCLEb7o9vVwN6DjthCSrrc6zTETy8q8fRRqhzPX+/rTtiuasaViJe
   YLGzw1Pr2h+iW9csCFSko9mTnSlbVT6+0dftQm79hZauNXm2BMkBky965
   vBn4bcimL7yalX+ZRUHXszR/ukd1IBaaSIqI2DEP9QqJKHePag7a9wOnZ
   KwZMZP3WGc9s2K3wvxLhtFjCVj92EyhYXHpmAE8/NrztwaobPepq/1njQ
   O6K8YrT3YmycnT6eQYRBgw5Uu6voMozlRU6PG0pmzSmjjmGgEk6wHX1zl
   SH+LVIdTZrQYV82eTWti+E1u7KfzqYA+R0gvx+433+DvGTIqYkIR7qQgO
   g==;
X-CSE-ConnectionGUID: yP6jmDB6Tsyt2kGc/kUepQ==
X-CSE-MsgGUID: MYRrKhUCTOyphVxYpXISdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="72498192"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="72498192"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:46:34 -0700
X-CSE-ConnectionGUID: /K5Jo7RUQLCn5PR8Zm7aYg==
X-CSE-MsgGUID: kBAWSdGTQ6aUVmvnYGJntQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="176494988"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.4]) ([10.125.109.4])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:46:33 -0700
Message-ID: <74540a81-a7af-4a50-b832-679e7873cfe0@intel.com>
Date: Thu, 25 Sep 2025 08:46:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/6] bnxt_fwctl: Add bnxt fwctl device
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, saeedm@nvidia.com,
 Jonathan.Cameron@huawei.com, davem@davemloft.net, corbet@lwn.net,
 edumazet@google.com, gospo@broadcom.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 selvin.xavier@broadcom.com, leon@kernel.org,
 kalesh-anakkur.purayil@broadcom.com
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-6-pavan.chebbi@broadcom.com>
 <548092f9-74b0-4b10-8db0-aeb2f6c96dcd@intel.com>
 <CALs4sv0GMBZvhocPr4DTUu0ECFCazEb8Db6ms9SwO9CVPzBNVw@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CALs4sv0GMBZvhocPr4DTUu0ECFCazEb8Db6ms9SwO9CVPzBNVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/24/25 9:31 PM, Pavan Chebbi wrote:
> On Thu, Sep 25, 2025 at 4:02 AM Dave Jiang <dave.jiang@intel.com> wrote:
>>
> 
>>> +static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx,
>>> +                         enum fwctl_rpc_scope scope,
>>> +                         void *in, size_t in_len, size_t *out_len)
>>> +{
>>> +     struct bnxtctl_dev *bnxtctl =
>>> +             container_of(uctx->fwctl, struct bnxtctl_dev, fwctl);
>>> +     struct bnxt_aux_priv *bnxt_aux_priv = bnxtctl->aux_priv;
>>> +     struct fwctl_dma_info_bnxt *dma_buf = NULL;
>>> +     struct device *dev = &uctx->fwctl->dev;
>>> +     struct fwctl_rpc_bnxt *msg = in;
>>> +     struct bnxt_fw_msg rpc_in;
>>> +     int i, rc, err = 0;
>>> +     int dma_buf_size;
>>> +
>>> +     rpc_in.msg = kzalloc(msg->req_len, GFP_KERNEL);
>>
>> I think if you use __free(kfree) for all the allocations in the function, you can be rid of the gotos.
>>
> Thanks Dave for the review. Would you be fine if I defer using scope
> based cleanup for later?
> I need some time to understand the mechanism better and correctly
> define the macros as some
> pointers holding the memory are members within a stack variable. I
> will fix the goto/free issues
> you highlighted in the next revision. I hope that is going to be OK?

Sure that is fine. The way things are done in this function makes things a bit tricky to do cleanup properly via the scope based cleanup. I might play with it a bit and see if I can come up with something. It looks like it needs a bit of refactoring to split some things out. Probably not a bad thing in the long run. 


