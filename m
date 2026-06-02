Return-Path: <netdev+bounces-294003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FkJvCWdYHmoAiwkAu9opvQ
	(envelope-from <netdev+bounces-294003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:13:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DFB627FFC
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED6BA300B1DC
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 04:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179D338E5DC;
	Tue,  2 Jun 2026 04:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hZhY5NKs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF836C598;
	Tue,  2 Jun 2026 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780373605; cv=none; b=cOfThbu0gjKItBYVCtB314xWaRxaSRnEEo3ZczhRSZG75KuDqEUBscQAZDH9r+09KFDRiv+HOcqCfzrewSYtBCpGmhFOOeJ9V9fTjyHJp6P7Uu8qv2IAH5NaOBcyFDODqoxS8UTum+D6yAJq2ETAeAuCOnthKJ/NueeqdhWB5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780373605; c=relaxed/simple;
	bh=VyBxYaUXUu3Gm0Pk9td80arq66oQ0Omao9H3p0G7wfU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9eogDBs6U9X6Qu0FtCdgxwDfNxQ0QGs4Uk1uCyxwxPRB6n1VZV2Vl6iecH3Sf2No060n/tpeMjrk0E/VusZ3RR/FAcDsvexzAKP4VoVC2ahPoJMzjG51l+k2pi07GifIxEEWdYbA6Dmbp8PJ+K7mwoyl9jgZyb6fxYJQ17lblY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hZhY5NKs; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6520IfBv2859284;
	Mon, 1 Jun 2026 21:13:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=WA6PZgFBUb+0fck+ztc2wU9u5
	fohPzyUuEYdJDxOmJY=; b=hZhY5NKsPQMakbM+MH34sbr/5+33f+YZ0qsqwduhP
	Cf5aNmrMQ2oubl7BZWJJ52OOvW3E05yZBnaJ0LP617MiUB9RA8k/prMzJr2UY1Tc
	MbrhecILRz4CfRzxxe0DPInBvATTAGvkMDZBZpJA5j9dvzQzZz3dQ5g181eDnz1t
	oyXQJ+xEP9LB0vpUoaT1+xFuOTSt1YHfyTrLB9CAjS2cClQmA3qxRNMmrKKL9RuP
	zQjStuZfwrWwmxRjRKPh9y6hfp3223NYw1o/d35r0+JVsXzdDAtpwQr+cak8lI7s
	d7ClPoZm/SsngluCZc3sbTGAEBTSax8G9aiqYGzT35jGw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ehbxra76g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 21:13:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 21:13:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 21:13:12 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 4CEE53F7062;
	Mon,  1 Jun 2026 21:13:09 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:43:08 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v17 net-next 6/8] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <ah5YVLE6cWu-tyMd@rkannoth-OptiPlex-7090>
References: <20260601025844.865865-1-rkannoth@marvell.com>
 <20260601025844.865865-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601025844.865865-7-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=RMaD2Yi+ c=1 sm=1 tr=0 ts=6a1e5859 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=aGXFfAgDFSogSVCN33EA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDAzNSBTYWx0ZWRfX36++i0FeQ2Mv
 R8WzbuN5wLWT6i5C0+tr0068qIQ6ahaCVImHKNGwqpxZLy+ijNp+unCxuDq4Twhj7IxYhmGDD4D
 BQQdq5D1A8ccd+TGwn9netsf2C8Frw5u9bp/ahnKlXbcS1HiMwdnc9Xs36M8w7p/kLCSLVO1Nnm
 8767w8PsXkoTBDjphhsk+leeYRuW2VWhg2+XG7LMmEyzve9LkX3pGP5WMBPtIT35yT0/4tT+0B9
 6ZRCCHu1i7VHwhYz9LISfm05yepw/ImUCdr26df+858otHWf0nZ0ClNZHrSbHqTXH3CDjYDYCw6
 ugAVhVFzG1OUSlIoXdsoAf20KnihjS1tbYFtM8ugcCysRXSxTdR5YEiFv9hML6nHhIPrqArC1ts
 rJZT5ijiNNfSdyBkDRMZb3AA3SQboLdTCG9noMO+HTSy94WXzb5DW6AmpSEbMUYz1r9XI7nLKCp
 Icj90W4DeN4E/sLbjQQ==
X-Proofpoint-ORIG-GUID: Ix5pn9l773MAT0br6aIfEddv3dbp4VTV
X-Proofpoint-GUID: Ix5pn9l773MAT0br6aIfEddv3dbp4VTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294003-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B0DFB627FFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-06-01 at 08:28:41, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Flashing updated firmware on deployed devices is cumbersome. Provide a
> mechanism to load a custom KPU (Key Parse Unit) profile directly from
> the filesystem at module load time.

