Return-Path: <netdev+bounces-289989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M+MCI/QDWr53QUAu9opvQ
	(envelope-from <netdev+bounces-289989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:17:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0435590A5B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05D0F300EE82
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40543EF0D7;
	Wed, 20 May 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="L1rsEDsM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D13EF642;
	Wed, 20 May 2026 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290223; cv=none; b=i2a+phbZ2It5ctMUj/bVQXKR++Ajh8qAQvQ4odM07RjLNiCulkYr2HGDndLwW/CMnsZViw4KK8VSMkJ3j1FMDqy/gqvugH2WOGmiN5tTaTCUsEh0M0YUUgpnZhlpJmaHa3wuTeB9T+bSfeapkukT8dmbgRbnCokQCabJrVJ/aFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290223; c=relaxed/simple;
	bh=2IhOhT/g8r66zAMyV1dJLobZkqvOZ74vllZdclHnYEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHLYd6Tydzhwc5Qm25WboTAgGysVWZ151HcIm6kkn0F6a2Dfg9G6uD7iTQ2wWPJfXm7rkJ9ZBrHamreBBel2wy+44dO1rifMmCGkxDIcFQnobARwtV2GSKTywPHe+V/8xMv2kwn4VZTLjRkrsvGHws8vtbwyonCShDUtTK1HEQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=L1rsEDsM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDoukh417075;
	Wed, 20 May 2026 11:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=g5b1M
	kL3xOTz+4EinhhDYo3oQY1LO8pte1y8xB8Xja4=; b=L1rsEDsMIRc0Wthr2nLYx
	pyvfPeG9uWAyABalygM8m9woI0Ra8MEdpDUE0dxJ5iwgeL5kSFDAnFL/+i6u2ROy
	5Dl32dW04+7FgstWxsluvlQjZvb5nNyWNNBlXJJ+tX1FYMm6W6UCEKzrYMo1tSUu
	0wm1eGlCre7L0M2/O5116vnau2NQ7WRkOTpDe7NigATEmxqh4xnRhDwliOYnaChX
	VWXYQ2etiGXJ0ECtXxleg7Jr++PZJaPPlcJjAqKa3Sp/TET33LynOt7hVA3RP1NZ
	3fASv22cj1gAYqCKgcTGDklSt1iKm8S1bvPMzin+dOW7tavaR6HAM+M4mzjvSh7n
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9e6wraq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 11:16:49 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64KFGmnw037607
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 May 2026 11:16:48 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 20 May 2026 11:16:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 20 May 2026 11:16:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 20 May 2026 11:16:48 -0400
Received: from xvr.ad.analog.com ([10.48.65.167])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64KFGVex021857;
	Wed, 20 May 2026 11:16:34 -0400
From: Ciprian Regus <ciprian.regus@analog.com>
To: <selvamani.rajagopal@onsemi.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <parthiban.veerasooran@microchip.com>, <ciprian.regus@analog.com>
Subject: Re: [PATCH net 1/2] net: ethernet: oa_tc6: Interrupt is active low, level triggered.
Date: Wed, 20 May 2026 18:16:21 +0300
Message-ID: <20260520151621.405125-1-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CY8PR02MB9249D2392242AF27988B9C0583042@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249D2392242AF27988B9C0583042@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: gYNbkJvFd1D6ArbRs6EZuWyqJN6OrKCd
X-Proofpoint-ORIG-GUID: gYNbkJvFd1D6ArbRs6EZuWyqJN6OrKCd
X-Authority-Analysis: v=2.4 cv=K8gS2SWI c=1 sm=1 tr=0 ts=6a0dd061 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=ZsT_3VxfWKg2-RS7:21 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=GrngUzCRepzmGNCGzS8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0OCBTYWx0ZWRfX9et7EkN5k8VV
 1qGwYQyfhdHOsPFluyLBoHspuQy9OhEg8EXqOpx08QI1fNESKseMO9+XrGzWmfi4g6rAh4jP8mk
 9HLs2o9cxDDvozYtE9fOe+YmAV+/sm4UM0xp7WRmdiJ93xXkClOMAfFadUXQz0m01pxDohOeXWu
 j6nH/UcnTL+5hooufwIyOOaz2R6FJaUC2tZzj1Nsl8rtH9xiICNlUuQq6Q42pmd/VS7B+9vDK5q
 hFt/nTjdz6RA0Hi1/K+3+I8C/Rh2b1CQkZg1snbRP7FCBpzJqWyfYmOstedEtD2kCRnp6lY/Ttg
 +icJlMwPW1AJnVS3MUU1M7El53hcIlEgkO8Qpu7A1luTVwJuupmugDcRYTfZpfV1LV0GKiuP4Tj
 DWC5d9mVlq4mVqwySLcgzI+43rh0X+3dw/aujFNiiXTZYr3rMVCYRqRrrdBQz5KbCaSAxzUnkLn
 XRfponGUFfvs0AcStOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200148
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[ciprian.regus@analog.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289989-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,analog.com:mid,analog.com:dkim]
X-Rspamd-Queue-Id: B0435590A5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>        ret = devm_request_irq(&tc6->spi->dev, tc6->spi->irq, oa_tc6_macphy_isr,
>-                              IRQF_TRIGGER_FALLING, dev_name(&tc6->spi->dev),
>+                              IRQF_TRIGGER_LOW, dev_name(&tc6->spi->dev),
>                               tc6);

oa_tc6_macphy_isr() doesn't clear the interrupt condition or disable the
interrupt. So it will be triggered several times until the oa tc6
thread gets to run. Should we use something like this instead?

devm_request_threaded_irq(..., IRQF_TRIGGER_LOW | IRQF_ONESHOT, ...)

(together with some rework to call oa_tc6_try_spi_transfer() from the
threaded irq part).


