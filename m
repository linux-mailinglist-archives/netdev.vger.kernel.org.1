Return-Path: <netdev+bounces-252239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPn6GIXccWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:15:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EB462E4A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6AF2E5689CF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74A6366DAB;
	Thu, 22 Jan 2026 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NdNiOd2S"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98D221540
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069097; cv=none; b=SnBWvSgUAjejOUn5/THUWWX8oE2VQDYZvWjjAJmx+NmQO4kJbebdcQ3t0Vx59lHMeL4Lxok/jPkpgRCqxC3zc9bCB/jTWHA46MhCUpo0IhJUqtdA6Y5RK2Ta9byYVZ2DdkzyPn8n+k46HA/C8KJyUqcMfhq5bafEu0KTnp274Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069097; c=relaxed/simple;
	bh=MzpFXG8atcvUeQnjJNkQdcR8xEQdP16k9WKPPys555s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw6ooAloWsEmoMwf7fYpjOM4mBPXABehQq7hFSTDBdwG+4Ut++m5qo//NuUCokKHQY+7fEvss91wftZ1/5TAvkrK9/2x2L0fxnmKtvLIJGjehvg8u+6ooR2js7C83Ytp1N6i5iZ/pA7Mka+k0qXUj60v9hOqYnna4qWETYwMEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NdNiOd2S; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M6YheJ2555628;
	Thu, 22 Jan 2026 00:04:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=bbGnh7XZ76BMbctuwwp6Z+KSn
	MttYMTxOPkdaWMiXc8=; b=NdNiOd2SxAcXx9J6VQphiofN9CUebs8/OU4ldUEEz
	PrQSy5d+zZ8zSmrWMf1TAv79/QywfndbQnZOXoH+J0gCt/cyfZDLGX9UqemPAg/y
	BcwQOqoPKn59sosPbeWYMcOJ465xQ03ge649TAMOCZLK8gaAE++LmL3TAUE21OXj
	5jUZUyuUQJFcfTlYLl5EXx+mGvmDPSnAl8GNKQbjKhEVa6++lUz5DuOFI8bdYW3h
	6dVoCTOk51yA46M7mUI3MlOk6AwjyVA/mIxCtqEJWy9scZNTPYYXHb6TDJgcyEic
	6YEN8NK6OXBhBPRD81KpQCUI6Ro7boMgSUTQpT8AlbqrQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4btm3kkpx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 00:04:25 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 Jan 2026 00:04:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 22 Jan 2026 00:04:25 -0800
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 6B1593F7048;
	Thu, 22 Jan 2026 00:04:21 -0800 (PST)
Date: Thu, 22 Jan 2026 13:34:20 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
        <michael.chan@broadcom.com>, <sdf@fomichev.me>,
        <almasrymina@google.com>, <dtatulea@nvidia.com>,
        <asml.silence@gmail.com>, <dw@davidwei.uk>, <daniel@iogearbox.net>
Subject: Re: [PATCH net-next 1/6] eth: bnxt: always set the queue mgmt ops
Message-ID: <20260122080420.GA1544331@kernel-ep2>
References: <20260122005113.2476634-1-kuba@kernel.org>
 <20260122005113.2476634-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122005113.2476634-2-kuba@kernel.org>
X-Proofpoint-ORIG-GUID: NRairLFkitDFFd_j5hrbkCMXr3JBlWnp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1MiBTYWx0ZWRfX3qht9lEWJ+qF
 AliE4tjVJqeThJ0LsNn1qhQ5dA42hy7eEAKuevf2u9e6vzWXN5hsIqqcZCuMZAYScZZlFWxMrt6
 IVYfmJiBQ6g1LzE46znl87rsnS7dIyv0frO8I/dOW4tspT0WZ/GaImnd571I4daUk2BMOFeAogp
 p4950z322JO9/406OxNPJLoo6MNJx6G2d0op9yKARQPhTnxqJcoSypR9/rtvQ8PGFZG/mjxcFOa
 ClLyuOg99ROMhO80wetQd2wiv/oZitKORHymkK3TfHbn7vix3/4C7CaTXBE+1OjOkvFYYhMomRc
 I/3yy+DB2bq1HsKHEz7U+1bwsrbUSt2ESHAG1yBNwlDeISwqOQHOGfT6bKncgW3HwrMzDu5UJOB
 3Mk3XOYY+IDdqc2aJWswtsvLl9T7gfvdhQ0gAVZL9o8mgngQpRAz+2RovsunlLIdc8AnsAujHJ3
 07jK/JN/qBhEsZOfdxA==
X-Authority-Analysis: v=2.4 cv=Mu1fKmae c=1 sm=1 tr=0 ts=6971da09 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=6VcI2bKbvKJvvJzL0UsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: NRairLFkitDFFd_j5hrbkCMXr3JBlWnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252239-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,marvell.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,fomichev.me,nvidia.com,gmail.com,davidwei.uk,iogearbox.net];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[marvell.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 17EB462E4A
X-Rspamd-Action: no action

On 2026-01-22 at 06:21:08, Jakub Kicinski (kuba@kernel.org) wrote:
> Core provides a centralized callback for validating per-queue settings
> but the callback is part of the queue management ops. Having the ops
> conditionally set complicates the parts of the driver which could
> otherwise lean on the core to feed it the correct settings.
> 
> Always set the queue ops, but provide no restart-related callbacks if
> queue ops are not supported by the device. This should maintain current
> behavior, the check in netdev_rx_queue_restart() looks both at op struct
> and individual ops.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> --
> v1:
>  - reflow code
>  - typo fix
> rfc: https://lore.kernel.org/20250421222827.283737-15-kuba@kernel.org
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 0e0c88c122f8..0b95100a7c36 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16314,6 +16314,9 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
>  	.supported_params	= QCFG_RX_PAGE_SIZE,
>  };
>  
> +static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
> +};
> +
>  static void bnxt_remove_one(struct pci_dev *pdev)
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);
> @@ -16966,9 +16969,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
>  		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
> +
> +	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
>  	if (BNXT_SUPPORTS_QUEUE_API(bp))
>  		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
> -	dev->request_ops_lock = true;
Can we also mention that driver with queue_mgmt_ops set makes it as ops locked
driver in Documentation/networking/netdevices.rst ?

Thanks,
Sundeep

>  	dev->netmem_tx = true;
>  
>  	rc = register_netdev(dev);
> -- 
> 2.52.0
> 

