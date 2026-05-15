Return-Path: <netdev+bounces-288143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKrMBZ13BmoUkAIAu9opvQ
	(envelope-from <netdev+bounces-288143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:32:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0E55486CA
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11C4A300CB09
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87B6366DB9;
	Fri, 15 May 2026 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQhsIMbH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D635C1AD
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808730; cv=none; b=PDWIhcVSOeQZz2HfiiZ6TWTBSAxpmpi7ErzhwsiArW83h4qLv9GKkhCl8PpN7YJJV/Apxpf98sRlQ42D8CuACTthGvB/RTDrlYHuKYLNx32p5l7n66QMs/GTWo7uXsS+y8ucX32C1MXFSxo7BxqydBW2eDr3eAuQNPTFOSmLObw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808730; c=relaxed/simple;
	bh=hziJcy07T49JEzjtW7Gs8Tf25HTZrdijW1Yg0CAk0EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjeDos3MHqzYj3mqtnw1p84YwpaZp9hlAUZ/3XgKVBOw8B/1u5vzqd0s61QQf0CvJAnqd28t1GYcbXn4yMjtWa61IkliuPyXGyUjugEpK1IoMoLZ9TAF5Cmr1CyypF80zZH5GbkIylizwX8UWOJc0FxDTgDMvr0wfMJRxDeQMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQhsIMbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045F1C2BCB3;
	Fri, 15 May 2026 01:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808730;
	bh=hziJcy07T49JEzjtW7Gs8Tf25HTZrdijW1Yg0CAk0EE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQhsIMbHuPz3JAWUrFijzfD8hgvJqDDaBf8JPLRxrhMQf4Pt6QdhIDc1iE5ZegORb
	 bSB14ZIJh2C0EafAhvjycVIAe0BGc7Wp3X+s0Ok1B8p86vy7lnaiUqgnZwJMltpLEF
	 H0HkMhbIjZ4fzsdQUDlEfCF0mfhQdKDsu/4V52dxTUSANy8SI9W/VKj1feJNlZ8wir
	 /JTl1F7wNqbC0z08OnrqrHl16SCOhCvceRk5jKcNnS/eVD5UZlBqPzcPRkiB9sMVfZ
	 Se6B3QRfNOst3sg6psWpkI5HmfZuMBN2Yrk60Tt4r0MeJSMb+8RcCiJfvjroN+qAve
	 0TgEmX41QAuEg==
Date: Thu, 14 May 2026 18:32:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 5/5] ionic: Add .get_fec_stats ethtool
 handler
Message-ID: <20260514183209.48fa771a@kernel.org>
In-Reply-To: <20260512224421.25236-6-eric.joyner@amd.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
	<20260512224421.25236-6-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AA0E55486CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288143-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 15:44:21 -0700 Eric Joyner wrote:
> This includes 802.3ck FEC histogram data that some newer
> hardware collects.

Ah. "Some newer hardware"? As Sashiko points out the standard stats
are designed trying to avoid "does 0 mean unsupported or 0" ambiguity.
You need to figure out if the device reports them and if not - don't
set ranges.

