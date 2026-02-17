Return-Path: <netdev+bounces-259134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPOELte4lGlmHQIAu9opvQ
	(envelope-from <netdev+bounces-259134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:52:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3624D14F5E6
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41842303E3BF
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9641B37105D;
	Tue, 17 Feb 2026 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IpcZoKPl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GLp+xZ+j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E762372B59
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354306; cv=none; b=KOxObbHO4rWkQ2kaKFfsQ+070Cqp9yUu//BQ2eaBTIgufkeZ6sy8kV0Z5YXOBC1LDSjj0WHt1zW1YpvZ4LRXuKhdT+iQrEwSkUvyKkUuiLrg7Xa34j3c7zLKW7rO3qp5cNZzjcMchBe9UG+KShWxlu10slwQpNne32J84aU2kjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354306; c=relaxed/simple;
	bh=J/2e6aQGmdZUHqj41Iz9vGqTt+mvLf1V3psejJ5P8ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb4/+T2uQ4VmAm1CdoiODQbv10Cs6mdEVMCt1ncTWDR3o+fz+vHtNcsITqsDtHTgyPHP2aD/Ox6p0WRFvkWvZT+FRzsuuYRvQu6c1QgtaY+uaUk85x1NO2tFBJX4vg4fbWLodPvJCt9mnXtxyVuXQpX3vRIFT5UfaEX5B1swypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IpcZoKPl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GLp+xZ+j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGraCa985305
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gpHs+q5sc2ESyRXoe6yeXOmM
	BULgitSi7HAS3517law=; b=IpcZoKPlwXP+qSoGmhgA7aZ52B1WDxH60u2yqNm+
	a5XxCGsJPgPhfqBPTXWf7qOlgQuVwrPxC4KfNYzmebtTVsM0jTq0mvnvTl3y/f/l
	6v2h3wLnFDfuhLBvv9e9l1v5GYpyBLRSussMg7oMIV6Du0nO1tQ472vJygiK67R5
	P0kLbqvSLaQcGAaOkSexpBhyRexouLT8bBsqxmA+q/aCA30GQZ+4pBiBIuTqjQk1
	EznJTER67p2oqpav6zrzwHrh3M0d0iT78Ytmoy/JhqgeRF3QtswLNt1i4k63rG2N
	Lhi3X6WzeE+BEFGXcEhHliUAmSdscI4qSswmFpqCrBBvlQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ap3etq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:51:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6e18ade2c2so3175448a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771354304; x=1771959104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpHs+q5sc2ESyRXoe6yeXOmMBULgitSi7HAS3517law=;
        b=GLp+xZ+jcm01hVYidOGP1xkJ7hqSmQPVpmL92fqdpNMAJ8kEJe0sV+Kmm+0VgLMcRk
         Xzr8/jfYmCgiZSXUPscSu9w7ay/hJMMOrMZHkCctWE6SPisyIlSS3ViWWTNZVkwDz1G0
         zO95Rb97OXGiR5CNrZOjGwew+iBQuRID2PpB+Rq9z0OVxdFAXTbVSOQ7oKzhhWUNh09A
         KP2xOnNhXCMT81j0NGVgWyHMJ0Df9Q+CSTIadE6GbDTZygbGWGQGQcBpjCuUm3jbQhh+
         b6OC4ZJ1qCbGNkY5GkLcZutUl/I0JN9pHIOBTkxZyhhsQWEBzNslZf2Z5WHrL1TheLj0
         D6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771354304; x=1771959104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpHs+q5sc2ESyRXoe6yeXOmMBULgitSi7HAS3517law=;
        b=o1uzDR1uTH6XishA5Gz3KxOFGv6qjUg4+h0UF2I5ESHe51YAIgcaDoDs8O+9mJ+915
         ooJJJSFo04zEGIeA6NLzCeNIk9LRXh+8BUJCqZwe9VsIxx3fC/g57GlxCuP89B4J4B5I
         NF8TbPgjTUW3L74YFjTESEnlcY7KrH9/7eWjvUdglFjNfvNXA76Gzn6uApmx7LUdLbiD
         MPt/hzzhM+83d/J8MZdlu+3hjgMhA/NqbglLRU0pnDb1mL2aF3uGx5lWC0mnXTVqWXwj
         dZk2iTKyG8tzeWBqTnGQrZ8UiQ30GTfsbcseo/M5b36YxbIxKdcECcig/s38yx/SYgwS
         nweA==
X-Forwarded-Encrypted: i=1; AJvYcCXuAS3RB3ouAFZg2AA5hI/sRJZ2o6GdYVIqvLQeV5ujoHrB7EcEgNNvf3g52QIg3g5FSYJZFxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoEvZU2ImrM6wLIqG5z+MTJ7F2LxXCqVbSGJb0gCDSvjQ1NrvU
	4RgnZRq3KDwcTykiN6Q0joKufxb1a69W3+bHm62Wq5roE9m7+Of75stv2hNx4IJAbKaTn6j4LU5
	6kcS8z86CEOtmSrxShze2lbySO0Vsv1i3B2LGbZi9z2+5jKZvBeEzZ1XLqRc=
X-Gm-Gg: AZuq6aKGYRn8Z30cLAsNpkqpHKx6Mk0+qXQnaiPMbC43W9VYgPKwpP+k59hIUcO+1MH
	cWHv0Iv7FJWWSy3F/+bV5oI+pCxTdAoX+SkQqcbw+MKjKTIfYCz6tKFa+rtGzlTdXqDWRxm84QP
	oa1vqGA0Xppkj/X7aWiPWKOArhu6NvSDtydz7i34DRkzp34X+3wckK4swgFFzDeI3mx7R3fRDar
	NrMcrzrKvPIFHkGEfN1fafpkOD4/ilE3+r3jUJaFt6p/4YxCa3rVFbvFa/mczLwkJNomEJHPRlD
	MQ+czxQIGJUkWssEiBoN9Mu1qCnbzdSjkQQLXKrVjGFlTq66jxsl9j0s1N1y8hFq0vKCmJmHD7f
	64eVEX+RVXqn8ITiKLG/+uEcLl8/wvAfGT18=
X-Received: by 2002:a17:90a:e70d:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-356aaa98b25mr12221102a91.7.1771354303843;
        Tue, 17 Feb 2026 10:51:43 -0800 (PST)
X-Received: by 2002:a17:90a:e70d:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-356aaa98b25mr12221081a91.7.1771354303326;
        Tue, 17 Feb 2026 10:51:43 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567ebc4331sm19801025a91.16.2026.02.17.10.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:51:42 -0800 (PST)
Date: Wed, 18 Feb 2026 00:21:35 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next v2 02/14] net: stmmac: qcom-ethqos: convert to
 set_clk_tx_rate() method
