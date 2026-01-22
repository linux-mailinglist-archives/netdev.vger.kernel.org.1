Return-Path: <netdev+bounces-252172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAObAMqdcWl6KQAAu9opvQ
	(envelope-from <netdev+bounces-252172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:47:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA8061721
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5819F50248B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FB041C301;
	Thu, 22 Jan 2026 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu9IVHrH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A13570CA
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053209; cv=none; b=m/Gb1c01rGBOynPPLtdifgN0fYwzaMclFgbb0Q81cFNG3yb2rTeZ+uxiNnxeSBmH1HtAUnMlRpAO+XhpahWyVzyUIDbNmorCtu92qkMol9sf2lGwireTxegHIoy4AKUk8vMwzUHfetJEWv79H7QqX7D82gEK29iiNBiaEF0MDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053209; c=relaxed/simple;
	bh=QXLFUl39aNkJFHtiahDMOhts5MFjv08pdgkJXTLRrrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m7OTHekodJTa32BO61SyEH/LZmYvG41c3DNSNJyooIamDWcMf9fkEg6Ef+HGqfStPYzX438iZJn7/HGRolmETLAvF6uy7rIbxtBBSON9GAQ70LkqrW3Ohd8zTZoraRYDfhyaQI9Eh/K03v6NlsZN2u6kPqQFyU53W7d3Ww5Tvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu9IVHrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D424C116C6;
	Thu, 22 Jan 2026 03:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769053208;
	bh=QXLFUl39aNkJFHtiahDMOhts5MFjv08pdgkJXTLRrrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cu9IVHrHhUiQzbhpGTRlFEXQsD6eBcAFGdO3E0Q1c7SP9nHawgOGqEqDoGHW4bhiF
	 dQQBjoTkN8z9SQMfsxzoO87krDA08hm+rwyZjIdf/qC5fEXziizNf3ORnKi3L6b2hz
	 K8SN/dveqbDI0rc0QpT92x8Ou76l4x74bXVpWP4+gpsKmft3zS08Mbul4r2Gi7x+oZ
	 8b1zh3Szj+uZY1ecmz3cPkVo4//Bqx9Vz5oA6H4QUQ6UrpHCeP/d+rAsUAAx/xbhs+
	 1GePRRdu4cy0tkZHuHRensD2+SHJRASNMSiyDO5CttTr2ztRQEWt2j7vx+eJQ6TZza
	 lqLYBPIvGwEWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BADF3808200;
	Thu, 22 Jan 2026 03:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bcmasp: Fix network filter wake for asp-3.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905320535.1545617.2963132988351714620.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 03:40:05 +0000
References: <20260120192339.2031648-1-justin.chen@broadcom.com>
In-Reply-To: <20260120192339.2031648-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, florian.fainelli@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-252172-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BDA8061721
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 11:23:39 -0800 you wrote:
> We need to apply the tx_chan_offset to the netfilter cfg channel or the
> output channel will be incorrect for asp-3.0 and newer.
> 
> Fixes: e9f31435ee7d ("net: bcmasp: Add support for asp-v3.0")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 5 +++--
>  drivers/net/ethernet/broadcom/asp2/bcmasp.h | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - net: bcmasp: Fix network filter wake for asp-3.0
    https://git.kernel.org/netdev/net/c/bbb11b8d758d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



