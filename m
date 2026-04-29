Return-Path: <netdev+bounces-282425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPxbH4Ii8mlmoQEAu9opvQ
	(envelope-from <netdev+bounces-282425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:23:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EABD496C5E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF4EA3008E25
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44334D4EA;
	Wed, 29 Apr 2026 15:18:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5237757C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475887; cv=none; b=EvvtgK28Od0A8yzsNaDxSYKbxhW8MvEId2nx+NdDKIyNxw4ph8FJkVFSIdaEootQe0mAaA4gPUmKcDHltg0f1xg2pl1V/FAlouie7Hj9md+Ws+2AtHTvNSKbIkURrgogrSNwt8Gd5yEWRWuX95ct6cxGguSpmNr8ivvB7D4JnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475887; c=relaxed/simple;
	bh=Spbw5+FwnAD1Te86LZRFTidv12kPXHlIeSpjbXHRsAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbVXNQPsmZOb/1oZn0yNZ7luCjB3zSH1Yv6scXJUOx/bYmPrM+9jBi+97u+86REzs1U3hoqz++yg8ZRqwHanfsQ8HvllhzDsLNFu91NtWFa30zvnNxDejK4tFTgMjRX4dpVm/uJtt8KAIZowpXfdiNGYzQPAMpluDIpVsgHE32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso68959775e9.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475883; x=1778080683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6g3lBM/B1h9yI4BCUe+xp9frAHx+qvXrSW9JLGyPZkQ=;
        b=IN1JgtUCkvYnN0ryJB1zclmq3lmy2a8LVf/BGZLGZISDyYz2rpuc2TbPW3buFPgZgl
         10gfzJL2I7e5jJf5MqSH/CXDaYLGFe+kJMHox53MT8I+y3IMrnmYiQhvIQkdtQzQ2ZyQ
         jEAgYBOkDxIytoLtwyg6clWRHW+iNFIX0/UNq9lNNziAsmonj0P0btyu17QBWRDaA6gg
         Q0UOsAoZyJqv+xce8fhLRqKoMYS+64xmhFs+cQJ29dMoLUjADORBZZsE/v6XiHgeQJ1a
         /MsvRfEm68PUNlY68lqiNFiFOC7FzTSumTgD9IhXaQrJ20b04GXRfPIty6mvZQxZbL5l
         LZDQ==
X-Gm-Message-State: AOJu0YxkiawJFyq/IcLiDUdJlLR6ruaF0XmY86ruLWqgAMmHR4yAbC1x
	n1/OgoOvRhddAlrMMBNCqSSEByzAf8PGcZJNK/6fjNBQFMCW257mIH0+mxwOYAm9YBQ=
X-Gm-Gg: AeBDievgPyy4jC8YweQ82fZqFbzVyL+PggzxZlzKDO326hY9EjB3fW5VhQ5M0nvuzLL
	7FWTSBlngnxvRpAr3C73b0a3cHZSXGIg+p1ln8HYU9UhVeokVJjCW0KXa7rGSv/kUtBu3zYLh2N
	J9ZPvZ70dicodwMayWNcN0bQsvRj1hvL1VY5NSP+S8XRHyfmbrgKwAUAXEjSPAz2n3QoHT2nlPQ
	6OpKw4eesxuGiq4QXxuSanVkayl1S0zNoqZixcfSfx/AnfUF25dLKza8cBjq9AKHPJGiZZlA/e8
	C1GirW+i+HPJANs5qSZZ1z2XZjiCq2umWcPm9t3s6sII2BI5AB0N6rvABSlXHBs5hyklSeUaWro
	2LVKQHyota5yXjNxVXpcTQ86dQP0M2SEZ5nvesfwTk3VtBRdVJrnxl6/HDuHvj+/Q1MxZnzXvID
	oxri+x5671Tc/S4JknP8iEUyTDKB01eYvRCG0oCb17jwVXpPnALuKQ3YWWKmO9Itp44e9gjg==
X-Received: by 2002:a05:600c:a110:b0:489:1f3e:5f69 with SMTP id 5b1f17b1804b1-48a77b176f5mr97415915e9.18.1777475882817;
        Wed, 29 Apr 2026 08:18:02 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2d3811sm32358165e9.3.2026.04.29.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:18:02 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuan Tan <tanyuan98@outlook.com>,
	Yang Yang <n05ec@lzu.edu.cn>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net 0/2] openvswitch: fix self-deadlock on release of tunnel vports
Date: Wed, 29 Apr 2026 17:16:35 +0200
Message-ID: <20260429151756.4157670-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1EABD496C5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282425-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org,vger.kernel.org,ovn.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.548];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ovn.org:mid]

Two patches - the fix for the actual bug and the selftest that reproduces it.

I missed the self-deadlock in the original patch that introduced the issue,
because testing required code modification in the ovs-vswitchd to force it to
use legacy tunnel ports.  I thought I made the change correctly, but apparently
something went wrong and the tests were run with the standard LWT infra instead.
The selftest added in this patch set will at least prevent this kind of mistakes
in the future.

I mentioned, however, that these tunnel vports are legacy and not actually used
by ovs-vswitchd.  RTM_NEWLINK + COLLECT_METADATA is used in conjunction with the
standard OVS_VPORT_TYPE_NETDEV instead since 2017.  The code to use the legacy
tunnels still exists in ovs-vswitchd however, but only as a fallback for older
kernels and we're planning to remove it in the next release.  I'll be sending an
RFC to remove support for these legacy tunnel types from the kernel, as they
serve no real purpose today and only increase the uAPI surface for CVEs, but
we need to fix the known bugs for stable versions.

Ilya Maximets (2):
  openvswitch: vport: fix self-deadlock on release of tunnel ports
  selftests: openvswitch: add tests for tunnel vport refcounting

 net/openvswitch/vport-netdev.c                |  6 ++-
 .../selftests/net/openvswitch/openvswitch.sh  | 37 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 10 ++---
 3 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.53.0


