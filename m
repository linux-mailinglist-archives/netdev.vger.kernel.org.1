Return-Path: <netdev+bounces-282426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEv8A68i8mlmoQEAu9opvQ
	(envelope-from <netdev+bounces-282426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:24:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A45C8496C7F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8838730839CE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660AE379ED5;
	Wed, 29 Apr 2026 15:18:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627B379960
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475890; cv=none; b=EDXD6MD7ek41a5rh5A0H4cyxYovvegHfgPPmDog6mTsVTpxxlnvW50gavkFo5+eKz6KWmFwGoN+M/LJyRA7C5KHeto3kOfvtpEUx3gN87BcRs40KoXEaD+DvNmi6NJIomEtSU6i14Ic2qvyT2oRjGbF5VNShLb/dKJ3ITYt/roU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475890; c=relaxed/simple;
	bh=IcSgz7CPtBhFf1K8izNXcbPchRtKjVsJDl/ciso75PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR/WUjof2rDHhHtxMFHkGQLkAP8e1Iev+kO4mxF7cbRoAX1+AEB+dDWmRLg5xB1g4xCCDJR2SzzT7otC5sEZNcMPJRLXV3HQJRWe3t6bwK36w28iEuiR59h60WpIlXH2LS36bQeHbj/gXruJudBJt0BZXt7k9HgILZ1p0TjRCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso68960125e9.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475887; x=1778080687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wI/PIcTVy7eu/PfacjAoItlkhWbBUZ77v7uqcAyLoWE=;
        b=UXIjYHVp/HBaFWV2HtHevk1zOAy1S9EAMMPFm7YPWVJE0OiSJXX2dxVVOv+6XoynFV
         XcdTlEEKhArWToWKdOtwhouMpiKXPEm27S5q08MRel3hL3G2wjZ0ayoAVI/lYXpmYfHL
         GZR/ybypCSVSKyJ+dG3h4SHkpoAKkOmUrHiOMnmfR8d4DT6M62U8E+2EibBQOT4BxySJ
         bN8X9P6I5Nmico81BdSOHm6Y+KVF7ze2mzxdLV0eunFHSPOiGeZ6JTS/kXsQP3qsr1ns
         RDgWxErhh7VKJHFF1LvSb/ko+OqR0MKBy/WifmOjtqIj0lTHBFFdiRxx6UVUhirt1uBv
         Tiig==
X-Gm-Message-State: AOJu0YyD5Vg6QW4c4gaVY/4C/J0SIZ4fgkneqpPhM+gPbBeVbNjllyFO
	kLMcHnnb3XAEhryKRPXeIC0Blyz1yVPsajPIpV76yf1Ko69iIz/XL7u1LoUgPlXKIRc=
X-Gm-Gg: AeBDiesG2ZNSIcnFYrhbwI1e8VVgi14WQC+DKlVJ9B6C4PmN07kAcg73o0Txw4elM6x
	Ruucwsszp4GA5tUBdMYhduhhQIOq8iOZ0YacqxUvsD+vRuPP0dO9+JsxpLTjYqjInFskMwScac4
	1mRWC6jIyGnfEb7UifamPl6Wttt82LyAYJispe1Qumg5oZ9073/TvP3CFlJgVlEuW4OQjrVVhr2
	L2avKdf2GdlHi4ENaEQAMX4DVyKhlhRbEsO9hnJQlGy+z0trOy5ha1+WZkQ5jOP5wxVtFwanKcC
	BFIEGxS9N4XSW3mxhJl7jnrTitdvbkABVuDO3F86P/WNMUbRsKTpESvIQaYIreYNFTQRL6MSJYL
	Lob04LsNtknjRE/2ISIDcsb9Fivu0dPROYF2SCMDJE2jpYJIpyxkBzUSh53mQHVMiL6+ywqR0nY
	S158hMGjLeJIq1gIm/QHiY/DG/xCnaAPMEDlQj+1PL6QlJTLp7M90f4I6Pg0AR31lcjReUWg==
X-Received: by 2002:a05:600c:1396:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48a77b1b85fmr132416975e9.22.1777475887157;
        Wed, 29 Apr 2026 08:18:07 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2d3811sm32358165e9.3.2026.04.29.08.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:18:06 -0700 (PDT)
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
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] openvswitch: vport: fix self-deadlock on release of tunnel ports
Date: Wed, 29 Apr 2026 17:16:36 +0200
Message-ID: <20260429151756.4157670-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429151756.4157670-1-i.maximets@ovn.org>
References: <20260429151756.4157670-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A45C8496C7F
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
	TAGGED_FROM(0.00)[bounces-282426-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org,vger.kernel.org,ovn.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.318];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ovn.org:mid,ovn.org:email]

vports are used concurrently and protected by RCU, so netdev_put()
must happen after the RCU grace period.  So, either in an RCU call or
after the synchronize_net().  The rtnl_delete_link() must happen under
RTNL and so can't be executed in RCU context.  Calling synchronize_net()
while holding RTNL is not a good idea for performance and system
stability under load in general, so calling netdev_put() in RCU call
is the right solution here.

However,
when the device is deleted, rtnl_unlock() will call netdev_run_todo()
and block until all the references are gone.  In the current code this
means that we never reach the call_rcu() and the vport is never freed
and the reference is never released, causing a self-deadlock on device
removal.

Fix that by moving the rcu_call() before the rtnl_unlock(), so the
scheduled RCU callback will be executed when synchronize_net() is
called from the rtnl_unlock()->netdev_run_todo() while the RTNL itself
is already released.

Fixes: 6931d21f87bc ("openvswitch: defer tunnel netdev_put to RCU release")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/vport-netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 12055af832dc0..a1df551e915bc 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -196,9 +196,13 @@ void ovs_netdev_tunnel_destroy(struct vport *vport)
 	 */
 	if (vport->dev->reg_state == NETREG_REGISTERED)
 		rtnl_delete_link(vport->dev, 0, NULL);
-	rtnl_unlock();
 
+	/* We can't put the device reference yet, since it can still be in
+	 * use, but rtnl_unlock()->netdev_run_todo() will block until all
+	 * the references are released, so the RCU call must be before it.
+	 */
 	call_rcu(&vport->rcu, vport_netdev_free);
+	rtnl_unlock();
 }
 EXPORT_SYMBOL_GPL(ovs_netdev_tunnel_destroy);
 
-- 
2.53.0


