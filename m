Return-Path: <netdev+bounces-303964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1BMlA6bpRWpeGgsAu9opvQ
	(envelope-from <netdev+bounces-303964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:31:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 531CB6F36B3
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:31:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=FuH34gzm;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LeRqJwfm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303964-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303964-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61EAD300FED2
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 04:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27B02561A7;
	Thu,  2 Jul 2026 04:31:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F1A39FD4
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 04:31:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782966690; cv=none; b=TyVZqYoiJtsG8BvvWcTW18C+Oxnafke4ePVYRDMplhOgWmo9eju1aB3Iih1l5LuqBBrpbS7fG0fObzOtzjZkYqsTOx4ivFiTt/eDgJ+P3TGeUaM4uk23moJtpCF/ArHJ3+CCln64SgaJGIWe2w4gOFbpsYummo4mmfdL+Q3LtR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782966690; c=relaxed/simple;
	bh=vE7Hjf+MLc8902/ktwRaxiqP0uFvZ89u+t9/5HuFbB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tpo4/Vuzs5r6ktHDdKZl+2yVT5dakB5AL0IWQzE25SPBAJ79Fl3LIloqTo4FpuP3vWeIGqZwAuRNhiqa8sE3nO3tsiQAp0ELGgONiApbOzL6f72CO8E/T1QGxYEx5rcQQZkSsS/+wmFaPVxA7yu07kqaT72YLxFILwD+m3MejIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FuH34gzm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LeRqJwfm; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KMge3067786
	for <netdev@vger.kernel.org>; Thu, 2 Jul 2026 04:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9z14DdaScwvuUkS9S1aCzsy5HUZXH5Z2PoiV67T14h4=; b=FuH34gzmOQltaLm8
	w2azdXwGaNSljN1NZWl5tRrWFe4uA2HTLHGrtEZeDI6F1NSElZalItaY1rlfDQlp
	mh5DFLLg5Hyn8aWsWD6t12SIIPtapo88esXUFpiTA+s5i0D/JyJJeodFEBtrPM1R
	BlMIOGSoTA8QdLgw4mL/D5sudvPCrug6FFhasCnx93V01qqK+qAEnGnq6iHfreuT
	0WsyMdQjStUadCy53dK/6CAqZF//MWsHmkFLjBVGCI25dWSpa1b6Q28VSv0FWPTM
	IFASBpqdwFQNtPbe8oSp4zMrK3ixrBnWFguc4JNFV2FRS5IzPFpEWcus+1oZQTAA
	DTbTpg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510aktmd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 04:31:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c894391f000so2600477a12.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 21:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782966688; x=1783571488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9z14DdaScwvuUkS9S1aCzsy5HUZXH5Z2PoiV67T14h4=;
        b=LeRqJwfmaFAYcxhH2QOlcCYDqA30P6E0mh63YJNmYTq1i6sHlk0RgdyPmOzJ3khnBG
         ihBLBWrr+YbPNh8kYGGt4MyXFYSL7LwWbouNiJ8k5Wo1XpnXydOLskIzQMinAbUXXFS/
         VECkcZB6G+DI+yeO2OY5m/EV9Sjmmy7cUAsg5Vv9AulAEtjxWuG6ihpVJsROc5PAlRFI
         2cHgp2XXZmbhGeKKnLIiPKA0x+b+tQSwrFq5HHEwQODRCntxU1kYJkPZTxsdC7DRH+3G
         QrOyLasxLofgP5unOLMZjf50XGaN0QhXGdqNw6l6NwmwffXOn4Sgd41UzwuljpYY5K6w
         qo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782966688; x=1783571488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9z14DdaScwvuUkS9S1aCzsy5HUZXH5Z2PoiV67T14h4=;
        b=q5nIQx97Vt5VK+dK1CyDBiIOQcsLHJxsl8OYnw0ugFLcrCkNSBgy/M0e5+FSSdbLRX
         NCQnRG4qMOMbUILqHF4I5HnUPVx5VSl4IGASHuuUYxOkek0NrsjrSvEcUkERWKp2Us1/
         zr5dMMQALytD7AB5nzrvoxDlfxmPYt43cxLzWQ7tj/paXfZVl8i0xand9zbXlBT6Cqgl
         IYPV01ZQ6VRFuSObTABkUoBP8Eye8FvfsEsqYG9Lnj8HVSAGXJY8JyPDpHp2C8CL1HaF
         l/f+Uv/BdOI/ferjpyOYJMpoNy1Ty69BL6t2z2nPxE1Lu+ZpQZ7rijKbm0ITvdGxYVSi
         /b1A==
X-Forwarded-Encrypted: i=1; AFNElJ/ZKJoDu5QpHdcO5K6pXjPAY0DtlhLFMF+uQtUab9ZTvIviijqXvdMtMuGt64P6UAWtzNepe3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyged1Nr3Ycd/PXJL/xT3uiX46OwwhTlhxWHKpGWLs5NAy15uaj
	HjiueUAIaLc80ibmPxtgbV3LNF/cizjFG2F/awqnt52aNUlBzNU71ge9+cIfEAYOpmesVvEYFSR
	Pl9q2RmMm11GjxZzS5lCafttv7Oniax8cW2faobiygg0b5m7EMtqfbNrV7vcppcbgEYE=
X-Gm-Gg: AfdE7cnYUVHwOR43afdNfDmhGzayXyPF1K21NVhuahzdFnNgBfWtD/HUd1Sx1K5hlrl
	mJAAovTPOyZOFr1gTmftmOgTu6ea1pGlHRUk/49bTHZlQ1x/nrb4TS0e1bsm5qMVZkfit1To7Ff
	QnRKH0kEjtOfmmaYJydq9ETbV2cNed+fYDShHaAQ0gNj2Cwfvcuy35MbE9GTwmAHFXKarbQ88MM
	hRiM7oIu8NNaL/IWann1OZfZca9wUNgYCnn8WEw148dtytvh7e5icegK4Q3XGnlQTh9dHmiplA3
	um0UqrBQRBmoA8Nfof7YrTLZ/ZnUl5/gcx5eGx9s59ASmMastqQzMX/81/cYoFAPDaCjMgzYLlK
	WAmQ65Sun4DgRZFqHwa4Ao25p/uoiyA5TF3PJ0SZyh1I=
X-Received: by 2002:a05:6a20:918b:b0:3b4:7e2d:a3bc with SMTP id adf61e73a8af0-3bff3c31bd9mr4183268637.0.1782966688025;
        Wed, 01 Jul 2026 21:31:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:918b:b0:3b4:7e2d:a3bc with SMTP id adf61e73a8af0-3bff3c31bd9mr4183227637.0.1782966687526;
        Wed, 01 Jul 2026 21:31:27 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84366sm5441204eec.16.2026.07.01.21.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 21:31:27 -0700 (PDT)
Message-ID: <bb0904d0-81f0-4575-aa17-007aa88f9942@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:01:21 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] bus: mhi: pci_generic: fix Rolling Wireless
 RW135R-GL and RW151 support
