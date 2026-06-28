Return-Path: <netdev+bounces-302436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gu+7F4O0QWoMtwkAu9opvQ
	(envelope-from <netdev+bounces-302436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 01:55:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B687B6D5544
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 01:55:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ml0u0fnx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302436-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302436-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAEC4300B87E
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB92F7EEE;
	Sun, 28 Jun 2026 23:55:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104BE374A12
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 23:55:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782690943; cv=none; b=brnMA+XnNZJtQOeG8mMPLp7ej3y8Jm/hsGiIDIsEBkEOS7NnHuLnyQiwnW80xvG9xaRFFHfybYZvcMwL4zKgEheKgpfrbgedmyqoDAJ8kHd3qlTyYUFN6q20OA94CVpdSXPeeLW0ZjnE5cdPDMVxuhbWTJHI707NWA0MEWpq0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782690943; c=relaxed/simple;
	bh=1iGzbc/ihiojGypt1O30+8mo7mH0LgpOsPvWYUZLeCE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BD6GbpdmSyyx7NkRVqiBpUHaedbmNbneHe1fa37ClR6YTmyZjr3L6NhAryymN4u7U4wTbIp0OOQw06RSO07tNTQcQ9cK2AYUbPzkqXXcb2vlex79ejAWi++iSMVE7w5qdzIQBRlV3ctVwG1WuTasa85woOs1aD7o7yjCdECh/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ml0u0fnx; arc=none smtp.client-ip=95.215.58.174
Message-ID: <0892f5e8-7ca4-4efc-a002-8c1ed244b18e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782690929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWJ9m0B2lARXAerF+kQRyl3GwQ7mSztH/5H45745C7k=;
	b=ml0u0fnxeOD3TDUQoQBKFWCstaPO5JjU8s3x+N71MCNi9B9tXSfYscQzhI2Sb1wpggERiC
	PxpqearG1H4OKQLoskDaWvUI5fW+iWc/VyWFW3yh7Thfhvj2Ncqoz9p+OxDW3zblWY4Jq9
	ozCEs7Jdoh4uJN+j1BVRpnCSlYs9qXM=
Date: Mon, 29 Jun 2026 07:55:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH iproute2-next v3] rdma: display resource limits in
 curr/max format
To: David Ahern <dsahern@kernel.org>, leonro@nvidia.com
References: <20260615005315.169582-1-cui.tao@linux.dev>
 <4d98d9a3-07e1-4333-b040-c72e5f561a63@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <4d98d9a3-07e1-4333-b040-c72e5f561a63@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:cuitao@kylinos.cn,m:dsahern@kernel.org,m:leonro@nvidia.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-302436-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B687B6D5544

Hi David,

Thanks for taking a look.

The kernel counterpart that introduces this uapi attribute is the
following patch, currently under review on the rdma list and not yet in
Linus' tree:

  [PATCH rdma-next v3] RDMA/nldev: add resource summary max values for usage display
  https://lore.kernel.org/all/20260615003646.168704-1-cui.tao@linux.dev/

That is the one adding RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX.

You're right that the iproute2 side should reference the kernel patch.
I'll add a Link to it in the commit log of the next revision, e.g.:

  Link: https://lore.kernel.org/all/20260615003646.168704-1-cui.tao@linux.dev/

If you'd prefer, I can also hold this iproute2 patch until the kernel
side has landed, so the uapi is already in tree when it goes in. Happy
to do whichever you think is best.

Thanks,
Tao

在 2026/6/29 01:22, David Ahern 写道:
> On 6/14/26 6:53 PM, Tao Cui wrote:
>> diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
>> index 4356ec4a..e5b8b065 100644
>> --- a/rdma/include/uapi/rdma/rdma_netlink.h
>> +++ b/rdma/include/uapi/rdma/rdma_netlink.h
>> @@ -604,6 +604,11 @@ enum rdma_nldev_attr {
>>  	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
>>  	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
>>  
>> +	/*
>> +	 * Resource summary entry maximum value.
>> +	 */
>> +	RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX,		/* u64 */
> 
> I do not see this uapi in Linus' tree. What is the status of the kernel
> commit? Put a reference to the kernel patches in the commit message.
> 


