Return-Path: <netdev+bounces-304570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MRzyBwDER2rgewAAu9opvQ
	(envelope-from <netdev+bounces-304570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:15:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E22A703547
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:15:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=m3ZeXph0;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MfzaYzDX;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304570-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304570-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36390302ED4C
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1D3F39CA;
	Fri,  3 Jul 2026 13:45:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E63EDACE
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 13:45:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086349; cv=none; b=fU+jpQ2akgYbJaUlizDmm0XXQ/gbUm3gFNfZ0AK2qEMpTraOTIkCQS+1JDlalffCGC4vniAcsqo70t5YB40UbAR7/WJsV85iJLD7HRvStIedqWjudAl+KOPVXsyKQJsRRxFmmM9Go38FDhqb7CIOrZTrNErrZTr1xrIMpVdjyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086349; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LyD7QCQfmZcMEC0+V6ozi3+oXO2jscagMDRcb7d7880OGBIOSwbDuTiA3vKQAOKZKydk1kioRc5PanJ/TbN9l+m38eGjd3gvTaQxVEZcZRNgE6cPj+Aj8oeLwzXy+G/I4t9eMKyydgTi18Ct2qoVGMv5KS38W6x/lGZXI8qMk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m3ZeXph0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MfzaYzDX; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6637Zo3I3410192
	for <netdev@vger.kernel.org>; Fri, 3 Jul 2026 13:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=m3ZeXph0qWHngde4
	cyKZge+jjCK5fC4rR9gZXCNMwv//46MvW0g5T3GTreKkoX81ZKjiGv2oAyBuI3J8
	AWDZ7yFrfxrLeyTltJ6MAyeFz1owlPAK3WMFy1/csjR+M6n+ZtfDY620VL38nM2h
	dJzUsWvGIC8BIEz8vc5uDQBGjV449EYxd1mORNaVVPAgD7kyEmii7WOT6T9SJhFF
	Iqhv18Qe4JGzwPqYT5En9tvzwEm++OlruahreWLUcXWodo6IduWS6YXkoMYvuwbf
	uX59OIdL1VpqYEIRfNysL+zWXfKlJDhp6F4c49B1EP5NfVFsPBai7e+vDDgF4gD9
	qOUvdw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u31c9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 13:45:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e3ae05d649so7106026d6.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086346; x=1783691146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=MfzaYzDXh/mKrdEJnjOkXdyXxAVCSWQr34fv6GSTJAx3m1PEV+q9LDmM3roX9QEO+r
         Wr21a4BGCMajbUdW2UCj6gSvDlyh+T5vkoAsIOtIZ1sGLmT1PsYIlPt5WYZIZwj/e11D
         DdxSxo2J4PMotXmvXEDSV8O6XESSsHyTnX5oLNOsTHe0bx4UrUTjShLNwyHwPa78a3++
         pXOWRxdXtYawCHYswASLApm7Km39Onblk9K60wKcGRj5Ft1FWKis7UDQfZWbGYaMs7/X
         rSGuv/0pwWvia8dn1Q/MRwQcfAg+Xg79Z3acLyzdd2FlYzmZyXwSgjYAwQoQM0iQK63H
         dhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086346; x=1783691146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=a86urdKmKDr86dBDlKyfiBFFIj78dBXigiLj6z8Z10JFcjQ96AGQ2Aj/lJSejSMY8Q
         1a1IVkzcnsYmKcJ51KKyqtMjGL6Yf2VLRrefe9Aw/okFDAMcLgvJSF/LVMp9q1S0wjXE
         KUuThBSbDZFHNf26O4aVLjT+jGSY7rkP8ZB8J5Df9+1DPz9H3ksMDAI7vjyLH4ZcHbal
         VMeaPOrg70tsowlJEPYfRgBLUiyMIbWWI6hIYS2t2X51zLrnzLVPdLxybuYi3BMiqb73
         VzN9U7ssDHNywoLyJC+DUCCFsBRMTOvJuAEEfpmYwBDI+MoZemAkUUTGkPY3w10+Gnfw
         wa2g==
X-Forwarded-Encrypted: i=1; AFNElJ/S9DInZRrS8S3tXOgOrvlzJPYYpjVGvYLoDU8egKQOMzo8kEYM9YVp4KNOd4XnFkAnz4KQGRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJHB+Z3okNfGPubfStvGvzHE10bZ/Iax6gh+hxm5U3wzwTb26
	Bbby/3wFO1b74JEzuxAC+tcvSdEhR5RlMRRTb+gUN+11+3CaJbBDBaMASlnCy9JgF8k1kIs9I1X
	0I1rsJJYYOaCAgoJL4qHYtTjuGepw1TPton4w76dszKehTfZJ/g+l94OejRk=
X-Gm-Gg: AfdE7clrF+0hUSGntZDNYoioegsBI0n4gXqSPmOOzY4+kOsL2tEFBjxlvdPbhOwkuOk
	7ZZD/bxpT6+aFKecI4mVt75f0ICo9iOfCnH/QdnvDpvNAlHJF6W7CdL5ni+dAPNLqo0GU6h4mF9
	65oaQe1Ymb2HF2t3sCOJ6Y4Y0E+fk8FlB/XQ2qk7K1rjvdF0Y/GsJ3gq1KMFNqQZHThJLXB1Aeu
	uPxa9kD50xbzaONonKtjpTBhHS0KKeJZmHMmtwAxsAedabJyzAEQC+756hxfYFJAuCZDdDoxKKO
	QTLyrHKTbJZm+/gufz2FFeagvSKuKJccjWQkjRaL8Jb3aXriVAOkBSWa7Mhu08B+AeR39ADmI5e
	gvQYCysUETG7UMGZaXXvKhxwdQW9acvQoXqEWtqhH4Coq389AAHNd1nzhafDCTI1W35OdOjJ+QP
	BBkfPILx7g6BynJ/4ruiN0cOnWRd8Zl5On6zVl+6jTEykblM3TUQPYC2aGBmBNtKI=
X-Received: by 2002:a05:620a:3186:b0:914:d093:abbe with SMTP id af79cd13be357-92e781d3eb5mr1407962585a.12.1783086345759;
        Fri, 03 Jul 2026 06:45:45 -0700 (PDT)
X-Received: by 2002:a05:620a:3186:b0:914:d093:abbe with SMTP id af79cd13be357-92e781d3eb5mr1407952085a.12.1783086345170;
        Fri, 03 Jul 2026 06:45:45 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:44 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:22 +0200
Subject: [PATCH v8 9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-9-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: -uMKA1Zp0XuzLZBYoAcPDUNGiAjHa8_F
X-Proofpoint-ORIG-GUID: -uMKA1Zp0XuzLZBYoAcPDUNGiAjHa8_F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX+ir3lbFW/2Pt
 CG46M2J7r4GOh1LvjaBOZlQokCWNb7nwxhDWcVXYPM9cxXGzsGMjp2FhfBJWnmu8fSk/rWmx7aQ
 3Oir0lh4md1+reURecKqqmMdKkursfI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXy3iL0lRbdacC
 rmUpEU59NFGUA9gl2EKQbqIeMdgiSCaE98TfHxMuoCvXivIyX3JEeTxA9SUO4399kxtP7far3tt
 4WOzqzg87uN6TSb80lfwZLHmINYCEF5p7Gyue6ZUNlCT4jm4lt5oG6F/8BgVqbL0mBXS3xRNEJs
 PWRAUP0aEDvJsf5grVQkD2wM93Epr3v/hxvUOjA34cpuRZUGpwy05yZ262QJUcgw8o1Gwd2r1/C
 S0g+zGlARQUrDxtPC7cBMBFcPlRzBBSdhTgjd8ueYlp1e4FVxLcMi6ZjYETjzchQfZKFY9BXnd7
 7IzQknE5odRMhd9/elFV8cnmaVXS2ZJ9E+J01rERrhvfT/nEmhjtKuBIiwhk0K94SJKO01FNvwt
 OUFGAOXV4htBEKvWrsOZ+z0wqWWpftBwKOwN18LbFpmCgNdq6iyRDwNYXru61NQf17N67oW7BNc
 KAr2aIcVj7w02wBhx9A==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a47bd0b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030135
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
	TAGGED_FROM(0.00)[bounces-304570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel
 .org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: 6E22A703547

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are relatively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and Bluetooth
addresses, and point the WiFi and Bluetooth nodes to the appropriate
NVMEM cells to retrieve them.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..38839b8a361e76f6c1989924b16095b9d8815f66 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,33 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wifi_mac_addr: mac-addr@4400 {
+				compatible = "mac-base";
+				reg = <0x4400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			bd_addr: bd-addr@5400 {
+				compatible = "mac-base";
+				reg = <0x5400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +538,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +586,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1


