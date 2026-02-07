Return-Path: <netdev+bounces-257733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDS6N43EhmnrQgQAu9opvQ
	(envelope-from <netdev+bounces-257733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:50:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80839104F0E
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 356AD300909E
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F172EC0BF;
	Sat,  7 Feb 2026 04:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/xxfBUB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199E2EB87B;
	Sat,  7 Feb 2026 04:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770439817; cv=none; b=Xp4MO8EWNCLX7eulSoi95Pq9p85e0d6fHZekynPOPirnaYD48K3guv6KSN37r8Ah05n6r0JDwKv9hh7L2EYpG/aPG6IQi2UTzSEYnWl5oMn3Y03vlp1JuG5bK6P17nqiNJbhfsxSDttgc9CjMsh9oDFBwQn4Fk4L7QM1xJM18pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770439817; c=relaxed/simple;
	bh=tJI0mQsCX/ctAmU5YB2Kr6C6MU13J0g52VYnHVaRz04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KmvjA3oDmd3L5Or3aOr0xKeAO8NxP2B0XXVWS30/pm6ZKKbP/n9J72+X3lbLk52NdBnS8is+IOUJhYwyGECrDoA8Ihc4Hl45wx/rMYcCBksjJ8Ro5nQOxA6mFK09oeFL2H0Y1P+29laxNSpycmB5/4GcIQzGAw3Qt//SJt8KsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/xxfBUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD95C116D0;
	Sat,  7 Feb 2026 04:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770439817;
	bh=tJI0mQsCX/ctAmU5YB2Kr6C6MU13J0g52VYnHVaRz04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K/xxfBUBnrZozjcJxUjXBh7vBy+MMPy5obHeF1otn+rs4mTdP8P6bj0wgtRuRZEsa
	 VD8rgMkPwRUJjA21DHcV5PC9zBANDMoXMjFYCc3XGlpidiIWNE6GcYF9Eq8xZmNKrh
	 xPZKNdTeszjGtsDMh5jA22nAT7JvJxe4mGx/a02rOfhk4jl0phJ0rzFsayHXwUKJHv
	 t6fNDttpaFI7CBK5iKIKhOaATRnD1jDrC1wt1djtkTFAqf5vtn5Ws6XMHnG/40q27f
	 lbrjUP1rdnPUM+X4b8EotAhDHEoiVcFktA1AstcojXWBixrv7gkVyCndiiRDXNRCRE
	 vmqXLWBoUcHsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 854923809A1A;
	Sat,  7 Feb 2026 04:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: zl3073x: Fix output pin phase adjustment sign
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043981432.1190979.6522717950490483045.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:50:14 +0000
References: <20260205181055.129768-1-ivecera@redhat.com>
In-Reply-To: <20260205181055.129768-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-257733-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80839104F0E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Feb 2026 19:10:55 +0100 you wrote:
> The output pin phase adjustment functions incorrectly negate the phase
> compensation value.
> 
> Per the ZL3073x datasheet, the output phase compensation register is
> simply a signed two's complement integer where:
>  - Positive values move the phase later in time
>  - Negative values move the phase earlier in time
> 
> [...]

Here is the summary with links:
  - [net] dpll: zl3073x: Fix output pin phase adjustment sign
    https://git.kernel.org/netdev/net/c/5d41f95f5d0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



