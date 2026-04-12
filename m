Return-Path: <netdev+bounces-277909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMrSETMK3GkTLgkAu9opvQ
	(envelope-from <netdev+bounces-277909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:10:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFBB3E607C
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 198B4300253B
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F188B37F8D9;
	Sun, 12 Apr 2026 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBnt7cEh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45F2D5932;
	Sun, 12 Apr 2026 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028205; cv=none; b=GgKZAdpzlkPJhDKZciCIVXAaaZmycPMciY5q5Kzy+QarP6UOuMZweDy4CEt5bs4onV19Yc5MYpK2wMx5kO4WJPVeufQoHtHIM7kITBgjF+FdxZI+5tQb5CoOkxdfqujMXvvRoKpX/0MMF2bzuQQ67rDOl1O6Sbs1HBrVJ+0GdD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028205; c=relaxed/simple;
	bh=RnCEVneRg2p+B1h9N18MLNO+7HhnJP2hMAqYxAqiTLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuTjHFYd8636dKKotN8fVyVti0t1DfEsJWS4n+/5Jk18xALTYZCB4GqYa0kUOapxnS6zleNCIr6mOjMKPGtexdEOq+q2b4EG/R5YdEzUz8IhK3W6/xjCA9xXJlfyMKl5+8RYiDwLAGNnsBD99qzsr3H6w5i6vdmQH3zgmN/59e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBnt7cEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ACAC19424;
	Sun, 12 Apr 2026 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776028205;
	bh=RnCEVneRg2p+B1h9N18MLNO+7HhnJP2hMAqYxAqiTLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DBnt7cEhuMZsDeczOT08L4IejOCzswFAeinj+/7l15Xv7rR/GJFkmmy2+hxd1tZkK
	 M8KLB9TLsH1Da9a08Oyypyj3sUF+mxCzxJG6nY+nXRRoLPIiIEX55llUARtXBX6Y3K
	 WMXLonP/pKCn+fpZL/fjF3rdqud+i1CRPeO30KTg2BgrZDmssxx74Qg97Z2yx92sNb
	 r1+/WbabC86sU6NvQN1UVeOrmZHktnqQbX2uA+cVWWXmX2igGo2q5YD/8gl/2GDVTZ
	 0zTyqWp8WOngIuw+r8UZhIgLZfQhNqyKdZstLxnPwlkAnyVBSxri16CPVvuHo8hHOK
	 GQJ8Kl8yz3TEQ==
Date: Sun, 12 Apr 2026 14:10:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Tim Bird <tim.bird@sony.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] keys, dns: drop unused upayload->data
 NUL terminator
Message-ID: <20260412141004.22c6686c@kernel.org>
In-Reply-To: <20260409225703.158552-4-thorsten.blum@linux.dev>
References: <20260409225703.158552-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-277909-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BEFBB3E607C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 00:57:02 +0200 Thorsten Blum wrote:
> In dns_resolver_preparse(), do not NUL-terminate ->data and allocate one
> byte less. The NUL terminator is never used and only ->datalen bytes are
> accessed.

I can't see where this is used at all.
Please write better commit messages, there's no way this 1 byte
is worth the amount of time I wasted trying to review this :/

