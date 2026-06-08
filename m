Return-Path: <netdev+bounces-296341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mSToJFYmJmo+SwIAu9opvQ
	(envelope-from <netdev+bounces-296341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:17:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E9F65233F
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:17:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=AYBlL4Oa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296341-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296341-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14DC63006518
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE331197C;
	Mon,  8 Jun 2026 02:17:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8CA30FC03;
	Mon,  8 Jun 2026 02:17:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885072; cv=none; b=IAdXvidvBGqwcotn5iLr/sF9HGgVZ2TKy4WT3InsDQgL7t5oGAotr8luvvg1kHSD8PyGmuf+56doYkpvifGvC9coInXPcSb7nwtr4k7TJXFt1qbkxqIrdUgNZC2lSjT4vqLBLtjPsvUPNyt2RgB+4e4zKFD6qPR2/wtGbQSpbvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885072; c=relaxed/simple;
	bh=YTG+yTueahLsbWPl5062WwNa8E5epzEv7zUl0y/xm1M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN1WcioAg4o4hOv/V6/QV1bBG5G7vlgygc71H11It7GCTuILXO7oRpnftFPkJ1Nqu6gkY+S61kbqw2HEemt9LdtSzLYBFXjskzkR4xCCm48AoAaGoDsBUSIXg+rgWLJp0uJI2xjLtG1Yukv7y8zR+xvfB6ZfqbkEH/YIVrmrHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AYBlL4Oa; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580E8b2888603;
	Sun, 7 Jun 2026 19:17:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
	znJ3JTw+4B2h+qmcKG7kO2JNmgaW0mZA+1fkIsAj30=; b=AYBlL4OatWLDd69YW
	/grW+xGPVEFion4BwJ0iHcy//FhCq3ypvITSxgPkN9iftz2Oj14tlZB6vGH12ITP
	MxVaufE+ExKQOJMbPhyZC8yXX/5psyYoZwL4R60nCd7LlGTK2bU3h+amt1NEkr/O
	046j52nMkhVDp1MMhytvAFjt6C+0QHo7gsppsdWpD8H4jg7qmvMIQC5HPIvzOJ1C
	ysJhTpyl6e9Zt8EN7PDx8bTV0LnmJ1r5gqwil6K5WEIHE6eymK2JAMFiPf8MfSlX
	1EkHfDpbIeDcMe6KdyCY43zVL6DOXBsUnVA9OA6TbwK368fOSipHZtKZPRjNVNB5
	k/Xiw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4en7t8srx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:17:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:17:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:17:39 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 55C8E5B6932;
	Sun,  7 Jun 2026 19:17:36 -0700 (PDT)
Date: Mon, 8 Jun 2026 07:47:35 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 1/9] octeontx2-af: Enforce single RVU AF
 probe
Message-ID: <aiYmP_69I_pTCh7h@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605063245.3553861-2-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOCBTYWx0ZWRfX3PmibGczPMPY
 uOqXPRx5shHvLXudfbT9QphnJZYYJ0QbnTo4sp+N7jAPOG5iBb//I/wJNUf1HWefOVmtQmZXSMH
 oqmJwSHuwKXPsqEN6RLT11PPaCM028LgxW8/nPQ/uPuC08nAkUdAf0LCWAEPmdFU3Ldhw1yfZVv
 rf8qYf4x61NVxvm2GiXyFCcC20FskSMxUy3SfcuN7bkEZiqGVLjvClB+GpAXnHRsbWjPUD68NVJ
 DX+fWjRIHzjXiX6gdIESm01wpfJaWxVb3atrGqKBznm50hpTCsh1Yvfz79DXBFhV463rXOcF8YT
 WwpBm4u6NvNrW7bHxmBQV5aXLwpVpsRWuXJm6a7wypRUFmNcvqoz87JXnAuqJ4I9TV2rubYOvjO
 Wpcu3/rKP+y0nEp7RxfWvxRNbh6Yj9y5cJHHLAQlwJbrI+CQF07bCke6UDwkv1Gdas41t45EA02
 Jzb+rm8vGxgohM17+Uw==
X-Authority-Analysis: v=2.4 cv=evLvCIpX c=1 sm=1 tr=0 ts=6a262644 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=KEwauLbEcAKVX5NMn_0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: h_pZNQ2IMevnSfLNnrRc_D4UewHcHSB8
X-Proofpoint-GUID: h_pZNQ2IMevnSfLNnrRc_D4UewHcHSB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-296341-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06E9F65233F

On 2026-06-05 at 12:02:37, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> There is only one admin-function PCI device per system.
> Reject any additional AF probe with -EBUSY so the driver model matches
> hardware and automated reviewers can rely on a single bound instance.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://sashiko.dev/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says

>>  static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  {
>>  	struct device *dev = &pdev->dev;
>>  	struct rvu *rvu;
>>  	int    err;
>>
>> +	if (atomic_cmpxchg(&device_bound, 0, 1) != 0) {
>> +		dev_warn(dev, "Only one af device is supported.\n");
>> +		return -EBUSY;
>> +	}
>> +
>Since this atomic_cmpxchg() sets device_bound to 1, is there a path that sets
>it back to 0?
>Looking at rvu_probe(), if a failure occurs later in the probe process
>(such as -ENOMEM or resource allocation failures), it jumps to the cleanup
>labels but does not clear the device_bound flag. Does this permanently
>prevent driver rebinding or retry on probe deferral?
>Additionally, when the driver is successfully unbound via rvu_remove(),
>the flag doesn't appear to be cleared there either, which would cause
>subsequent manual binds to fail with -EBUSY.
>Is there a missing atomic_set(&device_bound, 0) in the error paths and in
>rvu_remove()?

You are right. The current implementation lacks
transactional rollback for device_bound in
rvu_probe() error paths, as well as the corresponding reset
in rvu_remove().

The inclusion of atomic_cmpxchg() here is a proactive sanity
check to enforce the hardware paradigm, as firmware instantiates
only a single Admin Function (AF) PCI device. Sashiko had raised many race
issues in previous version of the patch, assuming that multiple AF device
can be probed.

However, full
error-handling path hardening and proper resource cleanup for
the AF driver are currently incomplete.

To prevent scope creep in this fundamental enablement series, we
plan to address the comprehensive error-path rollback—including
proper atomic_set(&device_bound, 0) invocations on probe failure
and driver detachment—in a dedicated, subsequent hardening
patchset targeted for net-next.

