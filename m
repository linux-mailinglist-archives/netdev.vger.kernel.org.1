Return-Path: <netdev+bounces-296508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wvcQDE+rJmqBawIAu9opvQ
	(envelope-from <netdev+bounces-296508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:45:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99914655D03
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:45:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gyjq1X81;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=RcO5O9lG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296508-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296508-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C235301600C
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FCE36E478;
	Mon,  8 Jun 2026 11:45:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71A302146
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 11:45:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919107; cv=pass; b=i6PYyECzdaFJYrjOi9fYBsKrcRVNsEJjaTFJdB8WrgSyfbL1zed2meQtFTA6nb1V26gpO0YHpfBWJNTqKR2h56dAytiT+eCNsl1BnWtsqvPXa98JwS5/c5WH3Qe2tIjenuNikARSIR89ZBNCtau8++ujtR05v9d2RJeRhB4t++c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919107; c=relaxed/simple;
	bh=hhj8Vip6KRSgrU2uE5rO79Ldiak2Rlsg6Hs6C+XmYIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snwLzJE9GWJGyKVg7pdWLOl83e08BH5vaRLn9iwROmqiM3R69xKN8/RvKA4xbbMRp1tm0TcTEbV+Z95LqkKsPxzdlstBGbbYGUqT1tKIBlVDW+/MWnidB5ijngdufJaw4FcDjzgV1MFqQ26ebKh85heW71t1lMmvfJEcZO6gi74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gyjq1X81; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RcO5O9lG; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9K0X3029456
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 11:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=; b=gyjq1X81lQIRnvcO
	G1um2E6TV7hqmLL1Crrjwm5U2JX9LsLsEKMoBAB5r9dv+Re6mmmqF2N4BlWwnJWe
	WipwNPhnPDyTaQA1648cU+hTlv0M50/vvS6qQKzliDV+B0P+UasYAt4nGWww+/2V
	Jt2hVfesaJfjYeEx6LLpZB3Zd7kugW563Aw8AhYGU9FXuGT9sI2lmrgrxr4ipjYE
	RyrKH1rZFL3kTTJ+uQ3sF56wCseXRx5Ce/219eLO3wNRU5YKKduHHRQ7HWqC5dUT
	x7K2ybfU3hPnmKnk9GZzZSnL5s9fuvmjIHV2Ao63T44wc4jwbv7XlGhlcM4VQxJB
	Ow6dcA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun40d9k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 11:45:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9159bc52211so131283185a.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 04:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780919105; cv=none;
        d=google.com; s=arc-20240605;
        b=QbFS/m/aNB6bwcTmZ/+rj7tQztI+v+gB5rwEU7dHwyUB7RygdIR1Yk7rl0ma2/5UFO
         ntoJgbU/5lkSO+KEHZ2vTT/L7S8K8csDWjBGa4Kba5FbVc66JQxOex/AzUa8Cqcy/aI7
         Rp7ieB/O6/l107pEcE0LPlrZVkv/TuFCu3RJwM/QOy0EaCNb+oKKggZOHPpYRrKmKA2G
         8HYnz/vkq+DOs+2Q4jUTA3ZpXu+8JKgvrkI4xzELB5+vdRRDwrVXsr6n4jJtJ1zvI3K5
         oOjXdlrlWLIiQp9L5kN385ZMWFfC1TeKTw4ccmJr9WCar95/sCBTkkacKMZVuBhLQKCQ
         8l6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        fh=5wpG6q2c0BjNMQZOvxfhTtcQ7JOXkSE6c4wM80eRTsw=;
        b=P4dbhBdb0kNtTeBKkTWaBgf+JrRcmvVQq+JKHGq+wdPRmHloCbhVnOFHgrahpGM+uD
         6P2jH5laY0/DjSdvNqmWh0Z2u2iK36pODJJBiaeF1B6SVzsKHLBtKUfUeS/HB5Ni+Ip1
         5oQVq/TpvNI5OiHQbYcGPvOhDYgwg0DlgNialjybYGsUOKibCK1PeDdPqLEvZFtja2I3
         Fi78nN5o2qLfpKWSWsv1ZSDvVKCgelF0yOL6z2Ewsnlqsy+CEPpI5cZGNZjKJ6lc2rMw
         odpUDj/2FtxkJxEin0HzC9naa6fvihryH2SNCt2RirEL8y4Wt9XpVStYIhMVC97S2kye
         NStQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780919105; x=1781523905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        b=RcO5O9lGigUkcWBwngH5Wfra4pY3AIg683iEjDPu8iUitQvGL7OQVoChTSxOluDdJe
         +hSAORC1TWMgyB8XsS3ZAQFY7KgTWS5iYMxlK62hFqYhjc0ndnX9EaRRkcQijTqkY1r0
         YV1xsL0aKD023FfuillwZ3qcB9MvSonhseaSsiLWkScBlOaCA2s3mdI2kBvKree7hBwS
         zTCuF66jImfhEkiGIUv8P1cjypl2ziR+x80fXyxoz0Zm/Up+no+yC+OJn8FmtDHjGTql
         H6yt7tI8DTvpoPd8hNE1eRpZEjButzMMQak0CD/iP05MOo3AbN8OlKXglp+S8XyTSvw4
         wztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780919105; x=1781523905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        b=JVGxgqnGqt61Pt9hMdsbDM/05oGAYKbd+bGsW1JTTQDsWbTL4UZUgLySiuOI6RPQxY
         MaslvnWYlu65vFjvJ+e4eCtBtQA2KUV8WxSm2p3B4RuOMQS5W0fiotciy2EFRgO3r2Xr
         uvEjTkvq4Ok+ZX4Ap8V41H7g9lo3y2LaaNIwCvdYEMpv5EZT4njdvJR2vNoRIBcHts+h
         n+IhhkKn4F0YmqadJxCB/sb3DaseFaZxafvr+6OUgbWMXClKB2xo2UDB6JWqu8R52+NS
         adyGYyOi1qRA1eVUSCGxuJoA39BkSeGFaD2gXLkQYmfjoorB8ldaXsYRTcdztaPmNhXe
         bACw==
X-Forwarded-Encrypted: i=1; AFNElJ9SrIzgVYFao64lSjrYJmUtc04eRA59QFSpGNsedb1X7ImTpfbqGszQvYVEnJYoMHdxjd+CLqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9S6nBs26pTKM5YJFh+4FKFdYe3LYC+kffWrnLjl5ZuOmtl5TY
	KniMKGWCcEa6BZY7+06x2QNqjOctaFF6piWa+cWp4hGukKYVRqLewXPlr+IfzMkDGv/hIpcAWaw
	3y0zYlgtbqVapr/25TDoLhv6pli+EwWGs+nf3f1ktNnSTZ2pGljVQyJJunvQ0oKxJSf6/8KBKgY
	5lMLN98XLXoqHbNl7ZaD3XuZntd0HA3z/IjQ==
X-Gm-Gg: Acq92OFl3Jly5dpNX5NDvDehHi9EnQDnzA0yk2u9MSO3JitrUnnD9Qb7kBT0tKLFVnb
	GFr4l8vwBgoezBsdzzwr5D8vkKypzhuNvGnNhkuhEg1+AoIeu2DOCcLc3hoxYBn/ikqaSOQbXud
	+SJo5D3JcsUpQCTFCf2IubKfk5GT4Ue5GtB/HiKZTIuxk+fBDPKcTdnHx4/kRbfLHqH4YguwtSQ
	5VGXCdY3Qo2R2dmFccC77WNFSb6m7hYConUncWMvwtqFuDun+38NrmOvsY/za2vo+dTGqMkSGcC
	byS3t/6yrDync+AWtpRZ81Gt3H+saq69
X-Received: by 2002:a05:620a:170c:b0:915:8f76:8005 with SMTP id af79cd13be357-915a9dc9a4emr2367275085a.47.1780919104826;
        Mon, 08 Jun 2026 04:45:04 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:915:8f76:8005 with SMTP id
 af79cd13be357-915a9dc9a4emr2367267185a.47.1780919104401; Mon, 08 Jun 2026
 04:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
 <20260608-block-as-nvmem-v3-7-82681f50aa35@oss.qualcomm.com> <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
In-Reply-To: <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 13:44:53 +0200
X-Gm-Features: AVVi8CcIivK2P5dE8YRtSTP_9u8m9dGK-3gXU3su59C5FvR4dQPnW2soKiKG5MQ
Message-ID: <CAFEp6-0u1DBhXo9DCie5HCGTjcduWcHAiifVo88vFJwjYcjCog@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExMCBTYWx0ZWRfX5Hr67lNXCxFA
 JhF90HlBWxc4xy1x8mIUe/aE6a3eAjit9/0+xN9Q4/hmv7H+ScyFogwtVTW+XESxLQLaIgbFPXb
 yCZaE5A/jlcEa4VVgY5y7xNgTMO6IU381v1vvLdqou0xKimaleD7suBuolrgqYXWpOtNBb+2tKh
 h7u0elLhedgosWUWTQOqahyhezVKoWaEgaSLiAf5QZOJ5IIYTnUokQdcqsVJQvZxxuv2AeE3Eeq
 HIQMPEjUHficBVEGncVQwteTp34abfRyDPQkMkCkF+HA6+xh8NzXivWKl9/O5m8ruqHPC2Q78K0
 6UvdtYVAhnKRgkrylZI+4iZHjbg6jmjjNEDxmk40dbv+H1BmUVSQhAdcOkaI4+9vVx9Xk1o3Rdk
 Y8OSEf+IR1l0SZWl1JQRbBAg5p1qdp1xaYtEvdebad1mhAxGLG1ouaWpEGcQ7V7CSwV7AAK7m5l
 CQMo2c0HuUBf0+YQ21A==
X-Proofpoint-ORIG-GUID: tXmVLgHoczQupm0scVfPqM9hQsmJPIqn
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26ab41 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=4LeufcCx7mgyzPUJGOcA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: tXmVLgHoczQupm0scVfPqM9hQsmJPIqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080110
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296508-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk,vger.kernel.org,lists.infradead.org,makrotopia.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99914655D03

On Mon, Jun 8, 2026 at 1:29=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 6/8/26 12:50 PM, Loic Poulain wrote:
> > When the controller BD address is invalid (zero or default),
> > set the NVMEM quirks to allow retrieving the address from a
> > 'local-bd-address' NVMEM cell. The BD address is often stored
> > alongside the WiFi MAC address in big-endian format, so also
> > set the big-endian quirk.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++=
++++++++
> >  drivers/bluetooth/btqca.c                          |  5 ++-
>
> Squash mistake?

Indeed, thanks Konrad.

