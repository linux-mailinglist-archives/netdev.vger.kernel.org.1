Return-Path: <netdev+bounces-286659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN9xBuPeAWptlgEAu9opvQ
	(envelope-from <netdev+bounces-286659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:51:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD51250F573
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB5E93021F4A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FB03F54AC;
	Mon, 11 May 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="PMeH2Gs0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Six+pGaW"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F113F54A0;
	Mon, 11 May 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507428; cv=none; b=cdUjJ1/MFexV9kzwpHwlhPUhCo6dZVOCTY8A3i0PH6CSluMnzuNibQry8jHWnsiIM8rJ5BMXfjWcgmThT9SIPhlA0k4oRVYFQNOmbytYF5J5uGOUyW40fUivTuYgISM5/Z5v11fOlqTyfNUHRwc0hqolDRXBFhz6L/YEKBVoT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507428; c=relaxed/simple;
	bh=bE5c4a6p1Npfu8zc/F66atVHN8WwFv+DHmrlQEbCTiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP6cPh3UX01uwgEuTi4Wz81lwlWIte1bsoIQjerPpltIyxDzCk8SJQaSlwxLb3hmZitazxLNLI4dRUP5qduP9T4t9aaPuxSZLCigcAYTtIKpt/sEC70zBR9NfEd6iM7EfIei1J069qudoQuGh3IGH3dgitn14xw4/1Np87BZpVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=PMeH2Gs0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Six+pGaW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA586140008C;
	Mon, 11 May 2026 09:50:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 May 2026 09:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778507425; x=
	1778593825; bh=MQsEILfirhpSxp1+Vs4WVvqW8kmTFsbVLxudnGtIrB4=; b=P
	MeH2Gs0szePdtV+96HLDHwgOXkOKIenKtivQpsmvpZXgpEbTi5tsTZwghZd49tm0
	Q82SWxpc/Gni9XR66MqO3VWJscqOA+52v29o5AGY/LpjcmHmWq2j3gVfgsEObMpG
	pXPE0Vcm+tO/+OOG87YyyYvJcUe0PsNAHEKTGero/vgJWFy3OrXuqYPNbsge3LJl
	O5NKsInRKNK2ey/8Fd4qSkD9mYYneU2VI4WcLJEZLitaUHiftkUxBHy0I7XzGbsf
	um77Dj5mtl4D82TtPq8XpdbZDjAouJdEwts5qkmC1ukAuQg/JAQps5zTJu2WRk4w
	V8mVNC5csU94STdzQXk9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778507425; x=1778593825; bh=MQsEILfirhpSxp1+Vs4WVvqW8kmTFsbVLxu
	dnGtIrB4=; b=Six+pGaW8K5zqZboY3gX5T2Y93lK2vkRhakogFI7YYzWsizjpjX
	fMz+lznq6jm9NZTvFE6UzSWNPZdgWqtlfyACK0/7mANSBrpPHUkLpzgppbx4GOfn
	OKhOiCSCdNjK9jdkWfONlf8fT8njX9cmdrVrRojpMr2YB5D7vBtgkhqINwPUOk/l
	uv3EYREUttCmBX9vdl6z1TfW7b/VonTm1qHpwmRgxBsvDDYIs/xYJwJ+/3jt6kXp
	SV3b3pUNDnELH0JvER8QedLuUWrChiVusbYgzA1mnBsIVKGiUBgasq6ZsQwGxbWh
	+z25KZjD78Gc1j0OQHsCvchKhJwPoABGegg==
X-ME-Sender: <xms:oN4BamJa6ixhxq74ek9jGfPB3Q_eajvAXOLOI5W5uPOF3VpqZN-FBQ>
    <xme:oN4BajXP1CuxY7UIjhjJEBcLJBoBZyfRnKPMeVe9XTQastZp5XV_fOGShMeKgmD4S
    Hu2oKdPVY4zYlZd1ZdYtY6XAo7Ul5vjGTVzR-LLX9eeUzPqk4pPqGhc>
X-ME-Received: <xmr:oN4BaqFfDPaAqOor6rmbWzRo_CJp41ctFn3snb_DakBXF_PVeRQeFxrIGWoCAaGB9nxwCkjV5ecnRiKMotuxto4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeltdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigjhhliihhvghnghesghhmrghilh
    drtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhr
    tghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvug
    humhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpth
    htohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhhnvghssehs
    thhrvghsshhinhguuhhkthhiohhnrdhorhhgpdhrtghpthhtoheprghlsghinhifhigrnh
    hgsehtvghntggvnhhtrdgtohhm
X-ME-Proxy: <xmx:oN4Baq6cuUU2-4f7v-5wsfzQkrFRs5SB0ZEPVrQdNnNuJy_DugyLgw>
    <xmx:oN4Baoedr6kbCOm0abUH_8F6hFk9k8zPNxavtUxZQWdw7QtUT9uxGw>
    <xmx:oN4BamncoZKJvhGHfyRLwWT1ALSj8SKtLCI2se-MNulXcV1TvSSkUg>
    <xmx:oN4Bat-_eFzxbQcYc_fFdfRMeuUs28Faum7nzNwQuBtcMj3z0PcvWw>
    <xmx:od4BavUJ25oLseLN59PofDHUOpndXHDh9bMZ6HPM__rQ6kSUcsBXNe6G>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 09:50:24 -0400 (EDT)
Date: Mon, 11 May 2026 15:50:22 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: alexjlzheng@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	hannes@stressinduktion.org, albinwyang@tencent.com,
	shenyangyang4@huawei.com, kuniyu@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH net v3 v3 2/3] macsec: use rcu_work to defer RX SA crypto
 cleanup out of softirq
Message-ID: <agHenphzMNk3HEc8@krikkit>
References: <20260509033353.1814289-1-alexjlzheng@tencent.com>
 <20260509033353.1814289-3-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260509033353.1814289-3-alexjlzheng@tencent.com>
X-Rspamd-Queue-Id: AD51250F573
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-286659-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,queasysnail.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Action: no action

2026-05-09, 11:33:46 +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> crypto_free_aead() can internally invoke vunmap() (e.g. via
> dma_free_attrs() in hardware crypto drivers such as hisi_sec2).
> vunmap() must not be called from softirq context, but free_rxsa()
> is an RCU callback that runs in softirq, leading to a kernel crash:
> 
>   vunmap+0x4c/0x70
>   __iommu_dma_free+0xd0/0x138
>   dma_free_attrs+0xf4/0x100
>   sec_aead_exit+0x64/0xb8 [hisi_sec2]
>   crypto_destroy_tfm+0x98/0x110
>   free_rxsa+0x28/0x50 [macsec]
>   rcu_do_batch+0x184/0x460
>   rcu_core+0xf4/0x1f8
>   handle_softirqs+0x118/0x330
> 
> Use rcu_work to defer the cleanup to a workqueue. rcu_work dispatches
> the worker asynchronously after the RCU grace period, so no thread
> blocks waiting, and concurrent releases of multiple SAs naturally
> share the same grace period.
> 
> Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  drivers/net/macsec.c | 8 +++++---
>  include/net/macsec.h | 4 +++-
>  2 files changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

