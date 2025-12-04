Return-Path: <netdev+bounces-243542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3C0CA3527
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 11:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A2C302A940
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 10:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B9C3321CB;
	Thu,  4 Dec 2025 10:53:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD02E88B6
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764845622; cv=none; b=SAkJziC71ONKyN4M+XSd3lvRSrfh/oswkHUqpD3GkFFN872Rfy3FfNFmHhzQjEA9gGAV/WObNz7IlTc33yg+nzpc5tLOMEEG5LlLRlIDf8ASgkuUsJ8tRgqRl1g1p3ULaLjOF8A6hmfa4XhwASlmAsktdP9nog7pzIBdX0AyqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764845622; c=relaxed/simple;
	bh=16I3nDkcBxbvAtXGuiPo2PT/0oTSTuFMTpI9q6cIE/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YxGW934UEKdtsijasb3X8Lyd5TNEJZHceVBZDeokK+EJxQccKdbvb23o3yrhoyQFjytKGu0s6JgP12yzp7Hj48MzFO8eXNstJ6TIEwtesJZ5X3CJaDFX+xZU32vbBSqWx4puB1EadrAGXRR9WPnLOoqfPmYCuhUA9E4PayOQ9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b73875aa527so113317466b.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 02:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764845618; x=1765450418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDQlS2Gh60c2v9LmiNdNdP2rU4QdLL80GBdE/ODSzRY=;
        b=sWh5bpT0YY5x+yOuWOg4EwF5Oj57XXtDN+gNlOdvJkOMiQbKGoNb0k7EUs6Tb0KVNs
         qoC2XbJ7k5oe1vyQuVAF/6hP5cw7T3GQPfQzbTMgarjijIab2b3O+NYlUkArhYg76xT1
         nXptht/u5IGLBnQGzvv9IwmjRt63dEg3wrDAIcks8I3wYK6pCr9PKaVfcSKtobkY/X/A
         yNgt1boL/v9ZOTOjY+YM/4TSA5BOCvl7u/3f3EsNGJHloAqb8tGxla0T9qr/rdVDb4tq
         VMp+M2wz8A21at+xMlfgiZcrZ4V+Ia+Vb2AAKgnxQi86EFAGgWVo+YGnfrl4zHuk+Slw
         WoGQ==
X-Gm-Message-State: AOJu0YwjaZv+xi5hiSMJTwWP/dejvgoMfPjft5okowri/MUX/bDEK0gU
	k5BEVZRRIQknYW6zvTTuY6+eH5bl3lfHcT7Twm+TSpYAwa+YivrlggftEnZcdh41
X-Gm-Gg: ASbGncvjCD2taJt9i0TGK5Gb6xZOgXZEsPAYg9d6J3dJCXH+HV4tV2pY8NZJrcyF5Cr
	j7W8Uu4I5XXN1NEccbzzs+tTdNvNtVZvWKpn/1XTFyd5HnwNiwzDnxaSY8lbV0f/sOoTA5Bvx9K
	RFJqO99GtD2uNJqw+QlUPx79HBJ+uRBofPaRUR8o5CYSDvfnZMN8zdopsceJL7HZL02C6xR9RyZ
	OFRS+++tJwaBzWKNT4B2COBcEXQrxVpBRgwOM/HnmVy8+yZOi87bft+RFshdLYOfrAVxBoa/rU8
	Fua3v5D9d1nHPs/1GCVpNDFsiX6PtN8HVvuDpNRhGjBB+LfKyKajUTNQEMB3FJ458nl2bD55xZC
	svnInzuYtrq3Rd7OvhRU8Pt9li2dh16f7oXjVIXfncYHCAyJJi00Q2a9Ay0mo+c4O70XTqcepP1
	/wIdeOWEOos4oczDS8KDTkp2XJD9IxiKhzAMYylw15UZ3Y
X-Google-Smtp-Source: AGHT+IF3aan31pTIo6uyN/oe6VyITLYnu9MjmTjOZ5Uj/0kxgpfK33GFdR3nXh5J1r++CztSiGlWGQ==
X-Received: by 2002:a17:907:1c21:b0:b72:91bc:9b35 with SMTP id a640c23a62f3a-b79dc51d9b3mr502026166b.39.1764845617550;
        Thu, 04 Dec 2025 02:53:37 -0800 (PST)
