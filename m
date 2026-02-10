Return-Path: <netdev+bounces-258107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCaBF2lKi2mWTwAAu9opvQ
	(envelope-from <netdev+bounces-258107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:10:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7799711C4BB
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB143300E610
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B513806D3;
	Tue, 10 Feb 2026 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xgj0kmIO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146D36C0C6;
	Tue, 10 Feb 2026 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736214; cv=none; b=KcLoeqjtm/0lEf3zKBI1mJeNdzYa1gG4nKrnYjyShspMuaAuJH44OmjqIDGKfHJEXWouAzngd1iGtk+kUU7lbTMRmwXlltzC/XrwrxFgaIhuGRzTZTce25EQlIF6BJbo3xr/6ffat0bUcS49bTcxnGBfX7Txr2+m0I/Guk51z6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736214; c=relaxed/simple;
	bh=PTzywkzmydhHS4m65zxnJMTdAW4LV8KSXo7gsfkFZCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rm0abGODQf67xqni6/KHkJLOHijeYs14s3T+353YH/4vCVgeVknyK1nZHEtZ+vhSMToCDgjZxbdKYghnHVpoNxRsfgdpwY/ShuuFz4/+rmhEPAzLshC7NwjKufboxH0eaBxMLema4DRZAIrJOrfeyBiJv74stAKiOMsiT3cWDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xgj0kmIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794C0C116C6;
	Tue, 10 Feb 2026 15:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770736214;
	bh=PTzywkzmydhHS4m65zxnJMTdAW4LV8KSXo7gsfkFZCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xgj0kmIO2NIAC+1hAmcOAOsAqF72LCB9Bk3UQuRrcRns5eGwQ7e38PK2g3SG/DpUP
	 lNCupGhRwldJ1rmwcRhRGuf9uZzGWovr3JMTqHhcRbbo+spekR77Qw71j3viXFK4UU
	 S45KZ/rVvcBjRP1JTYEdaE6HG1UhwHdA4H7g4zRvHpVAEf/ze451uC6sFpxvMrPOkr
	 dFz4ZqGOi1dMih3nZ+FKf5038maVVe/uV1WCqB34vLFekxklno4Z1c0OiqJslhu3oy
	 I+vi8CfJrDZPuFbiYWN1gLAVYSjvQ9wBH+I5GRpcYoZi18baTNMuSD51sE7MWXPpLf
	 yFGX65+9m2uPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B02239D267E;
	Tue, 10 Feb 2026 15:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] disable interrupts and ensure dbell updation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177073620983.3548292.5914076023087755197.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 15:10:09 +0000
References: <20260206111510.1045092-1-vimleshk@marvell.com>
In-Reply-To: <20260206111510.1045092-1-vimleshk@marvell.com>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sedara@marvell.com,
 srasheed@marvell.com, hgani@marvell.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258107-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7799711C4BB
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 6 Feb 2026 11:15:05 +0000 you wrote:
> Disable per ring interrupts when netdev goes down and ensure dbell BADDR
> updation for both PFs and VFs by adding wait and check for updated value.
> 
> Resending based on discussion with reviewer.
> 
> Vimlesh Kumar (3):
>   octeon_ep: disable per ring interrupts
>   octeon_ep: ensure dbell BADDR updation
>   octeon_ep_vf: ensure dbell BADDR updation
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] octeon_ep: disable per ring interrupts
    https://git.kernel.org/netdev/net/c/73e6ffa37ceb
  - [net,v4,2/3] octeon_ep: ensure dbell BADDR updation
    https://git.kernel.org/netdev/net/c/ce8fe3fc4f99
  - [net,v4,3/3] octeon_ep_vf: ensure dbell BADDR updation
    https://git.kernel.org/netdev/net/c/484e834d53cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



