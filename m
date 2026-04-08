Return-Path: <netdev+bounces-276319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI1cJ4r/1Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:11:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6583B7F1E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3DD7306CA20
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F989377547;
	Wed,  8 Apr 2026 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLI+YVNh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3137702E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632159; cv=none; b=Q4EejCtsP/R/s+AEcrhSWxXXyk7vuFq1cxrPBWtxcbDx3MrHz8jPIz8aUbfEnVQZVL5PgnJwQcA5UfHl+KtdZ3mEGHYwqgQ7Zm0Z1iWeuIleCx4tW0TWBa0o+YhpUY5iRTpiioEazvXoGat0+Bd4upSNZNZ9C97hWt9uopS++LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632159; c=relaxed/simple;
	bh=arnp7gczBQAyyQIAMvp6Am0+WUL06koxo245kjp/MoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCiHzsSaGJhqgy8iyFOdBCDH7KbwTQr/2SGYY0TZ1njoM0Fbt8TG2gMhTW8syrwAtdpjRzWX7UHLNFHfZ4DQ2q9u/tVoGmtmF5WTlQF4mtdYo1nw55me7JKFybtNMxcWmOmSjP4F4fTGpqaWvfYwiWI0XmqfTSQVyZpLTrEX+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLI+YVNh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so5639595ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775632157; x=1776236957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHfInxTMO4F5kmKiIP6zRL2QqGxjyp1w4ES+9lythuw=;
        b=fLI+YVNhEyUhuDmcXkH5El4vGdT5dg8cfhPn8N/J2Z/xWn/sw3NePx7sZSZEpRblRv
         xe4TKBPpj4rUtNO3FHr8f52DICz4unSqOOnSfPl/bibcHhRiQKxknK9tEjuft21DZ1Ko
         zI2h9Ux1v5fU/HIkzYmJHf8NY/xYeJuHzKVqrWVz063H2SuGur9JJOUqaOp/ODlue0V3
         d2sbyUiVcb9gGG/1yMIIq6kjwYIeoKX0VUYqd6XP/aU4bwhGXRTIsdlen4FIY/leuZcR
         bfGIuAwAtOB1rRmvKhgO5DCx2GDzUfJQh/Hi5ZjUnrGP0uIAkEQM04QjEPTwt4pP3o4x
         tB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775632157; x=1776236957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SHfInxTMO4F5kmKiIP6zRL2QqGxjyp1w4ES+9lythuw=;
        b=X11XfeGUMHFBp674X2qpuRYGv7ahugYucNAMo+Z1H5iPxDszQIJ5Bnw76Yyynt2Er6
         6PC7vyGRIRBzp79sBXpxj3zLtHljWqRSatYoTX9srOxbNtrzCWzzqN5saEr0zbcTpEiA
         aWYg26WKN9UJ5zdGLOtt2blxpKin5Eujd+fbJ773cOzkpWiJKHPkLaTfShzl88j31z7y
         Osy6yUkhQzTAFeSaaULiUS17TOgi86gBj8sddm+YOQqCJyFYp20hdbFZPfimGe2SpWV2
         RkWSVbSs17YIW9k/GX79KhyNvldslQ/xbl2FlNTBaK/rJirlKCs3T8VDtKgrNqVWnGrC
         L71g==
X-Gm-Message-State: AOJu0YyHArRlPUcNm0NzPFdH4+DSSvjrOZ5SIoaoa4TGvvlh0iwe/0sH
	X1WGDcvay5//GipPuDzphRXa5dOkQ+V77N4qXm909n+92lBEa8pzX1zQSxp9boclOwA=
X-Gm-Gg: AeBDieshtPaKCzNh0pEoN/NRzt02xNfodU8BfzAHJFlLDBxjJ887rukT0+8IlrFDkhj
	BEaaXhBvJm92IroLzBF6pT5wIc6FsoJUQ66H/wG7F/fF84QelDg6b8nk2o6JFkUqkahHkwD542z
	BRG9kNkfyNEOxRMAs+We+Ct19tTJ515I06z9icJtlLjTI/BW1iWDW1/pBabprrR2kU7rWM54M4g
	DQixYPVl09KhnWUNn3xFKXWq3vUfnO44n7k4Ge0A/bo9XiqdE4/HjUfLXsKm3WVxNZB1taqLyWZ
	VevDdlzL2Wu/CEgVf5ZHGKbCxBPNksdixoA7neH8OJVdeLThgxtod2QauVP+VS/nPYZdjG+mSbx
	2u56xmNxMC5ZpRAdrnW+xX23l2ph4eEMmI62I4KhLWTI2qpAmPspsmH8NkMxJyx4pmDprjGpHtq
	wrs1KrcstCBjMoZPvVSlaTxDWp7YQQKixsAtt+AHMRMsOEDeid
X-Received: by 2002:a17:902:e78f:b0:2b0:b258:2a57 with SMTP id d9443c01a7336-2b277e7ebf0mr202325165ad.27.1775632157316;
        Wed, 08 Apr 2026 00:09:17 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749b66aasm202917785ad.68.2026.04.08.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:09:16 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 08 Apr 2026 15:08:52 +0800
Subject: [PATCH net-next v2 4/5] netlink: add a nla_nest_end_safe() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-b4-ynl_ethtool-v2-4-7623a5e8f70b@gmail.com>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
In-Reply-To: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-276319-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A6583B7F1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The nla_len field in struct nlattr is a __u16, which can only hold
values up to 65535. If a nested attribute grows beyond this limit,
nla_nest_end() silently truncates the length, producing a corrupted
netlink message with no indication of the problem.

Since nla_nest_end() is used everywhere and this issue rarely happens,
let's add a new helper to check the length.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/net/netlink.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 1a8356ca4b78..546d10586576 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -2264,6 +2264,25 @@ static inline int nla_nest_end(struct sk_buff *skb, struct nlattr *start)
 	return skb->len;
 }
 
+/**
+ * nla_nest_end_safe - Validate and finalize nesting of attributes
+ * @skb: socket buffer the attributes are stored in
+ * @start: container attribute
+ *
+ * Corrects the container attribute header to include all appended
+ * attributes.
+ *
+ * Returns: the total data length of the skb, or -EMSGSIZE if the
+ * nested attribute length exceeds U16_MAX.
+ */
+static inline int nla_nest_end_safe(struct sk_buff *skb, struct nlattr *start)
+{
+	if (skb_tail_pointer(skb) - (unsigned char *)start > U16_MAX)
+		return -EMSGSIZE;
+
+	return nla_nest_end(skb, start);
+}
+
 /**
  * nla_nest_cancel - Cancel nesting of attributes
  * @skb: socket buffer the message is stored in

-- 
Git-155)


