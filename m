Return-Path: <netdev+bounces-278232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K6NKBl43WnbegkAu9opvQ
	(envelope-from <netdev+bounces-278232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:11:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0961C3F4334
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C72B3037176
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9735B658;
	Mon, 13 Apr 2026 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/r6Ziey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3D2D3EC7;
	Mon, 13 Apr 2026 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121836; cv=none; b=ZF42JX1IQHnbWKMGvMJ72yZ1oJ1zy5iTi2h/g0ZtF4yEDFLmjLpTO5oByNLxqCDj0Xb33DRR5vDIDY/5sjl9xWujMKkU/0R6KO39iQQM6jEyQT4pf60Lc8WEMIWq69GaUrVYB508B5epKelJKaFj7AZRjzLKzA2l5ipGW63u8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121836; c=relaxed/simple;
	bh=tFAybFpPcfRFzNjyNQPvmGPHLnwmK7WAc8Kxdf1/7tU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EMe7LgB1axMC8Z7q54lOcUITnuDwF42nvrMkD3cQC2b0dznnCLswf9JEuE3s7MGG/3mBdcjYo5rIeqn2CqKMJQgp8wiU1EWL3j0a0kkOuz1azzvIavFa7dEZf9mpbLl9AgNrzHjPmdZbYUpbV9mxepMwHja3+XO4opAOPNrSbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/r6Ziey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16994C2BCAF;
	Mon, 13 Apr 2026 23:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776121836;
	bh=tFAybFpPcfRFzNjyNQPvmGPHLnwmK7WAc8Kxdf1/7tU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a/r6ZieylRR8BnuvoHDMCC24YWSENR1Z4oL5K58EhvYRwknFo+Z9qSgemCgj5vSeX
	 o7K4r5g3sZ52bp5O2A3HFI4aMmrYMEtdCMKLJS5PwLB5gcrQai4Vl/NhJTiQG5BXZe
	 mxjq363qc/w0yjCtbPSbfbgQq4nbCwgF9cey6LgXO7ugV43vXZSCL9NyaDfuVAMsru
	 5+RWbebP9g3qj8PwUUD/Nh9PYAfGKC3k9y+WHgX2I7nj4BtJWO/w7zcT6SmbnqSyqK
	 cifMl553VEPTcb+ecmL6dlUa4YczcDlYDuKYnafUYBayMvHBEJw9WtiTkqMbbZ9oGJ
	 MD2Vj33GWAaRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD463809A0B;
	Mon, 13 Apr 2026 23:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnge: return after auxiliary_device_uninit() in error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612180730.593344.1154925383981627112.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 23:10:07 +0000
References: <2026041124-banshee-molecular-0f70@gregkh>
In-Reply-To: <2026041124-banshee-molecular-0f70@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 vikas.gupta@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, stable@kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278232-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0961C3F4334
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 Apr 2026 12:45:25 +0200 you wrote:
> When auxiliary_device_add() fails, the error block calls
> auxiliary_device_uninit() but does not return.  The uninit drops the
> last reference and synchronously runs bnge_aux_dev_release(), which sets
> bd->auxr_dev = NULL and frees the underlying object.  The subsequent
> bd->auxr_dev->net = bd->netdev then dereferences NULL, which is not a
> good thing to have happen when trying to clean up from an error.
> 
> [...]

Here is the summary with links:
  - [net] bnge: return after auxiliary_device_uninit() in error path
    https://git.kernel.org/netdev/net/c/8b0c25528cb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



