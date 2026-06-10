Return-Path: <netdev+bounces-297730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g5WKJk+BKWqQYAMAu9opvQ
	(envelope-from <netdev+bounces-297730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:22:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D666AAB8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:22:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mandelbit.com header.s=MBO0001 header.b=BcR5yziy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297730-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297730-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B092302D098
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEC241931A;
	Wed, 10 Jun 2026 15:15:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937C40861F
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:15:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104512; cv=none; b=pPnMZPVrS2YNFycBhSr+4IAEM1ON6sDS9Cu0r0CRcI45JoB/5qm2rDDDtkpAyR03N/KcAuIHRjKFZsG7/8Y4Y72AZKMh57I+D3CFtKC9EQOHaIP79g2grJbIJjSKGRUcgsbJDgIU1SnygpCdh1lHwE9NF4InNAkf6O5wVzxPXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104512; c=relaxed/simple;
	bh=AcHnBkODCIJQUsA/TbUO5i7nbvynSvbc5zIJYSN8Wcg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Uf71Two3NPb777TBLxDNapU+jqlg4gFh89w6l+Q7Z19Yl4kCmMuqfQQAf/YX1+YlHpYMhZprtz/sv5+3w/HDRAz0dkGPZ3XBDhh4gPIWn032piDr8G8Suwiw9Yu7oiyEpN+5Y0fUgESgCKHxJZG/tfB+1HNm8Dsg/9ZghISFasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=BcR5yziy; arc=none smtp.client-ip=195.10.208.55
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4gb8Jh16pkz9ydK;
	Wed, 10 Jun 2026 17:07:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1781104036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8cyTzK8VVLFV0bzqRLOmtBcBa8FWin92OY6w3YNrns=;
	b=BcR5yziyiahOm5d6mT4ZDwC6XMwDbJjCs+Krg/eRB436DuFFMYmmk5Ep89S78a0g327U3r
	2BVNGEeoTFWjukFs0F6pMV9cYkGCJ0KJgpbquEyd96/RCrhLHIEs3iR3Hhxru8+1WGxFTq
	iWW8hxVi7XELTJXy2huvGyGHPwGy16HncJ8zcP4yhHMm/Z835q4Nc6fCfGX4HMFcQlXzVO
	4mP4imMNNjTVj+GUX8pgf+pKU63MuYP0P67OD3EfOTHyk+STgheXKsVI1su4ZqLCSz8AA8
	2n07bCdFFuCnIb+WY9cwWYxEpD3eQzWTA5CuX5FqNAVp8XZiAFKDWm4c1pnqWA==
Date: Wed, 10 Jun 2026 17:07:12 +0200 (CEST)
From: Marco Baffo <marco@mandelbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>, Ralf Lici <ralf@mandelbit.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Message-ID: <1932179615.53655.1781104032870@app.mailbox.org>
In-Reply-To: <20260610073111.6273e17a@kernel.org>
References: <20260608150741.3320919-1-antonio@openvpn.net>
 <20260608150741.3320919-7-antonio@openvpn.net>
 <20260609194246.23c66818@kernel.org>
 <1290464191.15539.1781081055969@app.mailbox.org>
 <20260610073111.6273e17a@kernel.org>
Subject: Re: [PATCH net 6/6] ovpn: use monotonic clock for peer keepalive
 timeouts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-297730-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:antonio@openvpn.net,m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:ralf@mandelbit.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[mandelbit.com];
	FORGED_SENDER(0.00)[marco@mandelbit.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.mailbox.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B8D666AAB8


> On 06/10/2026 4:31 PM CEST Jakub Kicinski <kuba@kernel.org> wrote:
> 
>  
> On Wed, 10 Jun 2026 10:44:15 +0200 (CEST) Marco Baffo wrote:
> > > On Mon,  8 Jun 2026 17:07:37 +0200 Antonio Quartulli wrote:  
> > > > Replace ktime_get_real_seconds() with the monotonic ktime_get_boottime_seconds()
> > > > to ensure the keepalive mechanism is robust against system clock modifications.  
> > > 
> > > Why boottime? Unless there's a reason shouldn't we be using
> > > plain ktime_get_seconds() which is CLOCK_MONOTONIC?
> > > 
> > > (if you decide to respin could you also drop the selftest change
> > > from this PR and move it to net-next? memory leaks in selftests
> > > are not important)  
> > 
> > Hi Jakub!
> > ktime_get_boottime() is like ktime_get() but it does not stop when suspended.
> 
> Worrying about keepalive timeout when system is suspended seems
> quite silly, did some AI tool suggest this? Anyway, if you want
> to keep this code please improve the commit message.
Yes, it was suggested by Sashiko but it does not seems like a bad idea to me anyway, but please tell me if i'm missing something. Regarding the commit message i would be happy to improve it but it looks good to me, do you have any suggestion?

