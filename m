Return-Path: <netdev+bounces-256536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEYIKEC7gmnLZQMAu9opvQ
	(envelope-from <netdev+bounces-256536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:21:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6CE138F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6F0F31221D7
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C99D2DE702;
	Wed,  4 Feb 2026 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swDvoS60"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B5272E6A
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770175232; cv=none; b=nIYYFuXDnBwN8JSmmIhlhe8p7EWWynai2IqhFpb2LDE2vIftFgGbCzrnLqip36Vizoi/INcvBMvYwcCP2+Q8j7MM77rt4+ao7QaV/rJ+oK38H+LB+6oUeKuMT14fDnjko/Hjj6Gkgm065UqroSBaNlwPoyg+PXOnopCyVv5qx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770175232; c=relaxed/simple;
	bh=n8kzygSaDqnByreRup7+TGt4u1ndkgWYcrgyZfTZ6es=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FNNTjaNdjPEejZGUbakabY/6r8aqasOo/lRGkMjbgYgqF4mQA0GFGUn2ELon55RpAbmUFbpQng+eHdF4yK4Za03zw7OAs90Tjdt5Tjxx69xqfxHUxU9HoRnfouBdPPVWAIt3GWafS+d977VzbrdEhZ8LtOvzO/57kHV8P1ZBdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swDvoS60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E18FC116D0;
	Wed,  4 Feb 2026 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770175231;
	bh=n8kzygSaDqnByreRup7+TGt4u1ndkgWYcrgyZfTZ6es=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=swDvoS60lqZeboPFTQwA/fZ3xtCUskO6Ppiez2nmvluWl2cbd8BfFA4C/WBdGVeR3
	 DJRgNfVqaCyXuu0prC41O0Idn+ezJgNMaf/fSR4E4ZBMn4QIS+aT9A3AGcqhUVAMY+
	 ZfdPAt399xeY2wdHXsp4ODmtF0iIJdVv7GsbUhQ1HVRQhK/mVtFPDHMhQF8iRDQdU2
	 qutfEGYivukseoZJtt8f1zmsUDccT7IpsuTicfh2j0B9Mq+qclyCZ/WVfcdWtjIk0q
	 Q9Cbux44JZ9lxCE1DoMjw6ZjEAM4Mgw32X/9CnuEp94Wkyfw0J6mj9nLDKku0SXX9m
	 LDGKD140jpbxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 147813808200;
	Wed,  4 Feb 2026 03:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] bng_en: fix misleading error message for
 generic
 firmware version
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177017522762.2163463.775465686957603659.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 03:20:27 +0000
References: <20260202033848.22993-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260202033848.22993-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: vikas.gupta@broadcom.com, bhargava.marreddy@broadcom.com,
 rajashekar.hudumula@broadcom.com, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256536-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 0EE6CE138F
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Feb 2026 19:38:43 -0800 you wrote:
> The devlink info_get handler incorrectly reports "roce firmware" when
> populating the generic firmware version field.
> 
> Update the error message to correctly describe the failing operation.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] bng_en: fix misleading error message for generic firmware version
    https://git.kernel.org/netdev/net-next/c/1384a81e54fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



