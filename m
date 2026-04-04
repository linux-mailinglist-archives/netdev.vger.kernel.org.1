Return-Path: <netdev+bounces-275404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBokIHx80WkjKQcAu9opvQ
	(envelope-from <netdev+bounces-275404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 23:02:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C5D39C774
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 23:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A216301875D
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAF533E345;
	Sat,  4 Apr 2026 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cb6lh1Wb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EBIgZvN6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C525A2C6
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775336539; cv=none; b=G8fRLYdrUzWfBvbtA2oPfi1ogAVQ+UQALfFgjKei+uIjefp0TTY+velenHaJDyw7tVZ8rXcud8H/7hnncTNP6gmcK9maafv/U9KpZCtekXv19Li8W3/joahL/3AMaTS1B7LNm2EOr/CxPsjYPZbR6mgAIxlwCM/gnc6oVh6nWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775336539; c=relaxed/simple;
	bh=M+11Bqne1ZEbBP552q16E4pebXsWAs4LLI08kLq/vLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZAfL9xHHb4rfLbHqq+Yqt9VBL/scaVXvi8mlQZUbLgk28TeRdogYylImUtqiNfEB7HisaKUIKu8aGOsU2wk3cg0oiIWYTru6In8uxR3g6S2AaEBxkBwxTHcPS82jxipN8Qy5F7iQSPGUiinpi9EUfZidTC7Gvn7f9nEs5jKW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cb6lh1Wb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EBIgZvN6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344emPZ2974021
	for <netdev@vger.kernel.org>; Sat, 4 Apr 2026 21:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fPHbHTmrz5b69W2HbX81pMl0
	Mb3P+N1Jkbf+3Ti3CC4=; b=Cb6lh1WbqZF67viqKoBgkYUQW/wTrwHq3kSFBBW1
	fLrfpE5IJIPXqYdcrnR2/Z/Mb2+iGyq1zUtmwVWr4LMegpAfW/FgB5tEOZlPlPWq
	9roAlVL3QAFwv9ZSWgRCoakovk0mDIhY+yf/HLZBpy1C3JhQ4igu6ONHtueBo5de
	SBYNL8lvfg1/SmNiiBrGPRQx4PUsJ3kfEBwcikMArm1KG3P52ZKBzqnkbO4BCKzt
	AO/k9Zyt4iw/Y3cj/qKbA5Yi5KzP6UqQo4e9Z1t8xRKxubcffTt6C0ZW9XScq6IR
	w7kJVOO7BDaUodxyEXMcZnUK0kfVVl0pDvUsyi8ncAY3Ew==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dauth9d7t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 21:02:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5093b92f327so82521581cf.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775336536; x=1775941336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPHbHTmrz5b69W2HbX81pMl0Mb3P+N1Jkbf+3Ti3CC4=;
        b=EBIgZvN6k3Ewz20qlNCkNiRkMc26RzSYvB0FTzlrK75f8o4rEOP29oxwMWh4+GEw+t
         Sw1/X8BYQP79AKL0dX/hQej6pKS4YiJ3LsmXG0gg4bjZa1xvWP8Plh3+KS1O4pKRed9F
         eu4AQLSmZ1/UgOivGmWhL43i6Henz3EGIv5zF0m+1pcvhW53MvJU6WF+1sG4wpdEAst/
         c4s9GwMhPit/+3yx26zovUiyAuasAfV3/Dt/Fvrta2dgghBVXlpTW1s0x0lLnV2XCaIo
         XTjZTIAwO7Jyb3yPW+o16W1TDQWFb5uluT/VjZtpbqHX1+KzuuZBiX+DZYSNatenEOMK
         7eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775336536; x=1775941336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPHbHTmrz5b69W2HbX81pMl0Mb3P+N1Jkbf+3Ti3CC4=;
        b=SiulPN6D7DglYV62EqesT0fd6cUHOMXlY43e/3t21qZO6FaJWDkIQz7Fw5CfMuKk2G
         SIu1Hgiih6fFeYI8EPqytKfw0VvUEUH27Ai5ERkGd/WlvSj6wcp9EOPeibgTql1xOQi+
         c8HgyQ8/p49qfv0C6ezCoZDxgkaQMcxWk2lzi6GFP1684XailKcGYD4CUNfdcxRoDcOT
         AhXfUfEwCTyZttnpHU/msi6x34E3rZd4poLGth45J0RiLgV6lyl0esx0ijzlUzxqg/lm
         mUgLdA45IkRAPLosmizEFfrWAdA/9lOFmUQNT7gbF07Mo/It3Dc7x3c5MA1rRfaSUKnJ
         0O4g==
X-Forwarded-Encrypted: i=1; AJvYcCVrA4Vui1vaj3RCSF224EIQMGnPqL6W0DEomo4htNKs8vQg0VdhoXEjXbPpfQUUWWzNM970jOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx56akg8ve1jwxKvaHmpdnVTHCXxbdFx67Nt+oqb/OIvxd8XZDs
	n/TlbSLNlOGTOmoeI84W+j5wayUgCf3wpDrG3k2ANE6oJiZCP2vFKNLEUk0v7ONXeHtl5WHvSgc
	065VmoEohhkFeisyHpgdlsxrjeFGSlrbVuz6QZ+3dV+pjRFjegsiEAlMByVI=
X-Gm-Gg: AeBDiesmKawKadqhcqxAt5/3n74s3OH2vBkaGeiOXhKiKAUSElAzgfhLmLWPXIO5LAi
	DLhB/Ni44hrXXElJPC11GniJdc8ZGQhI95TdqafribuUUoPpAM2+09tVmOi5zgbHcKZ/uwhjrRg
	eXTiOzdJvryiOWtfP8uOx3cMyOJcCpqMeEjnJA7m5NKv4GeShsjmsEHOW7x/Yx3sFRtRi4JfHiE
	mplTkh7ur9BosxYkui7ZB/u3XvH5Cm67GY8Y8WKUMWHRKc8BGP+z7Vrqw+dttsKNGwxoN+jWdrk
	UfKewImODO2VdUusZwNu1MUQewi8pdgLI9K7L0fa80x4M0AlEEF42RBmbK7QJ1SdTyJr3u5fQ0A
	FSyGu0i3Yq7XdTOCLqZhKfxV4nGnd7LjZoJTsslhtrUHN638i89N+uRQj3/veDR9aPjBDYqLUzb
	+zBObUCZSQh4HfvPaGqenHkNp8Ix1H2BWV6IM=
X-Received: by 2002:a05:622a:4246:b0:509:44c3:5ffa with SMTP id d75a77b69052e-50d62b0a6d9mr116276411cf.52.1775336535677;
        Sat, 04 Apr 2026 14:02:15 -0700 (PDT)
X-Received: by 2002:a05:622a:4246:b0:509:44c3:5ffa with SMTP id d75a77b69052e-50d62b0a6d9mr116275831cf.52.1775336535152;
        Sat, 04 Apr 2026 14:02:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c95149sm2319838e87.5.2026.04.04.14.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 14:02:12 -0700 (PDT)
Date: Sun, 5 Apr 2026 00:02:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Martinz <amartinz@shift.eco>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        Petr Hodina <petr.hodina@protonmail.com>,
        biemster <l.j.beemster@gmail.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: sdm845-shift-axolotl: Correct
 touchscreen sleep state
Message-ID: <ehzmqowdrvzafwahiakegphhvdoewq7eag3obpozxr6xf336rr@skgsull5vtd6>
References: <20260403-oneplus-nfc-v3-0-fbdce57d63c1@ixit.cz>
 <20260403-oneplus-nfc-v3-3-fbdce57d63c1@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-oneplus-nfc-v3-3-fbdce57d63c1@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwMCBTYWx0ZWRfXxHrzgN/bsSDs
 1pdvck5xI1V3S+utMl6oMwBUqxqeOCvGdrvsJDHB6xXgi/Za3XK+vYTeqcRN3YPb7MZYYJ6MqQu
 JdzynsGRcSQkILQhVPCsMWXTUAaiMjAnTlDlvkMxVMBYjjhHEGYmSLsyKrKddDtOp8157cdreS6
 018wGRZ/zhU1Bvc3YBE0V83uW3+J1/PDJTQ4t+0C5ydV9GhKzlfZhQp3m5R83K29MV/CNm1VbtV
 Xc+aNgQQdbjHOz+dsPcen7XkblLq4zGx43o0idtJl8dzxO65RPDWb0tnDbjbI9OGp6qUr/tpXZT
 4qwjMKIhSQTDkOahf1w8JezHnocG4qkRbYi9VHCTtZQ6TdlRHnJyKXUfCIbtx9AMjpjM7q/xojQ
 QC7paAbRdNosAEDiC7BBLBZCYhbZhuQGPAgSKBau3qhu4ha58PdT5R0a/EqjN15XL/yVKdM1SyN
 iIhMPdoe9f26yNBU6vA==
X-Proofpoint-GUID: XcrPYlmYXviFx7hnRPQTw2xNaBk2v5PH
X-Authority-Analysis: v=2.4 cv=MIptWcZl c=1 sm=1 tr=0 ts=69d17c58 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=_gdz5gggCwxQTVruBwIA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: XcrPYlmYXviFx7hnRPQTw2xNaBk2v5PH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040200
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275404-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,shift.eco,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,shiftphones.com,protonmail.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ixit.cz:email,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D8C5D39C774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:58:48PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> There is no suspend state in the mainline kernel, use the sleep state
> intended for this purpose.
> 
> Fixes: 45882459159d ("arm64: dts: qcom: sdm845: add device tree for SHIFT6mq")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

