Return-Path: <netdev+bounces-293806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN7PL9WkHWr5cgkAu9opvQ
	(envelope-from <netdev+bounces-293806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:27:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C2C621ACA
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60C9730420F7
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB743DCD90;
	Mon,  1 Jun 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr4tGw/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086A3DC865
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327144; cv=none; b=CFqC/mzDyLQ/n4dsjf9wznDLNy6553m7FYMr3SmVF8KWEO26XHKpuBQwKA8JRCzY0wOGhBp8WbenZ29Tl2gn8Lwi6uYZwXXh5yDw7Ur+938bfUyrhjaleQxAvyk7GcnQ7M99/ovT3/KxaOdMuoYBADO+SLSv64W4AZI8xsksE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327144; c=relaxed/simple;
	bh=PQO0UZwXLLelrITKmhXhC6F0znNCjfRA0kOIy5ZvCNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8av1+Vfx/HGIaxrqNgGTrUSelFxKxit8DWhlDYJ9+6a81P2naQGyPrRk2J+c1Umn4ShQ7P72NRG+aCHygqv82rKlBYFTM0Nz3P6ZpbuKggjXtN4wTsH711tHpmPlOHr8gnFCw4zve4xCr9Mi+TufCLZnb1kDTBHoPATatJb8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr4tGw/Q; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2c0c2a68d01so9886245ad.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327139; x=1780931939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDR/0d6767AKXu4Gbp+1FbUsOAvR4r8bVucFSVBkYL8=;
        b=gr4tGw/Q/FhooWcObcw2/szyDWZ8wkK15lcn36CakQOjov5TyO7oxkusGhs6mV28P2
         aQF0CjvkygHGfktnoQHH1oXFfKN454R8r7FWVdv07qtQlPbVu3/BYzmHLg11AwElZeEh
         /Fl45gYCucHNJFgwYHWvS1+tGN26C/6n/BGrihc7LCThEIFhA95T2e542MQg0nfDyQQ+
         geWuEeu052TH5vZFxUdlUxlYO2OnqhvGINOpJYVBJ8SE6VNf23euGXSo560TRRQGfh3/
         nbwFNu1JZEe+rI4yio0SVgxyJYkvSyIszcwV8yK2zuUFVn4fekcgjLT5sP3u1OLu9Lai
         OEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327139; x=1780931939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDR/0d6767AKXu4Gbp+1FbUsOAvR4r8bVucFSVBkYL8=;
        b=XxAZyEKA9g4YHe/N7YFAcP1r8CZ7A/YZCsqCuHG/2MhNEjMn1NuK8OWFMaZ6FeNXCq
         ch4ieZew7ptCQlTKOCCreIoEEQUDoCuV76wMrsLBAhPoBkeb59zMNOkLRG81EPzawu5y
         y7b7OYH9Zmfpe21NiLoFyvLDjf7Xi9w/y3gucAqlPtHlXDL1AztViueIq6PtRNb4UmCY
         mU9PCtT/7nG95O8BlsscX57iDjwtrnQ/jyIwg5JGGH/LOIGfwGEv0BZahZ/U62427ii7
         IqnKcnaDlLf4/wLBudUIpjWEG7XvRIsrcSaYlw6iZTcQJG9s41me2ahXxKwdx5jObXAx
         uSfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xJ2JT5UWO4R8fuD2h2NjDvo20mZA8HoNukkz0XuS8xkGuAzyXB6QTHDHRK+D/nfctk7w8YMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OaWJjm+rA/rU1UfxYOVRUZD8WVscaKe/fYNJZwhDO2/nvo9b
	2l5rkEpqcU2Xjo0lvaZj8xe4ZsDn+foW4feh9fC+NHkb6G7Tzr8wM8tz
X-Gm-Gg: Acq92OFJZTqaYmx9kVN2Ds1m/8l7m0wyYLd1lsHh4F2ldudkf1l5w+1BuoojSPP58bd
	b9p8DfExn5xBsOB60oxNy4WqxnztrLSw2V2W+/H4nAKLL6HnxY9t2CdXEL9zbofsPKJqc6wAi3t
	1dM6a1cPqm5f9IADnzM5BOzWkUn36Wq7A2ehQ2d4Z79Hqg+eSQVtYi+IOywVqYoclNuiMnpOWOz
	0JK3INPMaPtugINQX2YYo2EhyV1c35NVbm9TwZbHJQOzW1ffeU0PR/2SjftsKz1LhGfQNpVgrVP
	r8pUuA62aDMLpkU4RQ1HVD0xDOTG0FOIIpPFJGLtgw93gVKKyJGmR6pvANcAgsYxeuDC0qD9kVf
	7zNxDTVy6y+Ip6eX/Rqe3zQTvdZEgbnZha78ZL0XA1zDvDlN+F79UQfH32NKiYjahteMx1fzIhR
	QOFeC/ljAobYva40JToID2QIc5tUE=
X-Received: by 2002:a17:902:e54c:b0:2bf:2b84:c207 with SMTP id d9443c01a7336-2bf3688e46emr142931175ad.35.1780327138899;
        Mon, 01 Jun 2026 08:18:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b01732sm113263525ad.54.2026.06.01.08.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:18:58 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:18:57 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v5] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
Message-ID: <ah2isNZZycGgMNOv@devvm7509.cco0.facebook.com>
References: <20260530042630.80626-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530042630.80626-1-kerneljasonxing@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293806-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,devvm7509.cco0.facebook.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Queue-Id: E3C2C621ACA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/30, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The TX metadata area resides in the UMEM buffer which is memory-mapped
> and concurrently writable by userspace. In xsk_skb_metadata(),
> csum_start and csum_offset are read from shared memory for bounds
> validation, then read again for skb assignment. A malicious userspace
> application can race to overwrite these values between the two reads,
> bypassing the bounds check and causing out-of-bounds memory access
> during checksum computation in the transmit path.
> 
> Fix this by reading csum_start and csum_offset into local variables
> once, then using the local copies for both validation and assignment.
> 
> Note that other metadata fields (flags, launch_time) and the cached
> csum fields may be mutually inconsistent due to concurrent userspace
> writes, but this is benign: the only security-critical invariant is
> that each field's validated value is the same one used, which local
> caching guarantees.
> 
> Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
> Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

