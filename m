Return-Path: <netdev+bounces-251720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHcBKW89cGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:43:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60A4FFB7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FE4BA2FA8A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42BB34D3A8;
	Wed, 21 Jan 2026 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+TFNmjy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619534CFDD;
	Wed, 21 Jan 2026 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963226; cv=none; b=eVwfUa/WdvqW7eR+W96Bl1Bph3YTgN+7n6tI66FUMrP5HYhvr1Pb4FqmQssYqdZEf/zl2YSei9X3yaoFoAlEEp1yAp4BFuLBcT0V7Es8H4HQxlITu3XzKqFSUEQYjEAJVY/R9g0tp1BLdWZVMyjW8DrBJkNUXCQeD3BLkdh14nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963226; c=relaxed/simple;
	bh=kU4ivi3it5EOayRcuk2PGsOSIABVoKbr13xV7JDnuyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BzJ0LjaMv7GQbRtwy2cwY4UKbjPa3VHWlQDcVck7z73MdjIywovGtfzqsUoc0GX8xuxnUCvXfGj6rMck9TewnNUecUul9OmQA4MfWfQZxScna4pf5i5fZ86ic/uUPKh9rWpcVvZTqNSs0ZRljBwWFx07StTCBUiG2wQg14Sfzww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+TFNmjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04014C19424;
	Wed, 21 Jan 2026 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963226;
	bh=kU4ivi3it5EOayRcuk2PGsOSIABVoKbr13xV7JDnuyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H+TFNmjy86zH6Vd9cQTCklv1uMDdw1OCATQTpq/hflNnK6PWiikynVkZMlDVYRiHl
	 YuRnJ1EXCUBW8hFGcpcrFxU6nOBrJq1lQI2+NyZCrYNfn1D0nUyjdyBbkOhNUslL6/
	 LtUujWiihzDPcAUjVu3WvfZXoTMLzkB24WMK9SOXxMu2gVK61gr3G/n9UmemyIy1Eh
	 g3I29XgFevbXzv9/xMD0GbI7q1l7tJZgcQAYn/wo1UKqtKSnEsK06ngQjA06KjYXBS
	 GYbpkN1nGm37oGkgUQKcCOWtkGo7LeIue3dNUb5HNSSdevYKwOxqa2gVQ21ZIxpiED
	 Ud1v4QtY7LRTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBB9380820D;
	Wed, 21 Jan 2026 02:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] idpf: Fix data race in idpf_net_dim
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896322309.699622.15744094488253371273.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:23 +0000
References: <20260119162720.1463859-1-mmyangfl@gmail.com>
In-Reply-To: <20260119162720.1463859-1-mmyangfl@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pavan.kumar.linga@intel.com, phani.r.burra@intel.com, willemb@google.com,
 alan.brady@intel.com, sridhar.samudrala@intel.com, joshua.a.hay@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-251720-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8C60A4FFB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 00:27:16 +0800 you wrote:
> In idpf_net_dim(), some statistics protected by u64_stats_sync, are read
> and accumulated in ignorance of possible u64_stats_fetch_retry() events.
> The correct way to copy statistics is already illustrated by
> idpf_add_queue_stats(). Fix this by reading them into temporary variables
> first.
> 
> Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] idpf: Fix data race in idpf_net_dim
    https://git.kernel.org/netdev/net/c/5fbe395cd1fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



