Return-Path: <netdev+bounces-214196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF4BB28724
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F08B075F3
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A872C0F93;
	Fri, 15 Aug 2025 20:21:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0A317714;
	Fri, 15 Aug 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289278; cv=none; b=PGmeepBK5HOHvDBB82RjelCY4e/p3oalpQmuyn4JsNCQtnPDrwv8IboFb8/BEFJDjaM1RlNNEUY8sHQDL+WNyMHHS+yMcbl9vHlGOBLWDspZOLC9p4twLb95bwUk79PW9Df8Hu1JnHTIEEirn7MPvoiRc+r+Xfh/a6xlcUwOjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289278; c=relaxed/simple;
	bh=ZCEYv7vJ1Q53+ZfwmfDHKs0TvgM8lpXLaspwv9BuRNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DByULREv/QEshCWzfcF5CweFwB2sg0vfnLuHPLO8Wpq+if/PKRRMBj3e1SsCx6IiWUuhnUqtOgpf+c00K2hJ5vahQsj9Ul/VpHRx37TKfI2MdcrW7jq2igkA9T3rSS5+zE0HQsApOmj0CDkDpCeG931JJ+n48gzBV9xyXvPizdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id A55CC586B44;
	Fri, 15 Aug 2025 19:49:50 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C139E44296;
	Fri, 15 Aug 2025 19:49:40 +0000 (UTC)
From: Artur Rojek <contact@artur-rojek.eu>
To: Rob Landley <rob@landley.net>,
	Jeff Dionne <jeff@coresemi.io>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artur Rojek <contact@artur-rojek.eu>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Document J-Core
Date: Fri, 15 Aug 2025 21:48:04 +0200
Message-ID: <20250815194806.1202589-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815194806.1202589-1-contact@artur-rojek.eu>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetrhhtuhhrucftohhjvghkuceotghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghuqeenucggtffrrghtthgvrhhnpeeghffhgfeiuedugedvueevhfdvkeeifedtgeetkeffgfefkeeuieevffeitddutdenucffohhmrghinhepjhdqtghorhgvrdhorhhgnecukfhppeefuddrudeftddruddtfedruddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrudeftddruddtfedruddvledphhgvlhhopehptgdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheprhhosgeslhgrnhgulhgvhidrnhgvthdprhgtphhtthhopehjvghffhestghorhgvshgvmhhirdhiohdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsggvpdhrtghpthhtoheprghnughrvgifodhnvghtu
 ggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: contact@artur-rojek.eu

J-Core is a clean-room open source processor and SoC design using the
SuperH instruction set.

The 'jcore' prefix is in use by IP cores originating from this design.

Link: https://j-core.org
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a92261b10c52..558f51665616 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -783,6 +783,8 @@ patternProperties:
     description: Jadard Technology Inc.
   "^jasonic,.*":
     description: Jasonic Technology Ltd.
+  "^jcore,.*":
+    description: J-Core Open Processor
   "^jdi,.*":
     description: Japan Display Inc.
   "^jedec,.*":
-- 
2.50.1


