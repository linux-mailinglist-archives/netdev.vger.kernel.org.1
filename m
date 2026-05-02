Return-Path: <netdev+bounces-283376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id skCIGLmS9WmOMgIAu9opvQ
	(envelope-from <netdev+bounces-283376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 07:59:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5310B4B1116
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 07:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 796663006113
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 05:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A362DCF57;
	Sat,  2 May 2026 05:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kxMMiCRi"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702E273D77;
	Sat,  2 May 2026 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701558; cv=none; b=fVvarL2mTB6NasUH6aKaGPSMcQ1ZsYcaFH3/2EiFFJRE9L/2YwhVqru9ZIuWfrqcRVhn9xOvYzNk6yry/UCJ+fhgFIiOIvCiVVIm6SvxwIoyjX4gJNf73H1fI8obhPA4UlLi2IaAfzUzJaeo86smKbpfxDealgaPajopwAbhkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701558; c=relaxed/simple;
	bh=VljIhxZfpabOtLIN/T9+3T2Myqx7uMzy99pXp3JFv/c=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=jwDwPxrK21r3X+SMkaqQgrd5Jl45NpXe5SNILWhUgQXm/5uuO11WPte3E0d5I85GBpbTEtcjOEcB7gA9cSsbWMJxZvxIeQ3O4DAc8ddB6fUnMsTI2/BTkOybWk5s1y3/fgr2nLfeNFx7v2Q0OlWPHQXUJATHUgEbZlMwgHbe2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kxMMiCRi; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777701553; bh=9ny8Y7WkulRs3ZlcZ8RD1O/OliGSzC47KpDVSR30OJo=;
	h=From:To:Cc:Subject:Date;
	b=kxMMiCRiutxCJqwTsc5HJUWFefMdHVVogYKPT/zrIuXzEu3ZSQ/OwIsWWL4ERnr/J
	 S2r2zgL4N/iAIQ4SYc3CrPdN9BDiAR7CP9F/vSJamtQNk6vCiopg0nWK49wDtI1EFm
	 suuF/FgCurWuV/JGweWx/EMW7rtrZDPCC/1uwn74=
Received: from Lang.smartont.net ([223.88.152.211])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id ECAAF68F; Sat, 02 May 2026 13:59:10 +0800
X-QQ-mid: xmsmtpt1777701550ta5gjp1sr
Message-ID: <tencent_0AEA70199160355F19C15F52AC247073800A@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLDSKffvkxe3BMUmNZkEkG+RzmOb+wD2lsOBdf0pa21swtTPzbrw
	 kIOV54CawM5pfBxfkf8VJ0K6dM2zYIwKSPQcshgquubisSptTj8G4DlgspUMRGFMwx4+v+3flp5L
	 qEwSagpBPEs2weXr2t8CvMML3m337GsECeCh7BLtnkxxB/F5d1KCq4+Eovl9K0gRG0iIIni1rkaM
	 2rVS/NShHM1r3Xf7+OahHyW4sJwFHErJiCq0kASOYCsjHd1RHNMJhSWn+KK4XwuqMhM+57/GhT09
	 LYib2/8i9h1NIgMYmoSYnfjeHuudaKuyFW7nrK0Em1PFvGa+5/EKPhCEUxNumvfiwVMNc3yxwRht
	 KP3VefXP8c2D7c3eYLHids3/GFAcc9gFEvwlSIlsodQ6ftuZ3sSknjia9bTLyouEKdXo4ccrqYwx
	 7YtDnHer6ksvosSEi4Oh1Rjpj/UcMkc/v3pK6feSAMnr87MbZEFncJY5KbzcY/IH+tz7NW6+tYEg
	 TspYSVZ73111ccmRsCCZcAkGNCK/Fj9JQ6W/NSB/Hvo/xWwHrGhlRG4ZRjfBIyi4Rmyix+EiAgCr
	 hNOn4TH/584P1ys7xMPyp4Rj65S9JU1lqKYaUR1n8jfvrd8okvulYPn0/2GPBlf3Xbco8ugV6wta
	 ugfp+MYeXLhqQEJR4dpovcdbXnGy3/+eA267Cprg4EBCQ2FDSmJTfkow6nb/MJfJRT15GIb0th3b
	 7EDkplE00CSgWJSJBBHsR50xiQS+zel7rkT/bQnJhLvJdsYEQAtrIci/Bw8njXrQdCwLMLIH1Pab
	 E6EGfbh7jWZZXGV1YPYUMUuQA2OFgfhSNki0tBKXp0HqHHCD14682e53STMUONqgQLRdioDmpAKv
	 OyhfpUg8T6TBiQX4H+pakwtzfJPzxRqCRoctpx7JdcJhQC/v28xIvBCj8yfFGvWYJhGvshMoUhOj
	 yT0AZN6HAmoWlPACPBgK6uQWge0y9xaLMTxcj5u5zJFeHvpt0piEgPKuQo3ih01DqEH1uWp1ICnK
	 +NTSLEgMC5qfAPbzYr0XkGZuCgAMAMtPhKzWLQvoIN72bCwa7h
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Wang Zihan <jiyu03@qq.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wang Zihan <jiyu03@qq.com>
Subject: [PATCH 2/4] net: switchdev: fix duplicate word in documentation
Date: Sat,  2 May 2026 13:59:08 +0800
X-OQ-MSGID: <20260502055908.116226-1-jiyu03@qq.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5310B4B1116
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283376-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiyu03@qq.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,qq.com:dkim,qq.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Remove duplicate "in" word.

Signed-off-by: Wang Zihan <jiyu03@qq.com>
---
 Documentation/networking/switchdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index 2966b7122..948bce44c 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
 monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
 bond will see its upper master change.  If that bond is moved into a bridge,
 the bond's upper master will change.  And so on.  The driver will track such
-movements to know what position a port is in in the overall topology by
+movements to know what position a port is in the overall topology by
 registering for netdevice events and acting on NETDEV_CHANGEUPPER.
 
 L2 Forwarding Offload
-- 
2.54.0


