Return-Path: <netdev+bounces-275048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB5rJO/Cz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:38:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D2394976
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43C3930186B7
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC41FE47B;
	Fri,  3 Apr 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="FDE/G9D7"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8022DCF45
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223516; cv=none; b=ueCFnIZvzJ1oIuDdJDcjCCpFAKvAOgK/mZwCUZ2avXZZDkFxcs6qGYON6TbN2Zlcg4ZdDoT2Lix7MYuEfWl2y5tosN4fNrAFtmZb8IQXsGQSyaSSZDD2RgDZk0OPCJmvvY6iVAx8R/xyTRGNYlSEifrIJv/FCSB0D4MQpShGFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223516; c=relaxed/simple;
	bh=FbiPqG+0+WRU1mIXYmyHBm0FaHq7qQJE/ZfkEzHjA50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvhnDYFlZGcC+f2PD2TpxiahQJO092XQeNo3jYMDp/u9omgO2J+LxlaFgXL11oN4X27SqeeX3VYd6miNgQY7IdDXKFdUEAEf9cp5roRxJ/QQyPGZVzdlVNMgFhVhe7F1H1hjNF97+zJv/1a0pquLnSZJl58ZmM22NpajzuYK+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=FDE/G9D7; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (202.223.13.160.dy.iij4u.or.jp [160.13.223.202])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 633DcFdq062611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Apr 2026 22:38:17 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=k/+LSme+79ctNKimbMMFnmmAovxDGBizgyq+djaSN7Q=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1775223498; v=1;
        b=FDE/G9D7JJl4VSsAOhvGAFpJVw7bHO1056Z0d+k4elD1mhAja/S7Oy4EWssR13Vp
         P9OOn7VJSnrvVgeVBn6iEOfXI2NtdQY8CDaKY/LJPBWsveg1bfhqB7X+eaNjH0sf
         z5x8LHzvgR3sZu/ca1Cnr61Yqxb2Dfgk/IP/pVzJZIdhzye8EWa7HSGgLXyNC/zV
         2TpNPPKuxwXmlHx4TTCQqhuhWDKzspYaaqDFre4fvsObGaqhZUGRoe6cCKfZfIUk
         ile1nYSeDBMRaSjzF3aMoZ7k8PjYk+WDUlshcXXRopx1+5rQRVxvqh8Q280Jsba7
         tIQAhrhnQLPGiz11mGK5TQ==
Date: Fri, 3 Apr 2026 22:38:15 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
        netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: replace GFP_ATOMIC
 with GFP_KERNEL in ixgbe_fcoe_ddp_setup()
Message-ID: <ac_Bo2Ra7UuvXe6e@x1>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-7-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-7-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275048-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,enjuk.jp:dkim]
X-Rspamd-Queue-Id: 2D5D2394976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/27 08:30, Aleksandr Loktionov wrote:
> From: Sebastian Basierski <sebastianx.basierski@intel.com>
> 
> ixgbe_fcoe_ddp_setup() is always called from process context (FCoE
> offload setup paths) and never from an atomic context.  Using
> GFP_ATOMIC is therefore unnecessarily restrictive and wastes memory
> allocator headroom that is reserved for genuine atomic callers.
> Replace the dma_pool_alloc() flag with GFP_KERNEL.
> 
> Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> index 011fda9..7fa0971 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
> @@ -193,7 +193,7 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
>  	}
>  
>  	/* alloc the udl from per cpu ddp pool */
> -	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_ATOMIC, &ddp->udp);
> +	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_KERNEL, &ddp->udp);

Commit fa39ab5184d6 ("scsi: fcoe: Fix I/O path allocation") had introduced
this GFP_ATOMIC flag, since some IO paths called this function with a
spin_lock held. Now, is it safe to roll back this change?

>  	if (!ddp->udl) {
>  		e_err(drv, "failed allocated ddp context\n");
>  		goto out_noddp_unmap;
> -- 
> 2.52.0
> 

