Return-Path: <netdev+bounces-290149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJzgJS9LDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:00:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB8259D192
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 897843038942
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D8A19005E;
	Thu, 21 May 2026 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FORymzAt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6BA14A619;
	Thu, 21 May 2026 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321615; cv=none; b=gbQkpXYbefUriUCElK3hL50AVc+lgxgxuAmoYmVy3iIY6ZfBeZjq2dFKi1vPFyI8G+1ILhflnQeqoiykgFMx0EcU/vhw/ZyylujD9RaWu4ipWkuwtKv1fh+RDBkzN1N9+TEIW954QjYri1sc8sffcJiOknENr2Hc7VGCfNel4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321615; c=relaxed/simple;
	bh=8HOSs4vM2d6LgzE6ti8aJ+8F+yqAjvvOW7snYcVimM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mLxHJmhcXlQnYhWkKZ4eQn9rQnactw0fjMPltrXM3Vxm5GUmumzdn4uGnuCi19m/tRZejI1AzGdY8EYqifERnx4bJ5cnlYUiJ5sVlYoGzwvqig0NYKsE88K9cyx8hO3Lv13WpP6lkl3b3bPpCmBZuKZBZegT28aKWRndlE9b/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FORymzAt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5D31F000E9;
	Thu, 21 May 2026 00:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321614;
	bh=NitP4Vedf2dI/4ytHd4rR8yMMsGh0fHeF3LVKg3ZkJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FORymzAtvOd5zBkQcnwC7/7yGrpdEFAmhqjGl3F02F1DLJdQ0g1ME8/bQqw1TYHNP
	 FIey50GausmcaJ1wD3xD6ySs/tj1s1iXQsBmIqX4lsDO6wZciHKfzcD5aGIiIfqc/J
	 I1NlmTwpdMsxGGMhjbU0u7ZT1N8jukfKCSjgeNi1CIaztx27MS2fWXzVAYCl2PBUuK
	 jzWu9dHmu6bRY2JQXEotoDHs8Sx9T3Rcl4jxjgNJ/3jRZQ9SyCD4cI7rzaE65MwVoq
	 Lj5LfezlDWws2QWuSn7jHG52cO2hIu3MSvsExkLeQjYU7syOxBAgWk8eiY//0aAnB4
	 bGaiMCB5X8Vqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A8A3930C25;
	Thu, 21 May 2026 00:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] USB: add MeiG SRM813Q IDs in qmi_wwan and option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932162413.3801238.786393914842458462.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 00:00:24 +0000
References: <20260517153237.55995-1-janvolck@gmail.com>
In-Reply-To: <20260517153237.55995-1-janvolck@gmail.com>
To: Jan Volckaert <janvolck@gmail.com>
Cc: bjorn@mork.no, johan@kernel.org, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290149-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3CB8259D192
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 17 May 2026 17:32:35 +0200 you wrote:
> Add MeiG SRM813Q support by adding USB IDs to:
> - qmi_wwan for the network interface
> - option for serial interfaces
> 
> Split into two patches so each change goes through its respective
> maintainer tree (net and usb-serial).
> 
> [...]

Here is the summary with links:
  - [v2,1/2] NET: usb: qmi_wwan: add MeiG SRM813Q
    https://git.kernel.org/netdev/net-next/c/9758c11fc6c1
  - [v2,2/2] USB: serial: option: add MeiG SRM813Q
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



