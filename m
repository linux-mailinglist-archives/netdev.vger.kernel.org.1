Return-Path: <netdev+bounces-231237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15783BF65D7
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915B55416E8
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD1233CEBF;
	Tue, 21 Oct 2025 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN7l/pOj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129833CEAA;
	Tue, 21 Oct 2025 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047657; cv=none; b=QF+jx0OyJAlcnL+nKXve6oOQvumj1FZa3RacD83mHf7Ba0wa+PLaBs4am5PzbGLchEDtgKT6rm0zCsSom60T6e6HXoMUFBmEMPnrbjSXpFp6hte5c4K11utXQql7RfrBG/w15VB/jpxpQWDft6TSnHj/IwjdHQbI2H+rDxFzNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047657; c=relaxed/simple;
	bh=uPZbpRtuUAGL7PXaUrKempyAjExOsq+OSZosdwkFDXc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F1lZsJXssdcrGOZiJY3/MxoGab4ls0+pfCyqdzj44WizkOMihnNs2ggC8XLBKYgRsdy5hhHYRjy0o9N1skKpYCR4C5fFhhKZnElbGqrlDvNfcZ9B5oKsnL4VKooiPgQbN4HKfbzBmUGR4osb5hpvnRcXbd12R10ROXCzBb6d3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN7l/pOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C460C4CEF1;
	Tue, 21 Oct 2025 11:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047657;
	bh=uPZbpRtuUAGL7PXaUrKempyAjExOsq+OSZosdwkFDXc=;
	h=Date:From:To:Cc:Subject:From;
	b=fN7l/pOj403MC/dOkqseufxCFbACPUg2lwxHFfFY5q4H9hqfuUlOPralnu4qGlMMP
	 Yf8Y6gbDYv9gPMQoRJ+k9QtKGb8F1Zdy1ulks5cy7QOoLoCxpNKNSByBzSeWkrjs9s
	 nTo5xpLi2DVSdgNtHyuhWGX5dVw8ZIfxUBLhicyM40KnkflGnvoaF22dt91B67OW94
	 /PAeI2BPwTb971P1Xtu3W6F1BNiRBRMAnsyHk5Bt5ZWXBSLJguxpjl8giNlKonIKyw
	 JvlHTZIGU3TX0MZs4EwizUxBkS1y5D2s+fJdv91HHCuriJ9KAep61/OM30zoj4kEYf
	 vMOmklZ5sV+PA==
Date: Tue, 21 Oct 2025 12:54:10 +0100
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@gentoo.org>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: spacemit: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <aPd0YjO-oP60Lgvj@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use regular arrays instead of flexible-array members (they're not
really needed in this case) in a couple of unions, and fix the
following warnings:

      1 drivers/net/ethernet/spacemit/k1_emac.c:122:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      1 drivers/net/ethernet/spacemit/k1_emac.c:122:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      1 drivers/net/ethernet/spacemit/k1_emac.c:121:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
      1 drivers/net/ethernet/spacemit/k1_emac.c:121:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/spacemit/k1_emac.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.h b/drivers/net/ethernet/spacemit/k1_emac.h
index 5a09e946a276..577efe66573e 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.h
+++ b/drivers/net/ethernet/spacemit/k1_emac.h
@@ -363,7 +363,7 @@ struct emac_desc {
 /* Keep stats in this order, index used for accessing hardware */
 
 union emac_hw_tx_stats {
-	struct {
+	struct individual_tx_stats {
 		u64 tx_ok_pkts;
 		u64 tx_total_pkts;
 		u64 tx_ok_bytes;
@@ -378,11 +378,11 @@ union emac_hw_tx_stats {
 		u64 tx_pause_pkts;
 	} stats;
 
-	DECLARE_FLEX_ARRAY(u64, array);
+	u64 array[sizeof(struct individual_tx_stats) / sizeof(u64)];
 };
 
 union emac_hw_rx_stats {
-	struct {
+	struct individual_rx_stats {
 		u64 rx_ok_pkts;
 		u64 rx_total_pkts;
 		u64 rx_crc_err_pkts;
@@ -410,7 +410,7 @@ union emac_hw_rx_stats {
 		u64 rx_truncate_fifo_full_pkts;
 	} stats;
 
-	DECLARE_FLEX_ARRAY(u64, array);
+	u64 array[sizeof(struct individual_rx_stats) / sizeof(u64)];
 };
 
 #endif /* _K1_EMAC_H_ */
-- 
2.43.0


