Return-Path: <netdev+bounces-274816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG/yFt4Tz2nXsgYAu9opvQ
	(envelope-from <netdev+bounces-274816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:11:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA638FDF0
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CE6830858FB
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911EE276038;
	Fri,  3 Apr 2026 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQNzVRSK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6BB274B4D;
	Fri,  3 Apr 2026 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178625; cv=none; b=arBRBpOxBu7ggdvd7aRZ3HHS+Xhz6lozO7CRdPd0E3r41fjDRXWUQ6eae94BcTA5acPt8aD7Z9+ViYxque4OJXe9LwpTb9/S9XkbNz3nDzjFIQf2Dqv+AXUeu6dTBSVA5aujJLLd8CbXa6SuZin2fojX3gnkKw+IZoDZNddanrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178625; c=relaxed/simple;
	bh=79KKde1jbuebWU7wrbDmfy4MFj3u2t3Ploh3JBIV4/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RiPWb+5zQClfHoHQVetckxwpm9H0lXilY1uVse5SCkAXv5QIIZGvW6BOxAPHJKaP30qbutqLD2wOUeKCrGzNrkE70a9qZb+4hZHqaO6Z8g74fSHMZ7sOCf7KvOHxT0vzitLaBuLO9HCrfAvwba4krdv6iDjloL0R3dWlvsIi4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQNzVRSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E779C116C6;
	Fri,  3 Apr 2026 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775178625;
	bh=79KKde1jbuebWU7wrbDmfy4MFj3u2t3Ploh3JBIV4/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kQNzVRSKmJW2OjqdegfN4DUKnJT/Ti3SgJ6xlZ46yQMjonum9Eg7L3E1ahkOWwbsu
	 XeZ0YUgKlCI+VR7xQSbHbNLmywtDrrNGOwmHjWbuNAn4Xnpr8CdP4WSxFdCkkqg8Yi
	 0kEeI//MEa2XkE8g23DT/9CntXLnPdxcTRRQEGlEJC4216+l7ZHfxluoSnp97IrnhP
	 TOgoA+cFQBPKSykNOJnjg/lzHN6r/ihO+/KxwK1Fp2158AIdgTHvOElcXO5L5WvFBS
	 FM2MwhL8pPInJtaOn/f4g8HBcdeYLrodjKEIYARJyAXsOu82tcPATqLTk7td/7BwDB
	 BHS5mO9TgKALA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE5E3809A09;
	Fri,  3 Apr 2026 01:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: orphan PPP over Ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177517860728.685228.1265395378565790605.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 01:10:07 +0000
References: <20260401022842.15082-1-dqfext@gmail.com>
In-Reply-To: <20260401022842.15082-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kees@kernel.org, gnault@redhat.com,
 ericwouds@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 mostrows@gmail.com, mostrows@earthlink.net, gorcunov@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274816-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,earthlink.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2DA638FDF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Apr 2026 10:28:39 +0800 you wrote:
> We haven't seen activities from Michal Ostrowski for quite a long time.
> The last commit from him is fb64bb560e18 ("PPPoE: Fix flush/close
> races."), which was in 2009. Email to mostrows@earthlink.net also
> bounces.
> 
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: orphan PPP over Ethernet driver
    https://git.kernel.org/netdev/net/c/2fd68c7ea2ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



