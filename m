Return-Path: <netdev+bounces-178142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72488A74E36
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E201723D8
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD91D5CEA;
	Fri, 28 Mar 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="rY4iCp6I"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8721D7E4F
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177973; cv=none; b=hCTf6c9PNyNHyylIDTAU9JhSeLmhACG5N1MjqqhabvYnzWS2Rz1WwuxejSrjNwjMdfTCevkOoqvB9cQ40LkHVuVQxRj9B4QZ3o7xwWwa8DWsTJ3bR5vUN6rsNmHxG2CtijOVsIlTxLH1EbpZxmWQgJ6b7vMDD0CZkzKj5j44EXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177973; c=relaxed/simple;
	bh=Dwmm2XAmW3F71a1Vb/aC8blDhHdDpDJbM7aIkFaxaSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbaFv/XAGB27V4hl0Mw4GGNEjFLnEOJC/TXLcOo3j3ZTh1/lpByQEyKlazqmzxQ+QTboNrQOaTNCm9c2ipFskNSbXR3BXYKFBzKHHCluBYwUa1jiV62wSPUMeagfjDbFFapPsLkCfd4p8lkxU0OU/KRz+IasE7mJ/fsyWUDhrRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=rY4iCp6I; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4ZPQPH3JdyzDq7M;
	Fri, 28 Mar 2025 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1743177971; bh=Dwmm2XAmW3F71a1Vb/aC8blDhHdDpDJbM7aIkFaxaSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rY4iCp6Its0D+vXDfb8U/QiXNkjbpPOQSCxsIILml8ll3oVmoqjWiiZCeW39u9uUb
	 1HHvvZSbkRms5/j75d37XapWhG2nPJJJI/g0RA/WyiB2fLrUu/8m+qAVDW+iik27/9
	 JgD98YLla8c0UWwvssLR4HQLF6okNAqrATjjrkrM=
X-Riseup-User-ID: 4D5953E2C7175BCA2E12CF001834D825C52718D6E6A239488766BA32590A221C
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4ZPQP32Pq7zFw2N;
	Fri, 28 Mar 2025 16:05:59 +0000 (UTC)
Message-ID: <dbc2da11-0810-4894-acde-94c0c3575be9@riseup.net>
Date: Fri, 28 Mar 2025 17:05:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: hsr: sync hw addr of slave2 according to slave1 hw
 addr on PRP
To: netdev@vger.kernel.org
Cc: lukma@denx.de, wojciech.drewek@intel.com, m-karicheri2@ti.com
References: <20250328155522.3514-1-ffmancera@riseup.net>
Content-Language: en-US
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
In-Reply-To: <20250328155522.3514-1-ffmancera@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/28/25 4:55 PM, Fernando Fernandez Mancera wrote:
> In order to work properly PRP requires slave1 and slave2 to share the
> same MAC address. To ease the configuration process on userspace tools,
> sync the slave2 MAC address with slave1.
> 
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> ---
> NOTE: I am not sure the call_netdevice_notifiers() are needed here.
> I am wondering, if this change makes sense in HSR too.
> Feedback is welcome.
> ---
>   net/hsr/hsr_device.c | 2 ++
>   net/hsr/hsr_main.c   | 9 +++++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 439cfb7ad5d1..f971eb321655 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -706,6 +706,8 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>   		 */
>   		hsr->net_id = PRP_LAN_ID << 1;
>   		hsr->proto_ops = &prp_ops;
> +		eth_hw_addr_set(slave[1], slave[0]->dev_addr);
> +		call_netdevice_notifiers(NETDEV_CHANGEADDR, slave[1]);
>   	} else {
>   		hsr->proto_ops = &hsr_ops;
>   	}
> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
> index d7ae32473c41..192893c3f2ec 100644
> --- a/net/hsr/hsr_main.c
> +++ b/net/hsr/hsr_main.c
> @@ -78,6 +78,15 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
>   			eth_hw_addr_set(master->dev, dev->dev_addr);
>   			call_netdevice_notifiers(NETDEV_CHANGEADDR,
>   						 master->dev);
> +
> +			if (hsr->prot_version == PRP_V1) {
> +				port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
> +				if (port) {
> +					eth_hw_addr_set(port->dev, dev->dev_addr);
> +					call_netdevice_notifiers(NETDEV_CHANGEADDR,
> +								 port->dev);
> +				}
> +			}
>   		}
>   
>   		/* Make sure we recognize frames from ourselves in hsr_rcv() */

Ugh, I just noticed I missed to specify target tree net-next *facepalm*, 
sorry.

