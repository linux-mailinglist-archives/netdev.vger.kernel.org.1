Return-Path: <netdev+bounces-256086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMc6LipZgWkFFwMAu9opvQ
	(envelope-from <netdev+bounces-256086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:10:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AF6D3A65
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB57A3006B4F
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679432F1FDE;
	Tue,  3 Feb 2026 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM0uQZ4k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43047145355;
	Tue,  3 Feb 2026 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084625; cv=none; b=IZpk0Po8L0O+LcDXK8m0IblHWR98Vdwdcl3y9Az2Q2jG2/3aqB3ykdLHYd3rpXOSX4guusS/wP0B3W5QztvAr3sOq74MqOb2Iyq8Qe9vo5cB3CMetKc5tTJczArUGQI5C3THSjn9EV8isqhqi9OWSH7MMP+B+bQ6/RYq91F3EPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084625; c=relaxed/simple;
	bh=IkB/CmACAS4jbkEUbnSz2O0qLvuph4aShjWmKsqVi8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u6fqnacfkldUzvahQ5RbrVC3d+YPRQqeyHwr9Gg3i0sjAtxI4MGmoaySeofKvb2ICzOwV4gJyvM5gTT7V7paRJ2bT2yn8xr7pFdkcF8jrf5nAT6HdpKuVUeY3O7z3Mc3pTv0l21F6PvZ7y4TJ2UhqiVwXfn2QzHe96uS3oQT4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM0uQZ4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A66C116C6;
	Tue,  3 Feb 2026 02:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770084624;
	bh=IkB/CmACAS4jbkEUbnSz2O0qLvuph4aShjWmKsqVi8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bM0uQZ4k1LAo04z/twyCpcQ3jZxZNusTUtYmKIWjRqgtRREpl8ukDfx23c0OcuoU/
	 Wneh/sjUL/JiMvD3xdQ76yihjxhzial5ntg8KiE4uQclx8svuzeBnrg2eSYeLJz0AG
	 dQwdNYwlpDzEPZGcmSE/SdAIJ4zcU1fU0rdw857cDWviYy+p7dJ+JfVxAQ/NculA3z
	 wuFK7OdCe7jMMukq4xcqbU830lcmR02twH43ACpvdU3qnJPTP5kp+arBhV6FKPpCQe
	 NSX14ZnUAD4GfQaQc0q5jArimrsmnY9G1AtMvmeBurGxfphGN3cWRiRJ988HaWXDY7
	 ejiuHKYt7uC8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CE0C33808200;
	Tue,  3 Feb 2026 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/7] ptp: vmclock: Add VM generation counter and ACPI
 notification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008462163.1277679.3528738405743179040.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 02:10:21 +0000
References: <20260130173704.12575-1-itazur@amazon.com>
In-Reply-To: <20260130173704.12575-1-itazur@amazon.com>
To: Takahiro Itazuri <itazur@amazon.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mail@bchalios.io,
 graf@amazon.de, mzxreary@0pointer.de, xmarcalx@amazon.co.uk,
 dwmw@amazon.co.uk
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256086-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29AF6D3A65
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 17:35:59 +0000 you wrote:
> Similarly to live migration, starting a VM from some serialized state
> (aka snapshot) is an event which calls for adjusting guest clocks, hence
> a hypervisor should increase the disruption_marker before resuming the
> VM vCPUs, letting the guest know.
> 
> However, loading a snapshot, is slightly different than live migration,
> especially since we can start multiple VMs from the same serialized
> state. Apart from adjusting clocks, the guest needs to take additional
> action during such events, e.g. recreate UUIDs, reset network
> adapters/connections, reseed entropy pools, etc. These actions are not
> necessary during live migration. This calls for a differentiation
> between the two triggering events.
> 
> [...]

Here is the summary with links:
  - [v7,1/7] ptp: vmclock: add vm generation counter
    https://git.kernel.org/netdev/net-next/c/3495064b6d65
  - [v7,2/7] ptp: vmclock: support device notifications
    https://git.kernel.org/netdev/net-next/c/3b1526ddb254
  - [v7,3/7] dt-bindings: ptp: Add amazon,vmclock
    https://git.kernel.org/netdev/net-next/c/1d5a66045afa
  - [v7,4/7] ptp: ptp_vmclock: Add device tree support
    https://git.kernel.org/netdev/net-next/c/ddc867d0b5db
  - [v7,5/7] ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device match
    https://git.kernel.org/netdev/net-next/c/ed4d23ed469c
  - [v7,6/7] ptp: ptp_vmclock: remove dependency on CONFIG_ACPI
    https://git.kernel.org/netdev/net-next/c/ac1e7404924c
  - [v7,7/7] ptp: ptp_vmclock: return TAI not UTC
    https://git.kernel.org/netdev/net-next/c/562f59fe3291

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



