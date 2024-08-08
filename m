Return-Path: <netdev+bounces-116958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE2C94C33E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D8B1F23385
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED6C1922C1;
	Thu,  8 Aug 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="TGazH7mr"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAE18B471;
	Thu,  8 Aug 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136439; cv=pass; b=VjkDm6lyicb71S3pEKsmZNcdLOBape1w9hyty1BLVcdbbT4YnA67KIrVKtzJDjKilQlNwG+Xn++De1LV4ecrZiCS7qLOE80ReZUcIRlUV6DiMJSdWQY4CjXNKPmQMUL0uniQG48S4d8s7nqeipcA+Ww7JcRYtdWRKt5+ONgQ4Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136439; c=relaxed/simple;
	bh=ZJc6UZNNkrQszcl8lVcGVZCC2nUp6OHQph69oHVv5ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUTJ0mhRwGkgRGzXL/mld6JTzcI2r7bP77PV7pQdGzzcG71hgGQzmINWoq0R7TaZuzCSpGVb5wCznMGVWuLOdmVXshHXQ246Hnb/amlH9wiphRnvXRgWCF3Hja0tOFmdvw3100FQVW7hbBQeUX+Q7JEEsTGhZU0HbQkkTotYc/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=TGazH7mr; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723136400; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iufzSaCy1styaAcA1ACND9zvtAK5h50zw+7d/AHF1uHdSCZQh8419xBPItU0tFxPsWuGYGA8154598/0uXsGBVvo/nBp+wAF3EQUcUhArz94Vnj0ehA7Zv5EoZrE+74Twkhsc8rHS7owT8tSbYPE+FmG9hAAGir+qXcZ0mOvK0k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723136400; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nrb729petfY91nzUq0Q3CuuVyGhgg3PoYngbWZak+YA=; 
	b=oC5ki124tlmSTkczfqJDK0kfBeQ/ZpiYha40PYgfxXguZZpRteU3vUazp5ehtdKx0NkkzTaFJ+VrAEDpsqVjUuvuYRsAF+un+3BCwd1qcVaRqIYE0jxZmOJiinXWTZZ3MvcdhTT/dL4eUB5Y4z2YdM29ryI5hLqHokUIEoW5iMM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723136400;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nrb729petfY91nzUq0Q3CuuVyGhgg3PoYngbWZak+YA=;
	b=TGazH7mrbZN/WSe2rKBwGJxBtwoy5NfjHrohQ/WRP0ibmbtLkBtaOLgKZx340r2F
	JTftASJFEMHwKLhJoc+j7ENSzlfIYl8pSju3gZLCuahwQnHYx59vvnv3TW9/3LgKdqW
	KxQrG+kabjyKqtK2wwWoPEB/vEaEkiLcW4UDizUQ=
Received: by mx.zohomail.com with SMTPS id 1723136398929189.99879437516017;
	Thu, 8 Aug 2024 09:59:58 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	David Wu <david.wu@rock-chips.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 0/2] Add GMAC support for rk3576
Date: Thu,  8 Aug 2024 13:00:16 -0400
Message-ID: <20240808170113.82775-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add the necessary constants and functions to support the GMAC devices on
the rk3576.

Changes since v1:
- Add binding in net/snps,dwmac.yaml too

David Wu (1):
  ethernet: stmmac: dwmac-rk: Add GMAC support for RK3576

Detlev Casanova (1):
  dt-bindings: net: Add support for rk3576 dwmac

 .../bindings/net/rockchip-dwmac.yaml          |   2 +
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 156 ++++++++++++++++++
 3 files changed, 159 insertions(+)

-- 
2.46.0


