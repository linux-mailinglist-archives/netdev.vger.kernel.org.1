Return-Path: <netdev+bounces-264641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBEgGepHqmlkOgEAu9opvQ
	(envelope-from <netdev+bounces-264641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:20:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B35F21B005
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 450923002E50
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D9B30F534;
	Fri,  6 Mar 2026 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0yajPTW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362401E3DDE;
	Fri,  6 Mar 2026 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767203; cv=none; b=p0O6zevPJT3Z+EGhirOpG0npFlsN3Np8wU2NGItdWZDV0+sR9t4itlkqyJ9XEzMnlAgCg96SLxWHwUwEYi+ln5JCC+LiKrkOtfAgrRQUqeXXn1Xwy0YFUxBKTNYXS6HdPOamXMgGZRzdgYFnFxW0EidWUmINsF/i+6rMnzOi7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767203; c=relaxed/simple;
	bh=D/z6UnDkgHvDdSn8bobeBH2eE2oF4oe9gXPC+g60INg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wu/IsWD/S/q3+oAnjSCziyMCGFEiOJ932Qkm1OCo+5k6x6NrEREb+uJiXvBSvHEkXJ/WQahP8Kh9IA6cOOXEIwDzSHUsTge6a0nraD20fk6oky2py4VUnTKqJt3udT5X1aFSxQSjvMeyOLcaf60Zs4k5z5LesDkllMzS7YJ7cXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0yajPTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44001C116C6;
	Fri,  6 Mar 2026 03:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772767202;
	bh=D/z6UnDkgHvDdSn8bobeBH2eE2oF4oe9gXPC+g60INg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X0yajPTWG2Yk8g/wRoN4bq5aefh0qMQyjV52i7LRM2nBazrYgixWHo/wd5+iPdZpv
	 bmMuokY/vHp0x7GSkDGwcFGcZ+hbbDVd/kavvdtWLLgGVGFVJBiOZcBZHnBR6P08uu
	 9isUsJcNBJDWQXeKaPhft4IWyWUB5m4FMe6JY4Eba4Wdhbu94yYeE0Amgsl6zjwXHj
	 adx1LPOFhnfbRJOuvKEYpugjhASiD3xGhkWn49uCUypvbhAYwWyNOrZL6gDnMrjEo+
	 PK/CD9nIlgSXqx9tllPQLUkR0UaH5Vx3rjH+8Y06q2Mxj4vPVO5JFfqK26JlwygOu5
	 E/1PHC120tH0A==
Date: Thu, 5 Mar 2026 19:20:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next 7/9] selftests: ovpn: check asymmetric peer-id
Message-ID: <20260305192001.1e70393f@kernel.org>
In-Reply-To: <20260304230643.1014-8-antonio@openvpn.net>
References: <20260304230643.1014-1-antonio@openvpn.net>
	<20260304230643.1014-8-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0B35F21B005
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264641-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu,  5 Mar 2026 00:06:25 +0100 Antonio Quartulli wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> Extend the base test to verify that the correct peer-id is set in data
> packet headers. This is done by capturing ping packets with ngrep during
> the initial exchange and matching the first portion of the header
> against the expected sequence for every connection.

AI asks

> @@ -2204,15 +2217,15 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
>  		if (argc < 7)
>  			return -EINVAL;

The CMD_CONNECT case was correctly updated from 'argc < 6' to 'argc < 7'
for the new tx_id argument. However, was CMD_NEW_PEER also updated?

Looking at the usage text, CMD_NEW_PEER now expects:
  new_peer <iface> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]

That's argv[0] through argv[7] for 8 required arguments (indices 0-7),
but the check at the start of CMD_NEW_PEER still requires only argc < 7.

With argc=7, argv[7] would be NULL according to the C standard, so when
ovpn_parse_new_peer() passes argv[7] as rport and calls getaddrinfo(),
the NULL service parameter would silently produce port 0 instead of
the intended port.

Should the check be 'argc < 8' instead?

