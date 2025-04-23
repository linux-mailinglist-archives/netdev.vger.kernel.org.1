Return-Path: <netdev+bounces-184983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D80A97F5A
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F71189A0C9
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 06:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE32262D0C;
	Wed, 23 Apr 2025 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HGm/3o1D"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B41DE4E7;
	Wed, 23 Apr 2025 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390161; cv=none; b=AUI7z3lmF7/KKRcmUhpqj0FrySY5bGumdCMUTA/8ZljhpZotWIiDFvbWLPMLIvHsLPctEoiNiLgyOiFfOkC0H5TfXk9YGAJlANRoyKU4/5xHRroyMEdHy97GfFHM4dJhciZnM0DyLp8qEV4B3yVpUiKzyKrNb4A4brDqT1ZdkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390161; c=relaxed/simple;
	bh=4sueNLSXZyEnCvgfTumwCoU8uLt8qTggA0SiY1v7lOM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IZqKcz9EO+jXRVjDGiPBRGjEWOD2K8nSfpTKMCmrO6u1Iy0gYNLJGBbqtqDphflZZ0d3veg0T4XvNDI0vfWAMt6thTw5tqH1wVxscCZ3GxaA2ESp6AJkJbB4OuDvqIZ1awapZyQouTa7bsGz5sTUaVgxmUHKL8j0I4fCJDjweMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HGm/3o1D; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745390113; x=1745994913; i=markus.elfring@web.de;
	bh=Mf0YxB47xn6cTkgijZrbPJ6w00QCzMLFlOWIetZPPTs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HGm/3o1DciErxDYuuf1SwaacYOcQ5kCKZpbnpmnb4U2BUj6map3PQ0K9jC6rxwbg
	 UNN6CmZJsp0VsPUyI6DtPHQL41ieKJ+J0Yz0fcVsaKEl3vI7dli+ZpeQMyjQhxkdn
	 ez0r/46bLWC5f2NpvzmHWnOsP54YjSwC+3E1wug+75yRqZ4IYGNcMYRGz27MpVqRJ
	 fnNHnCVE4LPo+PLld8/c7qoKMrRo4amZk7Ibv4COEnNtFKFgKWPZox2gUjB8K/AHu
	 YcYo6yC6i1hyPhhuvnjltFGs/aSguoRzJrzFhzWI33C3ocC5+inBWQuEdDb5JQJVr
	 cx/xXn8BzfoklKMaaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.6]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnG2C-1uqTcT1Uc0-00ZYoN; Wed, 23
 Apr 2025 08:35:13 +0200
Message-ID: <a70bf317-33c3-48eb-a454-9d95117eaa6c@web.de>
Date: Wed, 23 Apr 2025 08:35:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, Abdun Nihaal <abdun.nihaal@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
 Simon Horman <horms@kernel.org>, Vishal Kulkarni <vishal@chelsio.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] cxgb4: Return an error code only as a constant in
 cxgb4_init_ethtool_filters()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lL1AMBKvJOUcW1Sfg112ZkjgkBc8nYS4dsBmae+dWmLh0LepZ7h
 Ng8DGwpIbJdQUJGZeNxKSmrS7ctTviL08XuTUsYce9KQVuE8TWW1nMWkM/RdE5cG8LSQWlq
 Gq17COPC/+jsMickWvnzLeK+k5Jt+wc0UHQnfKAxaseTSuBZnL2NuZANgJLMMXA0eztx+ll
 r4O2yc51QI4t5NIodQLYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/qcuy12rYWQ=;eceuahPHyge+M6HdOpZszTP2ORf
 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
 czvTkopZN/6qI=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 23 Apr 2025 08:15:24 +0200

Return an error code without storing it in an intermediate variable.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/=
net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 1546c3db08f0..fd4f6c146ad2 100644
=2D-- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -2238,7 +2238,6 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
 	struct cxgb4_ethtool_filter *eth_filter;
 	struct tid_info *tids =3D &adap->tids;
 	u32 nentries, i;
-	int ret;
=20
 	eth_filter =3D kzalloc(sizeof(*eth_filter), GFP_KERNEL);
 	if (!eth_filter)
@@ -2247,10 +2246,8 @@ int cxgb4_init_ethtool_filters(struct adapter *adap=
)
 	eth_filter_info =3D kcalloc(adap->params.nports,
 				  sizeof(*eth_filter_info),
 				  GFP_KERNEL);
-	if (!eth_filter_info) {
-		ret =3D -ENOMEM;
+	if (!eth_filter_info)
 		goto free_eth_filter;
-	}
=20
 	eth_filter->port =3D eth_filter_info;
=20
@@ -2262,14 +2259,11 @@ int cxgb4_init_ethtool_filters(struct adapter *ada=
p)
=20
 	for (i =3D 0; i < adap->params.nports; i++) {
 		eth_filter->port[i].loc_array =3D kvzalloc(nentries, GFP_KERNEL);
-		if (!eth_filter->port[i].loc_array) {
-			ret =3D -ENOMEM;
+		if (!eth_filter->port[i].loc_array)
 			goto free_eth_finfo;
-		}
=20
 		eth_filter->port[i].bmap =3D bitmap_zalloc(nentries, GFP_KERNEL);
 		if (!eth_filter->port[i].bmap) {
-			ret =3D -ENOMEM;
 			kvfree(eth_filter->port[i].loc_array);
 			goto free_eth_finfo;
 		}
@@ -2287,8 +2281,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
=20
 free_eth_filter:
 	kfree(eth_filter);
-
-	return ret;
+	return -ENOMEM;
 }
=20
 void cxgb4_set_ethtool_ops(struct net_device *netdev)
=2D-=20
2.49.0


