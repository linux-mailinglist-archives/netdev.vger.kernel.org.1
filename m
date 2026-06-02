Return-Path: <netdev+bounces-294019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEoJJqZpHmqGjAkAu9opvQ
	(envelope-from <netdev+bounces-294019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:27:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9602D628873
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 210143009E00
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B91C2848BE;
	Tue,  2 Jun 2026 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="HVv+xKVx"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E323ABB9
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378015; cv=none; b=pfPKJWBq9JnOwUhUwTSHTmCEtu8rrlZjAILR7Xg3yonTjIaP2s8NwQ6a+8dQgZxt2yq+CSFC3Lr/gYaoQWE+b56DEQMUDCetEQaavyR6aeA9Qw2X3pQpvnC6T7jfw+k7xDSQZquLvgEBK2r2f9AgL06QcaOI1Fnj+fwl988rxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378015; c=relaxed/simple;
	bh=Uj5l5U6GKnT13VZfWn/4SJmjt9cR96c5b8+qqDrgkDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2GLHK5S6Q7MuA5RpRudKJ5krRy7GLrUzDne/HHxzwXrZZUHpG9MFVFb++/fO76D2j5YIHeU5VuFwkofcWJKfjycmvOjxDIAzBcL9DVkIJ/y5v5y9sXVGJ6Y+TVkvadkVsuFa79ObgTlkqNzi3KwMT/aVVoG9pXW6TLJII44zdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=HVv+xKVx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780378011; x=1780982811;
	i=markus.stockhausen@gmx.de;
	bh=G6x/T9ut7R54fegeEKI1PApHPI2cygkMg5taLbQnHvg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HVv+xKVxCuxNvW4u6jWMP+X09BG9s1cEKGx7qRUFqHVurgvqkxVAUOvYhQdjQ0WA
	 QgAAFApgbC9v3Q4ODP9uqyX7s5AA29tPTtB7UyQZvbvv/lajsmAF/1WvU4KA7tIsC
	 cwXJGGkZKgfCpllCdrqChaQlge2lIeiYyRXlqLLVzwmiIGdaBuDiIFDyjVMfv2r0T
	 7/ops9NYjgd8gMmDT0Xlr8eAODM48v8M6eeC/jm6SoUqxlQ65ainHpWL07vknPbwp
	 As3dX4ZIyxykrV04T5UhftmNbpvm/lzORlBKT1QlJn9CG9HY60rZUwfWPsmD4GAUe
	 PDOMTU6Nq4KqDOdryA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1xOi3q0kkP-012ygu; Tue, 02
 Jun 2026 07:26:51 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	mensi@mensi.ch
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next 0/8] net: mdio: realtek-rtl9300: Refactor initialization and port lookup
Date: Tue,  2 Jun 2026 07:26:32 +0200
Message-ID: <20260602052640.93083-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MOZMN8YB/T3Gc4c0CKw0w6++y+BAnnrXIITZoFCf9tzX+4AeLZ5
 sEU9hRVdc31f9ekIdzoxoErQRgX3ZerGq0g13b0coArhB+LetuJXc844xjOSkMLHB5ghDhb
 bt5o8UqkC12qSGx47eWD64JuZM818auDraDDgeBnBg7H1ewdiUROcXt4JpzWSXEusnCPg5i
 61NI6ncfAezDBz4LAcItg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qRwUM/eAw7Q=;QOd5MwSOKXapRaBv1lujn+D6YYB
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294019-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 9602D628873
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

A lot has been done to enhance the ethernet MDIO driver for simple=20
integration of more SoCs. Now it is time to solve inconveniences
that were discovered during daily operation. That includes

- Tightening error handling and improving overall robustness.
- Adding support for PHY packages.
- Fixing setup order issues. These currently hinder the driver from=20
  properly enabling the hardware on devices where U-Boot skips the=20
  setup and leaves the controller registers untouched.
- Converting the port lookup from O(n) to O(1) to save cycles on=20
  the slow embedded CPUs.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--


Markus Stockhausen (8):
  net: mdio: realtek-rtl9300: Convert to fwnode API
  net: mdio: realtek-rtl9300: Correctly handle ethernet-phy-package
  net: mdio: realtek-rtl9300: harden otto_emdio_map_ports()
  net: mdio: realtek-rtl9300: harden otto_emdio_probe_one()
  net: mdio: realtek-rtl9300: adapt spaces for defines
  net: mdio: realtek-rtl9300: relocate topology setup
  net: mdio: realtek-rtl9300: reorder controller setup
  net: mdio: realtek-rtl9300: Convert port lookup from O(n) to O(1)

 drivers/net/mdio/mdio-realtek-rtl9300.c | 235 ++++++++++++++----------
 1 file changed, 143 insertions(+), 92 deletions(-)

=2D-=20
2.54.0


