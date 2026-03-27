Return-Path: <netdev+bounces-272325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNseCMLixWkeCwUAu9opvQ
	(envelope-from <netdev+bounces-272325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:52:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8782533DF80
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67ED6306A016
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C4D257448;
	Fri, 27 Mar 2026 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLTFYUPa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9D13AD05
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576228; cv=none; b=qoER8KWppfmnVE49WOFFd2r2fPj05q5NRSNuLZbpIRNfZYkEREAmXK/x6htY1X/Rh0YHqrYFuvI/lUdxpQLg2i8W/wTR5S2UDxxDbDekMzOPnc/GwWSQtQcC1xYYyGJa8avclQZX3tW4pXxvidGxEvJ4T1u8fyfCiqY7tK6INMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576228; c=relaxed/simple;
	bh=+sL5z3lLnI7AHTu0azBDvUHryE3q2fqjUDFPAEBcxqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jYuC/ItwqQbMS5MkAn4NNzwtxEeXNzJ4dlCgqdINCPD8oClwdzQojN5ae+xw7dc6w3QnzvuJhK96fGhcX98NK1VkLCPuiIgRSjATVExYlc9EvGnKwdzah5hCVPl6Ex50dNR5XICbAZLLzv/q2mlwNsMbRrASzjOh0/m02s/szDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLTFYUPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735A4C116C6;
	Fri, 27 Mar 2026 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774576227;
	bh=+sL5z3lLnI7AHTu0azBDvUHryE3q2fqjUDFPAEBcxqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MLTFYUPa2hdq0RYsy6Nv301PHZHd1o2gsYYyFJUrsR/Pf7bHKl4xH0uuxVE23BC7h
	 x7v7ngNKQQevwSNMP8gNh8VxIV2OgbSIsuo88xTKfJsxMhKiUz3pNGAuTryQWg+N7g
	 vQJdD0LNd6C/QO3MPX9pacR7YW0gGR/uqsXswSlBJ3a+SpN94pv08vbejqqLvEWJ2e
	 HICb4ClG7SmuzItyAT0ocT8kPkUOAVrbbaORbS4kNo6eC+Rkfmn272pr9mJA/9oIt3
	 9TTKNsBXUvBFgLNAzrlrzx3WotvXn14X5y9b4jChaTxEq/gcaWZ/er0MlWwfzuVTew
	 LqJbjyzpAEWkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E063809A07;
	Fri, 27 Mar 2026 01:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] Add support for per-route seg6 tunsrc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177457621353.3256339.515984783963679850.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 01:50:13 +0000
References: <20260324091434.359341-1-justin.iurman@6wind.com>
In-Reply-To: <20260324091434.359341-1-justin.iurman@6wind.com>
To: Justin Iurman <justin.iurman@6wind.com>
Cc: netdev@vger.kernel.org, andrea.mayer@uniroma2.it, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 justin.iurman@gmail.com, nicolas.dichtel@6wind.com,
 stefano.salsano@uniroma2.it
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,uniroma2.it,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-272325-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
X-Rspamd-Queue-Id: 8782533DF80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 10:14:32 +0100 you wrote:
> This series adds support for the new per-route seg6 "tunsrc" parameter.
> Selftests are extended to make sure it works as expected.
> 
> Example with the iproute2-next companion patch:
> 
> ip -6 r a 2001:db8:1::/64 encap seg6 mode encap tunsrc 2001:db8:ab::
>     segs 2001:db8:42::1,2001:db8:ffff::2 dev eth0
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] seg6: add per-route tunnel source address
    https://git.kernel.org/netdev/net-next/c/78723a62b969
  - [net-next,v5,2/2] selftests: add check for seg6 tunsrc
    https://git.kernel.org/netdev/net-next/c/2d047673d374

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



