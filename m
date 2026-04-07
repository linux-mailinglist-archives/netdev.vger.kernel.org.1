Return-Path: <netdev+bounces-275928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCbZMr/S1Gl/xwcAu9opvQ
	(envelope-from <netdev+bounces-275928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:47:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBFA3AC489
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8076E3036D6C
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56CB3A6EF4;
	Tue,  7 Apr 2026 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="oHnW/oTH"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DBB17C211;
	Tue,  7 Apr 2026 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555004; cv=none; b=uNo5cfBped9s5K1xZwa3bl6+QV6ysF9TUflkNQ2IUiCQoKK5cv0zBiG6Xa5k9wVcvsZFuPK7R8rgVYa5bOjZnjwNhGec6R0F3rugOglIdvzR46r38wC1dVKcgJ5CTvsch2B2qh8xi9dwdbylAAEvLuZGS+84A5Ku7B2hy6HOl8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555004; c=relaxed/simple;
	bh=Ap4r+tPeUBSMdbXyn++tg47PM7FG3DxtL85yOb4dXzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPoWXyYoRsabzfGhT5iEoQ2iG0kerAiN8xRYv3XCJ26H/aJeE/U323Wl/2GEwpZajr2IU+Y7bO++wXLP5f6AkX7gugAxunryxkksQq9rFXt5FWLiVtPMKiTtuCUBtWcvKkCGMY/esSxxJ50QDb+PlQAI1nKVFDYumKK2Gkl8GLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=oHnW/oTH; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AraoNOGQyrP4BGlaGUJ/u2QG8FiBKNZjkR45jHcTWQs=; b=oHnW/oTHuaVnhBozl2VUbZi4at
	0r7dtv+rit8eBlQjJiIPRcddLosvVrydj8MdEjn6dcIg1vwdZi3r4rF7OMpbx+JuvPzh7iSZMDl5s
	CHGAKLbF4WL54dsr5m//EMnSEezNYjwY9nlXCURfRiLk8pIEFQ5oJJSV+N+n1GgjHJNcPKyEiQ/sV
	PlXN+EdyHljcqQVK+dvbWhSAVD+fMirupOIOhEEpku/S2nXqSETrXPpEc+Uw+9b9c8RUMP4E7R1ke
	5cVFYt4fEHgImUasTWf7QQ/0DDoFBqBFCmoIwYhPqofZV04++i/Y4EXACQPAeYPDxFZWfkzTVVFVk
	m84qqHiw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wA2xo-007Y9m-25;
	Tue, 07 Apr 2026 09:43:15 +0000
Date: Tue, 7 Apr 2026 02:43:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: adjust to socat changes
Message-ID: <adTRoJTdIOs8mu9o@gmail.com>
References: <20260404230103.2719103-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404230103.2719103-1-kuba@kernel.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275928-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fomichev.me];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EBFA3AC489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 04:01:03PM -0700, Jakub Kicinski wrote:
> socat v1.8.1.0 now defaults to shut-null, it sends an extra
> 0-length UDP packet when sender disconnects. This breaks
> our tests which expect the exact packet sequence.
> 
> Add shut-none which was the old default where necessary.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

