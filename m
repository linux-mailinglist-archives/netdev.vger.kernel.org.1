Return-Path: <netdev+bounces-261166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBjkOhq/n2lOdgQAu9opvQ
	(envelope-from <netdev+bounces-261166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:33:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5834B1A094E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F256A3013A77
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058B633A9DB;
	Thu, 26 Feb 2026 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kURdJ+ZV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4A296BD1;
	Thu, 26 Feb 2026 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076602; cv=none; b=HFPDPBw8NcEFjorS1iu9wfh5jRqml82oNLui5d2h+3LzVIUuJPc+IJIWQgWEqIjBah3g2ooDdlcYnnTRQJ9UKKYObZx8/echeCnr3fkFXqsFJa8ZYmo3AJYASBpyV8hHzzQ5c15Ogy8l7Jb+gKHmn3Ix4Ayms9s4E9Fjm/sRlxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076602; c=relaxed/simple;
	bh=7lCmbDv+2pRFz25J9Y5YD+I1O9idkhZlZdp0R+Bw6tU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eocIIx+m0jVdJHkjCW7RBVNHMve3U+I5K8IFeMC1wzYFlRnKlG82DBXjkasVWpGliT+50ttCxuWPgqJjvseVKPQA5B/4RgioicvGDHw2DD3dBVxJ/jIeeCLnwalcoFt/1uT0MJRLFytURUmAcmpgswDLVmhLY4iBq4zbZ51a+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kURdJ+ZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAA5C116D0;
	Thu, 26 Feb 2026 03:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772076602;
	bh=7lCmbDv+2pRFz25J9Y5YD+I1O9idkhZlZdp0R+Bw6tU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kURdJ+ZV6FUaCIue5OgphZ6iCKILsjtgG7kBybGxnWFdJ/CE3AaK2Tpa0eHG5IpVd
	 fFWM1LUG4wTv0PKbpQTlMv/qoHFC6zcCr/4HWtg4824xHRfrXPCpLkaCN3TIoWy00d
	 aqVoi/V14euPqR4PptQWcNLnZIVWDhRD+17C5q5XAXS6onDp2JSP04hB7Ki5DHDJ4G
	 75ETwvHi0UeJE+Jnd2RhyF374d8qTfBt1HZSn7kg/fOqy/j+hNzDSxGPCOJSKw8sJb
	 SB3IoT2gDLzYKKlS9penxODyKwSWzP++vsZFYkzHoAvWPuUM6HHQY4JwkE0V6K4vgI
	 7Nw2LCnJGdNwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EBB380A94B;
	Thu, 26 Feb 2026 03:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/ibmveth: fix comment typos in ibmveth.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207660629.1022268.3552526517808096956.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:30:06 +0000
References: <20260224153601.17534-1-abhindeka@gmail.com>
In-Reply-To: <20260224153601.17534-1-abhindeka@gmail.com>
To: Abhilekh Deka <abhindeka@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-261166-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5834B1A094E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 21:06:01 +0530 you wrote:
> Correct spelling mistakes in comments:
> - Fix misspelling of gro_receive
> - Fix misspelling of Partition
> 
> Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v3] net/ibmveth: fix comment typos in ibmveth.c
    https://git.kernel.org/netdev/net-next/c/8debe7a22309

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



