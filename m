Return-Path: <netdev+bounces-298087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w3+OIimYKmrWtAMAu9opvQ
	(envelope-from <netdev+bounces-298087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:12:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D775267131D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:12:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HrsgcuV+;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MYEe0vyC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298087-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298087-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC9A63365EB2
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE113DCD9F;
	Thu, 11 Jun 2026 11:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16F3DCD8E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:09:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176165; cv=none; b=f8t9EHk1aWlK5f/c9Of6KFcWLrpAmv8MQVGXWSgv1PcqFIGgsHmgCt9fO60aTn1gxTOmpVvRa2VStOjr2f7k+vWToeJ3lw26ep+rTKs4tn15qcQHlXrGiNFzS9LPu0sERGRfK6HXxswt/fIZuYY22yUd3uC7nBerksqX6BQvil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176165; c=relaxed/simple;
	bh=4LDLD4bL2RKuEubdKyGkbcldX6+fZfzLzJAR5i9D13k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSvcHr7sbi5reut5kUGtcNOhHo0i4JYaaz5JLo7z20y7/u28ZnP5sjwU2jNvE+fQ00CpWnl2P4u/1XIg55004yzobYv571f6y3ThIL2kPyGH35MTfPmdMgS9yTCRApQoi6wYVEnxprTKmfjuQZz0wbq0FeTu4jTbrAEd7DOsLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HrsgcuV+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MYEe0vyC; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9xB6B263558
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AbcWMSpbWcxDG6Ak1C1oDrao3F0+2Zx3golBpAedkmE=; b=HrsgcuV+xnXdPyEk
	BtYiOemFuW3XN6tCBv2B/Log0zbYDuh8Krt0kqC876AiV5bFj8ign7oDErGAhHJk
	ll7aHj/nY4x8VnyRHnz3Q3UDb5viZXdFR/zsFuOTbStKm1iOI1u+Q663P4qqaO2S
	rEZq7J+LkXcUOpa5hYFEgwjqsVGLJ/BinzlGCFKPApTIf+hEBrXPiuOXJS6BLR4N
	HAiW6FNwX8m6ixpp0kbcfNMUjtIZlpZDGOurXHBpmhNrqDdO7FJpEWlusbXCML4a
	LoVbZljZ9mJxdutpyFOP3O19LnBU9p0QBnck2ge2ig9OW2eeyDk5h4t6qJYK6ObM
	FrUMqg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6uu2uf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:09:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517865e6219so17079741cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781176163; x=1781780963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbcWMSpbWcxDG6Ak1C1oDrao3F0+2Zx3golBpAedkmE=;
        b=MYEe0vyCWutoLlWUjF3tcrRyXIc+UtcGtn+nN1/FmUFEuJM6cTw+EwY/6aBvuSMhGK
         8lvHDKH8F7UBZtpttvszawSDRldfO6KOPSXgfCJHX5li6KFHbPhf3fPO+Zmm/4sOndap
         vbhPfs9ouvjK2qsJeApl+ThcsQWu8YR4mX0yKuuLbIWkiLIa/VsL4E6Gr3ime1B0Jp3c
         Kh1MqffWA1q/RmdwdBNf2P5Q5XSiGry18dFZF+uaWsaFfFz56vdi3yh30k2Y7ZbYBNr5
         cuMNajcPuCl2rEK/TgHechEghMyOXYIqnCXCVf5ox/bBbdpt9oeEqupzrqHYM0WeUfmv
         HC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781176163; x=1781780963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbcWMSpbWcxDG6Ak1C1oDrao3F0+2Zx3golBpAedkmE=;
        b=PpgtYKG7M/JFzVZlNqpR7EJ0kAFA0/1LPpkKEsY79d0+XtEvWj5Kp6Pbd4Ybd+/Jp5
         hczYGAFaxLffXrqwombQGbIDYwNkHQUMLTfSPN9qDW3A6bv2W6HKt4Cm9Y7BXtc3ZY1M
         2MpJ1efxLEE1bu64Kg2ROWqNWwWZuNndxhhWUDth3TJDqckKlmk7WY5CbX4K2MlqWvxe
         Cg+Ge2eL3/NRy/obH/GWdJTt8N59aaFhzgMQqlSu4CmPf2iWa94NrLor9pmiKbeEIgZz
         Zsh5qBi+Y5vutEbTA7sHtfceKqXB0bCsidOhujueLh+mBssnoMhQDePyXnB/XwRSJWre
         t80g==
X-Forwarded-Encrypted: i=1; AFNElJ+D6DUjio4ZKC3zYCksGLi6JXHPiMOvXyOfqkRqXz3ouoZEU+wYapvOQJ6Nc2PiDNeYnt9dUds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqSuvFl33eTbZUcyo/8eJ5cltfYykfQVPyobxDSdbd4mMbY7KH
	Me8Ad5dnFMR/nM0hYeEa1ayX1z0Svpv3CBfbJ8rEl9udFCe+C/UThRsnVeMcZ5eQkkcqsEnUBdN
	88vVs5/ZTlhFl7eCftHaDqmJsFk+rlgWbQufwXkC6MdqXQOW3eV4GhgAU1uY=
X-Gm-Gg: Acq92OG+XtEKF6usRhN+c0Lo0qAMFMlF7A0V9DGDw1j+KyxC/gkjg1OUG4pxhxoLjIF
	QAgidFcVYnFkR4qwFDu1KHVH+vS/UdyTd5aluyAbuS2cNyrW6R6HM/QVkIr/+nYlMUgnyfyuBxC
	bfG/LpGqrhtpvlIzWYHEaR2JyDYkHk2ALmkghmgq3rgdXWqX1y9KsXk47NXtOSUgSd4DgbTvcWG
	Hc5n49EWmWiEoftNuwNhb+yghfEmuN7BXo6X0sDTE7BQdRyI1HqWrgZRdk9oR9qCElp9g5JMOwW
	136dSrQulZVT10OrIAbQP1p6XLXM9CFjX0kOLkmVAv9we51vxt+R5y9Bkr30FR0bUFnVZljLgSx
	gu/58523Yi9Td5xILXTsgn0zDqKgKPv1hZPdrVLKlMApBJmS9sZvdlv5W
X-Received: by 2002:a05:622a:89:b0:50e:5cc1:1de9 with SMTP id d75a77b69052e-517ee27fe16mr20241481cf.7.1781176162798;
        Thu, 11 Jun 2026 04:09:22 -0700 (PDT)
X-Received: by 2002:a05:622a:89:b0:50e:5cc1:1de9 with SMTP id d75a77b69052e-517ee27fe16mr20240991cf.7.1781176162261;
        Thu, 11 Jun 2026 04:09:22 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb60b99f0sm49789266b.55.2026.06.11.04.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 04:09:21 -0700 (PDT)
Message-ID: <22e69b79-6dbb-4e43-914c-7800eef49013@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 13:09:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] clk: qcom: smd-rpm: Add missing RF_CLK1/RF_CLK2
 clocks support on Agatti
