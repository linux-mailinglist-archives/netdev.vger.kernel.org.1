Return-Path: <netdev+bounces-286338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Om/FrW2AGplLwEAu9opvQ
	(envelope-from <netdev+bounces-286338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:47:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE351505305
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBB2A301053E
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92373B27F8;
	Sun, 10 May 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="lqk3pod7"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1E3ACF15;
	Sun, 10 May 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431464; cv=none; b=iBTIoe3n4NOj/azTCp3FrCT72QSeKaPW4izKupZfzbu+FfJNM3fGSPLi7LOAodcOsdl6baVsy1YCLLXpB8V78jprYkOYXJ4i0AZEEQGRbuRF0GN+mFaf9nScAxOhuj8nGpAyr65M8skDcfJBMeQs3Mv7Qb64krErlh3A6d7OT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431464; c=relaxed/simple;
	bh=RpmaRYY3PJernLi+mHT5wcbgojVG+s9emQiFmp8vQRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdW8rtyWjzCM3JsseVeonTAksJQYBShhc/wqiYlGPC8z/WcT/xB3blNom6fTFKrRqkqT/Aph/wBLhlyq8j6MMFiOKZy//hvl0LrB1c+dNwdC7jOlvCVdvozlhtfh54iqq/2+83Nuum1KAH0Y444VHuVCLiKfB/Tnvsg1b6sjV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=lqk3pod7; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4gD7x10FkKzDqSf;
	Sun, 10 May 2026 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1778431461; bh=5T6leDP8tmF3XvpwD7l+rnfsgJdFuQTS47BKmtBbf7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqk3pod7Nf5wp43CXQJ6MYEpIucBqZQvSc8kOWAV4yDkUSlZ3gX8L0J9cQbwgk2wu
	 b00OY6SujXnDN8JgP5bODlIMuV/jVeO3XvMuN4Jc/hEOCgQ3lRwbpd/5x/O/xD0WrC
	 z5rpH/miZT1VDYMppByY34X9WaL1XQMVmFojnsjQ=
X-Riseup-User-ID: EA9A6AE0E301AC6588F85268079748D01CA43CB25B8D93121CAEFDF9351872E6
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4gD7wx6jfRz1yDs;
	Sun, 10 May 2026 16:44:17 +0000 (UTC)
From: =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@riseup.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Filip Pokryvka <fpokryvk@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@riseup.net>
Subject: [PATCH net-next 5/5] selftest: netdevsim: suppress socat warnings
Date: Sun, 10 May 2026 18:43:37 +0200
Message-ID: <20260510164337.7611-6-ihuguet@riseup.net>
In-Reply-To: <20260510164337.7611-1-ihuguet@riseup.net>
References: <20260510164337.7611-1-ihuguet@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE351505305
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.11 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.77)[subject];
	DMARC_POLICY_ALLOW(-0.50)[riseup.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[riseup.net:s=squak];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286338-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ihuguet@riseup.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[riseup.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[peer.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riseup.net:email,riseup.net:mid,riseup.net:dkim]
X-Rspamd-Action: no action

When executing the peer.sh selftest, socat emits these 2 warnings:
  socat[116839] W address is opened in read-write mode but only supports read-only
  socat[116833] W exiting on signal 15

The first one is because socat tries to open in read-write mode by
default, but STDIN can only be opened in read mode. Fix it by adding the
-u option (unidirectional left-to-right).

The second is because 'kill' is used to terminate the first socat process.
Suppress this warning by redirecting its stderr to /dev/null

Signed-off-by: Íñigo Huguet <ihuguet@riseup.net>
---
 tools/testing/selftests/drivers/net/netdevsim/peer.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
index ec96015bc9eb..183a130c6e4b 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/peer.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -210,13 +210,13 @@ assert_carrier_up nscl "$NSIM_DEV_2_NAME"
 # send/recv packets
 
 tmp_file=$(mktemp)
-ip netns exec nssv socat TCP-LISTEN:1234,fork $tmp_file &
+ip netns exec nssv socat TCP-LISTEN:1234,fork $tmp_file 2>/dev/null &
 pid=$!
 res=0
 
 wait_local_port_listen nssv 1234 tcp
 
-echo "HI" | ip netns exec nscl socat STDIN TCP:192.168.1.1:1234
+echo "HI" | ip netns exec nscl socat -u STDIN TCP:192.168.1.1:1234
 
 count=$(cat $tmp_file | wc -c)
 if [[ $count -ne 3 ]]; then
-- 
2.53.0


