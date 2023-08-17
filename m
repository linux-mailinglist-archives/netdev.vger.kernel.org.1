Return-Path: <netdev+bounces-28365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB9B77F2F7
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABDF281C24
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299C12B8E;
	Thu, 17 Aug 2023 09:12:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369512B86
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE9FC433CD;
	Thu, 17 Aug 2023 09:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692263565;
	bh=GXIGtEMigdYTSCm2iTmqFELl4pZbSdBA2ThXERzYR1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGRviZinUBE4lgehqCUeo1V4Hgys+hK6OWx4J1S4kpbsTNJRVTL7a6Xt/xvjwAwPw
	 ytyE6pi6+UwC3LmFKpVfToarP8gp+vmMCUu3NRDN14VzWOT/7xkk4P98raAWYKny8b
	 HzuJUJVgduQ7D/X8kcD7cgBhlYmnQZO866vh+cmVZPDyqn+F9bCeSECeo3JVGpVXM9
	 hvRDlyT4ikLw2JA81Fp7P8z7KusTmlsgOOVy09FO3HUbrnFZLIQtaLo06l9r9d6GaA
	 6rTb4bZvelDg+zU/966U6JyUdBCCUj9pgS8KfrsPdFj+5nUtlmRA92l2b3v80ReSjc
	 0CgZneqfQ6raQ==
From: Leon Romanovsky <leon@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Dima Chumak <dchumak@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v3 5/8] net/mlx5: Add IFC bits to support IPsec enable/disable
Date: Thu, 17 Aug 2023 12:11:27 +0300
Message-ID: <a978d0a9239d3109faed5531102d026662153b7e.1692262560.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692262560.git.leonro@nvidia.com>
References: <cover.1692262560.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Add hardware definitions to allow to control IPSec capabilities.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 08dcb1f43be7..fc3db401f8a2 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -65,9 +65,11 @@ enum {
 
 enum {
 	MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE        = 0x0,
+	MLX5_SET_HCA_CAP_OP_MOD_ETHERNET_OFFLOADS     = 0x1,
 	MLX5_SET_HCA_CAP_OP_MOD_ODP                   = 0x2,
 	MLX5_SET_HCA_CAP_OP_MOD_ATOMIC                = 0x3,
 	MLX5_SET_HCA_CAP_OP_MOD_ROCE                  = 0x4,
+	MLX5_SET_HCA_CAP_OP_MOD_IPSEC                 = 0x15,
 	MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2       = 0x20,
 	MLX5_SET_HCA_CAP_OP_MOD_PORT_SELECTION        = 0x25,
 };
@@ -3451,6 +3453,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_virtio_emulation_cap_bits virtio_emulation_cap;
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
+	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
 	u8         reserved_at_0[0x8000];
 };
 
-- 
2.41.0


