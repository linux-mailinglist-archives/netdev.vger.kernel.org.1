Return-Path: <netdev+bounces-270492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO/EGm8lwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:35:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D96892F1495
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3F04300B9AC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2473932CB;
	Mon, 23 Mar 2026 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kEKOKaLc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VHLZm9S5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE8386435
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265668; cv=none; b=auqHGVdJG0ZPgPiv93uTBPy1qSyw5ImfWygpJHqq5QveesRFheEVszdNGh3KV7/8gYZsMp7IYB0zgizCExuoi9dJo4pUdablKWAikgUavPnNxSJX0nO07MTaBdBAkOfkdlujbWhF+kjUbe845DVq4I4RhS9GZNa7fRKPQVCurws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265668; c=relaxed/simple;
	bh=5y6Bd03R9I+jDsejN2kyRg3MgRmiMG2aUkV/pbS3EVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSTJjzR/mezsVwzcFES0Zp1incHB26VhiZrPzKaDRAGCJX8DvZdE93i8ynjLPp5Taz/DOF/BGHTop0s3/yiRjcwcmcb/phpQHpIeTHh9BHcLBpFueFdZattfjEjHu4jR2lFYUnlXMGz1HnATIM+WY2cbwF5jwyaLWFXHsHHhVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kEKOKaLc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VHLZm9S5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N77Mjh024253
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yP7BePyV8V69Gp0dwYW6aB+HYb7u/dPAwd2KQHqi9jo=; b=kEKOKaLc7JHXads1
	LiyvnEtYHpnm7QbgsRkuvvdn5iKUn31iiuV9BJoaGZr29co3jC6kI6pStMAiBmcR
	6jgwwFDiUIfP3Xz6UPHNmYvTvu77fvc0/3f2yPaPzuL1lSCpUaV90AououKvT30O
	G+3/JVwcwdGxb7zOb0GFIYmrQ91hdZ+HEuf27XuNJ31Kv3ueDWu+r1bdnSFlSjFW
	8WQX0dIhJTah6TVeJXH/KuQByFuvwfFBRwAECylOs36ZaEM3MWnqreVobcxJz6S4
	PMqMGMbj9ECQGPJ46f0leb96RmQAeSBh5pcCD6wQHyOSf5y4lr7Wt3oc4AH0X/nU
	BpxW+A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1h1e59sn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:34:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b27636835so41241891cf.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774265665; x=1774870465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yP7BePyV8V69Gp0dwYW6aB+HYb7u/dPAwd2KQHqi9jo=;
        b=VHLZm9S5nGqvINpPdMec83tf82BOiFRZsVehKA0ImJfnX020GoamMP6LsVPrcKmZF5
         u/8j19RKSk+kLa8Aimo4n8/QBTL2KOMN8tW9VI7AEouZy/iP6RuXrW2AIf757/bZp1Gv
         6J0TgokhsMnktQFn9eZA4gY3+kjY9SyD7BwSMRfQQhaad3lXDRB3ZYcG5cQIjLPbx2ZO
         w7uaKE5yxe3JgVZYrbrNOhH5bRuttQgaEUA9Sue6RdAd9iqK2ytpUS2XIBQJFr4sAggU
         wydJwt2bO4Yi/K46+MyBgkAw19XTH83+cuHYsdMGNOmDXerCZrYlEG/MiDQ8jLJAzrzf
         lhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774265665; x=1774870465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yP7BePyV8V69Gp0dwYW6aB+HYb7u/dPAwd2KQHqi9jo=;
        b=PkuBu1UrMiw2WJAprJHXwL3PJZtDKLzUyK+ZOiNijXGhBpJYPMF2LHEtl6rTxGQur6
         YV13nwfVmXgj727IV4iGVOoC9bBlza0c1ganKLWs0IATrKquDB6TOVkgsvhr1dz7ZNar
         xoByKGgFhoeK6gxY8vCcFrBPNBCltNaJeU837rnNUO4o4Em2upk60V4q6MkpEy2P0CqS
         hN78A8KwiAiCnSCZxTtESm/z0hXQCb0ocqYVlI66Lrdv+V6fDr7Xq4lRkatYngYD0PuP
         WkCKSwX1ETz4NJWaND7xiNe+5Osh3A1xp7QAZmT/X6NtM/flswiGwcvaFbXVhxDBlCfw
         60ng==
X-Forwarded-Encrypted: i=1; AJvYcCU4k8fPdH3y53jCr/Rq3PQTX8Q83XD9hZvZMEMpB/FKWFztg7Fzu7GAe+Wm76B5xp7ZLEWREpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/E4rEVh9z/0yxHK5/D3E+dEjHkb1bwX/SKoS9VPZ1G1ciGgE
	AXe+lrG8fmcJQJv7Oo+Y3eXExjfsPam8e7yzSEJ8/XFjucz/KuAnlL1sNq8Sa1a3E6r+QyiSdZR
	T9/9wIv+eUscym9jOB9rmBliy7sAfNGsMqSrfmuOUEdinXxjNTgD6BlJku2M=
