Return-Path: <netdev+bounces-273457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA09ErlGy2nSFAYAu9opvQ
	(envelope-from <netdev+bounces-273457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:59:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2137363CB4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61DA6305C4A6
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972F2C11E4;
	Tue, 31 Mar 2026 03:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwmN9fp3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57FA1EF39E
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 03:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774929419; cv=none; b=u3k0BRnUxrzCH602M9L5wUKrr8BCLAp0iDbSMm6z5kTtRe3CF4htBmI5Rb73pdNMEsIlK7vgZbuXOeCNto7Q64817kC4cNCyBRNYt5aD1YeSp02V3vRcWtQg8t59Djw/p7eZtwhYynSS6B1BLHO1MQ+cw3Gq3Pnex5JL3WKhAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774929419; c=relaxed/simple;
	bh=sBpTeIDTxFTEcP1EdffM+/HbnMaP4LD5XXijFqb4WO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IigWw3Yn+Zr1xOJH7F6+DaOHwtArgP3wQDUscyAFnbClL5SDupd2GE9llopAJu0LMYVAyrTdACelzzNkcgWV+6Lm1RDbcehJWbw3y/FvBTj9I2LxBfM7qr6PoPLUjqn5rOpj2w0YCAEN5/rfS5E3GGu+JizKGNHYTXYKY0WEpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwmN9fp3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76af79f029so173265a12.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 20:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774929418; x=1775534218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gJ33OB4rjx34cR+Fv1tlLCTXuTAsGru5JzrTqHdTao=;
        b=GwmN9fp39wdt/IxLIBbfJcb+sYUVSrctUVc+poyxZ1aLDq8MTNL0Aa1o58JL3vprZW
         ZW4++IOUw6MSwmJRG3A2EbqN/P+XR9DwZREB168enQ3i8nc5IrCrGUlYyX59KnzZ+JS+
         +7XfjOaITTV2FA1F9UIqOZ9zsnI87EVhKUOKNCl6Fmoj47aVEL70wERNWF+2mUHXhd3A
         XLDw+KVC4ZVWsTkO8YiF3K+qTitGPbxV2QRMif69DVzIAH9DBVPduu303S/5JD+8MPBF
         WlBap3AUuqKuxO+WDbQDzvuuG6e54m5kQ0Y8XoNidGO3hSPOfu9Vz0qq1fZ+IERIk0zY
         Bd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774929418; x=1775534218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9gJ33OB4rjx34cR+Fv1tlLCTXuTAsGru5JzrTqHdTao=;
        b=SQylI3YDRlwNqOQcmJLAOl7mi8fob0lLxasOA2P56TQOy0mXczgkU3NrV6aloihlUp
         /Twy0smMycP/6bshnZiXaeO2pDovppCjsOPWWR4QfTy/JoAoSlrOWOUlFWFmapXbDXPJ
         D7qkvb9cQXDY9XcsaLG+4nIvUvrbdJ76Yd5USgFPkyC/1uRXo5EJQpzu+eDn6F1uEc89
         cLXngGLpXZnZRCD3ChVmATzOWIzG/Y9jPJEXDccLZe74sv9r3a4JQBNLWVVy/o+Vzq7c
         xKgkek5bJXq6FDiXeX0Ov2tUQe6fO0c0KxhcV/ocwYNxdATqzAF/oOqgE5Mlzc62YjRc
         wpYg==
X-Gm-Message-State: AOJu0YwpQVZqJoqZa9ZcaKP5SIuBklGZ0n1vuo613U7enJmrsQO7mGU4
	4YZa0HbJKoi0475JkD9gCJGJLmmDQP2G4OSeMIpR9v18KFWubW8TUhoC
X-Gm-Gg: ATEYQzzouAy92/ELD5nbT7/n0U8jOEpLuGcb00Ry8mdQO8CY4CPtiRhd8dl8Ep3Sq6n
	07Yfo2xJWsupwXuOtLckSs7GDQDtyqGHMXV7gcO95riLXHx5VEVc+YMAop49ze3V8UpGbCgpUsp
	5sj1DzUFsTzx1vcHNda3Plrf00YltvYwJ/RLOSovtUvIIMvCc137dZU7B23XiGYYfGMREJnRMV1
	Wn+p2D69GvGCUErF6eozuQp7Cotxq0Q1GPNlPr7n03BCpO2JHLsjk4hlZoTTBOjPcgjfuyAIgPD
	ndjKMmP159g3wYXcgAAHLIEC1kLUb2EH068xExpxYZvWfAw1Qi/pSg4xfg+b2zPmEGkAk/fKBxZ
	8tQNXnBwg9G78m6jABvDDuXbi6TeTBiv4cCTy4102tWhzGembORVUw6R0NV2mTs9oriS1kRUDad
	JF9ULkEoI/hKDRJFN3kCEJP0esDxXT34PJrQ1l0NHMS6RP/cZUyth50NKO+wAa5hKgrVx+XXJrP
	ARRrQjXDCmmPbD0tgyNPAin5112q6Z11Pd48GGUoR+4zhbthUk=
X-Received: by 2002:a17:903:1aab:b0:2b2:539b:d29a with SMTP id d9443c01a7336-2b2539bd632mr62814925ad.23.1774929418137;
        Mon, 30 Mar 2026 20:56:58 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:500:c92f:4f4e:9953:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266e487sm94680625ad.24.2026.03.30.20.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:56:57 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 31 Mar 2026 11:56:13 +0800
Subject: [PATCH net-next 3/4] ethtool: strset: check nla_len overflow
 before nla_nest_end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-b4-ynl_ethtool-v1-3-dda2a9b55df8@gmail.com>
References: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
In-Reply-To: <20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-273457-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2137363CB4
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

Fix this by checking whether the size of strings_attr would exceed
U16_MAX after all strings have been written, and give up nla put if so.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ethtool/strset.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index f6a67109beda..9c502b290f5c 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -441,6 +441,10 @@ static int strset_fill_set(struct sk_buff *skb,
 			if (strset_fill_string(skb, set_info, i) < 0)
 				goto nla_put_failure;
 		}
+
+		if (skb_tail_pointer(skb) - (unsigned char *)strings_attr > U16_MAX)
+			goto nla_put_failure;
+
 		nla_nest_end(skb, strings_attr);
 	}
 

-- 
Git-155)


