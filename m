Return-Path: <netdev+bounces-288125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNeSDGZnBmrOjQIAu9opvQ
	(envelope-from <netdev+bounces-288125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:23:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8504547F90
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10A71307824D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D923536B;
	Fri, 15 May 2026 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkHTB6JZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882422D7A1;
	Fri, 15 May 2026 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804481; cv=none; b=H2uCAr3ZJTo4NrSx7A2XaSSaAve9NtSZEVNDBiWkNbWc4aW/TVuJaXakskxM+avexo746kV2CAA3rnKORBPzpFMc847wHmp36Mq+11sbFgG20Ud2Q+AB/DqtLllaiFcOzbOKxEjUGuCkb2vMsngbQYFDQHk5Hnw+eqxv3U2jI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804481; c=relaxed/simple;
	bh=Oz2TKx9qExpvhoQRhO1od0MXlhhjJI5MRGYtecZUNYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dB+n9n6eVC8XNgMUvdIoNT+wB/3g6TloPBxkvMIK97jIyTfgVefdBk7NzJNGADe/Dq9tUxVgsopFzJI/T6ZWG6ofDPdMwmFiP40fte0oGsFBD0eKoLwiX8L2+4c8duCqCPM2IkFQy/mtCxVOmCOXJ8I5W5eHVVhHSA5RhXeeOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkHTB6JZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCF7C2BCB3;
	Fri, 15 May 2026 00:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804480;
	bh=Oz2TKx9qExpvhoQRhO1od0MXlhhjJI5MRGYtecZUNYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IkHTB6JZcVRICQXl+tfZbCc1GvrZzOv9IUDbL0D2QGIqLTM4e9r8NgEa74wrj8Gl8
	 C/5iuneywYgnXq0qcc+b5vqPCylI3XFG05zTroea+A8KqoJV01LptinTZl8YaDQNQX
	 Zsl3TQASUFMTDsKrfKVbqc6d6MpjC8YEGm6kC9S45fmPIVZ/ZinFhshd6DD4H7C7sl
	 /q5HbNov5Z9l3Uj4Ly3WVhGoiTVasacIBUgzAXpH/x+oA0OBzeWUaCvowVv7FqF5K7
	 DnkTPq9pHtIeoO+oriBH7mNmB2YmvLVGsmHItf9BymhZeqIiyhR2r/MJevUpAOHMk6
	 AEVLeLciZ5EEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFF739E4DB3;
	Fri, 15 May 2026 00:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Documentation: networking: ip-sysctl: fix typo
 in
 tcp_ecn_option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880442505.134878.16209369565016154139.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 00:20:25 +0000
References: <20260512133125.1772658-1-avinash.duduskar@gmail.com>
In-Reply-To: <20260512133125.1772658-1-avinash.duduskar@gmail.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: A8504547F90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288125-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 19:01:25 +0530 you wrote:
> "regarless" should be "regardless".
> 
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] Documentation: networking: ip-sysctl: fix typo in tcp_ecn_option
    https://git.kernel.org/netdev/net-next/c/d2dc0c5c4c42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



