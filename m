Return-Path: <netdev+bounces-283318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DAHOzxB9WluJwIAu9opvQ
	(envelope-from <netdev+bounces-283318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:11:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B48E4B0705
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 525F9302834C
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 00:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08518A6CF;
	Sat,  2 May 2026 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhfIONGf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C7155C97;
	Sat,  2 May 2026 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680663; cv=none; b=tHTYQQ2Ena5G+xkNlFgNXa/wtX1G1zCJVn8n58mpI+IfI3CANMTwUCR76pT/NOp1S2Cp+LbCNtzv2mmCpEqnunvGUw+ZCrq+cKFzwjKiHEYJ9AslItlPiRAu5GQq3KnwSLC9CMQFe7gMF2GTm8/fy0t8JLEOFaq7m6Rz91dI3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680663; c=relaxed/simple;
	bh=DSjsCTkfWydZI2FV5sUL9ipFi5Z9x92jqoXscoMFLHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JIocJfo4Wd54cXTRbb12QG3VQQVFWejMzE5bOoESuMYzoyv9KzK+4+PE24RLiGbiU6zJUL2sTzFu/DK/S9L8FsLHeWW0nTv3LuLEpH0zSndUj1oRuGHOs0JSMpZRoG4Mk/tUW4ipvvZtZqIJQAbIhc1PLqohyVdQSVntamQZ9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhfIONGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF20C2BCB8;
	Sat,  2 May 2026 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777680663;
	bh=DSjsCTkfWydZI2FV5sUL9ipFi5Z9x92jqoXscoMFLHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rhfIONGfrubwzmUt50vUgiby1Ynp3HNQzLruZyfmb4f/3cvazo0PHEOn9rvQV/iDy
	 6kB5OFbZuaUA37r91bxLm5cUEzmWajhGEmxLEQ6dcH2/DMEeF3P97Mp6fQD9TrM3dN
	 DI+keBXjCvkHJ7gTgUa2Xnwh9djHFII40nsgnTKZDH+PNU862hJQtfrWLkQxmYbzRr
	 oNJHa6J9yY0PuMqWHXhKaRHNfnALhG5INvmrJ9pu8i3Uv/xom84HhZ/EPQPox7v10r
	 lWXHwZXeVZiH+C0kLW6aE5NEF/kX1tOWWl6gGyH+Y29moUQQ9OkH0Lf57i+aNdLhDa
	 neUMg3ewC7dSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC8380CEF5;
	Sat,  2 May 2026 00:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: r8152: add TRENDnet TUC-ET2G v2.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768061679.3667015.16615664630858230517.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 00:10:16 +0000
References: <20260430213435.21821-1-olek2@wp.pl>
In-Reply-To: <20260430213435.21821-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hayeswang@realtek.com,
 hsu.chih.kai@realtek.com, kees@kernel.org, mail@birger-koblitz.de,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch
X-Rspamd-Queue-Id: 5B48E4B0705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283318-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:email]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 23:34:33 +0200 you wrote:
> The TRENDnet TUC-ET2G V2.0 is an RTL8156B based 2.5G Ethernet controller.
> 
> Add the vendor and product ID values to the driver. This makes Ethernet
> work with the adapter.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: r8152: add TRENDnet TUC-ET2G v2.0
    https://git.kernel.org/netdev/net/c/f93836b23677

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



