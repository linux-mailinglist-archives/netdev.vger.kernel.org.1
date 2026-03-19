Return-Path: <netdev+bounces-269267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO07HzFgu2lujQIAu9opvQ
	(envelope-from <netdev+bounces-269267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:32:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D42C5000
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B24AE3094605
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695352D8DCA;
	Thu, 19 Mar 2026 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWhdTGBo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C50277C9E;
	Thu, 19 Mar 2026 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887439; cv=none; b=I5InBU20DuEHr8t5am/xrO+vZKrE3M1djsfCezXgx8nflqjplPMqCEUMmtBwhh62oueOlQPpXODMSByEVjTRIpMzxz4R1RECi95A/x5/uV8q5EjLX/+4Obrt2Sbe7XGWOMGn7bQsZA0BwipvfoSztNYlXsZnpqWphiD9XH/XihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887439; c=relaxed/simple;
	bh=xWn35S5eSYIJwCS1K9AG5kbF7ITUrwAriCif/gWPJGw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H0CXrBjo+AyzkpDi+9BLb4hRmtEwxRkN5PY9IxhaDmCceon8T003zDGzB/C6yztxW1qJyn4idPm5ANwqscJd9bz6SQkJukwqoBX+Br4Ufb9st+DGjeeq+D4xqDwxvc2QFK7JLzQHq3KW3XLyrAhnfXFYd64XLAQqxi1vPyPPqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWhdTGBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29A4C2BC87;
	Thu, 19 Mar 2026 02:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773887438;
	bh=xWn35S5eSYIJwCS1K9AG5kbF7ITUrwAriCif/gWPJGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WWhdTGBo5FHYYBuV8wVQN5OqnLnQArXEeprqupATlR0A3EWl9K0YZxa6JCgcPv1i3
	 /Ng2SR1Ptz7YPDw/h0/9lkrf7Cix3NQgq+LQUd/PvDfGQYpwwgfkPSv8XRFHiLlWWo
	 mqfOAS+6UdAfywoJCpfRnSxhg+vhVUdYK/4qBXWsoauyTzqu7qO8K+bwI8wYfAiZwL
	 UCNyHxL7NDgoP86N+N6oIY9cG7Q+4VC04TjpKNFH1zuSomAO7hudl4nt1R7Wb/U3Js
	 6npY6qG6ZYFW17549uaUb14Hjab7W0OU4NR95cTfhVYTs+UC7VeKqE3sBbE/I5HNFQ
	 Svc53JL8FPKKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0713808200;
	Thu, 19 Mar 2026 02:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] qed: Reimplement qed_mcast_bin_from_mac() using
 library functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388743003.997016.11328368912909508799.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 02:30:30 +0000
References: <20260316221453.66078-1-ebiggers@kernel.org>
In-Reply-To: <20260316221453.66078-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-269267-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CF7D42C5000
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Mar 2026 15:14:53 -0700 you wrote:
> The calculation done by qed_calc_crc32c() is the standard
> least-significant-bit-first CRC-32C except it uses
> most-significant-bit-first order for the actual CRC variable.  That is
> equivalent to bit-reflecting the input and output CRC.  Replace it with
> equivalent calls to the corresponding library functions.
> 
> Tested with a simple userspace program which tested that the old and new
> implementations of qed_mcast_bin_from_mac() produce the same outputs.
> 
> [...]

Here is the summary with links:
  - [net-next] qed: Reimplement qed_mcast_bin_from_mac() using library functions
    https://git.kernel.org/netdev/net-next/c/d5516452a362

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



