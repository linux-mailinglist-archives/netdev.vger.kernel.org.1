Return-Path: <netdev+bounces-269183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFmEBjoWu2nYewIAu9opvQ
	(envelope-from <netdev+bounces-269183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:16:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8592C2E81
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0351F301EF36
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8739346E43;
	Wed, 18 Mar 2026 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="Uh+4QSff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51E2D879E
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868599; cv=none; b=sxECkjGy13vyzbQFNpd/wO1t5LPg3Ruej3+VxmaaSXYPa3SoAYhOs3+PcVPvAjDVZOZ6l6efMDtIvP9BQhYOvLYoC5Yy41A2BxF2gaTJNlXKFfALOo261B7ovMHC2v+lG4+wBbpCrbHps26VdE+qLk6vhWjNzbJIm3jw8GKMywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868599; c=relaxed/simple;
	bh=P//KxE6W/5Y+HAxi/f5cOXKna4n5LLIU7027UToyg34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1qUTZJEkXnPsr2iGo3mJ4QWWmHrlNqb7Tpo9O2aXyY9SQ8hyvg9+XRYYCQt3QmrNL0/BtjOtvhxN/JWYB5QyTmTiSj2RpvbvtUovv4HX/u1d+A8IlsTny5HCptzTcmScb13nFUUe8rq+DAymQujBAdycs7cMffOJ1WllODOaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=Uh+4QSff; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso196271f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1773868597; x=1774473397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JSbsrYhFg+Au4jgvX758AnPNxCSSto/QgL2aLSvMGI=;
        b=Uh+4QSffM1uGTLyOEOiMET9Q9ElpLzCKb4XanROgT477VE+9Z7Imhlvsbho+yNIPn/
         edWoCR/vrz4sOfms3aCJk2GXaXp2BB7vQ0c3By8j7A+p+dBzfw3wxMpSL9kuBqByFlOa
         jfVZeQQS+NyWj6eAT5LYWSwgsc2nPYQ3Q9oO5wjeUmCW/56DH2QmP/av+CgqUY9sFedv
         GG74szR+s1k8eICg6667X6jFJTG42+2ACKcGpARFX7Bdo+aad+qUFXxfNubA+21WP39I
         KVIzj7YOZ8gJ07/eygvoApUPGkQ9vOuodL9AWwguT+7Rsuhja8VWzSOIFkm0jbIpckep
         7KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773868597; x=1774473397;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JSbsrYhFg+Au4jgvX758AnPNxCSSto/QgL2aLSvMGI=;
        b=VncMUAbFyszOlszLqtHNLcM/MHls0jePUdPf9xEo+3u1CfLbxrMlBgBfxOEv6pRCVo
         TX7sKIaWEm6kdIKnQT0tqbGGdTp1d/S7rbxScg6EpKABuTgWqeC128bJAqPcrPmLaEzk
         ExVu7PhtVyqbqt7qwRRTG7hgDqJCTTbAtOzMgt9mLHzg/jmBJWS78s3AUCbUAgAbuIHA
         sMhL484LG+SlbUAy76/jxCcqiLVH8ga3lfmFTkOeH8kP+0gkpBZpSyYJxpysrjQuLR/M
         qKELX6pYhs4Ffdsz9pvugye8f6QiahL0VjF412V1jw/UhhJpADmQYo7MparUX4PgOlSp
         Fylw==
X-Forwarded-Encrypted: i=1; AJvYcCWOyZyGssiZwxCs1xR5tcOJ3NWeTG1O10rDubUtqYyc+Wx7oa1wLAtNig2D+qrVpSGN+baeD/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEuUhJP8MwPdKEMzfAT4y+vzbezSC2dLWJNXH+ILMwQAvsuNr
	2t9pM2DCJYA/+uRmEigxKfoU2gzrSpERDNC6yEpNEiMbOUi0oJ5UdMxgsvVGxm/jzJQ=
X-Gm-Gg: ATEYQzz7FIPwV01c5RKeYg5Rf5/+gWR/LEdh0iJjhZ7prA7k+ne53DTKwM84FnAuby+
	/yDz5ZMzDMdq0imXwMN1GZ/AIK32go98mUjkJsenSCT3HZdVKwid0LTMxlYEm0HSid3ONNoVhtA
	1VsqcEvwK8Aw5TxktZI+rZe32aOUtLm1fH5j7KgjmA4Rlladu5KclsncXSQUpIoPOadN10iUCVT
	ph0TDIB+8CpiLKaN5asB6/+9V5IDzOLh6Y9Yxw78bKONpInwympWiiOLa7rdn8ugO+sUfd+GnyC
	aI/TUuXu/FgXx48gqeoCZehCKr21mNgGQiZ5fvTnvovHEJ1bhttBUBxHj3mwmJr0hegrkVrA1Xf
	a2sPjejxLbCN1nrTi88Pw94njepQWCE7CTThgDRQ2ty9Si4sPhnS5b88rdtYyNLC0fp4N0I3DHe
	QQh2lRUoHtT9xCcXXHMeu+DTPcKtWEhpJmov+Z9w3twd0VnRO6CGV67CSR8zqepjfYKnUjvbFX4
	lnO2gwkOEVMVZw=
X-Received: by 2002:a05:6000:608:b0:439:c69f:503a with SMTP id ffacd0b85a97d-43b527c4df0mr8143039f8f.27.1773868596733;
        Wed, 18 Mar 2026 14:16:36 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892244sm11628020f8f.22.2026.03.18.14.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 14:16:36 -0700 (PDT)
Message-ID: <6b696861-ac39-4a87-a2fa-ad47a75031c6@linbit.com>
Date: Wed, 18 Mar 2026 22:16:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drbd: select CONFIG_NET_HANDSHAKE
To: Arnd Bergmann <arnd@kernel.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@google.com>, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260318104858.1868731-1-arnd@kernel.org>
 <20260318104858.1868731-2-arnd@kernel.org>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260318104858.1868731-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linbit-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269183-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linbit-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linbit-com.20230601.gappssmtp.com:dkim,linbit.com:mid,arndb.de:email]
