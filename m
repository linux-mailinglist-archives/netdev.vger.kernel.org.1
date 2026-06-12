Return-Path: <netdev+bounces-298822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gzvwKlKbLGrcTgQAu9opvQ
	(envelope-from <netdev+bounces-298822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:50:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A9A67D181
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:50:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cI+MbVzs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298822-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298822-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 198733249A1E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23FA318ED2;
	Fri, 12 Jun 2026 23:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70A5301719;
	Fri, 12 Jun 2026 23:50:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308213; cv=none; b=I9vxGarW0i7NcWj1Cc9D13k/gJ6m8gT9z8KGsMJpO2985qTv1LjTedNkZtolocJAua3NmbEnua0BFBf3Sloxwwa16cLuPFNMwDIKHEdxU41mlRYxY2B/k+w6GzV82P+57/J1ein0T2p0EGeSpZ3//ZNZPRuoTULfl2LpvIXK16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308213; c=relaxed/simple;
	bh=cT2bba7hA669/5rneFxXHLEA7soszRhZlQftku+F7Kk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dBEoO4TYJTI41YcczKkstuJ1WJucjUIeusezEMfJGe05qebggP0IAzdOyB4ml2vyYk3Mp6vG7fP5X7YnbHWjOaseDqxAS4Ul8MNxq83kL0NkdLyyL5VwS+1EkDkRhK1LQK9W8zAj1UodNdDTtOfdT0vikicy6r+d7MBi4dd25gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI+MbVzs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB661F000E9;
	Fri, 12 Jun 2026 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308212;
	bh=GeQiU5lJzSA7sxR6Y50Gt+TLkWrbSjN8RcoHFYutCa8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cI+MbVzsBaNNXfByyg2QRsQnbujnzz9NMfhls1P/65NSOAb0fPadiZ4gXfrUp76Qr
	 ts23HZILuU3tUSiumZoQR9RKUIttjKp4mYnwYJapsd1a2OMWXITyIXvvnSjbt0O0UU
	 fvR0uOiwwFG2qqhizFRjQQTHJDbtBtn6mcRH+QzCdRlVjKoEKvSCJFYoce+ds0DM9j
	 hUV2Qjt+yAGOI20w8vLmyLl59agjhWwaOAXfycUwoi06hVkkddGaDVRa7XOLmpKyjt
	 WuUEuaYPRRMdAQMkbFhlFIp0wXqYlJmq9FIeouCbTcqOnvrHDsjaobPkf4ocTUz4QH
	 XAQ6ZibkT9axg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1980739E9602;
	Fri, 12 Jun 2026 23:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] virtio_net: do not allow tunnel csum offload for
 non
 GSO packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130820864.1294761.17379581600716494206.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:50:08 +0000
References: 
 <6c3b6c47fb05c100f384630dc48f3975cf37b67a.1781195144.git.pabeni@redhat.com>
In-Reply-To: 
 <6c3b6c47fb05c100f384630dc48f3975cf37b67a.1781195144.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 virtualization@lists.linux.dev, g.goller@proxmox.com, f.ebner@proxmox.com
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
	TAGGED_FROM(0.00)[bounces-298822-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:virtualization@lists.linux.dev,m:g.goller@proxmox.com,m:f.ebner@proxmox.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09A9A67D181

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 18:36:48 +0200 you wrote:
> Fiona reports broken connectivity for virtio net setup using UDP tunnel
> inside the guest and NIC with not UDP tunnel TSO support in the host.
> 
> Currently the virtio_net driver exposes csum offload for UDP-tunneled,
> TCP non GSO packets. Such packet reach the host as CSUM_PARTIAL ones
> with the 'encapsulation' flag cleared, as the virtio specification do
> not support this specific kind of offload.
> 
> [...]

Here is the summary with links:
  - [v2,net] virtio_net: do not allow tunnel csum offload for non GSO packets
    https://git.kernel.org/netdev/net/c/86c51f0f2313

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



