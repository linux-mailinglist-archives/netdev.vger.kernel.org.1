Return-Path: <netdev+bounces-274506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFOPHBxczmmgnAYAu9opvQ
	(envelope-from <netdev+bounces-274506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:07:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 209DD388D1D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 14:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3915730300E6
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6243B52EF;
	Thu,  2 Apr 2026 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1gseKUt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DE3C6A47;
	Thu,  2 Apr 2026 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130627; cv=none; b=EdKgJOy0ibouP7RVU2eSbTbVJUvcXGNZpDr9vDe/rw3HDU0PF7RUsILJnukyeoEHAhkF9BKAZ3WR/uygx2QFA7ISrQWGffcD9CKiGPNsVUHR/3rY/scFE8TPBLQQUj/xJm5pLDYLodHwhE4MtTR0lfWIC9d3+cqB0IYOkY1m7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130627; c=relaxed/simple;
	bh=vEoba+fMvFDveHycMeExA5QONJY3k3BViAl1ncI9DhY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U8OFwzTF3VWCdct4qJg46sAuOH8CSd8IdklX8KUrud4neAjjQ7CbZfKtO0EUQZtKVaRN7P9bx5TZ53cjeD2PMDobuW8mhdHlly86KlhbcyvKsQAdOhWrGR3gmS4YUMb2mHGExouP5qq3TiolpnfKw5VICiOM+4Ls/U5aCkL5D0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1gseKUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A61C19423;
	Thu,  2 Apr 2026 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775130626;
	bh=vEoba+fMvFDveHycMeExA5QONJY3k3BViAl1ncI9DhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F1gseKUtBpwrjvnxksoIBG1UFzJ0P4IhMA/UDXS9QXY8EJLsXdUk3+syxCRsS9Y6v
	 0q0aTIFRj+xB3z2ZcP2qSGUnwnte4JjBTqBhdmzDtApdfiCs8k9nZg1Gp8cfDtRokN
	 eCkWeWAdbfGa9CB0vBAxkx2Ae6KY2DqP68XJjP22s/5O60Gx4nag7rHtJWsyZvW9Q/
	 E1TyDZlQgTuDLu6unRpdvgskq/3hx+WjDq8kpmf5EQLJSRRzH2su6/H/BXZVjBxQc1
	 x4doTLfNRU2PioYPz2QkROFC/XWqe/9fX4Nuqvj5XhdxCg6o090Xm2NOlel1Q9nzp6
	 uG2gh2STb9o0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EA7380820D;
	Thu,  2 Apr 2026 11:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] net/x25: Fix overflow and double free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177513060854.4158057.16194132816256127315.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 11:50:08 +0000
References: <20260331-x25_fraglen-v4-0-3e69f18464b4@dev.tdt.de>
In-Reply-To: <20260331-x25_fraglen-v4-0-3e69f18464b4@dev.tdt.de>
To: Martin Schiller <ms@dev.tdt.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, yimingqian591@gmail.com,
 linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274506-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 209DD388D1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 31 Mar 2026 09:43:16 +0200 you wrote:
> This patch set includes 2 fixes:
> 
> The first removes a potential double free of received skb
> The second fixes an overflow when accumulating packets with the more-bit
> set.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net/x25: Fix potential double free of skb
    https://git.kernel.org/netdev/net/c/d10a26aa4d07
  - [net,v4,2/2] net/x25: Fix overflow when accumulating packets
    https://git.kernel.org/netdev/net/c/a1822cb524e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