To: Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Brian Masney <bmasney@redhat.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
 <20260608-shikra-gcc-rpmcc-clks-v5-3-94cefe092ee3@oss.qualcomm.com>
 <b86e9f5f-a7ec-489e-829e-6e07c62841a3@oss.qualcomm.com>
 <31525025-333e-4845-9dfa-df68a3df3752@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <31525025-333e-4845-9dfa-df68a3df3752@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a9764 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=7GRNE63i-pEe5CX7YLEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExMiBTYWx0ZWRfX6g3KHgq+0Muh
 4tGS8TU6Fz7lcj06DIuiw8d5uCyA4Rl0JbLmwhwKYUEW2y0tqx16gw2kB/dkxeAGA2tHSwAzIVt
 JMkPBXnctCHetPSiEHJepvvV8UsQYoc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExMiBTYWx0ZWRfXzXOqSqBUqMRQ
 uDVY5dTSDDKz8jTnu2FE2p3BhYrycF768JvBU2iBNzPijQo6QLv0EmTf3pYUzGPGu4JEEbU6Jdh
 Rl54lOadPXQaz7VObwRQay+C6r9wjP+uJKoLMFYvdHos6MGLzI1YLFv6xVba9HCkcze8Z7sH3kg
 yO7NOtyd8ABNhTOeh5S0hM18q787uAOqpmmLrWWOq/GKXs/KLODDIwZbLnYkYQ0E0L51NODIbEs
 Lws9XUikB/v39GQjvhJDQM5zXQGDrJV/pejmXDh5YSB6GzoEuFj/SWGxWIK4o0q3SI9kcg3lyTy
 a/ve66K6G2T2DalLFAQmAZ6tss89kU441tTvWeXSscw7/HdQ3JhSBe6Iv+fmZj0AOi0W09sRzXO
 dQbqpCwbDsGJ9zQt1X+CbogACiy7myDFoODZSu5a+4G1ixZNUh6tNG1Krnylbuq9xHqA9MrsFdu
 ZSINLb8A8PsamHlNSIw==
