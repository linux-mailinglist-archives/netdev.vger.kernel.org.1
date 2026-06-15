Return-Path: <netdev+bounces-299531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I4doF7QnMGqXPAUAu9opvQ
	(envelope-from <netdev+bounces-299531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:26:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EE268857F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iBf7qqqM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299531-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299531-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1666C30DA147
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C4F3F210F;
	Mon, 15 Jun 2026 16:15:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AA3F4840;
	Mon, 15 Jun 2026 16:15:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540157; cv=none; b=q2A4ETxC3+HDz7k6IbVB4Ee415az/Npbu3D4fUSI4mpx+rz5ex7tCt3bZOMgzi8gj3S7UpxsDkG50+6HK1r9ZVW1C0PH7UgmcZERkHNpeE5TTLTKDV6Co2fuIYTck0gibKNz2DKUZQ2glXKcFdJ9U9hrQTj+U3q0WrkFo9WZajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540157; c=relaxed/simple;
	bh=ELuhMg5L4/O6P9axI27xSC1eehDCn3+dcYe+GRH9I1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uy8RWQ095HOj0MqRNaABuVeSi0eDkbPIyNZqEY0+7BXi7MoCgjoebZGuxHJSPidGbaR8j43aluWuODRY6cKrtOpnfZuHxBhPXMP/NJb93vk/5po9kiAMB6afItuirqZXkICyC0dloER0yzU7wJ70rI6iyA+YUreIizdKwx6dqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBf7qqqM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89C41F000E9;
	Mon, 15 Jun 2026 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540156;
	bh=ELuhMg5L4/O6P9axI27xSC1eehDCn3+dcYe+GRH9I1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iBf7qqqMUjy7kdPxVRh7Lx8De/+AJrRwcVpLga02OpkURzWiUXnmU4cUQCpG+/wJO
	 ijyHMqayhEMxqhL3mca3r9wAdzbLw7LG7vRVlXamKAQ6YAxTTGiWnVojl99kEKk/i+
	 vXVtTfwcQm1zyCS/dTKlTm4JkYrx5xmxn90Y1QP1Ww1FHZwIwMy4Vi7G66kJ9LGare
	 AjEtgfInXwwGqwb9coEUKkvatU7O0p0fDXRD5N2MjgFuFlFe6mCDBQIapZlAI+uwVh
	 EPcgHQZg39S8oNN5QH40UwU74/+T1qzSka8gdxjtA3yhR+yzijL0YEghgi6MRZQIfu
	 TdMoDf3YeQOfw==
Date: Mon, 15 Jun 2026 09:15:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH RESEND 1/6] sock: add sock_kzalloc helper
Message-ID: <20260615091555.4af017aa@kernel.org>
In-Reply-To: <ai7JfHTFgFt6YN_K@linux.dev>
References: <20260527082509.1133816-8-thorsten.blum@linux.dev>
	<ai7JfHTFgFt6YN_K@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299531-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:horms@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3EE268857F

On Sun, 14 Jun 2026 17:32:12 +0200 Thorsten Blum wrote:
> Gentle ping? Patch 1/6 still needs an ack from netdev maintainers.

Perhaps other maintainers shared my feeling that this is a waste of
time.

