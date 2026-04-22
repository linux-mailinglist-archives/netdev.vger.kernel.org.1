Return-Path: <netdev+bounces-280517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA7lLKQB6Wl5SgIAu9opvQ
	(envelope-from <netdev+bounces-280517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:13:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E82449319
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06113300998C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32F37FF5D;
	Wed, 22 Apr 2026 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kFe3PiTe"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699282882B7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877983; cv=none; b=H3LBgpuqKnosbyw4nIzbVRYTgGocFK98+Bwacfk1sfH94O0cylI9Nhrb/DNAaoy+08femkbG8hfkkELzgeTUcWPZ8tvseOcle3E/78tbhKR1GAoN9TqFFUSfXNEnJwvw0VFsgmkh9S3/g8Q1qsMycJ7VHlQw4c3DpEkt1OmobqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877983; c=relaxed/simple;
	bh=pzcdFik0gCzGgdcyGjVSniEZ+gJsEwSPJo5ybsiNWIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3SBMOQRjuNh3Bw7ewGY7oLI3XBTE+u9yC+6b67zKJ6HDkJ5zBjnxyf31aj0uTv7qQG0MvfkLVtnjHIQSARShMH1QKAPKCGeWjEnAKElQdeSx+dCJiEnoaMAR3DW2maAWsmvZhkssubhoIDTiYRFzIKHiDvc6MnXcFA5GBzY5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kFe3PiTe; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pzcdFik0gCzGgdcyGjVSniEZ+gJsEwSPJo5ybsiNWIY=; b=kFe3PiTersDIDQj4KYqgZ01kqf
	1K4dWkEJ9Uluc9dsdKvIn3TzcJ/UZEK/shHS5dl9TNZudUrxIqzfjnP6LPYsSzQQyGw8uKfGjMDMI
	TMAodQH/G573YRjKvLHk1If8BQ0u5s3kKterc2QlN460Zg5G+oKySL803ianp1BYvbkrot4HB5O1A
	668Uban75puxXzHWXwZnKmix9AbwAo6mdieVP2uXJxARRcA6lzlwfvm1GAKuhHdl/nHhiDeZsTSUo
	8s3o//buMberhjfOi/SPyLhZtW1vHGxRZIecwsveaGnXkh2VXkDmFe/om4WAJZmqDpFBCbjd6VP03
	Y69sIcKw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wFb8F-001mHd-2E;
	Wed, 22 Apr 2026 17:13:00 +0000
Date: Wed, 22 Apr 2026 10:12:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: add support for RTL8367SB
Message-ID: <aekBHVAEN1j54J8j@gmail.com>
References: <f5ac420f-0087-4af0-bb43-b9a5b6228fbd.ref@yahoo.com>
 <f5ac420f-0087-4af0-bb43-b9a5b6228fbd@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ac420f-0087-4af0-bb43-b9a5b6228fbd@yahoo.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[yahoo.com];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-280517-lists,netdev=lfdr.de];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52E82449319
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 05:58:30PM +0200, Mieczyslaw Nalewaj wrote:
> Add chip info entry for the Realtek RTL8367SB switch. This device has
> chip ID 0x6367 and version 0x0010. It exposes two external interfaces:
> port 6 supports SGMII and HSGMII, while port 7 supports MII, TMII,
> RMII and RGMII. Use the existing 8365MB-VC jam table for initialization.

This should target net-next, which is currently closed. Additionally, it
appears the maintainers were not properly copied on this patch?!

https://lore.kernel.org/all/20260412142250.131bf997@kernel.org/

pw-bot: cr