X-Proofpoint-GUID: o8JdX96FFOOEe5QIab1N0HJn8jWt7h09
X-Proofpoint-ORIG-GUID: o8JdX96FFOOEe5QIab1N0HJn8jWt7h09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110112
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298087-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,baylibre.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:imran.shaik@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D775267131D

On 6/11/26 12:52 PM, Imran Shaik wrote:
> 
> 
> On 11-06-2026 03:10 pm, Konrad Dybcio wrote:
>> On 6/8/26 2:21 PM, Imran Shaik wrote:
>>> Add support for missing RF_CLK1/RF_CLK2 clocks on Qualcomm Agatti (QCM2290)
>>> SoC.
>>>
>>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>>> ---
>>>   drivers/clk/qcom/clk-smd-rpm.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
>>> index 103db984a40b950bd33fba668a292be46af6326e..0b624ed4715c75042b92ec49c073b281533cace4 100644
>>> --- a/drivers/clk/qcom/clk-smd-rpm.c
>>> +++ b/drivers/clk/qcom/clk-smd-rpm.c
>>> @@ -495,6 +495,7 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(rf_clk2, 5, 19200000);
>>>   DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(rf_clk3, 6, 19200000);
>>>   DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(ln_bb_clk, 8, 19200000);
>>>   +DEFINE_CLK_SMD_RPM_XO_BUFFER_PREFIX(38m4_, rf_clk2, 5, 38400000);
>>>   DEFINE_CLK_SMD_RPM_XO_BUFFER_PREFIX(38m4_, rf_clk3, 6, 38400000);
>>>     DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(cxo_d0, 1, 19200000);
>>> @@ -1262,6 +1263,10 @@ static struct clk_smd_rpm *qcm2290_clks[] = {
>>>       [RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_branch_qdss_a_clk,
>>>       [RPM_SMD_LN_BB_CLK2] = &clk_smd_rpm_ln_bb_clk2,
>>>       [RPM_SMD_LN_BB_CLK2_A] = &clk_smd_rpm_ln_bb_clk2_a,
>>> +    [RPM_SMD_RF_CLK1] = &clk_smd_rpm_rf_clk1,
>>> +    [RPM_SMD_RF_CLK1_A] = &clk_smd_rpm_rf_clk1_a,
>>
>> Is RF_CLK1 19.2 MHz (with the other RFCLKs being 38.4) on purpose?
>>
> 
> Yes Konrad, as per the hardware connectivity, RF_CLK1 runs at 19.2 MHz, while the other RF clocks operate at 38.4 MHz.

OK thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

