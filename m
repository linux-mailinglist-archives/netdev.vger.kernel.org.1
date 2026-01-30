Return-Path: <netdev+bounces-254990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE6OJIQcfGmAKgIAu9opvQ
	(envelope-from <netdev+bounces-254990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:50:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4D3B68F0
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAFF9300AB15
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B493C333426;
	Fri, 30 Jan 2026 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay9D2S1P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FDE1AAE28
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741438; cv=none; b=XJJCGAPPPGYxZmR5ggIT7+5w6+HcyKlPX7SRudPrCIBVMpxLGdcB57jzAqhj7XmPK4Y6fny+wGV49e5Yx2anI4zLsNFHLnxIQxORK+oIz8IeD9/vHcUTytHUX216fTjbbWUC7qQD5W+xqAY40mn6oDOtVYDsoskc06dSiTUryRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741438; c=relaxed/simple;
	bh=RWwo0x+RLxPgOOxmSbl3SmcNWjtiPGHwiyyMQdLP144=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D3W+R6aiVOyl2aHweFBtc3aQKlTrZ0EOzD7TDFM6Bz4Ttc8Ou2hBYbt5peHsv/ejXiY/282rgFwrTD7UwejMb5OcrE06n88ZrMk0+hBO16zzJfz+6R+Bkg1cOBDXJqsC2wcXMrY29TIXioj3E0OmA6okEV3rjo4G97yFx8LOFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay9D2S1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6620AC19421;
	Fri, 30 Jan 2026 02:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741438;
	bh=RWwo0x+RLxPgOOxmSbl3SmcNWjtiPGHwiyyMQdLP144=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ay9D2S1P0enVFX4PkdZVhnQ+CE7kpSmqiKUbyxo3ELvYQXbjYuAtQmhzOW6uLQ0Im
	 UFfhXHo7u6IKEQKh8ObP+Ye4xBGvtcvS8kykHvV1hwLUL+nU055FUSfO23DOnE4bjF
	 Q6Xj+7ZXDYSKe61FnP2obV43MMaaiJSJqC+PxPpMF+4Rl+YdH4lXL1tTZyA+1TaFq+
	 UkWFN3rDtgWqN/4lGW5HmpvBiImaAy3QhsAb7S0V5xsWcIx8XtN6JsGol9ROho7gNx
	 YXWkiQr4XuwipZ/4xFxS3HfnVz8P8ehDQyB1IfMHbBBx4Se6CNu4wTwZE4wNzMWjmo
	 SoTZZEeJ06i7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EE4E380CEE0;
	Fri, 30 Jan 2026 02:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-pf: Fix header guard comment in
 otx2_devlink.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974143087.3149010.17900843367800587977.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:30 +0000
References: <20260127174333.1247747-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260127174333.1247747-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: sbhatta@marvell.com, hkelam@marvell.com, gakula@marvell.com,
 sgoutham@marvell.com, bbhushan2@marvell.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254990-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[marvell.com,redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B4D3B68F0
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 09:42:52 -0800 you wrote:
> The closing #endif comment in otx2_devlink.h refers to RVU_DEVLINK_H,
> but the actual header guard is OTX2_DEVLINK_H.
> 
> Fix the comment to match the correct header guard name.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: Fix header guard comment in otx2_devlink.h
    https://git.kernel.org/netdev/net-next/c/241b91d9680d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



