Return-Path: <netdev+bounces-302298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mk8/OkEvP2ppPwkAu9opvQ
	(envelope-from <netdev+bounces-302298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 04:02:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9356D0C51
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 04:02:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FxppuCnD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302298-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302298-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 027CE3098EDB
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AABD29C33F;
	Sat, 27 Jun 2026 02:00:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BF25B0A5;
	Sat, 27 Jun 2026 02:00:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525642; cv=none; b=sB5A3AKHUB1bDN89EqITf1Bk/Kk5/nBhHyenaoApMWENn2VKcYf/ou4mI3IdW0wDDkkNWR4w5KTlb5z4F6PxiigkVwh5ThsgEPcc2FI6u2YVdOS2x/0kiGS0bTap/jY9VQnG6rT4B3A8yVEEFLRQK5nJBSesPcmv/byYXOdpw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525642; c=relaxed/simple;
	bh=EFjoQt5Foug5DO1fQU0jSVTrUzZcJmb2zgIrDvDBDJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqepE5PGjWhGgcP1KS+cG8qT7hlU4VFZwAti6W6VvwB8UdXyXZFRW1adufYrapx44J5rqB0nYlikDV89y7WortVPj6BMEYJBX6dzKffDbgwIj6AmcYbAQH4OlBqF0ZmTHUrUF9H/4AA6Nx/gL0ClF+BVMqaNqXvM/92bqqK2+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxppuCnD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CC71F000E9;
	Sat, 27 Jun 2026 02:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782525640;
	bh=88bgxuwezmvW1f5k01honCxuGEX4KlXiyI8bc/EBdw0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FxppuCnDzKfLdAShoKxwVfgAarciUROYgZhZpMTule5FdxAQPSI7GcwYCJtFPd7Yy
	 JIHSeUN/EPsOJoulTbOjPLEBDIYgnvAq6FMKIZY/2CpHVLCjGS95Fzr4eeuZCuCoKk
	 I4ZX7Fi7U4eMlBG8CPDSKJG7FIJMIygv+PUgNhIgT9eIT/8IOKPGzR5xXCUPxsZhxs
	 mpEkh/fxP0uW3vLAvT1+JEMkoMF2+IkSUXs3JqgnSzlsg0YgV2664tgO5VTypWyWql
	 HUJ5Bq8L/jV2fguPlB4IB5ToLwTPCn8S9FioQLlogLBV5xXCI8thIaErSzS4F6Noxw
	 htpVL796wZkJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B3C3938C76;
	Sat, 27 Jun 2026 02:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] seg6: validate SRH length before reading fixed
 fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178252562681.1167656.14195813566936530803.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 02:00:26 +0000
References: 
 <20260623-f01-17-seg6-srh-len-v2-1-2edc40e9e3e1@mails.tsinghua.edu.cn>
In-Reply-To: 
 <20260623-f01-17-seg6-srh-len-v2-1-2edc40e9e3e1@mails.tsinghua.edu.cn>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrea.mayer@uniroma2.it,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 m.xhonneux@gmail.com, daniel@iogearbox.net, dlebrun@google.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,uniroma2.it,vger.kernel.org,gmail.com,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302298-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gnq25@mails.tsinghua.edu.cn,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrea.mayer@uniroma2.it,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:m.xhonneux@gmail.com,m:daniel@iogearbox.net,m:dlebrun@google.com,m:mxhonneux@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F9356D0C51

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 18:32:31 +0800 you wrote:
> seg6_validate_srh() reads fixed SRH fields such as srh->type and
> srh->hdrlen before checking that the supplied length covers the fixed
> struct ipv6_sr_hdr fields.
> 
> The BPF SEG6 encap path reaches this with a BPF program-supplied pointer
> and length: bpf_lwt_push_encap() and the SEG6 local BPF END_B6 and
> END_B6_ENCAP actions call bpf_push_seg6_encap(), which forwards the
> length to seg6_validate_srh() with no minimum-size guard.  A 2-byte SEG6
> encap header can therefore make the validator read srh->type at offset 2
> beyond the caller-supplied buffer.
> 
> [...]

Here is the summary with links:
  - [net,v2] seg6: validate SRH length before reading fixed fields
    https://git.kernel.org/netdev/net/c/a75d99f46bf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



