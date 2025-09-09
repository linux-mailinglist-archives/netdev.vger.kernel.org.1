Return-Path: <netdev+bounces-221392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A1AB506F2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995F51C22C2E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC0035FC1F;
	Tue,  9 Sep 2025 20:24:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00E35CEB2;
	Tue,  9 Sep 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449463; cv=none; b=PtGiQE8bBg35EoqVAXn+33l5mGFxT44KELfGPGMjxz0V/sRak+rK29Wgxsmr78PLnbehwxporlV/VXkVrlrY1UWyTl2sPypJRM3fkVpvUP2Uswa6Z+MX0UJmCxD1NIiw0Y6yMl4yPLdCOPe/WttfMUL53uXpgZEvS02E77ttC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449463; c=relaxed/simple;
	bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XUdf9kenMKnkhLAf3TNopDNd6nzOavHYZ0k8FpUrRO/0xYZM9qQeGmqmODNTadLdcdFxlqt1ZymEwjrqwhE/JYh+YVbDu3us02VHBCwyFL5geSZK2GEZy3mhfgwQAp0oVLPxxudCD3TcKVtvqgpCzXMUAZ957YZaX5uA7Oi1/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b047f28a83dso1033788766b.2;
        Tue, 09 Sep 2025 13:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449460; x=1758054260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEyyDJEjHIGcptoyVMY30XDmajElEFVLCjxYGTHfuEc=;
        b=bn/8sCxjxKLHqNjk6XQVtnqzp2LToIXvJKMN7NTesuhtdeL43AKBWmANhIdjba9HMz
         k01M71ztOLYMIgFoYLWaqvJDfwckS+8i6hiw5OCcHwtFyB6amkHL5V5eXbp1GLWc0wV7
         TEh69eWKH0fqu3hJrQsVOa67lGtKY13YDtOtIyTndZzoFO8qyEDl/5eJ0pDHYIDF3vi2
         gNSPu9OOF3m55BRaCcapvUNI1fyZx9EGW+eOW0CG3NWv8p9Zti79lfGp6ftHSgGBHESM
         aO9vlaPjBe66gIm0ZJvCYO8nGlZJ28EXLeQKRy2uiby6JgYoITRMpWnXDkcRjlrCCWtX
         ho4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpw2tYJEU76ISQ+RMWuSdAq11EOFlzezJtNOhUmlxKB+7DjKaWxJD326TSe9gdurkY4aCHYGfF2Mo1yjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrytFyruk0u+yZ9kYXyepSBu01WzhOD12WNSBRUJdMlVPWJInY
	YtSdLopvtR3BsPF/xCRZ9ude235ogF/8lAUqd6SA/o/+UEa2ewNzdUE3
X-Gm-Gg: ASbGncupAKA1We75HyfyguxAN3XEMh4LOZ6/n365MTBRLFapf0ra8JBT2fjcGypVm69
	X0K4XU4eA++ZbGrDxdsCkX7hK2Xp9qO+eLVEbQ82Fitjob52EyPnEYoIoY44ai8cDIZ+CkXW3CK
	atl7OfJrBBrdLf/BiJzvFeIWDFD5el5l2dfknVX+hqtea4/7uEjMqL7YV+JRMJw4Z3n7yeTmj1c
	VPM+bwfG/mfciEG8dXge5Bc9ny/JHsTsbYGxb3H/DApJdCUngURsqx2pJT4DuvDZ20T2DNTYWqa
	f3Mto5p1EAPqsXzMjXk0V2PsrmcaxDY6HcN91Tw5JOFKOzgeA0QtvoE/ZSdqE0j2TnXD8DBuqUs
	h7rmsCa2qqnZc
X-Google-Smtp-Source: AGHT+IFu1r0fknjD96QmQU54NZeaJTSld6HXrwh8lrDcMpKUCdz8Ptis3MfqzOneT4vAqsA+wMPHNA==
X-Received: by 2002:a17:907:86aa:b0:b04:33a1:7f1b with SMTP id a640c23a62f3a-b04b1446e50mr1215344166b.19.1757449459625;
        Tue, 09 Sep 2025 13:24:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830a7bc3sm46969566b.36.2025.09.09.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:24:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Sep 2025 13:24:00 -0700
