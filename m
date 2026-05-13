Return-Path: <netdev+bounces-287710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMVLFB/IBGodOgIAu9opvQ
	(envelope-from <netdev+bounces-287710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:51:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0E1539498
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35E283096544
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F943B47FF;
	Wed, 13 May 2026 18:36:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97EE3AE1A8
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697387; cv=none; b=SgqU3uV/NocSA/kFX0A13KKOTcc+TbkA2EKfRTIK2LLhunLVPlTC9y6hJxhivt6BkAQt/6i82kemo1axYLpnQm66ikVQ8p97xMQfdVD6fuFRBuG/cBwQ+qh93Nma7glxnFRLR0erCP+NStonDvErbbB6bJGMdV1wGBmiwjyHp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697387; c=relaxed/simple;
	bh=o0pCRzhxwmfMV3TcD5VlPb9JbEKxbxvZW3AI+AvXYbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUxFR0Q73z5P44cnh/OiZC8FnrVPCTZXXwGIJYGGHlbfoXXa+1XzhCUq6DmInkAnXdYd/5maIpxJHovilkAMfPxoMOmM5DwyYR31GYH1zxKSRFAtcgENqrYJvGP5vFlsepWP20aa1bG6A4MXzGbPjXDpKYnexRN2i50cqAttiZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso6069112f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697382; x=1779302182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDjn5A6QB434U5615WGA/fHygBkP687Auiym2D0+n2I=;
        b=Vb7p+tFcn3FSn3t2vScTnkyYh7JM/S3l+i2CgZQc3JtcOUp9Xr6rR8MLacDwZKRAU9
         /ZR+/GN0NsOaqv9CZyUiojc7mdieOy5lvdHWHC5sd8bB/Y/d8+IcMkN6F0sbTnLM+Lgf
         d52Adn973mF4zyS912ddzDGUsaGF/1lHS70eC4QF8hCZiHWwWB+eGVnIbIdek2kQ6ws6
         J4rSgE+KdYlPI5S5dEfyYoJFSIXUraCn/2tIdRjcwWasvbTG9o2/1nFgMvz09n6zHZel
         L2NrcXNhDFhU8xfn+n0sE+3As5Hzreg5UHcbyi461KNNBmeqXLlKfDetME9h7YZVNRK6
         qN9w==
X-Gm-Message-State: AOJu0Yxj9kLcyhbDBmye3W4ZFVrXpX8CjhJCBVhNeh4/c4RIMdLBMk88
	+pPjaE+NawV0WmuHjoWHyx1a5efvYjh3gju7pnt+d6AWawy4TC+Xjo6eZYOir68N
X-Gm-Gg: Acq92OGnbkI6iLlWrUmh9ry8VVMxQyt8g9JMIJlIDQaMDmb97+rS8k2J5WeT2lCQKmd
	85hg42yDhOIr2zx3yAc54GLW46VRV9mPz3/+hvd0YTU6kVjgEjp6dje7h1M+UjKuivAieMqbNOA
	NwZzSLtTMJvGoItU48Ta0MGGop5vsOvWxDopRNI8v33pc4s+xZ8WZoVKx9M4EVliTu/i0/Z5661
	BkT4EToHmaSQ9M8BECjfT3d0XxUzfmkoUdtgUP3xcXO8puB41ACFtNWWVjHjOJeWoNJQk6XCT0b
	IY2ATEtrLQTKm8dEAaOTmZJm2JOlrtpR5OQ1ILYjY8aJEQbBW42Y3xn5bjm0Rlxvog9K/tVTPAr
	IBJoE29UNIWzWEIMun7nciUAOF14KLFGQuKIrNE6sLiByQuYBDw/v9xXuemU+QEzKf+wmjd34XA
	duoL75tkuUwYoGvXFU294tMU7B7bjrG2QAGEG9TXFTu4fnTXUH4TwkK3XEhlQ=
X-Received: by 2002:a05:6000:2386:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-45c5b2184f5mr7318960f8f.43.1778697381945;
        Wed, 13 May 2026 11:36:21 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm720609f8f.34.2026.05.13.11.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:21 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC net-next 2/6] openvswitch: vport: remove infrastructure for vport options
Date: Wed, 13 May 2026 20:35:22 +0200
Message-ID: <20260513183559.2141010-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513183559.2141010-1-i.maximets@ovn.org>
References: <20260513183559.2141010-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E0E1539498
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287710-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.930];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ovn.org:email,ovn.org:mid]
X-Rspamd-Action: no action

Since removal of tunnel vport types, there aren't any vports that
support options.  Let's remove the options-related infrastructure.

