Return-Path: <netdev+bounces-286079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ6OFAST/mnJswAAu9opvQ
	(envelope-from <netdev+bounces-286079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:51:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD804FD654
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB6403005A8D
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 01:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0A0281525;
	Sat,  9 May 2026 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvUItxhR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744AC2EA
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291457; cv=none; b=ZVahk/l9Hoza7Ip2Q3+Vu2sOh2Lwr2YCKtOVilJZs+iixeVqlvr4a7B6mNVxJ3ywxAy1MZByW3Lo996ApUWKSUULgru97gsdxTvAKT51GaZnDKa8qYHMf3dLG9SBFeo5k6pLybvX52PJDF0dSYaNVAEGkCt36cSAF9ZpsIHrG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291457; c=relaxed/simple;
	bh=KntIHwJ+PkR/VBc31DDFO7W9+1zpNvg/anmOOYQvFP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BObRWh2+Y3n+Ndrh9gUJGcYOGwSdoldRB9PqZmv4+NP6abrdb5vGQoW265J+v2LASvQPZJouGf5aCXGZywWnj5TF5lNiOuSuOZOzfzRoglOOUm117iGTVMSez91ceYt5uOPBmfaTBtKU68nms4EDcGV+MMoZBHwxV0817DxZm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvUItxhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747EBC2BCB0;
	Sat,  9 May 2026 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291457;
	bh=KntIHwJ+PkR/VBc31DDFO7W9+1zpNvg/anmOOYQvFP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NvUItxhR/gJUc4U63GaheSTJXB5SoL6CL2teKaM0AirGRoao1N7+Y6xIWgyXmVRNg
	 qX4s9Wc4DnXh3MHMoV5gdYeZb4NMHc3s4s1ZQbYcPmgiz5eCWh3pJHwrcf8TL2KUe6
	 Xv0w9qYQ5Z7U6zmDE2YDj5v01wate8Kr4Fo7r9WjyW1m47a+2Dje7ks4ez29Ets1Qn
	 SoIJaHGjMUxCHx6M28wNwfKuduZ8OvoMy+61+aW0E8bKbJmCEyAVXWcEnMoKGuuEAh
	 RjTLrtwR64dZIiLc6rFW52RhUNyu0KnLtXuwG2k7e50AfMobWu9AbAU1FJuSZTFIBv
	 X/mE5K3EhEuiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E6938119E7;
	Sat,  9 May 2026 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177829140555.931855.3651116265067551153.git-patchwork-notify@kernel.org>
Date: Sat, 09 May 2026 01:50:05 +0000
References: <20260507155332.3452319-1-holger.brunck@hitachienergy.com>
In-Reply-To: <20260507155332.3452319-1-holger.brunck@hitachienergy.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com,
 horms@kernel.org, kuba@kernel.org
X-Rspamd-Queue-Id: BBD804FD654
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-286079-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 17:53:32 +0200 you wrote:
> When the device is removed all allocated resources should be freed.
> In uhdlc_memclean the netdev transmit queue was already stopped. But at
> this point we may have pending skb in the transmit queue which must be
> freed. Therefore iterate over the tx_skbuff pointers and free all
> pending skb. The issue was discovered by sashiko.
> Tested on a ls1043a board running HDLC in bus mode on kernel 6.12.
> 
> [...]

Here is the summary with links:
  - [v3,net] net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean
    https://git.kernel.org/netdev/net/c/496c0c4c53bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



