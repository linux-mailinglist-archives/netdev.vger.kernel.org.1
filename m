Return-Path: <netdev+bounces-297052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VNXEBPYXKGpj9wIAu9opvQ
	(envelope-from <netdev+bounces-297052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:41:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 011EB660ABF
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:41:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bTWh8AYf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297052-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297052-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C503430060A4
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEEC38AC65;
	Tue,  9 Jun 2026 13:30:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE328850E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 13:30:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011811; cv=none; b=TkZoETECdMKIHhZODGjw0uPHimmBL3YZWR7sfie9KKiEkWyo5aeZvnMvLpD3C4Wv6x8LK5lQdsQwpqS1nEWvcuIrCF8lX3d3vBNrZ2RvUch++X6dEYv8g+W5khZf/xtCivN4pSqhIoTWmqqx3akTfkIcFma+IIPXGv/Ij1RzRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011811; c=relaxed/simple;
	bh=fLLXdIlG+c1WK8htpNpQKmWEMgm10IiWOwSGccnoIc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t/zZLqcLsw5BfUHGV30gfgaEEtcwgm2XOzVNWx9vnqctRk1A5DOSxAFhQWbkEM8aer8Nzu0n7Oj442tTcXmkcV8RtzzRIOvbudDkZPR/Ud72Xn5OxQmw0/dMIUEr2d6DcMFb/nfemnqZAXBOcMTmh9qQH3PDjInRPJjNYFq/GkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTWh8AYf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9F91F00893;
	Tue,  9 Jun 2026 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781011810;
	bh=/yRustlpKO/BsoqJ5LoKaT/yPOd5LE85+DB3PDO9sFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bTWh8AYffpChG+So00/Qi2ZUmMuEoFfjLQc8MLo7Ov+bn+LWmBagIdDM5qz6w/SWK
	 awi4JXVUuBeUTDA1Q1syjIhzBLORGYMMpWffmAmvTfhGrjxHE5jN+IJng/+J2IKdYF
	 7+JfkNtv85d/ic1LwzxwQ/3pC77ETQRg5EgjNtwc4Ft32voPNn38me6beBCSR6hMvJ
	 S8b5a1t55iiJVpEyYEamtnKJm7Jq7Zh+wnSCsOU8PWh1iuHxstwO3QhX4lMztOV+rl
	 cb886wIX3vM2XiwbMtOjJfqNYMY4JrMqaXvbv0H3VREvj8tEid3J/LoxVSiuASbh4b
	 vK+AurQaIp68g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56E6239308D4;
	Tue,  9 Jun 2026 13:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: mctp: usb: minor fixes for MCTP over USB
 transport driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178101180914.2029912.4636936255342101999.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 13:30:09 +0000
References: 
 <20260608-dev-mctp-usb-rx-requeue-v2-0-29a3aa507609@codeconstruct.com.au>
In-Reply-To: 
 <20260608-dev-mctp-usb-rx-requeue-v2-0-29a3aa507609@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297052-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 011EB660ABF

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 08 Jun 2026 09:25:39 +0800 you wrote:
> This series adds a couple of fixes in the ndo_open / ndo_stop path for
> the MCTP over USB transport, where we are incorrectly sequencing two
> error cases.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
> Changes in v2:
> - Add fixes tags
> - Add re-queue note in 1/2 commit message
> - Link to v1: https://patch.msgid.link/20260605-dev-mctp-usb-rx-requeue-v1-0-b86993d01ac0@codeconstruct.com.au
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: mctp: usb: fix race between urb completion and rx_retry cancellation
    https://git.kernel.org/netdev/net/c/54665dce9826
  - [net,v2,2/2] net: mctp: usb: don't fail mctp_usb_rx_queue on a deferred submission
    https://git.kernel.org/netdev/net/c/881a3113b749

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



