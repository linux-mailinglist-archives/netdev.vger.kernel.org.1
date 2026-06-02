Return-Path: <netdev+bounces-294430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2zOvF5tOH2r5jwAAu9opvQ
	(envelope-from <netdev+bounces-294430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:43:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4F63228F
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:43:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RoXqJAii;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294430-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294430-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 544CF3067F3C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 21:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29C03A7597;
	Tue,  2 Jun 2026 21:40:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43FB367B66;
	Tue,  2 Jun 2026 21:40:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436413; cv=none; b=qwKMzDiuPoCFKIxa4dQcsTjTdqXWBJEMFfHjIQyF1ZFZ16gTg8DbUvNACoFCUeGeKAFN5Qp71joAOWQyEkM5LDqOwl0aufSOBkKuhaQ7Jo4hkkDYe+JaTnTXlHbEnGrz4HmUh22vPUzdjlHUWp+cAVB3/QhALQAjdxAsE44ti0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436413; c=relaxed/simple;
	bh=6cKaEOaoo1bEteb2wlOi3/V5XATgUszrwu2Rv7lF7Ok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X0eadwoPtkHrfNRbC0vMB8y6Yh5B1j0Q8/Dfh1r4yDKYkH8KEql782kLq786Uz2wLOFFwa33g1oVR9V6JpVj/WEe8n+VxK4mKpcHZHCnTpl7ArRD8Yquc2Gz2TKE7ajsno50YH2VehUyXVEb3zsW+SiWV/IlXeAaCNhr/AZ+2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoXqJAii; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897B11F00893;
	Tue,  2 Jun 2026 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780436412;
	bh=95pCHA2AVt+MKJZiKdXWN6AGeolznLP12Am6KewOb4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RoXqJAiiY040OGICFwjwOhG9gRrZadvwxIskO+Ck4iydkbTfxBj5bbKQ7bGaLZl+8
	 LlSXADi3IiTswxmcJ7Ok5/sQ42rV+tDgWryKFj0ShP9plUSU7XsnUSsEp4gQIqBc+q
	 jqOtSM70/Jd36LZO34VMgVSMTtiR5mc8vPvy2pSgbF+I1l3ze+CKjixCf54Wn1ffW6
	 wYY3h/uNM/1FIWa/Rdc9N62djKMUQpZvi2CXmwg3GGEa6UQkcf41tpRHBJQS2CYDRL
	 qdf7qx2VZPozGFv62oQ4PR0TxS5/MRoWGaTGb9TooU0M7NqiWpBGLNag/M3EFnwDHI
	 Ug/D7gDauVaMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A8D3811A76;
	Tue,  2 Jun 2026 21:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] selftests: openvswitch: add dec_ttl action
 support and test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043641414.1060922.17896897180668119864.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 21:40:14 +0000
References: <20260530021443.1734484-1-houminxi@gmail.com>
In-Reply-To: <20260530021443.1734484-1-houminxi@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, davem@davemloft.net,
 echaudro@redhat.com, edumazet@google.com, horms@kernel.org,
 i.maximets@ovn.org, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294430-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:davem@davemloft.net,m:echaudro@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:i.maximets@ovn.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ovs-dpctl.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9E4F63228F

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 May 2026 10:14:43 +0800 you wrote:
> Add dec_ttl action support to the OVS kernel datapath selftest
> framework:
> 
>   - Add dec_ttl nested NLA class to ovs-dpctl.py with proper
>     OVS_DEC_TTL_ATTR_ACTION sub-attribute handling
>   - Add parse support for dec_ttl(le_1(<inner_actions>)) action
>     string, consistent with the odp-util.c format where le_1()
>     holds the actions taken when TTL reaches 1
>   - Add dpstr output formatting for dec_ttl actions
>   - Add test_dec_ttl() to openvswitch.sh that verifies:
>     * Normal TTL packets are forwarded after decrement
>     * TTL=1 packets are dropped (TTL expiry)
>     * Graceful skip via ksft_skip if kernel lacks dec_ttl support
> 
> [...]

Here is the summary with links:
  - [net-next,v5] selftests: openvswitch: add dec_ttl action support and test
    https://git.kernel.org/netdev/net-next/c/d6f6d7123355

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



