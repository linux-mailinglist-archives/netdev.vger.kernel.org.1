Return-Path: <netdev+bounces-259127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ig7FGe1lGlbGgIAu9opvQ
	(envelope-from <netdev+bounces-259127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:37:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7208C14F392
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1190E30000B9
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A546372B31;
	Tue, 17 Feb 2026 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFB0OLP/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D0y4vzuv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0187B36F409
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353441; cv=none; b=QZfujApRQVxaxrzVWqH2D+XpJxqzBFFZXHBMHvWAnAJSPaU78e+8uFDTLWKl7RX1/ITtM0m+b7cgCHJs3x7b6jJlPENCBn0rCXxvWt7cA13RnhMjf/P1lGanYmeq0amJEjRc7txBZdVLjz+oHUj0E93HPNHPD9YdHxAIqFzRs0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353441; c=relaxed/simple;
	bh=xn1qa9Wzq30aeozYIZEjQOWZY7YneM3h7/bNRTwQFiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLG85SJwmLYtBbE8KvgcKPlCBi4SMLSVZlQyC4J9yx5nar6cYRD2fUzL7abQRtBGvQR2LeQxpUzYKN0cv+9AhlNQP8UzNZNqKew1ls5OkT2b34+ye1hMcETov8n5J3XYbb9FSJq3slP8qDX4s6wJwViGJcWoElgV9ws/4V0c3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFB0OLP/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D0y4vzuv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HB3l901943250
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1QmuUCEZrBFNgSu7w6yY93qG
	dfCy2AGpXr9u+0yhsQM=; b=dFB0OLP/P2Zw+1rUZLCk+oVjBbPLZfNVad5hyE30
	3eyHyd594rlb+oaHi0wm3ZIT2iPUdiV/Kn1AzykObKvntO5Et9uTUkDTfMz4YGsC
	hC7sUFSRE5FVE0ZhHQlP1NrT7TD+Y3dBzCGNcMqx5E3eQgKjd3KVh6OHmKN9Pf2n
	tDSkPmxLGeNfuUh5NyYs4pt0AeXPWzQ9DH6SALarPo14S98LmrUqi5xwBlPdEUe8
	k3SRvDf9AAL/7qq5iRt8o4gdOHSeS0V8laEZS+30ov6ggr+YZmoaQHEbA3Tdfhh9
	UhGrYkpQPsoHnT2Fmr8uXt/9Dw2A3TFWtNCav7JwRIgDMg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccq4g1f31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:37:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a7b7f04a11so240833055ad.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771353438; x=1771958238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1QmuUCEZrBFNgSu7w6yY93qGdfCy2AGpXr9u+0yhsQM=;
        b=D0y4vzuvCkwnXY0x1Eqghy/bCWpJUMTXdfObfGAnQht1BLozVPIqIbzMrFq+L9g7dJ
         FrxUUHhqL57iTUQq3Nb/rt7Tssz3/fKv/fSTahrb87FGtEkKbqySvHQ1NwJlqi5lkuXQ
         uUu6kP1QoZWx4A3RPR9lx7J2mYvmJeUOr3ToSetPyUJ5Y+PMbKfFJ/WlIOkSsSNTLxsH
         69I/P8EVUqwGWl6rQepDFwhHRuiJ1Y6MO2NHZo6dcPChvBYUjwn2i6DPAxCjWFzNuPnw
         e9H1eN4L5suCy+bZ6CC2S2fRCAjKlSc/938Q0LKPbf/QAwPt5VCGuiGdtcsIZwxu9iHi
         MVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353438; x=1771958238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QmuUCEZrBFNgSu7w6yY93qGdfCy2AGpXr9u+0yhsQM=;
        b=LLetA8X17bL4X9se/SyWazfwetAZaAyy3Dac11kewue5kVTfyEBgkrYZ6s6zSjj06G
         JgEXbq9MABwC/4R+j9B5fXSmlqZxsQyOuunQrfO3zG7ISYgqzZpifX9kBiET/18b6yVd
         rkiaF9wcgONy191UQPaVGwggrIsHC3qp6Bu2o4bwNYDX+y/AY/IRz9ISs0/hvQ/G695l
         FA0s1G3Mj5xopZnXWtc7iTj5AmDosf345O1jUVoTxeJ1RtPe0ECLcxe0As8oA8dQ6Tkn
         q7FMeRBYkNiHaBm58OY1IzFwW8tJD5odybG01NTY9POhOm+eMYMq77+OrYcx4PKtm2xT
         tJbg==
X-Forwarded-Encrypted: i=1; AJvYcCXUguBbLAss53JTGyiK9E3qfH94ahg2jm9NS7FcjI+LAA9JP2c7vvBaYMJ+vzeS9lupSOW8tLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1T6QKk4f/zLKMYxVRDWkEAZiG0K5RUQy+AlgDEjQG1xR9h29s
	Y2STIk900a5WHSH4NSteKw4xkwqxUjwDnWFT/Hl3yP2jGwMkaU5cPfOTEWwFgSW1M1AUQaYHt4b
	EsGxtbcdlwS9GQ8gw5zM4LxdO5xXR4yfcV8cRouSAHcVz5B0j+jFETRw+ekM=
X-Gm-Gg: AZuq6aKYUjpiCRkJQCwCQ0MrDoQVDw99LQiHLNOz8mheXqYVSw+4qHKOzu68iQ6JsEN
	XDQoGv05demMGpd/yxCKHQLDvVxeKJ4Ip8XX4xfkZo//NVC2JPO8YmdyP1HvHzxVb66MK4296ZO
	QGiD3FMIpPSUvWKMsPUrJ9fx8YdwaOOUTiV4PZfALCePI7rqThJj8ZI8DuwNc6AD9fpL9kYpXgJ
	3xAASv0P33vyJAuDlN6196zAYcDFXxH7gYR8a9StdaS0aUJDBDp6teTvK+Qxhk74Cz4IoaV3nOg
	iz4sycQgWp/9GOOKVQRVVY2+X/pWwjyJPiSctq25+WL2etudjww/RNL5BBeXJwKR1+fciEahMYi
	Ik+nwkqdaS7IxUlTelejUgADZUJlCfTeId0s=
X-Received: by 2002:a17:902:fc4f:b0:2a9:6414:71a4 with SMTP id d9443c01a7336-2ab505146femr151882815ad.16.1771353437898;
        Tue, 17 Feb 2026 10:37:17 -0800 (PST)
X-Received: by 2002:a17:902:fc4f:b0:2a9:6414:71a4 with SMTP id d9443c01a7336-2ab505146femr151882425ad.16.1771353437289;
        Tue, 17 Feb 2026 10:37:17 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a738220sm110424095ad.37.2026.02.17.10.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:37:16 -0800 (PST)
Date: Wed, 18 Feb 2026 00:07:10 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Frank Li <Frank.Li@nxp.com>,
        imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next 4/9] net: stmmac: qcom-ethqos: move
 qcom_ethqos_set_sgmii_loopback() up
