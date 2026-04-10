Return-Path: <netdev+bounces-277315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Nw4J2/I2GmkiAgAu9opvQ
	(envelope-from <netdev+bounces-277315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:52:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A51363D53F0
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9A933003BED
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFCC375AAD;
	Fri, 10 Apr 2026 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TeT3o3jn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225036F42B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814762; cv=none; b=LVOAvOAIfJ0sFs8SG5v1+ux6HOKMh5VQHlRGtWCkktnwcIFTEfuDew2laQw7/MZo6KJbLnONkODpwdfBJT4btryV3rQvzLzXN2QPzBT6jYOFBtIjH+wuL62fT94XEujQkC0RbKa0JTRNoqOdqz8TjhUmxFw5x9QxBnyYLBAQ40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814762; c=relaxed/simple;
	bh=wC+ZLkXzJk97G5piw9Yr8951QpN425O3aG3RWKLmvz8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKhjtaonnNYk0ixLiZPGR6ASjTPb8oD7sFWYnDFgXmJjq+Ly0z9ZauM+5YCRYJcanUYBm75ei7QJlROIwzJaEulw3+jTV0thP9yNoz1joJ7Vq65JFTY/4milsYT+n9ItUvPIL/aoXKJmHZipnE/CPQc5Gg2FEQK2m+pzg2cc2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TeT3o3jn; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A02muK1095861;
	Fri, 10 Apr 2026 02:52:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=CBmclJJ752EZvz3UdeerRACzB
	P5uu3jRG2MZ+Gafox4=; b=TeT3o3jnznjRWWDangNkEl65B0HeR+pruVfSmslOV
	flz4Z0FhxhvB9H/4iQvnEplfR3aKMv1ukXOqTvbUO9wV3k/85oZ+rGKpVE2KEd9y
	4s6wtmzoEKFFAFd2779BY20yUTc2jT9FcQBPY1QiWzYSxteZZx3YsraNz8t4NXm5
	DTWBkGZlgaXgouPW40UxaBqDWag01noX9OBkH53BBEIEBfMJjZpu/OUH9aswmdDl
	lnIKsHFKWOrpzqvu3UiELPOuUStg7g0BXDNCPWHMGL7wW90sXUp8K9cCYZhW4+hB
	BzW9Uixu/nBYLf6Y21GMfCs50KKAPB7iUlpJbhsec9dow==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ddrw2dcwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 02:52:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 10 Apr 2026 02:52:39 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 10 Apr 2026 02:52:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 10 Apr 2026 02:52:38 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id A5E233F7058;
	Fri, 10 Apr 2026 02:52:36 -0700 (PDT)
Date: Fri, 10 Apr 2026 15:22:35 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Dan Carpenter <error27@gmail.com>
CC: Suman Ghosh <sumang@marvell.com>, <netdev@vger.kernel.org>
Subject: Re: [bug report] octeontx2-af: npc: cn20k: Use common APIs
Message-ID: <adjIY1Y86KbiBo3A@rkannoth-OptiPlex-7090>
References: <adiQJvuKlEhq2ILx@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <adiQJvuKlEhq2ILx@stanley.mountain>
X-Proofpoint-GUID: CT0Us2QE2EM65zCYJ-yHGLh2CKSkUwGD
X-Authority-Analysis: v=2.4 cv=asqCzyZV c=1 sm=1 tr=0 ts=69d8c867 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=pGLkceISAAAA:8
 a=3td_wS-5I6CIhLHr07gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5MSBTYWx0ZWRfX3Fw0Ega9+0kE
 qGVgb7h+C9hjKkXtotM5PUpDDZVzpazxC2rTRw3qHKJI6j5W34D9qFvDZ7ECmXO3VJsCE126O2N
 HD8rElaI9me4wvVws0ik7PJ7/XEPCMMKs/PfEdTayO+FLRiO1nvRCgpf1VLzTYjGE4JRWYmF8dg
 IrPoaI8+W1ZGH49GsxYE29aymCMHHoEAoYiWvcsGISphb9erAcVJPqni9O5eSWgh+UoY6hTWDHn
 ZHcAS5Hv48Fy07ckbnwYfnePO/Rz+WihyOAoxypJzUKspQzARn8ZkBtoEkzlmVG59WMK5Nbib3q
 kGwADaVedvSE3UWmS/VViXLCv6VK9/gXnmuI01P8gdO/oxFt/IzV0YB2hY8azcX/7UnUbUnTwlh
 rbcqNQlP9uhhc4dIRIY5B0eYmGXiDvbDXmPv04opDtmLtkDPxBQlPQ1HgkI6DYqny9vIllryb0W
 aWMPqvME7rrlwT9CDQA==
X-Proofpoint-ORIG-GUID: CT0Us2QE2EM65zCYJ-yHGLh2CKSkUwGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277315-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A51363D53F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-10 at 11:22:38, Dan Carpenter (error27@gmail.com) wrote:
> Hello Suman Ghosh,
>
> Commit 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
> from Feb 24, 2026 (linux-next), leads to the following Smatch static
> checker warning:
>
> 	drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c:1065 npc_cn20k_config_mcam_entry()
> 	error: uninitialized symbol 'kw_type'.
>
> drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>     1045 void npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
>     1046                                  u8 intf, struct cn20k_mcam_entry *entry,
>     1047                                  bool enable, u8 hw_prio, u8 req_kw_type)
>     1048 {
>     1049         struct npc_mcam *mcam = &rvu->hw->mcam;
>     1050         int mcam_idx = index % mcam->banksize;
>     1051         int bank = index / mcam->banksize;
>     1052         int kw = 0;
>     1053         u8 kw_type;
>     1054
>     1055         /* Disable before mcam entry update */
>     1056         npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, false);
>     1057
>     1058         npc_mcam_idx_2_key_type(rvu, index, &kw_type);
>
> No error checking?
ACK. will push
>
>     1059         /* CAM1 takes the comparison value and
>     1060          * CAM0 specifies match for a bit in key being '0' or '1' or 'dontcare'.
>     1061          * CAM1<n> = 0 & CAM0<n> = 1 => match if key<n> = 0
>     1062          * CAM1<n> = 1 & CAM0<n> = 0 => match if key<n> = 1
>     1063          * CAM1<n> = 0 & CAM0<n> = 0 => always match i.e dontcare.
>     1064          */
> --> 1065         if (kw_type == NPC_MCAM_KEY_X2) {
>                      ^^^^^^^
kw_type is set by npc_mcam_idx_2_key_type() call above.
> Uninitialized
>

