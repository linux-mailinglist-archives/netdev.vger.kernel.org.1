Return-Path: <netdev+bounces-251739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDmSIZ1DcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:10:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDE50419
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81A19506CE7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91FD356A11;
	Wed, 21 Jan 2026 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqtvpj7L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F11356A05;
	Wed, 21 Jan 2026 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965010; cv=none; b=YFEmaFzD8isGf6pVOCW3lLFBPWQ7QiDaAmpMVdLBs6rqKHF32WXjYV5XSQJhf8gXPrZU/0Z9BqUkHaZ1ujXrURN6XVZSWabfv1gm+weC4d2GkTFlkxmQ2Gwj6kQklx5e9CKHZ/cHYZfyHxcBuTTIPvrIIuxrnDQNE6hnq6aIcUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965010; c=relaxed/simple;
	bh=aielJTOBw58FwdnxXswivgYB/zLkpUygEabseHAholY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qtOQypmfvII23fy+7FT6yhgtvfAYMSg7bFIVCdnOmLRxAMQl7i4XXHeRXKIRZzOipb6Zk6rayU9vAX+qMTkCjDhqS2tWqoRqo2U9FvVqbrDQqAaStb2b0dYe7rW1ToLZrFprz4hISKVjjHE5qtt4PQmijP/DPiXeoF2OXJRw9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqtvpj7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E43FC16AAE;
	Wed, 21 Jan 2026 03:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768965010;
	bh=aielJTOBw58FwdnxXswivgYB/zLkpUygEabseHAholY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tqtvpj7L6nZJhK3/b7H42VznxbN/P//tWku6NVPFD2YMDCIIy2IQyn8u2vAxULYeV
	 Tv9B9V+PmTr0wGU06cMTGDL0ZG7cw0tkEoeGU9cQHA+NtonRfqEjUIu0BeEhDFbnhO
	 YI65DN2V/zuMMhW3vUbCIF6GRuHJQIq3E0hFVBMR1D34kQP5x9tTVJQC2doOyLgeue
	 Mf8CtykHbIDNMFgmuK16LuQYTF7T9qpvxcv/BIAF83bW8Uny+kZXR6XSy/GilZoM7N
	 f9rrNN7R+7lpV1zc6P56SVlgLeuqKox3oykxPNIlDa5VNRbU6pATEK2W9ETwGoIWgs
	 p6eOJSPCsKOtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8BBE380820D;
	Wed, 21 Jan 2026 03:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] usbnet: limit max_mtu based on device's hard_mtu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896500760.707355.7611917521322998807.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 03:10:07 +0000
References: <20260119075518.2774373-1-lvivier@redhat.com>
In-Reply-To: <20260119075518.2774373-1-lvivier@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, oneukum@suse.com,
 kuba@kernel.org, netdev@vger.kernel.org, sbrivio@redhat.com
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251739-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 31FDE50419
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 08:55:18 +0100 you wrote:
> The usbnet driver initializes net->max_mtu to ETH_MAX_MTU before calling
> the device's bind() callback. When the bind() callback sets
> dev->hard_mtu based the device's actual capability (from CDC Ethernet's
> wMaxSegmentSize descriptor), max_mtu is never updated to reflect this
> hardware limitation).
> 
> This allows userspace (DHCP or IPv6 RA) to configure MTU larger than the
> device can handle, leading to silent packet drops when the backend sends
> packet exceeding the device's buffer size.
> 
> [...]

Here is the summary with links:
  - [net,v2] usbnet: limit max_mtu based on device's hard_mtu
    https://git.kernel.org/netdev/net/c/c7159e960f14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



