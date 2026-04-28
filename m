Return-Path: <netdev+bounces-281855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCAJIPKx8GnsXQEAu9opvQ
	(envelope-from <netdev+bounces-281855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:11:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E7748594C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 048F43020C47
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39053E6DD0;
	Tue, 28 Apr 2026 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mNYw/QFi"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679673AF65C;
	Tue, 28 Apr 2026 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381641; cv=none; b=WYlFFtfG3MwUDeM97q008QlA0WOGkJZOzmd1SKAFPBr5ZFkGGml8JBAweOj+yqrFzZLz78D0JQl0uQ5RCl3Cos0Xfm46qNGtSDBKk5zXCeJ97aKFnb/r13Kz1XK79/T2QdXbCFnIN+ns3x2AEHdIZhlOc4NdHwkx0qM7lO7sNZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381641; c=relaxed/simple;
	bh=u5vp6FbftZARpKR4Xdii8fdcaaW1jSq2pgUEfYf9HaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MCBOfnTW7Y+y+Qs6nFgSWTpQ4DpBDo7vh8qQZmV52y1mVvdVIyjVw1V4n/1aMAlaJs4LdV1FxvWlpXFdx/GVXompt+QR9t5hd4X7ayOawia2n5kOfL05dy/7xAXx4j85NJtS7bnTPeFepGFdonV3zwI7OGM7N+Tx+s6ZZiM3sSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mNYw/QFi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777381640; x=1808917640;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=u5vp6FbftZARpKR4Xdii8fdcaaW1jSq2pgUEfYf9HaE=;
  b=mNYw/QFiX4yVAvoDdWKNKUuJT73LkDpsj0lroWmT4rvq+kunZsVSeFio
   G/x1Zrvq3kwdnrYpUZxij3mKwSAF1zoaDRi0LqxvfJUGuJnac1j3up8R+
   ASqyElaIbohS9G0Cjd4eMkkxYm56uZknSSvo1RJ9tV1rEwDod0DwTigPY
   oEc25+tdbs8VbjZ1I/K/A04FMCVvjMWfbN0jD1TfeXcEn72PnUD548bHh
   2pUkMTQ7J8fmWsTTq8FYMZmpm67pyq2/7dopb958FmFQC31TWYVvpe+2d
   RNqOwxfocgrJvGxTUEHRJoZ1oH1yMX43fhUqvLug6tYe53gtIjC+dNgT7
   w==;
X-CSE-ConnectionGUID: l6k+7SRBSTiZ5RirIUYLoQ==
X-CSE-MsgGUID: LJB9MmItSri1Voh4+Lz4uw==
X-IronPort-AV: E=Sophos;i="6.23,204,1770620400"; 
   d="scan'208";a="288093138"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2026 06:07:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 28 Apr 2026 06:07:12 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 28 Apr 2026 06:07:09 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 28 Apr 2026 15:06:50 +0200
Subject: [PATCH net-next v2 01/13] MAINTAINERS: add FDMA library to Sparx5
 SoC entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260428-lan966x-pci-fdma-v2-1-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
In-Reply-To: <20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 22E7748594C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281855-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

The FDMA library under drivers/net/ethernet/microchip/fdma/ is shared by
the lan966x, sparx5 and lan969x drivers, but is not covered by an entry
in the MAINTAINERS file. A subsequent patch will add new files to the
FDMA library, so let's make sure it's covered.

Add drivers/net/ethernet/microchip/fdma/ to the Sparx5 SoC entry, since
I am already listed there.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7dc9e6fad2e..53559c74a132 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3084,6 +3084,7 @@ M:	UNGLinuxDriver@microchip.com
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	arch/arm64/boot/dts/microchip/sparx*
+F:	drivers/net/ethernet/microchip/fdma/
 F:	drivers/net/ethernet/microchip/vcap/
 F:	drivers/pinctrl/pinctrl-microchip-sgpio.c
 N:	sparx5

-- 
2.34.1


