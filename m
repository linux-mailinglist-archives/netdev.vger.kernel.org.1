Return-Path: <netdev+bounces-304382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CbnSI+FeR2qvXAAAu9opvQ
	(envelope-from <netdev+bounces-304382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:04:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F376FF582
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:04:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WoqqCIck;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304382-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304382-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0E103057D76
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70AF38A729;
	Fri,  3 Jul 2026 07:00:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A7385D64;
	Fri,  3 Jul 2026 07:00:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062034; cv=none; b=MYqVWqvQ7AM7wR9YPS9+dYUr03jwORHQVq8yBPeSeOD3Beq2QQZ4BFdnUkrwkMnBD3X+GH6yb/422wvMkkQZ4DqPnPZKwAp6YrvV1Tjd7RIyt5uuKALzfa0i7WsVPqNmcAbYybqcAH9m8+IozXkWslxIgBlx4MV/ZrnsHSVSycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062034; c=relaxed/simple;
	bh=z++ngxRb66TNBiKHwufjl5IT9u6RoWUAiepDpClhv0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PCiHUG6R6LD1qFlngtk+ul5dGbzhVkrJi7Q0aIND+5kkp/EP0gWvQt5AUWLspedFabix3Pd+MX3A6y+j8k1OANPRuFI29BSJTa6azRB+9NNnKbG5iQRVFi0n1QtfpdTFeCaI8Pcud6Ez2bBVkN8XgE7q1lNLTeK0lz8gQ2cb5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoqqCIck; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7C41F00A3A;
	Fri,  3 Jul 2026 07:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783062033;
	bh=Mlg/7o/uXYGVV6CdKrSHCzMBej7X3M2kBDgsG3s/9HA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WoqqCIckQa8+VDQrHX3tNVPe2bBvYZQQZt7wYUgZLng6nOO5eB3zj7+2YS1ZTFwjM
	 yUjZBBelvkQ0Vz90QKT20VeZKwrVUx0iCUzTrsfHXeknx/GevnD1q5liW097bhxy2Z
	 VkvJ7gnh/uxJnrH0MiS9K9CnmJd726fq17EP/r1ui2hh4tATw4pAfgELGm6nzfZsfT
	 yaVQqWYWniYRYjTEVVGEDqDuVcfPVcQSWylI6+3Ay0n9gDQIbPHzWvB8nk1e6TyRz8
	 p2+PZFgKVwjX/jHKvtcIrp1RoSxtCjaX8iRgRNDBImNIPNfS11SlzRCLUewwQ/+hBO
	 yD5hYZBpDLx8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1997739387AF;
	Fri,  3 Jul 2026 07:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: report multicast group user count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178306201573.2494164.11397995719215578269.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 07:00:15 +0000
References: <20260630110207.37841-1-sigefriedhyy@gmail.com>
In-Reply-To: <20260630110207.37841-1-sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, dsahern@kernel.org,
 donald.hunter@gmail.com, edumazet@google.com, idosch@nvidia.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,gmail.com,google.com,nvidia.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304382-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9F376FF582

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 20:02:04 +0900 you wrote:
> RTM_GETMULTICAST reports IPv4 and IPv6 multicast group membership, but
> does not include the per-group user count. Userspace therefore still has
> to parse /proc/net/igmp and /proc/net/igmp6 to obtain the Users column.
> In particular, this prevents iproute2 from moving "ip maddr show"
> entirely from procfs to rtnetlink.
> 
> Add IFA_MC_USERS to carry the user count in RTM_GETMULTICAST dumps and
> RTM_NEWMULTICAST / RTM_DELMULTICAST notifications for both address
> families. Update the rt-addr YNL specification and extend the rtnetlink
> selftest to verify that two joins increase the reported count by two.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: ipv4: report multicast group user count
    https://git.kernel.org/netdev/net-next/c/7cb8198761e6
  - [net-next,2/3] net: ipv6: report multicast group user count
    https://git.kernel.org/netdev/net-next/c/e1d0f3f08391
  - [net-next,3/3] selftests: net: check multicast group user count
    https://git.kernel.org/netdev/net-next/c/3373cb099e66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



