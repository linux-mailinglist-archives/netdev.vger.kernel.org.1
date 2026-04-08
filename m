Return-Path: <netdev+bounces-276231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKDUGf2v1Wk18wcAu9opvQ
	(envelope-from <netdev+bounces-276231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:31:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A71FE3B5F17
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04C34302DF6D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 01:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAAB32143F;
	Wed,  8 Apr 2026 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZaYCp/S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD434AB19;
	Wed,  8 Apr 2026 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775611859; cv=none; b=V0ILkM8WOZ4plT3hIS4pwH+1P2YwkVN8XrKix1uN7cYH0RENh4QmopSuYj7LXeMjcuJ+Zmc6zf4FwFh7wonE+ME8B/Qw07SgXDXkeyi1TVYGk225z0AmbUERB5neibMjrrfKdkJGgyUexHGfZLMrO2epiF4CjukVNRaPfEfm2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775611859; c=relaxed/simple;
	bh=CmZPb7vFxIrmMQ/rUIO3y2Ha+q/NS6f746SXTbXVlFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JjrTm/O0/5yBHq9tXt6qPqhNE2WUb74tlhNWjoJQnrgEurWWPke+ILCuUTxErDpjDA6Ig7i0MHdFbP67ir3C7d7xawq0oZQ5ydKC+icaOsrgdE/Yvd+mP9fUMs5eHpWvCJO9kEE7UCsOMe8nQ6pbaayuT1gnoKYmP/pi6mKKIsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZaYCp/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41950C19421;
	Wed,  8 Apr 2026 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775611859;
	bh=CmZPb7vFxIrmMQ/rUIO3y2Ha+q/NS6f746SXTbXVlFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WZaYCp/SaKSSHZ0xnG0oqW3CJKj9BvYXeNGVd80zqrrulZDthHbA3l2MOK/36M+XI
	 /ElafttOhrEHbutQfEFOzOhuiH0jPoqoBzlkqjbbA17qFZb51seD4Oib3Jr3/pf0rc
	 njg/vpOQcUuUbfsBJuy2uh3TT/pcrWk9scuzY0FeB5F+6SIhwYX/sRFn3sCiCkcKRn
	 0waWfUkjGLlm6MRiJSd0Hz7+y2IJvKgMqknBdcmbI/UNJPn9g5hITQPtZpt+PcynNP
	 54BitS6dXF3+Le1JXOQ/ajO2SBRRVABLQZUlA83pp0r8BS+oTpVecirI0mVYBQq0xR
	 /6iqtLamKgifg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA00D3809A3D;
	Wed,  8 Apr 2026 01:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: sfp: add quirks for Hisense and HSGQ GPON ONT SFP
 modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177561183629.28494.6162682994883134425.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 01:30:36 +0000
References: <20260406132321.72563-1-jspavlick@posteo.net>
In-Reply-To: <20260406132321.72563-1-jspavlick@posteo.net>
To: John Pavlick <jspavlick@posteo.net>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, marcin.nita@leolabs.pl
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,leolabs.pl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276231-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A71FE3B5F17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 06 Apr 2026 13:23:33 +0000 you wrote:
> Several GPON ONT SFP sticks based on Realtek RTL960x report
> 1000BASE-LX at 1300MBd in their EEPROM but can operate at 2500base-X.
> On hosts capable of 2500base-X (e.g. Banana Pi R3 / MT7986), the
> kernel negotiates only 1G because it trusts the incorrect EEPROM data.
> 
> Add quirks for:
> - Hisense-Leox LXT-010S-H
> - Hisense ZNID-GPON-2311NA
> - HSGQ HSGQ-XPON-Stick
> 
> [...]

Here is the summary with links:
  - [v3] net: sfp: add quirks for Hisense and HSGQ GPON ONT SFP modules
    https://git.kernel.org/netdev/net/c/95aca8602ef7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



