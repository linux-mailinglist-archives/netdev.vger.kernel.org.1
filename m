Return-Path: <netdev+bounces-241490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 569A9C84708
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D0C434F93F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9B82F6598;
	Tue, 25 Nov 2025 10:20:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E272F290B
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066002; cv=none; b=hkOOOKcfXw9zynn1sarVuum3KDsUHbtJCa8SF6Y1KpHHRLcy2IaBy3XiCny5zvbZ9OG6l7OJM41CUH7bpMcnR6shLsWd3KulZ0iRHQiH7SkUxRd3E25gseKM8iQAhySW0/Tz9kaE3lhgsto+6xOS6YxmSgSIouw2eoDXVRbC71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066002; c=relaxed/simple;
	bh=hVEX4eVAfWJb5W2oFiVN1kQa1CjAK6kJPi2V6F44wTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWKL3CNsXHBr6iE7Pq8tqeQWxkFLcPfM2HT99DB7OQzQxFzmw1f46k7HCNMuDJAPVpP9W+CeCmPsVfL3RwWNr57NF5Rurc5h5evW9/fnBEaxXsqPsjWSkT1zYOXqGG8IQ/gQKEi7Wod6Lgm/mqOUDBrdQTxAfxuFMEAQGk9FzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c75fd8067fso3110817a34.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764066000; x=1764670800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h8v9/WTizrePyr3QJeAH1/2LNaWTwWj5f0e5cWpR0qY=;
        b=eukMxe2XmmqsVF5rPOVY7PgANkk2cU5ajFch2w1xFF5XpgJIWS5oDz1lXwhxOMb/RG
         6uh7HWaZdGZwWfXpP/Q5ChjPmAR6B9IRqqrq175edDu2NRvH1lOB8O9vNAW1bKOuIwtY
         H2WUZiK+a+xVHqCxL/Wm5VjOoOvS0qXUDf5y8w6Xr1by+EHA88Da6n8CqFjbo7y8mGlS
         PO6tCiURGCiu8DPIDNQfjsYqEjBSCdN5tF5gkPHsUbjzL+9tSRXIOP+3GNNCELxmyUt/
         YnHqH+fPYMlz4AEF7RDvw+INJpA3tPNd43vN8D/RhiyosgrxVlpivQZ2kK18qts3jrg+
         /b+w==
X-Forwarded-Encrypted: i=1; AJvYcCXyj/AsAALS2jvzUtMpvK3pqzevSU9OO/Ew3EYh4F5wigNQPsEe5Fr1Fm5BzOvQY7+Xv+lAY68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxni/Ps5q+hVqE7HLLeQAQFWMZ/CKSNKg4+ZX+9C7f3tHnVNad6
	mM9pIsX1DLGqCekDNUTZ3v8G7XsvpIDYhfD49qw1bGOH5/cUHZzpueIC
X-Gm-Gg: ASbGncuIUBNtBa6unQKdNAxBKs/AvWx9WtmU9/zCBc9nesvGKbfZiyvr5mWQXPRJ1h3
	bEw8mk7K1W46mKxBRIz1kN2DkWqzGWm2mcvJseJFZa69mWlf8MPBAKLDLD+ScZw2Sr2viSp3JNC
	DSqv2tZ5womOIAWJ5UOOxIREWMx8Us90s6gISf7WSH8pWNcptvXd3VcgaIeHQhON+u4qikawSP1
	H/KLJaP8W8HwtgdMj/kEXNv1pSsveHpQRoS8b9+XLWHgefV8Fe3enN+t1DWvKcTW0av6qhCQdw+
	lyWICdXqaO4ILzBmuQv6zr7tzyywguXdjqesBTw2yBXf+fKSyjWsAhMMDiW0KpeQaZco4rU0ks3
	Qd8P+R/byx3ZEU42rBN421vnUX9h9i3GmVPnrXcdbpO4Mr7BOi3hsNJCYXLbboaVWrZFd5IDxrg
	hOFOzKC84bgb5f
