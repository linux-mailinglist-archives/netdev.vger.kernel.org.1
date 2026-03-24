Return-Path: <netdev+bounces-270977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIitOQdnwmmecAQAu9opvQ
	(envelope-from <netdev+bounces-270977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:27:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBE63066F1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E80B307C263
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C60C3D6485;
	Tue, 24 Mar 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHmSVP8K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679853D524A;
	Tue, 24 Mar 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347620; cv=none; b=cOw8LAXPfsTx2TMJTWetP8gvoXqpd+pVXvBpFXvI264HjiDhEI5HZUPmFtPNBxUVy6MGd+U1YegaJ8DsFghYiIsB+SR+4U2vITVu+GB0RhFd1PvWm2UtrK5NBm4Ck1WwnxVudc/tjF7fkQZldRgihEv9PV+2P6+Da5SgDz865yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347620; c=relaxed/simple;
	bh=uQPsNdIXoBcuzaVN7/3i4rnLMCLoiHbqiVgK7UP4cD4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SyCWjdh01Qhg3ee9fAP817AsU39L9gdeaIaVPkeE++dTuBOFYm0Wk/YYlTUKYmOxEvRHvNTgWjQwE1om4A6e0Bm4jTPSVTCpYccOnCpXkDKz+XrKxY5paOZDL6btxcduQLLaTj0VmmsPJde2pTsqkB1hrqbnhovbbd38BSjgWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHmSVP8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431ACC19424;
	Tue, 24 Mar 2026 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774347620;
	bh=uQPsNdIXoBcuzaVN7/3i4rnLMCLoiHbqiVgK7UP4cD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FHmSVP8KmsBYChTa6/3x4AhKN57N14KCNlKcCURSkq/YsPQuTLoGci1cRiHSZcCoa
	 Ig6Wd4mgQN2D085TQuOSYcDGxTOY7EEQhlROIo0BGFJzZblpToEYdl+A5XEeGrZAip
	 vrPZXIla0JytPl2j2k6hi+ZxGEDSHBAZEv/ShUBMBFtV88FL0oYKOd6HlGi5Rm+Z76
	 cdHYxG9pKKeZSEMjJMXtE1tezA58sjoCW/VrECwgkov+smCd1AMdZL9hb90ldpwn+4
	 tBNTnfd0mWWm+ZiOo1PNQJqBM5dUi/6KNuht2J78Gw74InFlgEjQfF8XiEY2m+1CJj
	 LXx0F2oH2iSnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF6A3808200;
	Tue, 24 Mar 2026 10:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] net: cleanup bitmaps printing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177434760829.606554.7988116286884528295.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 10:20:08 +0000
References: <20260319201713.941956-1-ynorov@nvidia.com>
In-Reply-To: <20260319201713.941956-1-ynorov@nvidia.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, sbhatta@marvell.com, sdf@fomichev.me, kuniyu@google.com,
 brauner@kernel.org, yajun.deng@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@weissschuh.net, yury.norov@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270977-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,davemloft.net,google.com,lunn.ch,marvell.com,fomichev.me,linux.dev,vger.kernel.org,weissschuh.net,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EBE63066F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Mar 2026 16:17:09 -0400 you wrote:
> Bitmap API has a bitmap_print_to_pagebuf() function that is intended to
> print bitmap into a human readable format, making sure that the output
> string will not get big enough to cross the current page limit.
> 
> Some drivers use this function immediately before passing the result to
> scnprintf() with no modification. This is useless because scnprintf(),
> and helpers based on it like seq_pritf() and sysfs_emit(), take care of
> not overflowing the buffer by itself, and perfectly print bitmaps with
> "%*pb[l]".
> 
> [...]

Here is the summary with links:
  - [1/2] octeontx2-af: simplify rvu_debugfs
    https://git.kernel.org/netdev/net-next/c/6e4235adfa88
  - [2/2] net-sysfs: switch xps_queue_show() to sysfs_emit()
    https://git.kernel.org/netdev/net-next/c/de69301dc2f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



