Return-Path: <netdev+bounces-302864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iR1eDaoRQ2rvOwoAu9opvQ
	(envelope-from <netdev+bounces-302864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:45:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B12206DF6E0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:45:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nRgKb7+f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302864-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302864-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9B2230185A7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 00:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D62F1FF7C8;
	Tue, 30 Jun 2026 00:45:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF421C5499;
	Tue, 30 Jun 2026 00:45:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780301; cv=none; b=bKeXyt1So13cidrcsFRfMJCymYSmYfPMWAu25qN21onSkPq+w3Mr2sDH5WJlhCSHza0keFLFqsMFSMaZpIfgQaeHoaLOJX11Nc2I454kCMNG5KqiAUhwuPj/edEz3s7uJjKF+B/gZgKs+8TpoJevD+aZCWd3ty7PFrtlPdDh12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780301; c=relaxed/simple;
	bh=IfuNVk9Pm1YxFnvAwcaN9om6gmMbI+kZQlQLrfH2F98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhS9Gsh1Dvf5pFMwLsXo3scQyPasWgPwLM36FWC/Dcr+9aweH3IIRFAFZX1NwuYebWvpHHI+4QFvP5/LpaqWHdumnLAN/nr6upf/7IVUcc/JCcE1e7PjMQN/fJtdAqopZ6s/FTOWGB9KV7nIseGKtKr5tUghFcZsWLAnkreuWMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRgKb7+f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5B21F000E9;
	Tue, 30 Jun 2026 00:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782780300;
	bh=+l3CICuo67aRWRqku5fM9O3DdeBPgI0eiWBOS4epbIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nRgKb7+fJbFHDaGtdtNN89iGBNN4KJkid9aBsX7YDqA1mCO+Uu0Mb4s0rVxcfWM3k
	 lLsnN1EoKOMBCmbB9zP/EVKzRoPOeEdvD/0Jr+fenFJhNoTvRB8oXugETus6kB/eXu
	 j2B+c/X4Fxl5U8QEHjSoxRnUrpAGQ5WASoBskTJPozCkmKjevPpaJynKwLixo5pvOl
	 4Riwu8Elasgh3UcSZYhnAXS6lUiHxmA2kyXHnG0ST7Qt5Ef+IZTKtDKHKvcO1O4QZ1
	 ExwKGMGEk1SyPKQVSwa6MtVn3lYAm0yaElQGf5IxskLaRSzu75yDHEnL8N47qvkaUb
	 q1mdInduOUobg==
Date: Mon, 29 Jun 2026 17:44:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Tianchu Chen" <tianchu.chen@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: usb: cx82310_eth: stop parsing reboot marker as
 packet
Message-ID: <20260629174458.6ebf647d@kernel.org>
In-Reply-To: <700e16e9523d7f1299b00df75b13a3c66b6e517b@linux.dev>
References: <700e16e9523d7f1299b00df75b13a3c66b6e517b@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302864-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tianchu.chen@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B12206DF6E0

On Thu, 25 Jun 2026 15:32:04 +0000 Tianchu Chen wrote:
> From: Tianchu Chen <flynnnchen@tencent.com>
> 
> Discovered by Atuin - Automated Vulnerability Discovery Engine.
> 
> cx82310_rx_fixup() treats an RX length of 0xffff as a device reboot
> marker and schedules work to re-enable ethernet mode, but then continues
> processing the marker as a normal packet length. This is an out-of-bounds
> heap write controlled by the usb device.

Where? Can you be more specific in the commit message? At a glance 
the accesses seem to be bound-checked with skb->len.
-- 
pw-bot: cr

