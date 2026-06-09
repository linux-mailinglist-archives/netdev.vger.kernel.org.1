Return-Path: <netdev+bounces-297319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CT/cG+SNKGrPGAMAu9opvQ
	(envelope-from <netdev+bounces-297319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:04:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 624276646B0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:04:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=VvJCIQ2U;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297319-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297319-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55EE53037D47
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75F33EFD0F;
	Tue,  9 Jun 2026 21:58:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BF73F8ED1;
	Tue,  9 Jun 2026 21:58:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042293; cv=none; b=jdKZGws7dulqBGTRX/W2TiigNy4dX0jKMWpsvHz00IaRPEwS0pXxZtyH2wL+RLo5v5ZbBMLazD5cGWhzL7yDDv49i/xAkgyYV0H+r4C2MFkAiWmX1OXoDOG7dltzK3WT+94kcVSSQ9Th5K88zMb9w7aib8jfT64Ng//I7ksVYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042293; c=relaxed/simple;
	bh=KmzHd4DKziu/q29HQa9Oyv3SDw1p1TocslOV5ni/t68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6tru0FK+ekrWgE1u2H8V2mD4LNazZARexWwRKU5Q4fS/Uoz+svRBNh04GxSp7+vivYLH52A6xEd2vmSqFSmYIopDcg+Ozz5+5SQcV6mTnDA9K5DOp2Tnofzj+tgXSX3t1bwJ/VQlDqBTMevv6Cg8UWRSo1FzyVYqVbwvM3rLiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvJCIQ2U; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781042289; x=1812578289;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KmzHd4DKziu/q29HQa9Oyv3SDw1p1TocslOV5ni/t68=;
  b=VvJCIQ2UMPJYX3x2/CyI/YK1twwPhMrgNGEfXZYfD+nfE+k7HwnxLxyt
   W6gEP7TV/m87NYbkaIp3/TCfFOb4KG2y5/v6ZcqDuenY1RPUOp5RO2Ja1
   9kN4nMPd0Y2EY2ro4GQWqA4wiXYlBZZjXKMy4OV0Ai3MyNochEXE0q1Hi
   u5KwHIlvzWDw0t134ory1nyV8Y7E2DZjiCMTkAtsY5aTENC4fttegD48/
   Ua6iwYw+kDqxaxOiIIXPbTRqUEpeJw/RN8PvnrPVM6mxDr09oGZScbdB1
   N18GPN+wZHYgyCEUF5Smhj86P2uFr8S/hPEvHr6Uhrzsm9z+TbW2afQeG
   w==;
X-CSE-ConnectionGUID: i3ycBXRmT1ma6J/hKSi1Mw==
X-CSE-MsgGUID: sCOVPxKMRhW8y3J6vt0aWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84390929"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="84390929"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:58:09 -0700
X-CSE-ConnectionGUID: TexOhdYLQv27MMQdUVv3hw==
X-CSE-MsgGUID: WDv75E6TSrmhvY7RGHjvBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="247835219"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.206]) ([10.125.109.206])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:58:10 -0700
Message-ID: <6e42786e-fba4-48bd-ad84-e22e9d3224b8@intel.com>
Date: Tue, 9 Jun 2026 14:58:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297319-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:alucerop@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 624276646B0



On 6/9/26 2:57 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use core API for safely obtain the CXL range linked to an HDM committed
> by the BIOS. Map such a range for being used as the ctpio buffer.
> 
> A potential user space action through sysfs unbinding or core cxl
> modules remove will trigger sfc driver device detachment, with that case
> not racing with this mapping as this is done during driver probe and
> therefore protected with device lock against those user space actions.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx.c     |  1 +
>  drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 90ccbe310386..578054c21e79 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_fini_io(efx);
>  
>  	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	efx_cxl_exit(probe_data);
>  
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 4d55c08cf2a1..d5766a40e2cf 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct range cxl_pio_range;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
>  	int rc;
> @@ -75,9 +76,32 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return -ENODEV;
>  	}
>  
> +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed\n");
> +		return PTR_ERR(cxl->cxlmd);
> +	}
> +
> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
> +				    range_len(&cxl_pio_range));

Should this be devm managed? I think the mapping leaks if efx_pci_probe() fails after calling efx_cxl_init().
 
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> +			&cxl_pio_range);
> +		return -ENOMEM;
> +	}
> +
> +	probe_data->cxl_pio_initialised = true;

Should this change be moved to the follow on patch that uses it?

DJ
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  }
>  
> +void efx_cxl_exit(struct efx_probe_data *probe_data)
> +{
> +	if (!probe_data->cxl)
> +		return;
> +
> +	iounmap(probe_data->cxl->ctpio_cxl);
> +}
> +
>  MODULE_IMPORT_NS("CXL");
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> index 04e46278464d..3e2705cb063f 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.h
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -20,10 +20,13 @@ struct efx_probe_data;
>  struct efx_cxl {
>  	struct cxl_dev_state cxlds;
>  	struct cxl_memdev *cxlmd;
> +	void __iomem *ctpio_cxl;
>  };
>  
>  int efx_cxl_init(struct efx_probe_data *probe_data);
> +void efx_cxl_exit(struct efx_probe_data *probe_data);
>  #else
>  static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
> +static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
>  #endif
>  #endif


