Return-Path: <netdev+bounces-291417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCJuGE+XFGpfOgcAu9opvQ
	(envelope-from <netdev+bounces-291417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:39:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29B5CDB8A
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2839F303C62B
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F58533C53F;
	Mon, 25 May 2026 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSFwvaOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2001A23A4;
	Mon, 25 May 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734160; cv=none; b=LEiR1sGM4TsPbh3ZdhVylE8opdmmxyOufZKHpJfypkCiMZoWFbQidIhw+H/rdeHEdtvwJdSnBt7NJpDQ9/pRFP3nbP75cc9b50+05aPKJIpzInKM0jH2LV5Wp3wEkCcwgccvN5Hgwba0X4Lkn7g+HIbPVKSyV4vuIl2EJy2QS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734160; c=relaxed/simple;
	bh=eBwH9rWmf+4lIJnmfdCexfouZbIfdjMVSlP679q6Y10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y64ZfCWS+RTcBtVae0gL2qPNlQxRFchZNXCpSPnIO3vPbj5K3pyXZ6vNGDTCr2PItkbjaO/jy70hJ0ZdYhThhwiEjSRzCNfY4mrciM1GIEDxhlBxCT4/s8uDsFoeKCKzZOWfeSr3pguoWZ4+cXqx/rAQha4tq+nQ8QRgqR7W04w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSFwvaOQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01A61F000E9;
	Mon, 25 May 2026 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779734159;
	bh=NdUEHvy6IiK6HI8x+dd8eQZG9wUjSih5j8Or/mbnlpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kSFwvaOQEC6jH8m+ukkHJjItrWnK5Dfm5FJ+c3mO24nBNfxYTCTNOdjRbFKH9z5XY
	 I3VQWd0MurUBb82eWUeRuZusFJcPlm4x7zFEUUwc12PhU/8/LYroc+U7+KKH+THQKt
	 kqM5MPAi+UdGGaDbg23Gf7eaZKFhhL8Yi2fXKFavTa+EQ/sZAtepgWvJYtII0wlNan
	 K9o/bfgyvM+byJBNpuKngLYHLSekLtDji5mpg6tV8Fqa568hpU7C/WS3kOTzEaFZTJ
	 7MOGkTjUgeM7ozY4rXjYg+IkvFD0Gkbj7Nr46pF9GvYNz3wRqCmvPhy89lA5bFHmFJ
	 ArcwjuzrFLJlg==
Date: Mon, 25 May 2026 11:35:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk>, Mohsin Bashir <hmohsin@meta.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] eth: fbnic: move aui and fec from fbnic_net to
 fbnic_dev
Message-ID: <20260525113558.0b6a461b@kernel.org>
In-Reply-To: <20260521-fbnic-aui-change-v1-1-fc0c46e8e682@meta.com>
References: <20260521-fbnic-aui-change-v1-1-fc0c46e8e682@meta.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291417-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B29B5CDB8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 09:51:33 -0700 Bobby Eshleman wrote:
> Subject: [PATCH net] eth: fbnic: move aui and fec from fbnic_net to fbnic_dev

reportedly does not apply, please rebase & repost
-- 
pw-bot: cr

