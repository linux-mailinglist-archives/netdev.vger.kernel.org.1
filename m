Return-Path: <netdev+bounces-229333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41EBDABEC
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C373E833A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A692F49F8;
	Tue, 14 Oct 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="sDBydC1F"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C0242D97
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461995; cv=none; b=T0KrPQbkge/TMAfv8dhCFgT/QHXOaLQqXcZ0V1+ujXTj6zG4k6d3hiEs5W4U8bNqeZdJbrPSJmwe1a+km/6VLkO6A1l7ZXea5kQ88xBE9LJhwyQuPz7KuMhkiLIgC7aqMSAf0tzZcY9vfuew6soY/mBiDXG1rSomOrZvvsVhx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461995; c=relaxed/simple;
	bh=NuAsb1w8NLgDS8QqD1VxcmP2E+E2Rik3hj4154+lvbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YWvwQ4Ou+acMeFLq8rCnaOZAkvyZJzUUjT3KLezvrkDp3c1F5gy9Mmbsj1fbSN5I+yByIDnIF9fiAqo3/hvOfZ7xeQ+d65SPZrx9S7dQhlNisPaLK1RxdAR03l7pqyiRhSz+btQ4uZWfgBrSsUbVjRduyvUMCZKPqNnchcRtrpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=sDBydC1F; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 353E7200A8C0;
	Tue, 14 Oct 2025 19:07:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 353E7200A8C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1760461627;
	bh=zFLurzG9VYw7z45KhSzX6d66KojjsftffxwY34E068Y=;
	h=From:To:Cc:Subject:Date:From;
	b=sDBydC1FHmOaoA9sfUfzEwD09A39ZWKEuaptM8VvxZ2AItKgeYbQxLuBqkqNmN3rV
	 5udIlyjzao+0oMFZpLivHGzYoI1kCZ+HkwLoflE3USIVZsKMcy6UY6LAcm2WiU4pSM
	 /omlqxvIJChG3UmYPCe8NfDMO6JRyQHx71WbEV4UHI+8G0WAXjhQeF/chf+Pq6PQKF
	 qWi/iZWO5zLlc+nLcHUQMI9XnOI1ZKpjYmHflM+GDC9Ul2YcALXMS7qQRFmftkTTXH
	 Kh0eSeHW1sNS9QVQKdP5b+oIkU4l4awjAr2cr7Y4hgloFcCtjAF8FdhgFXYOl1FoRO
	 G+4Zlgd1TXnQQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next] MAINTAINERS: new entry for IPv6 IOAM
Date: Tue, 14 Oct 2025 19:06:50 +0200
Message-Id: <20251014170650.27679-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a maintainer entry for IPv6 IOAM. Add myself as I authored most
if not all of the IPv6 IOAM code in the kernel and actively participate
in the related IETF groups.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a27901781c2..95b1e5054ea0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18011,6 +18011,16 @@ X:	net/rfkill/
 X:	net/wireless/
 X:	tools/testing/selftests/net/can/
 
+NETWORKING [IOAM]
+M:	Justin Iurman <justin.iurman@uliege.be>
+S:	Maintained
+F:	Documentation/networking/ioam6*
+F:	include/linux/ioam6*
+F:	include/net/ioam6*
+F:	include/uapi/linux/ioam6*
+F:	net/ipv6/ioam6*
+F:	tools/testing/selftests/net/ioam6*
+
 NETWORKING [IPSEC]
 M:	Steffen Klassert <steffen.klassert@secunet.com>
 M:	Herbert Xu <herbert@gondor.apana.org.au>
-- 
2.34.1


