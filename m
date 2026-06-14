Return-Path: <netdev+bounces-299193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jnixAdiBLmqCxwQAu9opvQ
	(envelope-from <netdev+bounces-299193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 12:26:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D1680D6E
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 12:26:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=D7R4oUaR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299193-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299193-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7705D300349C
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C5D39B95C;
	Sun, 14 Jun 2026 10:26:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886DC329C66
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 10:26:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432780; cv=none; b=j5cgzhYkzItYB5qYA2fMmZg3YNDsbeUSGpvKJ9hXA+ZcfefrUSZHmgFNBeja3XEisRaobLaeS3NxWF4PtvBXyT5RLnPmi7JfKf9c+hCBgwsXghrZfjW3qz0eZa9pMBXH93Y/dMZYAoxpL79dIFW12WhqyQqd4Ook9tlESwY0zsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432780; c=relaxed/simple;
	bh=WlxapzB9/qhluL8vXEKS0t0tYicVH7BeGoejz2BxDX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iY18V77sAklqEtrBfwtNQh1K3jYmbKaH7UiGpOyySTuembtwT2tWtkg1btl5F/eTmm+CEMAw+WLiVdZ1145WMbxryT1l5IirwTzaAy+aOOkacG0Y17kRFdHtk6QTeKrFUGYGL0etph3r0Lj4PqwS7yUvzVqKQJ5FaoTDMZfUOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=D7R4oUaR; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=C4mXeC1iJ/AzgXR7HuY39KddOLnZzVo8e0sm0ONAMGI=; b=D7R4oUaR1j7ocFT43L3oTsDVGX
	tScsra+Yr833mbvP0JyNwZ6SFUWBwOjtSJ/Mv579iduOJfDdGbqROnuKCxaNtAjJCV8ggoWhFIOTT
	U/AWytv+S+ULQa4jqNjKOmiwpxbeZ94x+6xa5pjsZt8QabAix1O1oASJuuxVOdv3MJl5o9vZkFaPO
	mLrZYDKYlbka+kiiyKQOXNIpcS2hOIFIbgZmOX6rRTDRRMeRlmCAdLCXgJ9JOIuvJDJDG5ht/pEgX
	LM17HQ5unUC4RAo+nXHNpZrIkM2TXId2Sa0pwoHKMsGWHU4/vbQhdwsXBMktHLN0e9hlqX83CN8E8
	1sQewiqA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wYi2c-000Nh7-2C;
	Sun, 14 Jun 2026 12:26:10 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	bobbyeshleman@meta.com,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 4/4] selftests/net: Add hugepage kernel config dependency for zcrx
Date: Sun, 14 Jun 2026 12:26:07 +0200
Message-ID: <20260614102607.863838-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614102607.863838-1-daniel@iogearbox.net>
References: <20260614102607.863838-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28031/Sun Jun 14 08:35:08 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299193-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:razor@blackwall.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,iogearbox.net:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A7D1680D6E

test_iou_zcrx_large_buf in drivers/net/hw/nk_qlease.py runs iou-zcrx
with rx_buf_len > page size, backed by a hugepage-mapped area. Thus
add to the Kconfig.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index cd20024218cd..ed8642b68094 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -3,6 +3,7 @@ CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
+CONFIG_HUGETLBFS=y
 CONFIG_INET6_ESP=y
 CONFIG_INET6_ESP_OFFLOAD=y
 CONFIG_INET_ESP=y
-- 
2.43.0


