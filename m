Return-Path: <netdev+bounces-286012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOECGOZg/mnCpwAAu9opvQ
	(envelope-from <netdev+bounces-286012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:17:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 100E34FC441
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7775130066AE
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAF839C621;
	Fri,  8 May 2026 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg3csxur"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507B30C354;
	Fri,  8 May 2026 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278627; cv=none; b=spmTQo9mnUaAVJ7kYsyThoQa8EtWswzXUNxXJFOyWiBfJpEx8VGfIVjFKghSpmME2k3FbZpMfxbSMcmwHGOPfK/dVexWCYuGKYUuitJB8Xv39Gj7UP0HfzSLd/NLslau/YhyhTYLhO+cihnlMTm2h7ZoBPP6/DDpfJatxgiqVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278627; c=relaxed/simple;
	bh=eqTk5pb5JyocaCQTV74wIppxWYFjYa11HBl05trmdNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6nJOHbNGUB8upaY5onGirIWD58sOEMIo6t7zvxsSWYLI++Y9cIVMpbOfTWKzdDH/2Oxq9WZVUQt9QYbKuZSCO34l4AwdvnwwJB4TFzUOVAEgvyv2NB93r84XDUN+Qb7rfcu43fVhxoGNoOmOHxk9usCyzGTaI/BOYECOj87q7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg3csxur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8A1C2BCB0;
	Fri,  8 May 2026 22:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278627;
	bh=eqTk5pb5JyocaCQTV74wIppxWYFjYa11HBl05trmdNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tg3csxurp/psDxpXOL7DfWtPv9bg8PwnwVckWoC0cZZdobXc8ZdMyQIfG2YmdsU2r
	 DlFNsdXkwpU6V3M3v+u/Klut6Pn8jijBUoPYRrIOXYdhbzQGRnBTEpu+vbGTj3GSEI
	 brjemlQ4htC+GR+KVq4UX89D8NnWp+sYeFq+Lk6vmI/9Hxs0nHKmVq5+PtyOJK2IR0
	 Q7P7dCdprByqQx3cUER6mvwAs9tUHEZUihs/vZKvAYVnopYP21ICESp443aLBV+0fd
	 YToMMNvEIuaTL1ptnacKwlT9E0ixdTHD/MawKvvepFHhGj5XV0gIQxMV5l7iYppDW1
	 uu3k5QrNVJ0xQ==
Date: Fri, 8 May 2026 15:17:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 netdev@vger.kernel.org, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: bridge: replace simple_strtoul with
 kstrtoul
Message-ID: <20260508151705.2d1ae5bb@kernel.org>
In-Reply-To: <20260506172447.9770-1-aadarsh.official.xz@gmail.com>
References: <20260506172447.9770-1-aadarsh.official.xz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 100E34FC441
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286012-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed,  6 May 2026 22:54:47 +0530 Aadarsh Chandra wrote:
> The simple_strtoul() function is deprecated. It does not handle
> errors or overflows correctly. Replace it with kstrtoul() in
> brport_store() to ensure that invalid user input is caught and
> returned as an error.

Your email server (or something else in the pipe) is breaking the
whitespace, this patch does not apply.
-- 
pw-bot: cr

