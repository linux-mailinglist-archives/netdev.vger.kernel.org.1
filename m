Return-Path: <netdev+bounces-278590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E4BK+XM3mnnIQAAu9opvQ
	(envelope-from <netdev+bounces-278590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:25:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4883FF070
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F953014131
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 23:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF253B3C05;
	Tue, 14 Apr 2026 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOZqvDjY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65847389114
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209080; cv=none; b=kzCN5En4iKf8bRyjN/J/rCWQIqJTnZu1dIrGDHrWSb108p5P1uSLb3T8R65+1bM62hvK+NhLmuJAjtsSEgNdcqYQn7Eyc7WwLPgbA7BJL1jo0/qDrDJlaGAU6elWwW3XeZ2IzRajmMDiF2WhfQv7r+fO1OGpg8h0t3otI/gIRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209080; c=relaxed/simple;
	bh=wUdrK1aGS/ciJ2GUT+QYJzMtHSiDuIhpn1b9a6dvf4E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mvLFA/iWAIZM+yd8wBMRtW4gW9eWzMxUrXxQTGnEQ+g9QcBIrFGXrEMNQw6b1Qirq4ySkgsQGh7LTDV6jKLGQIYbN6ok9NHCeOEOEqW1nuILYtLLAStqh9eFuCTYOg+mieP+nFVgtfH579Ze60vcSXNV6OBtjIOHMwzYNYOXPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOZqvDjY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9841aecf72so784694966b.2
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776209077; x=1776813877; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EoT7jyah6WMfEESCKOYLl5fVA/kN0jcFgC5b53AGC0I=;
        b=nOZqvDjYCblrr4EOg3zt8hFtm+EAzpl471tAaBJAxOu8rkowvrmwYm5ngef/MzREA6
         dWjyezmzdE6S0uxTH2a89lhpDxgqNDDZBFuzRf0ZRfqgUOSXLGp9nw6mvnk5ciOeb/Yj
         4Jc1v9iNPPZYN6PpaV/o3JlNfqlD3VlhispEP8D5tgUyg/YZlVypPw0Dog9/tpeM7pe6
         VOaAo+oKgTMmg1NqZDC+sKr613W4szNaGI3HngFwh3dhn8uMurzDmn2nHAHJ5XmPlBGm
         D8soztRQRgThgzfTst3fov0NYFq1tY8r8ID5m3IREM0/Is7kChvwJgKaeJMNtNLxAB8u
         zWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776209077; x=1776813877;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoT7jyah6WMfEESCKOYLl5fVA/kN0jcFgC5b53AGC0I=;
        b=PEBDAGD51w5YJeYrNIwsOIlKIWkXcvnsfYYFbv0E7rOjK37METL7szU9k4FBNYX/qu
         joXjYWtFMUwHvqLgNvSa2dy0l40nmK6KxBw5hpap8IE9QBVJD4VTATaFkaTc+MHnNR9e
         sGyzNbt5WavqjPiNKPt6X9vdyCr7WS8RVmmj0wbWMK8qicTGoTt7b5LKFAH+gcV1a5zO
         9Q3KnGl9cUwMGO32C3iVb8clBPa5uAyHv/XA629WXVKmnEfNR1hVdA8a40OvONr8LaMB
         mn2GDhaR8Et2EqO74zE1T+9QWCJ9PAOjynkCq1xjJLK0v3o9jdOkcSYTqUVDxziH1Bgv
         1STA==
X-Gm-Message-State: AOJu0YyGT40RB+tlvkeIAbqTKfg3e45mgwCmyvxQ7P6OgkEvo18aVXrV
	R5rY5AdF1tFsvFIk/l0mPPpQ2lVtYGpJcMyeiDlPYrldrS8XYruo04wDq1y/e/tY
X-Gm-Gg: AeBDievAgzbuw0U0i21fcwngLpU2FBDHUwwrbctUO/+eInIhuAsBnQYgfb+rE+eDIDd
	1yhDPHsZMqV05aYsqlDt+4FWRHNt17r/lRuGO3E9EqNWzZ5CK9sgrsTTk50qlPe+QZS/K5OU2Ja
	OFN8quBVU2b3jP1iDMMbDrT0pXvc5xBhpDZ45eKdFgNi5TRyzExfJUlPg9ZznFwCMWpUURC0sXi
	q/7MwP8hSMHdxan6/DssB4OFUJxNHlOejQHEWrYEwK8JkjbT2aFNgDUqoWCFHp1b9wtxVDJc2DT
	BZvBaBMcQdABBH7a+U6urPJZLHX+3dMlilUrjiLIG+vtCxbdlK+Fef+BtHMmKzHv9ToUePWWzVW
	4p+3WH4oQT3K29qHLTYtY+fyUcViCo2E4fsmwtyfSQ9AuUbxvwrFO8Oe9o15neZRed41Nefd0KF
	dDCIJ/n5ljK3qCkJ1jiokK1VFe7dUXlo3B/rWRLYVmEqb6bPRybQTM0/dopwNKGdjIQ+Mw0DA7w
	/OD
X-Received: by 2002:a17:907:c80f:b0:b98:45fc:241d with SMTP id a640c23a62f3a-b9d7267e5bamr1145215666b.37.1776209077512;
        Tue, 14 Apr 2026 16:24:37 -0700 (PDT)
Received: from dau-home-pc ([185.229.191.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f1a3bsm434032966b.62.2026.04.14.16.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 16:24:36 -0700 (PDT)
Date: Wed, 15 Apr 2026 02:24:33 +0300
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH net-next 0/2] udp: fix FOU/GUE over multicast
Message-ID: <ad7MsSJOuUU6EGwS@dau-home-pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-278590-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F4883FF070
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

UDP encapsulation (FOU, GUE) has never worked correctly with multicast
destination addresses. When a FOU-encapsulated packet arrives at a
multicast address, it enters __udp4_lib_mcast_deliver() which calls
consume_skb() on packets that need resubmission to the inner protocol
handler, silently dropping them instead.

The unicast delivery path and the GSO segmentation path both handle
this correctly, but the multicast path was never updated to support
UDP encapsulation resubmit.

This causes silent packet loss for FOU/GRETAP tunnels configured with
multicast remote addresses. The loss ratio depends on the early demux
cache hit rate - packets that hit early demux bypass the multicast path
and work correctly, masking the issue.

Reproducing the issue:

  ip netns add ns_a && ip netns add ns_b
  ip link add veth0 type veth peer name veth1
  ip link set veth0 netns ns_a && ip link set veth1 netns ns_b

  ip -n ns_a addr add 10.0.0.1/24 dev veth0 && ip -n ns_a link set veth0 up
  ip -n ns_b addr add 10.0.0.2/24 dev veth1 && ip -n ns_b link set veth1 up

  # Disable early demux to expose the bug (otherwise it's partially masked)
  ip netns exec ns_b sysctl -w net.ipv4.ip_early_demux=0

  # Join multicast group
  ip -n ns_b addr add 239.0.0.1/32 dev veth1 autojoin

  # FOU + GRETAP with multicast remote
  ip netns exec ns_b ip fou add port 4797 ipproto 47
  ip -n ns_b link add eoudp0 type gretap \
      remote 239.0.0.1 local 10.0.0.2 \
      encap fou encap-sport 4797 encap-dport 4797 key 239.0.0.1
  ip -n ns_b link set eoudp0 up

  # Send FOU/GRE packets to 239.0.0.1:4797 from ns_a
  # -> without this fix: 0 packets received on eoudp0
  # -> with this fix: all packets received on eoudp0

AI assistance (Claude, claude-opus-4-6) was used during root cause
analysis of the kernel source code (tracing the call chain from
udp_queue_rcv_skb through encap_rcv to ip_protocol_deliver_rcu,
comparing unicast/GSO/multicast paths) and during patch and selftest
authoring. The fix approach was identified by observing that the
unicast path (udp_unicast_rcv_skb) and the GSO path
(udp_queue_rcv_skb) both already handle encap resubmit correctly,
while the multicast path did not.

Anton Danilov (2):
  udp: fix encapsulation packet resubmit in multicast deliver
  selftests: net: add FOU multicast encapsulation resubmit test

 net/ipv4/udp.c                                |  13 +-
 net/ipv6/udp.c                                |  13 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/fou_mcast_encap.sh  | 150 ++++++++++++++++++
 4 files changed, 169 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh

-- 
2.47.3


