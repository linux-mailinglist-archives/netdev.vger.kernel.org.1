Return-Path: <netdev+bounces-303922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1ftlE0rURWptFwsAu9opvQ
	(envelope-from <netdev+bounces-303922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:00:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 752E36F3268
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:00:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303922-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303922-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E2413022F6E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAE230F819;
	Thu,  2 Jul 2026 03:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FF2EEE76;
	Thu,  2 Jul 2026 03:00:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782961222; cv=none; b=AnEaNSunRdnTM+Pd5PX8pa58cM4y9/bDGq3D/dorc4prFB/sZ7X0gb4aW9yNS3FgOxAjosfEVyndCAScOtylx5jq4MXMC2H3OhvUYSYI77OiJvrP9AqrQ3yTRyK29s5tifO3MpDhUTNcw7CfWJh0/Y/sG1YJ5W7sjkTdpZPZip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782961222; c=relaxed/simple;
	bh=g15jO8VNdK351026C0xI0bHACJ/m2cgS+Z9xQ9CJXIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=G+2atBb/+BRqh26K/ECuhTJFLU7tqmA58ZMfdIByUZ4L4wPI/APjES9TYfrosU3/zmEl+2dRkGeg4Jq6Os9ZFWWwGXcI+jEjYE7mQ/NrvT1+mOVbPgkbIHxwphGXhOcXvzJRKmNIfqoaXGpAqWzUh9qC13w/CgxdkDStHUaU4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 24974c1875c211f1aa26b74ffac11d73-20260702
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d9ff5e0b-6a3b-4b29-931f-b4dd1f964ab5,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:d9ff5e0b-6a3b-4b29-931f-b4dd1f964ab5,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:179c91b6ccdaecc00aa813affe488696,BulkI
	D:260702105828YKMYMX0G,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|102|127|
	850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 24974c1875c211f1aa26b74ffac11d73-20260702
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1813944472; Thu, 02 Jul 2026 11:00:12 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: horms@kernel.org,
	lixiaoyan@google.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Yan <wangyan01@kylinos.cn>
Subject: [PATCH] selftests/net: fix EVP_MD_CTX leak in tcp_mmap
Date: Thu,  2 Jul 2026 10:59:49 +0800
Message-Id: <20260702025949.442523-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:lixiaoyan@google.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangyan01@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[wangyan01@kylinos.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303922-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangyan01@kylinos.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 752E36F3268

In tcp_mmap.c, both child_thread() and main() allocate an EVP_MD_CTX
via EVP_MD_CTX_new() when integrity checking is enabled, but neither
function releases the context.  child_thread() misses the free in its
common cleanup block, and main() returns without freeing the context.

This results in a SHA256 context leak on every run that uses the
‑i (integrity) option.  Add the missing EVP_MD_CTX_free() calls to
the appropriate cleanup paths to fix the leak.

Fixes: 5c5945dc695c ("selftests/net: Add SHA256 computation over data sent in tcp_mmap")
Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
---
 tools/testing/selftests/net/tcp_mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
index 4fcce5150850..2544ae35d07a 100644
--- a/tools/testing/selftests/net/tcp_mmap.c
+++ b/tools/testing/selftests/net/tcp_mmap.c
@@ -313,6 +313,8 @@ void *child_thread(void *arg)
 				tcp_info_get_rcv_mss(fd));
 	}
 error:
+	if (ctx)
+		EVP_MD_CTX_free(ctx);
 	munmap(buffer, buffer_sz);
 	close(fd);
 	if (zflg)
@@ -606,6 +608,8 @@ int main(int argc, char *argv[])
 		EVP_DigestFinal_ex(ctx, digest, &digest_len);
 		send(fd, digest, (size_t)SHA256_DIGEST_LENGTH, 0);
 	}
+	if (ctx)
+		EVP_MD_CTX_free(ctx);
 	close(fd);
 	munmap(buffer, buffer_sz);
 	return 0;
-- 
2.25.1