X-Rspamd-Queue-Id: AB8592C2E81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 18.03.26 um 11:48 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The TLS handshake code is optional and has to be enabled for DRBD:
> 
> ERROR: modpost: "tls_handshake_cancel" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
> ERROR: modpost: "tls_server_hello_x509" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
> ERROR: modpost: "tls_client_hello_x509" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
> ERROR: modpost: "tls_get_record_type" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
> ERROR: modpost: "tls_alert_recv" [drivers/block/drbd/drbd_transport_tcp.ko] undefined!
> 
> Select the option whenever DRBD is eanbled and rework the dependency in
> the symbol so it can be selected more easily.
> 
> Fixes: fa8ef6960ebd ("drbd: add TCP transport implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/block/drbd/Kconfig | 1 +
>  net/Kconfig                | 4 +---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
> index 29ec6ed84251..de9e232d6479 100644
> --- a/drivers/block/drbd/Kconfig
> +++ b/drivers/block/drbd/Kconfig
> @@ -11,6 +11,7 @@ config BLK_DEV_DRBD
>  	depends on PROC_FS && INET
>  	select LRU_CACHE
>  	select CRC32
> +	select NET_HANDSHAKE
>  	help
>  
>  	  NOTE: In order to authenticate connections you have to select
> diff --git a/net/Kconfig b/net/Kconfig
> index 62266eaf0e95..769880113740 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -92,9 +92,7 @@ source "drivers/dibs/Kconfig"
>  source "net/xdp/Kconfig"
>  
>  config NET_HANDSHAKE
> -	bool
> -	depends on SUNRPC || NVME_TARGET_TCP || NVME_TCP
> -	default y
> +	def_bool SUNRPC || NVME_TARGET_TCP || NVME_TCP
>  
>  config NET_HANDSHAKE_KUNIT_TEST
>  	tristate "KUnit tests for the handshake upcall mechanism" if !KUNIT_ALL_TESTS

Thanks for the fix, I applied it to our drbd-next tree (which should end
up in linux-next).

I would prefer to squash these kinds of fixups to keep the history in
our patch series clean.
Arnd, does that work for you? How do you prefer we handle attribution?

Unfortunately I couldn't really find a clear precedence pattern for
this, how is this usually handled?

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage


