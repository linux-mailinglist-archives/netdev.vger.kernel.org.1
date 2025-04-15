Return-Path: <netdev+bounces-182671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C7A899BA
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C157A4EC3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD84228DF0B;
	Tue, 15 Apr 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RGnqFyEt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="FxbIXQ3H"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF828B514;
	Tue, 15 Apr 2025 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712344; cv=none; b=K2d4MQWq8resyhCwaevXRWmFxnTuso6dDO+8Q33v+LkU98B7iRmHDkHG7JWjrzi51S29n5E0psVbhd2UDRiZ7/eMwbRg0q5+EpqY3DlK6mnM7DQ0YV64jeswr+4Su26WSFJxExa6/mnySEIFBjcQwMhLHqJuCMOE/eWBYdEaN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712344; c=relaxed/simple;
	bh=hycr9RrMa/7Y9VWU/Z/GmIOCv9QKk4RftFGy1qVEEyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VBjiehzsJo8YKPvYSuH6nvbhwRHIG9xCygZWa2iYqZTZvc9xajwFwhSj8ILayVbpvgnIkuMULlRF9yl8jaJ3nR+JrGvMSBwvBYxLORT5/YnZkUEQ86zXNHIwuqT1y5uPtxeNVtf+N8q16eifXz9Hunz3/UFw+5/fQU8J/PWKR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=RGnqFyEt; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=FxbIXQ3H reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1744712339; x=1776248339;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nb1CaeSyZdwCqAexjrlTSruwnwqmG4LLxlXJojt81rk=;
  b=RGnqFyEtnaz9tRKmro35jkfV3ilPA5+75dOFN5xRBZBfLHCxevOghUlh
   Xqgq4OiqksOXfGRXYvXJsrBndlQNKzfZn9pGpblZpcQUUXMje3OYcg+e8
   lsnYT3jVwLGcXKKwvkm0OLXjuf1b4IZ+I/lmk4Ire3DfoXo7qgTZYhrqu
   AS1LyikkSTJTulNbk5tn7WaSalf5UEP1YJ5g7t7Ttn42IhSi5YLfY8cBD
   eLcyp2wRKw6FiPgeYpZfOtswxy9u7lav378GqcSCeNzgm5YTqji6ALOBh
   yOh/vSUvHK5WARNMMSwLLPZguNvxOaeyViIIRyy2RxX8qH5bFUC2wTIxv
   g==;
X-CSE-ConnectionGUID: qHslwqOKQDS3n+C1PL8nQQ==
X-CSE-MsgGUID: z5CBpqFHQfidSCZ9bnHD7g==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; 
   d="scan'208";a="43537779"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Apr 2025 12:18:55 +0200
X-CheckPoint: {67FE3290-2D-903EAEAC-E04C76C8}
X-MAIL-CPID: 776D1808CE1E037E8E14824437E2A7F7_5
X-Control-Analysis: str=0001.0A006378.67FE328F.0080,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E105F161113;
	Tue, 15 Apr 2025 12:18:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1744712331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nb1CaeSyZdwCqAexjrlTSruwnwqmG4LLxlXJojt81rk=;
	b=FxbIXQ3HA+sGY8beUPvzMhSf8rVMxH9ihaDwISw58nDj4onHiPYDmzZR3r5FmvyQ0+ryhE
	SPTAUFh5jUFCYhlaUWM0uUeM2ttx8wXnwRF7SAZI50AGPebD5uP+rZ44+XCcghjbAg+3ba
	v/VucSP2xJw4k/hFi8G33/22jbmMOP0XsrRWeID36OjgICE1rfJHeyT6bnivXqmE6aAnmj
	3UggLZoPYk5wHtd9qwIhlbjpv462wNqOLuiXrDRUmMQ2RVE0imOhqc5FRo0BX7se8qW2f8
	IpNo1YCmCWf3g6pjX3ie/lkmJrK59/Ogx8BbITKc/rNhU/FXHqimWAH8vt5Riw==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net-next 0/4] RGMII mode clarification + am65-cpsw fix
Date: Tue, 15 Apr 2025 12:18:00 +0200
Message-ID: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

As discussed [1], the comments for the different rgmii(-*id) modes do not
accurately describe what these values mean. Update the binding
documentation and fix up the mode to account for the fixed TX delay on
the AM65 CPSW Ethernet controllers, similar to the way the icssg-prueth
does it. For backwards compatibility, the "impossible" modes that claim
to have a delay on the PCB are still accepted, but trigger a warning
message.

As Andrew suggested, I have also added a checkpatch check that requires
a comment for any RGMII mode that is not "rgmii-id".

No Device Trees are updated to avoid the warning for now, to give other
projects syncing the Linux Device Trees some time to fix their drivers
as well. I intend to submit an equivalent change for U-Boot's
am65-cpsw-nuss driver as soon as the changes are accepted for Linux.

[1] https://lore.kernel.org/lkml/d25b1447-c28b-4998-b238-92672434dc28@lunn.ch/

Submitting for net-next for now - I don't know it would make sense to
backport some of these changes to stable.

Note: I have also added the maintainers for the TI K3 SoC families to cc
in addition to the get_maintainers.pl output, to loop in some more of
the relevant people at TI. Should MAINTAINERS be extended to include
some of you for the am65-cpsw* files? At the moment, only the netdev
maintainers are reported for drivers/net/ethernet/ti/am65-cpsw-nuss.c
(except for "authored" lines etc.)

Matthias Schiffer (4):
  dt-bindings: net: ethernet-controller: update descriptions of RGMII
    modes
  dt-bindings: net: ti: k3-am654-cpsw-nuss: update phy-mode in example
  net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay
  checkpatch: check for comment explaining rgmii(|-rxid|-txid) PHY modes

 Documentation/dev-tools/checkpatch.rst        |  9 +++++++
 .../bindings/net/ethernet-controller.yaml     | 16 ++++++-----
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   |  2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      | 27 +++++++++++++++++--
 scripts/checkpatch.pl                         | 11 ++++++++
 5 files changed, 55 insertions(+), 10 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


