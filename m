Return-Path: <netdev+bounces-268101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHrmC9Pdt2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:39:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B2B298039
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 158C8301A72A
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D251038D009;
	Mon, 16 Mar 2026 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pzKAgnIH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fJ58h0dm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D496388E6B
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657503; cv=none; b=do5xw4B7m64NLTmgVrG8CZZ7Y8v9cFKmY5gz2RAhxTEIMkVC3cpToSt2yKOkosMc8iI++EwKnE5ijb4+n0/nRjboDaUl9tp0maXfxtE6fKDOyj3+uEXDXP5bI48mnXIxSnKW+TjEqHSnHBpvcx7jMb6HgpV2xp8/6A9AVa6hcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657503; c=relaxed/simple;
	bh=N0ETczg47Hthwni1YXRrWbd0jR+hnMv9HzsCGURdEAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uY4xbKm1bjAuYiYNEGPm6db98NMYJNibXJz/NW6xd6i0+baswedlD5oSEYlqsojg/UStukPhqE0u3sbmKvlP79iC9LqagIGQn4vPUaafw4R5vrnCfc7ggpe7hWeGR4Fl1tqFLhiwiuD40/SXy9CM2vNLFisKdTvsKn7oOSVqSJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pzKAgnIH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fJ58h0dm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64h0A323609
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ALirnm3qVmuyZak9zQ35S0q/tHtzUERhG5D7Dbo0hbo=; b=pzKAgnIHrkOsZWEB
	S59RUnQKyn/HQ5klGqlYSvo9pg9gnc/+1PRVu11XTdbHGdky048gwuZx/4ABNmDF
	M06DrP4rbscBFV6cmQ5wSmYqZnPt5pYK6A7T4It8UrAbL1m3m5AlokaaQxywxfvz
	UFsyqcr2m/BPuZXedBTGBKZX9oeoyPev0lr80B31FEhQme5DqzzjFjowJbhKvz4m
	U1LC9ZKL1MrTNCFiitTXelvlGkr0G/ZTaTuEjf+Vdf2E79OTZuOf/Ni7yKsm7DJ9
	TAZjcaMs/bmjZpHdiR46XToSJtIe++GI0J0dMOqhxwYfEm7+XSib7OMvnIu4miQV
	sw2Ovw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03qnc43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:38:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb456d53a5so302819985a.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773657500; x=1774262300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALirnm3qVmuyZak9zQ35S0q/tHtzUERhG5D7Dbo0hbo=;
        b=fJ58h0dmqPmE5Qwx4c9PgUBg9V44sxrn5cNHmRDD5k+ZtuVHOvvPqAkDytQZzplAXz
         qZ8Vus/fb8nbZTLKCeNQXVM5A3jrFj8ln7f1Ob7z4qNzgbxVyCX3avTahbRYURDDTRXh
         P9TSaUnaxZyYIxB8n0bc7rIRga6farn7P82QfbIJb2s4dPeV0AMw59xHgUrioCTCleCy
         g/7gDXj1Rql7Fhut5ayWTgCRd2j+InD4SWfE/hvphwym7AWQBSoQ4Io/dbU9A7GIrlhr
         v4B27wqDWnydZKkmoAS7mob0g9ALiRNpAArc0q9/k+6gVmWBrz/lKV14TlsBHtonLEBr
         ging==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657500; x=1774262300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALirnm3qVmuyZak9zQ35S0q/tHtzUERhG5D7Dbo0hbo=;
        b=iJ+9rietUvd5Yjx/keIBhX+wMvTR2PTrawHt7C7iswGJd48LB3Bvp+SnUlJVrm6ncY
         IaN1tLpN/q0jCecF7KQ7fW6Z/IxMYATbBSvZ+jnbTjPfGlWxVL9WXPk8avjaukHrIj9b
         wpiYipdJvd0mMbN6Fr9FjGNlb6vi/6DmOartnaLQ4ILKZDnCx1GQJWivzTLXmwM54zUM
         mNxXmVkwgNtTveeKPnJBqh/4nlyTUqVr73l9NvJWhCFmtSC01EW0SxyYdJppE7TnyiaN
         9awsNW7238EWXxU+LqyyKerF48gCU6IFaWKQelp5H8y7gnHCMV27NzfH0e5aCLDuJ0Y2
         qSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi/UrdclkiJimYAqWHciFo1IQhTMMrnv9a6G/S4gfPdcczqM8Bp7mhtt4Z23++JH9IlVzmfJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDIO90bkEXOGfFCZ4uUEhud+szU562Nw5H16OiO3sEG158Umli
	nRK66IW/s1LzanTn9GJQaOKtClp9RtrD28zLEMVjh0DWJLmLog7G1OswTf3eN9Kf0esxnT5zbtE
	660Xpi38HGKfsSlcyUkyUUe1XGNAQH83+IrzQ0xkgKWWrfsb+cFQbHMG+dKmkiUMo7e4=
