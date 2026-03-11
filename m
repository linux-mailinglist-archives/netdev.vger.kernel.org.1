Return-Path: <netdev+bounces-266416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePYnAJvQsGmLnQIAu9opvQ
	(envelope-from <netdev+bounces-266416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:16:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8125AD6D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60B8C321624F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8D34D390;
	Wed, 11 Mar 2026 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WW3IgNdu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C43563FA;
	Wed, 11 Mar 2026 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195282; cv=none; b=H97QoA6gHMVSX/3j7wI+wF3IVUhExZdnlmESC4zEVeVsNsJGlM18f51JrW4t39uVDN4sHg3isogkHWsrvZiu+7+bGj6aOoaFafpHEZoPAjyAAio6Q2lEMRR8fFg89kioQJySIRpXSWdYwKfaCSjKaLZgPOWxrEP2HI/qH6XoRZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195282; c=relaxed/simple;
	bh=g9KzHJnx61EhnIzoqsS+c9rf3WD+Idn9HQQ7iGVKYJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2/P93SobZc/eboWCtO9+3phbAlXyL4rYQspOFfjn+T9qm1fJHokQ+f5rBtrEwUo5KhscLEwYOg3y9Hj9zN/snaVSkNKjgFriAVtkZ02y81rsf9gxQwmvr1DKx5MIb5X+QCaZVzevQfayBX3XBiT60Phxj56fnPuFXHncnClmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WW3IgNdu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AJkWSZ1524531;
	Wed, 11 Mar 2026 02:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2ZceOk
	42rdEXugzjAGSRfQyEii6gNZwu/bJn2eegNWQ=; b=WW3IgNdutfTc9AYvNYBMDm
	HvoooDuQJBZ40CXMkmv0B8HdG/bdsOfAeKi2uMAcEvnPzZ0ZPGkLA9fKN3vJkeic
	NHX4uAVtqn5b8Z7JHeap+pwVEt2es3//N+AKVVr3Y36VKb+sJMwPhW/SflfiGprF
	C8aB5xJTLIn6k8xHP6SyO6L/EgW1DhAWxE8aH7E1+xAam8WGzh0CFVsvcdMsPJf4
	1ywXE7FZsk1W7euMOWNL0uH85/IMNQZkxJwKkASOMQAKOwv+W/bHaf6EB0K0b90A
	N8gh4VEu8Z48mBuhIPfQG/0wpWMqqsSvljZgbkxDw/8gVNDxAa0/n8Qydm72KiVA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmdufc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ALKPFK025052;
	Wed, 11 Mar 2026 02:14:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk3fs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2ESWH23724328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 810072006C;
	Wed, 11 Mar 2026 02:14:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 587042006A;
	Wed, 11 Mar 2026 02:14:25 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:14:25 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] powerpc: dts: fsl: Drop unused .dtsi files
Date: Wed, 11 Mar 2026 07:44:24 +0530
Message-ID: <177319508337.269267.16812187725403935492.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260128140222.1627203-1-robh@kernel.org>
References: <20260128140222.1627203-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hCYDyKHWNdjAoXl8sTBYY5Yk76KZBsq0
X-Proofpoint-ORIG-GUID: ekoJEsiTHtdoQQ4LVuqf-mnYOUpkl9We
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX1Z53069OfAF8
 l9k32Xe/ddRW1NELIzPRxp7EJa62BzLSPQPunOPDJT6UwP63z7XaEwXOGxSolD8FQCmXhsMl3GQ
 w+RCGjClj6hOd21VMljOegCkTlPBMmCyi+5KWyC39Ttm93XAdERlTw3rO+Y2pqWkjA2hFFFLE1M
 fPSMz8+dLsch+CZePHyy9ZWAQ0AGhoc1G1INE1fClpIJDdD2hNBfZwENdiWl1xt9ql1MkPkKnVs
 cgAu715zF8Lh/HYBbD5QsGpelOTKlJ1TGukv0sJ3ADnDhVdVRxZbcfibB40TUfTbEMPZsobcPMY
 Sz+AmEqMXsqkOyowobXc3DmdDosQzvHatiQ2atYDtyvQ3R/NNONwvNdF1eit8dmHBAWY5B9lcP0
 1wtlC5Wlq4uhO8ZfD4hJOIp7neBMPV5qDkbJ1TN68hvZEzBxSKyXVwibT+KPf2jHaZMbvALgaVH
 3p8sfObWh2BcsxFwZvg==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b0d007 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=ojrkqjeVVkUaGn_0cJcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016
X-Rspamd-Queue-Id: 9CF8125AD6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ellerman.id.au,gmail.com];
	TAGGED_FROM(0.00)[bounces-266416-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maddy@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 08:02:20 -0600, Rob Herring (Arm) wrote:
> These files are not included by anything and therefore don't get built or
> tested.
> 
> There's also no upstream driver for the interlaken-lac stuff.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc: dts: fsl: Drop unused .dtsi files
      https://git.kernel.org/powerpc/c/0706178339974d4332a782ba851cb6694bd210fe

cheers

