Return-Path: <netdev+bounces-268860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FkzNvcZumm1RgIAu9opvQ
	(envelope-from <netdev+bounces-268860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:20:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 741212B5724
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE15C30162AB
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5473314AC;
	Wed, 18 Mar 2026 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR8CwocQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B09324A07C;
	Wed, 18 Mar 2026 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773804021; cv=none; b=uX7SV+JdpkaG+RUSHMXqin+71SRscmJPbshemEy/6b92S1FvB76bus77yhq8onsPP4EWBhwYlamgw0BpIpzYRXZLO87c6TH/2tlufwF/wty4lZhvE+bFkspVVIlTmh3F7B1OlQwjpxZe7z4cZ/hd9ZySDT7xADPNpQ5MgzVIn7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773804021; c=relaxed/simple;
	bh=TQCXS6vRLEUGRnELuJH4GVYhtF+w+rrDYROmlhU+bHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OgRSWKs99vmtlhxwxYNPKGTfKbOkUGRa68c+zC7ltv66WkTZbTVFFswACCgZdPQEMqM07iE/ftRS6gzfZwJiRDPAcln4XE4OPQw0MSk7psPH/MAgSIJOxk/FCAv8PYj/lQmZyJ93MAGsgj0WF9rNqMImi4MJFcR2b8VI8vFRENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR8CwocQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DB2C4CEF7;
	Wed, 18 Mar 2026 03:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773804021;
	bh=TQCXS6vRLEUGRnELuJH4GVYhtF+w+rrDYROmlhU+bHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VR8CwocQ5DWlBG5sAldNQyyWynhZ5IgGSyAXeSqMJEDZpFxFKevjcnj4xS7GWRict
	 wQHh514FPAdH4XQFePO/wlamNJHiiWDz1oCF4Bq+5Ph8JmTTYfC+4+GUIQJNaDjGbq
	 EonZfe/FuIP/labhMBMhxKr0AUDSaHRUhymqi8V1M6EtkLrNcNI3934iOwMMSydZ4C
	 Fqia9ycyCmtXDBiCKXDXifBgge0nDPluJ6kIaT0HubnFRJENoopxCFOmOQp243pY+y
	 YLVlgqWcG/JMtIl+ekCKm7zQ+T7AlSpSxmJa8dt2waYGW9wf3VthJ5NWFKrIYRXnRy
	 f5Dn2ts7T6d0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401933808200;
	Wed, 18 Mar 2026 03:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] dpll: zl3073x: refactor state management
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177380401316.109214.6390588576885603605.git-patchwork-notify@kernel.org>
Date: Wed, 18 Mar 2026 03:20:13 +0000
References: <20260315174224.399074-1-ivecera@redhat.com>
In-Reply-To: <20260315174224.399074-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 poros@redhat.com, mschmidt@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-268860-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 741212B5724
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Mar 2026 18:42:18 +0100 you wrote:
> This series refactors the zl3073x DPLL driver to centralize hardware
> state management behind dedicated per-module state interfaces, replacing
> scattered direct register accesses in dpll.c with cached state and
> proper accessor functions.
> 
> The driver already uses a fetch/get/set pattern for ref, out, and synth
> modules. This series extends and refines that pattern:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] dpll: zl3073x: use struct_group to partition states
    https://git.kernel.org/netdev/net-next/c/f327f5a8115e
  - [net-next,v2,2/6] dpll: zl3073x: add zl3073x_ref_state_update helper
    https://git.kernel.org/netdev/net-next/c/05ea2ab3b100
  - [net-next,v2,3/6] dpll: zl3073x: introduce zl3073x_chan for DPLL channel state
    https://git.kernel.org/netdev/net-next/c/3032e95987fa
  - [net-next,v2,4/6] dpll: zl3073x: add DPLL channel status fields to zl3073x_chan
    https://git.kernel.org/netdev/net-next/c/41bab554d7e9
  - [net-next,v2,5/6] dpll: zl3073x: add reference priority to zl3073x_chan
    https://git.kernel.org/netdev/net-next/c/f6b075bc3ad5
  - [net-next,v2,6/6] dpll: zl3073x: drop selected and simplify connected ref getter
    https://git.kernel.org/netdev/net-next/c/acee049a6af2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



