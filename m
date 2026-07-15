Return-Path: <netdev+bounces-307752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PwIGKnGFV2qqWAAAu9opvQ
	(envelope-from <netdev+bounces-307752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:04:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 119BB75E710
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:04:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=plantwatch.de header.s=uberspace1 header.b=oHDJKvJQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307752-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307752-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99DAD3113D64
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578A947DFA7;
	Wed, 15 Jul 2026 12:55:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out03-fra1-mx.uberspace.de (out03-fra1-mx.uberspace.de [185.139.157.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0247DF85
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:55:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120116; cv=none; b=qdiRhnImIajJWMOPhpCtQGrO8KWozK5/Z/WjtJIPqNlwqtNlQ78OH91gzMBENdDp0Oj1HZD7Y5+Us5se912mswP09RZERKbCkIhuqAcxftKPrDvobS3WJhX4ZB/Nzjtupu27jnjLWC70/556Y3vKWWbixpAvRKdJU5wuhiKQwlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120116; c=relaxed/simple;
	bh=1yYXVjBEDtfrF8R0fB7yCTQ2qrC+ru2vfR4ouNj0MwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOsgun4SBv9/gCpOKnRBZ3/zhsSuJo/oSoSGe6E++BXMHAKPyxglnMM8ulDGDIipI51Zpt/Gp/2gJJfCi58Dw9+R6u+Qoyvyt4mBwUHaHhZvORTDkfUyDUqkB2wTGonnNHt4kRlb412Fi+NTda9imPEs7t6mBhclWgtLKPMz7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plantwatch.de; spf=pass smtp.mailfrom=plantwatch.de; dkim=pass (2048-bit key) header.d=plantwatch.de header.i=@plantwatch.de header.b=oHDJKvJQ; arc=none smtp.client-ip=185.139.157.46
Received: from janus.uberspace.de (janus.uberspace.de [IPv6:2a0b:20c0:2000:62:be24:11ff:fe50:5107])
	by out03-fra1-mx.uberspace.de (Postfix) with ESMTPS id 5FDC5100065;
	Wed, 15 Jul 2026 14:48:47 +0200 (CEST)
From: Simon Dietz <simon.dietz@plantwatch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plantwatch.de;
	s=uberspace1; t=1784119723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jc4Ytkf9DX6t7CuOKJQGJecERCbrBWrFuvnNRgT8cFQ=;
	b=oHDJKvJQmHNoKAZA/GyG6JrCtbPhW44rzyE9jvF8y1zlNRY4q/G+Y7+15d6VEZBdx3hehF
	/sEfETDBM3NhV3xuCNyOrbEG/cWX29K5if/GUvZwioY/I1izf9JslohGb62PDhjk1vvemq
	hAwx6QUX+HjyXij+sHtHAIOLVOEP0sllwZk0yB3mrMWlyjvPft+q1tYM2YapFxqHN1AjTu
	5ACH4cpVkZh5HtSIhOoPIiBgcKauP30kVsHqQ7p1e1lMzafCZM5AZu+mMCJ5hh7mDBJBfb
	6cnC9LeyKFoks6EPYPHe/AwWqxHhw6OWXlSjspLIy8YKKi+uMJ9qQ7hb33Cz0A==
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuniyu@google.com,
	simon.dietz@plantwatch.de,
	dietz23838@hs-ansbach.de
Subject: [RFC PATCH net-next 0/6] net: add GeoNetworking protocol
Date: Wed, 15 Jul 2026 14:45:40 +0200
Message-ID: <20260715124548.509568-1-simon.dietz@plantwatch.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[plantwatch.de:s=uberspace1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307752-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:kuniyu@google.com,m:simon.dietz@plantwatch.de,m:dietz23838@hs-ansbach.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[simon.dietz@plantwatch.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[plantwatch.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[plantwatch.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.dietz@plantwatch.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.com:url,plantwatch.de:dkim,plantwatch.de:mid,plantwatch.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 119BB75E710
X-Rspamd-Action: no action

Implement the GeoNetworking / ETSI ITS-G5 ('net/gn') protocol which
is based on 802.11p wifi and used for vehicle2x applications. It is
standardized by the ETSI and used by some car manufacturers
(especially in europe). It enables ad-hoc, multi-hop geographical
communication and routing among vehicles (and road- or railside
infrastructure).

Most work of this implementation has been done by the bachelor
project 2018/2019 of the operating systems and middleware group of
the Hasso Plattner Institute, University of Potsdam, which the author
was part of.

The project was supervised by:
- Jossekin Beilharz
- Lukas Pirl
- Prof. Andreas Polze

The code is published under the GPL v2 at this location:
https://gitlab.com/hpi-potsdam/osm/g5-on-linux/linux-geonetworking/

The original code base was based on linux version 5.1. The first patch
includes the original codebase rebased to the current net-next code
base so that it compiles under current net-next (as required by
submitting patch guidelines in order not to break git bisect). I've
backed up a not squashed version of this patch series if a more
compartmentalized history would be desired.

The subsequent patches address bounds, null, empty checks, memory
safety, locking, code style and ETSI standard conformity improvements.

This patch series is not merge-ready, yet. E.g. network namespaces are
not supported at all, documentation is missing, ...

Purpose of this RFC is to determine if GeoNetworking support in the
linux kernel is desirable and if so what steps would have to be done
next. There is ongoing research on the topic vehicle2x, which may
benefit from GeoNetworking support in the Linux kernel.

Greetings,
Simon

Simon Dietz (6):
  net: add GeoNetworking protocol
  net: fix GeoNetworking
  net: further fix GeoNetworking
  net: even further fix GeoNetworking
  net: add ppc64 support for GeoNetworking
  net: apply RCS to GeoNetworking

 include/linux/gn.h                  |  349 +++++
 include/linux/gn_routing.h          |   68 +
 include/linux/socket.h              |    6 +-
 include/uapi/linux/gn.h             |   84 ++
 include/uapi/linux/if_ether.h       |    1 +
 net/Kconfig                         |    2 +
 net/Makefile                        |    1 +
 net/gn/Kconfig                      |    4 +
 net/gn/Makefile                     |    8 +
 net/gn/gn_proc.c                    |   86 ++
 net/gn/gn_prot.c                    | 2012 +++++++++++++++++++++++++++
 net/gn/gn_routing.c                 |  632 +++++++++
 net/gn/sysctl_net_gn.c              |   33 +
 security/selinux/hooks.c            |    5 +-
 security/selinux/include/classmap.h |    3 +-
 15 files changed, 3290 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/gn.h
 create mode 100644 include/linux/gn_routing.h
 create mode 100644 include/uapi/linux/gn.h
 create mode 100644 net/gn/Kconfig
 create mode 100644 net/gn/Makefile
 create mode 100644 net/gn/gn_proc.c
 create mode 100644 net/gn/gn_prot.c
 create mode 100644 net/gn/gn_routing.c
 create mode 100644 net/gn/sysctl_net_gn.c

-- 
2.55.0


