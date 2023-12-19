Return-Path: <netdev+bounces-59017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8287818FA0
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 19:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A4A1F21609
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7839AC4;
	Tue, 19 Dec 2023 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="I2a3hFnI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8D538FA5
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3dee5f534so6314535ad.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 10:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703009806; x=1703614606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTlXEcR4t5Hlyf/doBgXX6yd248goOi9cA6dA2nXTrk=;
        b=I2a3hFnIFwo/FANlclD2PNAiKhx0+6VYZ81ZnBzpwPDPkQConyvVMXwXEDHm5zfDns
         Smb4Qs7Gcsqt57O0PnWxWG7Qa0OD1Xsonp9qz87MXSCMP2EXr2j574paQrUCGEmcQTMD
         MHCBsVNkm45h2hNY4ayrC/BBhGWapaeqYhpTM8T/XmFKN03mDmCxLb3I/sAv+iGxuCsb
         9cPP0SlU8dm+nAKYqkMXzoTCDN79T/MURQRSOxAjQ0avJtP5eI/WheVCoKPjj8tFjRqc
         GBe7aymMA07zoPq/qJx8SZ/rc9rvn27lqtxIFiscEf9GCXzO3OavZHsIAhe/pSUEPVcv
         tjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009806; x=1703614606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTlXEcR4t5Hlyf/doBgXX6yd248goOi9cA6dA2nXTrk=;
        b=Inbl6VkVRylUpXsBYq+DWW4i87I2uN6npomRcCUJkTzLQKXwtj8HF5Z+6ENwaX6BFo
         +Zql5AjrLTMxDkC7e5oy0U2YUGs8h1PPBIn042VQiiQAtXo3imo1ENUBn1M2DrmTimpt
         qtULo+AxTSzlW0zEwoydtUaBryCByRZaJ8MTiNgoXd3wmWkV2DbmdPRuFf68drEY03af
         RVVI5XFmTQl50g/SvvTwjCENIJUySMJzBFF6z2PaRdkTEkIxpy31zQVZ/5qxGXzLospp
         IGGnDrNV6kAW0S+e/Mku/XaO/0s9jTSiJtsw6BFTpsthgiqgEYCSC75zjfbZTxVPjMEK
         msLA==
X-Gm-Message-State: AOJu0YynA9UnUrrX3DJ67v2+MHiBY4/EDd9NU5raFcpNmxePx91cA/7H
	pv5QomAp3prtTQh9G6Ie1pPWyQ==
X-Google-Smtp-Source: AGHT+IGSCyGuVZAlO6P649yOmVasrbXpP3bP9KEm2Uvfl2D/Vp21jLjH9QCsp0tXPNMlYxDdJecI9Q==
X-Received: by 2002:a17:903:60f:b0:1d3:b522:51a2 with SMTP id kg15-20020a170903060f00b001d3b52251a2mr1491414plb.40.1703009806485;
        Tue, 19 Dec 2023 10:16:46 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b001d348571ccesm4372188plf.240.2023.12.19.10.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:16:46 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v8 4/5] net/sched: act_mirred: Add helper function tcf_mirred_replace_dev
Date: Tue, 19 Dec 2023 15:16:22 -0300
Message-ID: <20231219181623.3845083-5-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219181623.3845083-1-victor@mojatatu.com>
References: <20231219181623.3845083-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The act of replacing a device will be repeated by the init logic for the
block ID in the patch that allows mirred to a block. Therefore we
encapsulate this functionality in a function (tcf_mirred_replace_dev) so
that we can reuse it and avoid code repetition.

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_mirred.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 6f2544c1e396..a1be8f3c4a8e 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -89,6 +89,16 @@ static const struct nla_policy mirred_policy[TCA_MIRRED_MAX + 1] = {
 
 static struct tc_action_ops act_mirred_ops;
 
+static void tcf_mirred_replace_dev(struct tcf_mirred *m,
+				   struct net_device *ndev)
+{
+	struct net_device *odev;
+
+	odev = rcu_replace_pointer(m->tcfm_dev, ndev,
+				   lockdep_is_held(&m->tcf_lock));
+	netdev_put(odev, &m->tcfm_dev_tracker);
+}
+
 static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 			   struct nlattr *est, struct tc_action **a,
 			   struct tcf_proto *tp,
@@ -170,7 +180,7 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 	spin_lock_bh(&m->tcf_lock);
 
 	if (parm->ifindex) {
-		struct net_device *odev, *ndev;
+		struct net_device *ndev;
 
 		ndev = dev_get_by_index(net, parm->ifindex);
 		if (!ndev) {
@@ -179,9 +189,7 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 			goto put_chain;
 		}
 		mac_header_xmit = dev_is_mac_header_xmit(ndev);
-		odev = rcu_replace_pointer(m->tcfm_dev, ndev,
-					  lockdep_is_held(&m->tcf_lock));
-		netdev_put(odev, &m->tcfm_dev_tracker);
+		tcf_mirred_replace_dev(m, ndev);
 		netdev_tracker_alloc(ndev, &m->tcfm_dev_tracker, GFP_ATOMIC);
 		m->tcfm_mac_header_xmit = mac_header_xmit;
 	}
-- 
2.25.1