To: zwq2226404116@163.com, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org
Cc: mani@kernel.org, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
        Wanquan Zhong <wanquan.zhong@fibocom.com>
References: <20260701095344.309409-1-zwq2226404116@163.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260701095344.309409-1-zwq2226404116@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: W1b46zXvHTWNFUMoiHvrR9xdjD2xX_B5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA0MCBTYWx0ZWRfX7fbuktbEUX4I
 w49ny2uG5YLWP7dh0tCWICfr2iS2lZl8SUdh+rG7lQsmf++AKhMXPyCDGxd7C7EZtKz7olEP/zg
 4fMCC+KiNWrP8GEhQmqEwnw4HzQ7jYLmvpTHvYHKecBNvKqUq5Z7sv9mzRorx3cT5PvlAdkjD/7
 KYy4SRGYbQ0qMjsBMyVPfMFflPh2NzGrW2BIKM3oKsHmOZh5wViyZ2X7fsuS96OnGaPrnDQTucH
 Yk7N5ThCEWhu4cgeKg+hHHIxLR+YROl5sf6nMdWBjVkX8Rfp3zKXKWXSJa6OnTBK2O9zbEqLyc7
 Pkrmir50jhjE0SSYL0pzoZHbY7Ux1dv4W8uyFb+KMOfO9bbVJeuf039Z4aP5IrZXTVlHYCZM+/s
 6b3dzr1HfKovOLLMsKvHiRUs3p0zIt7qtJrov9qjC2jrfM1DyLFK7LrDDTaNxmD2xxFkIMebxDd
 eVCzArKM38UFUkx0GJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA0MCBTYWx0ZWRfXyHSGl57CsMcE
 GTsqKwlp7s6XUL+q3fxktPVxvsBXlXgtHbQ8gSvcwx+Qhy6k1YLC0FQuw4A95u8MSGiKxC93aH2
 xmVvhTG4iejkXAGlGPmHGPX6cF6nx0c=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a45e9a0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Byx-y9mGAAAA:8 a=6GUwiT5CAAAA:8 a=nWUtx5Q0ph_BRYhHASsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=tp1klI1xYmtLYojU9LVd:22
