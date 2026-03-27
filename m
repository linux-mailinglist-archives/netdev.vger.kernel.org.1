Return-Path: <netdev+bounces-272350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMySGdT3xWkjEwUAu9opvQ
	(envelope-from <netdev+bounces-272350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:21:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F233EC04
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CD44302F12D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5736C5B6;
	Fri, 27 Mar 2026 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2+LoeQW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF435C1AE;
	Fri, 27 Mar 2026 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581628; cv=none; b=MfFh3smtz0sAl/lbVuWSAE6czwKzpXT82n1Lgb3FKy0BJbV9iuOeBxJ4PQuK5+qcS5z0PrQJDujsNXoCYsp/9vPrEHzhXosWcaA1DVr+kp4w+RDzLncnby52LQpeLz9BuYE+h3W1NCCDXqO48qr1QBZqPkaHVIQTV9x2wWntP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581628; c=relaxed/simple;
	bh=NMNqDhrPaal3Yltv8RJLavSk/i9ysKkz0fwPnx3hNL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oPH9k4chNlHxH0cOIM1/Sxjlwnpmo+EbXdiJBeTCtigAIcq9D7QqSIZCty51v66t9gy8FDJ8wD+FBa/2DEgre5oogb9wXKU7FsPW/fAgC0ZQnyceM8pb8TSei/qatS5eWC/ANWvkFj0ysdNHeoJr9VzwYwPVH3vQJdFgsPuG9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2+LoeQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09145C116C6;
	Fri, 27 Mar 2026 03:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774581628;
	bh=NMNqDhrPaal3Yltv8RJLavSk/i9ysKkz0fwPnx3hNL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y2+LoeQWsCDZA0zXQ7ruhPWgwkMRKNPKXe9mreuJvEQbHpG29Mq9RM43y4GEMC+pq
	 JpdvMSxLpvF5VCr4HRpd8ms+3F4ZgadhTgXUceyi7DHtb8jRwPUExBRXVPT65BDJDR
	 BTdjJTjVxc2mfqnbyvsVYZyc3BRi1tPSuMrPUdS74yhVppFjaP4LOiTqJ0X6qxMxPQ
	 dKffPS/6g4vuAZN9aSoYf7wtKzK0jKq9TL02mHKdvAptSMm6c3Puhc73r0E6SCWTZN
	 3ijD/lmKlo0kUshCo1Rao/T/c/kpyRH6XXszPfEwXZZ0TRiWsGYZGGfx1DNz0sN+bN
	 da8UEhhWHDF/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFEC3809A0B;
	Fri, 27 Mar 2026 03:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] virtio_net: sync RX buffer before reading the
 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177458161428.3283168.99448398733931105.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 03:20:14 +0000
References: 
 <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
In-Reply-To: 
 <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
To: Michael S. Tsirkin <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, oelghoul@linux.ibm.com, sraithal@amd.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, vishs@meta.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,amd.com,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,meta.com,lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-272350-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5C2F233EC04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 11:15:54 -0400 you wrote:
> receive_buf() reads the virtio header through buf before
> page_pool_dma_sync_for_cpu() runs in receive_small() or
> receive_mergeable(). The header buffer is thus unsynchronized at the
> point where flags and, for mergeable buffers, num_buffers are consumed.
> 
> Omar Elghoul reported that on s390x Secure Execution this showed up as
> greatly reduced virtio-net performance together with "bad gso" and
> "bad csum" messages in dmesg. This is because with SE sync actually
> copies data, so the header is uninitialized.
> 
> [...]

Here is the summary with links:
  - [net-next] virtio_net: sync RX buffer before reading the header
    https://git.kernel.org/netdev/net-next/c/fe3e54253f0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



