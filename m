Return-Path: <netdev+bounces-258729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JXrA7vkkGnDdgEAu9opvQ
	(envelope-from <netdev+bounces-258729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 22:10:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA213D420
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 22:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5FB430059A3
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 21:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0ED311973;
	Sat, 14 Feb 2026 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrNJgHnH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08A3115A2
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771103416; cv=none; b=fN7SxqmAAGR9KW3YJHWEL4agXiaXuLmfhzXRdAYixho/sPg0gTfY/FonXnlViKO0pR/gAfREm3YK+uurMBabloKSDCnz4v1+c7mQR/L5RcJ/7Bh6DRz/2i9cHhDQkKrfSAbJsW7sspVnz4p+CE5vkafoyIYpnUB2n0cDLOjAm4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771103416; c=relaxed/simple;
	bh=7kaUQxEhVfFysL1JzcBxYK+t3yg5Sp0fGkUcKR6inAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cwn62+ErgnZI7ogkI56huxOhnAcrLaI9Er95iEsUqNEzc02Sj+0DeUZbg9W0Qjgky+lU5WiPCmElfGJUrcGIJ5wrCX6Po7NoMzNGnpa+s2Azp8enHE4D+mUBQxwefF9h4HES79NNEZEKUy7lFfwfrqw2uPpJS1IIAcT+m7wYfOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrNJgHnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0A5C16AAE;
	Sat, 14 Feb 2026 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771103416;
	bh=7kaUQxEhVfFysL1JzcBxYK+t3yg5Sp0fGkUcKR6inAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hrNJgHnHjUDMOsvGChxjofmkYewYNW9l+FjZiOolGVM8uAg0TTkfvtTS07dq/0gaq
	 7zWJ3MTGIPqOkx9ls2hQKJ2VXcW0EXR7jPuQUouS8191WeEWW2c08TK6GF6d8INpXJ
	 wCvfw0xeUOxnafe2qUJ5HnSZPeu0v3hd+PPKwufb98PFbogzh/vbXcwaEvQiRB9Gua
	 cIbh98cn/HF7Nv8rdxoExhZTRwut11GfT4hS1/A+/nUF6pQACBsmMsPHtvG/4WqFpJ
	 b5m2+m5tZI/a3Bb1CCWxcSBEmrGcS2n9qJuP/jBvJYKcKcfV7zweh6ndGoDxVgW0c4
	 6SJMqt70BR5fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851C0393091F;
	Sat, 14 Feb 2026 21:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool v1] ethtool: add --show-mse netlink support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177110340908.2902005.18220812521324209200.git-patchwork-notify@kernel.org>
Date: Sat, 14 Feb 2026 21:10:09 +0000
References: <20260113142031.555787-1-o.rempel@pengutronix.de>
In-Reply-To: <20260113142031.555787-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: mkubecek@suse.cz, kernel@pengutronix.de, netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258729-lists,netdev=lfdr.de,netdevbpf];
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
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,8.in:url]
X-Rspamd-Queue-Id: 5ECA213D420
X-Rspamd-Action: no action

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 15:20:31 +0100 you wrote:
> Add support for querying PHY Mean Square Error (MSE) diagnostics via
> ETHTOOL_MSG_MSE_GET. This exposes MSE capability information and the
> latest available snapshots for supported PHYs.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Makefile.am      |   1 +
>  ethtool.8.in     |  46 ++++++
>  ethtool.c        |   7 +
>  netlink/extapi.h |   2 +
>  netlink/mse.c    | 388 +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 444 insertions(+)
>  create mode 100644 netlink/mse.c
> 
> [...]

Here is the summary with links:
  - [ethtool,v1] ethtool: add --show-mse netlink support
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=de3d3c94132c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



