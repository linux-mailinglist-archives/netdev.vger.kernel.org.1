Return-Path: <netdev+bounces-90997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E058B0DF6
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB66B23BB5
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C27E15F3F4;
	Wed, 24 Apr 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADulGBhb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889115EFDB
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972020; cv=none; b=IIVWrz2MkKjJCo+79o2FZuWw/UboXYDUVPOZyR6NdP5pz9ZE484WSfimOKWQ4Gsl5EFwah8Oc7Ky++To95Xf0Z1sHc7z/v05XDA4jJ4VqbV/P57oYbYlvTIoXeUygUDZIgP1xzojkGc7iKWveEo2mJOaHetJI6aMXQObG5oN9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972020; c=relaxed/simple;
	bh=YJbIN0U/dfBcMYMj7GkeB26qYHH+xWSsJanUhNwfBQ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EtULuJA5ox8mrU8DIsDCINWFkAFQM9PO3AmdgUdoNfDGkwA1/olXWYsIZ1QlkBhfVnIODgdYKvsdl8oTbfKL8Q6056ioaHRkLaQnphfiOg12zLhTt2+tM6LN3n27JCVydrc09AYIMKqn8l1QFRvL/Xt6ZidgReFLLNWz9xdQgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADulGBhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB8DC113CD;
	Wed, 24 Apr 2024 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972019;
	bh=YJbIN0U/dfBcMYMj7GkeB26qYHH+xWSsJanUhNwfBQ8=;
	h=From:Subject:Date:To:Cc:From;
	b=ADulGBhbp4YdIeR1A8dDIyk/75qxoE+tzBCrSoU7iHaDzIS40DRmn9obCdRz1qqpF
	 bSjIEw15q/44lOR1fMeMu0JsXuCyyc2ixHciRuXgRFOM/woX311NwqxfJs7c4RPYrn
	 5dqVfwtmbF0PomrykQSaAhED9V6XEgscCkPZmIm4fNQLGicE+LI4hNCjIhKe6DEXTT
	 x7nAQ+4h/D7G9VicqrZ7kc+luLAL0aeM+IDRVZBN5uXWQZPVaDvExAKFDGcKQoYmMz
	 VtGEvcjRqQh+foX2VI018DtWikeNIL/7X3Opyr3qzb6hU3e4votFYSCC3UHPYNheqP
	 EUJJX8b5NVuXQ==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 0/4] net: microchip: Correct spelling in
 comments
Date: Wed, 24 Apr 2024 16:13:22 +0100
Message-Id: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJIhKWYC/3WNQQ6CMBBFr0Jm7Zi2oFVX3sOwqDDARJyaKSEYw
 t1t2Lt8efnvr5BImRLcihWUZk4cJYM7FNAMQXpCbjODM64ylb3iGMRX5YJNlI71jdemDYE6ct4
 9Ia8+Sh0ve/EBQhMKLRPU2Qycpqjf/Wq2u/9bnS0adMFc/Nn6UNLp/iIVGo9Re6i3bfsBlHIDD
 rkAAAA=
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
Changes in v2:
- Patch 3/3: Use 'extack' in place of 'extact', not 'exact'
             Thanks to Daniel Machon.
- Link to v1: https://lore.kernel.org/r/20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org

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


