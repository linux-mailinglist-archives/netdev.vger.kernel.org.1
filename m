Return-Path: <netdev+bounces-289213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCGkFViqC2oGKwUAu9opvQ
	(envelope-from <netdev+bounces-289213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:10:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6153F575678
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E1F7300682E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A92DF68;
	Tue, 19 May 2026 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha5DRlT5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A818050;
	Tue, 19 May 2026 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149394; cv=none; b=N9uHHh9hkjPYZo/SQr5Cp5iD9eGdTqrJ22kNitnzbfHkStksHDlyDstMbccTX89kqHm5P5aVmDSRU20WrIMOZoEcaqd7dtHUWUZyAQuqqp48YUroOunRCBfkQS9z720wxwgma7GLlcO8nIPUC60pRjXZyKEM3/Oe4cqV+eXjEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149394; c=relaxed/simple;
	bh=lyISGJ5yikv7/4Dt+NfDcoU2PfgKAB9pVCbpQG7n2TE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K+sfjltoBpe7CGZU3mbm541/bfu6c6fEKX4FaS/8dYdG7bU8MT+Fa3WGbaLrei+yQ5zVMoQjae3Ii3IE05J+WJTXQG/cZks6v2lWloAN1iXg3VO8lknGBamk4U6LGGnrP+oFax0LYCiXOheVoHuHQjULTkKSxwwbQ54CsbPJ7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha5DRlT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE84C2BCB7;
	Tue, 19 May 2026 00:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779149394;
	bh=lyISGJ5yikv7/4Dt+NfDcoU2PfgKAB9pVCbpQG7n2TE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ha5DRlT5ty3EB1/OFLH/yF/Bimj2JC6MYB5lfZJ/l+UIVFfOamvKFor+bM16DzU5/
	 vei4J2gjYzN9nRboztw6KX1xcUToc96hZSLZVN7G7Z942zdxS2ifdQWIi9ViVT63Lb
	 r5/qxWybw10zXsuZT/64nrOR1Bvapg9p/PuKFwAHMVkTbX5eqETSFyGC1DZWoVTni1
	 lAbaUU+oqGoRSWd7fJ+k8xUjJ12+HHUCwT0/j7LIBoXXJJEJ074fodm4TDL0lpuK0s
	 GhpCBcdFz4cmtn+Fkfm4+jWUU/zyoBtYyf5/CMb1U70sf1thOdpfAEGHiDOObyn+vj
	 AW/HbLSTYy+bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1992D3930CBF;
	Tue, 19 May 2026 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] [net-next] dibs: Improve DIBS prompts and help texts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177914940589.2022878.2427907339862915854.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 00:10:05 +0000
References: 
 <9093259c43e5d1996965d1522562444419196a19.1778838921.git.geert+renesas@glider.be>
In-Reply-To: 
 <9093259c43e5d1996965d1522562444419196a19.1778838921.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: wintera@linux.ibm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289213-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6153F575678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 11:56:02 +0200 you wrote:
> The Kconfig prompts for the DIBS options read:
> 
>     DIBS support (DIBS) [N/m/y/?]
>       intra-OS shortcut with dibs loopback (DIBS_LO) [N/y/?]
> 
> Clarify the DIBS prompt by expanding the acronym.
> Capitalize the first character of the DIBS_LO prompt.
> While at it, join the first two lines of the DIBS help text into a real
> sentence.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] dibs: Improve DIBS prompts and help texts
    https://git.kernel.org/netdev/net-next/c/62badeeeb929

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