>> +	struct npc_kpu_profile_adapter *adapter = &rvu->kpu;
>> +	struct npc_kpu_profile *kpu;
>> +
>> +	kpu = &adapter->kpu[kpu_num];
>> +
>> +	kpu->cam2 = devm_kcalloc(rvu->dev, num_entries,
>> +				 sizeof(*kpu->cam2), GFP_KERNEL);
>Is it safe to store devm-allocated pointers into this kpu structure?
>Looking at npc_prepare_default_kpu(), the profile->kpu pointer is
>assigned to npc_kpu_profiles, which is a global static array.
>When memory bounded to a specific device via devm_kcalloc is stored
>in this global array, won't multiple devices race to overwrite these
>pointers? Additionally, if the device unbinds, devres will free the memory,
>leaving dangling pointers in the global array that could cause a
>use-after-free for other devices on the system.

There is only one AF device per system.

>> +	struct npc_kpu_profile_cam *cam;
>> +	struct npc_kpu_fwdata *fw_kpu;
>> +	int entries, entry, kpu;
>>
>> -	if (is_cn20k(rvu->pdev))
>> -		return npc_cn20k_apply_custom_kpu(rvu, profile);
>> +	fw = rvu->kpu_fwdata;
>>
>> +	for (kpu = 0; kpu < fw->kpus; kpu++) {
>> +		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
>This is a pre-existing issue, but does this bounds check guarantee enough
>space to safely read fw_kpu->entries below?
>The check ensures the offset reaches the start of the fw_kpu structure,
>but it doesn't appear to verify there are at least sizeof(*fw_kpu) bytes
>remaining in the buffer. If the firmware image is truncated exactly
>at this boundary, could dereferencing fw_kpu->entries read out of
>bounds?
Pre existing issue; a seperate bug fix patch will be posted to net tree once this series
is merged.

>> +		if (fw_kpu->entries > KPU_MAX_CST_ENT)
>> +			dev_warn(rvu->dev,
>> +				 "Too many custom entries on KPU%d: %d > %d\n",
>> +				 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
>> +		entries = min_t(int, fw_kpu->entries, KPU_MAX_CST_ENT);
>> +		cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
>> +		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
>> +		action = (struct npc_kpu_profile_action *)(fw->data + offset);
>> +		offset += fw_kpu->entries * sizeof(*action);
>This is a pre-existing issue, but could the offset calculation overflow
>on 32-bit architectures?
Pre existing issue; a seperate bug fix patch will be posted to net tree once this series
is merged.

>The expression sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam)
>evaluates as a 32-bit unsigned size_t. If a maliciously large value is
>provided for fw_kpu->entries, the multiplication could wrap around,
>producing a small offset that passes the bounds check below, leading to
>out-of-bounds memory reads when copying the entries.<F11>
>> +		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
>> +			dev_warn(rvu->dev,
>> +				 "Profile size mismatch on KPU%i parsing.\n",
>> +				 kpu + 1);
>> +			return -EINVAL;
>> +		}
>> +		for (entry = 0; entry < entries; entry++) {
>> +			profile->kpu[kpu].cam[entry] = cam[entry];
>> +			profile->kpu[kpu].action[entry] = action[entry];
>This is a pre-existing issue, but does this permanently corrupt the default
>built-in profile?

Pre existing issue; a seperate bug fix patch will be posted to net tree once this series
is merged.

>> +	/* Binary blob contains ikpu actions entries at start of data[0] */
>> +	profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
>> +				      sizeof(ikpu_action_entries),
>> +				      GFP_KERNEL);
>> +	if (!profile->ikpu2)
>> +		return -ENOMEM;
>> +
>> +	action = (struct npc_kpu_profile_action *)(fw->data + offset);
>> +
>> +	if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
>> +		return -EINVAL;
>> +
>> +	/* The firmware layout does dependent on the internal size of
>> +	 * ikpu_action_entries.
>> +	 */
>> +	memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
>> +	offset += sizeof(ikpu_action_entries);
>Will tying the firmware binary layout directly to the size of an
>internal kernel compilation constant cause backward compatibility issues?
We can't change ikpu structure to add another field as it will break backward compatability.
So we will keep same number of items in ikpu.

>	mkex_extr = rvu->kpu.mcam_kex_prfl.mkex_extr;
>> +	mkex = rvu->kpu.mcam_kex_prfl.mkex;
>> +
>>  	if (is_cn20k(rvu->pdev)) {
>> -		keyx_cfg = mkex_extr->keyx_cfg;
>> +		keyx_cfg = (u64 *)mkex_extr->keyx_cfg;
>>  	} else {
>> -		keyx_cfg = mkex->keyx_cfg;
>> +		keyx_cfg = (u64 *)mkex->keyx_cfg;
>This is a pre-existing issue, but does this cast away the const
>qualifier and modify read-only data? Both mkex_extr and mkex are typed
>as const, and frequently point to the global static npc_mkex_default profile.

Pre existing issue; a seperate bug fix patch will be posted to net tree once this series
is merged.

