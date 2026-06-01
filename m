Return-Path: <netdev+bounces-293708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI89KNpxHWrFawkAu9opvQ
	(envelope-from <netdev+bounces-293708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:49:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C8E61E995
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61FB1305B23A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C923630BE;
	Mon,  1 Jun 2026 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KezbiGy6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DD35CBD6
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314476; cv=none; b=T6t4icvOl8i6JK/Ad7mFx24Ec18cN9LlBDTCCbije8jI5KN58YBfQPabTerVd1uiUoxdgbLdZhWS7jE59HzRPYL6zGXWkD5/khmWSzb0t2+HxDxEfQ/Ilpapr80geOhknGBJ2DgxIW5NnYcsuBlaDVg/tRBXmSjOKVGQVhcD0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314476; c=relaxed/simple;
	bh=cI92tb8LHga7/xRrXFRKJrWhhjWkamgeEJYqNsajcWE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U3E6dsFelOqBPwTWX7iKZzdRes/ohPRx81Nq+D5f2DWOn0kCVy9kYKxjvGBsefPCQiWO4WQ3cMKuI90001MXsshU9xzaJ8ETrqTrQaq5YPeYkuh+x7r/j1aZ8OywKBseDlFmLBTXS+60tl/ZTFFSTYCR7byXaxINZ3Sj7QHnRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KezbiGy6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0bd02d97eso15508445ad.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780314474; x=1780919274; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDQgbKGbJHItkkTgGoXZSz+st4eLdSdS2/oELqMd77k=;
        b=KezbiGy6OrcZA9hLY8pdIaqFdZSSaDvAxBl5FPYBXRHc7TEP0+i9yj+54/pDuNIIhb
         KZlGKmjMO9atSKn/otuy6MmX38oy7CkfyLNaYy5gvfbq7JMcotMjbML+A+3PUZgrHq5N
         WqPlBTozu4VljoAe9gW6SjVpt0tmYItJCvkHFpAfRWUi2Q8WxtzbU4aL5+wo70pcMEK0
         r6yD7I8m/bGOS8EJT00ZmIeeO8uLkpNAVYyHNwbsKVQ26GhVXDRgM2X0lcidSH9+L6iD
         +QC+DzM7CVt2HTh5SC7sAT7M5LhG475XDIqLiCYbyIu2zf+OPjrTUfODa/yTX5MGKT8Q
         j+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780314474; x=1780919274;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDQgbKGbJHItkkTgGoXZSz+st4eLdSdS2/oELqMd77k=;
        b=X8OBj2nQ0T4BFy3mmnLVt+neEOcOpy9URoIpTb8YU9u0oeNe8+Tku01m7lV+kxavdE
         eHfSePCfvkp9/hVTgrI6uTbnY5mGUkcAFVkS995QZy4qy4pwhT61VtSufrjq0ZuZEpnf
         TggBquasuCEmz2yuGpoGL29vfopEMoU1HR7QN8rZl7ckktJT+4SQvbMbpTH9B10qJYk/
         rdkCNqRJ/4rmrIZ9SHvpIX18zSDX4TJTnTaQjXC3NMBOMJi7l3+TZ0FVmXdU8baPrl9B
         G+zT0/pfoyK42mVlcoK8/zk8BYd9bikMus8O47nzu93Yrf31R4dwPWtPlRSF3WuzBK/A
         BLyw==
X-Forwarded-Encrypted: i=1; AFNElJ9TwLAAlU6yt0a4re2PTDOaJb4D+AJmEsMCsg1vGZJFU+cwC+W+hbobMH9alKDlsQRCtNdCfc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPOpHmHwB55enun46Z6tWG8nrYwpj5e+UMCC+p5+D8Pzrp4k1
	3UrhSoF7AXJjUxXp4mzi3ImUTbpgp3CEPB/oszIKgRB7XF1kwtuBsLIx
X-Gm-Gg: Acq92OFq/CXV9+VQpQfj+tTfxYp6O4XzL1hK1OJRaBTge5kqkkdUh/VLL7C+gnYt3/v
	IB7/Ob3mIASqPevAGcxDDzl7lFh5oOgvj9H6ffeeuVtjxCTzljTl+cGxJrz5q/tCKwmR0rxjC2y
	MQwO7Qmf/viisr/uzznnYwYmhvU3aGDfo6K7bvMJzv6wZUf81sP8cliaE7sH8uJvuk1kL5XgDJw
	VSM2faJ4i3lN8IXEXCZHRLLzSfa5jpLKqX1YzrSRUT9Va4rdg/B//bPNQCE1Wn8SC6Nfstu+TIt
	HJCYA2D+7X+H/OxDZeyaF5RWgp9Xc/OGNhUCAsGfKNMTg64mCMGizzfHAiTjMe5kvEkKuLW84VE
	d0JIzD/O28YId8rDYQ7n4WMNsuWFFYt96p7Q4EQ+tmT2IU3fsu8Mf5lvuFPeRd9G8dGVjZb7SPa
	c3FU1hgQEZ/CK+DwAPWKb32/F3QshsNrwgrRbSHDEUm/AsZr21KkLs4A==
X-Received: by 2002:a17:903:3585:b0:2bd:eeb6:ff28 with SMTP id d9443c01a7336-2bf367c3452mr122807925ad.12.1780314474104;
        Mon, 01 Jun 2026 04:47:54 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e5d83sm109854925ad.8.2026.06.01.04.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:47:53 -0700 (PDT)
Date: Mon, 1 Jun 2026 20:47:49 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH net] rxrpc: Don't move a peeked OOB message onto the pending
 queue
Message-ID: <ah1xZeGAjQQmRYu7@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293708-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 18C8E61E995
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rxrpc_recvmsg_oob() takes a received oob message off recvmsg_oobq and,
if a response is needed, moves it onto the pending_oobq tree. However,
only the unlink from recvmsg_oobq is guarded by MSG_PEEK; the move onto
pending_oobq always runs.

As a result, reading a challenge with MSG_PEEK leaves the skb on
recvmsg_oobq while also adding it to pending_oobq. Since struct
sk_buff's rbnode shares storage with its next and prev pointers,
rb_insert_color() overwrites the list linkage, and the skb, which holds
a single reference, becomes reachable from both queues at once.

When the socket is closed both queues are drained in turn. While
draining recvmsg_oobq, __skb_unlink() follows the next and prev
pointers that rbnode has overwritten and writes to a bad address. Also,
as the skb holds a single reference but is freed from each queue, both
the skb and the connection reference it holds are released twice. This
leads to memory corruption and to a use-after-free caused by the
connection refcount underflow.

MSG_PEEK does not consume the message from the queue, so only unlink it
from recvmsg_oobq and then move it onto pending_oobq or free it when
the message is actually consumed.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/rxrpc/recvmsg.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index c940600117a4..bc7f8a505595 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -262,12 +262,13 @@ static int rxrpc_recvmsg_oob(struct socket *sock, struct msghdr *msg,
 		break;
 	}
 
-	if (!(flags & MSG_PEEK))
+	if (!(flags & MSG_PEEK)) {
 		skb_unlink(skb, &rx->recvmsg_oobq);
-	if (need_response)
-		rxrpc_add_pending_oob(rx, skb);
-	else
-		rxrpc_free_skb(skb, rxrpc_skb_put_oob);
+		if (need_response)
+			rxrpc_add_pending_oob(rx, skb);
+		else
+			rxrpc_free_skb(skb, rxrpc_skb_put_oob);
+	}
 	return ret;
 }
 
-- 
2.43.0


