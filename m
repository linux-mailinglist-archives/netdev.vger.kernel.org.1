Return-Path: <netdev+bounces-283905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEMIGbW4+Gn1zAIAu9opvQ
	(envelope-from <netdev+bounces-283905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:18:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D534C08D7
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB130307D5FF
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D67D3DFC93;
	Mon,  4 May 2026 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So+A9Jim"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F113DE424
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906455; cv=none; b=F58dZEtamn+KrUjcBA6JbYcX0Ftm2L+xuCHdbEVa85nImVN6oD19/l7IdcUVqx4qd/44QOur/LnWbYXFmJZJ6yLqf+xekPIC9kljy7RZ0pTSxpaXi6LKdatT37kLqoSGetHt3AA7fohdAjlCLy7vmyxbFBNm7lII5CItmRYQUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906455; c=relaxed/simple;
	bh=6wZYZofD5XBH7p3dPRhe98oA4McZcgeESmYvHekXAmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn+PbWqwOuoSPRG3BHEi+osWydRvHCaRQ2RE1aIo8LLmcEzMYl+WIJimKaZn4P0YSML8B8RUohwnWDlo04zWn+gLIzc5bvuC7HKvv4KaoA+1tZqX6clkv3Au3lSuGuV57MTCo5z4f9vXsYXIGrSeSuO7c6Pn1TYnWMDSAZRopXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=So+A9Jim; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2b4650d5f5cso15450575ad.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777906452; x=1778511252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsUMHAzB3E1Lhy1w/m7z6HnCWQkTFKvmq9eCCZpqQi4=;
        b=So+A9JimTyzK40ologFi+5r1sfoeVEZMeK7snc8OfqEbzevesSh/dpqZj1hZaN15ta
         es60B5nqf1WB/589/jh/2XM/31iB2JpY1/JicywP+Aaa/yw96srFpQGlPY4ZdLWlZvuR
         vE5VHFl6yrCxUV9slFebKlMrDcw+lc+S8zTBUUn52EXDpyXO7t5ycGY8+2Keloxm+LDB
         zVvKgwwDrEAG7ia+6Fuuv1HVJf0DVCRTF5P4l91vpbTfxr2lPDQzUiD4PwLyV30OHKjp
         U1HU1wBDGf0zozUovcQ/P5HJMeuF32OSuG4ZfwZ2hBl3M+7Qv36SSdIWgBh51QuCL9e5
         0vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906452; x=1778511252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsUMHAzB3E1Lhy1w/m7z6HnCWQkTFKvmq9eCCZpqQi4=;
        b=YeDc/257UuarRw1nu3sCNClOikicJ1vBtZuLcIqrljsvufZh+G3MSibo0TovtUdHXz
         ZyPN1KOMdlz7tyc7q9JFSs1JRenuwQKwzHzd4b3zielDjIeZl4U1k3NZChLZABWLuBjk
         HPgpHfJwfinFsHuRj3KwsKX/IUET0dbn/3PsT6DHRAMufMRG17RX2xJE86n94ZasfZo7
         sDUaPOceKPp4rCpjNFSfFQcJVbEBpAgHZww80cfotHeBEhRp+P9osbxsUUQ9Qdk1OGhO
         OhHAxUYLfC0RR8mGvmGuSfMQuv12NVIzFPlW/+Hb9BCtGiQWM93Nv2StG/lrxIWFFrfi
         P0aQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SuwgbYHQYJSXzwtk0f7BaI90GdW368MysyovZLwmhRLqGevY1yK6WDg8o4C/ADMWdFWbNqm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtvoM5WWtUOgaaXc8mWkYJvvbmXbLkodboz+RXOyq80lVKxk2
	ZP/KTCa/eLf06Oi20A8gQDMitAUR0P4f/ZgjuFb35KrcrPGIMcxmqjK2
X-Gm-Gg: AeBDiesi5qaPOHX571MVJfGYLYdrQHNnFb2jSSVaEp6dq76Wr2NolgyXmGBIIwh5ZmE
	sNbuQxEn38IC+arOm6HRWqs0H6SXs5+vMbRGSbMvG2IUVbTJWPG1merxqQd60tzcP1i/xp1x62a
	Q9Nh33UB568+J9l4kS+ytQDmw+WkeWy8yGmg+hY+yibH5Y+/0hPKM3C+dTRmvnqnFebTEEOhaPC
	6fF5pOs7dxMt8QT4zsXDAY6hID0nSiVoNIzxYg/GH8ZLoylkAQ5VxijoI6F8AOFRDQQEBwz4Hxc
	NF/5ozKevoOGQx60Swe8BqGj/gCyUSZj4m+tfEMMeLB3CPBSd/SJEYv66n1fpBU1D+yuA/HYY7r
	CwLzWvsRJUVhM4AagJzVOOPNfzS3lIIyBhJosFJE4hqDiTbP4PcK2nFiUNYnABd65FZBpSiArYc
	S2R03tKEQtk8HKqu2z6/d3qEM2KAc=
X-Received: by 2002:a17:903:4b4b:b0:2b7:88d8:efde with SMTP id d9443c01a7336-2b9f256dcf1mr95395225ad.7.1777906452391;
        Mon, 04 May 2026 07:54:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae4a127sm142842165ad.67.2026.05.04.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:54:11 -0700 (PDT)
Date: Mon, 4 May 2026 07:54:11 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 1/3] netlink: convert to getsockopt_iter
Message-ID: <afizBv-egs3PPbTE@devvm7509.cco0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
 <20260501-getsock_one-v1-1-810ce23ea70e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501-getsock_one-v1-1-810ce23ea70e@debian.org>
X-Rspamd-Queue-Id: 69D534C08D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283905-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devvm7509.cco0.facebook.com:mid,fomichev.me:email]

On 05/01, Breno Leitao wrote:
> Convert AF_NETLINK's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> - For NETLINK_LIST_MEMBERSHIPS: walk the groups bitmap and emit each
>   u32 sequentially via copy_to_iter(), then set opt->optlen to the
>   total size required (ALIGN(BITS_TO_BYTES(ngroups), sizeof(u32))).
>   The wrapper writes opt->optlen back to userspace even on partial
>   failure, preserving the existing API that lets userspace discover
>   the needed allocation size.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

