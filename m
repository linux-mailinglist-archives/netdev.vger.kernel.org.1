Return-Path: <netdev+bounces-288088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB+1N6pGBmo3hwIAu9opvQ
	(envelope-from <netdev+bounces-288088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:03:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E35474FF
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA28730A2B5E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D603D34B3;
	Thu, 14 May 2026 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="IVSvB0uR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="h4ePGEyN"
X-Original-To: netdev@vger.kernel.org
Received: from acj35aaf126.lhr1.oracleemaildelivery.com (acj35aaf126.lhr1.oracleemaildelivery.com [130.35.116.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE673D1CB4
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795705; cv=none; b=cwux6pqiKzKgBYRA+EPuG3CqiUMkoTzPs67L+3SheV4e49zo/lfKgVnV5cM79ywcMsEpfm0//22b590bdg0OdQ8l2YSB5g8psXcfZBr0PoPCadoVunvEg+U4CaOTuvlaOI0CNH8tlQjb+SJfXdxsHdZDkW3yu5tagQ75nbsI4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795705; c=relaxed/simple;
	bh=SLygEdd4cXqK3o3IGUginuunzKS23d4mg6XXR09qFf4=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=cBgSrHrLDqkZgMoeP3xTSQCNjrpElQhvzzxB4tygvkelumwur9HMbXiQ076zlgbTaowi7WQVuTb0+eOJNCx1BUVWR/fh3UFb1MYqPkMPabRtuXuw88vxVxUDWVLvgr8yYFQPzGXL49iDNgL/26mfMw6qWeX0ujV5UgZfF4cWhf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=IVSvB0uR; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=h4ePGEyN; arc=none smtp.client-ip=130.35.116.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=FZvXfQHwc0uytzMRSej+dYkhKiNEOLiffrYDTYx5G6s=;
 b=IVSvB0uRy8BaWmNd6ItGnlVptNAie/gAQiPcwuVGCWFnYGJahT6wVd6cjDKqCu2TUjIVj8OpQB4Z
   PfHrIhmx0nf+AmFb1YWX1fujGSndw9AAfkcrITKJgdMuYlUZlFN9CYrGBbYs5HsF/GsJQBsDrHGo
   AqtZQCtzfhnK6eXJZNf+prduJYEZiO2Fk39nFGwmJAFJGTyunbKGi+rmnTNfB1exUw/DNyEPLtti
   1siNzS2V6WM503oY8fhZBu0kJQCfAaUDvNHK/9Ilh2EwCXSife6MOIiAG4thqTzBPawEAefZJ5o5
   vrXyv6t6l1mfUPIUOR/CkfAYWBwPHIr4rTWfHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=FZvXfQHwc0uytzMRSej+dYkhKiNEOLiffrYDTYx5G6s=;
 b=h4ePGEyNyBcQW9Dpn1IebdzOrUz/Zb+C0C+sMXE94nxhzhnoc4gKNCHSnw9i0ULlYtuv1LOM8wxD
   q+857+JN2D5F4KO9CquzpuQ8OmDNs1iSEOV8z0ZKy0m5l0E+B4jCsJqZdrh0W4o7Ty73NyoMZEaq
   FyxIK8AMShCXxpsbhJFfKvkK2DdQro780+wS9HCNTxuEaVd9IF++mhaJ7XcugYYYnZjYUOXewn2m
   CYo8u3pSq0FDPMdncuEUHAjsb5sPMZQzUU5EN5IHQP1IqplVWiXjFd0Ay6q3rDR5YFdlz3DfHInu
   IZ0lCJGupyTJKY6lAhuRqW/73SdEdppor1a8gw==
Received: by omta-ad1-fd1-1402-uk-london-1.omtaad1.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TF124TVQRJO5IA0@omta-ad1-fd1-1402-uk-london-1.omtaad1.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Thu, 14 May 2026 21:55:00 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Lukasz Raczylo <lukasz@raczylo.com>
To: netdev@vger.kernel.org
Cc: Theo Lebrun <theo.lebrun@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH net-next v2 2/3] net: macb: insert PCIe read barrier before TX
 completion descriptor check
Date: Thu, 14 May 2026 22:54:58 +0100
Message-id: <20260514215459.36109-3-lukasz@raczylo.com>
X-Mailer: git-send-email 2.54.0
In-reply-to: <20260514215459.36109-1-lukasz@raczylo.com>
References: <cover.1777064117.git.lukasz@raczylo.com>
 <20260514215459.36109-1-lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHf+Z0YX8zBMsksb6gSGL9ZV3VCbo9am2PhbSO1iipMaVnbSZPP4U7YWpbXzRHK
 g669lhZ1JQctwueluqmAYAuNG1sS6Qw9c22yyFHvMUITW0zfopNANtgYzCq/wDp4
 wyPoo+dgRi4PmjaFKy4eqf0F1nxSkuazO0llXjeGXjcHQX75Nr2wy9Tf9GWzDDTA
 Tsy9pfbk5c9kLV8ESdpUqpMIpZ7YKq4TxSWJDDSs+iTZRuiF/p3eD8CVy+IBZMq3
 5isof24q1nVqfdi841nscUQr1i6lujtVilri2JGdsAttDXp+T49cS3LFZXNjYhF8
 GQ8qJFyY7jWgrrZ/WYkTg+MRvl7I9dtm5FVIdQtlnXG1X50uLtoi4w1QCUcVw25X
 3XXXDN7t/NYOnoHLK4HDw4LsewINCQF7hFeMg0GXQGYzInsvg+iRJ6uKYjAg
X-Rspamd-Queue-Id: 4B3E35474FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[raczylo.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[raczylo.com:s=oracle-uk-012026,lhr1.rp.oracleemaildelivery.com:s=prod-lhr-20191104];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-288088-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[raczylo.com:-,lhr1.rp.oracleemaildelivery.com:-];
	FROM_NEQ_ENVFROM(0.00)[lukasz@raczylo.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.911];
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:url,raczylo.com:email,raczylo.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

macb_tx_poll() runs with TCOMP masked, drains the TX ring, then
calls napi_complete_done() and re-enables TCOMP via IER.  An
existing comment in the function notes that completions raised
while TCOMP is masked do not re-fire on IER re-enable, and
mitigates this by calling macb_tx_complete_pending(), which
inspects driver-visible ring state (descriptor->ctrl, after
rmb()) and reschedules NAPI if a completion is observable in
memory.

On PCIe-attached parts (BCM2712 + RP1 PCIe south bridge on
Raspberry Pi 5 is the case I have in front of me), the
descriptor DMA write that sets TX_USED may not have retired to
system memory at the point macb_tx_complete_pending() runs.  The
rmb() synchronises the CPU view of earlier CPU writes; it is
not sufficient to retire an in-flight peripheral DMA write.
Under that ordering the in-memory descriptor can still read
TX_USED=0 when the hardware has in fact completed the frame;
the check returns false; NAPI exits; the quirk above prevents
the re-enabled IER from re-firing; the ring goes quiescent.

Add a side-effect-free MMIO read between the IER write and the
macb_tx_complete_pending() check.  The read functions as an
architected PCIe read barrier for earlier peripheral-originated
DMA writes on the same path, so any in-flight TX_USED update
retires to system memory before the descriptor read.

The register chosen is IMR (the read-only interrupt mask
mirror); reading it has no side effects on either read-clear or
W1C ISR silicon (it is not the ISR), and the read still flushes
prior DMA writes via the PCIe completion-ordering guarantee.

Link: https://github.com/cilium/cilium/issues/43198
Link: https://bugs.launchpad.net/ubuntu/+source/linux-raspi/+bug/2133877
Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6879f3458..f7fa9e7ad 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1984,6 +1984,14 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 		 * actions if an interrupt is raised just after enabling them,
 		 * but this should be harmless.
 		 */
+		/*
+		 * PCIe read barrier: flush any in-flight peripheral DMA
+		 * writes (descriptor TX_USED updates) so the subsequent
+		 * macb_tx_complete_pending() check observes them.  IMR is
+		 * the read-only interrupt mask mirror; the read has no
+		 * side effects on either read-clear or W1C ISR silicon.
+		 */
+		(void)queue_readl(queue, IMR);
 		if (macb_tx_complete_pending(queue)) {
 			queue_writel(queue, IDR, MACB_BIT(TCOMP));
 			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP));
-- 
2.54.0


