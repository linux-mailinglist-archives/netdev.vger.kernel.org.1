Return-Path: <netdev+bounces-299797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CkdiMNEfMWoEcAUAu9opvQ
	(envelope-from <netdev+bounces-299797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:05:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C7E68DDAC
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:05:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299797-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299797-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0606D304A8FA
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2284279F7;
	Tue, 16 Jun 2026 10:03:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC54183C9
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:03:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604221; cv=none; b=KLolFs5HKCEiw4IrY8hQy66eS7a64G1KfZtSr6/dasNOaZ2wzlXYEjeAyy8DBLo34zILcLW5jD9FICNMci6d937gxEky6hMc+tjgEfF0eb5fkTUW6rBJHVFFj3HlnlBnXtt9MeyuEyUudCnF7a6YxTk+ElJNeIKfMy16EJsMxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604221; c=relaxed/simple;
	bh=cHY9Abcv4JeQfjc0VTlYZepQDXj06t3VGMBSC/q49yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/Rf1cSJ+ZKzI/6uw8k4iWF58mLte/Ll7jS6xPNBT8pXY+1IjC4kAZ5xGfeb/8hRLXyqUajmaHlQ76FV08us6gz14ZiAYpWz/SMYrtwPeXiWkVxKzLhS0xu5ZNtg7DawbPETkBrmtvTkpW7FFpwjwqDFccG/Ov5IFwjFMfhOvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.65
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-45fd45e596cso2444041f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 03:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604217; x=1782209017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3J3dF/rleitNHrIVaZmT+xGJuXa5FDx3AO/xzdX7Ng=;
        b=MnpE2ffnlGPnoH2rw62Xj73PqvAurYKqWv7bxzC37fS7qUFBfB22pZ+QuS+iJekslq
         vsrYnnqzNqtI8+MeeUmtp2CZRqTm5dHjcPWhoE4AkFZ4vsABgjjhEqHtWnD12rTE8C63
         Z3iFlKuplzwb8znMnGWWnKnA/gJiq6ORSaN8q7xD/FUYNhesEIv78k43oeHxvwdXzbTP
         rzjh1q6IjrE6BUms5yFGzeBm8EMGGphb1WdzBW4zB+8/RVfMzCkaVywreHqncZyL2Bbb
         g1hX0HGcXrYMYye4AoHSzbeaqkjP47YW9eq1dgwA7gzBeH4PWutpgczkU2+fiYI+WQ4r
         uKTw==
X-Gm-Message-State: AOJu0YzP5vimSv7L9hLZ8H7XC2LozDYOvKiServk7W4A0W93q5oymhpn
	BXl0j8uHhKAvqAKQ2b1LQCuXVZNL4qn/KL5ojLZhAHZXUWDsL9JJy2pO/lOCOjDN
X-Gm-Gg: Acq92OHt0yDY4SakutZQLKDsGmvGvFEbE4DjoMeISvMbzjFzJIVX0k9l+GSix/MDb5H
	cVXirjdvX1kEx9NYUWGxKiAq2St2+F5cKF3xmq+b0E45tUqQtdJCCjK6c6TUz7AIWLKHd5U6kOM
	eNaYU/vlXFtQqpp3L2k2cyHSox80Rlm/jqSnzeg19lys+QfzpQZ3ZDDSQFY07bY6GJ7yb+oVWoY
	VB5ge752BGnGicJU6ZVw3BsBXxAsDGgMAgjHoNLz4cZRahbA8XpadUtmj6IhrtZXKZ66ejYglU+
	9frYfoivirC3mvKZbzPpHPS7wE6c+unhB02pqD82LBKz9rc8eCHO4fyjYscFRplZzX3GM1Nf6BZ
	IUT2nIvLgVTk91ssI9gan0zKQhW7PiE8eyt9vdwePP9QkJCd5SdWU/2uJqHlxb0/i5KnCl9HZj4
	zlR8UDTDRfHm85uCqZ5KNwRho+s0wmMA5H6iW2QOdmCe4c2xvFdIeNKCiv3v5NznNBOg6AeA==
X-Received: by 2002:a5d:5906:0:b0:460:3233:beed with SMTP id ffacd0b85a97d-4619f31b6ddmr3918817f8f.41.1781604216985;
        Tue, 16 Jun 2026 03:03:36 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-35-102.nat.epc.tmcz.cz. [89.24.35.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d4fsm46870652f8f.24.2026.06.16.03.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:03:36 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	Ilya Maximets <i.maximets@ovn.org>,
	Johan Thomsen <write@ownrisk.dk>
Subject: [PATCH net] net: dst_metadata: fix false-positive memcpy overflow in tun_dst_unclone
Date: Tue, 16 Jun 2026 12:03:29 +0200
Message-ID: <20260616100332.1308294-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-299797-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,ovn.org,ownrisk.dk];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:llvm@lists.linux.dev,m:i.maximets@ovn.org,m:write@ownrisk.dk,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21C7E68DDAC

kmalloc_flex() in metadata_dst_alloc() sets __counted_by for the
structure to the options_len, which is then initialized to zero.
Later, we're initializing the structure by copying the tunnel info
together with the options, and this triggers a warning for a potential
memcpy overflow, since the compiler estimates that the options can't
fit into the structure, even though the memory for them is actually
allocated.

 memcpy: detected buffer overflow: 104 byte write of buffer size 96
 WARNING: CPU: X PID: Y at lib/string_helpers.c:1036 __fortify_report
  skb_tunnel_info_unclone+0x179/0x190
  geneve_xmit+0x7fe/0xe00

The issue is triggered when built with clang and source fortification.

Fix that by doing the copy in two stages: first - the main data with
the options_len, then the options.  This way the correct length should
be known at the time of the copy.

It would be better if the options_len never changed after allocation,
but the allocation code is a little separate from the initialization
and it would be awkward and potentially dangerous to return a struct
with options_len set to a non-zero value from the metadata_dst_alloc().

Another option would be to use ip_tunnel_info_opts_set(), but it is
doing too many unnecessary operations for the use case here.

Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Reported-by: Johan Thomsen <write@ownrisk.dk>
Closes: https://lore.kernel.org/netdev/CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com/
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

Johan, if you can test this one in your setup as well, that would
be great.  Thanks.

 include/net/dst_metadata.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 1fc2fb03ce3f..f45d1e3163f0 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -164,8 +164,11 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
 	if (!new_md)
 		return ERR_PTR(-ENOMEM);
 
-	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
-	       sizeof(struct ip_tunnel_info) + md_size);
+	/* Copy in two stages to keep the __counted_by happy. */
+	new_md->u.tun_info = md_dst->u.tun_info;
+	memcpy(ip_tunnel_info_opts(&new_md->u.tun_info),
+	       ip_tunnel_info_opts(&md_dst->u.tun_info), md_size);
+
 #ifdef CONFIG_DST_CACHE
 	/* Unclone the dst cache if there is one */
 	if (new_md->u.tun_info.dst_cache.cache) {
-- 
2.54.0


