Return-Path: <netdev+bounces-304550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +3IZBly3R2oAeAAAu9opvQ
	(envelope-from <netdev+bounces-304550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:21:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 449DE702CBB
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:21:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZGgZC9J+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304550-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304550-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C34E3303ED96
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF693D091D;
	Fri,  3 Jul 2026 13:17:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572F836A36A;
	Fri,  3 Jul 2026 13:17:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084677; cv=none; b=SygHlIpthbS8D7a5k4UlNADH6Sd/Vd2pfgqnzBfCHBEXigXQHZCD6dVABOPIQWbs9pMMVWxPuRNKmj5eGyMWB/dJrGJXs/lf8lEIvPtE553wrYCP9ZtzNX9J0Pq6pCyfnQW62Oseoq3z88w2+qXlIZnLqolQKgvO36W9tQOCW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084677; c=relaxed/simple;
	bh=Lpk9T9Nu4QX2hYu6VtapHcsvGWBwFmOya2dsfHjHORg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UzDdp8dXrzCPg9DZ/YeKLwgllrg24Wfo9UFZtGlJHKHNpwgLY0FDhNTNWvNhLWgaEBwu8T5Yc+EMKWlH1L0PQTnL9BdwITZdoqvpMeutAvK75pN4cc1q4Dg0X7eQZiA8Uf12jrZIuY7Zd6WEEam895ufxV4W9avU+RGxPprgKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGgZC9J+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273781F000E9;
	Fri,  3 Jul 2026 13:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783084676;
	bh=oNzl1AxTD2RqxUyD0XqLfr7tlARoKD1MvwPMVlFDCSw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZGgZC9J+86O5efyX4QcIw0nctyd6JaJKe+SQff9/78ZVvFFeRNofFiBS/TBxAU6qp
	 e4b/JFSBTxreDFvtN3WKMbidWFPZaVITuTlIyTHBCfQovqUOa7+ixxHnFQy0SIfRV5
	 fKb3WitLgihi3Vg2hy+3UKQJQmbtxSna5WOXvKgxdUGUZQU2pzMlQi3h3Bp6dK+ssm
	 1zkCmTq2swwlqNSWJ22xE8K9sUzDwTyBeVCN3rCqSQPkcK38yNi9/LxUlJMoq29ehV
	 06lVHNBIIp/1hA3+JtP652gJr0w4i6EbNP3JOMyZhMjm+671/8sTb9AurE3F5HpMuu
	 l5GPJn7wXjGwg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v2 1/3] af_unix: fix listen() succeeding on sockets
 in the wrong state
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <John.Ericson@Obsidian.Systems>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 John Ericson <mail@johnericson.me>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Rheinsberg <david@readahead.eu>, Cong Wang <cwang@multikernel.io>, 
 Sergei Zimmerman <sergei@zimmerman.foo>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems>
References: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems>
Date: Fri, 03 Jul 2026 15:17:46 +0200
Message-Id: <20260703-eisdiele-strahl-karneval-28355945318a@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Lpk9T9Nu4QX2hYu6VtapHcsvGWBwFmOya2dsfHjHORg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5b2tIjGWbOSPjftWs/wLrzhrmOcfqzbp315T3SGXAs
 9bFawq4OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaicZuRYUvT7Vvd8xrW2Brm
 1z9MreO8OHFn+v4zH1csXFtYuv7U3keMDI8uxCoanVu+y7Sso+fk2YVX+f4kMqy5yd3KPeUr8x/
 ul5wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:John.Ericson@Obsidian.Systems,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:mail@johnericson.me,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:cwang@multikernel.io,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304550-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,johnericson.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 449DE702CBB

> Commit fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for
> reaped sk->sk_peer_pid") inserted a `prepare_peercred()` call between
> `err = -EINVAL` and the socket-state check in `unix_listen()`. Since
> `prepare_peercred()` leaves `err` at 0 on success, `listen()` on an
> AF_UNIX socket that is not in `TCP_CLOSE` or `TCP_LISTEN` state (e.g.
> one that is already connected) now silently returns success without
> doing anything, instead of failing with `EINVAL` as it did before.
> 
> Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid")
> Signed-off-by: John Ericson <mail@johnericson.me>

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 
Christian Brauner <brauner@kernel.org>

