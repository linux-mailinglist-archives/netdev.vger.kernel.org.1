Return-Path: <netdev+bounces-89634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED3F8AAFCC
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 15:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3961C2181D
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE71B12B176;
	Fri, 19 Apr 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz2F82eS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2AAA59
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534868; cv=none; b=u2+d9+ydel/sS6v+fC9NRwo76U3HpLB+r2w5W2+MyWyj8zVKNI0WJyFdIQKmeZhcfye2EWDQ/7Vj1ZE/KW65/zG4lAzMGv74wIq9O4HgsX+udTRlp5MqFNdBHqihcX0fRP+6mx6YAtO+ljLt9v9QQWPqbX7P/HV8c89TpqFaHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534868; c=relaxed/simple;
	bh=yChrZ19QUvriU+RMhHRAah20JT8+YXgxz5fTNxVIZno=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NzbL2upsoDLLnfhJKLnZ9ZL37R4DJ3b1aMvcFCvJp9HWadtYWnrNKxbXDNvGAlbncK2d95WyKViWQaYtDB4hx7qIcp8n1CtL8URsaKPx+jHk5YA50FgLXooZsRNjcGIWQLsB9kRhiGFk0KKokg4Hgr9awNyVERENXfGRvTslArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz2F82eS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94706C072AA;
	Fri, 19 Apr 2024 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713534868;
	bh=yChrZ19QUvriU+RMhHRAah20JT8+YXgxz5fTNxVIZno=;
	h=From:Subject:Date:To:Cc:From;
	b=Kz2F82eSODfSaEihjuq0LReirSH84fZtpNTIWubTlPX+0U2SjOHDnNyyZEXAIowF+
	 Wx5RG0gFtS5wWPItLO/6Wqe17ijnZ5HMz5rSSA2RdyZar2Ybl1XGNhx4UXjTA+lpR0
	 nuoHyz3cXnEn6KueRcmByAl+V9fY7JLr9IkWShNPoAYv/prubzh9mr3zoGEW4/UYIQ
	 r6/wZ5MyLNbtu4mv8f3I17u+QyD28d4wy1VfAs2/gVzDLAq4G0AfzgPm9IAFa7+tui
	 RUnmPWOpEx+dVtcYvGxex3mHTBXzSmO3f0kN58jJ0+lPDUJFAYozGj4+LFc3Qemo8n
	 5rtnQg0T71HXg==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/4] net: microchip: Correct spelling in comments
Date: Fri, 19 Apr 2024 14:54:16 +0100
Message-Id: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIh3ImYC/x3MQQqDMBBG4avIrDsQ04DEq5QuYvxTB3QsiUhAv
 HtDl9/ivYsKsqDQ2F2UcUqRXRv6R0dxCfoBy9xM1lhnXO95DTq4Z+W4a5K8sY9zCEiwg52oVd+
 MJPV/fJHiYEU96H3fP2Ir4l1rAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.12.3

Correct spelling in comments in Microchip drivers.
Flagged by codespell.

---
Simon Horman (4):
      net: lan743x: Correct spelling in comments
      net: lan966x: Correct spelling in comments
      net: encx24j600: Correct spelling in comments
      net: sparx5: Correct spelling in comments

 drivers/net/ethernet/microchip/encx24j600-regmap.c       | 4 ++--
 drivers/net/ethernet/microchip/encx24j600.c              | 6 ++++--
 drivers/net/ethernet/microchip/encx24j600_hw.h           | 2 +-
 drivers/net/ethernet/microchip/lan743x_main.c            | 4 ++--
 drivers/net/ethernet/microchip/lan743x_ptp.c             | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_ifh.h     | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c    | 4 ++--
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h    | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_port.c    | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c    | 2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c      | 2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c    | 2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c      | 2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c | 2 +-
 drivers/net/ethernet/microchip/vcap/vcap_ag_api.h        | 2 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.c           | 4 ++--
 drivers/net/ethernet/microchip/vcap/vcap_api_client.h    | 2 +-
 drivers/net/ethernet/microchip/vcap/vcap_api_private.h   | 2 +-
 18 files changed, 25 insertions(+), 23 deletions(-)

base-commit: 4cad4efa6eb209cea88175e545020de55fe3c737


