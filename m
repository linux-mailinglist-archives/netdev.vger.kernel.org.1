Return-Path: <netdev+bounces-279533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KeHgKnzE42liKgEAu9opvQ
	(envelope-from <netdev+bounces-279533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:50:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFA4421DCE
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B55D301BC2D
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3941F2F999F;
	Sat, 18 Apr 2026 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rG2qAgnl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A92472A6;
	Sat, 18 Apr 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776534647; cv=none; b=MnTHCkhU2ni9n4yFnc5Eqf0+PYxOks+9GN4+VkvZpUapyfNU1LdcB7eXsARvELm6EL/kiYir6ckmpoN9sNL6ZwKIxtKGlz8tBRyd8jK+8xjD/nqBcC4Qnf3Bx2EUQBxrvmk2SB1eIgnL11RIS+Kd8uyJtZwTRGxodU5cLN4fqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776534647; c=relaxed/simple;
	bh=UDSHJvlRLnfJws7E3rDKrzCfc6LzXqWJF3JEjKI52XU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElHMj7O2PsW+2AwsvNXZp3nNGBWDJ+FpeQB+++S5XQadWYEgYgXXa0Cfbv7XHYNh5PU/7FeXjMWUpV5oc2E0UerqB0Gntu35n46wuQLLG8gOar50VT/W7ei1cYmPpixW1jwVijr6DD0B2O6s93D8ZiOzVL7Vu06uXS93XCP/z/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rG2qAgnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525ACC19424;
	Sat, 18 Apr 2026 17:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776534646;
	bh=UDSHJvlRLnfJws7E3rDKrzCfc6LzXqWJF3JEjKI52XU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rG2qAgnlUKtwNJEQ77UFsQpKu/eMsWktXuzcX/tv4yEUc38nBVgXs+qWMVk/i2N5L
	 YJ49ocPW9yLOu9uB2qQ3XNp2dTVFyY4chObAnpykaYi3zfrr+AocPKFsD0cwUPKyTd
	 lNtpFqpbg6LhTP5MvCRgQI8/9gIArdybPksHIHOs91Ae55gMTmNKVnLkmrZdpg755t
	 BVSG2mmHDknVAtmx/QorLPpbyJ/nq5KNj6jFa81Yef8NS3Kesg8ZqAmkPCaBff15By
	 9Xb2TZqVIW86RvMEtbsDRit8S2ylJumm7auBYnec7tZHwxs5Ac/PlBed6ucw/pc1Zc
	 NO/UsxHjXYfrQ==
Date: Sat, 18 Apr 2026 10:50:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gustavo Arantes <dev.gustavoa@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] r8169: report per-queue statistics through
 netdev qstats
Message-ID: <20260418105045.2bf4e102@kernel.org>
In-Reply-To: <20260418021232.5425-1-dev.gustavoa@gmail.com>
References: <20260418021232.5425-1-dev.gustavoa@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-279533-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AFA4421DCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 17 Apr 2026 23:12:32 -0300 Gustavo Arantes wrote:
> r8169 maintains synchronized per-CPU software counters for packet and byte
> accounting, but does not expose them through the netdev qstats interface.
> 
> Add netdev_stat_ops callbacks and report the existing software counters
> through queue 0 for both Rx and Tx. Provide zero base stats so device-scope
> qstats report the packet and byte counters as supported and match the
> existing RTNL statistics.

It'd be good to include the motivation / backstory that led you to
implementing this when you repost this after the merge window.
Benefit of having qstats with a single queue may not be obvious.

