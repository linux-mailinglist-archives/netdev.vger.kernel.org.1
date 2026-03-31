Return-Path: <netdev+bounces-273530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG2OMhCMy2kuIwYAu9opvQ
	(envelope-from <netdev+bounces-273530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:55:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC9366862
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A29BA3078B89
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB7E3EAC9F;
	Tue, 31 Mar 2026 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXkfi1Cb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928F3E9F74;
	Tue, 31 Mar 2026 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947026; cv=none; b=ZIS5mi456NrVqchnCpip+OATQ5UxrbaFpkqa7BFB6vK3oNsSgQpDzOEEiTjKrutL1HNCS3Ga4Mf6dRR9wVTq9qFQtJusj9pw+RZhp1ZFtVLakKpKprYNJr/0OCiZc5edLZr7ibbyYm/JYhL4Bus1ky5Ue7W8QXk05fCX6wA8xwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947026; c=relaxed/simple;
	bh=3xn5q88t5joBFJuzN+n2d6yLVcFLpIFnUvfH2KGmb3U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nY5h6KqW0lPRfkOLAsyuXPHj/O41PGVC7af+AwjpPKsybct7ryHvaGdEJSNDAJoHbu4cMTb2nvKbj7CnNp9heQiMefo9J01k4EBq8W76goYH6WGed1O4CV3N3nBHoJ82dFpKXwe3cxKGg5ynCIXH9KdjpYB/THuif5juY9YnodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXkfi1Cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9212AC19423;
	Tue, 31 Mar 2026 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774947025;
	bh=3xn5q88t5joBFJuzN+n2d6yLVcFLpIFnUvfH2KGmb3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OXkfi1Cbm9Sz05smuAuV9FfbF/nLoU33mswLkdWXpUG4ngnbhd8lrnd1dxJUY9gW/
	 oaEXcGvm83UichL4u8UwSvK+FIeEDXg6ijPlvI41GJehqp070OH9G6tlnHvm+ecOvf
	 /lsNdz2tNfx8cH02it/ClglS9U1RhAeZg4x/+WHTVl/q2XdAperJkJsK+/eAi28e07
	 aa3aLOsoiKEKqZOGkGayTA90JTLC6DI6xYiVeN8mmo8NQEHpaupvEBnjMPaRhkW4RW
	 8FvJ2Jo8PP8XwwugumRa2mNLsxmjq7esKygV9D0KW8h4xWNLObUU7tTyK2lX0TOd5R
	 JwvJw5zMAcImA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFA2392FF48;
	Tue, 31 Mar 2026 08:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] r8152: add helper functions for
 PLA/USB/PHY
 OCP registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177494700929.2182623.77507775114681012.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 08:50:09 +0000
References: <20260326073925.32976-453-nic_swsd@realtek.com>
In-Reply-To: <20260326073925.32976-453-nic_swsd@realtek.com>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, edumazet@google.com, bjorn@mork.no,
 pabeni@redhat.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-273530-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0CC9366862
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 26 Mar 2026 15:39:22 +0800 you wrote:
> v4:
> - Add a new patch for original #1. We need to fix a typo first before
>   original #1 patch.
> 
> - For patch #2, replace redundant ocp_word_set_bits() with ocp_word_w0w1().
> 
> v3:
> - For patch #1, fix the issue identified by the AI review.
>   In v2, ocp_byte_set_bits() was used to update the USB_LPM_CTRL register.
>   However, since its function only perform a bitwise OR operaion, it fails
>   to clear the old bits when updating a multi-bit field like LPM_TIMER.
>   Therefore, use ocp_write_byte() to maintain the original direct-write
>   semantics.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] r8152: fix incorrect register write to USB_UPHY_XTAL
    https://git.kernel.org/netdev/net-next/c/48afd5124fd6
  - [net-next,v4,2/3] r8152: add helper functions for PLA/USB OCP registers
    https://git.kernel.org/netdev/net-next/c/d16133f177fe
  - [net-next,v4,3/3] r8152: add helper functions for PHY OCP registers
    https://git.kernel.org/netdev/net-next/c/7db154aa58e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



