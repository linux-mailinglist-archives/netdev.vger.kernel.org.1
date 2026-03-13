Return-Path: <netdev+bounces-267258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Kv3lOZ9ms2nPVwAAu9opvQ
	(envelope-from <netdev+bounces-267258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:21:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 428DB27C3C9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A0683019E30
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D212D8DC4;
	Fri, 13 Mar 2026 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKrIEJvi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424E248166
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773364890; cv=none; b=Fc4FRLQfHEXVnO23bbKMvzWskTlPPq/Awwmgcm0SonQfVz+wwqJ5Lf3BMukWT3yxBR0qvczTYkqNEcS0tFt3G72C8QehQBIRJXZvyB+Gcw+fVSUErVdel4k2nXE38s4fbhbeAo9yhKTf0HqzlUlaKwFyvrZBAxVF5agg5dvRNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773364890; c=relaxed/simple;
	bh=RT5cCoFd51XlFsbavm43RBi3zqtF/Bni3O89ezyTihQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UY7Hbh9H5qF9ItYEzg/6YiKpgaPrd4R8erkOuR1dQQ+qACS9GKQVIVY0qIoXGK6Q1rHoHm82bfWaj3dBdzhD+GMEOFsureTS9XI/GpFgH8Km3rR6upHk1UUZbpfk+aFzC3iwRNfzUEi+pV0rK9I426lUX8TDcR82vjc+/moLyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKrIEJvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31556C4CEF7;
	Fri, 13 Mar 2026 01:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773364889;
	bh=RT5cCoFd51XlFsbavm43RBi3zqtF/Bni3O89ezyTihQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lKrIEJvi88ynMx73j9D6v1S2E/u0ZviHUojbpcdcohUAxa2J6HsjbBv5IzZ4Sivbe
	 quWYsKvkiatSCzdjRsht3U5CsSpu8huhGkl9jwjdhYL1L24uI05irsbEz/AcmKJgdQ
	 XvHigJGItZOyb0TCkmI7qVMKh0unkdPu1+0Gtl8z7sQYDw24+9EEs4jjBARFoBAoIc
	 nfxqxA/XKs7V5GNkHLk+P69jGQpRhnTE2sbrY0JHhBcasCsX4k1xTmuXxFBIOakVtO
	 8PyL2QvmusaSNiXHDaE1Ti1Ks/i9wSYMDAkHJ0v6An4cNtZUeGYjDzfgniFNptYGES
	 tKrIBzyC5F/RA==
Date: Thu, 12 Mar 2026 18:21:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Remove airoha_dev_stop() in
 airoha_remove()
Message-ID: <20260312182128.33d2d88c@kernel.org>
In-Reply-To: <20260311-airoha-remove-ndo_stop-remove-v1-1-596fe853b2e1@kernel.org>
References: <20260311-airoha-remove-ndo_stop-remove-v1-1-596fe853b2e1@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267258-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 428DB27C3C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 10:54:57 +0100 Lorenzo Bianconi wrote:
> Do not call airoha_dev_stop routine explicitly in airoha_remove()
> since it is already executed by unregister_netdev() if necessary

This one is a fix I think? We underflow the atomic if the port
is already down. Once again, commit message way too terse :(
-- 
pw-bot: cr