X-Google-Smtp-Source: AGHT+IE6t71uMK8vJhUZf3a/GMa3fQepPfD+FiI5B3hDu2dvBBm1hjM9xvNb0LamgEBtLV3ur2SqXw==
X-Received: by 2002:a05:6830:719d:b0:7c7:62d0:b462 with SMTP id 46e09a7af769-7c7c42b680emr1199371a34.6.1764065999790;
        Tue, 25 Nov 2025 02:19:59 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d3e2b43sm6139322a34.19.2025.11.25.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:19:59 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 25 Nov 2025 02:19:48 -0800
Subject: [PATCH net-next v2 5/8] igb: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-gxring_intel-v2-5-f55cd022d28b@debian.org>
References: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
In-Reply-To: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=leitao@debian.org;
 h=from:subject:message-id; bh=hVEX4eVAfWJb5W2oFiVN1kQa1CjAK6kJPi2V6F44wTs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJYLI5QoXS9+mJwT5CIZcE4OlmgbGwG/2mdjWe
 58PXeytql2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSWCyAAKCRA1o5Of/Hh3
 bdCiEACSgNVB4KN8Azh7hBw6ckkRbrThhhx63ZWDCp6/YNvXnsbqJv6nKQbUfQXQ0jWDda46H/I
 XrH/JxD3zH5O4vH64EbO7Y57egV7sgm7WgFNu21smSBNN3ccunDTmlUJqIcFCwZ29uv0++TMx0E
 Lb9fXt3hHjuwu6Ovvc/7aSuycpBQzCdLLlOToTQp8UXzxgKQFT3L6MMQDXt3Tyb21QrzsWmpI7Z
 sEiZq8i/9XJc7maUllQDm20RtvIUkwRarwPwsbdaYF5flWor9JjupY9G0AbcACExt+zq5IntXIp
 T+/+F2SNaXz2PIBf2rRoMsc8fFyv129QxIS7Ht8hzvju8Sqv/rVF/JQ1mA1OfLaXkDL97UfmB7x
 o0DZjOLwKoAg5V2ZlwbSmUJiIyv8x3SfrDU4HjIdm1Z+qhC6thsjk5gN03RHWTQ/IZaRzIFCv30
 G+iw20MZ6VQD+wku+OUqer1c//4H3HPSNC/KHx3VEiAk3u3wuw3UUt3itze90/EMF/bs6IZo3Y2
 w0u7dND+a0OW+4cF2F/dt+gaB0wzP5Sq5bIKgxtVHe5MtBU6f3IgcoDyQIbq3OqDmxeBPffFtl1
 j1ywp2RdAjRBR+A2PEZCVK4DKJydD8Mq4SyLygWR62gfFefyPLa5uDXmSnahWXIGYYa0I0+x9X8
 6NHpyZBi8i9YOuA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns igb with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 10e2445e0ded..b507576b28b2 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2541,6 +2541,13 @@ static int igb_get_rxfh_fields(struct net_device *dev,
 	return 0;
 }
 
+static u32 igb_get_rx_ring_count(struct net_device *dev)
+{
+	struct igb_adapter *adapter = netdev_priv(dev);
+
+	return adapter->num_rx_queues;
+}
+
 static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			 u32 *rule_locs)
 {
@@ -2548,10 +2555,6 @@ static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_queues;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = adapter->nfc_filter_count;
 		ret = 0;
@@ -3473,6 +3476,7 @@ static const struct ethtool_ops igb_ethtool_ops = {
 	.get_ts_info		= igb_get_ts_info,
 	.get_rxnfc		= igb_get_rxnfc,
 	.set_rxnfc		= igb_set_rxnfc,
+	.get_rx_ring_count	= igb_get_rx_ring_count,
 	.get_eee		= igb_get_eee,
 	.set_eee		= igb_set_eee,
 	.get_module_info	= igb_get_module_info,

-- 
2.47.3


