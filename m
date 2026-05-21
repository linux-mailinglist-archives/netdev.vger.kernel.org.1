Return-Path: <netdev+bounces-290201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCulAuVpDmob+gUAu9opvQ
	(envelope-from <netdev+bounces-290201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:11:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A362459DF0F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E04593043A23
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF7C346FA8;
	Thu, 21 May 2026 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf20Z5aF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E79633F5BC;
	Thu, 21 May 2026 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329430; cv=none; b=UjRU2ikWKBmRFQI9GwMLTEutrYmc5Rimn4hAnRJh4nLnqrpcJiWs7JDWcobBwNDJxwYkroShL4bUdoZUEdylnZAITrSh11U83SSa/H37esvC+K6BJLwQFShGG0HhmXvjQvDNqTbPe28EohNZAvdh/CwKaSIhsVvI8VtyLa+Rtko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329430; c=relaxed/simple;
	bh=eozyLbpDdiloCRqtx0/ngaofjUmpN5fy7fLLFFFMWFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=byv2SlaF4jgl/UXuP+YkFGS3r/f+pFXCOiZjayBT7rzOEI8HACwUY55w+W1P417xwjdnfb4QBlcZUutMPK38mvbHuyG7B2xjYtTLrUo73SAwHbBhnOPFXfQo5PBY0f61am6lAcpMfHL+hBlTwNJFzzApH5ryFd5re3CGOmUPGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf20Z5aF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D87B1F000E9;
	Thu, 21 May 2026 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329429;
	bh=ivDt/eXSZ8q8zdAd+yr/i20mMcVaiBKx5g2mCtrA0go=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Sf20Z5aFKCSFP8HNP8vxrhjXrmjxbV5nGPLL+1lNEYHLBhn4Dp3iPfaM39B5QlOa2
	 AXyyjSiRX2qhcy2Ul7gjtsf7f5mX2dtRw7DJQujo0L5uAiBMI113uVk4n5B8wfdOEQ
	 RAvgoivg9q+Mrb9BLbWP4dwWtZ2P+r7DBgymxWK1tI5skX9Oq1htz4f9dJ2U0r+FHi
	 FrIUsGxS8XBBYB0igQ3UGl2kdUgQ/C16O96fe0JilPMsTRp03UJAUt508SUsSMTPKE
	 NnX8zxuVjxzqJTK3CET0WZb0L8sHGW8nHM5E/V7GnUb9Haleno6Q95c0zDT/EmxZxG
	 NzDOeEdhq2gIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939563930C38;
	Thu, 21 May 2026 02:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] dpll: zl3073x: Use named initializers for struct
 i2c_device_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932943911.3832404.650041739281306010.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:10:39 +0000
References: <20260519142710.1587324-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260519142710.1587324-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: ivecera@redhat.com, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	NEURAL_SPAM(0.00)[0.970];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290201-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A362459DF0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 16:27:10 +0200 you wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> [...]

Here is the summary with links:
  - [v1] dpll: zl3073x: Use named initializers for struct i2c_device_id
    https://git.kernel.org/netdev/net-next/c/a09dfac0296d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



