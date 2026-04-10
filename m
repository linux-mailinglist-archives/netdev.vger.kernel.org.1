Return-Path: <netdev+bounces-277475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIjoDVkj2WlrmggAu9opvQ
	(envelope-from <netdev+bounces-277475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:20:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C3D3DA4F0
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0C7330E07B5
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF2F3DB62F;
	Fri, 10 Apr 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FztbtUtl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEAD3A75B9;
	Fri, 10 Apr 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837216; cv=none; b=mNozjxfXgRTcv+ucCbK3lVrfbu8PfwWm1rOzYi2u6IciSqdbUHQK3d8lCPxpkfCDBcJ6GJ1Iis5m+yWo6nuyXKfQRm3ZAfqRhKSOLQP4N9XT1wW6sns+qhlfCQtv1VVN0rJP/Vqf9L674Qb+eMriawv+3WRd0eL9buzUlK8XSZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837216; c=relaxed/simple;
	bh=IhHZ84Es2FjRKggMP0PTb/HVf8NvQGxpztAFj1YNKew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AcX8T67Nhobo4qwqFzVXTwEbWUzJeHuIXiqtreb8ILf7pm+ml1ueKw+8Zfixt4DDzhXHYP1C3n9bDl808Uy02zdJmVs/YM3V98azKLd9Kk90nyxGWoadxDHqVKetUTEUMHP9gwg2fRbZcyIBwmq2K9DWWRfJ/FPD5fxpuYqASiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FztbtUtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF234C19421;
	Fri, 10 Apr 2026 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775837215;
	bh=IhHZ84Es2FjRKggMP0PTb/HVf8NvQGxpztAFj1YNKew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FztbtUtlHo3yKuLzLIYI6kefZSnztpabAmkjj6ZCWZd2icIODkYmNPg1gUUaNPlL/
	 OZH0Uo4aWu4cbQXB/Tw4LjCQrXRhKT8IeaLE1JSyhzhWLHjajYPHjl0gnTKvQ0t/jg
	 hUpS+y2O6NQioqTfYb3P35fmd2620B4kvH7bIX1WZxdLNRXZqPn8c8RsjVf1aSLHPz
	 qlu87wS9WLlP45573JSi5w9lIQdQMNq3KfAscsJ3ZSVN8qZGD/SkyniXXlgzIFgN8s
	 33VHEh6V6XpxO0RbL6Uqvq1F27hZK3ebNkerIORkDkQEAD5iQL3zs2yhWi6zOz7E06
	 ZZKtz7oGXKhbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F523809A87;
	Fri, 10 Apr 2026 16:06:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-03-12
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177583719029.2534919.5279430998060479778.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 16:06:30 +0000
References: <20260312200655.1215688-1-luiz.dentz@gmail.com>
In-Reply-To: <20260312200655.1215688-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277475-lists,netdev=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92C3D3DA4F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 16:06:54 -0400 you wrote:
> The following changes since commit c38b8f5f791ecce13ab77e2257f8fd2444ba80f6:
> 
>   net: prevent NULL deref in ip[6]tunnel_xmit() (2026-03-12 16:03:41 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-12
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-03-12
    https://git.kernel.org/bluetooth/bluetooth-next/c/74c1e2737bd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



