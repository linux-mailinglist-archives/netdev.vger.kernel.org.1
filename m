Return-Path: <netdev+bounces-294403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oXRvNy4/H2p1jAAAu9opvQ
	(envelope-from <netdev+bounces-294403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:38:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F414631CB7
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:38:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Nf8zsoAS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294403-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294403-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 807CA308195B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FA22F12AD;
	Tue,  2 Jun 2026 20:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436633D6D5;
	Tue,  2 Jun 2026 20:30:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432210; cv=none; b=TjAxRP4y0p68YlPRbr3lTmLBG9bDpQtasQjaC8mJIN82HGsf8MY65wGi81kr3XJH3U3rJCBfMbLx3Ih4iX6TbT6lEtfh+HRPhfz1OUQMZtXQ9VfZw2ZcnKQ+sinl+CY3YMkAXhVoXs4rkzWV45VV33Cv2pJUsRFduDodFOcNnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432210; c=relaxed/simple;
	bh=63Dgdq0YlzvEZBLTeRuw8lb+q989qXocQQexbTPACP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3pE6IgX0Xaaa0txoKV7NcT/1ZagH/bbVqUpnNHTUSSs9jcme6ZJuBNkAM5ndXpn1jnML9up6xaPABSqhxh0UVWCmeaxi1tuijFScLKsc6HMf/2hQJnMN3kyDzuAjP06prJNV9hfdN0AJ30CGOqe4b9A70l2U8VtVb8w8j0nIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf8zsoAS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5301F00893;
	Tue,  2 Jun 2026 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780432208;
	bh=N2dbyBYbKnrRgkKys8ws2C6hc+8tSeDInqk6T4PyfUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nf8zsoASy3H8XRRFc/kP6g3TxaRQaqa4svhaPO/d+9SOw8f1K2pXIReu5/BIxSvry
	 0ApP+PcxRGNrV2a9lnNGUpQj5Iqdbs2tWHwgWQ4tWzgW/Q4x8B441qPmncuLssxmrW
	 4bvQf1aUekl9xxvdktTakP3N+UHe6+bttAWU+0cYTQKhAfW2MFze9HWIEPX7APEFpf
	 SHAbHJak7Fxnqor3wfo+9gPTIy+git83HESVLgjJelNJt+iQChMUx4I3dzCnSDtqMH
	 SgkX0PzEAB4QHVHhYUJLCDtZ526zYxhyh7Y7m/07r/zVY6hqzcAcFCVUZceV1nojOP
	 OKCNM5XERJSpQ==
Date: Tue, 2 Jun 2026 13:30:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Breno Leitao <leitao@debian.org>, Eric Dumazet
 <edumazet@google.com>, Ernestas Kulik <ernestas.k@iconn-networks.com>, Kees
 Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2] llc: Fix race between sock_orphan() and timer
 callback in llc_sk_free()
Message-ID: <20260602133002.3ed70fc3@kernel.org>
In-Reply-To: <20260529020059.3024038-1-xujiakai24@mails.ucas.ac.cn>
References: <20260529020059.3024038-1-xujiakai24@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294403-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xujiakai24@mails.ucas.ac.cn,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:leitao@debian.org,m:edumazet@google.com,m:ernestas.k@iconn-networks.com,m:kees@kernel.org,m:kuniyu@google.com,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F414631CB7

On Fri, 29 May 2026 02:00:59 +0000 Jiakai Xu wrote:
> In llc_ui_release(), sock_orphan() was called before llc_sk_free()
> stopped all LLC timers. A pending timer callback
> (llc_conn_ack_tmr_cb()->llc_process_tmr_ev()->llc_conn_state_process())
> could fire between these two operations and dereference the
> NULL sk->sk_socket that sock_orphan() sets, causing a kernel
> page fault.
> 
> Fix the race by moving sock_orphan() into llc_sk_free(), after
> llc_sk_stop_all_timers() has completed. This guarantees that
> all timers are stopped before the socket is orphaned, eliminating
> the window for the race.

Sashiko points out that there's more issues if the timer runs after
llc_ui_release(). Can you reliably reproduce this? Have you checked
that this change is sufficient? Sashiko says that llc->dev may
disappear even tho we don't clear that pointer in _release().
-- 
pw-bot: cr

