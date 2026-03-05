Return-Path: <netdev+bounces-264218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PxoOgw+qWnK3QAAu9opvQ
	(envelope-from <netdev+bounces-264218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:25:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F9920D6BA
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6234D300B3E4
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D18372EC7;
	Thu,  5 Mar 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=andrej.kozemcak@siemens.com header.b="Rc2DZ4tj"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537D376475
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699134; cv=none; b=HT7+GDfqGwYAOch22tUp/nf+LmyLjoDGZe+GWCFhnSuUl5Jl9i3z6jVD5oWMtBhZ0HjTaj78HpvaJnp1yMkbR7aw/yZcgLlsh2PcB1pF5wQiPxseA38Wy4zMTrExZoSypPsi/uaDgSvHVo97tH+cGXStXcX9z2YVp4CeeMdD7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699134; c=relaxed/simple;
	bh=iLX47Vj2SdQtsKXG7MC/IIlWWmxtbIaNLJo0b09Y0Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dpom4IZhE7VFs213LxSZftp0n+Y85hLWsnIqK1kyDcKi5fPrVp/46IZpVDUuVbIpmVM0tK0gT6hyv7hZQiXb1JKzwov4/a2+5Jg34jXn2WqvHD21FTXxeuQBNEfzSSlXMMUK340+fn3/Da//KfRHrtCTqkIBvQpqA9+X+setw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=andrej.kozemcak@siemens.com header.b=Rc2DZ4tj; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260305082520cacd7569580002071f
        for <netdev@vger.kernel.org>;
        Thu, 05 Mar 2026 09:25:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=andrej.kozemcak@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=LAriL+Ovye0GrysqZh+bvjp53D5O6Sg2bfgA2cIuajo=;
 b=Rc2DZ4tj8M27AmOHdtQBiLB8IpN5k1wsMGwE7mvroaQxujTjnlFiWpvn/ef1vkQyj8dClD
 9Zl4dmA3sEFQp0BHjf2uO29Sv3xlHgTk6bYb1B8aFAwTBTQNKDyW+c6/TCPWA3M9oFGBnAlg
 rd6cShXhgLvIqUXZUHqH53CzKToSqQ0gAEq163OF+wJ//0gIW/mlhGQk7w20b8AQ/5VNBZHh
 4TBX3iSri6/AAAdS7D3JxXQOIhctpNNUi1C/PiZfBDUy1t3otvA6GiwKb5p14FalIyOnUONm
 y52iUMYyBXu2Bl/5KUk2o4/vpzNFsNyyG737t/jpyzYSfSxPMhpe0isQ==;
From: Andrej Kozemcak <andrej.kozemcak@siemens.com>
To: netdev@vger.kernel.org
Cc: Andrej Kozemcak <andrej.kozemcak@siemens.com>
Subject: [PATCH iproute2] include/color.h: add missing include for types
Date: Thu,  5 Mar 2026 09:25:07 +0100
Message-ID: <20260305082507.896700-1-andrej.kozemcak@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1334352:519-21489:flowmailer
X-Rspamd-Queue-Id: 97F9920D6BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264218-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[siemens.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrej.kozemcak@siemens.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,siemens.com:dkim,siemens.com:email,siemens.com:mid]
X-Rspamd-Action: no action

Fix `musl` build error

Signed-off-by: Andrej Kozemcak <andrej.kozemcak@siemens.com>
---
 include/color.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/color.h b/include/color.h
index b543c267..3794a2aa 100644
--- a/include/color.h
+++ b/include/color.h
@@ -3,6 +3,7 @@
 #define __COLOR_H__ 1
 
 #include <stdbool.h>
+#include <linux/types.h>
 
 enum color_attr {
 	COLOR_IFNAME,
-- 
2.47.3


