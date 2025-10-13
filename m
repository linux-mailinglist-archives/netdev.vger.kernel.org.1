Return-Path: <netdev+bounces-228740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B707EBD383D
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148A5189EBF6
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6031C84A6;
	Mon, 13 Oct 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEdi1VQV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2E519E97A
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365796; cv=none; b=bbc/7lwAJEO3k6mHQYX/GAx9iiNYoaoQpzoIX3k80/hfUxEFhhnYmuWnSpyvph00qFHLAKiXmny4jOoKpCHi9bfJZ1zi4MYkDfdcEEQiwTaV+vh3VJ+aHqIyNI4zx/iQ9pIqjs/zAf7SEKGkiHv/aaReWXQgAcFAlajp1oiVb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365796; c=relaxed/simple;
	bh=kC+XxfYUzP+Yf+1ScjmU9ueeS1EQBoD+QY0KhVAVO4Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nbT4VuRUzE4A2uzxw2G5Pcv6B06rVAtXcsH8tlsf5c5GxQo1z8DlY/Wo3e9G3g5P4kW3uP/slxCNLs+B3KMHEcmzM3OjhLUflAmv/Egc0Oj8KXbljcYEzxxJOk53j4PBUEw8xfK1llaqJ+s2gbRA/i4cksJoGs0RIubIAmbty0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEdi1VQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2266EC4CEE7;
	Mon, 13 Oct 2025 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760365795;
	bh=kC+XxfYUzP+Yf+1ScjmU9ueeS1EQBoD+QY0KhVAVO4Y=;
	h=From:Subject:Date:To:Cc:From;
	b=dEdi1VQV8xRaiCfQ2oSehyxlChzj05g1iNkyVo0jK9/HL/EVDHHhCahi2EL2vBy63
	 OvCqYj066ZfnqXc4UbW8IHwQ+GCZMxVtKKDOkLArTc+bcWKshXNph1iudFfP+7rICn
	 eQqT5hYLRIJt8SCFx0KG828x2uBKivc58DxGSQsTz11m6L5sMM2x0JZ7zEOxKM4Jds
	 WUk9FxUriAlhybA8KXj6P20U+Ns0L9A9h+ylfxBU6Ja2Vfvhph0krh+12QtswJxsUr
	 otryYNATGnKHOpYJs9CqYBsSA8QkEFoS455ws2/GIa6n3h5vnUQPTAGgaw9JFp0pOw
	 MQgLOmqwEvgdw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/2] net: airoha: Add some new ethtool bits
Date: Mon, 13 Oct 2025 16:29:40 +0200
Message-Id: <20251013-airoha-ethtool-improvements-v1-0-fdd1c6fc9be1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANQM7WgC/x3MwQqDMAwA0F+RnBeIZcq6Xxk7FBttYDaSFhHEf
 1/x+C7vhMImXODdnWC8SxHNDf2jgymFvDBKbAZHbuiJHAYxTQG5pqr6Q1k3051XzrUgvdw4Ts/
 gI3low2Y8y3Hvn+91/QFYNZT2bQAAAA==
X-Change-ID: 20251002-airoha-ethtool-improvements-08266c4a9d09
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

- add missing stats to ethtool ethtool_eth_mac_stats struct
- set get_link ethtool callback to ethtool_op_get_link routine

---
Lorenzo Bianconi (2):
      net: airoha: Add missing stats to ethtool_eth_mac_stats
      net: airoha: Add get_link ethtool callback

 drivers/net/ethernet/airoha/airoha_eth.c | 5 +++++
 1 file changed, 5 insertions(+)
---
base-commit: 18a7e218cfcdca6666e1f7356533e4c988780b57
change-id: 20251002-airoha-ethtool-improvements-08266c4a9d09

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


