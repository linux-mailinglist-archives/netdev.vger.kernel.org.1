Return-Path: <netdev+bounces-268433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNdwJNbRuGnjjgEAu9opvQ
	(envelope-from <netdev+bounces-268433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 05:00:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BCF2A36B0
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 05:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9D0A3016257
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30E35F8C9;
	Tue, 17 Mar 2026 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSiksLMY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A49186E58;
	Tue, 17 Mar 2026 04:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773720017; cv=none; b=bsd0/fbT11ZvURBf2m0yKiiYvVID0nC/1Vv0r1cH6QPHwBUAscG1Xiq4CaiEMna6iCq2JCb6wlN7AkQvqT2OCYypoZNQU6Lq2VcBRAB65OyPBAevJRbXViaJta0ErHw5UT75eaBBP9zSv+lE/9qoJpi4I7IVYcVD96j8z1grkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773720017; c=relaxed/simple;
	bh=y7GywfJwPQ/nfW6GdPldGRpir6WvZPwMwOCcaYr4tdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y5du2JlA4iZ0YT8lXxOFqf4jHsVlppPfPnzLTDoL29A28Jfg11DfAfv4ggVk8ihiNFbBBGdEeKdhBGxKDJsXVLbJwxPWuIB1xyBSyolrjeo/A3r+/dsHLrvPq6Nu5BaAloysu6dMrmLNTFLySQasiYAhmdywLwLKdZzw2NKFfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSiksLMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5668C4CEF7;
	Tue, 17 Mar 2026 04:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773720016;
	bh=y7GywfJwPQ/nfW6GdPldGRpir6WvZPwMwOCcaYr4tdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PSiksLMYw9c9Q3z70QcJ5eOKTFq2p+HRGGXZRnabqxUZBztJvfRqTzMiKquQvNlOR
	 kz+SvtQ/uo1fp8Q/+BZ4jNfdCO2+6Cj8u3VoivEQ0VylXpMJT4NQJxBU90juXr4gAb
	 cehyhA9kL8FF+ExHibQ28Bj9f31nNtY99Wh3PeFvGiHd3+Zuphf7pBodNkweP9dv+z
	 2H49JJ6rtv2R0K2lkHN2q+ubgW+8IMp21Wq8/NJjt4vyrldn+Hj6YlESsmrwnMYAmh
	 1OwY9qwgGUKmLk3Q4LOH9633FZrTjFuaFGqJl/E0IOJ5dMB3jR5CZy6vUhN7b5JEdf
	 3XP0Ge6ZzvAdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F333808200;
	Tue, 17 Mar 2026 04:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] net: usb: cdc_ncm: add ndpoffset to NDP nframes
 bounds
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177372000954.3420008.2772975605346318437.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 04:00:09 +0000
References: <20260314054640.2895026-1-tob.gaertner@me.com>
In-Reply-To: <20260314054640.2895026-1-tob.gaertner@me.com>
To: tobgaertner <tob.gaertner@me.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, kuba@kernel.org,
 gregkh@linuxfoundation.org, oneukum@suse.com, bjorn@mork.no
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-268433-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[me.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10BCF2A36B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 22:46:38 -0700 you wrote:
> The nframes bounds check in cdc_ncm_rx_verify_ndp16() and
> cdc_ncm_rx_verify_ndp32() does not account for ndpoffset,
> allowing out-of-bounds reads when the NDP is placed near the
> end of the NTB.
> 
> Changes since v2:
> - Save struct_size_t() result to a temp variable to avoid
>   awkward line wrapping (Jakub)
> - Fix From/Signed-off-by mismatch
> - Move "Compile-tested only" out of the Signed-off-by line
>   into the commit message body
> 
> [...]

Here is the summary with links:
  - [v3,1/2] net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check
    https://git.kernel.org/netdev/net/c/2aa8a4fa8d5b
  - [v3,2/2] net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check
    https://git.kernel.org/netdev/net/c/77914255155e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