Received: from im-t490s.redhat.com (89-24-32-14.nat.epc.tmcz.cz. [89.24.32.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f426413esm111389966b.0.2025.12.04.02.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 02:53:37 -0800 (PST)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Willy Tarreau <w@1wt.eu>,
	LePremierHomme <kwqcheii@proton.me>,
	Junvy Yang <zhuque@tencent.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net] net: openvswitch: fix middle attribute validation in push_nsh() action
Date: Thu,  4 Dec 2025 11:53:32 +0100
Message-ID: <20251204105334.900379-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The push_nsh() action structure looks like this:

 OVS_ACTION_ATTR_PUSH_NSH(OVS_KEY_ATTR_NSH(OVS_NSH_KEY_ATTR_BASE,...))

The outermost OVS_ACTION_ATTR_PUSH_NSH attribute is OK'ed by the
nla_for_each_nested() inside __ovs_nla_copy_actions().  The innermost
OVS_NSH_KEY_ATTR_BASE/MD1/MD2 are OK'ed by the nla_for_each_nested()
inside nsh_key_put_from_nlattr().  But nothing checks if the attribute
in the middle is OK.  We don't even check that this attribute is the
OVS_KEY_ATTR_NSH.  We just do a double unwrap with a pair of nla_data()
calls - first time directly while calling validate_push_nsh() and the
second time as part of the nla_for_each_nested() macro, which isn't
safe, potentially causing invalid memory access if the size of this
attribute is incorrect.  The failure may not be noticed during
validation due to larger netlink buffer, but cause trouble later during
action execution where the buffer is allocated exactly to the size:

 BUG: KASAN: slab-out-of-bounds in nsh_hdr_from_nlattr+0x1dd/0x6a0 [openvswitch]
 Read of size 184 at addr ffff88816459a634 by task a.out/22624

 CPU: 8 UID: 0 PID: 22624 6.18.0-rc7+ #115 PREEMPT(voluntary)
 Call Trace:
  <TASK>
  dump_stack_lvl+0x51/0x70
  print_address_description.constprop.0+0x2c/0x390
  kasan_report+0xdd/0x110
  kasan_check_range+0x35/0x1b0
  __asan_memcpy+0x20/0x60
  nsh_hdr_from_nlattr+0x1dd/0x6a0 [openvswitch]
  push_nsh+0x82/0x120 [openvswitch]
  do_execute_actions+0x1405/0x2840 [openvswitch]
  ovs_execute_actions+0xd5/0x3b0 [openvswitch]
  ovs_packet_cmd_execute+0x949/0xdb0 [openvswitch]
  genl_family_rcv_msg_doit+0x1d6/0x2b0
  genl_family_rcv_msg+0x336/0x580
  genl_rcv_msg+0x9f/0x130
  netlink_rcv_skb+0x11f/0x370
  genl_rcv+0x24/0x40
  netlink_unicast+0x73e/0xaa0
  netlink_sendmsg+0x744/0xbf0
  __sys_sendto+0x3d6/0x450
  do_syscall_64+0x79/0x2c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>

Let's add some checks that the attribute is properly sized and it's
the only one attribute inside the action.  Technically, there is no
real reason for OVS_KEY_ATTR_NSH to be there, as we know that we're
pushing an NSH header already, it just creates extra nesting, but
that's how uAPI works today.  So, keeping as it is.

Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
Reported-by: Junvy Yang <zhuque@tencent.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/flow_netlink.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 1cb4f97335d8..2d536901309e 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2802,13 +2802,20 @@ static int validate_and_copy_set_tun(const struct nlattr *attr,
 	return err;
 }
 
-static bool validate_push_nsh(const struct nlattr *attr, bool log)
+static bool validate_push_nsh(const struct nlattr *a, bool log)
 {
+	struct nlattr *nsh_key = nla_data(a);
 	struct sw_flow_match match;
 	struct sw_flow_key key;
 
+	/* There must be one and only one NSH header. */
+	if (!nla_ok(nsh_key, nla_len(a)) ||
+	    nla_total_size(nla_len(nsh_key)) != nla_len(a) ||
+	    nla_type(nsh_key) != OVS_KEY_ATTR_NSH)
+		return false;
+
 	ovs_match_init(&match, &key, true, NULL);
-	return !nsh_key_put_from_nlattr(attr, &match, false, true, log);
+	return !nsh_key_put_from_nlattr(nsh_key, &match, false, true, log);
 }
 
 /* Return false if there are any non-masked bits set.
@@ -3389,7 +3396,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 					return -EINVAL;
 			}
 			mac_proto = MAC_PROTO_NONE;
-			if (!validate_push_nsh(nla_data(a), log))
+			if (!validate_push_nsh(a, log))
 				return -EINVAL;
 			break;
 
-- 
2.51.1


