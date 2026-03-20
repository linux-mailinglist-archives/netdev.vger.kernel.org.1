Return-Path: <netdev+bounces-269949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL6WG8xlvWlF9gIAu9opvQ
	(envelope-from <netdev+bounces-269949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:20:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A282DC8BB
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63835313E96A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B903C7DFE;
	Fri, 20 Mar 2026 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA1PoHio"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD03C1404
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018898; cv=none; b=R4I9hSuSHI7ENbXZI90i9dGfOG2MJTMkXSjVDw02mF7X2xEKZERViwRM31WyOlT/mqWLMDf9ec40a/z9Ts0u/OT9gVCh9tFaaYDMkdet3Nx+8bO7qiGbqufqsHWSROxOYGUW6Xkf6I7D1kcpKe6/gmpJl52zeZ4qDyQs8aktKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018898; c=relaxed/simple;
	bh=dKsUpyn2NKtJ5jpa/F4mcLLgTHirnEROKNm+qzVDoXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5CEfZDScpCVxUP78YYEEhomsUbTefMCoQJqwSd3Q123ITNZkRhrClOUDu1nrBrd9zG680LIokEzJRkG/aNggNt1eEn7uFYrhWku8u+Db6IhfXj86wGrMFbuqqZtHoOhjuyB693gg3GzIY+uMPR35oUYV/ReYpndGfjq8a+AdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA1PoHio; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c0c955a481so617670eec.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018896; x=1774623696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1+t74PZ37mjpgg0u6P8TqTzSJ8uiHRKeT0bk1Kj7kQ=;
        b=MA1PoHiovgoiWvr3jzVDwkQKKbfMTUlu41m9od8hIOYXclPkKR1JrT1crWlJpeOBg3
         ju7sYxDgGFmlVOzWRoCpw9XigjLy8po4V3vuFO8NAVOc0ReghHNNT8Mpk000Xt2LRXID
         VmCuzd2xd5R4yKhgMf7Azl2nZELbfziPcAJbZF5E3gakiEW1TKSKfti8W8BbnNJIQhOP
         EC8udA1UTTr3cdVerSUf0CT5N1ITk0NB4GXAtbPBVmrEnPErumg2IjmD/LTAgijuBIBu
         U7iwu9QbD4NYoB+7Q4NsJhuGwqG9/NIGOGKzcuysANky1wQDjwVGMVSnsA9OygHbzogr
         AiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018896; x=1774623696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1+t74PZ37mjpgg0u6P8TqTzSJ8uiHRKeT0bk1Kj7kQ=;
        b=FdV/WNRsuLJ2EyUB03jFVgP0Pxo+vewtJYYyB5oy5YO/2euA9hVTTduWBZ7v+YLbO5
         Z2iEyVL+qkBzABksDsjkrTB9qArWDLZieO3ce96XGa1Q0DY7a4SfIFDrK1yJtho4wHA6
         g+yWwwUp8iVm6sq0MgKjSBblEYRRjTV7MrrAvdWhmHc0r1EbgUhBOWGzPQdjlQNzed5w
         SZIxWUAzb9MOdBK/vh58wBgJpx5VQMWz7OD00lRB0rs+FBHDi/gk9ylBGMGU4nQ7I1QR
         rpO0HXcNYRGg7d8trrUviHkTr/tESRK5XR/IdKqGnp2nZlMuTDwRwECUqwZ30RfwtpEm
         WVSw==
X-Gm-Message-State: AOJu0YywYcu9iqV7D47lN1o7xdE3ms5PjGoT/qoviRtN+Qtg/c5PsGcn
	2NoEZALwtkJVONf2YeV+m2hpYIE8i6FUkdWKH6Yzl8Mc9gQ16Db5cnc=
X-Gm-Gg: ATEYQzxJ3Gd13ZsEzBw3jkba13YRCSx3TxtS8sk4Rr1h8d8A+3TQQ/ci6DQ6Wr/W6DY
	s6pNUQLpQTSmR1vZ/Ylk+eYtg7DhUz6+JVd4iP3HFnc/083uhX1ZtSZyLmkWx2p7Uq2583zU/68
	UhmfQkBsKfPC5U5ayOcIIicya6ZmcDvR/vqRIDr6hGsZhkl7m+3lgq5Tn+DVw1H/Y882zs9r5vu
	SgxFND1oPN+sgp/gGQXBLOmBoO4sYALvNxie10BsuE5O6zNNW2UEcIXTqpFy89wQXEztHmNO4Pm
	TrEPL5AhyUcG6dsdann8KByH4yro3c17+qyU9kCiTm8Wvf/pd/XqG+y583Bfdv1Y3awvRvSdKdG
	dBDnJCLrOpVU37qms7aJZi/mWXnzKXLHCb/ljlOIaMtjBt0BxpDEC4KTELOEnEhWB/o87vfWkxB
	VRfEIjfA5Y1+UCROxzAfhv5nIonLvqgEEMsrIsqBD/QWNGiDUR9zxXY06nfTmMV1eHIeWMcm5GB
	INOWHy61b44cGhT4A==
X-Received: by 2002:a05:7301:3886:b0:2ba:a1f1:2879 with SMTP id 5a478bee46e88-2c1095fec8fmr1786912eec.13.1774018895508;
        Fri, 20 Mar 2026 08:01:35 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2e6c30sm3345405eec.25.2026.03.20.08.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:01:34 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:01:33 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	larysa.zaremba@intel.com, aleksander.lobakin@intel.com,
	bjorn@kernel.org
Subject: Re: [PATCH v2 net 2/8] xsk: respect tailroom for ZC setups
Message-ID: <ab1hTRsbqS5dQ07P@mini-arch>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319175538.479139-3-maciej.fijalkowski@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269949-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,fomichev.me:email]
X-Rspamd-Queue-Id: D8A282DC8BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/19, Maciej Fijalkowski wrote:
> Multi-buffer XDP stores information about frags in skb_shared_info that
> sits at the tailroom of a packet. The storage space is reserved via
> xdp_data_hard_end():
> 
> 	((xdp)->data_hard_start + (xdp)->frame_sz -	\
> 	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
> 
> and then we refer to it via macro below:
> 
> static inline struct skb_shared_info *
> xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
> {
>         return (struct skb_shared_info *)xdp_data_hard_end(xdp);
> }
> 
> Currently we do not respect this tailroom space in multi-buffer AF_XDP
> ZC scenario. To address this, introduce xsk_pool_get_tailroom() and use
> it within xsk_pool_get_rx_frame_size() which is used in ZC drivers to
> configure length of HW Rx buffer.
> 
> xsk_pool_get_tailroom() is only reserving necessary space when pool is
> zc and underlying netdev supports zc multi-buffer. Rely on pool->dev
> state when configuring tailroom. xsk_pool_get_rx_frame_size() inside
> ndo_bpf is usually called when bringing up queues and before xsk's dma
> mappings have been configured, which makes it valid to rely on
> pool->dev.
> 
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

