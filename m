Return-Path: <netdev+bounces-299335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +UKbMGSfL2rVDQUAu9opvQ
	(envelope-from <netdev+bounces-299335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:44:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08402683E84
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:44:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="NAUmLD/T";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299335-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299335-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62EF1300CBD2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DCC3B2D0D;
	Mon, 15 Jun 2026 06:44:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A23B0AFA;
	Mon, 15 Jun 2026 06:44:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505882; cv=none; b=eWzNeeF7y4AxKTCcHpFOBuA8mIKZyigSvbnnGIouS0QtNsXKO3HvoCL4coqErLbdmeejA4HOvBrI8CJQsXicVkKkmrQdiKKmhlMT8hHr37HXQJ7b1ZnO/VyPpdOEVRZ3VokC8r+beeYt5GsrwCkwDhPGhOQEpGnAc+xj0hJ77/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505882; c=relaxed/simple;
	bh=BgNw+od3r0XHP1gTD9qpvHWxLT+zDciH27t0Hen7A18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CjVG/L7wsJRZ0q0e8Y0hz1hy/ZLqc/QND/f83qV0JfIqnAir9hyC7tb4BrkjE1XANQBoEofigOhHWx5xlMM4qWoiHIl4yHp2NxrBa/Pk9oQhasoDSCZcJvpbo/3c3O2rz+H5el+7mR7zSD49GIDxBy4FyHtrYI9eTlBJCGItEoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NAUmLD/T; arc=none smtp.client-ip=54.206.34.216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781505805;
	bh=Y+YhFmJ7zQPy/B03J257BpZYszXx4YqYoQaIMSnYhZY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=NAUmLD/TlS1EPBzdUjAsJyU2LAbDQ0pDnCvhUrua7Ep8pQyZQTWx+8wnHhUp4H/D4
	 As0YeHyaHoz4ATEkytIXu9BJujMXhw5mcqgxRb1XIGAmIh99dp22GsKC2WtLyMbjxB
	 2QAJZfGel3lphLn5hx2IrirM2z9yjhHxayigPcnM=
X-QQ-mid: zesmtpsz4t1781505788t45f96c5c
X-QQ-Originating-IP: ALQMhJ1rMIWtfNfZmUkK2DSDMRurZNf0PD1+PhvPQio=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jun 2026 14:43:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1283702314587439345
EX-QQ-RecipientCnt: 9
From: ZhaoJinming <zhaojinming@uniontech.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH] net: tn40xx: fix netdev and NAPI leak in probe error paths
Date: Mon, 15 Jun 2026 14:42:56 +0800
Message-Id: <20260615064256.1068059-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Nuk8bQLQf5MZ0a43xjL58q5DZ+3jB3aJor0a/g59pKZL8csiKoFgSVvs
	OZLmo7UoXvePgroWnR1lBvkPEkBaL37/ZH/Q4777C2izJ4NwXqKWku9KkmbnZ5eop82AQWN
	Oyeprvb+QRk581KleA8aCpLRbzfkxGnbIxUDN+0vfYwoLCgvGWNMGVlEHZTUYfvuM8+/eGQ
	W50iQKcTQKR3scvMg8saNeuYCFtmbE0kif7dTu2Gq09DvHSBLK8RQLeza0+8xT06SIRO9eL
	yLiXWQUU5rjRpPQ88PdD0rSFb1+fjCnND+m2jSQUT06O0ZA4EV8AwC0R3JmPnexuPgMwCJU
	BV4mr4eQtGLA+hEZRDSvPcPKgbTKZrc1jxYc8I7D6SY4iwARkTEcL23WEAHxNZoIJ+qvez0
	+/7ytlE3k0uKR5lm881LgcHBdeEpjOdVXvKoLiQVoJCY8hAjpR9psdjDJH6CBBAJB39nvu8
	fLdkr8xA2J7VTFqWEOWhdYXgkslAhqJ3j1lICPtRCDjl+yjobV1ulCGpCWKRqOiCElZmVPg
	v3x2xTs76aYqI9Mwyk8WdIC+2MWhyg4TzdNcNqjhGX9nk9TGaCQ7jpU/2QLpRKYdheHncp2
	IQ07yTp8t+6pTXi5S9iHb/ajnJSnki2E1djGJUtl/6Hnkgzfwi5uOCUEaes7mizzL55fg43
	amkWNoyoquIXF3DSn3zKpIW8o2XAVc8EHCn64B0W5FK6IaUXbiDlZvUlS8zKqNYmrEftN6X
	YZDzlOkvbEA/RPrdpUQUettubCN2/Hwkx+Dvy1Sl+W8vCTFtwBSwfilnXluCKSX4Dowfzsr
	eJ5Ldxyooh8uFbUQZWDpf5fQQZKnDgwv6OX9js30zAd96g7+WoWtAu6w+5S5jHF16kzDXkB
	SVbp2eNq2A/l2CbO6blmK0Tf6tJpyriB3KtGu2vu9Gk9mYbAomlSMBMa9/5UEjKxFzZD5Il
	SKL+MKBRihx/wk6njLTV+bHjs+D8+eB8zg7Mpj6u7Ha3AA3zhEJ73jGRdC3+3PktRvIhS1R
	pWrXrrZP/g9LOdW5Xs3j+rxxCGdB4=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:fujita.tomonori@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhaojinming@uniontech.com,m:fujitatomonori@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299335-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaojinming@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08402683E84

In tn40_probe(), after tn40_netdev_alloc() and netif_napi_add() succeed,
none of the subsequent error paths call netif_napi_del() or free_netdev()
to undo these operations.  On any probe failure after netif_napi_add() the
NAPI structure (embedded in the netdev private data) remains on the
per-netdev napi_list while the backing memory is never freed, causing:

  - A permanent memory leak of the net_device and its private data
    (includes DMA rings, descriptor arrays and other internal structures
    allocated by tn40_priv_init).
  - A stale napi_list node that references already-freed memory, which
    is a use-after-free if the list is traversed after probe failure.

Fix by renaming err_unset_drvdata to err_free_netdev, adding
netif_napi_del() and free_netdev() calls there, and redirecting the
tn40_hw_reset() and pci_alloc_irq_vectors() failure paths to this new
label so that all error paths after netdev allocation properly release
the netdev and NAPI resources.

Fixes: dd2a0ff55408 ("net: tn40xx: add basic Tx handling")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/tehuti/tn40.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 558b791a97ed..532703e9c28e 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1751,13 +1751,13 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ret = tn40_hw_reset(priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to reset HW.\n");
-		goto err_unset_drvdata;
+		goto err_free_netdev;
 	}
 
 	ret = pci_alloc_irq_vectors(pdev, 1, nvec, PCI_IRQ_MSI);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to allocate irq.\n");
-		goto err_unset_drvdata;
+		goto err_free_netdev;
 	}
 
 	ret = tn40_mdiobus_init(priv);
@@ -1799,8 +1799,10 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tn40_swnodes_cleanup(priv);
 err_free_irq:
 	pci_free_irq_vectors(pdev);
-err_unset_drvdata:
+err_free_netdev:
+	netif_napi_del(&priv->napi);
 	pci_set_drvdata(pdev, NULL);
+	free_netdev(ndev);
 err_iounmap:
 	iounmap(regs);
 err_free_regions:
-- 
2.20.1


