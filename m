Return-Path: <netdev+bounces-273777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OjmE+dSzGmvSQYAu9opvQ
	(envelope-from <netdev+bounces-273777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:04:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A195737296B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E734730B88CD
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F124611CE;
	Tue, 31 Mar 2026 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/UTOowP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB882FD7D3
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998035; cv=none; b=mmB6qpbkfpSlpCWHN6nBVLRsts6P6iTZT4YCe14SlyedaRIw6rYYkING8anApBQOgVzbyFpn2O7tyojLmE1aAD9eVIrLiq/yU46vZZ9qMClHA/STcHDlP6M6LtfoDjolERcJhMM6bD/haBjbxSrLBN0/8EQ4c3rThJxx6BTcqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998035; c=relaxed/simple;
	bh=ebB3tFe7st0ChlV9KEmkVCHkBQRl1ZMa/WdScimdd9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3p/bNXgA7Q5xrAtVB4ooZ1aynpHkH2y5hzNa46iBwFcxZ+X95FQHFHKL7YZGMdONjln0OXr9uWBgMtxxf9/d4yZeBhThGZdSyCqBa6SYYXg6dt2yOul/z7DG2Iu9L9mWBxyp/0/XkNWG+bI3i1TI1Yh+VpIK/RSONswK8NVtKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/UTOowP; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56b7fce3ae6so347637e0c.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998033; x=1775602833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ya7/v/C2ic5WGsD3LIjfz1NrbBwmNrzBq94qY22p7kA=;
        b=S/UTOowPngScjHxsuMUEcHpY/ce8RmIUfVRw3cDeaqvtLQ/tX4xyZ8J8AJVX7U5GJs
         mJ2sjb6nTe2BanqMOanOyewVitFdXUGvK4a3azlWuBOhgSfjAigvkczxTKNS+bafpaDR
         xO/lhZLsEHlomJ47l6m9/Z5oiCiYADGMt/RdeofbMcSVMvwN+a/g3l6uP1foZ44XLch3
         znzecaGkW08tHm4odtLNTo3V2uK0HC7H09tcdogRqxc2pjdtSEOVkBfwbPBRWumAbCQ+
         3/I+LFbEEQRwN8eIhcSK1+D9anaiKDDBp9KBok4FqVa8yeQy8MWAIIGH3fl9ysnXiX4b
         dBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998033; x=1775602833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ya7/v/C2ic5WGsD3LIjfz1NrbBwmNrzBq94qY22p7kA=;
        b=Ywk47U+serFwMwXQFSMqYBXhDTpKTPj8sljZ5yuKCsTj7yD8H1YMSeP9bVNyjTKQNh
         J/ZQbKAlxaJnPiMSPA2uMzW/iJzj33lvkS3p2GiPnw7WR0J9l+TciKJUTE3wzSY+pnxW
         b5W3lzQztD2zIE2lUnCWE0PgBwBf5pzToOYLoW9UbuKEb2ju/4hL7OuSzaQSVT6QvsSd
         n2YJU5qS80AC09AAhW5LHJz2Fv1Lrjiu05tTa+BRUDUrvXhl2nuYehSTo/vBichPH6RN
         yMR4EPhQnMxSMRoibPyYc8I2shYMfFMlq//TiA6RXAJAloEAvwgtzUMPzFwaS7s0mWnL
         vtNA==
X-Gm-Message-State: AOJu0YyVMvO1NHIiMesA4P+s/DPcjIBxtTTI71+4wpCrchPE2w3xmO4I
	n0EE+Y4kT/L/JfRt+HzEnJzgX8uFLiqo2SmPRv58/McJIbQlM6DeEQwa
X-Gm-Gg: ATEYQzxImwIrVWAmat8Ti/jLc7kcDzsOLQwYOH+2/2sq9Dm2gmT1A0GwhlNEkHcBt/S
	Eh6jTdlSP2V63jfOTdwoSFWo2Wa6D+B3wY++5gnQywIQ2GF+loeiRDdkYspnN+kamMuWACmXLF+
	lAty8PNTeUEoGMtXrzkto7wz80Geko7cUUFn7KNRHAx4l5t0iW6+Tpl+2wn24/6xM1tkyYsofHY
	YCe2ZVZNHWmTEHqEhGiGsZWXvFfNtJ7XmpAo1iqv5eWuxE2T0jnqKLQ2DSvFMfdIHHh2WqK7VEx
	XIu4WQoiw8SUY+GHFtRZa7XUgc2xHLtMNsOaU5JgAZShdEHkXihs1TE2s6n5bmXukbMKnbJifdF
	xeBpV45uKEe/JIAQIPxuDaKHipzEveFlHlMzyjt5v/MRV1sQ140eG0ZN+khELlkuIB/ck6XkgpU
	HIzhkQE8n9HtF6UDK/7SGIABIyqOYs71E9pNYmgw==
X-Received: by 2002:a05:6122:2224:b0:566:ec03:4683 with SMTP id 71dfb90a1353d-56d8ae13b72mr522364e0c.2.1774998033459;
        Tue, 31 Mar 2026 16:00:33 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a7ba96sm13948214e0c.17.2026.03.31.16.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:00:32 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 31 Mar 2026 20:00:04 -0300
Subject: [net-next PATCH 04/10] bitfield.h: add FIELD_WIDTH()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-realtek_forward-v1-4-44fb63033b7e@gmail.com>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273777-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A195737296B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some hardware stores logical fields split across multiple registers,
requiring partial values to be reassembled using shifts and masks.

Add FIELD_WIDTH(), a helper that returns the number of contiguous bits
covered by a bitfield mask. This allows callers to determine how much a
partial value needs to be shifted when reconstructing a field.

This complements FIELD_MAX() and FIELD_FIT(), and avoids reimplementing
bit counting logic in drivers.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 include/linux/bitfield.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 54aeeef1f0ec..8d6c1c309c3b 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -111,6 +111,19 @@
 		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
 	})
 
+/**
+ * FIELD_WIDTH() - return the width of a bitfield
+ * @_mask: shifted mask defining the field's length and position
+ *
+ * Returns the number of contiguous bits covered by @_mask.
+ * This corresponds to the bit width of FIELD_MAX(@_mask).
+ */
+#define FIELD_WIDTH(_mask)						\
+	({								\
+		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_WIDTH: ");	\
+		__bf_shf(~FIELD_MAX(_mask));				\
+	})
+
 /**
  * FIELD_FIT() - check if value fits in the field
  * @_mask: shifted mask defining the field's length and position

-- 
2.53.0


