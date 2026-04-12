Return-Path: <netdev+bounces-277858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB6EHgHe22lMHgkAu9opvQ
	(envelope-from <netdev+bounces-277858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:01:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE943E54F3
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13A7F30214CE
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7371363C57;
	Sun, 12 Apr 2026 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXneZx9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AD362149;
	Sun, 12 Apr 2026 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016854; cv=none; b=hhUFSTXKc0NyCu4aS1ulL5XcG4nFiDNVJQQjxhQ8U/ob7kD1FnCR742sCg51LRzeSMqSCWDaqTi5nXU/i5qaZVDjbPm4dDI2FYyybPFPLrPTX1vid+DQsLIPIgAVkHAI9uNXnCDmNFDzCpuy7Ygq/KmFpObL5z9DSHttFURByTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016854; c=relaxed/simple;
	bh=cpVpThsVDIuWHWEI8MIcs/A+E73RNhy4so7CkwixIXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R6u4pm14O7nlP1JccVvT1Kq8l4oHYHFngSb6GEeczSnhwGTdW7rcYX2mu0ZDAqO2O19OCr8KycyZ4xEKQkvXv9AmmA7ZO4FDd7OHI1uPhMH3sjavBrV+M6zvOjjb9o3YSCkwZZqzU5zfeiuh4PrI7Tt/tmsafIDCgQaP+5YEiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXneZx9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44765C19425;
	Sun, 12 Apr 2026 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016854;
	bh=cpVpThsVDIuWHWEI8MIcs/A+E73RNhy4so7CkwixIXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OXneZx9lQtmmmlNJ+/OQ5skGfS9LQPf2utTpMRWxvKjlkaiqkQPegNiwT5Z6Dt2R/
	 zLHBh8G/BbiEKz1lDKcTOWq4HFWcjZQM3sQMhQ0fqwdPDkXkSvyCIy/vPnsS6NYBof
	 fzfZTsCWNUWsQirSomg10TJJ0canEOFL44zehxMYdmuTqmjWAONPEZR3zEyiUsMPKD
	 fgEKEuDMpogCOJnnoqm3QFhqHLeB+B+J/AuMKnIkjQ2piYt4/+e4PQiCQ9t0uhbxgc
	 O7eMh7DJCf2OdUKIcYOSMmhBNQGKuGoGbG92f1E+RYyuptPFFzN9zsMbLNUxqDreUP
	 miNtYrd2uAugg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BF53809A8C;
	Sun, 12 Apr 2026 18:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601682654.3359939.6934554682952885882.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:00:26 +0000
References: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
In-Reply-To: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, avkrasnov@salutedevices.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
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
	TAGGED_FROM(0.00)[bounces-277858-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CFE943E54F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 Apr 2026 17:21:02 +0200 you wrote:
> `virtio_transport_send_pkt_info` gets all the transport information
> from the parameter `t_ops`. There is no need to call
> `virtio_transport_get_ops()`.
> 
> Remove it.
> 
> Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] vsock/virtio: remove unnecessary call to `virtio_transport_get_ops`
    https://git.kernel.org/netdev/net-next/c/006679268a29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



