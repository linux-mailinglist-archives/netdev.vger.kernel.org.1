Return-Path: <netdev+bounces-276320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MK0A67/1Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:11:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B8F3B7F5C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D2C13037F28
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF69378813;
	Wed,  8 Apr 2026 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF7ko3im"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FF377EBC
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632163; cv=none; b=H/KkAXkkLzHajPwcCBst4ox8apsac+UryxYtQqrkF17eDJLKLsZwDPQt68duwEI1P2MCtWmnrb4MS6P0LK6AOS1uTt3mO258px1VbDPXah2VVQPDuh/n57VcqbRpZku3hP7gu+DI7/DpLsSL/6aJMy7iqiWnetX9P9v8QXZ+CHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632163; c=relaxed/simple;
	bh=Vxcbk+0KCUKwsKzBSHDoUBsC/cy/EaOWyXcWYWFiBvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crZU2tZhEyx8e8sSJVV9oV9hMi/+X97XR7lL7McbURFiXeNzdymDYZzX2f4fIds4MjzlcvLMP8cVCujWxDV/noj/2aQQJZRROIydN/0X9iURKGDdgZeBHxQ/NzPRe9y3sb/cSbYn/dI1Xwhm8YQvgJ97gJE5eyMCJHcAnP7zdeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF7ko3im; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso5054910a91.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775632162; x=1776236962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7XcPeFEkX6jrjhcG/SmkZCF91BEDg8hDcsanGa5vj9c=;
        b=ZF7ko3im7Eqp9ltSq86Cpu7qLZUz1f/L7K8ULy1zPzOOVq4/ETrPgnGPdfLF2k6lDu
         swuXtJX89wHg967f3UdyKTBNVSBOd8EhYN5etuiO1gSNP0g401NIFp9uXUzq3UF7peFS
         OdHb28tDUgM8+VhcvUEGWtQjRZmQ/mlVELrGfI5KCxkQ4+vSE8ae2ZznpWfOGeHZlab3
         9TGjVBHR6oAhghD7kW/19ONanJepGQfdFucJKrErESlXuwno8MpK55gWwKTy44+GIC3M
         aSpAu/POrbVGnevNDpjKJIWsfAJWL1FcwL3/P0nUTDbnh55Bz5HIjK1Uwr9xMAU1ghJh
         hnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775632162; x=1776236962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7XcPeFEkX6jrjhcG/SmkZCF91BEDg8hDcsanGa5vj9c=;
        b=b0xWjgMdyyQ5hW2AN+S7D+sbxXIRS+jpsV92KVCd8RcKXNxYicLX99Hgq0DuG83Q33
         ck7ySndR4ttiJQCTZA9c9G5H065avwNjbA4Z7qW4KPyZ2XkBL0vbuJHuI7ppXM2dmghv
         hSGiarOim5CWFWTmt4oGML2Htmve2clXlmrk5diJh1y19SczEMFpau/sRekGc1Xmptkv
         09K12ANVXKTVGAH+7GxMrwNu66QDvK8kSERGWjMqlgi8tzDMdBEFj7zAXN5nvSgo1rMV
         XAP4g05NCS8XFd+g38OqyY7ufu8ZUbl9FXMsCKzqrgS9gzH6yQFNkBGT1PwVUbSCLOxo
         rbng==
X-Gm-Message-State: AOJu0YyRhHTF3hU1jI6zfe6LhPlJCq+jvUTeTTL9bxDoSUCGP1Wxdrt6
	/laI+L0LCBmLz7QnEOeo1b3Gxbh0fz5PeWh51VbYLrmoLT61VYi84VLn
X-Gm-Gg: AeBDietcL1nLii5zRhB5PKAmJTXqz7yaZmvMV5syE+8uyQg3GDUsa2cpshJPxhyiWGr
	kZQBWsss2skXGsrzeMJFUy5Vm5TT6l7g2tNxXt5XsQmlJjQ4zQ2MtZsuHYXN1XVtF+B59v6bNMS
	4l/zay4Y7Mqnjvw0Jvfln+y3t3j0UaAFCXk/iwPpS5KY7bYm4HkJCmo341UzC82lsijyKbBOham
	WG0a9WRBRbOd8bpbthRvIcQRS3gEU58Pdl4V1d3wDvkxsGdAZ0C/dvezCbNS5bJeUhSEp+G27ZZ
	WIH9hINZMW4JKioUIm3+Ae3y/crCWnijbiAP1SRwcK3s9/akGDx1hJ7UeD/2WyV57ExlG7TOzKS
	P4JMj1k0U2QDar3WbgZ1z2V+SynIxziHooGbQifo3jfCogvjmq4JOcIA5vprPLYRH6rdF5IlFVq
	zw+Y0dIltBsxZDjLfWnNlHHo2lx6v8P4gIqdApnp/Ic9ubY1MC
X-Received: by 2002:a17:903:b0e:b0:2b2:52af:52b8 with SMTP id d9443c01a7336-2b28184a5cfmr209513175ad.11.1775632161906;
        Wed, 08 Apr 2026 00:09:21 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749b66aasm202917785ad.68.2026.04.08.00.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:09:21 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 08 Apr 2026 15:08:53 +0800
Subject: [PATCH net-next v2 5/5] ethtool: strset: check nla_len overflow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-b4-ynl_ethtool-v2-5-7623a5e8f70b@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-276320-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 75B8F3B7F5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The netlink attribute length field nla_len is a __u16, which can only
represent values up to 65535 bytes. NICs with a large number of
statistics strings (e.g. mlx5_core with thousands of ETH_SS_STATS
entries) can produce a ETHTOOL_A_STRINGSET_STRINGS nest that exceeds
this limit.

When nla_nest_end() writes the actual nest size back to nla_len, the
value is silently truncated. This results in a corrupted netlink message
being sent to userspace: the parser reads a wrong (truncated) attribute
length and misaligns all subsequent attribute boundaries, causing decode
errors.

Fix this by using the new helper nla_nest_end_safe and error out if
the size exceeds U16_MAX.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ethtool/strset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index 9271aba8255e..bb1e829ba099 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -443,7 +443,8 @@ static int strset_fill_set(struct sk_buff *skb,
 			if (strset_fill_string(skb, set_info, i) < 0)
 				goto nla_put_failure;
 		}
-		nla_nest_end(skb, strings_attr);
+		if (nla_nest_end_safe(skb, strings_attr) < 0)
+			goto nla_put_failure;
 	}
 
 	nla_nest_end(skb, stringset_attr);

-- 
Git-155)


