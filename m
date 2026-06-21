Return-Path: <netdev+bounces-300923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vNeZCU9hOGr2bgcAu9opvQ
	(envelope-from <netdev+bounces-300923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:10:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B16ABB59
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:10:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Vwwj5yvN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300923-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300923-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71D043007975
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AE9371880;
	Sun, 21 Jun 2026 22:10:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB79238D52;
	Sun, 21 Jun 2026 22:10:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079818; cv=none; b=Ru00lyIQpBAYxgxoweUP4kIfpNezyPiCDneekfhLTWYCi6Ps4Yq8JtnG+5TIQEtR3ZfrfK5hD9/KpWvcnRuSk3ZT+rNIHxBbl+RGEUBe3A/ukq6nsTS3sHOj+Yg3kMaORJ6/MtRKPiAQSIN5AI4WmAqoeYwx6MudmjygCim9sNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079818; c=relaxed/simple;
	bh=Uyg3eRl5v4a1C6gsO6m5BIXkqz+xetGogHGFBaAZaPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JFwx4IEx48vpb/r9GS2ERZdM2CBLQ8wcnYnkgI6NNutDNioMwpHYZr8ynKVTNI/SJqbsZbHnSzivlsV73f/PaTyuX1DAFhArKaBwACOrngR55Thd2Bo6xiXjH/9ym6yzZNFMSc7VI6OrEgoNN89ffIWhuTjciWXVax8IiHdno48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vwwj5yvN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE0A1F000E9;
	Sun, 21 Jun 2026 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079816;
	bh=pHC1WoSn6aMFSw9fjP/gWS/f9CHkI4M83Av3/TqxQUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Vwwj5yvNDKh4DXQueoz3WfG8JsdShLqd7BnAN9dGu5B/PMBunj11pAU8Rkn7k3Crh
	 Cs7E57dvNglSuxwZrQz29MP4zfo3aqqSyylnWr/CYUPXXfZBoHww7ZBd0LKK/csHUg
	 hUOcMvCqExeVFxysD367Dc5SVJnG/TvTA2AIKJ95QZgZPj2WTReo+IiwuX7Eedv8yC
	 TXl6JbDJg0BlJiLOWpNYSdj8KWCV8Q/oyHIMJgOv7Fn/VB31kBH9kYL2Gfd2UWFk2x
	 WbUly3QkZxsno7HTpZ0aXjWsAD6g4Qe/zOhOyVaISkGzYzIOIHuJYKpeGL+1CbHKqt
	 HzasZmyHodUzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B883AAA6EA;
	Sun, 21 Jun 2026 22:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_ct: fix nf_connlabels leak on two
 error
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207980801.519103.12458776189573385617.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:10:08 +0000
References: <20260617215708.1115818-1-michael.bommarito@gmail.com>
In-Reply-To: <20260617215708.1115818-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, pablo@netfilter.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-300923-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:pablo@netfilter.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 881B16ABB59

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 17:57:08 -0400 you wrote:
> tcf_ct_fill_params() calls nf_connlabels_get() (setting put_labels) when
> TCA_CT_LABELS is present, but two later error sites use a bare return
> instead of "goto err", skipping the err: nf_connlabels_put() cleanup.
> They also precede the "p->put_labels = put_labels" assignment, so the
> tcf_ct_params_free() fallback does not release the count either. Each
> failed RTM_NEWACTION on these paths leaks one nf_connlabels reference:
> net->ct.labels_used is incremented and never released. The action is
> reachable with CAP_NET_ADMIN over the netns, i.e. from an unprivileged
> user namespace on default-userns kernels.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_ct: fix nf_connlabels leak on two error paths
    https://git.kernel.org/netdev/net/c/16e088016f38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