Can be reinstated if we ever need a new vport type or if we need extra
options for the existing ones.  The uAPI attribute remains.

Clarification comment is added to highlight that none of the supported
vports support options at the moment.

Note: It is technically possible that someone has an out-of-tree module
named vport-type-N that implements a different vport type and they have
options for this vport type.  However, our message size calculations do
not account for whatever options such a port would have and so it is
dangerous to load such a module without modifying the code in the main
datapath.c, unless the options are smaller than the ones we had for
vxlan.  A more robust solution would be to have a different version of
the entire openvswitch module instead, so the use case of a separate
vport-type-N loaded with the upstream openvswitch module is unlikely.
At this time we're not aware of anyone doing that.  Alternative to
immediate removal would be printing out a deprecation warning whenever
the options setting is attempted.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/datapath.c | 20 +-------------
 net/openvswitch/vport.c    | 54 --------------------------------------
 net/openvswitch/vport.h    | 14 ----------
 3 files changed, 1 insertion(+), 87 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index d86c53fedc1e1..a9c0cc2c702a4 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1852,7 +1852,6 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	/* Set up our datapath device. */
 	parms.name = nla_data(a[OVS_DP_ATTR_NAME]);
 	parms.type = OVS_VPORT_TYPE_INTERNAL;
-	parms.options = NULL;
 	parms.dp = dp;
 	parms.port_no = OVSP_LOCAL;
 	parms.upcall_portids = a[OVS_DP_ATTR_UPCALL_PID];
@@ -2168,10 +2167,6 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	if (ovs_vport_get_upcall_portids(vport, skb))
 		goto nla_put_failure;
 
-	err = ovs_vport_get_options(vport, skb);
-	if (err == -EMSGSIZE)
-		goto error;
-
 	genlmsg_end(skb, ovs_header);
 	return 0;
 
@@ -2179,7 +2174,6 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	rcu_read_unlock();
 nla_put_failure:
 	err = -EMSGSIZE;
-error:
 	genlmsg_cancel(skb, ovs_header);
 	return err;
 }
@@ -2206,10 +2200,6 @@ static size_t ovs_vport_cmd_msg_size(void)
 	/* OVS_VPORT_ATTR_UPCALL_PID */
 	msgsize += nla_total_size(nr_cpu_ids * sizeof(u32));
 
-	/* There are no vports supporting OVS_VPORT_ATTR_OPTIONS, so it is
-	 * not included in the message size calculation.
-	 */
-
 	return msgsize;
 }
 
@@ -2361,7 +2351,6 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	parms.name = nla_data(a[OVS_VPORT_ATTR_NAME]);
-	parms.options = a[OVS_VPORT_ATTR_OPTIONS];
 	parms.dp = dp;
 	parms.port_no = port_no;
 	parms.upcall_portids = a[OVS_VPORT_ATTR_UPCALL_PID];
@@ -2422,13 +2411,6 @@ static int ovs_vport_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		goto exit_unlock_free;
 	}
 