Subject: [PATCH net-next 2/7] net: ethtool: add support for
 ETHTOOL_GRXRINGS ioctl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gxrings-v1-2-634282f06a54@debian.org>
References: <20250909-gxrings-v1-0-634282f06a54@debian.org>
In-Reply-To: <20250909-gxrings-v1-0-634282f06a54@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=leitao@debian.org;
 h=from:subject:message-id; bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBowIzu0yH3IVMs7fK4gZDpzXSyteK9WNUC9W295
 SdSoczlAr6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMCM7gAKCRA1o5Of/Hh3
 bYD6D/9lJqcUOpNSwQqYATFngBRmXbtxTJJbT8gKRbinsx7LmqsT9rfMUOnNqVm6EqmnuRdb802
 4YBtIm7OViTHvs4mIBT5FOtxpPMnx2vIme38yxQocH0NOS9yzHxiGrMg1GdP1KXKJTcfQPrAmjN
 BuhR43mukV1l3182jrSI7tt+WfKGoXqvaRbXyjCY8JCR2mAzDWuaRewyDNRCf/BCww0YFL4135J
 P8LfZ/CYiR81GsHOcw7scN1NajcVBkjKu878wVwzUT5lfa1VOfBVNcXWc/0ySSCKj0pWGlgc4Dx
 vxTl9Bs5LftPamGY8dEgUizjpICHLL5lT607vGZLSdPzpggo33lKuhStONeCk3SumP06KmQ5RGn
 WJDtg4F2Sxyh4TqSbS7BeaXb/Nm07serEdlF4t1/3u9Nhd0C5dDRztjwEeicl768N29qbztjFjt
 Sfb2SXqI+br8DqesRODoFa2aamRZOihhcGtgcvsxf6TYJd7oknBxys/7wTz0fOB2+Fo4wpYn7ua
 DLhTbz14UHH30XjPw6GHTqjISymcXp1iTbm/Ef0UKM4A7Vb/8m+k0Ju3jIMl9qxX32BpAIFANRv
 v7mOKztZv8Qjzf6XQkvwQJxJuSUVlnmM7OtjbWsVRe/Kk41oum+qnCW3V+p3l/7TY858hzlYfBC
 WTV0eG162l3eacw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch adds handling for the ETHTOOL_GRXRINGS ioctl command in the
ethtool ioctl dispatcher. It introduces a new helper function
ethtool_get_rxrings() that calls the driver's get_rxnfc() callback with
appropriate parameters to retrieve the number of RX rings supported
by the device.

By explicitly handling ETHTOOL_GRXRINGS, userspace queries through
ethtool can now obtain RX ring information in a structured manner.

In this patch, ethtool_get_rxrings() is a simply copy of
ethtool_get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 15627afa4424f..4214ab33c3c81 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,44 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
 }
 
+static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
+						  u32 cmd,
+						  void __user *useraddr)
+{
+	struct ethtool_rxnfc info;
+	size_t info_size = sizeof(info);
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	int ret;
+	void *rule_buf = NULL;
+
+	if (!ops->get_rxnfc)
+		return -EOPNOTSUPP;
+
+	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
+	if (ret)
+		return ret;
+
+	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
+		if (info.rule_cnt > 0) {
+			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
+				rule_buf = kcalloc(info.rule_cnt, sizeof(u32),
+						   GFP_USER);
+			if (!rule_buf)
+				return -ENOMEM;
+		}
+	}
+
+	ret = ops->get_rxnfc(dev, &info, rule_buf);
+	if (ret < 0)
+		goto err_out;
+
+	ret = ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, rule_buf);
+err_out:
+	kfree(rule_buf);
+
+	return ret;
+}
+
 static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
@@ -3377,6 +3415,8 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 		rc = ethtool_set_rxfh_fields(dev, ethcmd, useraddr);
 		break;
 	case ETHTOOL_GRXRINGS:
+		rc = ethtool_get_rxrings(dev, ethcmd, useraddr);
+		break;
 	case ETHTOOL_GRXCLSRLCNT:
 	case ETHTOOL_GRXCLSRULE:
 	case ETHTOOL_GRXCLSRLALL:

-- 
2.47.3


