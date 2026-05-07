Return-Path: <netdev+bounces-285406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH+LIGS2/Gn9SwAAu9opvQ
	(envelope-from <netdev+bounces-285406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:57:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 021DC4EB9C6
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8BFB307BFCA
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6655144CF44;
	Thu,  7 May 2026 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNHCrDe1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C944D688
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169068; cv=none; b=uEfWqkaS0I9w27jBTxVLxZ8WFna59penXW+HDCZ1Ks/IoQ0M/k76Ybh0vS6RKqmw37/9emP3kP2xu5Z2g7s3OmvkTxvm7UNGixGJ+xf/wgCHSTk61YOeD4CQ9eV2Qb10d2f7DfQ5tU7635S+BMLlbU/AzVArDh2wo/UIOyoypOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169068; c=relaxed/simple;
	bh=x36rzMFJP7xkeIcPO04uT1XuRBSnmdhWnlz7Ha+bWe8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qemZ8LslTRamSPXnNzan3qsK51TQDv0DOQFQkDTU4iV/F4H6KAv1pMooiOYwtszTzW0P4LqppGvkI3ogf5fRZWmL9yb86EOHPlF8Xc0Gop3F0QVY8CW8PHBZn7hyPei8hkVmjQxjT6XCf/1rxQAojcLOvfvKXHCRCfNHR0Tclc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNHCrDe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13121C2BCB2;
	Thu,  7 May 2026 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169068;
	bh=x36rzMFJP7xkeIcPO04uT1XuRBSnmdhWnlz7Ha+bWe8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CNHCrDe1rIrX3HgCPA3+CMWJvDsOSDyYjPxQKp2lGbPMfNrv+/k+ZtHzI/gUfilxp
	 APZctYxSym9sSpEy9NcJOIYZxW4i56DQIpCCqgkBdpH9cLd5bB9Ve4vbs8yvTpQmEY
	 dyP1GAaLREvA+jGrmonDxd5wfO2TMomMwxKni1EouX6YUHcINJs0rr+lUwkf68PG+a
	 C/kvdHlyVGx4sqyZgh88mZWK0GVCastrVAAwT2lmGa2JuyEALAjWRF8efi6wjCXXtm
	 +4aggO6Ug30L5Cu94a45992wNQpLxNAzD+7MGHIbyxxkW0O1ASTxLQ3eA/UGz73PDY
	 5Txc7UFH3ihVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2323930909;
	Thu,  7 May 2026 15:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: phy: broadcom: Save PHY counters during
 suspend
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177816901704.4048611.12441196131254721138.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 15:50:17 +0000
References: <20260505173926.2870069-1-justin.chen@broadcom.com>
In-Reply-To: <20260505173926.2870069-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, linux@armlinux.org.uk,
 hkallweit1@gmail.com, andrew@lunn.ch, bcm-kernel-feedback-list@broadcom.com,
 florian.fainelli@broadcom.com
X-Rspamd-Queue-Id: 021DC4EB9C6
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,lunn.ch,broadcom.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285406-lists,netdev=lfdr.de,netdevbpf];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 10:39:26 -0700 you wrote:
> The PHY counters can be lost if the PHY is reset during suspend. We
> need to save the values into the shadow counters or the accounting
> will be incorrect over multiple suspend and resume cycles.
> 
> Fixes: 820ee17b8d3b ("net: phy: broadcom: Add support code for reading PHY counters")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phy: broadcom: Save PHY counters during suspend
    https://git.kernel.org/netdev/net/c/32cd651d14fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



