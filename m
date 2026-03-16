Return-Path: <netdev+bounces-268024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA3rNgyHt2mOSAEAu9opvQ
	(envelope-from <netdev+bounces-268024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:29:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43729294911
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6555301DAE8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38A033A029;
	Mon, 16 Mar 2026 04:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRUbqmgC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7B3339870
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635251; cv=none; b=F9o2oQuRilJT0mMkUjeKevtTitwHh22JF9S8QKdesgH1jTC5nloV3ASl03rEoohH1B0x3LRbYSl/+R6Y5TT4gzZS0wDziME1O4BCzlTeit/WkauVKidKYbhVGxKX8ky7wF53b/SzLcn8G2+s9vI31gATks6H4C2SLZSZuSJguLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635251; c=relaxed/simple;
	bh=pbtKIDznCvGEVtQHODrKsx+vVNFY8ZkNIx/vZ7lzIsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUntssfr1yyBfZBSUUkd3Ku3VnaSQ6bZ+xwwnR+2HMj1CuYdn1tB9yP1pW5twAFaiR2r1GdK6qgK6RnHa+eatTwRB8TAy1E6cztulPGKM3woYughEGQof59kZX901vozFMXTxxVrETJZSLT+NpdOlx38pk0LPCs5mFFgciLf8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRUbqmgC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829781b2b01so2573358b3a.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 21:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773635250; x=1774240050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPGq7YNOGl3DkR8NTBoIGDJAXGD2GV5oTegfoP6i0Xk=;
        b=SRUbqmgCkNbCavGRvSw5aN03HhEmlPtqPTWYZmG/Ksx5ZmK5WHW0+6F95Xg/7x31Ra
         p2kos3qMmPlnEqrn9n4D4Lk1LDw+HQ1EqBt+q4axlc5pGZGlr6nRNVZM1DRAZT6yUD4q
         l4H5upzafiE6zyks24TE6DQcgDWzVhXQ+na3mO2Tw50eWonWHEvOsllP2p15N55AzMuC
         npvw9I24a/pMWPD3PigokPRIL5OAPfOy1KJIffMiQ4fZXaG/QLcDdtiwzcbZ8AeaQKER
         9MOSoeBCduktbLEZT4jFwUr1YMNVYxlMOWV90DdmsXotnj9tT0jLWJn0+fxFm13NWU4h
         IgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773635250; x=1774240050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPGq7YNOGl3DkR8NTBoIGDJAXGD2GV5oTegfoP6i0Xk=;
        b=g/PPnV7npZ/OTBQYUTGx3ZhOGmuJttRiE7EK1cxDQ8DuVLVaO8Mc9Xtf6fH9fyP0tV
         YjRgJh3Nux1fNocJiEgFQCFsqmad5DuGkCXXdtyZJNCfopGh3ajC8cWNl54X1CzEaIDe
         pwdRUOrRdLtPjCrLoHOCPhmpm91Y4k+zoydX333rLSCwYtQDzBo8NmodOCCYBvjfqEoW
         OmsSklBYR5Yk1nmJQ/9J0xKFEuyQBhP6ugO4Z0rYT8hQxubT4Gekpuw+TbLgjOALD+XI
         e7Dp/zPwUxlX6bf8hp5uyCmrIHcLbGlyYuDQb6DvG8Cn2sYzQmjDEw/Du/bO8t1gUNnp
         FSGQ==
X-Gm-Message-State: AOJu0Yy6ox7nL6XdfGuVQwTOZB8TH4q5SiqlB2rp4VaHM3JWp0adFTFf
	Q4nuxOdO5b7pSvMqfClD+KTnhCiwgnUUNOl1+jDUmNRMo+5TpcJjZMZc
X-Gm-Gg: ATEYQzwBavlhEXi5G7MSqN249W+HAf1rytG2Ny70MBmIn4WiAYQSncacRLItUxs/mwm
	c3aPlRtd6+g2BftXVMRv+mMmqktOkX3110UTvFpKG37gYeQK01fRDP69uRxx8bIuZ6JeQrRK3fC
	jSOBWR7V0wt7chLs2lqPV6ceRwjz8lRL2lqLOF7JcitIYTiit3Yms9DbJEoeYJ734gP7smFYNkF
	7MtDN8q5G0msMT1kA/qFPChQf8INFDQHwoBE+3NOYwe4lC9okTXYzc2DNKVgtaHt1z0/toAnOYY
	BkZ1m7FZXiHrePRfYQiWpLlNWvIPU2xuQOwrijVBNI8z26lbN9uLpf5gY81XLsYwhTYTFGIBugI
	81Yn7iY37iNOQ0y8N4bZx3dt8GHhKJKs1LYLYnOKH6+RtsiCwxz29ydFjTkJRm1tlfgwcFdunAg
	neiNVNG5lcJTw9FbcpL1am+UqHi0AVNXVoQBdjnBIS9DDzEXMEnnLwza3wVNa3gOtyVfCC
X-Received: by 2002:a05:6a00:981:b0:82a:110b:e22d with SMTP id d2e1a72fcca58-82a1971e6f9mr10199007b3a.24.1773635249914;
        Sun, 15 Mar 2026 21:27:29 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5760:3860:bc29:deed:92d0:823c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm12180267b3a.55.2026.03.15.21.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:27:29 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Mon, 16 Mar 2026 12:26:11 +0800
Subject: [PATCH net-next v3 3/5] macsec: move netdev_upper_dev_link() after
 macsec_changelink_common()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-offload_compute-v3-3-a5d4a07d86d3@gmail.com>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
In-Reply-To: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268024-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Queue-Id: 43729294911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After calling netdev_change_features() in __netdev_upper_dev_link(),
the call stack looks like:

- netdev_upper_dev_link
  - __netdev_upper_dev_link
    - netdev_change_features
      - notifier_call_chain
        - rtnetlink_event
          - rtmsg_ifinfo_event
            - rtmsg_ifinfo_build_skb

In macsec, we call netdev_upper_dev_link() before
macsec_changelink_common(), which causes the fields of the MACsec
Security Entity to be uninitialized. Later, macsec_fill_info() returns
-EMSGSIZE and triggers WARN_ON() in rtmsg_ifinfo_build_skb.

Fix this by moving netdev_upper_dev_link() after
macsec_changelink_common(), and return 0 if secy->key_len is not
initialized yet.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/macsec.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..6bb38084bc1e 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4161,10 +4161,6 @@ static int macsec_newlink(struct net_device *dev,
 	lockdep_set_class(&dev->addr_list_lock,
 			  &macsec_netdev_addr_lock_key);
 
-	err = netdev_upper_dev_link(real_dev, dev, extack);
-	if (err < 0)
-		goto unregister;
-
 	/* need to be already registered so that ->init has run and
 	 * the MAC addr is set
 	 */
@@ -4177,12 +4173,12 @@ static int macsec_newlink(struct net_device *dev,
 
 	if (rx_handler && sci_exists(real_dev, sci)) {
 		err = -EBUSY;
-		goto unlink;
+		goto unregister;
 	}
 
 	err = macsec_add_dev(dev, sci, icv_len);
 	if (err)
-		goto unlink;
+		goto unregister;
 
 	if (data) {
 		err = macsec_changelink_common(dev, data);
@@ -4190,6 +4186,10 @@ static int macsec_newlink(struct net_device *dev,
 			goto del_dev;
 	}
 
+	err = netdev_upper_dev_link(real_dev, dev, extack);
+	if (err < 0)
+		goto del_dev;
+
 	/* If h/w offloading is available, propagate to the device */
 	if (macsec_is_offloaded(macsec)) {
 		const struct macsec_ops *ops;
@@ -4200,7 +4200,7 @@ static int macsec_newlink(struct net_device *dev,
 			ctx.secy = &macsec->secy;
 			err = macsec_offload(ops->mdo_add_secy, &ctx);
 			if (err)
-				goto del_dev;
+				goto unlink;
 
 			macsec->insert_tx_tag =
 				macsec_needs_tx_tag(macsec, ops);
@@ -4209,7 +4209,7 @@ static int macsec_newlink(struct net_device *dev,
 
 	err = register_macsec_dev(real_dev, dev);
 	if (err < 0)
-		goto del_dev;
+		goto unlink;
 
 	netdev_update_features(dev);
 	netif_stacked_transfer_operstate(real_dev, dev);
@@ -4219,10 +4219,10 @@ static int macsec_newlink(struct net_device *dev,
 
 	return 0;
 
-del_dev:
-	macsec_del_dev(macsec);
 unlink:
 	netdev_upper_dev_unlink(real_dev, dev);
+del_dev:
+	macsec_del_dev(macsec);
 unregister:
 	unregister_netdevice(dev);
 	return err;
@@ -4337,7 +4337,8 @@ static int macsec_fill_info(struct sk_buff *skb,
 		csid = secy->xpn ? MACSEC_CIPHER_ID_GCM_AES_XPN_256 : MACSEC_CIPHER_ID_GCM_AES_256;
 		break;
 	default:
-		goto nla_put_failure;
+		WARN_ON_ONCE(1);
+		return 0;
 	}
 
 	if (nla_put_sci(skb, IFLA_MACSEC_SCI, secy->sci,

-- 
Git-155)


