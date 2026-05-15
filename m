Return-Path: <netdev+bounces-288443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK2LBSGAB2qQ5gIAu9opvQ
	(envelope-from <netdev+bounces-288443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:20:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B39115575FF
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C29D73035B68
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CC939183C;
	Fri, 15 May 2026 20:19:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F039184B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876387; cv=none; b=JT9AMMgZ+mBfADYXtSPnVNBBQcRX/bfzs6xTzX5Ri8H53NrPORR08xRYlWZTPeR8+FUodGGipnsSTF526/YKE40JrtT+F8E00E1P9QXP3EcHLa1ZuCtHpbJysIzykMIiHHDXVKXGSgYRGwE0zUPZIII3S+EQVOyf6eYEw2T8YU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876387; c=relaxed/simple;
	bh=Q28j9z8dp3oa7JMWHW9YFacpLH2Z814ez5zEJhieN9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zi8Sj0AQ6O0NaJtI/Ezz3wEJKZmceRAe/hiCYKTDKaAbppDQJ9l71ahdh0/i59CUc0sYJJBqkd03/+XDZ9vTDxLdZmw0Hr+26VCyNrm2pw/j30kSQLMSh4pieZUahmcEwQoWdROb20JVbT/ta3tT7+HzCp5kCunWMOJX0kL2Bvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso1535165e9.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876384; x=1779481184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N3vmZN+/CLFfYNwXnxNj1H7df8GenR+J9C9ZLO0cmvk=;
        b=mtyi0pllXUNIlysw/6d1MP1sJOWgJGjJcW4s3xp96j1MgilY9VtMDGSo6A5mi652wz
         Cas4jGsOo5NhGd4RFL2P/TtO6X/BWuV8i1yh79d3zpjZJ9g3xPmEOBBFnDx8m8emhGTE
         MgtWSB45a8dlAUh2skt0oR5whm2JvymDvVVk63qIe40OJd7Nyu/XcBiZVdfshhQr5DpI
         s7+L1aqtsROJRkct5f67lZoqQ+GGuOAm8C8IbWjwVH4vBLB8l9gEre47Edecuv3FNbTq
         9bkpANLLF3P9mWl2RfqVlQv6JiTGiFqsoIq6I8s+RvLCUa0P7Cgisfv3yMB0oEWh98Kh
         Xpig==
X-Gm-Message-State: AOJu0YzFmFxGrdvTD/5QctTabEi5PfqAO7cmlXUor4J9bHxlWfL5DFxm
	0E6cGXdz566RHiavoQESwCdeXHP8ZV/aPD+MEWj8Bpt2eB1XCyHqxcRfKJJpJ0BM
X-Gm-Gg: Acq92OEBko1rloLHVDpG+Jhi8YvuE8d6wA6aBVK6y1EvpmCUAYkf3fthVmVNDr4rEEB
	1ETaBWu5Ry5Umz/G80bLsRj8pa4YDch7rTvytaeBCHfc1lkgd7fN8Ngx1gYLn3Cq9+cUoC7sw3g
	LODhn9EMx/iezl5dfXyIzOj8oyOmpCYIY01IpaGqi/2US1SgF9s9qqAE62ygfbhwvlmUBYlV2wZ
	fGqNCawstrTHubuXLWKyGuSTG2R0ASzOurW+tkXDEkEwqJLE/QuUkd0H+fJ+khw1nG0On+skzaL
	H78u2qmIC5n/jCpc5smJc6wqiYnXIiW5kUz6xZDAsf9ju7t840jXeVDEqVe0YHB3TjwbxCuQL6d
	YzWQ2orTEgSLOrn4aT4eeau7UnvtNWcV0IPDJ1QlEieSnez2aZ+uf41NaPqfhFRh4nrJUrWicjx
	gx1MImI+1zZsgMCLKhD8NubpQaVM4Bjm94DGcgjye2UsOn3ODgRPlnAXm0fmE=
X-Received: by 2002:a05:600c:3b27:b0:48e:7854:1608 with SMTP id 5b1f17b1804b1-48fe6516b54mr70915975e9.25.1778876383868;
        Fri, 15 May 2026 13:19:43 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2896bsm22924605e9.4.2026.05.15.13.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:19:43 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Jiri Benc <jbenc@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matteo Perin <matteo.perin@canonical.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net 1/5] net: rtnetlink: fix link nsid reported when the link is local
