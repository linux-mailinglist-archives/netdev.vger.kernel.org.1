Return-Path: <netdev+bounces-252862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LN/BMmQc2l0xAAAu9opvQ
	(envelope-from <netdev+bounces-252862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:16:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBAE77A51
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C66E930F3C33
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E216F339B45;
	Fri, 23 Jan 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="buGI6TIV"
X-Original-To: netdev@vger.kernel.org
Received: from www.redadmin.org (bc043154.ppp.asahi-net.or.jp [222.228.43.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55D1BC08F;
	Fri, 23 Jan 2026 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=222.228.43.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180549; cv=pass; b=lc5iNYSXzSSb3Q9AEh6Rfv4ueIfCMVW7sq+2PdS3msyoxdw9M/LUTKVhD7yjCRuo0iyIUaP22S4sRYUL8c95DnPeSbl1Ji9tGmFLdqSXnIEgQhPkKqBgEwgKelHRzzjxbTsfE3CNAyrcXs/7m57JdiCPYso1Sl+MkyCJzR9lQOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180549; c=relaxed/simple;
	bh=RNUBGQvZrqffsQKxrumheBLMkf3dfSua/uStg/54t8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Db9JTSFMriaJUJv60p7BCZ78YGix0aSgP3VLYVxMK8PSdznFTgcGXesqPSpQZvdjylthWrdWh38UoAYAoNcWgRdHFU6GaSjWOCd+2i6gd+lN6oWDRrh70WSbFWn14QdIUfm/b9evhynvWV9MeN86fcwuTP4CPDCGvFGKxBcuQkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=buGI6TIV; arc=pass smtp.client-ip=222.228.43.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 1A4D2109EFDEB;
	Sat, 24 Jan 2026 00:02:18 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d1ccRGAvcbSe; Sat, 24 Jan 2026 00:02:13 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 0E7EA109F15C4; Sat, 24 Jan 2026 00:02:13 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1769180533;
	cv=none; b=NJxYGIcrosx3QrcfSa7vNBu0ASTfQTf23JdEhErIi/0TNh8Vz6dsHUwiKQ/pL8pAI/lsQPoRUw5x8hw8Mk/di7YSaBetp0PhU0xNE29Rm1j7mhZdAqEB2nmdbl4m1z9dFhZe8kmRW+EPqiAik4xgGoi/flOR0uZMSBP2dMpC7qg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1769180533; c=relaxed/relaxed;
	bh=WRJln+kNPffSas7zqWERM0kQ6veD9Z6qs9cR/olmjt0=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=DlcloI7eQ7fSO/Qwej4jALDRHAabSwnEJ9jNH6KIm4uvSJSBK8OaHyyXrcRk8Mc6EAwq+CPEaTDaO7z7bVfYqtd7EPQFYtm9yv3sL+Mk7TRBlQn5SuACYqfLnAsdaZ8idE3T34MLgCPbOQ/fTkppr2a8W7CI2wODXO5MkaiubMo=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 0E7EA109F15C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1769180533;
	bh=WRJln+kNPffSas7zqWERM0kQ6veD9Z6qs9cR/olmjt0=;
	h=From:To:Cc:Subject:Date:From;
	b=buGI6TIVYkRUCEZiaZV/5ntsWeWVa2tPWOaSQkIUop5DgM8ar8V7XQFopDiD6rief
	 QSai1gy/KPfZpc6fOcfPqawbta3tFO+dEG9LzAkxDaYUahd6Rka4da8N+Z0E9r6ty6
	 2XZo0d6gWLEKIiRCRTaLh+jpBWZ+DmJssuauYVY8=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: robh@kernel.org
Cc: devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	Akiyoshi Kurita <weibu@redadmin.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2] dt-bindings: net: dsa: fix typos in bindings docs
Date: Sat, 24 Jan 2026 00:02:11 +0900
Message-ID: <20260123150211.2646235-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redadmin.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redadmin.org:s=20231208space];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252862-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redadmin.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibu@redadmin.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: BCBAE77A51
X-Rspamd-Action: no action

Fix "alway" -> "always" in lan9303.txt and marvell,mv88e6xxx.yaml.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.ya=
ml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
index 19f15bdd1c97..19ae600e9339 100644
--- a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
@@ -72,7 +72,7 @@ properties:
=20
   '#interrupt-cells':
     description: The internal interrupt controller only supports triggering
-      on active high level interrupts so the second cell must alway be set=
 to
+      on active high level interrupts so the second cell must always be se=
t to
       IRQ_TYPE_LEVEL_HIGH.
     const: 2
=20
--=20
2.47.3


