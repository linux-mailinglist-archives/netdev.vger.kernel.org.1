Return-Path: <netdev+bounces-260835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Px2AGfAnmkDXQQAu9opvQ
	(envelope-from <netdev+bounces-260835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:27:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B4194F58
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B53A306CDB6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF9389454;
	Wed, 25 Feb 2026 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uqLhwmTX"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F18313291;
	Wed, 25 Feb 2026 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011431; cv=none; b=StJTCo4Ce71vPfrB5QBSNSQdvg2SIpC9GqnMrxxCXVHdyIm3s05UWHwPVvomGMJDyvIsiwa541uZa2nMDm6xKvUSxsFmnO3S0/uqy3xUGMP7w2hiPiotoVd4zeSOzEO8nJ1fLzuLGLcWBpsd/xKP3JQNDEWKv7pNDj9+2FqHO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011431; c=relaxed/simple;
	bh=QBkQcWMhF05ufeIv0SyA5SJp0DDBlyaSfEdE90K5D9s=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mN1zFEHnITc1AenovtnyWh7WJ2f8LsfvEodHd835UMV9uUpd8wV0076XZIIIdnySllzszwmHGoaflTWovwOvD6GLRf07Nv4NkBGL6SzcGdhpk07RKxdwpovWQb7Jihtc5H+u2RwX990RMSfnBJCRwh/AKhOWxtN/bM8Arl8kQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uqLhwmTX; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5xSSyvwBS97xJBgxZ/Q+3dWxudMXircE0WBxGVYaSCk=;
	b=uqLhwmTXSeN4ZBauyoV/v+bW+mipJ3q6WjJa32MwSLQ/Fad8VAoe1A/JP+pQoun3r+9UwDd5u
	TjaKU4BuCBiYPvOR7ESp6MSInq8pIlAojQaazl5yoQS5pBkcdozK1aSEBvlv/N9/mdD0u0ApVYH
	eesYkmGDtJrgYWvEqQfuE9w=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fLTXz3D04zcbV7;
	Wed, 25 Feb 2026 17:18:43 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 418774056A;
	Wed, 25 Feb 2026 17:23:44 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 25 Feb 2026 17:23:43 +0800
Message-ID: <2a2813e8-c94a-419f-9c45-eda88f285faf@huawei.com>
Date: Wed, 25 Feb 2026 17:23:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <pabeni@redhat.com>, <jerinj@marvell.com>,
	<lcherian@marvell.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] octeontx2-af: CGX: replace kfree() with
 rvu_free_bitmap()
To: Bo Sun <bo@mboxify.com>, <netdev@vger.kernel.org>, <kuba@kernel.org>,
	<vadim.fedorenko@linux.dev>
References: <20260225082348.2519131-1-bo@mboxify.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260225082348.2519131-1-bo@mboxify.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	URIBL_RED(0.50)[mboxify.com:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260835-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[huawei.com:s=dkim];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_SPAM(0.00)[0.997];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,huawei.com:email,mboxify.com:email]
X-Rspamd-Queue-Id: DC1B4194F58
X-Rspamd-Action: no action


on 2026/2/25 16:23, Bo Sun wrote:
> mac_to_index_bmap is allocated with rvu_alloc_bitmap(), so free it
> with rvu_free_bitmap() instead of open-coding kfree(.bmap) to keep
> the alloc/free API pairing consistent.

Reviewed-by: Jijie Shao <shaojijie@huawei.com>

>
> Signed-off-by: Bo Sun <bo@mboxify.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>   drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> index 6000795823a3..4f33a816bc7a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -1822,7 +1822,7 @@ static int cgx_lmac_exit(struct cgx *cgx)
>   			continue;
>   		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
>   		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
> -		kfree(lmac->mac_to_index_bmap.bmap);
> +		rvu_free_bitmap(&lmac->mac_to_index_bmap);
>   		rvu_free_bitmap(&lmac->rx_fc_pfvf_bmap);
>   		rvu_free_bitmap(&lmac->tx_fc_pfvf_bmap);
>   		kfree(lmac->name);
>
>

