Return-Path: <netdev+bounces-281801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLc0BYeX8GmrVQEAu9opvQ
	(envelope-from <netdev+bounces-281801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:18:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3A1483840
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC6DE332E6C3
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8943F0A9D;
	Tue, 28 Apr 2026 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys0dmzq2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05FF32ED2E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374452; cv=none; b=RiDLKdM+ZWfzKhGVC9hButkwCuKTLhiCS6g927DwMF3+w2laXG3QNWZBI6BRE6T2wjxvC/HKVAW8NIhBhfzLE7nOvtBsSCCW3+LXZAbk4a21Vk/7zg3r5lRMdIOdL6Gu0Y93X+gIEgULkO6pdaskdzd4q4Vt9yDEuNBEwtp9i8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374452; c=relaxed/simple;
	bh=o8i2uC1zO/a2xkebuFDYmXGH5i+hiWFwIKkf2xAeZHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jenodjuys2zFzZPwJqQgVctNlAer/p05CmNS6PgCsAVld/Xnyt9wrk4j3yDqY/xUE643NlCZdKV3mEPnVXazzx048Yx51TS+ZND7n+13VFCLRDJ82hZS5PBfYlHfaQwVApIo0bhZImNsD6dOHhuXpVSai/CuRDDDopuZoKbo8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys0dmzq2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82748257f5fso6467534b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777374446; x=1777979246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=winsu62q5y/m4N8BbYwmfb2kAuzIpiVgfaZfSzGuNDg=;
        b=Ys0dmzq2kEmt/rfD7kGSv1AUCdL+lFmRBLqyN3HK/hVC1Whs7WbYmjwoZ8dDRSCzAA
         Ig8U9fNXfwsmQpD/iOL7w1k7QW3XUZj03wiyUfEK1kQ4uq0tHm5dX6XAzpMxG5XlLECP
         TJ07eSekulVIVT763v4LmonkPj8XVhtylK+PteOjJVF2Kzg+Fl19JN3a49irfVTd821q
         a+/VUYIYcv8lmMTL8AE2OyZ+9t8pVxTFrwuS8Wts+zsVQrVL6YD8rZmcrl9CF1xWByWa
         Rd8+meZMJjYzi/XZhTLbvVGI/UFY6jQm9xp3daIwRF1CETbZeafQqjALz7P05Zx/fDpo
         aklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374446; x=1777979246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=winsu62q5y/m4N8BbYwmfb2kAuzIpiVgfaZfSzGuNDg=;
        b=D9TRxogJplf0aB1Q4KhdCTurhSr+vhDVDQhnxWmLnIo1+rj2XGkj+d3RZZ72SjTy7J
         5pqxaRRq9bDHexwu1KBc9RTAN4HY3a/6jqkY8KM0IGJXEngNPEKgPN/ynzBYFtJXNxBg
         8ae5YmnIulE/wYsFqZW0dOcrIkvtrfhMS8kWtBY2cx5y5G5AnMfFd31wuU0hCct3Cp0N
         Xcy4+tvAguxoXJobb7Q6Fj5/qud2DAZw8bEDfTaonlyCpv1Z5vIYaaXYta+IQphIMFPa
         IoKTojfRcNuv/F3akMJdJ3If48UbDvUViNFRMEOBJ7OtlxpRYSk6dda1GjN2uzUZfwfQ
         wwOA==
X-Gm-Message-State: AOJu0Yz+CCEL4mkDcfSJi1N8wcnXXyWIwkwmsOKfi7FZ7LA4ZZqgRoFu
	tdrXWBoATZrdODE/kmc1lzNDT0zolSqT2JPSEi5l69p4nq/KbJeKpwdh1laDXg==
X-Gm-Gg: AeBDies98JFIQLOet+0NZUzAHOSsLGBV37rZ/ii8HobSRdu6wMDqxE0s0WMgf6XGZVh
	avahXZuSb4sr1zstNc4VJ8BltSgOjKNXrRVx4LUGqWf3B/6KpgOrpufDDuclM/PVX+ayHBkm864
	QatYpR0ntrGBdABgRUkuCTzl5mPROw0FJUG636PqgaLQswaPQlrlLFtlHqGJdFi1+s+97vrzP0K
	rEE6eSMGruoTTx/gIaWY0I3Ez+9xNz9F/fLr4WrA9D1lVia9suFo+cE2UaEH+jQWOyGHSnOSimE
	Gc9HyiFs7hO9efgIAXKa5kspBtZybvXLkpyOlg85WBvezYuDk3l/JRi2FVcWXLu/uDDHULgWv8c
	6PLetuLRE4lshaj4Q0Mdwy8QIczP1ccy1+6v0CdzFMSlrh8f/2MnU1frbgkY+by32/YwoJc9Ioc
	/a6W1pfoPWxtyUEwoXg3gtTMSqRKEIvT3ZcCSSh+RCelRX5L05kUTme2IuKEng6npz3gob0g==
X-Received: by 2002:a05:6a20:9146:b0:3a2:d53f:691c with SMTP id adf61e73a8af0-3a39c14961fmr2707035637.26.1777374446370;
        Tue, 28 Apr 2026 04:07:26 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc33d4e11sm2023328a12.24.2026.04.28.04.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:07:26 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	shaw.leon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org
Subject: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
Date: Tue, 28 Apr 2026 19:07:13 +0800
Message-Id: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9A3A1483840
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281801-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ntu.edu.sg:email]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
ip6gre hash via link_net. ip6erspan_changelink() was not converted in
that series and still uses dev_net(dev), which diverges from the
device's creation netns after IFLA_NET_NS_FD migration.

This re-inserts the tunnel into the wrong per-netns hash, leaving a
stale entry in the original creation netns. When that netns is later
destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
slab-use-after-free reported by KASAN, followed by a kernel BUG at
net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().

Reachable from an unprivileged user namespace ("unshare --user
--map-root-user --net"); cross-tenant scope on container hosts.

Note: ip6gre_changelink() (the non-erspan sibling earlier in the same
file) already uses the cached t->net correctly. The bug is specific
to ip6erspan_changelink() copying the wrong shape.

Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link_ops")
Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 net/ipv6/ip6_gre.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index dafcc0dcd..38ac14cc0 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2261,7 +2261,8 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 				struct nlattr *data[],
 				struct netlink_ext_ack *extack)
 {
-	struct ip6gre_net *ign = net_generic(dev_net(dev), ip6gre_net_id);
+	struct ip6_tnl *nt = netdev_priv(dev);
+	struct ip6gre_net *ign = net_generic(nt->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 	struct ip6_tnl *t;
 
-- 
2.34.1