X-Gm-Gg: ATEYQzyzQkF6mnthJRfViG+G7ILzsz6mvonwpDlmB1/Nyh0376Y9LeesUw2Ax+jQua2
	cjhKmBKg9rZM+PnNO+avqTRdFD8HmUWLBI7U816STFS2aoCgtwVOfY/EPXHVXvasifFESbXT7Wf
	AQVRlCrvqOzr+KUvEWa3Y0MeRrHJ0HaVikxU7aJU5bURHEhlfarcXT3vguZDxeCdUn/Bd4qjYoV
	698EgoZuTo1a+sn55LFq0JopqFNb5kiH1nvCtykE3SfYl23o+CSSYa/RlJpZC3lMFMArvTNtlEH
	YikKCvMP5H82knjey5TJ1E2m3VkYnpzE5+VtpgUbfxixMPAlqwOUOTLuEnGr2hgwCiCmy067HLO
	/x1otgnFQVfp4XIPIpjS/2wpq70M6+vcClLM48LhHujZEmO+rQqCTUBDWyp+UJxTf5C6wYvUIBt
	pRLl0=
X-Received: by 2002:a05:620a:3193:b0:8cd:923a:87a8 with SMTP id af79cd13be357-8cdb5a2d141mr1275006085a.1.1773657499697;
        Mon, 16 Mar 2026 03:38:19 -0700 (PDT)
X-Received: by 2002:a05:620a:3193:b0:8cd:923a:87a8 with SMTP id af79cd13be357-8cdb5a2d141mr1275003885a.1.1773657499223;
        Mon, 16 Mar 2026 03:38:19 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6634fbb9b24sm4875162a12.6.2026.03.16.03.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:38:18 -0700 (PDT)
Message-ID: <a87a13b0-2bb9-45bf-a3d1-2d08aac2a171@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 11:38:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] arm64: dts: qcom: monaco: Add HS/SS endpoints for
 USB1 controller
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, r.mereu@arduino.cc, m.facchin@arduino.cc,
        geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
References: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260313103824.2634519-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260313103824.2634519-2-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U-_z_f_KJPO-LoWouFJTTos-RzmXgT0e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4MSBTYWx0ZWRfXzauFpnUo8Bs/
 Goczc90h2IQ6cPK+qL8MaWd2WENaFOdbgSEznBhWaz7BtS3CclLwdXX8wvp5lOTdt5rFc/3auZZ
 Xy6peKoJrx7ZDb6tTrP7/njdvebS0EYl6gd8Xy+b4Ln7haldYbcFYB0zx067sF4/15b7nP/wfxn
 MhPypd7hMpc/t9WvMX5sB3/q+PpA8/SMOLIab4iJj9ZoTKnmB+sS7MqRIE9qHzhyFCYczh6goqE
 zcEA52xEGh7Kv2m10cs3vcafzmugqQLkcZ1pbKJSDdDSvD8cS6MD6YiKUSJFZH+bb88BqK9XiMJ
 IzepBnIKs06RrN9/1/jIigC89JrqlghglrDbm+3uPv++PNMAX0nBumFSrcZ6DluiCtUjwrJh16i
 r9fDK+6TGCeMskfNaGrowp1O59Im2v0RjzW9yaeoaRosboBLCuZg78NVdFt6dOTBviadkJxnBAe
 KHLexpwR4QeSyU9myqA==
X-Proofpoint-ORIG-GUID: U-_z_f_KJPO-LoWouFJTTos-RzmXgT0e
X-Authority-Analysis: v=2.4 cv=ZbQQ98VA c=1 sm=1 tr=0 ts=69b7dd9c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=od1gnLZaB1Y5O4OfTGMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160081
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,arduino.cc,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268101-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 82B2B298039
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 11:38 AM, Srinivas Kandagatla wrote:
> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> Add a port node exposing the High‑Speed and Super‑Speed endpoints,
> allowing the USB controller to be linked through the device‑tree
> graph.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

