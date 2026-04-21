Return-Path: <netdev+bounces-280168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCdvJ9CW52mp+AEAu9opvQ
	(envelope-from <netdev+bounces-280168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:25:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF2843CB44
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E73D305BFD4
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FE32C2363;
	Tue, 21 Apr 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx2nEI7y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04845282F02;
	Tue, 21 Apr 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784807; cv=none; b=AiCOq+bjW52f5K8gp/34raggPZ44jUP36Wgi3gFFAKMvSQ56DvdgKs/AEavmtikmaXvEnDlzY9zH0G2/FyIzFtqlJhAUENuQdWleuztzA3uQEXdZ9JhdN8GhJkM168uas64qMHG5k0qxvCU69a/F2phySsuz1qapKbDJmab9hYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784807; c=relaxed/simple;
	bh=CzEVcDl5gAAqVpLVhu05W8l9aBX4FNIHynLpgN+12iA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbBYhRTUwAZYUGo/qlvI3P3ILV1oZyeWEuPK2TP29MF1gA5r+msKUBUXA0KW3goibmKEDoqFS54dsb+4ryuxer7df9EDbBxSSyCV2wF5fXN1QsJPv1syGJGdFWzq7C3O8iVzA0pZKFPLkNVOhLUVccACOjzWkCtZ1rSqLFNW60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx2nEI7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBCEC2BCB0;
	Tue, 21 Apr 2026 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776784806;
	bh=CzEVcDl5gAAqVpLVhu05W8l9aBX4FNIHynLpgN+12iA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gx2nEI7ycw9pZ47NuDcpSSWm7SrZkXpDvcxWWiadutKum/EXfnXZtzHNEydrINJom
	 QWsQKwvA3o+tWLJygs16Xh9vCCpmlpdv5O+5PKO3UHTX9gSJYMA/jtKUosf8hGPHnh
	 q9apT75l6Df9MoNl4P6fri0M/zPYIjgNUZFVdXfalMZpWniBp9XCD1FadDcQWqM/RG
	 KcLd2F5u1reLTs07J681eik6vXFEQMG51Zo0GG/Rn/66mOyTGYBd8b5TYWr5GVADjV
	 vmIbFUtor+pM9Ty7toRvCq+w//QUX/1wPPkNdFPlE8a2xlYwAMdFAOmWwoaIaapB8T
	 edarCvY8K/adA==
Date: Tue, 21 Apr 2026 08:20:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: Initialize all fields of ip header when
 building dummy sk_buff
Message-ID: <20260421082005.74a3efb4@kernel.org>
In-Reply-To: <20260421073738.22110-1-zlatistiv@gmail.com>
References: <20260421073738.22110-1-zlatistiv@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280168-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FF2843CB44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 10:37:38 +0300 Nikola Z. Ivanov wrote:
> Additionally remove the now redundant zero assignments
> and reorder the remaining ones so that they more closely
> match the order of the fields as they appear in the ip header.

Doesn't matter, now that the whole thing is zero-initialized.
I don't think it's worth the noise in the git history.
-- 
pw-bot: cr

