Return-Path: <netdev+bounces-171682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40665A4E1F2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EAA116F638
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39907276D23;
	Tue,  4 Mar 2025 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/cUNq7O"
X-Original-To: netdev@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A192063E1
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099714; cv=fail; b=h5j88iAPfzuhZANuv/fnO8DMx0AmRYY34MqsFh7lr0D9W1McnHXrLGdcrkpyiCPaOiyBL8s3q6xj+QuJlfZ4jfZyub0ebwIWVU2Q+kfQIe/s+8CDFOr7oWSF0IDABl4gPlxhkGlRx3/o5mvA/Uf89ewllA5/fZd1VKmYUl5+R34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099714; c=relaxed/simple;
	bh=CGEcvGW5UxIBOBlHpmZcGgsIR6pcCHCtB6h3nxJt264=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UOq8iXdbk7JEcSjPDPWlqIuCSLwA8uAk6XtyvlY39XkIpiuDjysr2t3NUIpqiCLd8BauXULaoHeuaExg/gxjS5AgjmUiTIcp/nclpmi6bqYVuWbnpjc4yI+1+Tj1S52DAY2NwHf7a8mGVbI4yBOJFPNjL3dXGCzu8o80Ivk6bQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/cUNq7O reason="signature verification failed"; arc=none smtp.client-ip=198.175.65.9; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 5B67240CF12A
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:48:30 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c/cUNq7O
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dnr5CH2zFxg6
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:47:44 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 12AC842720; Tue,  4 Mar 2025 17:47:34 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/cUNq7O
X-Envelope-From: <linux-kernel+bounces-541374-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/cUNq7O
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 3349B43668
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:30:58 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id DF36F2DCE4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:30:57 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4504170220
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F64F1F4735;
	Mon,  3 Mar 2025 10:28:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6A1F2380;
	Mon,  3 Mar 2025 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997712; cv=none; b=tXdatXpvgAzxuMj0Ls8wcG5NuhvwLJwwArOKLASURJe/MVwmWKXMR6p7DguSp45aptrbOVRXPtdZ4lTU1fSmZqS+9fQny9usow3Zpc528MqT8ls8nFMbBa2OIJlY83GvKIeCi4Kz5o4omX3hbm7evpWur66VS31UWaxmMoSx4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997712; c=relaxed/simple;
	bh=P6ccI5F2+0bACe0n0NkpiYH116w0AVZ4cwwt/aKfPE0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=paO1VDeRtUeXcEQWW3vOsI4o3nzhuXkfNG2VC+HTMIW0kQZDF9ecIxg4cGf4tUkyb/UC7zkCfdot1ak5WYSpTkQ9j+T7Zh0ZddcAJ9n5INXixkJLZaem4PvDbNbLJnfZQO737GEqEHpy2s3xRoOs2h+uvEyXfshFKDco2X+dCgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/cUNq7O; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740997711; x=1772533711;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=P6ccI5F2+0bACe0n0NkpiYH116w0AVZ4cwwt/aKfPE0=;
  b=c/cUNq7OYD6Grb58TR65YS8XR/qxDeaaWaoo/F70P+bKUEDcbc/lmL6E
   4SKT8oGd+hsYGRmmbXV+z4iFoyoOCrwIjSUJLtSt7HxxCuWzSPYfHbH5S
   mnhAO4n2booLNAQ/henIX3LSxMYwZL4dioPG+3o+6QkxyxVcXy5Uskpfv
   mzczzdjDNfe/CeBE775zA7VH9d8thAYSb7Cb+QFYopIVg8fWRhGx9L4vi
   IfFDtYR3EwvDV43GD7lSLZ8eIcEjSqZP/pLzn7Rim2++OEBphbgUDE2cc
   Nu3AC6Ak+WOz8Jd31bNBQrDeyBx5Nx7eDWvsRLvc87qrr9DtDJd7Q9hUC
   g==;
X-CSE-ConnectionGUID: /zaUF2XsSKiqJeKsU3+GcA==
X-CSE-MsgGUID: 7HpBJq95SaW2RR+4zH2ZiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="64310294"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="64310294"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:28:30 -0800
X-CSE-ConnectionGUID: IJ+J0UlmS3KRsMbMevFqAA==
X-CSE-MsgGUID: cS//+fnETaSB4iJW+tt0zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="122569920"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa005.fm.intel.com with ESMTP; 03 Mar 2025 02:28:23 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v7 8/9] igc: Add support to get MAC Merge data via ethtool
Date: Mon,  3 Mar 2025 05:26:57 -0500
Message-Id: <20250303102658.3580232-9-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303102658.3580232-1-faizal.abdul.rahim@linux.intel.com>
References: <20250303102658.3580232-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dnr5CH2zFxg6
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704466.92588@5QcBUP0wixRxo+YC5KDUGQ
X-ITU-MailScanner-SpamCheck: not spam

Implement "ethtool --show-mm" callback for IGC.

Tested with command:
$ ethtool --show-mm enp1s0.
  MAC Merge layer state for enp1s0:
  pMAC enabled: on
  TX enabled: on
  TX active: on
  TX minimum fragment size: 64
  RX minimum fragment size: 60
  Verify enabled: on
  Verify time: 128
  Max verify time: 128
  Verification status: SUCCEEDED

Verified that the fields value are retrieved correctly.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 14 ++++++++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.h     |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/e=
thernet/intel/igc/igc_ethtool.c
index 529654ccd83f..fd4b4b332309 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1782,6 +1782,19 @@ static int igc_ethtool_set_eee(struct net_device *=
netdev,
 	return 0;
 }
=20
+static int igc_ethtool_get_mm(struct net_device *netdev,
+			      struct ethtool_mm_state *cmd)
+{
+	struct igc_adapter *adapter =3D netdev_priv(netdev);
+	struct igc_fpe_t *fpe =3D &adapter->fpe;
+
+	ethtool_mmsv_get_mm(&fpe->mmsv, cmd);
+	cmd->tx_min_frag_size =3D fpe->tx_min_frag_size;
+	cmd->rx_min_frag_size =3D IGC_RX_MIN_FRAG_SIZE;
+
+	return 0;
+}
+
 static int igc_ethtool_set_mm(struct net_device *netdev,
 			      struct ethtool_mm_cfg *cmd,
 			      struct netlink_ext_ack *extack)
@@ -2101,6 +2114,7 @@ static const struct ethtool_ops igc_ethtool_ops =3D=
 {
 	.get_link_ksettings	=3D igc_ethtool_get_link_ksettings,
 	.set_link_ksettings	=3D igc_ethtool_set_link_ksettings,
 	.self_test		=3D igc_ethtool_diag_test,
+	.get_mm			=3D igc_ethtool_get_mm,
 	.set_mm			=3D igc_ethtool_set_mm,
 };
=20
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ether=
net/intel/igc/igc_tsn.h
index 6b48e0ed4341..a00dc1d80e12 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -4,6 +4,7 @@
 #ifndef _IGC_TSN_H_
 #define _IGC_TSN_H_
=20
+#define IGC_RX_MIN_FRAG_SIZE		60
 #define SMD_FRAME_SIZE			60
=20
 enum igc_txd_popts_type {
--=20
2.34.1



