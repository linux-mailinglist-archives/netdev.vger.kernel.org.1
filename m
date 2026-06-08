Return-Path: <netdev+bounces-296344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pwfyEpknJmpnSwIAu9opvQ
	(envelope-from <netdev+bounces-296344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:23:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D2B652369
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:23:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=JrsRdLgF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296344-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296344-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C0F43005E91
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996530FF21;
	Mon,  8 Jun 2026 02:23:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447D30DEA5;
	Mon,  8 Jun 2026 02:23:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885397; cv=none; b=j6H66TNi+MEAUphuJAKAe3OMT1Cf7bipVSQNd7Ink8nORrN2MgyQuJxt6+j3hSz6+2kODp0C8aBIFb4qPiImpWoN6NDZpsHnQ5MEMjb0LXjZlRTQC5SJavn6EKRXihtQTPx9grJAz8IT9g1w4WnndPQvYUqyHRxEFMlXf5g2mdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885397; c=relaxed/simple;
	bh=9KdZ0poso5+AGqavE25CNr5Y1ALLNhXF/5fF9XiT4s4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5iUUjLzZ11N9ET45eXrPn4nLKV270Z+pNHhwv9ZOFuvAao7+alEilhzLPNFjNN1fYzrdp97HqymyOyNb9SM2tSkQ80umMUm72efTeUin5/TnDj3zXjayA0HPc+0p+v8+oISp8N0F46VAxprWgkCQPIqVPMtqqO24/TI70fxKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JrsRdLgF; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EdI8839098;
	Sun, 7 Jun 2026 19:23:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=yB2JgRTiUf2avha42gFjzsEHJ
	RhEXpdyx8qr7mGpqvM=; b=JrsRdLgFfwENK/h+wl73S4MQ63FZngrlOHVLoJEoz
	9nyDAPU8rAK62Ts4sS8JdFuBPqyy7U6A/SKQ5DtvXLaAow8N6gMuZP3WFwqrJ2Y+
	WvSMQ9kFVF2uVF1rXUCFnvRQALnpiSd617LdjPnu2VgdZB2XMYgXXtmgVeK8sL/r
	R96jGZE7rJ0x2OQlQj74bttY1Vvn/22pvIC4SDv2e3UkinSnfGNwBJtLGpZJo4GL
	iA8iB7alnBdpzUdldYAo13w8r4MDRO/5BiF9nuKIeaDO4Wih+dq8PCXsbfjlJzW+
	gTcRA/dCeRqWxw5RH7lB1BkyUZbO7OK4LIYWrWJ2cDWvQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4en4a5j9ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:23:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:23:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:23:06 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 4B0035B6933;
	Sun,  7 Jun 2026 19:23:03 -0700 (PDT)
Date: Mon, 8 Jun 2026 07:53:02 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 7/9] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <aiYnhgUxnOl5Pd1a@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605063245.3553861-8-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=HpBG3UTS c=1 sm=1 tr=0 ts=6a26278b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=x-62jzRuyg-rEeT1vRgA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: VJbPg5U9yIYCN-MsnqWcNopDzIYdQkvb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfX1BCkDJHUy8QI
 Y5BSJU002us+FAcSVTit9ofUuDTi87iBz7ivtdFYTTkn3bUFUlKuL1LgeGbHUpFSsoh2p3LiKV5
 5Ux0lOVi+ZAa89oRMJtMJCAwXqWm6h1T9rNRymuZeHsv8aKziYrkZjSMkKp3exLYlsMTpO5jLlE
 /AJYv03VVSEFwHnRSxCdxVaTYRWnGSTU/plnvrf3uMMoQKNv/hoVJiiwPSpchuPIamUtUW/AH/A
 wUZEsbhWciUltZlzoma28WXfksnabiRtddZ1SfntBz/oUUxS3fz76SOCCG9DjZz/Lq38y+dPo1F
 hBgrOTV0FtTc4Mq1oMIQfbNltv0AcGvDriNzEclprRATMKKy0dOuhGxbx/Gi4NO27zNs2Naxnsy
 RDNh131c151kR/PJmu2PfGdCHq7vETDKra+DCENigEJeh0nRrx3ta3YxWO1LGCF1pfXNzLiWRDc
 +NAvcINueOzMNMK7Xfw==
X-Proofpoint-GUID: VJbPg5U9yIYCN-MsnqWcNopDzIYdQkvb
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
	TAGGED_FROM(0.00)[bounces-296344-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,rkannoth-OptiPlex-7090:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
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
X-Rspamd-Queue-Id: B5D2B652369

On 2026-06-05 at 12:02:43, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Flashing updated firmware on deployed devices is cumbersome. Provide a
> mechanism to load a custom KPU (Key Parse Unit) profile directly from
> the filesystem at module load time.
>
> When the rvu_af module is loaded with the kpu_profile parameter, the
> specified profile is read from /lib/firmware/kpu and programmed into
> the KPU registers. Add npc_kpu_profile_cam2 for the extended cam format
> used by filesystem-loaded profiles and support ptype/ptype_mask in
> npc_config_kpucam when profile->from_fs is set.
>
> Usage:
>   1. Copy the KPU profile file to /lib/firmware/kpu.
>   2. Build OCTEONTX2_AF as a module.
>   3. Load: insmod rvu_af.ko kpu_profile=<profile_name>
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://sashiko.dev/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says

>>
>>  	/* Verify if profile fits the HW */
>> +	if (fw->kpus > rvu->hw->npc_kpus) {
>> +		dev_warn(rvu->dev, "Not enough KPUs: %d > %d\n", fw->kpus,
>> +			 rvu->hw->npc_kpus);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Check if there is enough memory */
>>  	if (fw->kpus > profile->kpus) {
>This is a pre-existing issue, but does this code read out-of-bounds when
>parsing firmware KPU profiles?
Pre-existing issue, will address as a seperate patch after this series
is merged.

>>
>> +	for (kpu = 0; kpu < fw->kpus; kpu++) {
>> +		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
>> +			dev_warn(rvu->dev,
>> +				 "Profile size mismatch on KPU%i parsing\n",
>> +				 kpu + 1);
>> +			return -EINVAL;
>> +		}
>> +
>> +		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
>> +		if (fw_kpu->entries < 0) {
>This is also a pre-existing issue, but does this check properly prevent an
>out-of-bounds read?
Pre-existing issue, will address as a seperate patch after this series
is merged.

>> +	/* Binary blob contains ikpu actions entries at start of data[0] */
>> +	profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
>> +				      sizeof(ikpu_action_entries),
>> +				      GFP_KERNEL);
>Will this leak devm-managed memory if filesystem firmware loading fails?
Yes. Buti it not an issue as there is only one AF device per system. 1st patch in the series
do enforce the same.

> +	/* The firmware layout does dependent on the internal size of
>> +	 * ikpu_action_entries.
>> +	 */
>> +	memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
>> +	offset += sizeof(ikpu_action_entries);
>Does this tightly couple the firmware ABI to the kernel's compile-time
>array size?
Yes. There is no field in the structure to indicate the length. We cant add
now as it will break backward compatability, so we maintain same entries all
time.

>The filesystem-based KPU profile parser copies data and advances its buffer
>offset using the compile-time sizeof(ikpu_action_entries). If future kernels
>add new packet kinds (PKINDs), the array size will increase.
>Because the firmware binary does not encode the length of this section, older
>firmware loaded onto a newer kernel will be parsed incorrectly, shifting the
>offset and causing the driver to read garbage for the remaining KPU headers,
>which breaks firmware ABI compatibility.

