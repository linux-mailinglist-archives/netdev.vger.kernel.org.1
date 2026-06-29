Return-Path: <netdev+bounces-302532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MJkRF284Qmpe2AkAu9opvQ
	(envelope-from <netdev+bounces-302532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:18:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C876D8063
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:18:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=jwWIPkqU;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Cqq+ka7U;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302532-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302532-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E430302B5AB
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9773FB7EE;
	Mon, 29 Jun 2026 09:13:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB04028FF
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:13:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724420; cv=none; b=Etj/wHHM8EBRf/l81ICVNsW/zdeuS8dUe9dK4kNThpFSvC/yfWKALqyMEPBmpC48PcY81izYwqr6p1uo3dut0CpdJUZcwhB/qpYCjCAH7DHEk3itSsAIPrPvYcEdJ0gq3gzuFAkXhGgXtcPA2AYwi3fh2SH5rQ9v7TcT390EaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724420; c=relaxed/simple;
	bh=LAw6TP+//tnDWpTcxlgUU+E8OF1oyUbi54CbVTPa5rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dkm/3kMYVfKXkOOL8c/14b4zqVGwgEB7gJVNTOJz02ntuUVzsgeCyxYDvlSgMu4GUKmqjl67/s7V8I6Dv9sodYPhxLEj2qY8fsXBOlaawr5SK4CR8hzUWoRv4LQYhEyXrYhFe017URyITl4Yq/dSn2kJE1C6JDWWZ5jrp9vFSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jwWIPkqU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cqq+ka7U; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T9043U2433806
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NuAGmXhaYagKEsijNwanCl2DU/uS1mMyuthIapbtuKU=; b=jwWIPkqUfbIHUw4h
	qxXbw5MdhJ7tU5kAgvYT1xcyQD+B+MVZHIunycRmvl0cEsDfMzPPmmnNY48Ad3xm
	ZGBZEropJlIWYP5tX45jciHeyvSG9KJhhJdCEzNBBRNprWleIidgiUf2qq8ff8dM
	kvhFKuGq3RtjOnh643ig1kYJscniNaflHGpGwVuYOmU3POpqQ/6Tt9D9I0x/rHPE
	0CsoOG4YAVao7+vBDic3flhV9alXhJDUWz42OITy2PJgaGwlbFEXuC64Z7AFr701
	XmoIgFjrtmInhE93fUYcHj8QA6C6b4fqRcgqtRc1TCgMdtpu+5eZns7NlOENWCZQ
	MzmyZA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nper255-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:13:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e59b0e0f4so25616885a.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724416; x=1783329216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuAGmXhaYagKEsijNwanCl2DU/uS1mMyuthIapbtuKU=;
        b=Cqq+ka7Upn4AhiR5HNykbkrom/cJmtU8oWBRDgIIZCi7wVNQae0DO815Do7EGw+6Up
         GK6ioFc5km7sRG+fwCTWS6QHc5n1iD5QR0Zs4C0E/VUQPPZTjySu5hL7J1g3eYqOAhFG
         c+jtcwkHoDzeiTL6EFkgsQ4HzsGXJ+KqR7RQGdBor+jw5YAn1L44EsovzY44gXueVdcP
         nAbXTLTQGDk5GtEyUXOt7GegfBxy4PKEvgCpSsOynFFTBW0zvi508k6M+3F7XKvhV59D
         RJirTzz/qmPykPTE6EJahqUSdokCEYQkRpH9jtzyFnV2QLyrSCxJh2ddo5w/e++wY/Fx
         L6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724416; x=1783329216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NuAGmXhaYagKEsijNwanCl2DU/uS1mMyuthIapbtuKU=;
        b=eqwfsZMVkbiB2JtvThtFkjfJqsLPfPGCmrNim6IqebFWi4gzDxXgZocW6FIZHPWe9X
         l2igN/spHzvVf8aJVKlDyIJ6zS7VhYlHPwxV6o6KrmrWBVDJ4kJLVBLFMMYW5YZ5Z3Ov
         s4NODFzDo+w6vKnn1VEnWR6MYwIB5TxAbiEYWsnIEETsLDg/JrxGl3oJvYzxzG3gAGcq
         ItgHbseQEwBvE74sqnIcV6yVUlurCO3IkBgIgZkTwPsVsnsrDtz6Q6vCTE7q73mcZEib
         1OOV1hnpmgUEdeT04TfhPDTZQr7/lJt4TwqmueJnYg4QBQNMzuKpH3+n/9U+EolvLAtx
         LjZA==
X-Forwarded-Encrypted: i=1; AFNElJ/BP7TTRe3g7VFu2S/dWJ3llt7mDIE6yB7NIxGCGAIFEHyQlgJDlDpLr7wiaozG3mrAZDQh0Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB31amP0M4GjLiIy5mAByxxrOTM8sS/CxI70ycay4Sy00rtXUC
	zQKNf5/nXvnFijfhuOUC9+bqtQe3ZQzhm7dOF0RitKUDom+fyQvq3fSekzJ7aBcZ0Qv2XmbNuur
	pG4oTlc6LJJ2OfPUfuBPCXgFlj4G7p8xka2vu0cu7beqRtdcI3z58QXdUApI=
X-Gm-Gg: AfdE7cmDjh3I8GxirPZe0W9XOhWboeaHcgRHTzSuLHGEieWHNxfil7A9e8b1S6H9M7K
	NrQ4D5RcYBqWZs6z5IoocbvUZ2wEy/xatTL8ZOH5VSARqSizLfwF1oznGsOH2OOC9mdjzURggtD
	bgUXevIQTZ8IDA7+LNW1vyDpta+1LPWKdE/l7y/L/yUC6kUk8fV1rZNfhg1kwWaHyD+0w/Igoti
	/WrgQcvUdfxiJA+8Noip6ad3O3ppD1ij7FZntgTIfBXp5FqMvIq4FgnAljSe4mIuTN1LrqWU6/u
	t9we0HT6FKA3rs2/CNFhxrwkxvNcZkt+ItuGX1cB+TbSJpuQrHSX8DrnEmlXbYm/Uany51gce1V
	s3mKjI/swW06OQaMkMNKKCmqH5Ab6HENkcrrvPkDO
X-Received: by 2002:a05:620a:414c:b0:92e:51ee:7945 with SMTP id af79cd13be357-92e51ee8ae6mr323647185a.30.1782724415908;
        Mon, 29 Jun 2026 02:13:35 -0700 (PDT)
X-Received: by 2002:a05:620a:414c:b0:92e:51ee:7945 with SMTP id af79cd13be357-92e51ee8ae6mr323643585a.30.1782724415437;
        Mon, 29 Jun 2026 02:13:35 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:34 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:35 +0200
Subject: [PATCH v2 12/19] slimbus: qcom-ngd-ctrl: use
 platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-12-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=LAw6TP+//tnDWpTcxlgUU+E8OF1oyUbi54CbVTPa5rk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcRvVGm0XjHzeekMWgCSmedmQdOuB32YFAod
 HQ6XNyVL0OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EQAKCRAFnS7L/zaE
 wxVHEACqOwp3yO7AptcceX8k/naLnlKxs+wmgitoHHSTRNa8FE8HkJ7lYPPwAwc8lovQLX9q05Q
 6hcHOe4n4CZQbTxN15/qEZ87njRex4lLYPQZ0AuWZzlrx6rr4WQIRBarM875qSv95m5BL7AR3Du
 ENPTAKbTTX+n+C25UiY+ayBKtWsSGo+kpsjN3X3Z05TthGI8MH1cQqBtpCXwLDDDxk5ZJE+28wk
 Nxr04r/bKCTmFTKcAOLeZwe+n7OBQJiULX5aNGFND2NKf6gYXCLrX9uSvrOFKGgahmbtYUFZVrS
 aMQrMchr3DV0mRgFYqENcBrCgGeMZt6rZXDuQ2/lDEmpFrJ3JHsNtYzXygqcuHVQ31BjA2JQ+DH
 nrcD2BYjuGhGKUV7Wzayp9U1n/q6PJkAxKuVsOJx/jGmJeJsjfbNnyBY2f6dS7cDV583Hw7Z/tx
 6SzHZBOe8r5iHFsTvsP/CvjXUetP8B08c9s0WkwKNh5vrqHQt9jegjzDY6LZM8GsreGmq/SMB3e
 eED8xB8DcdpxLmveQkgTC7u5QBiF4N77Q3Uk9jZ9zLfJLSJF9y0iwK1d98Kp26FrAvtSsukjHkf
 /3kIw6Q5xTb/Yzc7/yv3Ccc1iUgJCOfnZ0rWZVZ+0ggxeXJ0kK2eg4UsUY7GtJTRNPzxT/PdftH
 otsBKzVctyCmwZQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX8qJJaVFgIxeT
 O3KzSfQu9jbr+5IGvQ4HAT1DDlXLv0GU/kEZ6cwYzB/6YE3ngkK5otrAxXfdgfHX/iOIoXlN0v0
 EokqfqOmOpyHSVh6ZAbiuAYwwq5eFZpBEbHjO5RX19JE7nvorOzZcsWHVf5Txnn85a5IFQ8DfQu
 7aEvBjP7YnwQLvcGcOtaNi2UR9ujYXbscCwr4SlcywaAwWC7khzFm18hGPAlzZnOopRHGKxR+mw
 Nc5770V3C827/ZZfRqZTT+bhksPfFc+kQlLnAgnfg302/iL4D7hcHL8Ka2JRCVli6EeuT4MYD/E
 Pseq5Odb5W42sXR/rvVOWWWjAUgHWaNjA53bgn3ee1l+BdVDQLluyBHb5NtKr587+ENBS00v7sd
 CvYdZAF6zonCLcgCV2q86/kSrTxoSykEAgSKJRYt0RydoXZnXshu4kCFM/TawYPtZw9/WBrat+i
 OHWX6K1DANMZo8C365Q==
X-Proofpoint-ORIG-GUID: sAZk62-1yjulfLrhZGD5U8Vn0huQGIfa
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a423741 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=gD7B2NV2fXQl33RD-VUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX/FrzzQ6ieDUd
 W9o5JSSjdXngjBZYCD6IRfmIYVgTmIkPVBrh6Aqf5cNWNOwaGUdp+3LBXq5+Od3ctGeUP5moVdy
 N1Z7nfiKFg40kTmvlTZ5/TIauJj6tj8=
X-Proofpoint-GUID: sAZk62-1yjulfLrhZGD5U8Vn0huQGIfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302532-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:broonie@opensource.wolfsonmicro.com,m:thierry.reding@avionic-design.de,m:sebastian.hesselbarth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:vkoul@kernel.org,m:rafael@kernel.org,m:dakr@kernel.org,m:robh@kernel.org,m:saravanak@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:andi.shyti@kernel.org,m:andriy.shevchenko@linux.intel.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:ulfh@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:rodrigo.vivi@intel.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:peter.chen@kernel.org,m:paul@crapouillou.net,m:b-liu@ti.com,m:p.zabel
 @pengutronix.de,m:luzmaximilian@gmail.com,m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:krzk@kernel.org,m:benh@kernel.crashing.org,m:brgl@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-sound@vger.kernel.org,m:driver-core@lists.linux.dev,m:devicetree@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-i2c@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pm@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-usb@vger.kernel.org,m:linux-mips@vger.kernel.org,m:platform-driver-x86@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:sebastianhesselbarth@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,opensource.wolfsonmicro.com,avionic-design.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org,linux.ibm.com,ellerman.id.au,linux.intel.com,8bytes.org,arm.com,broadcom.com,nxp.com,pengutronix.de,intel.com,ffwll.ch,crapouillou.net,ti.com,kernel.crashing.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[66];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27C876D8063

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 3071e46d03beaaae2321e858c564b512c22e820e..6e89415712ce1a7a7781af6bd0eaf0d6879da52b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1539,7 +1539,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = of_node_get(node);
+		platform_device_set_of_node(ngd->pdev, node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3


