Return-Path: <netdev+bounces-295311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ha+vKIGgIWr2KAEAu9opvQ
	(envelope-from <netdev+bounces-295311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:57:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1DB641A44
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:57:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Uqp+2JVf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295311-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295311-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A211530BF3C1
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BD637E2FE;
	Thu,  4 Jun 2026 15:45:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377931ED93;
	Thu,  4 Jun 2026 15:45:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587909; cv=none; b=q/HBC9ye3B2JUzSHkPyvBMSBaLP3XO78FI8a1QFFglVYKK8wgYoPBoo6gcVkRcYiTGJdDuJDeWUrlTDbCbfgILBjlnkBPIZqfCAWH0Kl0TZKb7wP6diq7kQbSDYvv3CMjFETpfbAiO34pMnVJGivrPxbfICpIvPhHMd4eHQPeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587909; c=relaxed/simple;
	bh=7Vjgou5oMsAUP+bV9bMz64D3Q2RmTauvoo9g8niLyIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFVoFxTX3E4PDRpZXo2OsP4Xacam1mkKA5LFzvcT8Xo/gtTncgIG7T+KrRTJKMC1WzC0zX71vy4cnVDTZG6XbhJdFuZwapF4YSDv9IfIipracbjgCG2lVrtoR4D/V6y652caYEQqLBxwGMTlMtCma8PQpLQcEPJG04ISUtXoSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uqp+2JVf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1BC1F00898;
	Thu,  4 Jun 2026 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587907;
	bh=J6/Zc8Kntqruk++j6OsWXgT7GAK8IYpfolpCQp+mdPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Uqp+2JVfNkgM4DYirxsvI8dPAPY20KbRBU2RAzPe4pXaeY5l1Ui68DWZUIfPO3hfx
	 H2BfK9fBaLnouKZ85RXL4bSDV1nqG/yiZTXVZTYSz3PiJrGnLb6StT2pTf5PVNnAQY
	 UebUeKlG5F+Ztj6vVrscC2VEtv/jzch/UFZow0rvntiNS+4+GVXrCG2LhQ+pZn6Nh7
	 eIbyNd++z5R9TlaCOCG1RFnBc1tYm4IPX8MdXCasbq1kjaYuujIL7tZzMDsbj5wg5x
	 GxwLb2oUz2tTaMh4gipcMKzDiCzayZD3OpuSuJIulbb6FbA1P4WmiSJUgPj7nk5e1c
	 2gzVemjcOi/Yw==
Date: Thu, 4 Jun 2026 08:45:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Til Kaiser <mail@tk154.de>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Matteo Croce <mcroce@redhat.com>, Sven Auhagen
 <sven.auhagen@voleatech.de>, Lorenzo Bianconi <lorenzo@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/4] net: mvpp2: do not return retired RX buffers
 to BM
Message-ID: <20260604084506.274d0ead@kernel.org>
In-Reply-To: <20260602164635.62517-4-mail@tk154.de>
References: <20260602164635.62517-1-mail@tk154.de>
	<20260602164635.62517-4-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295311-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mail@tk154.de,m:marcin.s.wojtas@gmail.com,m:linux@armlinux.org.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:mcroce@redhat.com,m:sven.auhagen@voleatech.de,m:lorenzo@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,fomichev.me,voleatech.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F1DB641A44

On Tue,  2 Jun 2026 18:46:34 +0200 Til Kaiser wrote:
> The RX refill failure path jumps to err_drop_frame, which returns the
> descriptor buffer to the hardware BM pool. That is only valid while the
> driver still owns the buffer.
> 
> After a non-PASS XDP verdict, mvpp2_run_xdp() may already have recycled,
> redirected, or queued the page for XDP_TX. After build_skb(), freeing the
> skb on refill failure also retires the data buffer. Returning either of
> those buffers to BM lets hardware DMA into memory that is no longer owned
> by the RX ring.
> 
> Split the error handling so buffers are returned to BM only while still
> owned by the driver. Once XDP or an skb owns the buffer, only account the
> RX error. Mark page-pool skbs for recycle before they can be freed on the
> refill failure path, and unmap non-page-pool buffers before freeing them.

As Gemini points out the driver seems to be following the "if I can't
allocate a new buffer I'll drop the packet and give the current buffer
back to the HW" flow. So after your change on allocation error we're
permanently leaking a slot on in the buffer pool. Leaking as in it will
never be filled, if it happens enough times the pool will be empty,
and no Rx can happen.
-- 
pw-bot: cr

