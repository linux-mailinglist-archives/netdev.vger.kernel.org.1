Return-Path: <netdev+bounces-306280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qyYFH9K3T2r+nAIAu9opvQ
	(envelope-from <netdev+bounces-306280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:01:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94998732963
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:01:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IYUQY8C3;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306280-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306280-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D830B315DC1C
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B336CE03;
	Thu,  9 Jul 2026 14:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739303806AF
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:40:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608029; cv=none; b=g/EL26DpBSzdDRB194EP9CvXvcv72GpiJlvMPKYUdBIquKCzCxxBf8entnT33CU3COeEtyt5qSFKT1ii7L3oRNkjaDpki2B/vR5W9tQ74LADa7X0skAjXQgKqqt7jzLV9geQ4DFR3w78qlwUTAtNgHWN970klvqK39dK3fniz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608029; c=relaxed/simple;
	bh=ObHZPg+9DIViYsCSa6s5IpPCIrlylp/uoVITxCiC/E0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kwDeCKLJIz5/phj2czj7m0Khh/9WZcF0WBy/evv84/k4LNWB/pRSjUhFvZYB3SNsosQHnf6eM0YRlC4b1COiEq1fhoS3NhHUOq01UNV5kcmNeyHSDUBHz7Ts+fwHJKm98DZqNhpPYVV3vzmT1tUMgoi92+QX4CYoRAfoGiiFkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYUQY8C3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536641F000E9;
	Thu,  9 Jul 2026 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608028;
	bh=r0iux4Nm1ux0AjP8obWiH9icVC6cxwm62zTJ8rrwJ+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IYUQY8C3BSQf54AWqQYWtX2LySuy/U5gaE5x9XyYsgYYMJUm0WCnub3aZj49pDkYt
	 u5PdYNYjYSTlCV/0+2M/3F+w4ZSWUxK3rlXf97n/sGMpu2xPDvptSwoxnkDDdRbQCa
	 pb/dtiYthlJLkAVAcg7OWbltE4N/g3Ks0t3qMqMSlFOC/Byc4NAvruBcTQq5MHVMJ0
	 +TAABkbpu2d5swRsbdcaV+OuEsaY9O3eLlsNTmbKW5fr9fzExGnCNQPlrJQYBeL+fc
	 KM2XhVAzWc2Juceq1G1oRkcmjVN+Efm3DmzWfVJ8PbGLauaoX7dcnn/KN87evOEIbx
	 HyJHDWofb2w/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C039250D8;
	Thu,  9 Jul 2026 14:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 iproute2-next] ss: stop displaying dccp sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178360800689.3521873.4056238946296200606.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 14:40:06 +0000
References: <20260701025005.76589-1-laoar.shao@gmail.com>
In-Reply-To: <20260701025005.76589-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: stephen@networkplumber.org, kuniyu@google.com, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306280-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:laoar.shao@gmail.com,m:stephen@networkplumber.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:laoarshao@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94998732963

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed,  1 Jul 2026 10:50:05 +0800 you wrote:
> DCCP support was retired in kernel commit 2a63dd0edf38 ("net: Retire
> DCCP socket."). However, ss still attempts to query DCCP sockets via
> netlink, which triggers repeated SELinux warnings in dmesg:
> 
>   SELinux: unrecognized netlink message: protocol=4 nlmsg_type=19 \
>     sclass=netlink_tcpdiag_socket pid=188945 comm=ss
> 
> [...]

Here is the summary with links:
  - [v2,iproute2-next] ss: stop displaying dccp sockets
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=3c0b939e88e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



