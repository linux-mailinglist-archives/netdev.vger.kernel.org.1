Return-Path: <netdev+bounces-276781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMgNH/EM12npKggAu9opvQ
	(envelope-from <netdev+bounces-276781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:20:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E88D43C57DE
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EC2C3008512
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21F535C1BC;
	Thu,  9 Apr 2026 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV7ZT+5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21311CBA;
	Thu,  9 Apr 2026 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701230; cv=none; b=Jnk32FqGBXj5PgEcB1cyX0maxLT6oVZLkV/meqIfVxwNphLD+UGmrZA4j4FdpE0YO8jGq8sFT4Yb5mbrrlGmoAO8lXbs/wq81uqXI+SEArv3Sy8XY6RY6wn3X2KpeUh+/+PKgo+hQVu+jS0ZD2X0fkIo0Hv5OstuI+baQ5vb53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701230; c=relaxed/simple;
	bh=wWb9gSq6hoPVMk4EAJX06Hg371ytY7jQunigeMtA3L4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZJi1bA4noXN2foiyL+yqq+gUcKozwF+BxiJpEX6PsXNTaDO+RMKLRCIL31mrnFANL+7h8ZnB+TE/ZqDhoB6M7Vlxz9ESQQNJuUoesoCQeilYmYGuCVs3UNi+8Vk9ASXO4CzYz4/NqF8ayt2558zfcIt4rVSD2z/BpVuJLt/X3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV7ZT+5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6AAC19421;
	Thu,  9 Apr 2026 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775701230;
	bh=wWb9gSq6hoPVMk4EAJX06Hg371ytY7jQunigeMtA3L4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WV7ZT+5+5/rauccIKVTblUwcAGBuI44rsodqKBduBFOF/4HQ7mTPxZPQ2OIHbLrgW
	 RMnK0mElrbQrbZZWaalXGnec4ax0wEGwz4reyQIpLr2vLU0cwalWBM/SN/epO4T67x
	 3fBusnTgxroPaV3N2tsWUV0uSlU+dH23D7fvI9z2t1HvHHKEywWhMfZD1v6XWTbuS8
	 d68tha5FuwAeA08qUXzU8efQOyA0aACCtweQ4XAuL97R4LS+2BauJfxj7RhT2B3Xc0
	 HJAt8E/EJm1zbBkmZP++LZ3IBuIRez9BIYFI7Xj0jM/KyqpKUm1/wVbx0vMNlzChb/
	 wO2i3/zbDJeQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DA13930793;
	Thu,  9 Apr 2026 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: txgbe: leave space for null terminators on
 property_entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570120655.959042.9265969901669493235.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:20:06 +0000
References: <20260405222013.5347-1-fabio.baltieri@gmail.com>
In-Reply-To: <20260405222013.5347-1-fabio.baltieri@gmail.com>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276781-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E88D43C57DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  5 Apr 2026 23:20:13 +0100 you wrote:
> Lists of struct property_entry are supposed to be terminated with an
> empty property, this driver currently seems to be allocating exactly the
> amount of entry used.
> 
> Change the struct definition to leave an extra element for all
> property_entry.
> 
> [...]

Here is the summary with links:
  - net: txgbe: leave space for null terminators on property_entry
    https://git.kernel.org/netdev/net/c/5a37d228799b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



