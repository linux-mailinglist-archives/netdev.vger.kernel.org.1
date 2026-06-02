Return-Path: <netdev+bounces-294331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BP9PEXYeH2oMgwAAu9opvQ
	(envelope-from <netdev+bounces-294331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:18:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E50631001
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:18:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nTzLFTrT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294331-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294331-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1755C3026260
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82378368D48;
	Tue,  2 Jun 2026 18:18:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1F35F8D2;
	Tue,  2 Jun 2026 18:18:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424306; cv=none; b=CDSp+pGw6JUfa7pVI2Z+WrAOR91BsvUFe9zI2fqxb3LyG3yXK7sqVkjPPbfS+rlW4JtksD/DAf6Gv3Cw+F1/bR3p1ccXM8M9lgk32tMGaeQzxTsCOqZ+RypzECZ7bI55WBxPZKkdWvy1zWDvDeTNYRB9UDiT6Cm/ZHiXEc/5NYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424306; c=relaxed/simple;
	bh=kaiP5nlmx+o6J5dZn3NEtFmE+/1HE1JUKqGhpXDCNTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3mSxbpF/6gxs8peUdyKPCRHvNVFdxZZOxgQrTq4JH/aKagjoCsvvRSS8bJdxec9QzaOc9E/mx6WKEc8fG7n1lRImV1Cx87GrSP81SyAOt7QlkWPVZUGfe+b4X+nmKofWkWLQiEcuAUwXVuCxhGclOPs5EoO4wKTgnOMjpz9jtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTzLFTrT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3181F00893;
	Tue,  2 Jun 2026 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424305;
	bh=tDyACb5/KqIGSD/zVzhz+P1a4GYNHCqoT3JaADnFHhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nTzLFTrTFDNrds9z+BHs394zIpMQnncSZ4LXYu1cjVIecgdX4KfmqViJq75KQHnuK
	 abGBei3kUWObVS5dyh9mXuz/K5Fam0en2eakjVz/HigNAtrrNMiKcM8y1XZ554HLPF
	 4Ak4VGu63ZFHb6m3S/mvcQOViokzTcoWHewkWPfmS1QNHvpiHVeomNowhbIFYRWbsv
	 7KumAtMzFLELe/cAzhLLDVPj6BbSQJSphC1PbbT+HrKjTxlheI12ZAyyZkQi+wyq2C
	 1c/8QxH7mL4uPjYRAMQqivEvJX3FcdLJ1VD4RbAph4syzrxg2BYhJoMqH/xgNTgjei
	 lqyacgx2jzZWg==
Date: Tue, 2 Jun 2026 11:18:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stefan Metzmacher
 <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli
 <tfanelli@redhat.com>, Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz
 <dreibh@simula.no>, linux-cifs@vger.kernel.org, Steve French
 <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey
 <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, Chuck Lever
 <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Steve Dickson
 <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring
 <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, Matthieu Baerts
 <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, Cong Wang
 <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, Jason
 Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, Sabrina
 Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, Andy
 Gospodarek <andrew.gospodarek@broadcom.com>, mef@scarletmail.rutgers.edu,
 paul@jakma.org
Subject: Re: [PATCH net-next v12 00/15] net: introduce QUIC infrastructure
 and core subcomponents
Message-ID: <20260602111823.0b1129d6@kernel.org>
In-Reply-To: <CADvbK_fBbLCwY61HXsNeGCA8MhiBKcbvE0BvSZppohJgtXO+2g@mail.gmail.com>
References: <cover.1780232930.git.lucien.xin@gmail.com>
	<CADvbK_fBbLCwY61HXsNeGCA8MhiBKcbvE0BvSZppohJgtXO+2g@mail.gmail.com>
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
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:quic@lists.linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:metze@samba.org,m:mbuhl@openbsd.org,m:tfanelli@redhat.com,m:hepengtao@xiaomi.com,m:dreibh@simula.no,m:linux-cifs@vger.kernel.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:steved@redhat.com,m:hare@suse.de,m:aahringo@redhat.com,m:dhowells@redhat.com,m:matttbe@kernel.org,m:mail@johnericson.me,m:xiyou.wangcong@gmail.com,m:alibuda@linux.alibaba.com,m:jbaron@akamai.com,m:illiliti@protonmail.com,m:sd@queasysnail.net,m:marcelo.leitner@gmail.com,m:daniel@haxx.se,m:andrew.gospodarek@broadcom.com,m:mef@scarletmail.rutgers.edu,m:paul@jakma.org,m:lucienxin@gmail.com,m:xiyouwangcong@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,google.com,redhat.com,kernel.org,samba.org,openbsd.org,xiaomi.com,simula.no,gmail.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
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
X-Rspamd-Queue-Id: D5E50631001

On Tue, 2 Jun 2026 09:12:30 -0400 Xin Long wrote:
> Note: I've run Sashiko on this patchset many times locally over the past
> month and addressed all the real issues it found. I don't see any new real
> issues being reported on:

Coccinelle had a report tho:

The NIPA CI coccicheck run flagged a new Coccinelle warning introduced by
this patch:

  net/quic/crypto.c:1164:13-20: WARNING opportunity for kmemdup

At line 1164 of the newly introduced net/quic/crypto.c, there is a
kmalloc() call immediately followed by a memcpy() into the allocated
buffer.  Coccinelle's memdup checker suggests replacing this two-step
pattern with a single kmemdup() call, which is the preferred kernel idiom.

The fix is straightforward - replacing:

  p = kmalloc(len, gfp);
  if (!p)
      return -ENOMEM;
  memcpy(p, src, len);

with:

  p = kmemdup(src, len, gfp);
  if (!p)
      return -ENOMEM;

Please update the patch to use kmemdup() at that location.

