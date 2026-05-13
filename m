Return-Path: <netdev+bounces-287422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN6+GI31A2rKBAIAu9opvQ
	(envelope-from <netdev+bounces-287422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:52:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B237852D04C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBB16310CDB7
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB6397347;
	Wed, 13 May 2026 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmlKm4b9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631FC397342;
	Wed, 13 May 2026 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643998; cv=none; b=L/dheyUc8jBs6Z6h7a/IIajz8fQAID4qhiOZ9HuGv6exBNImJlt5jhQumEl3Q1nO4qt30EdZmrhBRFaDz3EO40IZNpYnz1UfF9gTV3yAfMt/MLqz5EGTNLgjxkQKEjFC5ZJwZbs/SiLfBRtlGRHvn4YhUA0AQ+FkQC6bIwUPUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643998; c=relaxed/simple;
	bh=5kBKh+efbz/R7U8lgQVz2iAarBxxhLdKzm+NAVy2U8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kJSlua+QGSGaVZmjR+xMAfYqFN8qJi+7jABveXR3ut3UxlGAx9u/xWfIgdve7wcTUW8xKBWGE2qm5G4MSVpNRIARgqom8hzMi726AJolZ3iQdcAEmYg0nPq+isA3br8awrX8dANfSxx+GgADZM4wlEBbcYbg6xGxtwqkqrzliyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmlKm4b9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E84C2BCC7;
	Wed, 13 May 2026 03:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643998;
	bh=5kBKh+efbz/R7U8lgQVz2iAarBxxhLdKzm+NAVy2U8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TmlKm4b9abb6JKh4V8ph+BmXPZU9WXRblu4/uSfFmp4h7X4LWpFDr/6MTpM4tmSLb
	 wpTmkhDfLbdbGMV0g6emnjTMGq+i7KwpFlw3aVvHNPjDP5IyvmQ91LYpA5cc3JlmEj
	 xcpTKi13Ua1zGvcMOoyoYTZ8BpQmHaU3VVvw8MUGRVgW8D0oJx04klsqpeOJ5IH54E
	 40gNQxYDoGRbsvxuHxaCQsvDEb9xwqgrXUZjbIvuAEjeEDcbwjQBjcjdd0kuc63hFd
	 AV3r9krgU8bjn+i6WZcccstA3R+b6cQhecT28bS+PHd+j6E5F/8axVLa630ZWWcMzz
	 RndOENPZ9lS1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCCD3822D60;
	Wed, 13 May 2026 03:45:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: intel-xway: fix typo in Kconfig
 description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864394404.3173643.13190738323269805779.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:44 +0000
References: <20260509210900.3968447-1-olek2@wp.pl>
In-Reply-To: <20260509210900.3968447-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, dumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: B237852D04C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-287422-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  9 May 2026 23:07:22 +0200 you wrote:
> Replace "22E" with "22F" in the description.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/phy/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: phy: intel-xway: fix typo in Kconfig description
    https://git.kernel.org/netdev/net-next/c/6c9d76eec482

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



