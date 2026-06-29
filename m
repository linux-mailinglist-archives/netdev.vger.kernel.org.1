Return-Path: <netdev+bounces-302598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CN0gIFBdQmoP5gkAu9opvQ
	(envelope-from <netdev+bounces-302598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:56:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C06D9B1B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:55:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=iQXZwN7f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302598-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302598-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5F91306FDD3
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03F13E1D0B;
	Mon, 29 Jun 2026 11:45:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455038A718;
	Mon, 29 Jun 2026 11:45:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733557; cv=none; b=S/GjkICZNCytBkSEycnXPvO9fjMqNMNz1YrbNgYTgsHGt/o4In+XM2lkByYTn/vUNlcyn4FM7yFXQnzWxCmBzWAf/1NgGiamdUNOWUroch9BWVsnjWK/02nWDkIHtbbFCPj/8DJqPN/Znm1eF4hTmYxq4TTOl30nblf8/m+t/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733557; c=relaxed/simple;
	bh=QWr9ysC6OQ3JB8R2OJ84TK6P3OpLKnEssbEOO+LRxNI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PH687jKeDwzZgmbkvKuMqd+KziFPjyHC9mhPLbldq5WQVYBfCPOrbQEqZoTLKTHTr3nnxXTRuNYzdHp00mRq99eAS7lvjl5SB/GA8UR8GovX94yWT80ZVCB4/soX4O12LMlUB07jTzSjqRxiipBwgJ8KkqFgjvubl9t0Wky0/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=iQXZwN7f; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=dkRZJp47irsF8IfKbEMXa5Q0GNFPkNwXPRtfmlrbz8k=; b=iQXZwN7f491j+RsJLMz6zfYsl2
	87XxqJkLzKIbFx9Frlby0RdJzyeu6DNmmM2JaYLTWPswaXnxUA5HA/mx2wJKJJpIpLD3QXi34IVym
	Yvym0+oGKCX2mUOmqYWwQgH+cp+tkefb4p/y7ftKFwF+FE4whGQjKUDHAdY62VURnuh5RQpm89/HB
	egWElHXmqwAhPvX5Cs8SY1dDfUUvpcHWH9uiU1X8UbAUNMT3HM4lyoBD+vi51obPURiBZDTmuKMX0
	ie/5b9NqsQMbOFoQrMhzoDDjnIwFNIKYGsQfHjrcRb7jp7SIwIIIdOVymJqiC9NudgFChOGRBjZNs
	y0KU8F+A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weAQv-006Gdp-1i;
	Mon, 29 Jun 2026 11:45:49 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net: do not warn on best-effort skb
 allocation failures
Date: Mon, 29 Jun 2026 04:45:39 -0700
Message-Id: <20260629-netpoll_no_warn-v1-0-f380f0b2cd0c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAORaQmoC/x3MUQqDMBAFwKss79tAklZLc5UiYs22XZCNJEEF8
 e4F5wBzoHAWLgh0IPMqRZIikGsI02/ULxuJCARvfWc7/zTKdUnzPGgatjGr8dY97tG17yne0BC
 WzB/Zr/EF5WqU94r+PP8EtT5FawAAAA==
X-Change-ID: 20260629-netpoll_no_warn-20174d15bcd3
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asantostc@gmail.com, gustavold@gmail.com, vlad.wing@gmail.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=leitao@debian.org;
 h=from:subject:message-id; bh=QWr9ysC6OQ3JB8R2OJ84TK6P3OpLKnEssbEOO+LRxNI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqQlrpH0x8xb+ksapgzqxOQ0MymnKp5nDGpEiLf
 ZzlnitXr7eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakJa6QAKCRA1o5Of/Hh3
 bV2EEACObdxT5Q30HgRzyr6jkVTiB/qAwXZR8820xsD9DGJgf5rr8jZtuHCei1nGKFyoobizT9C
 NsEIiX12T1WtFJU4jcH6mzI/qrPeLlBl1EXuqXR/L2UMrYtvXt950/LFV+quBYPjv+w+omlTHj+
 ArnUK9VG1w5QU+BpwMd8oeZ2rX3ZcqwTUHSLP7OAqTSpLAFl2voRzVaA7GORZqOe+svkiqzQPwb
 BASP6ugc1EmIiRd+H11ER2iVHWNbXjeFq5AXAfWmgCEdZ1jeljCenYGu2xGPsgyopx5i3zppIWg
 knNrzGwbkVdFIEDmzS3jeYVIREOZW7h2rb8LXUFVL9hFfx8iOim0PhiiJ+vkegRkZ2Jd3jIZR0a
 RzPcwkMLiR1irZv5VFPqB/ZMWuESW+rS2ek2RTpBUAp1Z3/5lsSZLfMyJpVn5ize5onJdpCeL08
 7xukXvQsa91dNFuH4iScy81mIo/HsfQF6kn3J4BQYRua/ySQaFn/QIyKRa9Zc67MhhbOzXvqHdH
 Mo7AfyxLT0NXuOp3yDD3wYXcfOt928ekGCgtcN6z2CieZPlE2hAAwF6SMfl5cqQAASd71/oY8Zu
 W/OqBKvSepIEpK+tBzUgSxfahwknoijnvp4U1vPEi1OxSvPkFIg4lQBi2QzOXym2MY+Q5nzPNaE
 EUmtjKtCzbhtzbw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302598-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:vlad.wing@gmail.com,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,m:vladwing@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D98C06D9B1B

Both netconsole and netpoll keep a small preallocated pool of skbs
(skb_pool) so they can still get a buffer under memory pressure.

On the hot path they first attempt a normal GFP_ATOMIC allocation and only
fall back to the pool when that fails, keeping the pool as a last resort.

This is where the problem happens. If alloc_skb() fails, we now have
more than 100 message coming from the page=0 failure, which consumes the
scarce pool of skb, making the real issue disappear.

So the noise (memory allocation failure) deplets the SKB buffer and crowds out
the real message we were trying to deliver.

This is happening on the Meta fleet. The stack trace looks like:

  pr/netcon_ext0: page allocation failure: order:0, mode:0x40820(GFP_ATOMIC|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
  ...
  dump_stack_lvl
  warn_alloc
  __alloc_pages_slowpath
  __alloc_frozen_pages_noprof
  alloc_pages_mpol
  alloc_slab_page
  allocate_slab
  kmem_cache_alloc_node_noprof
  __alloc_skb
  send_udp
  netconsole_write
  nbcon_emit_next_record
  nbcon_emit_one
  nbcon_kthread_func
  kthread

Solution: Do not warn if netconsole/netpoll fails to allocate these SKBs. Pass
__GFP_NOWARN on these best-effort allocations -- both the hot-path attempt in
netconsole's find_skb() and the pool refill in netpoll's refill_skbs() -- and
let the existing fallback paths do their job quietly. The allocation will
happen on SKB refill workqueue.

Given I am touching this code, if alloc_skb() fails, reschedule the
workqueue to try later.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      netconsole: do not warn when the best-effort skb allocation fails
      netpoll: do not warn when the best-effort pool refill fails

 drivers/net/netconsole.c | 2 +-
 net/core/netpoll.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260629-netpoll_no_warn-20174d15bcd3

Best regards,
-- 
Breno Leitao <leitao@debian.org>