X-Proofpoint-ORIG-GUID: W1b46zXvHTWNFUMoiHvrR9xdjD2xX_B5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020040
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,gmail.com,lunn.ch,davemloft.net,fibocom.com];
	TAGGED_FROM(0.00)[bounces-303964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zwq2226404116@163.com,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:mani@kernel.org,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:kuba@kernel.org,m:wanquan.zhong@fibocom.com,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com,lists.linux.dev,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 531CB6F36B3



On 7/1/2026 3:23 PM, zwq2226404116@163.com wrote:
> From: Wanquan Zhong <wanquan.zhong@fibocom.com>
>
> bus: mhi: pci_generic: fix Rolling Wireless RW135R-GL and RW151 support
>
> - Increase RW151 MBIM channel ring size from 4 to 32
>
> On HP and Lenovo laptop platforms the device probes successfully and
> WWAN ports are created, but pci_generic enables runtime autosuspend
> (PCI D3hot/M3) after a short idle period. Resume from runtime PM leaves
> the modem in MHI SYS ERROR; driver recovery (reset) fails and the device
> becomes inaccessible (PCIe config space reads as 0x7f). The failure is not
> self-recoverable while runtime PM remains enabled; keeping power/control=on
> avoids the issue.
This might not be MHI issue, as the endpoint supports both D3hot and M3.
After runtime suspend check what does your platform is doing as part of runtime
suspend. It is more like a platform issue not a mhi issue.

The change is like workaround on platform problem. so for the change
no_m3 = true is not correct.

- Krishna Chaitanya.
>
> Set no_m3 on RW135R-GL and RW151 so probe does not enable runtime M3
> autosuspend for these modules.
>
> Power management testing (separate from runtime PM above):
> - Suspend-to-RAM (S3/mem): tested on RW135R-GL and RW151; MHI/MBIM/wwan
>   function after wake.
> - Suspend-to-disk (hibernate): not available on the test platforms
>   (/sys/power/state lacks "disk", ENODEV).
>
> Signed-off-by: Wanquan Zhong <wanquan.zhong@fibocom.com>
>
> ---
> v2 -> v3: RW151 MBIM ring size 32; disable runtime M3 (no_m3)
>  drivers/bus/mhi/host/pci_generic.c | 4 +++-
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index d598bb3b3981..d0fee7e3ba3a 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -942,6 +942,7 @@ static const struct mhi_pci_dev_info mhi_rolling_rw135r_info = {
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
>  	.sideband_wake = false,
> +	.no_m3 = true,
>  	.mru_default = 32768,
>  	.edl_trigger = true,
>  };
> @@ -949,8 +950,8 @@ static const struct mhi_pci_dev_info mhi_rolling_rw135r_info = {
>  static const struct mhi_channel_config mhi_rolling_rw151_channels[] = {
>  	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
>  	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
> -	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 4, 0),
> -	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 4, 0),
> +	MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
>  	MHI_CHANNEL_CONFIG_UL(14, "NMEA", 32, 0),
>  	MHI_CHANNEL_CONFIG_DL(15, "NMEA", 32, 0),
>  	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
> @@ -986,6 +987,7 @@ static const struct mhi_pci_dev_info mhi_rolling_rw151_info = {
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
>  	.sideband_wake = false,
> +	.no_m3 = true,
>  	.mru_default = 32768,
>  	.edl_trigger = true,
>  };
>
> --
> 2.50.0
>
>