Message-ID: <aZS4t5Uf21PTOQA7@oss.qualcomm.com>
References: <aXNEwBW3OA1xLEUj@shell.armlinux.org.uk>
 <E1vjDr6-00000005fQ9-3RUD@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vjDr6-00000005fQ9-3RUD@rmk-PC.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1NCBTYWx0ZWRfX9oQvNpMfsl1K
 O/A1LugnDv1oi/Y4NVVO5eTLkuufConji3vwfhGMbPs42N2rbe5eVhnEz0oHk/c4Ma2ezGHd+3n
 1x/FOnK0trXaS5Z9Lq8XKV9KSIs+w2/xBPsTkHpg1fJdTcOXQwB+CI0X7ez8FEmpuKqTggjg1CQ
 OEQMUhGsz85d19Kn0bO9EXtbBkJm6vfCVrHGXFwdxtjO9FfdvpR3edtY0bZKlLP0v2eRt2/f9ZC
 9xrU4qRSzoYkA90eA5GERbDOv1FamGChkJiZ5kFGx6i/F9VW0xq8FOpGXFkg2Q4HBbQgLdJSo+n
 F37y4qKsBe5V4BqdMs1re88uR5vonp2leMNAqAGnmORN6GW6f2PBL1bxYvzn/5ASM95pUKZEKcY
 bKqjgejxqIJRQGUthl/Jdph4Apg0lCEEE9M+pq1SJ3vodL7pbjSb9fYwmIPSAwcMACagnUPC0jT
 E/71QhXdp7XAXNFnijg==
X-Proofpoint-ORIG-GUID: W5jiWgyO9ggSpN5kWBm7Tiy_P-2fX8Xy
X-Proofpoint-GUID: W5jiWgyO9ggSpN5kWBm7Tiy_P-2fX8Xy
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=6994b8c0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PHq6YzTAAAAA:8 a=UutzXAvyMBxkWM3TwEQA:9
 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170154
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259134-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,bootlin.com,linaro.org,redhat.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,armlinux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3624D14F5E6
X-Rspamd-Action: no action

Hello Russell,

On Fri, Jan 23, 2026 at 09:53:28AM +0000, Russell King (Oracle) wrote:
> Set the RGMII link clock using the set_clk_tx_rate() method rather than
> coding it into the .fix_mac_speed() method. This simplifies ethqos's
> ethqos_fix_mac_speed().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

No issues found when I tested this patch along with "net: stmmac:
qcom-ethqos: cleanups and re-organise SerDes handling" on the QCS615
Ride board with the KSZ9031 RGMII PHY (see [0][1]).

Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan
---
[0] https://lore.kernel.org/netdev/20250819-qcs615_eth-v4-6-5050ed3402cb@oss.qualcomm.com/t/#ma85cac924488d580b971e6477e7df30dc7e48045
[1] Ethernet is not yet enabled for this board in the upstream kernel.
    The changes from [0] were applied locally to test this series. I am
    trying to figure out how the board deals with RGMII delays so that I
    can revive the series.


