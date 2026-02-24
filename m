Return-Path: <netdev+bounces-260553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIdwBgy5nWnERQQAu9opvQ
	(envelope-from <netdev+bounces-260553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:43:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5705F18891A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D53B300405A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024938BF60;
	Tue, 24 Feb 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnR3powK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB777378806
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944143; cv=none; b=SwLeCD8C1pWFF0blZRo0jtot+pdGK7YOrP/79aLzTemjQ2buprzq+Nyj2MgQ8QEG2QnS71fAizMeIHxKaLDcpqIRKRJSX3dTL4lSdrsqFhLYlUPsHye0C1CUboxFPNxw4f7t+ZQtNAJV4/KMFhvZkjn/5VWcTJ8LuQvwcYCYZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944143; c=relaxed/simple;
	bh=5ZNIZoIJym+AaiB5vhhF5rYP9sCgmaJ6czhporeCOVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+rg4V2gx5H/oWZDc32KArpL8cqZzYjQDKKNNWRlJPkud+2lM2uWt7LAUSaw8O6xEmXItsrxapVG8V4U5fRYoTJstLD18Gu4hrE8KsFbaBJtqHwqsyGnRD7WvkIzIvXqz8si6wBqCUIHS1pNAu4V3YSgW2CecnXRGYaCv5KnhxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnR3powK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771944142; x=1803480142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5ZNIZoIJym+AaiB5vhhF5rYP9sCgmaJ6czhporeCOVk=;
  b=GnR3powKfQHYZLWUu+N3mATZZMmVKysMwtAK5i30CstVVZ1ZUXrYaccH
   yagS/jnxgQABCI90z4TjH9CC6aTcORrA2bOS94vkFFZydgJS8yoU91XJZ
   4ghqv5IbRg7P4jlIq29dfrDmx/IKWpiOucWHX9r3prAMwymlyEU201j/w
   ydSjRdpMmlDTWerzod9ndUu6f/PMmwXXCxrLTYfarhTHwvo3jxI3EcJWb
   TUQj+EZ8rni/vzSiJnxdykneyHePXN75BTDoPSceW2jGek0oCfqurH3nV
   IuOCYlyFjTwqMucnprljvUL57pfWW67cEff0AWdwWlGYsjbDu2NgI8Ea0
   Q==;
X-CSE-ConnectionGUID: DybIj/2QSa216GGs9ZhZyQ==
X-CSE-MsgGUID: n5WxvE45QKC/dCShlbWBVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="76821449"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="76821449"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:42:21 -0800
X-CSE-ConnectionGUID: ZJUn7VEURY6APU6E/zr+vg==
X-CSE-MsgGUID: WSZ2pWV5SyWiQdtr0gwnNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220507571"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.19]) ([10.125.111.19])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:42:20 -0800
Message-ID: <07904415-19a8-4381-9292-2f0625fd69ca@intel.com>
Date: Tue, 24 Feb 2026 07:42:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ntb_netdev: Fix NULL check ordering in TX
 handler
To: Alok Tiwari <alok.a.tiwari@oracle.com>, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, jdmason@kudzu.us, allenbh@gmail.com,
 ntb@lists.linux.dev, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com
References: <20260224130458.1355686-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224130458.1355686-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260553-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,kudzu.us,gmail.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 5705F18891A
X-Rspamd-Action: no action



On 2/24/26 6:04 AM, Alok Tiwari wrote:
> ntb_netdev_tx_handler() calls netdev_priv(ndev) before checking
> whether ndev is NULL. Although qp_data is expected to always be
> valid in normal operation, dereferencing the pointer before the
> NULL check is logically incorrect.
> 
> Move netdev_priv() after validating ndev.
> 
> No functional change intended.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/net/ntb_netdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index fbeae05817e9..6792b3b1f253 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -177,13 +177,15 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  				  void *data, int len)
>  {
>  	struct net_device *ndev = qp_data;
> +	struct ntb_netdev *dev;
>  	struct sk_buff *skb;
> -	struct ntb_netdev *dev = netdev_priv(ndev);
>  
>  	skb = data;
>  	if (!skb || !ndev)
>  		return;
>  
> +	dev = netdev_priv(ndev);
> +
>  	if (len > 0) {
>  		ndev->stats.tx_packets++;
>  		ndev->stats.tx_bytes += skb->len;