-	if (a[OVS_VPORT_ATTR_OPTIONS]) {
-		err = ovs_vport_set_options(vport, a[OVS_VPORT_ATTR_OPTIONS]);
-		if (err)
-			goto exit_unlock_free;
-	}
-
-
 	if (a[OVS_VPORT_ATTR_UPCALL_PID]) {
 		struct nlattr *ids = a[OVS_VPORT_ATTR_UPCALL_PID];
 
@@ -2602,7 +2584,7 @@ static const struct nla_policy vport_policy[OVS_VPORT_ATTR_MAX + 1] = {
 	[OVS_VPORT_ATTR_PORT_NO] = { .type = NLA_U32 },
 	[OVS_VPORT_ATTR_TYPE] = { .type = NLA_U32 },
 	[OVS_VPORT_ATTR_UPCALL_PID] = { .type = NLA_UNSPEC },
-	[OVS_VPORT_ATTR_OPTIONS] = { .type = NLA_NESTED },
+	[OVS_VPORT_ATTR_OPTIONS] = { .type = NLA_NESTED }, /* Unused. */
 	[OVS_VPORT_ATTR_IFINDEX] = NLA_POLICY_MIN(NLA_S32, 0),
 	[OVS_VPORT_ATTR_NETNSID] = { .type = NLA_S32 },
 	[OVS_VPORT_ATTR_UPCALL_STATS] = { .type = NLA_NESTED },
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 56b2e2d1a749f..7a9caacfd6ac2 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -239,22 +239,6 @@ struct vport *ovs_vport_add(const struct vport_parms *parms)
 		return ERR_PTR(-EAGAIN);
 }
 
-/**
- *	ovs_vport_set_options - modify existing vport device (for kernel callers)
- *
- * @vport: vport to modify.
- * @options: New configuration.
- *
- * Modifies an existing device with the specified configuration (which is
- * dependent on device type).  ovs_mutex must be held.
- */
-int ovs_vport_set_options(struct vport *vport, struct nlattr *options)
-{
-	if (!vport->ops->set_options)
-		return -EOPNOTSUPP;
-	return vport->ops->set_options(vport, options);
-}
-
 /**
  *	ovs_vport_del - delete existing vport device
  *
@@ -348,44 +332,6 @@ int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb)
 	return 0;
 }
 
-/**
- *	ovs_vport_get_options - retrieve device options
- *
- * @vport: vport from which to retrieve the options.
- * @skb: sk_buff where options should be appended.
- *
- * Retrieves the configuration of the given device, appending an
- * %OVS_VPORT_ATTR_OPTIONS attribute that in turn contains nested
- * vport-specific attributes to @skb.
- *
- * Returns 0 if successful, -EMSGSIZE if @skb has insufficient room, or another
- * negative error code if a real error occurred.  If an error occurs, @skb is
- * left unmodified.
- *
- * Must be called with ovs_mutex or rcu_read_lock.
- */
-int ovs_vport_get_options(const struct vport *vport, struct sk_buff *skb)
-{
-	struct nlattr *nla;
-	int err;
-
-	if (!vport->ops->get_options)
-		return 0;
-
-	nla = nla_nest_start_noflag(skb, OVS_VPORT_ATTR_OPTIONS);
-	if (!nla)
-		return -EMSGSIZE;
-
-	err = vport->ops->get_options(vport, skb);
-	if (err) {
-		nla_nest_cancel(skb, nla);
-		return err;
-	}
-
-	nla_nest_end(skb, nla);
-	return 0;
-}
-
 /**
  *	ovs_vport_set_upcall_portids - set upcall portids of @vport.
  *
diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
index 9f67b9dd49f98..636788b59907c 100644
--- a/net/openvswitch/vport.h
+++ b/net/openvswitch/vport.h
@@ -34,9 +34,6 @@ void ovs_vport_get_stats(struct vport *, struct ovs_vport_stats *);
 
 int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb);
 
-int ovs_vport_set_options(struct vport *, struct nlattr *options);
-int ovs_vport_get_options(const struct vport *, struct sk_buff *);
-
 int ovs_vport_set_upcall_portids(struct vport *, const struct nlattr *pids);
 int ovs_vport_get_upcall_portids(const struct vport *, struct sk_buff *);
 u32 ovs_vport_find_upcall_portid(const struct vport *, struct sk_buff *);
@@ -92,8 +89,6 @@ struct vport {
  *
  * @name: New vport's name.
  * @type: New vport's type.
- * @options: %OVS_VPORT_ATTR_OPTIONS attribute from Netlink message, %NULL if
- * none was supplied.
  * @desired_ifindex: New vport's ifindex.
  * @dp: New vport's datapath.
  * @port_no: New vport's port number.
@@ -104,7 +99,6 @@ struct vport_parms {
 	const char *name;
 	enum ovs_vport_type type;
 	int desired_ifindex;
-	struct nlattr *options;
 
 	/* For ovs_vport_alloc(). */
 	struct datapath *dp;
@@ -120,11 +114,6 @@ struct vport_parms {
  * a new vport allocated with ovs_vport_alloc(), otherwise an ERR_PTR() value.
  * @destroy: Destroys a vport.  Must call vport_free() on the vport but not
  * before an RCU grace period has elapsed.
- * @set_options: Modify the configuration of an existing vport.  May be %NULL
- * if modification is not supported.
- * @get_options: Appends vport-specific attributes for the configuration of an
- * existing vport to a &struct sk_buff.  May be %NULL for a vport that does not
- * have any configuration.
  * @send: Send a packet on the device.
  * zero for dropped packets or negative for error.
  * @owner: Module that implements this vport type.
@@ -137,9 +126,6 @@ struct vport_ops {
 	struct vport *(*create)(const struct vport_parms *);
 	void (*destroy)(struct vport *);
 
-	int (*set_options)(struct vport *, struct nlattr *);
-	int (*get_options)(const struct vport *, struct sk_buff *);
-
 	int (*send)(struct sk_buff *skb);
 	struct module *owner;
 	struct list_head list;
-- 
2.53.0


