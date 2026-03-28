Return-Path: <netdev+bounces-272718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFPJF2BSx2nfVQUAu9opvQ
	(envelope-from <netdev+bounces-272718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:00:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACC534D359
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0654A3024EE4
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E2229992A;
	Sat, 28 Mar 2026 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN17ULNI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD51D514E;
	Sat, 28 Mar 2026 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774670424; cv=none; b=ZG+CUslldUmslz6BWG+hRFad/PgOlBdg8fD0aAMy52d7QKATPMeXmugst8pRCkz8wFfM1pdZSn90McQFUPdtMV8yyw3egRLqKaYezC+wnJHLnNojhyLVJUOULDA1itvwalif/Hf6vnx65iQwi+osgnNzDJQAYXujp0Jzv1eRBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774670424; c=relaxed/simple;
	bh=yloG6ynr9Mz4f4H0bKZf9h5qR/VAUUv+IJoP+vxc1i4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qWe84WYMODX9KZO0mM3g/eRYr5UdVyE4QE0L8gHJ8Im1/yKCt+P2zMH5KjHL25hKAnPGRvGKm/fNXPZqnci9O43QrAKFEDyqZUOKYK85B9QWvSGh5kPa9dD7O8a1cP+z/M05dMXcurU1lDuJZFBVFVd8+LpPM35uMlMtLpzvYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN17ULNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA266C4CEF7;
	Sat, 28 Mar 2026 04:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774670423;
	bh=yloG6ynr9Mz4f4H0bKZf9h5qR/VAUUv+IJoP+vxc1i4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rN17ULNImDnquUgvHd+8DlYcRJm3XKxQoackE3BiPTObWDogGhGqMCe7ui5dpcUWD
	 PMolSBQlxFJR5/lsfahjUaGeLnIgKcT4IKW3/MYGYGSfSAka+GFhznCB7IDMnoKSlm
	 vgIwRQWyX2uDdG7KqLWW/SS1Me+E14ZeE14POrIiaQJ300fjH3QpGyFLJITNw6Mhqw
	 0NEvpD9A41pO8c4kHQDapnFBrl8nmmPrAM/2VX7iyO0bgxF6yFuZmWgisrajHTfRlb
	 qVufvxNeqwm4KlRjInhF5AGlv2hQuBF+PjmBpw9HVaOwCuCgmhncSJk/3ExZMTVz8h
	 Z83OStDjJbcLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CECA3930181;
	Sat, 28 Mar 2026 04:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: enetc: add more checks to
 enetc_set_rxfh()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177467040929.4173055.9412756951653552914.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 04:00:09 +0000
References: <20260326075233.3628047-1-wei.fang@nxp.com>
In-Reply-To: <20260326075233.3628047-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexandru.marginean@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-272718-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4ACC534D359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 15:52:31 +0800 you wrote:
> ENETC only supports Toeplitz algorithm, and VFs do not support setting
> the RSS key, but enetc_set_rxfh() does not check these constraints and
> silently accepts unsupported configurations. This may mislead users or
> tools into believing that the requested RSS settings have been
> successfully applied. So add checks to reject unsupported hash functions
> and RSS key updates on VFs, and return "-EOPNOTSUPP" to user space.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: enetc: check whether the RSS algorithm is Toeplitz
    https://git.kernel.org/netdev/net/c/d389954a6cae
  - [v2,net,2/2] net: enetc: do not allow VF to configure the RSS key
    https://git.kernel.org/netdev/net/c/a142d139168c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



