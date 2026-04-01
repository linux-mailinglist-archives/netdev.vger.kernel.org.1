Return-Path: <netdev+bounces-273857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAZrE46FzGlXTgYAu9opvQ
	(envelope-from <netdev+bounces-273857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:40:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA782373F38
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC6231012B3
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35B1F4176;
	Wed,  1 Apr 2026 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap3XrfWi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C7033120A;
	Wed,  1 Apr 2026 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010630; cv=none; b=ZErGHpcF/b7oOv2s4RXmTGtfNzVh8WH51psRdmC4FkluPb/Rwr1EC4UnC+lEinbP+6u4uOVn4ptoHSELo/g40f3tRbvMZQiIV/HCq+jKuKVGuTSTtL9tb6AxgkIv7kwZHNKkWxSD4FceRW3VuOjv5rGxltFgsi7p9yS3bhcE5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010630; c=relaxed/simple;
	bh=Cwqf7uFjQGTGXEobsj1A8mxxBkvsYAwtxGNsAO5Plco=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kRP8CdulXgmQ5CDx+7sixEscQE0z4nyTUzBfE5n9gmrUhq9wMqb9q/0Rtf7ozRrqYrq+M5baeq1O2gCQv/mftdVRMI0l1IhaMr2QLfzraF3HLbimWEIoTUgbKIcmlGyP910gmqwv5O+qzIsXu5l1CGj6yykm1vN3194rm3BzTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap3XrfWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77074C2BCB1;
	Wed,  1 Apr 2026 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775010630;
	bh=Cwqf7uFjQGTGXEobsj1A8mxxBkvsYAwtxGNsAO5Plco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ap3XrfWiTtMeadFKnxkQeOcT1CjESA4VjiufQlz4ULRk8UkbhBnaXngJv3KuNJHh8
	 PS2IglUVjp3bkveHAHBRI0YKfi2GLZjj1p3vuxfk4/vmuwhA+8IuM1JKD+jZVLhPPJ
	 4ORop27devFNWZBoql/QTN3XLDbfOA6Ot4ntdJTJQmzh/Qc5mOzC2NguGxCrObwJZk
	 inYU8PpKqcaoDH/1lnCctv3s1tQdehpJbfGHVJTTg3b/OPwFm0lNjNYp/PcrIDgt+2
	 /SB3urfHswaHOWv0BXYeXCchhF+sID1sRctNXRanM0sr/z7B/BZpqaJow408jwnPMb
	 mwOW5vlt7FVHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C5A3808203;
	Wed,  1 Apr 2026 02:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net: refactor USB endpoint lookups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501061353.3039405.285600614072699753.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 02:30:13 +0000
References: <20260330102611.1671546-1-johan@kernel.org>
In-Reply-To: <20260330102611.1671546-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273857-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: AA782373F38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 12:26:09 +0200 you wrote:
> Use the common USB helpers for looking up bulk and interrupt endpoints
> instead of open coding.
> 
> Johan
> 
> 
> Johan Hovold (2):
>   net: hso: refactor endpoint lookup
>   net: ipeth: refactor endpoint lookup
> 
> [...]

Here is the summary with links:
  - [1/2] net: hso: refactor endpoint lookup
    https://git.kernel.org/netdev/net-next/c/da45a55748f2
  - [2/2] net: ipeth: refactor endpoint lookup
    https://git.kernel.org/netdev/net-next/c/abfca6b13bcf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



