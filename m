Return-Path: <netdev+bounces-299590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3GqzLpVXMGqDRwUAu9opvQ
	(envelope-from <netdev+bounces-299590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:50:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5337B68992F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:50:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kKcXZZXV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299590-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299590-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C50FD301136B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0303A783D;
	Mon, 15 Jun 2026 19:50:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AD93B42F1;
	Mon, 15 Jun 2026 19:50:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553036; cv=none; b=RwsueROciueLGfb6f1eueSVV3/DM3az60cqUy1mbDflRGk74eR/W+PyCnEPwfqkeCTeiiUSeJ4qHWx68kvLWg2GGjTuK+hKKup1L0iBT2emennY1xHQbq1DVgoygvS7AYgarauFhO0bjBN+ZCq17RVbT3j7pxzB+Hi8kaxYZiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553036; c=relaxed/simple;
	bh=EUFDYhrFJESAeO8mrJmNZcwzqnKAa8kBWCA473BPdZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jeovjTpb4ggP7zExRCosmpeRrxYDTepsRyrjdJ/taPiYRnJ5zP2sf76gWyzjpYv8Y5A2XBEyuXmgdTuCv3L4MF4QcRBT/Ivu9g5u5UJUO7mJN/F5F1saKXGqhBhzvLekqI+2+9DiU//WhRxsNOmMF7K/86X+6BfvpsL7xCoEtNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKcXZZXV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084741F00A3A;
	Mon, 15 Jun 2026 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553035;
	bh=Ywu36GF+JzT7opTbaIFg+FjRAJujNHtYpeGS/esxG68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kKcXZZXVk3SFxN41+tue3AjtTdQ33aKanaT8NIhs22f14XZNHP8kd+ZDPwocg4R+P
	 ZX48ITRVuqn0UBdyTBGssmyMJ9S6bVFmlI5I18HAdOJZgGQY7daJo2WRkyi4O6kIlw
	 qfnowwZLsPvrgfuvPst4aa0qKJ/lnB37Tt/9uW3S8Sx7E9nQt/JYqvfb3QisVGwXs1
	 4x6c208vwPKERl/BQGyStjZ04nxKyUjjnL+lJCLrHz/9V5kb8ozX/C8HOv+Rk/AzF4
	 QBhR6Cohb9hyd96OGe1xzAV6Z68hbwjumPwo7QWlZSi21jdYcbAtAdvFcTjiroHBjl
	 Inb06L0dubryg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569303839A06;
	Mon, 15 Jun 2026 19:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] devlink: Warn on resource ID collision
 with
 PARENT_TOP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155302988.269508.8987903722532704224.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 19:50:29 +0000
References: <20260611070856.889700-1-mmyangfl@gmail.com>
In-Reply-To: <20260611070856.889700-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, florian.fainelli@broadcom.com,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kurt@linutronix.de, jiri@resnulli.us, horms@kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299590-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kurt@linutronix.de,m:jiri@resnulli.us,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:jonasgorski@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5337B68992F

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 15:08:46 +0800 you wrote:
> Filter out the ambiguous case of
> 
> enum {
>     MY_RESOURCE_ID_A,  /* == DEVLINK_RESOURCE_ID_PARENT_TOP ! */
>     MY_RESOURCE_ID_B,
>     ...
> };
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: dsa: dsa_loop: avoid devlink resource IDs collision with PARENT_TOP
    https://git.kernel.org/netdev/net-next/c/b2772157e5ae
  - [net-next,v2,2/5] net: dsa: b53: avoid devlink resource IDs collision with PARENT_TOP
    https://git.kernel.org/netdev/net-next/c/89ccbd3fe837
  - [net-next,v2,3/5] net: dsa: hellcreek: avoid devlink resource IDs collision with PARENT_TOP
    https://git.kernel.org/netdev/net-next/c/31d2b61ba2cc
  - [net-next,v2,4/5] net: dsa: mv88e6xxx: Avoid devlink resource IDs collision with PARENT_TOP
    https://git.kernel.org/netdev/net-next/c/bfdf01f4d161
  - [net-next,v2,5/5] devlink: Warn on resource ID collision with PARENT_TOP
    https://git.kernel.org/netdev/net-next/c/f1e13d23e0c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



