Return-Path: <netdev+bounces-278155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ9xDDEn3WlpaQkAu9opvQ
	(envelope-from <netdev+bounces-278155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:26:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 900F63F15FA
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDAE93072A99
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C588348452;
	Mon, 13 Apr 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="icrcdejA"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88634C83C
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100874; cv=none; b=WU009vSQzGMuGSgWgiVwCCOSWqCht3A/bQ2a61fcXcwcv4F9fLm3OETVWBivAm0jd7Ee0jMWA5nipQIgBwnPBxQGD8xObg+YV4tkRlr4WNc2UMGzAkIY/8xnku1Zul/gqat9EnMBQhaqF2HjJ9HkXmbHalmapWBF1WTRGvbJogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100874; c=relaxed/simple;
	bh=SUU347PnA2orS95MeAT9e+Z9DGtBbu9oXGFkpwbHraY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yitoig5u6bERPmVnbwO9xUsT30EV8E0B08IxGyOQX7D1j2RB4OFoAAVi966HWLqW59bFnlf3z3DlgOA2KNbTGLoB8IbsmMZ/GWgddLbcMDI5gJyCscLYA9rMXecAQznRIf/kj+XslUzbo/eN19KFhEfl8hznY1s8G3mfv1jhEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=icrcdejA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pjxz/fgnnBC03Tu8UL2fUq1VGeVPq76m2IpbA43gCug=; b=icrcdejAiBtfrq02wsdu+Io0SE
	H+GVSyZk6ecTCtGuNEF4trTRieQbxG8gamUdSNjL39bzkvqJ+k9nsSMGnuYlS8nbSebHBCd5RpXxl
	lrRtCb4+J6bteEUiwb6vNJ2mcl5rBiXYbZKRPVBw+RYCCQ324/klhMpOMr22REq2HN8TpccP2oPPS
	OniBu/GQRl/mej/acgvwofzL8L2oY438kQGTE6osEpjlt4vIDAK19syeNtuD29rAiNPCdNEwjXryV
	mwG21sqvZa7DPGkx24qFVojU7Yo91y8p22kM5Sv4qyN87T/YNYDFo2ZBUmJIBj72h4vIv2Wof6UUD
	vxZ8YNJA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCKyD-00CS9u-0y;
	Mon, 13 Apr 2026 17:21:09 +0000
Date: Mon, 13 Apr 2026 10:21:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] rose: Fix rose_find_socket() returning without
 sock_hold()
Message-ID: <ad0lrloufxJyhhbf@gmail.com>
References: <20260413090420.79932-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413090420.79932-1-phx0fer@gmail.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278155-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 900F63F15FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 05:04:20PM +0800, Dudu Lu wrote:
> rose_find_socket() returns a raw socket pointer after releasing
> rose_list_lock. The socket can be freed by a concurrent close()
> between the unlock and the caller's use of the pointer, leading
> to a use-after-free.
> 
> Add sock_hold() before returning the found socket, and update
> callers to sock_put() when done.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
>  net/rose/af_rose.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
> index ba56213e0a2a..b32b136f80aa 100644
> --- a/net/rose/af_rose.c
> +++ b/net/rose/af_rose.c
> @@ -1,4 +1,5 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> +	if (s)
> +		sock_hold(s);// SPDX-License-Identifier: GPL-2.0-or-later

can you describe how are you testing this change, please?

--
pw-bot: cr

