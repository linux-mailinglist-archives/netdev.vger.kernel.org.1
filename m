Return-Path: <netdev+bounces-264538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAsAM+7pqWmLHwEAu9opvQ
	(envelope-from <netdev+bounces-264538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:39:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5869A2183CB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 454AE3072460
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E03446D1;
	Thu,  5 Mar 2026 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OwYnViCU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F0341050
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743071; cv=none; b=LJTX+O8Wvm7iCtUWubiRAPzRHDJmFiH2QNmo1pSSjgUR6fcll+PLOyFoTzsc3yYWpf/wzqHaJSt3kC2tfFXjfOUu2AtDrzIjdNlXLYQNzDLh7+dBkBP8OFIqm1TuHen3s8On9B+cNRfLW3Q3fYpwIMn+fjcuvF9er01nkQzYmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743071; c=relaxed/simple;
	bh=Yfucwf5JHvyU/znf9S6sDQrRZ/qy3di3N5iSoXWL4aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sTv20H3PHOFkUyOQFR0JUij0iIe2K4E//ObzB6xMsq3uP9OktxN7MR9hpPp9GKzTOPPlAXEVfgVmkbtyNZPxfViU4+bnOcd6PbLfWTfOqhl5QDwsJ4JZka9e4kF/0S9XjqRGyoCiRfrC7VWWTHp9ftrtysVTSary9aqrnKsSLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OwYnViCU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48371119eacso100302615e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772743069; x=1773347869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qqlYUk2uLknCELv6zwONHG5x3atJmpFah5PNZJ3m1g=;
        b=OwYnViCUQd7q/FhqXzjz9Q8r4KoWEKZa/1pt39UHCDDILvlIgm+PK7qqo4Vlen4XXy
         2Z4rIFVx1DOj9kRtPCN5wbKFjxEjqzoEUuJ02KGLheB21r9V2LomJqBSr4mn0Qs3IIJx
         F3MTZCV6eeSc/fCcHPeWyoRYGbcTd3LUNPkTwOk/FhKGWMD2xwyJQUysJhI86E+ts30Z
         QbJ/dlzu4aSatL9iHEdQwfCLLuSFPLLC+25n5Ll6PItYogwGRsFzBPTz/8Rr6A/IVVd0
         oX3WdG94wBeovCVbLngT+x2pFaAU2/mrlK4mXyDzkEx5O685ylrzRTzqFMOJ3oMficqx
         Gotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772743069; x=1773347869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6qqlYUk2uLknCELv6zwONHG5x3atJmpFah5PNZJ3m1g=;
        b=fEMC+cHGPvE4zpMUWQ+zrJAupsYegPINGrLsG5V4ksTHQgTki+mjybgY3uZ2VUZA5/
         oSyUeUwmJ1DWGT6rbrjcpX1kxWC5JDaY5mvZn0JaNJfE4tp+JvRgsQ2xlTXxSGi1AEbR
         6vqjuoGqIpKUU7hxA2MryeTQdtPnKcXYCa2iZ3wR/tTNZ3yRapKYif5kuxQZVwDJ768I
         NjEsW057BTZsZf6yQlgKwzfYBpL7e4MdKJw5ZfVDhHCMdDfF+jQXM5w+gorHk660ffN3
         zSnLddr9OfkMvyWcI40K99Z4VXX5FhUDZrraFk6dx2D9J/+D9ptynz7sKQZ1x+ZYdYl6
         F6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJJoFb3e90ryJX54EAkTzKYoz17ZqVXqOLLf6pQNd/6nBILtZVZdfwdCUCzC43Q6YlgKoHJgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhe91brHhGPjzGg8MhHbF8W123nWlJXYb//UvM7NYjJ5WKYCse
	6Y48SlGR1YqPQY49EES28wxO3R8hmTwlfgO71mI9HydyLKImaHak/apB6ZEcdLdYNpw=
X-Gm-Gg: ATEYQzyeuWtGzkZQgM8W5l6JvuUo9boWrOXvgFmCHSMZn2i9JUrA6cRkuQ7hfu0CJ9B
	3eUxWPmv+xLrX+iWN7yUfGvowx7HPsBd8G3MD5C/8dC2UR+CP/NhbSTzsVR/oFvz5PlGh8Dsm5/
	5rpALCiogH071Fn8C02u8OgR2xMvA/WsPF5GXONaZUXCI3kpHPQob1TUUJUJiLb0TEVBJRkeTT2
	v62Y6BlSsC4qwGhuxIj2UxVd+ooix8yYA1jjf7ZFBTBTarocUky+dysGZoslHwR+0geUKkYMIDk
	7yNMw4HCCq/9zvbgZ1jPZWkrNXBVWSZY5LOJBtUQbU4B5cXeL49l5X0BgdFwjr0s7y6a8eUTLKu
	HKd+QZ0WXJvffCqyDhbh+E21lFbwioVJnr262iNv5NZd+ahDrlxhzUN6W8Ca9lSh4hpO3Cdrspd
	wmX0VZCatVoQ==
X-Received: by 2002:a05:600c:3f10:b0:483:b01c:9508 with SMTP id 5b1f17b1804b1-485235a78d8mr14649615e9.2.1772743068926;
        Thu, 05 Mar 2026 12:37:48 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffce11d29dsm2610413137.7.2026.03.05.12.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:37:48 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 05 Mar 2026 17:37:39 -0300
Subject: [PATCH net v2 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-net-nd_tbl_fixes-v2-1-b7177db1a9f3@suse.com>
References: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
In-Reply-To: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1772743062; l=2193;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=Yfucwf5JHvyU/znf9S6sDQrRZ/qy3di3N5iSoXWL4aM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QELA4fZ8Uu1G8uhu9+u3KMAefcDUWGgV/dwgvshG/ifXp0EaQKOUYgVehq7+ApJEY+ASGkfwf7P
 bFe0OGSXMmgI=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Queue-Id: 5869A2183CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264538-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Action: no action

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called which
initializes it. If bpf_redirect_neigh() is called from tc with an explicit
nexthop of nh_family == AF_INET6, bpf_out_neigh_v4() takes the AF_INET6
branch and calls ip_neigh_gw6(), which relies on ipv6_stub->nd_tbl.

 BUG: kernel NULL pointer dereference, address: 0000000000000248
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:skb_do_redirect+0xb93/0xf00
 Call Trace:
  <TASK>
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __tcf_classify.constprop.0+0x83/0x160
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? tcf_classify+0x2b/0x50
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? tc_run+0xb8/0x120
  ? srso_alias_return_thunk+0x5/0xfbef5
  __dev_queue_xmit+0x6fa/0x1000
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? alloc_skb_with_frags+0x58/0x200
  packet_sendmsg+0x10da/0x1700
  ? srso_alias_return_thunk+0x5/0xfbef5
  __sys_sendto+0x1f3/0x220
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x101/0xf80
  ? exc_page_fault+0x6e/0x170
  ? srso_alias_return_thunk+0x5/0xfbef5
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

Fix this by adding an early check in the AF_INET6 branch of
bpf_out_neigh_v4(). If ipv6_stub->nd_tbl is NULL, unlock RCU and drop the
packet.

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support supplying nexthop")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0d5d5a17acb2..ff02dbe4c94f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2335,6 +2335,10 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 
 		neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
 	} else if (nh->nh_family == AF_INET6) {
+		if (unlikely(!ipv6_mod_enabled())) {
+			rcu_read_unlock();
+			goto out_drop;
+		}
 		neigh = ip_neigh_gw6(dev, &nh->ipv6_nh);
 		is_v6gw = true;
 	} else if (nh->nh_family == AF_INET) {

-- 
2.53.0


