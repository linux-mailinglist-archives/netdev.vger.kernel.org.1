Return-Path: <netdev+bounces-282110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBppBBY48Wm/egEAu9opvQ
	(envelope-from <netdev+bounces-282110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:43:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9571048CB72
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EF4E3038793
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A203238F255;
	Tue, 28 Apr 2026 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaJDSLxa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244D38837D
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416136; cv=none; b=PuFWsbOXHDkfwutDMQgWHL75ihRyNv5gzBsKC515R2Q5994HIlqmOv12hPuoxWoKFZKWZ3E2OidZQ0y/zWWA5q737Eg0Lzo8/J+bPW8rDOj+WKJdVrUv0snv9KMskOFd5NQnauzAEXPoqFFLeBR7SNmWFUi9dU4hEwp9wVkzfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416136; c=relaxed/simple;
	bh=yr6AoTDFdh4MqEMxnu13OdxlbpWzGzc+BNKVis4NGcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rW02uNZyTUqcHXsrpjsucUExucXP0G5s3Gi5I/Mw522JhO3Txlg8k88/ZVBoWOqyS2FusTBIYIuYNvgNTyIlSY94jEyAXxP64i/br4So2hbeqAk0NFSoNG7y0H+4LU5HTZiKbm2CBR6u4/h4JD2f+vFBV1jQjYWAH/Xl3OC7qkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaJDSLxa; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7b4ee3a88e1so128125127b3.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416133; x=1778020933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2u+rkDBVuW0DwLrX33JN+GmAXBBEhpi2PB6tf5nm73I=;
        b=MaJDSLxavajfyTAEJdCYLscgPlaC+Dwf52Se1w0ySLkONCRh3lvD0nvWTqcSgKT5N/
         clsbq79Yt6nnYgqYiOL42WNO4gWNgtpTOPi1lAEB2TQlqhxVqPaTiF+9Ng/1t75R+4Da
         okaMGdldIL2/B7Cgr6hBux+zeGp7IK/rkemNH0pO46Wwgxw4nptWtU3AhUEoq3ZB+sS4
         Uz38CJlekYWJzp6I1yaBbe3XzEcYWNTkVGK04Ta1ngfbTDhXupGicOdbNnBMtynMT+P0
         AnCpNI7xwvekjyUDsV53iUOG6/dg/N4KUQnA0E7O4qHMC5CJyCBKOxGaS+MwXivXE3yX
         SVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416133; x=1778020933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2u+rkDBVuW0DwLrX33JN+GmAXBBEhpi2PB6tf5nm73I=;
        b=WiKoaXAgIBOb2124KGBrsZOG8TKqRwBu2VB3fBmWzc2/u+1zPplNEf3UctC3STgY1c
         ENY0rQgle7H1Tl4Kblw69A8p+W/zkRX2Awa2Tgfqvuh9UGPNUmXgLOOXw6NtdebZ4Xic
         46EXCpZvKgsHVi0dExvpDNzv8KIActBkGXK1ccQMsiB4SJ9UdDMf9EZrY/6wykOlvS3C
         GhDahf8c458FqCJvZZ7o/ePEmEXKD57iMUjP1+hyMIJSU7/DH7ytLIt40w8YkwQ9irkN
         8hK7j1ZbPYrFgJVgpkoCiGvQtCpfL5F8F/dIzV56wGi+PS0sfBIxWlrxI9e6Z+r2QKjQ
         laDg==
X-Gm-Message-State: AOJu0YyMureWfUBZdN9qLx0jBI3J+xJPBwcImaZHoDRepwpyvcl5p5Fj
	weDbafAoHQJove+5gtQ6jKl9PS7XxZOeHasSzxciCKIYkuEhkr3ujUiT
X-Gm-Gg: AeBDieupiaKMFwFQ9h8c3eqRtxNxi8/K6fiiZP0w9dyaekXJd/PEjtfKSzflIGhresN
	/RqS2XFqKTXz4gfZ4SmKgKDZUBOJhNE0VVAm6CHN4D1pUNjyJH5VH2eiurW7iDdbP5f32wFHbw2
	ySareX/cZA5U4CQSGYgtljRIhB+tQLqPEGVY2U2gEV3B+e4BB+mjusfulaLjPCmpQStbat0xzlO
	8+/R5/PcOTAM3vC42+ILPtVmRFQEmHhzE7jFieeC3UhF5mfvoR0Bw534GxNfdSMe0NCrKk2MKI9
	Ge7mxK9YlMRwatdvXqz4Rvqwlr0iZox2XvCej/UhMc7s4Zkrpds4je2tg8IyEudXPNDPlxAKxqL
	gsRL9Tg9TUItum0NEbn+PkL1OHAVlKcMmnBXfGi5M+J8g+IU4YpXo/Ll4gqjwo0ib0lmo3LqMal
	zuuqi1YLqYF523X6YQgHd2AqIUfSpDl+sd
X-Received: by 2002:a05:690c:660c:b0:7b3:9f53:9374 with SMTP id 00721157ae682-7bd1d378604mr17118827b3.3.1777416133033;
        Tue, 28 Apr 2026 15:42:13 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:4f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd258cc768sm4466607b3.35.2026.04.28.15.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:12 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:41:59 -0700
Subject: [PATCH net-next 02/11] net: bnxt: convert netmem_tx from bool to
 NETMEM_TX_DMA enum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-2-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 9571048CB72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282110-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Now that netmem_tx is a multi-mode enum (NETMEM_TX_NONE, NETMEM_TX_DMA,
NETMEM_TX_NO_DMA), set it to NETMEM_TX_DMA to indicate this driver
supports DMA-capable netmem TX.

No functional change.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8c55874f44ca..ed9c22dc4a5a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17120,7 +17120,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
-	dev->netmem_tx = true;
+	dev->netmem_tx = NETMEM_TX_DMA;
 
 	rc = register_netdev(dev);
 	if (rc)

-- 
2.52.0


