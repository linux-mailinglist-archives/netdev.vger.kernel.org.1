Return-Path: <netdev+bounces-294596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t/LzF1PRH2pfqQAAu9opvQ
	(envelope-from <netdev+bounces-294596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:01:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA8634EE5
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:01:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=JoTxm8+n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294596-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294596-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B407D30037C6
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549AD39526B;
	Wed,  3 Jun 2026 06:56:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1C22424C;
	Wed,  3 Jun 2026 06:56:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469777; cv=none; b=RPXcDVln9n5ikMdhoQY9nELt+vXQd3n0u2WQ23BJvYRQVtxZMr4dnF3xYEUhztRBE2zpYSCiZBtxV7WPPipep3ZlUxovmp1HreBT9H7JXFwYMErvXzkvPPLl9f2fjz99TKsmhOafeAKYtqgtwOFmTdAx+ym1KWaFtOUo5DH6EXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469777; c=relaxed/simple;
	bh=V1q2YtkUXrnRlGF8E1LjGClxHtbyKbua39fPCtBz6wA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVk6uLKchduTaPspGqBL/nFpnEaLzeCDfIs6h8bVzQJRODAjUyxzxEXgpNFOOST9l2TK4HlEqIxJ/fXp8l6SzVzzD8WcLwftAk+23VYO2jXUbd5o6gAVPJfgKCEDFm/bokMRtCNa1ah5jiBt1X9pQCbvogPDHXZ8xOwFwvp1Oa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JoTxm8+n; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6532dXcY1231410;
	Tue, 2 Jun 2026 23:54:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=oGZpzjg0b5+CVtZxYRVVMis1F
	3YYHy4AhJQpQ8Qnn/A=; b=JoTxm8+nSbyEE1c+kKvqG3MePYy8ALe4SKQB/LCLQ
	V/0nJHC3RerTje7B0CBpp2jTD6GTUUpVe5RKin5krA3Z74XCHxFphfV+D2wdkkFm
	+t/4hTot+DHGSlq80GOb9oOOshe3+qJCc2k9XuPbFaZOmzzzptYfoa00qxwvyVrG
	vQRjEyb6CgMTPqxJPgAc54FpNobpXXY9En5vaw9nLEtdmaZ2dVQ/VCqEVPDwndqo
	RQtUAaazoL1Iii3apf9e3F1nB3S/Hkg4mBwtU20URh5uZ9xZl9wGjQe9kqyhNKSM
	dtSGcbYrXxfAtNgflWuRToiUDmUkDMESHzom6TyQAjHGg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3bc7kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 23:54:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 2 Jun 2026 23:54:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 2 Jun 2026 23:54:35 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id DA6443F708D;
	Tue,  2 Jun 2026 23:54:31 -0700 (PDT)
Date: Wed, 3 Jun 2026 12:24:30 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 7/8] octeontx2: cn20k: Respect NPC MCAM
 X2/X4 profile in flows and DFT alloc
Message-ID: <ah_Ppj-UMxEeowVg@rkannoth-OptiPlex-7090>
References: <20260602060359.1894952-1-rkannoth@marvell.com>
 <20260602060359.1894952-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260602060359.1894952-8-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NCBTYWx0ZWRfX2vLLtwuw5yRs
 0sF3B6ER9wRJl1Uf5Pn+YgzzoyXjjexaMOZBLZuABU+2RLY67lYZXl/OcsvMu0g4Fb6xOXJAUXc
 gQvHcb0CfKyF7FFk8wmrvAYn2dkeQuPN4sSK1IUiaCVgvz+RYcnLr/3NFnCfMFU6Jfeg+Yg6TF1
 OdWV/Bg5+hlOzELadm26cxMj9Q+QR19Gk4fU6Kbp9joDL/0CmCs1FzFIFrt13FSQ5zTAWyW4zMv
 XlvPXjWT928jdTnc6RHIaGRWrobBsoaZ5ov118XohMAgL8z1FnQFvR3lwYzjqpW6hqhta5fsU4M
 dOyLnsKTCP8Wc1YyB8oTjspBd76fkjhPOENW3T7FiYbnaOlb0oLhbxlrf+h4P7yhcBjbdEXZSme
 phuxudClljMXlH/S8IgGUAv/2agsvXpIOZLytuPvwzk3qcAuI9LUxeKJdZtO+FyxUuHmw4t6EV8
 38eFp8IEuiRzor5o4AQ==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1fcfac cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=53kNHl5VV_6t2H7F-a0A:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: J2LDGb1xbpL1rzC-X3kFKhkoPhdgtWDs
