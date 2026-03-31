Return-Path: <netdev+bounces-273428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDlDC5sfy2mdEAYAu9opvQ
	(envelope-from <netdev+bounces-273428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:12:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C50362FFB
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC5123051CB1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7952EC553;
	Tue, 31 Mar 2026 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQkykAGa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49399548EE
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774919427; cv=none; b=ajeNBr0hq++u89So3jhCK7hMvTtUAV9ksucu3akMZtamJXElQtGrbK0gUrMWwtAEdZTURNx60mZaEkNIiFaozzz0GQCIPezQfMemyCcCxSi995vM4N9TSZlzohIv67qAShPza8g//OXWC53FLvD8YoF+asGRZydCCOVSL1zIdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774919427; c=relaxed/simple;
	bh=rFMcBYeopbsen4UF2EndeJk0OSUhO9PRv3WemTAI2lg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SG6tws2Gf+3c2dKLdrKpadH0pSiTEOKGy/XkM+EfBFobmX7b8bAiP1PMYiga3rz67j8YHpUoEzMkgGP/mtOSa/zn9bkatoZLFsQe1kJgpE7NIDt5DOZqhofpxki4y3YfihCS7+Ncbf5e2tjHXywlUnlC8y6cxwxSo9kVk3E4CBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQkykAGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA05C4CEF7;
	Tue, 31 Mar 2026 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774919426;
	bh=rFMcBYeopbsen4UF2EndeJk0OSUhO9PRv3WemTAI2lg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RQkykAGaQ8Hda8DjWN61ks9t9LmuKde1eVeVeGWbUzz0oHlCGDlH4H3z3Vl/ad9cJ
	 c+PKO00Z7ZWqGD4UAjwUBlN3p0jdqz+K26VG4Mqa8MTq5VTlaU47qTruPNWjKzJe0q
	 LxV+1phkBqKa9yc2Na470eyflxZQxt7Etu8pMcYTTXO2TNxJKWQp5/LQFLVS7TToxI
	 rpO6+BM5ruLjphPUFO1GKDsAYzOJhOfXrAQHNSpac6QZLYyNS4LcWObYoHDMC2+dYH
	 1L0gAcAfK7Ay3gm6ir5LHPTq+2KDzWUE5Ko+BvsDF4EXCnqDGqqhvOMN+ih+BZ4+tX
	 rba94M3WRROCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0CF32392FF97;
	Tue, 31 Mar 2026 01:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: airoha: Delay offloading until all
 net_devices are fully registered
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177491941075.2043537.8277292762892112886.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 01:10:10 +0000
References: <20260329-airoha-regiser-race-fix-v2-1-f4ebb139277b@kernel.org>
In-Reply-To: <20260329-airoha-regiser-race-fix-v2-1-f4ebb139277b@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273428-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75C50362FFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Mar 2026 12:32:27 +0200 you wrote:
> Netfilter flowtable can theoretically try to offload flower rules as soon
> as a net_device is registered while all the other ones are not
> registered or initialized, triggering a possible NULL pointer dereferencing
> of qdma pointer in airoha_ppe_set_cpu_port routine. Moreover, if
> register_netdev() fails for a particular net_device, there is a small
> race if Netfilter tries to offload flowtable rules before all the
> net_devices are properly unregistered in airoha_probe() error patch,
> triggering a NULL pointer dereferencing in airoha_ppe_set_cpu_port
> routine. In order to avoid any possible race, delay offloading until
> all net_devices are registered in the networking subsystem.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: airoha: Delay offloading until all net_devices are fully registered
    https://git.kernel.org/netdev/net/c/cedc1bf327de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



