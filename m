Return-Path: <netdev+bounces-270493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM0tCywowWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:46:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7282F168D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F2263036ECC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380473976A2;
	Mon, 23 Mar 2026 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o7f0gmCt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NPg0MblB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C48395DB7
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265724; cv=none; b=EkBljjXs+fKBDRei+zipLtNSlybtljdmm3JXITtg6cicuQyj4CGdGGci9PqkB94KBmHbLFG4zvBIsp2cYcfkpyhUp3QRbLc3N07wH2BdqcUfGtkFJOKtfSEwRyMUEgJ8JTdFA6meaNFTDS4KJmpK+tt5nK4gJ+1dUf4qvxRBk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265724; c=relaxed/simple;
	bh=xDPmlMDXeL3lxfgUwJ6Kd1KI98MjSx2OU5F2knJ/FuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ua7RVq+EoEUx5mfOOg5ob/tEsHfIvYN+0mnf4FAxCQkYdV8Ta+yR6aAutsPoQpog3PNpmAiLY7j80rqUCxbydbg4zhkB+iMO1yRXyk+RB8+RrDa1TqLTiNXERRWT/hVBuswTddSwP1pjHNCpkqvn/iuffd/gWXm6BWFm6ATSE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o7f0gmCt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NPg0MblB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N7UPMp424216
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6wS5LtayeZTbWa+/jowDNFAN2aTZHLtBtVNHTSu7Goc=; b=o7f0gmCtH/CDJQer
	Uzu1ls1dWrprV1Eu0TfZoj0LGizNlvHpmGL0pRDGcQwqsNyBYPd9xJ89ATQPBBHJ
	jtu8gKZiU6IPqagOAWGFeoW/wir9KtD4c+pFqm/tm5BRRATdmp/93fkrRo+P96oE
	CyBAGXQ0hvZvMztGGqvEPyuniL1CEItyEnPQ7mlTddDvlcsM6cA5NxeH4ZfYbrf6
	NAVIc/ytCcc/ZyXr1p5o9d3RhrGesFi/DOsG8+WYBeqewTRLccaK1WAhjdSRpmkf
	Oh16AGtTQ1iUI48UuOS0WuUdCseAoYGKcN2pUN4ckpZqmpBSWhf/qzXil/NYdmwn
	1XlOcg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jwvn77n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:35:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b32feb719so26897811cf.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774265721; x=1774870521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wS5LtayeZTbWa+/jowDNFAN2aTZHLtBtVNHTSu7Goc=;
        b=NPg0MblBoXrLKdLf2m6vQYDMJQcwRAWxjrs+uhSY6/AVkmRNd3qFHsxPNXdwaDtqQr
         4aut/qZN9/UwxMgOFkWgP0LptZFVTMELbXX6OEG87gbM5MQRhdy1ZD7oIk68NkODbZfl
         ZrtXmzMWqWEb65pZkEdkg6Pq7qs4QPCx0RO49+D1lWkxFRPKklehirHpEt7Ch9am+oHD
         Iwddy5VJK/c0/+VH0fIuXMUcb6JOFEptGoN9oIsF9CpWEFngDfEAt/NAVrU55MVx18Dl
         KpeqCv5GNzeh/GiBe7k2zbfTshfgDACpQojR70R9V7KKx9oNsdrepQpFf5zun9h6wCyD
         IMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774265721; x=1774870521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wS5LtayeZTbWa+/jowDNFAN2aTZHLtBtVNHTSu7Goc=;
        b=N9j5ogXGVjsil/vSpPSaU5R71UOcTt2Bv0tr0Zf6fzAMoBuZsBJ6w5NdaR67NVSzlc
         liYB5N4i8+9Lcq9445ENveePGyLH/wZIMMCXjBRwoAlnqB6XHJLZeDnXGur93T0ast3A
         vH4qLhdm9I1yC7LKStYo3L9zU8cEiiKZ0BASpllYuZ2ZPvjfK7eb7TBxcqJ93vjtu93M
         NbOCKKYr/jkeNln9V/8MWTQfQp47LHNMI/vDmuQVynaVEpAv7VF78JA2vX7rafuj7rdI
         C4/ux91ReA0rcmDLt0xeP9Ph1yKPLH7kIaBCdFWVSp/rLp9Y39PM1OwzzO531D8zG/2n
         rL5w==
X-Forwarded-Encrypted: i=1; AJvYcCUlFqwg9h4NtYWhMSZSQ0+QUvB63/IXTozCp4Vk9BOgKl5K0J5ClnnrtyyncAiLe5XREkoP67w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOtFsRc3Tz8ugy15qE3+1LurEL1+pQUhBYOhoTUg6guWk/a3JG
	DX9P9ZxHn2vqZ0Fld5vcld1MZHEa8SOQyVCRv959GwNMphIqvOkq7Xv4s1GqN+rGroC8KZ7zgeY
	qgWEEur2khkkWozikkJ2Ne/fXzwRCeWHVxHKUad4EepfNl1NHC+Pv85OYo7g=
