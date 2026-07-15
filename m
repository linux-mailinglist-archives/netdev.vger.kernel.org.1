Return-Path: <netdev+bounces-307712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tWkxI8VJV2qsIgEAu9opvQ
	(envelope-from <netdev+bounces-307712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:50:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C09375C0D4
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:50:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=vfnltAKj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307712-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307712-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 640013014342
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D5D3D5C1E;
	Wed, 15 Jul 2026 08:50:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664AF3D811C
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:50:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105408; cv=none; b=WJIcUVseZ65FxZGWAiyjYaAwABP6coWVLobsW677mGuFvcY6YNxZtNOy1Qjil8Z9Kuh6vWAQKKr611HEefTqUpWwpZXhmqoyU4YZncIzqeMoc4olpVTv497acgZi564DWG7RF/faT7RlKSom3X+gVCRKJWyVYUYnktcdYN3SHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105408; c=relaxed/simple;
	bh=I5OAkfmHEvsQbo1hvOZkHC/fWbcEfAyx7MnKvtFUAyg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=eK5uWW1wGCXr/T6kl9SCTjDrA0Z4hOu6tzP8JTpft7QNnwBSIM8jxHN+yemX6JL3rXHOam8v+UXqv+6kTjTXI13HEQPGju6ijJ3hkYfW7ycc2cBF+cxueXiZGcsE8fLmdBcl5hqqcB6M/bZhO2pJB3bkt3VjOAqkmc6wrPgHH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vfnltAKj; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260715084952euoutp0104a62a22ef5d0bb11dc9f91138f7f66f~CambUl4YD2214922149euoutp01-
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:49:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260715084952euoutp0104a62a22ef5d0bb11dc9f91138f7f66f~CambUl4YD2214922149euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784105392;
	bh=W+ZhuCKZnyUyI5mfgulmDYNya+im90TvyaU9a/3RrHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vfnltAKjC22aVV87YrEA6i9yZNifCxQpgooZdLtCDUkHiwbm8oK3c/rBoHWlt9kgu
	 TMdw1hvIE+X0ZukSnNggVmVJcwjWJWs8HlRN1JxcWrdHtEoTCbgHCipIs2w8iLiwqr
	 zFGza3P9/aoYKxgHF8s14cA5ed3wnsk3WdkSLLZM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260715084952eucas1p263586986449da01e2cca9851c4118919~CambGuAoD2082520825eucas1p2y;
	Wed, 15 Jul 2026 08:49:52 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260715084951eusmtip25a541156a238e99f8ef7d8ce7ba9deac~CamasCW5p1038310383eusmtip2T;
	Wed, 15 Jul 2026 08:49:51 +0000 (GMT)
Date: Wed, 15 Jul 2026 10:49:46 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: weimin xiong <15927021679@163.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, xiongweimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH] virtio_net: fix spelling of aggressively in comments
Message-ID: <aldJquLV8Up9o3X2@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260714024037.186799-1-15927021679@163.com>
X-CMS-MailID: 20260715084952eucas1p263586986449da01e2cca9851c4118919
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_34582_"
X-RootMTR: 20260715084952eucas1p263586986449da01e2cca9851c4118919
X-EPHeader: CA
X-CMS-RootMailID: 20260715084952eucas1p263586986449da01e2cca9851c4118919
References: <20260714024037.186799-1-15927021679@163.com>
	<CGME20260715084952eucas1p263586986449da01e2cca9851c4118919@eucas1p2.samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307712-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,linux.alibaba.com,lists.linux.dev,kylinos.cn];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_RECIPIENTS(0.00)[m:15927021679@163.com,m:netdev@vger.kernel.org,m:mst@redhat.com,m:jasowangio@gmail.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:virtualization@lists.linux.dev,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email,samsung.com:from_mime,samsung.com:dkim,AMDC4622.eu.corp.samsungelectronics.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C09375C0D4

------F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_34582_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Please read
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

This patch should target net-next tree and is not actively CC'ing any
maintainer. Use 'get_maintainer.pl' script to get correct recipents.

BR
Jakub Raczynski

On Tue, Jul 14, 2026 at 10:40:37AM +0800, weimin xiong wrote:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> Two receive-path comments misspell "aggressively" as "agressively".
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3e2a5876c..f3c7b28ce 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3190,7 +3190,7 @@ static int virtnet_open(struct net_device *dev)
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
> -			/* Pre-fill rq agressively, to make sure we are ready to
> +			/* Pre-fill rq aggressively, to make sure we are ready to
>  			 * get packets immediately.
>  			 */
>  			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> @@ -3419,7 +3419,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi,
>  			      bool refill)
>  {
>  	if (netif_running(vi->dev)) {
> -		/* Pre-fill rq agressively, to make sure we are ready to get
> +		/* Pre-fill rq aggressively, to make sure we are ready to get
>  		 * packets immediately.
>  		 */
>  		if (refill)
> -- 
> 2.43.0
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
> 

------F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_34582_
Content-Type: text/plain; charset="utf-8"


------F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_34582_--

