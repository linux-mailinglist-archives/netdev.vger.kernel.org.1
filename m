Return-Path: <netdev+bounces-294992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +GFCCGLMIGoH8AAAu9opvQ
	(envelope-from <netdev+bounces-294992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:52:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE3463C1EC
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:52:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oL48xzWV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294992-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294992-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFDF2301B25A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0761F30BB;
	Thu,  4 Jun 2026 00:52:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAA73463;
	Thu,  4 Jun 2026 00:52:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780534367; cv=none; b=Yr0hB63h7pGyeoggsVmigon5aVrcYJ7Qk+qetXf8+XsDHnJ9Ll7PWzTwqjUx0B4uAT59myezZyEuwqBcCrVN6sE49Wi/8HzaP23VBIdIbus23FhDhn5AGJ9P/j01n631o5GtDDPn4mp5pY70NT74K8Mnj0U5Cpzg1qBgffPtW1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780534367; c=relaxed/simple;
	bh=5eS6mGy0XcuxMWjVnk9W9w/s9NaxdSZ6Z569lfx/1Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfWQr0/uhNmd8ttVNLdf9PiLIOVTUNCw7RE74SoPKzjz3t0yE286P+SIUoCMWrfaRQMeak+9fiyXjNYzWEqNqb5+eWD3n9Cssg4Lq9KYec2otxP1iXnbmGB0l57GNTMY7/aYxU9egLlxwEGG+Vg1/1Wu9Hn65PYp2vnqqQervoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL48xzWV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA391F00893;
	Thu,  4 Jun 2026 00:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780534366;
	bh=5eS6mGy0XcuxMWjVnk9W9w/s9NaxdSZ6Z569lfx/1Sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oL48xzWVllHJHqwZ7z1CLg5Z77CS068Zq2NxKnnIaZaEuzKRzScaLOUHkzW9J+CTL
	 2zPAtnPKDVp0bEFx06G7vxahKBZGQmxr5391iYC0J9Z6K03xQf6n462mM1qT19NGiH
	 bFSod5PtG+u1SBs6OZGWi7Czj/f1o6Ms/o/YACtlS+yhsBSRNs+WKG6C6tzGPwRMcA
	 p5KIvkHOtyHRII91dQfL2PjGFpSn8ZyemEbPJWgZ3F15W1rpUQa/ZX2UKopNZNxZGX
	 Y7YhgBj55j+d2vz9CkdYkVkybJg6dCRywoONy8vKLfPtlpI+NeM5pGMjJWeQ2dTaPv
	 13DULhE88VwJg==
Date: Wed, 3 Jun 2026 17:52:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, Alvin
 =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: Re: [net-next PATCH v11 4/9] net: dsa: realtek: rtl8365mb: prepare
 for multiple source files
Message-ID: <20260603175244.0950094e@kernel.org>
In-Reply-To: <20260531-realtek_forward-v11-4-50d60f5717e8@gmail.com>
References: <20260531-realtek_forward-v11-0-50d60f5717e8@gmail.com>
	<20260531-realtek_forward-v11-4-50d60f5717e8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-294992-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:luizluca@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:namiltd@yahoo.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,yahoo.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BE3463C1EC

On Sun, 31 May 2026 23:53:19 -0300 Luiz Angelo Daros de Luca wrote:
> The trailing backslash in the Makefile is deliberate. It allows for new
> files to be added without clobbering git history.

FWIW maybe just my personal preference but I'd add a trailing comment
for this, IOW:

rtl8365mb-objs := rtl8365mb_main.o \
# end of rtl8365mb-objs

This way it's less likely someone will add a line here without
realizing it will become part of the previous statement.

