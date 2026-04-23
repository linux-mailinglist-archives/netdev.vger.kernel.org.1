Return-Path: <netdev+bounces-280595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHXhC0Gf6WkAfQIAu9opvQ
	(envelope-from <netdev+bounces-280595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:25:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9381144CF08
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A1BE30B8B3F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453513CEBA1;
	Thu, 23 Apr 2026 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s44f1vAn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E823CEB80;
	Thu, 23 Apr 2026 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917456; cv=none; b=ZL9MXuKP2rJWw8Yf4WVM8Q3Cbnp2aeA/kS/2rviMxJLmLp698pGvIMdlXL07HaoZrkU8CTf+pn4XC1hk4hmIq7Ym9puKfBsW8exXVc4ZE4GEvZXeWrv3CqvQlmKJ7sSWYyVsIp8bl9FFfkjAtih1lfgL5p03zCfryDlYQmO9Klc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917456; c=relaxed/simple;
	bh=51au8fFA+7VyrcLTlgsc7KNVkrJe761NvZlTkZbBT+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U0y0p7LhSQpQ3o88qL5Gy6n4jUOPQboHuzvcXnvzGLetHyPsZ2JNvU/VBWApaoiNIn1ZpCPWzAb1VMa0cAY5mnUhtl8sQzihZGkJd+KPInQlYHCz1h/K4aIY/PEGWRqQej+x2faGkRi11tBByw9Z4VAlGIVvLKkfrqXESQXtaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s44f1vAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E10C2BCB2;
	Thu, 23 Apr 2026 04:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917455;
	bh=51au8fFA+7VyrcLTlgsc7KNVkrJe761NvZlTkZbBT+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s44f1vAnLeOz+NB1aFDlCHLnXKx6TdZqwUi2r4oYYlPoBykaPSaHWY6tH0HVJDJOM
	 y/E8uXZw9DWr2UdqZQr9aUEWLIRomUZU3WsvnIuhyL5EX4salseCH7cubb9S1S3TrH
	 1uekH8KxtpsZpwfSWVx/1usscsrdw6uy+klmur+rNJDeoKpvlg6/VQeI3+hp/HKvG4
	 7eGrhuH/JM/SRfGMKf80hbS0ek1WY5rAdntvVjC+RmfzRs2AU7+fPfZHu9iG5K+PJm
	 F4+c72mYXNwo1Gl5wTMvt30H3X9C4keHuuy6TRvakvTARBJ6FE66INn4iu1Y01i2KF
	 f9HFyFzKLT6qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E273809A86;
	Thu, 23 Apr 2026 04:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] bnge fixes 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691741779.4152232.6756555111239675124.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 04:10:17 +0000
References: <20260418023438.1597876-1-vikas.gupta@broadcom.com>
In-Reply-To: <20260418023438.1597876-1-vikas.gupta@broadcom.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 vsrama-krishna.nemani@broadcom.com, bhargava.marreddy@broadcom.com,
 rajashekar.hudumula@broadcom.com, ajit.khaparde@broadcom.com,
 dharmender.garg@broadcom.com, rahul-rg.gupta@broadcom.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280595-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9381144CF08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 18 Apr 2026 08:04:36 +0530 you wrote:
> Hi,
>  This series fix two issues.
> 
> Patch-1:
>     Due to wrong HWRM sequence, driver do not get the correct
>     information regarding resources and capabilities.
>     The patch fixes the initial HWRM sequence.
> Patch-2:
>     Remove the unsupported backing store type initialization, which is
>     not supported in Thor Ultra devices.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] bnge: fix initial HWRM sequence
    https://git.kernel.org/netdev/net/c/70d7c905a07a
  - [net,v3,2/2] bnge: remove unsupported backing store type
    https://git.kernel.org/netdev/net/c/c6b34add67a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



