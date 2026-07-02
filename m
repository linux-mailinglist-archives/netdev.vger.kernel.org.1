Return-Path: <netdev+bounces-304034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ign9CawkRmqrKgsAu9opvQ
	(envelope-from <netdev+bounces-304034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9A56F4EB6
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:43:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TZ9kBmzV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304034-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304034-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9396330D21D6
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7742E8ED;
	Thu,  2 Jul 2026 08:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AFF42E8EF;
	Thu,  2 Jul 2026 08:30:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981029; cv=none; b=LGbYjN4RROxruFvDpwd9cybijCxzSalgYR6XR3+ooMvf0M777LSV2SvYEL68l5AuM4hk9aV+WE3z9sCO5QX5s5XlggbfAc6KhBbuU/ORLUfLzVovLoI2hVRHrNXAWEwHZLaDA3zlUwvFRH5ToqByYByQt04cj4l01Kd28bs19sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981029; c=relaxed/simple;
	bh=2bw4igrpyVtfYaTd0hz65BxwFOe7o8+X73iYDYgqe28=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iZbzmAat9rBxDXCqfWFkVyrA9gJmr+70i1yVzt5A4I0wXZL4MzJIbe7i1dvMze6ovjFotShz9aY9QVJHuGL8WfyvivEOfAoCwVbDazE7lq700jkaERd+8EmJl2SjIaJXukgb5Ng81/Sa5G7oR/018kDof+QtETnwhfOgHUD7tWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ9kBmzV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577FA1F000E9;
	Thu,  2 Jul 2026 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782981028;
	bh=9vg0GTfChhCKZvm+cnRjJqJAGTBXlNMHOD0tSCmhl0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TZ9kBmzVb0wnkHwyoIwysyqSoauLx+Yk7L8H60ATyCFaNYQTWTWS+MHETYRcavWy2
	 OXugWfJQttS8W1OLJ+DwW/vbhffMTpnuv7CBYoG4SHcTu9SLjOG1t2rsrpqAI6ayI3
	 Cl9eCtYyJJk9Q1PvTqE9kKge+lTx7Lunz4ElLSidHcjaxURl49rLJ/NMM4IGbzPbJB
	 NcUqemCmfXeVIXGEIQVR+KBner/zDCRYZ1fN0KwmGMuYYtJa9xsE7ljAIAV075Y3ND
	 mym41dmX/s+j7Iadh+AYvRjifubBMnd0yoVedz8qzPMg3Jkezdx9OCTQqzhrt1BbvA
	 Br3PbOPmDBf2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A07392665C;
	Thu,  2 Jul 2026 08:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: toeplitz: cap the Rx queue
 count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298101114.1518480.3634582587156593531.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 08:30:11 +0000
References: <20260629234354.2154541-1-kuba@kernel.org>
In-Reply-To: <20260629234354.2154541-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, noren@nvidia.com, gal@nvidia.com,
 linux-kselftest@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304034-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:willemb@google.com,m:noren@nvidia.com,m:gal@nvidia.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F9A56F4EB6

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jun 2026 16:43:53 -0700 you wrote:
> The RPS test needs a free CPU within the first RPS_MAX_CPUS (16)
> cores. This is easily violated if the NIC or env allocates the
> IRQs to cores linearly.
> 
> Cap the Rx queues at 8, we don't need more. This makes the test
> pass on CX7 in NIPA.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: toeplitz: cap the Rx queue count
    https://git.kernel.org/netdev/net-next/c/07d3aaa046ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



