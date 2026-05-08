Return-Path: <netdev+bounces-286015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJGnAQFi/mlJqAAAu9opvQ
	(envelope-from <netdev+bounces-286015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:21:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 772704FC4F0
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76B35301915C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998539DBF1;
	Fri,  8 May 2026 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWldtr5Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024342DF134
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278909; cv=none; b=aXVwZAEkQZsCd4E0UA5G54JfMIcFC5CKg3QxkY0zyZETS28pxKwXnJsQGw4h+UkgSNnNZYXe0LT80mbFpewUu3i2oU8Tzwatx9hXK5P+AX85P5Bs9cJZREmumG2yURwEQHUo7HhcA/0J/lqe/gnil1IqwFCkzvXDPkskqn0nbiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278909; c=relaxed/simple;
	bh=YrlHwG1JhRwk6HXbHF4GrgQkV4daUgFo605JYTtGxW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMei6k4BdruBWoEoq3uScM892RT7S2TiH2P0ouN656uGsbOt6xfG9LfRf2+bglJs62wSqmCc7yNcq1u9q300c8YWcpSmOm1vdt9ZT/OLzJ0P26KKAGmRkRkhRmSOEP7IKTfCh5xIYxCVPJdNd04RSYZ6nlcnISFzRGAeu3/5caM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWldtr5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31A0C2BCB4;
	Fri,  8 May 2026 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278908;
	bh=YrlHwG1JhRwk6HXbHF4GrgQkV4daUgFo605JYTtGxW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TWldtr5QDg+PgE3d01uWAL5rppdBzdUJJONda7wBLwlu4Y4XGGQ/9zgkYMDh0CxIk
	 3u89eTpiAk4wLCF5M6PMQeRl8/fnQMdeVcBP0Gy5w7HJSmHGXz2S1Gzf9mYYeTXoQw
	 VH+PHF7IZ/KhgYCKbsr+ga7hcTsXUh0TQ3tYc6cDnSO1QFCCc21pww/aDxnQp7px/k
	 MRHTapJ2MlfYznsJiJO9J06CEeQz/xT0yIDAaUy4hUeK5H0u3b6QMmRqo5JDlPYbfl
	 409f2tDz2qXGsKeOrcdMAmryXk0UZ1BP+nc7b4CxJt+L81KyoOxcvRuKeYkEKmAMuJ
	 0ViZqFKuDuQJA==
Date: Fri, 8 May 2026 15:21:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Alvin =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3] net: dsa: realtek: rtl8365mb: add support for
 RTL8367SB
Message-ID: <20260508152147.2796f426@kernel.org>
In-Reply-To: <2a52d7a8-3a39-4dd5-a0d5-c746122a9f73@yahoo.com>
References: <2a52d7a8-3a39-4dd5-a0d5-c746122a9f73.ref@yahoo.com>
	<2a52d7a8-3a39-4dd5-a0d5-c746122a9f73@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 772704FC4F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286015-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 7 May 2026 07:18:31 +0200 Mieczyslaw Nalewaj wrote:
> Subject: [PATCH v3] net: dsa: realtek: rtl8365mb: add support for RTL8367SB

v3 never made it to patchwork.

Looks like there were some review tags given on v2 which are not
included in v3.

There's also no changelog under --- which could help me understand
what's going on.

Please mend these issues and repost..

