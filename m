Return-Path: <netdev+bounces-261663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K5CBG74oGnHoQQAu9opvQ
	(envelope-from <netdev+bounces-261663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:50:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBBC1B1A2E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC6F1305BB90
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167652BDC2A;
	Fri, 27 Feb 2026 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmbRBvhE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD029E10B
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157004; cv=none; b=jZZmjCltWMIYbl+YFR0KUpUqDGjiF9+v6obmu7wIKclB5Q7oTFkW/ZQSgIzB/TDhh5Ruj2XFpof/Jwo3yZcOTQxEqmbQaO9GAjCEO8/F84VeHvDzkgdAgOqLWqfIyXvJ2/kIOB0u713bQBKsYSrfHmDpi8xPicO5jqKRDpY3BcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157004; c=relaxed/simple;
	bh=zEIkP0v+Gt6GKxEd6rrduCgxlWdMNrWP0C7sJGM9NSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZGHQXDk1o5uOx1+fmvYrP1mCraWwxrztbfGVoQ5fiG8zPSVWWeE8NsHRq+7oiGA0FNNwLEvqNX+/0ELJqgKCTknrrAQm/4Rud6u+E1wrdJRkMfIVcQ4I09XikPELB6QrmE/pa8TMYinS43DMJeJxHLYaFVkGWaPtB3r1OgJJm5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmbRBvhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB567C116C6;
	Fri, 27 Feb 2026 01:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157003;
	bh=zEIkP0v+Gt6GKxEd6rrduCgxlWdMNrWP0C7sJGM9NSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CmbRBvhE8XpF06ktiuTWDldt8B3JOhztqsyrsGnCtopGkKWJbUKXD6rOrA4HWEZZu
	 o2J7w+J8JyjfPG7HU/WZOPjF4vVlAINDAwTdtvBpw8a9fZWHOZ/cAi24HVfvJCscYL
	 i9rUOTanNM6xLJzmbWWQqpMaaIYRQy8GRMxj0G9Qat4QoEI7Fmaoiu1VgphqdTvAsx
	 nZA13RyQ/gGLtC1GanNG9puhtv2e4d4Ws5QjW4l0I46KQn/z18ISjzzaZJuTSnXK4D
	 zcsgF6y+8lwL1cOXHiB9yhL5TZQKo6LmZDfAJtTATIHt7dBAS5DO0ZmPkYRlPIs8yP
	 N96jAjMs4B2ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CA5393109B;
	Fri, 27 Feb 2026 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: ptp: limit n_per_out
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177215700779.1935486.3167937625716884926.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 01:50:07 +0000
References: <E1vvBhn-0000000ArCg-4C4u@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vvBhn-0000000ArCg-4C4u@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 Jose.Abreu@synopsys.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261663-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CBBC1B1A2E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 10:01:19 +0000 you wrote:
> ptp_clock_ops.n_per_out sets the number of PPS outputs, which the PTP
> subsystem uses to validate userspace input, such as the index number
> used in a PTP_CLK_REQ_PEROUT request.
> 
> stmmac_enable() uses this to index the priv->pps array, which is an
> array of size STMMAC_PPS_MAX. ptp_clock_ops.n_per_out is initialised
> using priv->dma_cap.pps_out_num, which is a three bit field read from
> hardware.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: ptp: limit n_per_out
    https://git.kernel.org/netdev/net-next/c/5c894879f17c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



