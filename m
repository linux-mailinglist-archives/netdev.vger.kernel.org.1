Return-Path: <netdev+bounces-287713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEmXIl/IBGodOgIAu9opvQ
	(envelope-from <netdev+bounces-287713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:52:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8101B5394EA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51036306E43D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A3C3B9D89;
	Wed, 13 May 2026 18:36:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F43B27C3
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697393; cv=none; b=dQRmWbxPSvtA6lLtr+fOWYQin9xA2aDedv9yttHtnzu/uiqUuRgzdfHyV02vSbONH3oJVyecFKlmxYaqClyucUir+ZZlGOBJraAgLE7tF03NhhmB/pSEGnCEFJ85Y+dEMZAmztdAxj5ZCh8bIIH2pKImDoHpfFiU2rqcqO8MaT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697393; c=relaxed/simple;
	bh=bbNVFjVByescbxlWSooR9HsipPYLdQ+oaSNYna3xljo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/qLUKoSXwjlnsBDgy/OAIwl/fao42dh7fjvRXlRv3Memd8eB04itlT0Jm7nb0GDrnMznrnGt1I4DR3Uy8dV37KVmJKZ5iEz7G+hb4s3livt5603j70HMCFyIU5l0W/N3ekXMsBJ2X+V6g76cGWfIJ0DT35EcefZ8x31LHU8Pfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43d77f6092eso4514335f8f.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697389; x=1779302189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RFryEAJj/MmmFRvFqgOL8R9VRzL/GvvXFVwI7R7pOfI=;
        b=rDPHsb06FBq5CKR77UKSP81D6RshToej4JbnwZys2F5A5LRkIPdESSW5f8xidAMp1k
         IdtRW8871xJUKKRGAbmP6xKqnKttImOWYqDbzS15vQKUGDb4zYVXhLo9IPupi1cwIzK/
         vAN1rrqbFKwzGoIs6bpDRrRhn+67j7idPML0gYcr0q1+DnoGyGi2eLcCjiU9yaCo4lev
         JB7XzCSwQi9a9YUCuMgd5bxttqvFjje13lYV2UA81Hqinpm8CvH4b9bMIIidkAZXDk0C
         OvOnUKnyAxOFpKevORlRWOFnR5az1z0JSIXvIx6Fu4B8iiomXZF/uWaTtr+YsPCDYphI
         Nfqg==
X-Gm-Message-State: AOJu0YyzmKkjmbfyBKARkmMYrCOL2EFk3kJYAV6yFFCfvq5zS45DJa5N
	sp4LvfJxPlP4aSg1aWzWtOSbfEfqGy946keC+gDERV1cK1akZVZCfhPKSEPlTPKx
X-Gm-Gg: Acq92OG5D+X3S/MNSJbhwl8g5xMHbjEJGnNgAmmTtj3w2zc+et+g+uUjJ5X5qO4inq3
	y7R/h86dwzM2vCD8pw7nBhkQgqRW31DIpTYe8ap7AboMT92U6JvtxWEQ/rrJnOcPvrofnKdDlgz
	Nz7RfnBhhqhG7kPBqshhasdXvFMDnKTU/IxlZy3dQTjqaqcJKmNsYRTu/8KXVRTph416rW32HLt
	+DU2+cKbiQWR48B3LSR4XgWAM5t2JyVclwAs4hGzQDQsimCkwRM9yYN97qPFqQo4QoD8JoZ77J2
	kSSXsFseW6pX9rQCCESNl7U4THVRTyKbtqRpsalCSd/4UVrQBk9HyEgJgH/iV6/lBVg2xF8YneM
	qY6fgvk9eX1mn2tWbVvWUXa7ViHsUCPUMEEGypSMLOitnu+w8y+QJdSKHO6x++Was2p6sNu7f5g
	jd8+FpOBXBsJYIyOGSiR8b+6Jt+qiKMhGcT0WyLvXgk9i8QG/WJmGptgX8Mpk=
X-Received: by 2002:a05:6000:2902:b0:43d:3004:5fef with SMTP id ffacd0b85a97d-45c57de8025mr7061742f8f.7.1778697389364;
        Wed, 13 May 2026 11:36:29 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm720609f8f.34.2026.05.13.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:29 -0700 (PDT)
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
Subject: [RFC net-next 5/6] net: gre: remove unused gretap_fb_dev_create
Date: Wed, 13 May 2026 20:35:25 +0200
Message-ID: <20260513183559.2141010-6-i.maximets@ovn.org>
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
X-Rspamd-Queue-Id: 8101B5394EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287713-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.935];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:email,ovn.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The only user was vport-gre in openvswitch and now it is gone.

Note: since it's an exported symbol, there is a possibility that some
out-of-tree module is using it.  So, alternative is to deprecate it
instead by adding a warning if it is ever called.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 include/net/gre.h |  2 --
 net/ipv4/ip_gre.c | 47 -----------------------------------------------
 2 files changed, 49 deletions(-)

diff --git a/include/net/gre.h b/include/net/gre.h
index ccd2932032844..b55f67ecd2fc4 100644
--- a/include/net/gre.h
+++ b/include/net/gre.h
@@ -32,8 +32,6 @@ struct gre_protocol {
 int gre_add_protocol(const struct gre_protocol *proto, u8 version);
 int gre_del_protocol(const struct gre_protocol *proto, u8 version);
 
-struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
-				       u8 name_assign_type);
 int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 		     bool *csum_err, __be16 proto, int nhs);
 
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 169e2921a851d..a1dd833ea1cad 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1710,53 +1710,6 @@ static struct rtnl_link_ops erspan_link_ops __read_mostly = {
 	.get_link_net	= ip_tunnel_get_link_net,
 };
 
-struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
-					u8 name_assign_type)
-{
-	struct rtnl_newlink_params params = { .src_net = net };
-	struct nlattr *tb[IFLA_MAX + 1];
-	struct net_device *dev;
-	LIST_HEAD(list_kill);
-	struct ip_tunnel *t;
-	int err;
-
-	memset(&tb, 0, sizeof(tb));
-	params.tb = tb;
-
-	dev = rtnl_create_link(net, name, name_assign_type,
-			       &ipgre_tap_ops, tb, NULL);
-	if (IS_ERR(dev))
-		return dev;
-
-	/* Configure flow based GRE device. */
-	t = netdev_priv(dev);
-	t->collect_md = true;
-
-	err = ipgre_newlink(dev, &params, NULL);
-	if (err < 0) {
-		free_netdev(dev);
-		return ERR_PTR(err);
-	}
-
-	/* openvswitch users expect packet sizes to be unrestricted,
-	 * so set the largest MTU we can.
-	 */
-	err = __ip_tunnel_change_mtu(dev, IP_MAX_MTU, false);
-	if (err)
-		goto out;
-
-	err = rtnl_configure_link(dev, NULL, 0, NULL);
-	if (err < 0)
-		goto out;
-
-	return dev;
-out:
-	ip_tunnel_dellink(dev, &list_kill);
-	unregister_netdevice_many(&list_kill);
-	return ERR_PTR(err);
-}
-EXPORT_SYMBOL_GPL(gretap_fb_dev_create);
-
 static int __net_init ipgre_tap_init_net(struct net *net)
 {
 	return ip_tunnel_init_net(net, gre_tap_net_id, &ipgre_tap_ops, "gretap0");
-- 
2.53.0


