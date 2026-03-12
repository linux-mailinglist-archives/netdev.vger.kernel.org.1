Return-Path: <netdev+bounces-267049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMh6C7e0smmYOwAAu9opvQ
	(envelope-from <netdev+bounces-267049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:42:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE28271F1B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 511FA3045005
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A1A387597;
	Thu, 12 Mar 2026 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXh/dFry"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE61DF271;
	Thu, 12 Mar 2026 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319210; cv=none; b=l2oBaR05TGwnZTbWVluHxfbi+5HSBuftzkfFxrv9N2og5wWcU2jKc8ouoAbPqg4fVOsoUCAbJZq6/ThHWLqWp8kASCY0U1XKIOKaqjZzhZ8EZ3TFq4Lt3lB896e3IgdAKRfyDBkzF6A+kaxMycRIRTsuioCceK80lT0rg0Tle7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319210; c=relaxed/simple;
	bh=PufnIx8LdWeVV3gpXlB9jKSjN6vMEdvNOnxRzhERNV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DnUxAzJlMtn/G+AsWpf24IOAjg2cTd0p+r59bkquBMjyJxFgJlYTReWSQODF0nVL2to3SFhDPXCkBks/hhnwP8YpmkdQ7yJz9O6VvRfXIc08TtFK9SoRr78nQ0xjzGlclK6tiLsAgLOo2PN9HIvopN7lqOB2QotlkFqQD4zKdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXh/dFry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E01C4CEF7;
	Thu, 12 Mar 2026 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773319210;
	bh=PufnIx8LdWeVV3gpXlB9jKSjN6vMEdvNOnxRzhERNV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EXh/dFryv1w0ZniWRmTcjnfaGqaeTyFvQ4PXqyrw2dcx8PR4sU514nSObKn7MXx69
	 fvgZ/PKVkG1uUwYd+vLGdMzw38+Hf0buXqjfCJKCFd5cZftC5tGrPsFggAv+uBZaPp
	 Nih0la3jHhXzJJeY7looW0HHXaKssxciyCZvxx0qHpOAZG1NiEjtZK63joyPcKSe7r
	 ijhNDxyf0AQ1LzsBZInsTc4pNY/F81rUftwxc+mHL/B+l6hB9oUISpFf6LuWgYo3xm
	 gMz0YkfDSPmGT/d3V8zwr42Ai0wQUZS5kab7iKhZkbv54g1TY/tSLTfqG2BdtNtxNs
	 dOtoupXZTM8Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F2D3808200;
	Thu, 12 Mar 2026 12:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ti: icssg: Fix wrong macro used in RX
 classifier configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177331920555.4084292.14837207705389854005.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 12:40:05 +0000
References: <20260310132035.1299787-1-danishanwar@ti.com>
In-Reply-To: <20260310132035.1299787-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-267049-lists,netdev=lfdr.de,netdevbpf];
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
X-Rspamd-Queue-Id: 7BE28271F1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 10 Mar 2026 18:50:35 +0530 you wrote:
> The RX_CLASS_OR_REG macro is being used with RX_CLASS_OR_EN parameter
> when writing to the AND enable register. This should use RX_CLASS_AND_EN
> instead to properly configure the classifier AND enable register.
> 
> Fix this by using the correct RX_CLASS_AND_EN macro parameter for
> RX_CLASS_OR_REG when configuring the PTP duplicate and HSR tag
> classifiers.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ti: icssg: Fix wrong macro used in RX classifier configuration
    https://git.kernel.org/netdev/net-next/c/8e7adcf81564

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



