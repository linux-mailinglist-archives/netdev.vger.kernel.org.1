Return-Path: <netdev+bounces-287096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG2hCM0KA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:11:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68051F1BC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3076B3001CF5
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DC8383998;
	Tue, 12 May 2026 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8gdXzFi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D234B194;
	Tue, 12 May 2026 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584263; cv=none; b=grZlS8D2rU/vbJmj91SpCEO4bvf1YcMrdxV72FDyEY3OBgqjPEti+VYOgAHPdDB0C97IhEXvTHGIya45mjcUf8b33Y2Xmg4DI/H4I8y1vXNs3fKJWiYFT0+3fuhg6WDQX9DDANtKoppxcW6rbCDvx7eopdoyCog0kFSsHctL43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584263; c=relaxed/simple;
	bh=T5qBBfTlLOCFqM3EzVqvA9J5ENejvnr88f1w2HugSv8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D9LyQEIRLhLel5aOr3rR6enbCd40jIQwaHA45wJzBI8OahrmHDmLnhEu8Zo+K8YsicjAWV7n6zN59XQUsw0cjiI5Ta3yV+wGKBmWv/eXtoQLK+F2I5ZhcCm7RHdNODPxe5z31UcDHUPQSMbw2CnE1hJ+pxCfUjrr+4FlNh7ua1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8gdXzFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE752C2BCB0;
	Tue, 12 May 2026 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778584262;
	bh=T5qBBfTlLOCFqM3EzVqvA9J5ENejvnr88f1w2HugSv8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r8gdXzFiRgOUfeCa/F7I5vAhU3EG32bEIjQ4+i9Le5kzIz89Q8ooJDbs2chBpO77b
	 G5tDnct67+P/tZWJ+uoUQjWucH8kdj5XZyDX7Li7N8yp21u6Vu3piWHQmO4r1/r9qN
	 AuaXqSmlRtSGHqJam/LBLIY8JpblAwnYn6WX505SfK8b5zFolGqJMjETtOxNtLd9H8
	 QfocJ1GqOKBXaJ0kvV3+horSa1koiXDVlUj7hP7TudAoRREGpMySuCCt2RN8hANG4h
	 51+0cteElfxUJDgsjqPZhompfIDmR5BxYoNds9BofMpxtJrwAAvt4qzXxPBosvnjpD
	 M4KZx/iyv/VBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDDB380A979;
	Tue, 12 May 2026 11:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] vsock/virtio: fix vsockmon tap skb construction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177858420905.2807191.16905874591205920315.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 11:10:09 +0000
References: <20260508164411.261440-1-sgarzare@redhat.com>
In-Reply-To: <20260508164411.261440-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, sunyiqixm@gmail.com, linux-kernel@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, mst@redhat.com, stefanha@redhat.com,
 kvm@vger.kernel.org, horms@kernel.org, bobbyeshleman@meta.com,
 jasowang@redhat.com, kuba@kernel.org, davem@davemloft.net,
 virtualization@lists.linux.dev, edumazet@google.com, pabeni@redhat.com,
 avkrasnov@salutedevices.com, eperezma@redhat.com,
 bobby.eshleman@bytedance.com
X-Rspamd-Queue-Id: 0F68051F1BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.alibaba.com,redhat.com,kernel.org,meta.com,davemloft.net,lists.linux.dev,google.com,salutedevices.com,bytedance.com];
	TAGGED_FROM(0.00)[bounces-287096-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  8 May 2026 18:44:09 +0200 you wrote:
> While reviewing the patch posted by Yiqi Sun [1] to fix an issue in
> virtio_transport_build_skb(), I discovered another issue related to
> the offset and length of the payload to be copied in the new skb.
> This was introduced when we did the skb conversion, and fixed by
> patch 1.
> 
> Patch 2 fixes the issue found by Yiqi Sun in a different way: using
> iov_iter_kvec() to properly initialize all the iov_iter fields and
> removing the linear vs non-linear split like we alredy do in
> vhost-vsock.
> 
> [...]

Here is the summary with links:
  - [net,1/2] vsock/virtio: fix length and offset in tap skb for split packets
    https://git.kernel.org/netdev/net/c/5f344d809e01
  - [net,2/2] vsock/virtio: fix empty payload in tap skb for non-linear buffers
    https://git.kernel.org/netdev/net/c/3a3e3d90cbc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



