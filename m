Return-Path: <netdev+bounces-118023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D198C95044A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F811C20F6D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353E1991D2;
	Tue, 13 Aug 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="glg2xvLK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6KH5SUKc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jAzaYaXr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4+MRS/Cv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A01991AA;
	Tue, 13 Aug 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550363; cv=none; b=l5bA+N4U6KHHOeYN7qCwiVu8j2TI7sYa5ra25SlzVAxgv7mh1ugCx7sfY4QjnOFT3dzTLDKttn6Jz0vaIK2vKspX6QkkqZ5v5fCk9z1beMLMOU5C6Cu51ouk1bx4q3oE6ms2XOJwMqgkfHXUrcKtdW7uqxyt1UOc2OoEJZb9K7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550363; c=relaxed/simple;
	bh=YKUhh138MKddwNXT//mlPFhV2bsCE5QjxVJU7COwIY8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=lxtETotCVtLFt38ncO6U9OsNXD3fT7WElLRz2kQH6mH/PR7MWLRNslqkeyuVS81cQPcp9GRY0rvidiSOo7BTVS/Y/kMV5xfXZGrcuMufyCqJvg8n7gX+//UCsSj7ERqs40PqUzqlElAkzLV4VGF6FTKWIi3grApssHAoF1Gua8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=glg2xvLK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6KH5SUKc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jAzaYaXr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4+MRS/Cv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E5B61F74B;
	Tue, 13 Aug 2024 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723550360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YzbTbyzS1OF3r8pmcPB9/80dU+RKX4grDiTjBdUyQoA=;
	b=glg2xvLKG3Ua7x17igx/wtY2TI4C7bGHdmxZI4DPCcXZ/3ZZiMKBqNRndE+TZvmbLXe0Y6
	NCao+bov+ExiVcN3wrB+aPzCNJSB36uoyYh8buk4ADwT0/w09HPv3hjmUZJ8d0QHLo4OMP
	4Ae/REaBvr1sPFP4hE7nL10itF3dBf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723550360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YzbTbyzS1OF3r8pmcPB9/80dU+RKX4grDiTjBdUyQoA=;
	b=6KH5SUKcqKESay3+iZU8pXy8ydknSahCk4X2ljFFsfqLjKDsC5BDoNaGxUv9krBns4GoeE
	Hi/24/XrRwsaNkDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jAzaYaXr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4+MRS/Cv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723550359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YzbTbyzS1OF3r8pmcPB9/80dU+RKX4grDiTjBdUyQoA=;
	b=jAzaYaXrK73U7/2T4pEbWEZ84MvnEhdRNsWNzrXsxzUWKWEuEkskfu713Rd8lZQVOAokg+
	Vzs2RI9rPEXprF+FnYOBiu32Qh/LkbcQrkhrxnNNhUtH8vTBAcbSfVfG3m2hP8B0uA/4En
	L9tnQaiNoY6s8oEMLdX3daSXkf3Z0ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723550359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YzbTbyzS1OF3r8pmcPB9/80dU+RKX4grDiTjBdUyQoA=;
	b=4+MRS/CvIjo/f5HeOgh288b69m0PRnR09v8bMKsDi7MUlENjjyYREY63GOYYlCcRVomFDO
	dygbrCMcVulHsMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDA4F13ABD;
	Tue, 13 Aug 2024 11:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id McDWOZZKu2YWdwAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Tue, 13 Aug 2024 11:59:18 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ip6_tunnel: Fix broken GRO
Date: Tue, 13 Aug 2024 13:59:10 +0200
Message-Id: <20240813115910.87101-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.01
X-Rspamd-Queue-Id: 0E5B61F74B
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

GRO code checks for matching layer 2 headers to see, if packet belongs
to the same flow and because ip6 tunnel set dev->hard_header_len
this check fails in cases, where it shouldn't. To fix this don't
set hard_header_len, but use needed_headroom like ipv4/ip_tunnel.c
does.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 net/ipv6/ip6_tunnel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9dee0c127955..dcbc668906c6 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1507,7 +1507,8 @@ static void ip6_tnl_link_config(struct ip6_tnl *t)
 			tdev = __dev_get_by_index(t->net, p->link);
 
 		if (tdev) {
-			dev->hard_header_len = tdev->hard_header_len + t_hlen;
+			dev->needed_headroom = tdev->hard_header_len +
+				tdev->needed_headroom + t_hlen;
 			mtu = min_t(unsigned int, tdev->mtu, IP6_MAX_MTU);
 
 			mtu = mtu - t_hlen;
@@ -1731,6 +1732,7 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct ip6_tnl *tnl = netdev_priv(dev);
+	int t_hlen = tnl->hlen + sizeof(struct ipv6hdr);
 
 	if (tnl->parms.proto == IPPROTO_IPV6) {
 		if (new_mtu < IPV6_MIN_MTU)
@@ -1740,10 +1742,10 @@ int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu)
 			return -EINVAL;
 	}
 	if (tnl->parms.proto == IPPROTO_IPV6 || tnl->parms.proto == 0) {
-		if (new_mtu > IP6_MAX_MTU - dev->hard_header_len)
+		if (new_mtu > IP6_MAX_MTU - dev->hard_header_len - t_hlen)
 			return -EINVAL;
 	} else {
-		if (new_mtu > IP_MAX_MTU - dev->hard_header_len)
+		if (new_mtu > IP_MAX_MTU - dev->hard_header_len - t_hlen)
 			return -EINVAL;
 	}
 	WRITE_ONCE(dev->mtu, new_mtu);
@@ -1887,12 +1889,11 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	t_hlen = t->hlen + sizeof(struct ipv6hdr);
 
 	dev->type = ARPHRD_TUNNEL6;
-	dev->hard_header_len = LL_MAX_HEADER + t_hlen;
 	dev->mtu = ETH_DATA_LEN - t_hlen;
 	if (!(t->parms.flags & IP6_TNL_F_IGN_ENCAP_LIMIT))
 		dev->mtu -= 8;
 	dev->min_mtu = ETH_MIN_MTU;
-	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len;
+	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len - t_hlen;
 
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
 	netdev_lockdep_set_classes(dev);
-- 
2.35.3


