Return-Path: <netdev+bounces-294091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EpYA7KdHmq5CgAAu9opvQ
	(envelope-from <netdev+bounces-294091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:09:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A5B62B129
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC0F300EA85
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CAF3C585E;
	Tue,  2 Jun 2026 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BBxWCwli"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22F3C81A9;
	Tue,  2 Jun 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391143; cv=none; b=BPlkLOGWCoEgDiE76R+Xx7iOMrGmMr6ud0Kyg2R4vnykjsFZn+Qajjmf4UtWxQFmfpdWRSUVl2qwobVVR80otOwQL1F4hyT62edWkqHKcl2SV/SKXYG29ORmMpeYZHjfzoMNmzrAYm4o+P0VNTg7HM8GZ7vs4wrxur2BNZKhQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391143; c=relaxed/simple;
	bh=4ISKIg302H0QG5EBCnN1MlangFR1q9sYBrKBVGXrdeM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Rv7ZyAg2PWI3qb1UnciFnNfAOAep/hPngun3M1JRVZnjCHx7qDMyFtg9lHxz5aOPIap+qi+XqshXx391j6vquuUfpINygiP6/GeLatYWNimyLswGq0EzStiWxWDFfuRAd1avyoGaF1D2Wz11RNM6JoJMqyrba4XEGCbRtt/TVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BBxWCwli; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780391134;
	bh=Q0WNm6g10MFQgiEZ0ypFJR4luc9FuEribuvlDn2kdAg=;
	h=From:To:Cc:Subject:Date;
	b=BBxWCwli42+mIHT/jFV4BPL+Jir8hgsWVSCGROlflovCpWoFoE5YQ0hchmS3kenrI
	 7SHEaHIxcp4VJt2fXHX+i70AhHJZTyIGDLIHeKoDG2R6R5LE+gXpGJgkvNPFLQ5tEw
	 dZsKPjuQXmGhHTgkmpRT34zgUgbYsFHf5MBBlPIs=
Received: from localhost.localdomain ([2409:8915:2067:10d5:5f88:ceb0:c03b:f401])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 15E02E54; Tue, 02 Jun 2026 17:05:30 +0800
X-QQ-mid: xmsmtpt1780391130twvfyou6u
Message-ID: <tencent_29CB862D5756CBCBAFD2EE436EBAC98A7E05@qq.com>
X-QQ-XMAILINFO: OR5rDBBXAGpMjtPEPR6GPwz00IW16RuB49+OJyu68YY5og/IdBpSnq2wgE9PRb
	 CTVT4AmjpsUqpXomcaERwoW6t8hueu6cRv8Oy7qlWRCQFBQ3gYJLOWQDUrt6rY5FJCBwW3tax/ZL
	 ZwqrRVOzAWrKwN2EpbkArRN5yPOuS1XtAyBgnO78m45oQhBUNMpOdwa7SNVwo+Bz4OjhGjVclZUs
	 h1qV/fruRXy0HjILeHqeJWus6GIWZGgXWMF40SJaBn4nl4IP6Koi4J0TVPBU2ceR22hwt0JrCGgS
	 UmcBGy8+OgIZcrVzstfr0AJTI9Fh1siD7DRwIsMTN1kuSdBV2vZAiojnf9VgpKfbiWJqFKjHU3kD
	 U1dyY8DjVoMEmaGcO/4LpFzn6CzFE7MF2KCJr8Y/d6BOgGfN5RnEC8bU6/zprlEr5chauYCy4y0R
	 DktC0MJ6Ag1+o83/c0hUrde4b/IVVpnnrceYTSBVr+nEN9TCoF2lL/dZ220lubnUPANF3yoE99OF
	 XvhUOIH6WegUiLQH90OsaJYsMLxyckDQbMEf3FCwlYY9OVDdr7/RCSkFXVDeDlWC4mMcBz8OX5S3
	 WHKvM7VymMbNq76Cvf2VeMlyYTmCme475Qxvmt1upfrOLHIWamVGiw79T+kzhZZWs7b2dDDVNdyd
	 nzlT+rHCGK69qFKwI8i5FK3S3b0RWl631FBsakOcoyuWQoEBF2TCYpnVX70yihdG2wgB/vvsYdMm
	 rAJdktgNhI3G3TNYFnkqbOXl29b9M5lYDsVv6EHT7rJjUTjiGVgMCDYlN5KR7nDgP5V73OCs2CeX
	 1uo+V93fcVaoo2FFYX1KtTCVn8BhlJJ7JpcazSGqWf4wpzCoAOeOtuhuePvl7X4LBOCmmq639YxX
	 /3dkm4BK0kMbgRdFAjOLzQTTETbjaXIJuEtPXwW/+y9+7t+745MAP+CN11HXp175qrjta1TXd03i
	 R5jh5coz4kMX1juuulv05KGeZtQnS06W/UptDoGuGIoazTm7WySODw9HAgLkIgV0TJG51bphxU5O
	 Cv5yMqgqLd6cuZsLzMW56+zyJNBxsrO2Bauok4pXQmYp8I/BXOa7bfqegZr6ORuNWv2LI+WA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Shaoxu Liu <shaoxul@foxmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: shaoxul@foxmail.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] rndis_host: add LE310X1 ID and enable low-power handling
Date: Tue,  2 Jun 2026 17:05:26 +0800
X-OQ-MSGID: <20260602090528.2544-1-shaoxul@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65A5B62B129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foxmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-294091-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaoxul@foxmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:mid,foxmail.com:dkim]
X-Rspamd-Action: no action

This series adds RNDIS support for Telit Cinterion LE310X1 and then enables
USB power management for that specific ID.

v2:
- split v1 single patch into two patches, per review
- patch 1: add LE310X1 USB ID only
- patch 2: enable power management only for LE310X1
- improve commit messages to separate enumeration from behavior change
- Link to v1: https://lore.kernel.org/netdev/<replace-with-v1-message-id>/

Shaoxu Liu (2):
  rndis_host: add Telit LE310X1 RNDIS USB ID
  rndis_host: enable power management for Telit LE310X1

 drivers/net/usb/rndis_host.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.34.1