Date: Fri, 15 May 2026 22:19:20 +0200
Message-ID: <20260515201937.2813983-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515201937.2813983-1-i.maximets@ovn.org>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B39115575FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288443-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,vger.kernel.org,canonical.com,ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:email,ovn.org:mid,canonical.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

For most netlink replies and notifications the expected behavior is:

- if NSID is not reported, then the device is local to the querier.
- if NSID is reported, then the device is remote, i.e., located in
  the provided namespace that is not the same as the querier's.

Userspace applications like ovs-vswitchd expect this behavior.  And
ip monitor uses this logic for printing out [nsid current] vs [nsid N].

But this doesn't work for link nsid in cross-namespace RTM_GETLINK
requests.  For some reason the code checks if the original device
and the link are in the same namespace and not if the querier's
namespace is the same as the link's.  So the logic becomes:

- if NSID is not reported, then the link is in the same namespace
  as the queried device.
- if NSID is reported, then the link is not in the same namespace
  with the queried device.

If the link is in the same namespace as the querier, the code will
allocate a self-referential nsid for the querier's namespace and
report it as a link nsid.  This is problematic because:

1. Application doesn't expect to see nsid reported for its own
   namespace.

2. Application can't know if this nsid is the nsid of the current
   namespace without making extra requests.  So a lot of extra
   logic is needed to understand if the link is local or not.

3. Implicit allocation of self-referential nsid for the current
   namespace affects notifications on sockets listening on all
   namespaces, since this nsid is now reported in every notification.
   And so those notification handlers also now need extra logic to
   understand which namespace the events are coming from.

4. A seemingly read-only RTM_GETLINK request for a different namespace
   allocates a self-referential nsid for the current namespace, which
   is a little unexpected.

Let's fix that by applying the same rules to cross-namespace requests
as for standard ones, which is:

- Report NSID if it is different from the querier's namespace.

This changes two things:

1. If both the device and the link are in the same namespace which
   is not the querier's namespace, the LINK_NSID will now be reported.
   This just gives more info and the user can check if the reported
   id is the same as TARGET_NSID, which is in the same message.

2. If the link is in the same namespace as the querier, but the
   device isn't, the LINK_NSID will no longer be reported.
   This is the main change, as previously this would mean that the
   link is in the TARGET namespace, but now it will mean that the
   link is in the SOURCE namespace.

There are no changes in logic for queries that are not cross-namespace
queries.

A research across open-source projects doesn't show any projects that
rely on the things that are being changed.  I couldn't find any
project that uses the reported LINK_NSID with cross-namespace requests.
And no projects that use cross-namespace requests seem to even parse
the reported LINK_NSID.

Of course, that doesn't mean there are no such applications, but the
current behavior feels like a logical bug that IMO should be fixed,
otherwise it's hard to use all-nsid sockets properly.

Note that the logic for notifications in rtmsg_ifinfo_build_skb()
remains the same as those are formatted from the perspective of the
namespace where event occurred, i.e., they are always "local", but
then distributed to sockets listening on all NSIDs with extra metadata
pointing out the original namespace.  And users need to translate
the reported NSIDs to their reference point.  While RTM_GETLINK
always reports NSID from the querier's reference point.  Hence the
reason it should not be reported if it is the same.

Fixes: 79e1ad148c84 ("rtnetlink: use netnsid to query interface")
Reported-by: Matteo Perin <matteo.perin@canonical.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index df042da422ef3..0d539b8e4bf61 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1881,7 +1881,7 @@ static int rtnl_fill_link_netnsid(struct sk_buff *skb,
 	if (dev->rtnl_link_ops && dev->rtnl_link_ops->get_link_net) {
 		struct net *link_net = dev->rtnl_link_ops->get_link_net(dev);
 
-		if (!net_eq(dev_net(dev), link_net)) {
+		if (!net_eq(src_net, link_net)) {
 			int id = peernet2id_alloc(src_net, link_net, gfp);
 
 			if (nla_put_s32(skb, IFLA_LINK_NETNSID, id))
-- 
2.53.0