X-Gm-Gg: ATEYQzyvOYcnQtEE7URPkza4dcSwPhpQXYwksCIC6Fcxq61UmE9ENWk1GC3HC04Q1ha
	mlmlcVzh/y+sGdDIei3igHmALvR3JZ9XI3QLbqmp1ntzSy04fqe477loKjeurjO/BGKdgDmKqbE
	0NZPmkB5nLaTrL0tfD2Zh4GtGM1TqLSDHaZiF+U1ONrTDmR7qPHkcscNFtYgkxEjj8l0DiTakVx
	hCLoNyzyRPqEJuo3emcyIzZs3+9uTGcphDI3M7JDbMwV+NE25sH5cvNCfcJqrY42aeJmbIdz9Z6
	dvDvS+VHS1I4o7ZqZOjVboxqkkpmP0a/cL/0qoBua1f/WNz02MpPUjLN0sL/V5g4/f4dtdIhA3s
	/FoqVNlcd6Jq9OgUIrEAdp1FtN77Pu5nvJxNADWDSDhWIR0EjZBpUNIiV0L2kCi25heF1TnOdUg
	xIgWg=
X-Received: by 2002:a05:622a:65c7:b0:50b:51eb:c355 with SMTP id d75a77b69052e-50b51ebc824mr45722081cf.9.1774265665434;
        Mon, 23 Mar 2026 04:34:25 -0700 (PDT)
X-Received: by 2002:a05:622a:65c7:b0:50b:51eb:c355 with SMTP id d75a77b69052e-50b51ebc824mr45721831cf.9.1774265665045;
        Mon, 23 Mar 2026 04:34:25 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983365a166sm489893366b.42.2026.03.23.04.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 04:34:24 -0700 (PDT)
Message-ID: <b743b408-0b24-4660-9879-3536d8006d7b@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 12:34:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH QUESTION 0/2] NFC support in Linux (and support for
 Qualcomm SDM845 devices)
To: david@ixit.cz, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>,
        biemster <l.j.beemster@gmail.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20260322-oneplus-nfc-v1-0-5f22f544f0e2@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260322-oneplus-nfc-v1-0-5f22f544f0e2@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bq0CfnPHSmXKUS_NHGeqn22lyGflzx_J
X-Authority-Analysis: v=2.4 cv=epXSD4pX c=1 sm=1 tr=0 ts=69c12542 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=XBYjAflyaPWs-M9QSm8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4OSBTYWx0ZWRfX6Roj4mW/PEoR
 DQiZP4GgS3OjsGWlp1UfqbJa6sV7J/1i7p5pJtbZq+wKskiNVgKEnUWdYrpkg7Vz0KoCDLkPaSb
 GczwIr2U6EcxXXsJ0kJwCq+NZahhgH3bwUuNmpumrCt4a2hXq6UQQ+/c1SHeybmH6lsMdx9BCg/
 qlzSnP+btLcIEOWmo//fRZw8VZPMOwWp71R0+3t0C7gMrwy3vMVJ9t+Hd3rR7ZealdL/+iFAROV
 9aIB+D9XqPmdsCkrFi9XV7eqMo33BBUb4FRP68RHu0WoyItE3Lhh/qOA53N1yH5unre/jB/D+Ft
 ulfQL1lLZp6nchkChdUp696GGVFIZoyeFxjyQaaakzCbUdbGKYImRLTJG1GY4EYN5FKzphPQR9m
 cg4ZwfFhPS27ZbNSi+a3Rxo7Y5cKwWx7/mBCCOmplVeE/+1tP91qwB087SDfshaEOsIkxWfETgQ
 Yfp6DJ7fSKGa0o3o/dQ==
X-Proofpoint-GUID: bq0CfnPHSmXKUS_NHGeqn22lyGflzx_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230089
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.105.105.114:from];
	FREEMAIL_CC(0.00)[protonmail.com,gmail.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270492-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_SPAMHAUS_PBL(0.00)[78.88.45.245:received];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[209.85.160.197:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D96892F1495
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/22/26 3:24 PM, David Heidelberg via B4 Relay wrote:
> There isn't upstream driver.
> 
> I'm openining this as a starter. We need a NFC drivers I assume. I tried
> quick check, but both of NFC drivers register
> 
> nfc: nfc_init: NFC Core ver 0.1
> NET: Registered PF_NFC protocol family
> 
> but efficiently does nothing. In the See section, there are some ways
> how to make NFC work, but rely on patched vendor libs, missing updates
> etc.
> 
> 1. What hardware is present on Snapdragon 845, is there some
>    documentation? It seems that both sdm845 devices has almost identical
>    setup, thus it's NFC solution integrated? @Qualcomm

As far as I'm able to tell, they're clearly external ICs

Konrad