X-Proofpoint-GUID: J2LDGb1xbpL1rzC-X3kFKhkoPhdgtWDs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-294596-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: AFBA8634EE5

On 2026-06-02 at 11:33:58, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Default CN20K NPC rule allocation now keys off the active MCAM keyword
> width: use X4 with a bank-masked reference index when the silicon uses
> X4 keys, and X2 with the raw index otherwise (replacing the previous
> always-X2 / eidx + 1 behaviour).
>
> In the AF flow-install path, flows that need more than 256 key bits
> query the NPC profile; if the platform is fixed to X2 entries, fail
> with -EOPNOTSUPP instead of requesting X4. Otherwise select X4 for the
> MCAM alloc.
>
> On the PF, cache and pass the profile kw_type from npc_get_pfl_info
> through otx2_mcam_pfl_info_get(), and use it when allocating MCAM
> entries for RSS/defaults and when installing ethtool flows on CN20K,
> including masking the reference index for X4 slot layout.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://sashiko.dev/#/patchset/20260602060359.1894952-1-rkannoth%40marvell.com says

>
>> -				  u16 *x4_slots)
>> +static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, u16 *x4_slots, u8 *kw_type)
>>  {
>>  	struct npc_get_pfl_info_rsp *rsp;
>>  	struct msg_req *req;
>>  	static struct {
>>  		bool is_set;
>> -		bool is_x2;
>> +		u8 kw_type;
>>  		u16 x4_slots;
>>  	} pfl_info;
>This is a pre-existing issue, but does using a static structure to cache
>the hardware profile break multi-device support?
These are value of AF device (singleton device per system). AF process mbox messages serially, so if any PF updates this
first, that value will be same and can be used for all other PFs.

>Additionally, the cache is protected by a per-instance lock, which provides
>no mutual exclusion when multiple distinct devices access it concurrently.
>Could this lead to data races?
No races as value is same and is updated by first PF who request it.

>> @@ -289,6 +291,8 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
>>  	struct npc_mcam_alloc_entry_rsp *rsp;
>>  	int vf_vlan_max_flows, count;
>>  	int rc, ref, prio, ent;
>> +	u8 kw_type = 0;
>> +	u16 x4_slots;
>>  	u16 dft_idx;
>>
>>  	ref = 0;
>> @@ -315,6 +319,16 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
>>  	if (!flow_cfg->def_ent)
>>  		return -ENOMEM;
>This is a pre-existing issue, but does this function leak devres-managed
>memory when triggered by devlink parameters?
Preexting issue, so will be addressed to net tree once this series is merged.

>>  	u8 kw_type = 0;
>>  	u8 *src, *dst;
>>  	u16 x4_slots;
>> -	bool is_x2;
>This is a pre-existing issue, but does the VF validation error path in
>otx2_add_flow_msg() leak a mailbox message buffer?
>A mailbox message is dynamically allocated early in the function:
>	req = otx2_mbox_alloc_msg_npc_install_flow(&pfvf->mbox);
>During the flow specification validation, if the VF is invalid, the
>function unlocks the mailbox and returns an error:
>	vf = ethtool_get_flow_spec_ring_vf(ring_cookie);
>	if (vf > pci_num_vf(pfvf->pdev)) {
>		mutex_unlock(&pfvf->mbox.lock);
>		return -EINVAL;
>	}
>However, it fails to call otx2_mbox_reset(), which means the message slot
>remains active or consumed in the mailbox queue.
>Could a user repeatedly submitting invalid flows exhaust the mailbox queue
>and break communications with the Admin Function?
same as above.

