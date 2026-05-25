Return-Path: <netdev+bounces-291454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHbUOLexFGoJPgcAu9opvQ
	(envelope-from <netdev+bounces-291454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:31:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9645CE7C9
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AC31300BBB1
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0533A1685;
	Mon, 25 May 2026 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjhARh/0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31E399354;
	Mon, 25 May 2026 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741051; cv=none; b=sJbmeeqHuyG72T0dGEShhviB4RobgAP5TZs1g3/7OdnATkhB2nhDe5cis06BAjBHyQj2fuTCpeK5+YJ5d/fNH/Xfj7dEfzcjRK6Ffe5GRxuWPQAlklvfSIJEUQzHahBI/359Xks4C7rEdOtYDyunuFoxyXK3fXP6t2NfoIbaqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741051; c=relaxed/simple;
	bh=Gny49ti2kqHXkS4Oki8m16bWDcJv/L+PvEksWip2HOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxnVX8jumbFYMsags+4LTzo+8CnwJJJgf/4wX+AuKkvxHEIQ/r6SueCJwjIfH/hOBj8v7KZXLvjdn5hkbvDmUeWceTFyeWC80WQm7BgoEjn01dezj4iBaWQfbfnKzIJZ80uiJw1k/zdxRpduJLX0IWelZPmWacTXxHORQ3rqyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjhARh/0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA181F000E9;
	Mon, 25 May 2026 20:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741050;
	bh=Gny49ti2kqHXkS4Oki8m16bWDcJv/L+PvEksWip2HOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EjhARh/0ZKZh56PL7rCJALdojx7PAxqVfVJoagipLQacP7W95TtBzuz/VBw8PsRpF
	 XKI5ei+jOnUZkTElgI3yTMLiO3UcxJ6OwACWapHUiv6QfRLcU1EACjEerxXcSKKYS1
	 Lscal3GM33iTv96J88UIw/kPAoHpfpTgrp6eGSgem1PCjgPfo+h/1nYGcSZTKY3zmy
	 UUrn4vv9TZUis23yXmVyVh8tDJds2YLG3prXJkCN0YviVmnEjcNszhy5UzM4ZRG2y0
	 vOKGXAMrWiUWBr6c/bF7YvIdnNycAIh+G+d8uCBbQA8Vq3toNV0tklYk3+W0v2AqGk
	 nYGyls0Y4CJRQ==
Date: Mon, 25 May 2026 13:30:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christopher Lusk <clusk@northecho.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: net: add kTLS async split record
 regression
Message-ID: <20260525133048.2dc6d8d3@kernel.org>
In-Reply-To: <20260521025840.976378-3-clusk@northecho.dev>
References: <20260521025840.976378-1-clusk@northecho.dev>
	<20260521025840.976378-3-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291454-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BD9645CE7C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 22:58:40 -0400 Christopher Lusk wrote:
> Assisted-by: Codex:gpt-5.5
> Assisted-by: Claude:claude-opus-4-7

There are already tests for sockmap + TLS in bpf, point your bots at
that please.