X-Gm-Gg: ATEYQzy5yQEOZTwwvrIfi4JYcz6j10AFlNEaBFzo4iK0Qr3P7IDMQQgLuMoriDJW8Vz
	HlF3vqhofl4mtKYy41bmSfrVCu/rE58ZBcigo3GsZFgNCRyAuLAJYbTBRiSKybzSoF4OBmvmR3r
	uojOUD3KO7FAYq5mwERn4Im/LnrblFXe5fMZDB2wLHB1HlVU7LkmAtY1//F8W7lacXAgIr4yavp
	yA8oJdLvw9uP0EZ3faLWBClX4X6nGrJIVhVn8F0LWNm4p/XQ0CWB4YeVuFIBvLWefBtKgQ/qb4V
	blDmqighnNNhQPQX3/qjykx1dyVEXhXMvYLfDAZYmS8OpvROGuv4EL7WE1+5Ve4Rx8fJtmn3Oru
	UUpvSLlFDc7vwA2b3y4VMfvydTi+zvQ/Wo+NycUuSYzNUCoQ2Vjn0oK9OjeP+LIw+mIa3AeQ3r0
	2O3zo=
X-Received: by 2002:a05:622a:4647:b0:50b:6b21:2a80 with SMTP id d75a77b69052e-50b6b213658mr3775571cf.1.1774265721265;
        Mon, 23 Mar 2026 04:35:21 -0700 (PDT)
X-Received: by 2002:a05:622a:4647:b0:50b:6b21:2a80 with SMTP id d75a77b69052e-50b6b213658mr3775111cf.1.1774265720584;
        Mon, 23 Mar 2026 04:35:20 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6694b45de66sm2208073a12.31.2026.03.23.04.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 04:35:18 -0700 (PDT)
Message-ID: <75c80dae-1ee5-43c3-8d72-bf239fd51fb8@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 12:35:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH QUESTION 1/2] arm64: dts: qcom: sdm845-oneplus: Enable NFC
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
 <20260322-oneplus-nfc-v1-1-5f22f544f0e2@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260322-oneplus-nfc-v1-1-5f22f544f0e2@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4OSBTYWx0ZWRfXz3kQoD/16M8I
 RY7Ecq5s87O5Ou4Fh/QlG2gESIoQOCKCMrRYDTUrLrP8NajSfMi7SGx5CxsvKw+g0UebH5z4o+A
 9GJh0BqTr5rkkUNOvBDUdr6Jrf3Bwm/+yoE+iQlfcpxYtSqyCGM1VMhyOjDlCjZFFudOy0YUL2W
 NP7DhuTu+meO+WDXsHdMCPHUe1iMWfQrA0dPSd5dvBFEbfrf2P8QQsTrNSvQrQgbmNaGcR1a2P0
 beq66MvhzBhftiCTNehhnjjO502c5vAEmwkiJNkI14QiZ2+BcuzYLg99iDGb7TpEB3OUILTXm3Z
 4lrHvtPJCStVWYesUjlJ1IWN6iUHYPsMbe84nJZFD5fV2s0uh0WkkY6CLXX1rnvJpwPaZx8yLtQ
 72BDSFt+X2jWwAHUwnx4s1aFyEJKvP4Q4ljMbjkYJ9QpRb/I/8lDzP5R5rApLVOGp7fGkFMMCYd
 4zYySgw3BW09B9GFtBA==
X-Authority-Analysis: v=2.4 cv=bcdmkePB c=1 sm=1 tr=0 ts=69c12579 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=o4zcOJKZs6uzFkhwQ20A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Lh28zDgd61yLMoaD9ikDnfDa9ckJBun1
X-Proofpoint-GUID: Lh28zDgd61yLMoaD9ikDnfDa9ckJBun1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230089
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[protonmail.com,gmail.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-270493-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ixit.cz:email,0.0.0.28:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8E7282F168D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/22/26 3:24 PM, David Heidelberg via B4 Relay wrote:
> From: biemster <l.j.beemster@gmail.com>
> 
> Definition of the NFC.
> 
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index 5b121ea5520f5..34f476299b114 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -392,6 +392,26 @@ &gpu_zap_shader {
>  	firmware-name = "qcom/sdm845/OnePlus/enchilada/a630_zap.mbn";
>  };
>  
> +&i2c3 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +
> +	nfc@28 {
> +		compatible = "nxp,nxp-nci-i2c";
> +		reg = <0x28>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <63 IRQ_TYPE_EDGE_RISING>;

interrupts-extended, please

Konrad


