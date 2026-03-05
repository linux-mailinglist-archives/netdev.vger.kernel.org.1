Return-Path: <netdev+bounces-264144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBO+LyvtqGnnygAAu9opvQ
	(envelope-from <netdev+bounces-264144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:40:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2959020A42F
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AF97306C462
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA6267AF2;
	Thu,  5 Mar 2026 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qekti/wf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8367B26738D
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678429; cv=none; b=k8cY8AktpQvNt7y8/oZf2+ExkiBZHR5pC0dWzfrtLo8no2m1YT1K8djTzbUooLnN0HAsqZOIz7lLsh0/w3P2wzVOnhDX9D+xvkLRnEDirUEp0xgEFnpo5ZMzkpPW65a/bXIIbuqOAjHqHcSbUf3NtwFNos9Vaq+kKdGZoMcci3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678429; c=relaxed/simple;
	bh=xkFEe2vMd5jWzGW1V9fqgl/B94uA+hFfZSFbqYoQzfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MPg7ykwsLG1wO87n4ug9efbPl2FPLVd7dXKUPGpRVUCQP8E+iOx55QBLMEcVzqn9QI1n1XGf9opNPbh0vpzWSTF5/pXb3fwsRtRhbcSgIKkMUAw/EL2HcMNIhi8ygPWtKh2kLgefCGToISYrfkV8v7czUXL2Sg2nMZ9KtIaKqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qekti/wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D768C4CEF7;
	Thu,  5 Mar 2026 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772678429;
	bh=xkFEe2vMd5jWzGW1V9fqgl/B94uA+hFfZSFbqYoQzfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qekti/wfRccxMbffU9gDw9HbMUJoAgOBdE1SWau/nMOhJsV1oMTjLqHWzKMtE/cMZ
	 v0C9ZPZVZ5Xvcj3vJacpNgGskpce0OHvJLUbaxJkAJxzRFKEcLzA2dHJJ8JZCzwwKX
	 1Q9ZrRbYB1VgavQvLszhCfQsjalKriC3PaDp0wUjR4EENMh+T7LVJ1A4wYF5kKhhDK
	 bQnGWdMesX7K+02fHocmDHAjXMaPhR/PQf+BgjwWzLqLcyzBWSmmW4Q89mcbpNlegu
	 Wqf5oQlrFfxO/bBmvq225BZaMNnSwk3r/Et2KpdSkBNQZDoEetNGSIwhEHjWoU+fS1
	 69ZbbZVlzsmvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F333808200;
	Thu,  5 Mar 2026 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2026-03-03 (ice, libie, iavf, igb, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267842929.2487871.11008962542144563866.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:40:29 +0000
References: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
X-Rspamd-Queue-Id: 2959020A42F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264144-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  3 Mar 2026 15:11:46 -0800 you wrote:
> Larysa removes VF restriction for LLDP filters on ice to allow for LLDP
> traffic to reach the correct destination.
> 
> Jakub adds retry mechanism for AdminQ Read/Write SFF EEPROM call to
> follow hardware specification on ice.
> 
> Zilin Guan adds cleanup path to free XDP rings on failure in
> ice_set_ringparam().
> 
> [...]

Here is the summary with links:
  - [net,1/8] ice: fix adding AQ LLDP filter for VF
    https://git.kernel.org/netdev/net/c/eef33aa44935
  - [net,2/8] ice: reintroduce retry mechanism for indirect AQ
    https://git.kernel.org/netdev/net/c/326256c0a72d
  - [net,3/8] ice: fix retry for AQ command 0x06EE
    https://git.kernel.org/netdev/net/c/fb4903b3354a
  - [net,4/8] ice: Fix memory leak in ice_set_ringparam()
    https://git.kernel.org/netdev/net/c/fe868b499d16
  - [net,5/8] libie: don't unroll if fwlog isn't supported
    https://git.kernel.org/netdev/net/c/636cc3bd12f4
  - [net,6/8] iavf: fix netdev->max_mtu to respect actual hardware limit
    https://git.kernel.org/netdev/net/c/b84852170153
  - [net,7/8] igb: Fix trigger of incorrect irq in igb_xsk_wakeup
    https://git.kernel.org/netdev/net/c/d4c13ab36273
  - [net,8/8] igc: Fix trigger of incorrect irq in igc_xsk_wakeup function
    https://git.kernel.org/netdev/net/c/554a1c34c11a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



