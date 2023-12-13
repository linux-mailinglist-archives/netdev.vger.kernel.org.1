Return-Path: <netdev+bounces-57122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316BA8122D1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83922B20F87
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D0F77B39;
	Wed, 13 Dec 2023 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSR5MsLe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3E77B2D
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99FCC433C8;
	Wed, 13 Dec 2023 23:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702510138;
	bh=jUHyUeLnfbSzBxtN3d9CndNvmtz13tEGP80B8miWkWY=;
	h=From:To:Cc:Subject:Date:From;
	b=TSR5MsLeLTV39+ncEEojg/aPltoHsEcEzA7hNHhl2fyqHVN24lQb9QohAZTMiUwtu
	 BwDlL6GrmWZHzOMpjN/zbHx8yQcSRSZ7yYHPDHTzsIIrWsEpB5ELjqV3DKXhn7KM6F
	 pSvQdfaoqWJY0RpjbUxI3cY4f2sjlDM2ytpAhcYQgjcvU7kRUHQ/UsfL/LA6hS0HTE
	 Jy5SKGH/DRFtR/gbQGi01jm236HMEtaMTWbvjtfeoHcQEtklQXLyd/qXEdk7qZfxgw
	 OX3M8G8zc8ewIujrbqgMKRy7RxDsh9AbD4dzmkFYuUb16EIxt6HuaFvbza9jpRPa0N
	 RRK/CSpwE8Yfg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] netlink: specs: prep legacy specs for C code gen
Date: Wed, 13 Dec 2023 15:28:19 -0800
Message-ID: <20231213232822.2950853-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor adjustments to some specs to make them ready for C code gen.

Jakub Kicinski (3):
  netlink: specs: ovs: remove fixed header fields from attrs
  netlink: specs: ovs: correct enum names in specs
  netlink: specs: mptcp: rename the MPTCP path management(?) spec

 Documentation/netlink/specs/{mptcp.yaml => mptcp_pm.yaml} | 0
 Documentation/netlink/specs/ovs_datapath.yaml             | 3 +--
 Documentation/netlink/specs/ovs_flow.yaml                 | 7 ++++---
 Documentation/netlink/specs/ovs_vport.yaml                | 4 ----
 include/uapi/linux/mptcp_pm.h                             | 2 +-
 net/mptcp/mptcp_pm_gen.c                                  | 2 +-
 net/mptcp/mptcp_pm_gen.h                                  | 2 +-
 7 files changed, 8 insertions(+), 12 deletions(-)
 rename Documentation/netlink/specs/{mptcp.yaml => mptcp_pm.yaml} (100%)

-- 
2.43.0


