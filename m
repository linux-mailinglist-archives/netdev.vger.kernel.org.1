Return-Path: <netdev+bounces-260757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJJsLRt2nmnCVQQAu9opvQ
	(envelope-from <netdev+bounces-260757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:10:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C62191817
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93F273061BD6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1C12BEC3F;
	Wed, 25 Feb 2026 04:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1BB2cwD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0622BE7D1
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992589; cv=none; b=WUq7TeVJwdAcnNodIJBWqxZhSMM2dhHBNjP5I4Pr+klmjsbL62VeyiiL8n4kM82V2AgsSsAhJc+F85ejGFaKIjYmCqUmX+HnaTl4mM+kQfRrbxl4yS6uRdmRKBNd4vcsgtUjeSKXrFXtjREjfgDbEDxy8BLShTXEQFegceIzm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992589; c=relaxed/simple;
	bh=Zpb/L4Lm4Bkp8eyXeYr1VMcZfVHW2gIKBkcj5ms+alQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yikj7txT+myuAZmKuEt/aYKoB/yaocFQ2qNqUYkl49Pg+7JWCXeUZQoGpJ4GIR1u1gM0M90lTjdkaBwjBGyW+SUYNToyNaSH7m+CUH+ZkifVrKYBEfA6waEfAzmCxEG2QyCJF56WzT+P9/UmP5zr58LRWXxyokfJFbuM/LsY60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1BB2cwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA73BC116D0;
	Wed, 25 Feb 2026 04:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771992588;
	bh=Zpb/L4Lm4Bkp8eyXeYr1VMcZfVHW2gIKBkcj5ms+alQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A1BB2cwD1//qeApUz0PfqwhB0zxPs9HfwlawbFzBoMTU6sewGCRfqh5T/JCsZMjoa
	 npHrfNGDs4sFOQRGm0b3I8Wf706pDxb+pz95U50Z4+a9agYUjc4TIck9Qx+j9/BnKF
	 4ULBxa2w2IzyfA6oS6a2lSjoVK6x9J4OYm42yaVXwLvPxYRtMllyXFTDQ4gsgkdrF3
	 fZKrNbRLHiZw0yaPv3Tid42vJXeupDP5QZPAPwJJzsbKvLzLkCRo7ABgEL3vH0Nory
	 KutFoQrD2w5HRrhu4DOxyjXhLVn+eij3qHHPiA7h3MFJykJwD9eIJ2VhDhQcSd5+jy
	 HGbpr8LJmgbYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCF6380820E;
	Wed, 25 Feb 2026 04:09:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: bnxt: rename ring_err_stats ->
 ring_drv_stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177199259379.36698.16362733482941267976.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 04:09:53 +0000
References: <20260223203702.4137801-1-kuba@kernel.org>
In-Reply-To: <20260223203702.4137801-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260757-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3C62191817
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 12:37:01 -0800 you wrote:
> We recently added GRO stats to bnxt, which are maintained
> by the driver. Having "err" in the name of the struct for
> ring stats no longer makes sense (as pointed out by Michael,
> see Link).
> 
> Rename them to "drv" stats, as these are all maintained
> by the driver (even if partially based on info from descriptors).
> Michael suggested calling these misc, happy to go back to
> that. IMHO "drv" is a bit more meaningful that "misc".
> 
> [...]

Here is the summary with links:
  - [net-next] eth: bnxt: rename ring_err_stats -> ring_drv_stats
    https://git.kernel.org/netdev/net-next/c/6c32b0765067

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



