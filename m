Return-Path: <netdev+bounces-169527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA84A44658
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63C0863EF9
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9780F18DB17;
	Tue, 25 Feb 2025 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow4txWpi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D317E015;
	Tue, 25 Feb 2025 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501226; cv=none; b=U9dhUwwlqXWA3BIJxeGz6Rdr+emoPPaMILbGo++FMz0WkQ6P89zs4fawohmt14mZ4Jku6fqzviGSvRd+CwZYyL223SEIdZ8IzVlED/WOAhIZpmAh9pG27Gts9EksHcAkaCWsswAnzirF4PCcQODW29vCx9q5lKObZgG/2EYguBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501226; c=relaxed/simple;
	bh=NqYvq6GfBXbQuFPVOUtl3UqBOH2cLfkOSchjZ/ypfjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lPufzBNH7fFKZXaV5C/uhgthzKENtlsgtDN6v4ZfOINNqpFvpzSvRDFwlGEOChvuU+mT9YUuxpKTq1ATAOcbcXMtdYA1Fuy7gtNepuQBGHnO0dyhedvoEgyipjtM93k+Sig8VqWLcfb1f92UZI0O5MrbFFDMfZnAyuVdIzn1B4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow4txWpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBB0C4CEDD;
	Tue, 25 Feb 2025 16:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501226;
	bh=NqYvq6GfBXbQuFPVOUtl3UqBOH2cLfkOSchjZ/ypfjc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ow4txWpi6dekVomHO/j4GgPgrhdqyYMAmU1CmS0Ly5zKZMAtS3PCL7RfzhLZNlykk
	 cuvG2VxC3OiV7NynCMpHOFfVoTIKBc1hviCLZou8PMfX+Ax5ujR2qVCGl2djj94++P
	 9TWa3JWf5d/nFZ6sBLZPN4pyyuEOYxTZNIXnKEjIOQH8Umzmt+hX/3GTXFYXfZ5sYS
	 ZGPIwblci8jPxekLPg5DpKdvTKKhX2yGRUtZchkTtEe5psI7wWDG/6ZEcH8TLP0Mnn
	 8auKUiVPIrsFtgVKFbtSXEasmN5bT6EdzsRbMCwcvvetRZKBRDI7KLtxHJEEnWxAy9
	 AgsiWtRN9hdXw==
From: Arnd Bergmann <arnd@kernel.org>
To: Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: hisilicon: hns_mdio: remove incorrect ACPI_PTR annotation
Date: Tue, 25 Feb 2025 17:33:32 +0100
Message-Id: <20250225163341.4168238-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows a warning about hns_mdio_acpi_match being unused when
CONFIG_ACPI is disabled:

drivers/net/ethernet/hisilicon/hns_mdio.c:631:36: error: unused variable 'hns_mdio_acpi_match' [-Werror,-Wunused-const-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index a1aa6c1f966e..6812be8dc64f 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -640,7 +640,7 @@ static struct platform_driver hns_mdio_driver = {
 	.driver = {
 		   .name = MDIO_DRV_NAME,
 		   .of_match_table = hns_mdio_match,
-		   .acpi_match_table = ACPI_PTR(hns_mdio_acpi_match),
+		   .acpi_match_table = hns_mdio_acpi_match,
 		   },
 };
 
-- 
2.39.5