Message-ID: <aZS1ViyPMUmk/+IH@oss.qualcomm.com>
References: <aY0aJppQWUC52OUq@shell.armlinux.org.uk>
 <E1vqKPB-000000093mT-1lwv@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vqKPB-000000093mT-1lwv@rmk-PC.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1MiBTYWx0ZWRfX7BwH/QKYOzeY
 4pbfF1i/k1OMiwnekkd2QFzZTArSseysYPjMcFNJutcFShjs1Ohn7ALsfmTbU80FWYTEtr05tz1
 aO9f/3evTGK24aiGaXp/Df+K/RwMXKsXklK6EIpKd2sEcbsVNl4KHfMzBxHcVP4nWI6R9NPmdJE
 KhKdH1YMW4erjTh5+NMsEr84J51prwmy5FhxkkOrW+3S9XMX/3kR4gFuD/t+oOCSw7ayENEf1LD
 go3/Kv6oB+JYAAUXLLwo1rOgySfF7psOZnE0n27I+fo/DVYjc/AANMe0DWp23edc0Xj+4L1Gd2h
 kjJLqQOIQS9Ed51TY12pvdDUSfEDna+4TpCWb0tIJxJkj/PRHlMbn4X1NlP8lt/IG9zOCzsHXon
 +XpUHkeJhAq1/acb5ffed6hsyh3KrHhTrWS1T4IOfNNg+C0CWhYm7y5SPIxd5tI+71d9zMfZlR5
 mc3W+vThqzKNzOiue4A==
X-Proofpoint-ORIG-GUID: dzfDAZoCKmG-C4bBF7Yj1rbTjMN8JJoc
X-Proofpoint-GUID: dzfDAZoCKmG-C4bBF7Yj1rbTjMN8JJoc
X-Authority-Analysis: v=2.4 cv=YdiwJgRf c=1 sm=1 tr=0 ts=6994b55e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=PQJxtWgwoR3tQ6wQTWQA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259127-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,armlinux.org.uk:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7208C14F392
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:18:01AM +0000, Russell King (Oracle) wrote:
> ethqos_set_func_clk_en() configures both SGMII loopback and the RGMII
> functional clock setting. qcom_ethqos_set_sgmii_loopback() is only
> called from within ethqos_set_func_clk_en(), and checks for
> PHY_INTERFACE_MODE_2500BASEX.
> 
> Move qcom_ethqos_set_sgmii_loopback() to the callers of
> ethqos_set_func_clk_en() except for ethqos_configure_rgmii() where we
> know that ethqos->phy_mode will not be PHY_INTERFACE_MODE_2500BASEX.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

