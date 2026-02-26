Return-Path: <netdev+bounces-261158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCDDGCe8n2ktdgQAu9opvQ
	(envelope-from <netdev+bounces-261158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:21:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E77461A076B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72B49300A7D7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81552311C38;
	Thu, 26 Feb 2026 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmdcSooX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EF2727E0;
	Thu, 26 Feb 2026 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076008; cv=none; b=UTNqVGST2nizAsl177mutZfYy5q7a8cEpwkMPopcCyIl1oRAUuZz7t1NSuXTlAOYP46RS8pu+nzkHFGdCiqlOt9P59FwxDXRukW1ruUIOeehPfm38ZotiwQzWOz6LV+KHQVSZ3NkrbV44OQ0Q2nI5LCHw+PjxsfXP6j4RkfBuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076008; c=relaxed/simple;
	bh=xugchI5TC8kDJlZj+zK0zU57UQ5m7JSKube//5QBkFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dvjbhUbLJxVYfbezQ7TebZHnna1/8yaCfxjd9LMtZzP1+9LRh5HWXkYydK9lW17UnHoDrhbXAzobu7WcB5SCpIfcgY3kEXWQSJsDxH2Zvo96RBfn43msQ/JKrylSuwVggWZWatWh7RWIzd8RKXpSimz+aDj9TG5Bg2ddRv+ly7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmdcSooX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07374C116D0;
	Thu, 26 Feb 2026 03:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772076008;
	bh=xugchI5TC8kDJlZj+zK0zU57UQ5m7JSKube//5QBkFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pmdcSooXM3JhH4fiPWFuReou3oPc/MSkRAK537pQlEH0IOa0y5VH8gXS63rKFQ5wO
	 fOKJleO3BPz26VxR6MFpY76ip/sMNI10q1B5c7X+bm1J0bEkSERxp0PevaoQpmtx9t
	 B027KzMPzo0l8AOv0qp9E3WlAgEU/HNdMjMTss55T/GSYYiqzb3hGQLJF2Fi9TB9Bk
	 N67td/j2KkqQ7CQYJSSrJnGFPqf/ibxTwSYkffb3ick26G9RkqJiSS8hQbMVoQhrmT
	 XHrdplW1fxxI8inESSVd274T355zAz8OUdd16ePKklAimBeuDRggkq9h2O7bp38T/q
	 GF59PNOVciDeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D99380A94B;
	Thu, 26 Feb 2026 03:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dpll: zl3073x: Remove redundant cleanup in
 devm_dpll_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207601279.1018003.4268544138074557807.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:20:12 +0000
References: <20260224-dpll-v2-1-d7786414a830@gmail.com>
In-Reply-To: <20260224-dpll-v2-1-d7786414a830@gmail.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: ivecera@redhat.com, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, przemyslaw.kitszel@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261158-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E77461A076B
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 19:04:04 +0800 you wrote:
> The devm_add_action_or_reset() function already executes the cleanup
> action on failure before returning an error, so the explicit goto error
> and subsequent zl3073x_dev_dpll_fini() call causes double cleanup.
> 
> Fixes: ebb1031c5137 ("dpll: zl3073x: Refactor DPLL initialization")
> Reviewed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] dpll: zl3073x: Remove redundant cleanup in devm_dpll_init()
    https://git.kernel.org/netdev/net/c/676c7af91fcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



