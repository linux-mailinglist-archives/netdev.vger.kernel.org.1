Return-Path: <netdev+bounces-296347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K87sAzsoJmp8SwIAu9opvQ
	(envelope-from <netdev+bounces-296347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:26:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEE665239D
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:26:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=Foh99MXI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296347-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296347-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F6973008211
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EEB30DEA5;
	Mon,  8 Jun 2026 02:26:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A73101B0;
	Mon,  8 Jun 2026 02:25:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885560; cv=none; b=JQvQxNMczJIDiSKiIBZx0NbeV5Ht9smONbcbGoCfyWDN1sblESuruCCK+lrm3BNtTdljjwXVnaZguI8d+vOoWE/i8uXcvemW2X78sJ8ekunYDFIBmMV0CrLF58ePL/dOPJ+WhsN7Eb29KDlCy/b/n9ZMlum3MyDXK6X+czndoIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885560; c=relaxed/simple;
	bh=CuTWCIdiAko6A183eJ74MFkBY9CGpWXqmZfpXZYLliA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRliz3LoDTAQxbtNBPutzD31VkoA3cXaC/9WIlBIfNvPfvlQpyGZrjfwF3jAip0FUpu+8gs8bfRduIFsByW2PrRNEjPTgoBSGj0VijdWlGfsPZp06lPQDsQAsxOez6i0lqEg4wwkWz2IZNon6GqFzLPexIwTU/PBmv1Wi6+E398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Foh99MXI; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EA9g888654;
	Sun, 7 Jun 2026 19:25:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
	O3QjaHlZaokipw4hbds1pfie5IKRfTmHoiHou2W33s=; b=Foh99MXIS7uRnvw/c
	8yf3MK66SjxUtvGygTqzxr5kqpMPwK7ZP/esUnPqSTMuUxy2HGfD1moS9yrbvQP5
	cg1Ornj/l6AcviT6FBGJuSV4mC9stUByIUom22U8Y2xKiWXVHTtH2E6ylegwaXtd
	nIebPaqlDWuHwgsAQkyWQHC11+JmE4OlFmd19TalhV1pDT5CPjsUq/qlVSbQrQwI
	/ByuDIPqe4EcOEJBx1rb7C86pvD3LyNjYn1ZSMmXbAoxuBboyXeZMAM7RBybL2wV
	FsgfT/4udCMYpBlGCElcNpS3pLatjVjlxxS1BXg0kqJp9RG9u40BWxXvh61rpoXT
	KBinA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4en7t8ssg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:25:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:25:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:25:48 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 581CB5B6932;
	Sun,  7 Jun 2026 19:25:45 -0700 (PDT)
Date: Mon, 8 Jun 2026 07:55:44 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 1/9] octeontx2-af: Enforce single RVU AF
 probe
Message-ID: <aiYoKDG5DNQFQwZO@rkannoth-OptiPlex-7090>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfX9txzzjwjOzd/
 kWcEELaaxGyShJDqmAa8Tf3gCeJP7evrVFYQmS065zVf05sTx8bhQPNBWf4XOLk8p6hbwXJILVW
 q/Ioa1+PvelyIje7GMhwV0DUGvzz79Gbr9OfIBMAbnG8TT925EJpMlIlpArY11HSAPLJ/txTwFf
 hQ2DjkbQmi/I1+AcWHTMs/R+T0ySIfQUz0vasT0WV+BInvxr48Z/bi25zr4r/oMbKgCzit6vZuq
 dlZtWxsJNRoHHznFkFGlDGvN3kqpMng6YlrggvSrOFovravL94G6Qef6ojk693zJSQYkZ5eh//C
 chpf89SE8E4+ex0dWgoFTx+PWjMHtDe3pgC4/NGOD5j94XkoIhp1BPa/9IgewMWoAqJT4QDQev+
 D1XLsmxHrXbzxj8tW+XGub53QfeSeIRq+T4u2rS57p+jZ8XIZf1cP530ttQKQUSu6/FG9nV3ArX
 4WgD0QCFXsUEh0DSrfA==
X-Authority-Analysis: v=2.4 cv=evLvCIpX c=1 sm=1 tr=0 ts=6a26282d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=JIJO8x5AFiNFHzJHdLsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Sassp9UuvGdJdsNkfmT14hFHt5iHamEM
X-Proofpoint-GUID: Sassp9UuvGdJdsNkfmT14hFHt5iHamEM
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-296347-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rkannoth-OptiPlex-7090:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 5FEE665239D

On 2026-06-05 at 12:02:37, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> There is only one admin-function PCI device per system.
> Reject any additional AF probe with -EBUSY so the driver model matches
> hardware and automated reviewers can rely on a single bound instance.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
>> @@ -3542,12 +3542,19 @@ static void rvu_update_module_params(struct rvu *rvu)
>>  		kpu_profile ? kpu_profile : default_pfl_name, KPU_NAME_LEN);
>>  }
>>
>> +static atomic_t device_bound = ATOMIC_INIT(0);
>> +
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
>Once this atomic_cmpxchg() succeeds, where is device_bound ever reset
>back to 0?
>The flag is set on entry but the function does not clear it on any of
>the err_* failure labels, and rvu_remove() also does not touch it.
>Two scenarios appear to leave the driver permanently unusable until
>module unload:
>1) Any transient probe failure after the cmpxchg (devm_kzalloc returning
>   NULL, pci_enable_device(), dma_set_mask_and_coherent(), pcim_iomap(),
>   rvu_setup_hw_resources(), rvu_mbox_init(), rvu_register_interrupts(),
>   rvu_register_dl(), rvu_enable_sriov(), etc.) returns via an err_*
>   label with device_bound still set to 1. Wouldn't every subsequent
>   probe attempt — including deferred-probe retries on the same device
>   — then fail with -EBUSY even though nothing is bound?
>2) A successful probe followed by sysfs unbind, PCI hot-remove, or a
>   driver rebind goes through rvu_remove(), which tears down the rvu
>   instance but does not clear device_bound. Doesn't this break
>   rebinding the same device (echo <bdf> > /sys/bus/pci/drivers/rvu_af/bind)
>   and PCI error-recovery flows for the lifetime of the module load?
>The commit message describes the intent as rejecting "any additional AF
>probe" so there is "a single bound instance", which reads as one bound
>at a time. Should device_bound be cleared (atomic_set(&device_bound, 0))
>on every err_* path in rvu_probe() and at the end of rvu_remove() to
>match that intent?

You are completely correct. The current implementation lacks
transactional rollback for device_bound in the downstream
rvu_probe() error paths, as well as the corresponding reset
in rvu_remove().

The inclusion of atomic_cmpxchg() here is a proactive sanity
check to enforce the hardware paradigm, as firmware instantiates
only a single Admin Function (AF) PCI device. However, full
error-handling path hardening and proper resource cleanup for
the AF driver are currently incomplete across the broader
initialization sequence.

To prevent scope creep in this series, we
plan to address the comprehensive error-path rollback—including
proper atomic_set(&device_bound, 0) invocations on probe failure
and driver detachment—in a dedicated, subsequent hardening
patchset targeted for net-next.

