Return-Path: <netdev+bounces-292803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLOlI6qNGGohlAgAu9opvQ
	(envelope-from <netdev+bounces-292803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:47:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F725F6B38
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21DE0301C581
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C0D3191BD;
	Thu, 28 May 2026 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="p+DNZTqX"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C230E851
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994023; cv=none; b=rpw8qFKjKwJ80JUb0XdOeucumkBO7hYHqlLK5lOV9Sx5DfnIGeiE18HaVd4W2/XMO8gX3MX+YKe3WXYyIqXPELc5O8Lx0SRcWORoS+74eI6Ap2QoX7zuGda18R9LWDZUBl0Mrk6kbR4QDJPRVF40bG/E6EqjEJ+NGmxFkhfSSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994023; c=relaxed/simple;
	bh=d6HK8mokx1B/xCFU1d/eTdQRd1P7S87uSAM2rjzqUyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILNg7W8ffHTaKYp9T5eLDzyIZynA4v6uWXxX9bSBOrTY5M8JYfL0+qvBDzHVkSYm1yMHe9pFpu21CWFkpitRHotpSVg+crzhbzZBHQpSA1K0CQlzpU3D/sS9yrhDD9DTeKzGzPIIBe1pm+8mv19MKN4Mi9b96lkSzsa9VC1pGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=p+DNZTqX; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1779994015; x=1780598815; i=wahrenst@gmx.net;
	bh=rd+ByegabPGeoe04g5fmfuuetNosHFqtRU1b3P3WSGk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p+DNZTqXjKgZt9JrLHfAm0UfKE/XGtieYW+cvOkmSETCQDol0a5AxffMjeIVq9K7
	 G0UW21UNQBAOIOJlQjYiWQuaToWcfQ3saJrvZZ6ajdtGo0sKGbldO2EWFqNra3CuN
	 G6m4N1sgomAb6Dqz8iqktlTO3dINbrqYI196dSJv/cIG/y7lpdhlH/LbZ447xKIm+
	 qD4Z9pXkuiiwlZIuCgZBpCibhbJ+Hd8FPKqBsHLqsvRGSpCwOBI/1RtoW7I9Eq8sx
	 N3i1oemR0ykeg8hSv/wDfVqD49Z/zcvtPtk+toWIvgb1N5zEaPHlA7PMlJJyPVF3a
	 c4sEY3+gb4XJfb4FPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1xG74c3g5E-012tQ6; Thu, 28
 May 2026 20:46:54 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 0/2] net: phy: dp83822: Add optional external PHY clock
Date: Thu, 28 May 2026 20:46:40 +0200
Message-ID: <20260528184642.33424-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g1cq3Rz4/O4z2Iw/SIGtiYdUL6LnGsaQ4sMqCA0NXnmHILJ4oWF
 0Bux9x8d5VXQH5Nm6c7hLDUypj+EdJsfoXqxVzXWi7qSUepXcsJTeyiuBfUTyfjU8BcDUF0
 NGmcNUIR75qvGtCI5mTKCsHgakj44/tWdDnEJMHkGpqhuj2SmXVbmfjvGJpoMzetuNp4HW9
 ljZFvDn7TDa9sC/xlPFNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+gzFabSEoKY=;930QWa0wTUqvTbx/OYQ2UKFSDVx
 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
 6f5kRtd12Ejjz+pA40N+8YrgK7E=
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292803-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D1F725F6B38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This small series implement support for external PHY clock for the
dp83822 driver.

Changes in V2:
- Make readability changes a separate patch as suggested by Andrew
- Make clk a local pointer as suggested by Andrew

Stefan Wahren (2):
  net: phy: dp83822: Improve readability in dp8382x_probe
  net: phy: dp83822: Add optional external PHY clock

 drivers/net/phy/dp83822.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

=2D-=20
2.43.0


