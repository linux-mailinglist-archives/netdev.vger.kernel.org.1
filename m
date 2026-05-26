Return-Path: <netdev+bounces-291637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP7nE4hxFWpbVAcAu9opvQ
	(envelope-from <netdev+bounces-291637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:10:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C69CE5D3F64
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A58E0300427E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F873D9051;
	Tue, 26 May 2026 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY5/2mwp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E053CA4AF
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790213; cv=none; b=ZB5rfgSunlMOmmQ+JSVqBThqemLtlx0ElRqfQtxwLdLLoBACV8yhzfmlOKvrAhj19EDuqbV/ItIHJ1tji54iiEBXXSMDz/im68GqtTecipcgz0ab9VRP45e5QkwZv7vYMATprefI4WwtTAyD5/uY43DZb9GOz2V/TGhl31E6MdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790213; c=relaxed/simple;
	bh=toqSzHyGE5vMlnTOSmxU6ryVsakV5LDNnfvwen6VLZs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hr1XC2DGYKosZQ4UHV3QsagMAxqs4POfCornEsbXkCTYq//1a7LM/+tuf1tyVp9PfoHwXTgyabFwpLI2N7R6D7ktBOtQxl1e+gQr7wx38tyX6u+FodUImG1bNVB96B8PHErDxm7JYW7NbtfGObGwQ8XYmyTPFDGZgPTTAjCwIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY5/2mwp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F271F000E9;
	Tue, 26 May 2026 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779790212;
	bh=4nXci8guigpxw0FiToG5awnHCsiwyJ13956m3zL0xT4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aY5/2mwpAEo7RnTY4xZKtEPGzbIxgINokL7LnDVjrVZvCkIVRo1S3wIrYr9XcVK05
	 ekFJjFggmKb+bSSq15Gl+WZXUiFqiAA9VFa3wlkBOeHd1QNM0BHmhwpLrqPfdDU/0r
	 2Q56zPOiAcjeQOXNBYFO8NO7SDXAXdhCxrUFBZI8TjeQuz10JN1dU24gJymAYFcsy+
	 eSMgNQGswzGLg4XNBU7LQwCCIhHtzt2mzWuVWZU5dH73PU1vW6Xf0+enW092Rxz3XT
	 JKzRaP4udJY4FLYuyCmPZBMTrBKdqAg5aNO/yZE19NTCCxzQLP9R3al2t8p1EYlY0w
	 +K9KAG5MT5pZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93F19380CED2;
	Tue, 26 May 2026 10:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] net: mdio: realtek-rtl9300: Groundwork
 for
 multi SOC support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177979021839.3302983.7872741518824440277.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 10:10:18 +0000
References: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
In-Reply-To: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-291637-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C69CE5D3F64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 21 May 2026 19:59:09 +0200 you wrote:
> The Realtek Otto switch platform consist of four different series
> 
> - RTL838x aka maple   : 28 port 1G Switches
> - RTL839x aka cypress : 52 port 1G Switches
> - RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
> - RTL931x aka mango   : 56 port 1G/2.5G/10G Switches
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] net: mdio: realtek-rtl9300: enhance documentation & naming
    https://git.kernel.org/netdev/net-next/c/d15c0d1df494
  - [net-next,v2,2/9] net: mdio: realtek-rtl9300: Add device specific info structure
    https://git.kernel.org/netdev/net-next/c/315a02b39e8c
  - [net-next,v2,3/9] net: mdio: realtek-rtl9300: Add ports to info structure
    https://git.kernel.org/netdev/net-next/c/215701873a7e
  - [net-next,v2,4/9] net: mdio: realtek-rtl9300: Add pages to info structure
    https://git.kernel.org/netdev/net-next/c/38c9d5b64404
  - [net-next,v2,5/9] net: mdio: realtek-rtl9300: Add register structure
    https://git.kernel.org/netdev/net-next/c/62baf5f1d80f
  - [net-next,v2,6/9] net: mdio: realtek-rtl9300: Add command/C22 register
    https://git.kernel.org/netdev/net-next/c/8bf7e2b133db
  - [net-next,v2,7/9] net: mdio: realtek-rtl9300: Add I/O register
    https://git.kernel.org/netdev/net-next/c/ffc92cd00914
  - [net-next,v2,8/9] net: mdio: realtek-rtl9300: Add port mask register
    https://git.kernel.org/netdev/net-next/c/cad6a373f7f6
  - [net-next,v2,9/9] net: mdio: realtek-rtl9300: Link I/O functions in info structure
    https://git.kernel.org/netdev/net-next/c/826a1926f084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



