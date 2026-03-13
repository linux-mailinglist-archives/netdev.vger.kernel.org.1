Return-Path: <netdev+bounces-267289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BJ9LwB/s2kDXQAAu9opvQ
	(envelope-from <netdev+bounces-267289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:05:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 583C627CFAB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E7A33145428
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE8532AAD6;
	Fri, 13 Mar 2026 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUF6SP+n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B822C3257
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371054; cv=none; b=W69E+DYTjXun4QOZsCCfarJKxrDMdiIvOcbwh4zjFjmJDRahRkZLlCtSCWPErqLurmOct+i0gYYnWvqu8/h9w2qOCjDuFtM0ONdDXxGCIsPN/MEDGtrwNFhipaxVXeeaWEo4RxAudAIiAPCf3R/W33uLZC0e32eEZjXtSs5u0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371054; c=relaxed/simple;
	bh=pbtKIDznCvGEVtQHODrKsx+vVNFY8ZkNIx/vZ7lzIsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NwHTzpBJUy9udJUdq0h2F2U0vv1BwUjVYwLHMESgt6pmSPQtSuiUwnWxPF/bJ/iCWtFVvOytLaVwZHbfVJEgydAcqTverHaeABL3gwfupXEl7kSCQCAkic993kE0+DufiWimWSl/ZGq2NZi1faCrM5zqRn63SdCb1aYrun2z4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUF6SP+n; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a132767c3so708867a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371051; x=1773975851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPGq7YNOGl3DkR8NTBoIGDJAXGD2GV5oTegfoP6i0Xk=;
        b=CUF6SP+nfvm8EGykUo+yEDyeYPu231983gEVErsdnljr4Uh8U1n71xl5duKcS2Q4/a
         O+c3zpoaLPFsbSw2jBkHT3ftoUFS4QfgaHsSTS9+5wRVl9G/qyoSuXpYKdl7MEQGe2gE
         UUbF6qnuCtlYiKwQty5J0AmgYDHc2o8rAqErUNJpBl4lW073H5mNKom04GOmHPH0ERNA
         bswAzMfRLxi+skeU98p/uks4TeiLXzNMlc6kXDliluweXrEYWnsm54ZB2swTdfCq7txc
         maSPWkrKYypLkbraokqeTQcM9/11cXTmK/g2pxlWPsnXrOnHIeSKY7eEQR+9R1oXobpY
         dv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371051; x=1773975851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPGq7YNOGl3DkR8NTBoIGDJAXGD2GV5oTegfoP6i0Xk=;
        b=O9PYp9UbiWVm4GsfRsQqL44taauRF1K/46T82tjWDWn2WMUOzH7tFkDNSilOM6KT5/
         p0OEoLO1yFWlL1ssqpP9toB2nIv1vKtCfj5M6MpbyFBxzmH3Ifep1N4eH0+u8s9lu63c
         orSafxMa7dnH7kgHQU7OdJ0RpnlWUHH0XoO9NAxK+Aax/uTzYjx1SITS6crMw+//g6KI
         /lBDUFfDzQN1RwfU0alISq+iJwBmTaVLI5ELIYWmZdP3m/RtLOTLkT2X+Y04DUneeCV3
         UaC1Ti8zneX0woP20bRaDUafLkYSgTzNKeLYITp1XbOENzvU2JGH7L36WUk1YUNwvlOy
         wXdA==
X-Gm-Message-State: AOJu0Yw/QWwUGbTNrRb+6MLhI/duhX/yUMBgxbQSnMGerQ9OMPtQgpVp
	KkIpf2m4m1XnXIurcabRX9D3+nbtH0q3CwPzUuczFcnPl4lV4cHV7rSEuEhKVTWHQ3yHcQ==
X-Gm-Gg: ATEYQzz5p8lvqtMQxjiqHNErefoblEOmjT965Cx3X4s5M+v8Sl4pnmfOC8ngL0vCawD
	YoeHmLY8JoZ5yyV0VwfhTkBzTV3xURInHOlpEV8fdsQwu/3cCko1iyaRwmyIzy6W5At9h97tCT9
	Akkdcz/88GXtf1NpO6xnKxphs2zrGeujILFdWeEDmfD4Ame+jzGCOgfJrdaKui9rv4UpXSA6I9a
	C2Y5WVFfi/U6shA9GEKyGvBXXw1useBXpYRAP9VboE39gDtDr+rN8oBpEi8NR1h7pcbooVmExmE
	IQFDx2JuKRqlwnKwbzOKiICmVMmqJ7rd2hWs0TVphwheuPP6Fmzv6lXxWPEThnnp8nIWDHHVzVB
	GXxA78lL5aIQ2v3gv6k1wIvAwwtH2UcWRuIEJS2b1BiGt2M3tBT4RINKXEj8N9re7S3SNF03UzK
	XejWP9H3rJJoiZ7J8J3FHs0ofG8FtubQRfzTVeTLrc02Xr8VRuIeR0BWgEfhfwIAO7Y1GW2Eo02
	6nIWigX+oPjcBOdTsLWi3sobPvKpVYuVeJR5FLz/+XZDtxvBK96Y/ecgQam5ek=
X-Received: by 2002:a17:90b:3b41:b0:35a:3e2:7cbb with SMTP id 98e67ed59e1d1-35a220558b3mr1403433a91.29.1773371050802;
        Thu, 12 Mar 2026 20:04:10 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:adb0:54b3:92b9:a11b:1cae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a24a7dc1csm293967a91.1.2026.03.12.20.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 20:04:10 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 13 Mar 2026 11:03:10 +0800
Subject: [PATCH net-next v2 2/4] macsec: move netdev_upper_dev_link() after
 macsec_changelink_common()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-offload_compute-v2-2-ffbc8ce5d50c@gmail.com>
References: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
In-Reply-To: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-267289-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 583C627CFAB
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


