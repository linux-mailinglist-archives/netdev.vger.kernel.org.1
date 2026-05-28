Return-Path: <netdev+bounces-292487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIjRBfeNF2pyJAgAu9opvQ
	(envelope-from <netdev+bounces-292487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:36:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 625485EB486
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4596303FFF4
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84BF19CD0A;
	Thu, 28 May 2026 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFCsc7Fq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC11343895;
	Thu, 28 May 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928192; cv=none; b=JclyJUSjpuKmkmRTI4UYHLA8NZX7rWDWRnAZlzaHviOAgvj3Ii5m9RhMScF8bbH9jG5g67CaYtp7F66dgcw4l+dN5aQbkEv3eS71GSt/o1KVZ2uuNASwssmanyRYO2EobpST/y2d2sopm5F8mH0TS+TJa26j81WOapmqMyNna/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928192; c=relaxed/simple;
	bh=6/YtKLwPoFekQFz4/cSbLo0aS85IkF4jyxwtlMvzCR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKEu3hUWYaOMCjOE9gcnL91FagYuB+HYC2KxtpOzVfUZzupQKyhdVgG0ftR4B7C0/CcK4rnh+gHLxaa96eNFWgdkglHuODyO/VkEYsQSYMwxk8NFzE8uuL0Cb2j2dgv/WDd+rG1kD2YEHDR7R/nBpXQN0rdYz6fGNbZWfzlkuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFCsc7Fq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F5B1F000E9;
	Thu, 28 May 2026 00:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779928191;
	bh=y13f+t+m1+FcOureFd1SO4w2R0ma9SJhAiidx4cfjiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WFCsc7FqbREOHn0I+wYLNvOTUXUiDkuf9QFiM1ZMR7lin/qDz7o1Pp3X4egM7crgx
	 c39HXiiGmd1X0UTimNIBuyxEukDPr3KZ4u3akaSK7ZCDIyOO7zFRclSMd2uWb+NU3n
	 YLe9Pp1phiRy50+vs93HAmAAzdpD+xpRWYVXN/T6HnNjsJd0LxWnAnI//SYFFWyeTm
	 mEy8JwFgYkml6Sv7Pq2iVHdd6ILd+CAG8ztR7rrd5oNLOMtGlZ+/yKI7YkcGMmgILp
	 U7PRkU+zIo/dL0exTfohhyA8uA5+p04U3NvMXBUZo5z02gBRRDq2i9/jdlNJoFNoxC
	 iStHOHbF9pXRw==
Date: Wed, 27 May 2026 17:29:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, danishanwar@ti.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 yaojun@mucse.com
Subject: Re: [PATCH net-next v4 0/4] net: rnpgbe: Add TX/RX and link status
 support
Message-ID: <20260527172950.4295edb4@kernel.org>
In-Reply-To: <20260526033539.164061-1-dong100@mucse.com>
References: <20260526033539.164061-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292487-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 625485EB486
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 11:35:35 +0800 Dong Yibo wrote:
> Hi maintainers,
> 
> This patch series adds the packet transmission, reception, and link status
> management features to the RNPGBE driver, building upon the previously
> introduced mailbox communication and basic driver infrastructure.
> 
> The series introduces:
> - Msix/msi interrupt handling with NAPI support
> - TX path with scatter-gather DMA and completion handling
> - RX path with page pool buffer management
> - Link status monitoring and carrier management

Failed to apply patch:
Applying: net: rnpgbe: Add interrupt handling
Applying: net: rnpgbe: Add basic TX packet transmission support
error: sha1 information is lacking or useless (drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c).
error: could not build fake ancestor
Patch failed at 0002 net: rnpgbe: Add basic TX packet transmission support

Please rebase and repost.
-- 
pw-bot: cr

