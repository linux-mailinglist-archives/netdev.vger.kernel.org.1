Return-Path: <netdev+bounces-302418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GeWQIduLQWo2sAkAu9opvQ
	(envelope-from <netdev+bounces-302418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:02:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBAF6D4EF8
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:02:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=DP3DyreI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302418-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302418-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46E92300C91D
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 21:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF3635A381;
	Sun, 28 Jun 2026 21:02:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4167261A;
	Sun, 28 Jun 2026 21:02:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782680536; cv=none; b=bGw4fnwxuFtLGqoLChZpVHmFeaZJ8nn0qQTmBEIAnBruAS9A9kLX6ymSbbBXgoZAkDyDUtCx13ongblKHhx8UY1sFRBZ6W0af1+GfjN1cNNg7qna4z3Fpm3L4FMCcMCIU9hpordwE4i3s4EalJ11wXWrwQRly3V1GHIwgt3GLiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782680536; c=relaxed/simple;
	bh=rfpd3WbPnifSHSfMdfb2ShUhrdTA2HxDq0vn2oqQ3JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIIg0Dk8pmib2FULzvMbzqkDfQNwAA60v884rjB0tuVk0/OlavxATxT5CTGYbDgFjrTQFPr5Xgp3EZjc1JqPRJaCtAYMD8vRg/Pl1pZx6n/kTsMtx/ghLNCU59cJQq94Zmmex+pFRVuG9Ajdk3jWjW8QBe8EYdqC7NcnysptiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DP3DyreI; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UdPVrGBsfiuqpekwBYy0Es3XVPiPzRaFs+oHp2F9b7E=; b=DP3DyreI+7yUlA/LxYAXw/5+Ka
	U/DI5iIEnr2wYYd20XmdK/lgC8rSXxhEgY03rTeHC5TA1b9aq/9akJGhiXCzS86TEA6pnXsq3zyLW
	BY9RusdBe82e1w+9VdFFh5fQRQV45zTF/TraxXInApku/4SMj9JYQtb19Hz2CZBKhY/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wdwdh-009eJ8-6m; Sun, 28 Jun 2026 23:02:05 +0200
Date: Sun, 28 Jun 2026 23:02:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rafael Passos <rafael@rcpassos.me>
Cc: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Subject: Re: [PATCH] Wireguard: Fix data-race in rx/tx counter
Message-ID: <aa423184-7465-4bc9-aff4-d3d671beb3c6@lunn.ch>
References: <DJFTVX3FE7OD.2O8GTO84798T@rcpassos.me>
 <20260628203823.144789-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628203823.144789-1-rafael@rcpassos.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302418-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:rafael@rcpassos.me,m:Jason@zx2c4.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:wireguard@lists.zx2c4.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9ca7674fa7521a3f1bc2];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,rcpassos.me:email,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FBAF6D4EF8

On Sun, Jun 28, 2026 at 05:38:23PM -0300, Rafael Passos wrote:
> fixes data-race in {rx/tx}_bytes counter for wireguard connection.
> these values were incremented inside a read_lock_bh block, but write
> protections were missing. making them atomic was the simplest way out.
> This was found by syzbot with kcsan.
> 
> Reported-by: syzbot+9ca7674fa7521a3f1bc2@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=9ca7674fa7521a3f1bc2
> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
> ---
> 
> Hi,
> 
> I am posting this patch to better ilustrate the discussion.
> If this is a non-issue, its fine.
> As I mentioned in the previous email, this issue was reported by syzbot,
> but I was not able to reproduce it.
> I am also aware atomic calls may introduce extra cost on older arm cpus.

Atomics are expensive in general, especially on high CPU count
systems. 

Statistic counters tend to be very asymmetric in usage. They are
incremented frequently, maybe per packet, but reported very
infrequently, maybe every minute when an SNMP agent reads them. So the
solution to statistic counters should reflect this. Increment should
be very cheap, reporting them can be expensive.

There are a few different solutions. Per CPU counters is
one. u64_stats_sync.h may help.

Please take a look at other drivers doing statistics. This is a solved
problem, you just need to copy bits of code from somewhere else.

      Andrew

