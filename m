Return-Path: <netdev+bounces-284166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIqDAjRU+WnF7wIAu9opvQ
	(envelope-from <netdev+bounces-284166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:21:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 560D34C5F5B
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AE2E3033D1C
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75CA39D6FA;
	Tue,  5 May 2026 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEXOsDQO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C4A39B49F;
	Tue,  5 May 2026 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777947657; cv=none; b=cTP271yMwK/i6KgQT7IQMBP3Gr8OThOXkyImy+J9NiyHvKX1wAVLfJPOYrIFgruD35p5tXatL0zCoY2I6qXcO18XunA/hzmC67wBaRFOeMHDGeQMGdKKgpJWqGzdiGhsH2lzRXm/bpBMRUrm6Eo2i5mno8uxuUuBLkC0S6/VnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777947657; c=relaxed/simple;
	bh=VZC8BumA8T2KIHIxvwzglM4Yo9qX3ZIOn9IjL9c6qAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NIW0Nhp+3sF4icQ7cDMbb/7qxi3aGbBTmXOyJW2ls4HkqItTTGUz9IczktXVvpdrvq2ugLqyjxBbKUHWcNboq+YXRrZ8a38MZGm6VpAz1lT3SoTk+fHWjtD+1hb8cBVdgQcki0RjCvcigf8r6RewNMFsBZqxxc735lwAfKKn1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEXOsDQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4081EC2BCB8;
	Tue,  5 May 2026 02:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777947657;
	bh=VZC8BumA8T2KIHIxvwzglM4Yo9qX3ZIOn9IjL9c6qAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PEXOsDQO/qhNGVlhZhOmL0Jtxx26gzw8Ptb1RzSL5j6Qy8U7wObLv7+DLp2D4OOmo
	 myGhnYp+n6yJjMVejo9b3ALsibIFix0xg0m39imfkCJQWcxjKJi2WBMLMx9ZIu5UvK
	 ck9FY15j5cJ/jywjY7kOAVYIUn821bvxpf3aqax79QQNaT0zbRgKKMF4c9RcnrrkiA
	 K9M+5lbzg3ezDbtdife49WzM9yOiKgOfaIsUCfPKeAqc7M7RrYk6sy77A3euqWzM25
	 gJHf0UJlzoGeH6s887o7rtJ50DHblTNSglkSLTbpfqgTZ33ZZSbxBoj9+e7JR2Hfba
	 exGH9OKt6Lq/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDAE39301A2;
	Tue,  5 May 2026 02:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: asix: ax88772: re-add usbnet_link_change()
 in
 phylink callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794760791.1391894.7472938774024727243.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:20:07 +0000
References: <20260501163941.107668-1-Markus.Baier@soslab.tu-darmstadt.de>
In-Reply-To: <20260501163941.107668-1-Markus.Baier@soslab.tu-darmstadt.de>
To: Markus Baier <Markus.Baier@soslab.tu-darmstadt.de>
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, enelsonmoore@gmail.com, linmq006@gmail.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 560D34C5F5B
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
	TAGGED_FROM(0.00)[bounces-284166-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 May 2026 18:39:41 +0200 you wrote:
> Commit e0bffe3e6894 ("net: asix: ax88772: migrate to phylink") replaced
> the asix_adjust_link() PHY callback with phylink's mac_link_up() and
> mac_link_down() handlers, but did not carry over the usbnet_link_change()
> notification that commit 805206e66fab ("net: asix: fix "can't send until
> first packet is send" issue") had added.
> 
> As a result, the original symptom returns: when the link comes up,
> usbnet is never notified, so the RX URB submission stays dormant until
> some other event (e.g. a transmitted packet triggering the status
> endpoint interrupt) wakes it up.
> 
> [...]

Here is the summary with links:
  - [net] net: usb: asix: ax88772: re-add usbnet_link_change() in phylink callbacks
    https://git.kernel.org/netdev/net/c/36bdc0e815b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



