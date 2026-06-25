Return-Path: <netdev+bounces-302040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IQ0VARZXPWpa1ggAu9opvQ
	(envelope-from <netdev+bounces-302040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:28:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C886C778A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:28:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Azc0EV4o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302040-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302040-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6388931174ED
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4A63EDE42;
	Thu, 25 Jun 2026 16:21:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA13EDAB1;
	Thu, 25 Jun 2026 16:21:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404473; cv=none; b=cZgo8QY+yX3CtLQsAYvhGERpIRgdHHIG5g6Z3JEF0jqkAtG7TnbBds7Dv2Ab9DRLcS1emH2AdsFPB/tvzm6YKkgx1Qt32LK30XYymd1Z49ZlqSzetji0VoqnsJ79I6zdx2AqYEyjEjkKoVjwz+GwtYqQqWL27m60RWJWRBQTObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404473; c=relaxed/simple;
	bh=YN08UWBdkyyc1Hf8Mluj2zNVgcnCyZOAW1EP3N3qaHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hQ36Fv8QezaLpc0jD4J/M/m2qZmzuBkWrlX0n+yhZj89a4rXM1JpsOn9Ap3dxrZs/TaF3Z6IatAE52TD2pF8ZTYOW25F15xZCLodBBLiEgiwkxqpiqwGT3ch65VqLinEOk2Q+fNAS7L9a7dKSB4wPclogm2o+x1aShZ4qJq7QZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azc0EV4o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7E71F000E9;
	Thu, 25 Jun 2026 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404472;
	bh=XxiZ1wHM3ANnlh39A/D4FkP6dgtvNEO7QZKv89EiFn4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Azc0EV4o6nqtreFURXbzfgHNPNvzJQI/nKsnHTW1CpTkfiL93FplY8jgpBZuWMUUz
	 8w3KgGBbVyhOO27GOtm0brY7enkrCf/PqtsvRFTID0BE0CvQfInGwk3z/vsk73xzjh
	 T2Phs2MqQkiccwCC3OWkc85JQSYstTBfcqhMBiZCnBpx/SjAqPiK2/0OlSCC6EymDU
	 wFIlYKsgezOwdyAvxMNqMt2TCFH24fztGm/EhBKLiaPmlcGLbpyVkxxc9lasMZ27+e
	 Nv1aouk8EX/WyTIjeveDPspv4t3MhV7OKuNitIZbhZ9Gm5KblQicc6y844A/UOdau2
	 uxU/wRMECj+eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9395B3AD449A;
	Thu, 25 Jun 2026 16:21:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: fix potential divide-by-zero when num_vsi
 is
 zero
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240446029.3803792.16487953963500361613.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:21:00 +0000
References: <20260624072726.1238903-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260624072726.1238903-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302040-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:wei.fang@oss.nxp.com,m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Frank.Li@nxp.com,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60C886C778A

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 15:27:26 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> For i.MX94 series, all the standalone ENETCs do not support SR-IOV, so
> pf->caps.num_vsi is zero. This leads to a divide-by-zero in
> enetc4_default_rings_allocation() when distributing rings among PF and
> VFs.
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: fix potential divide-by-zero when num_vsi is zero
    https://git.kernel.org/netdev/net/c/5da65537792b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



