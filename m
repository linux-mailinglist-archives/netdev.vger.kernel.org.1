Return-Path: <netdev+bounces-265481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OAwH3uqrmntHQIAu9opvQ
	(envelope-from <netdev+bounces-265481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:09:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 218432379F4
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A62A301DB9B
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 11:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C97396D24;
	Mon,  9 Mar 2026 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PqCeTolU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RPh/Sy+i"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92742396B99
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054575; cv=none; b=RdjAmuAE47YyH1zuv8p/QhWRHYSSuBFq8kTVJ0ZUkjQJNmE5ZGE8OaR1a2izxqud6P1t5bH1+AZt5WJjGWJ5EGQ8YxhFWkaX0uNQ6rSyOlNMUdIvV+WZKjfiGgDC2TpmPVfV2SFssDOEEoVbJy/4uPpYvHm7xToUH0x3zFytmpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054575; c=relaxed/simple;
	bh=kXdAlIMWwWWj8alseEzHkxCbtrX3BttbUv0wSD5JaAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5GawAEnF2aEXq7YistnOto4bwOZGHy0j7raEeVwmYrZmtujZ94um7Lzq8OyKFjycqxYt6mD5qohgc+9pnBQpxCyBH0WkfQs//ZQcmk7e4lZFErNRlFC+BaV6Pz5mNDZ2GMDyLRpJ6JsgdC3xne9CFQUWxug8OTL7OpAb7najnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PqCeTolU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RPh/Sy+i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6299mh0q716509
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 11:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9GcFU1X0YgGaDvQY7T0H3DK5
	6rvaH9tLv7mLbV4BabU=; b=PqCeTolUyDUnfQtvNv37mNjqVxegnXKUYob3z2lG
	XphlgQjhQnMquTaJQt7KF2g+f5/98CZ3ail8ZOhukncqxq5WKInf2DZL9bnftxgK
	/FYGhtbpYUYQbYqm3EjwwYAMvrOu1i8U+leKtQFkxaUDN+aC1PDvV/qUzLX4k9ij
	wLYuk64n7KpwuMgkHC+219t+94GHSEewV+gh5CQRCnjiKdv0/E6b19TciOUlCtFR
	wxYLt6veXcikC7E483Dm35micc3IxfR3E46Up/kypL1+Dz4Hm2pbHv4b0uIlCnOI
	4oRIxavDO5KUbDFFXCQlzUd19z0kDB8yAeimdXmFgxkeXg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cr9qewewv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:09:33 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829c331b4c6so298063b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773054573; x=1773659373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9GcFU1X0YgGaDvQY7T0H3DK56rvaH9tLv7mLbV4BabU=;
        b=RPh/Sy+ifsfqLxRJf1a+srvi/3adq8HtRZHwLgN8j9K9IYi3uQLLLdvXIFEqA8U8I8
         Zed0N0frCO7O8sBjVTnDyRjEySTvR7MokMEVhbDxAdeoJQZG5RaT0LX3ajMxKbF5S/Ar
         MfMaQ6XOBlhUelvcWjNquVxfIMFi3qgg5yZTvqhdsIFLnvxsdQPOy1vAQX9Ug7vcwWN3
         v1bRNe+m+FUKcgKV8mK2eaGekFC7eqz8fylyDqorN0jvIvFg8OYQvLQ7nRo4E51l/JgY
         sG5Ykyt1OndFpyffPBeMbfYGtitgcGCnh9LjKVCmrpRwnplpTNK5NPPQVZSw916gpS9v
         /z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773054573; x=1773659373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GcFU1X0YgGaDvQY7T0H3DK56rvaH9tLv7mLbV4BabU=;
        b=MFsYAGaOxucH6PNB+iYbESILAMMB/fCnH+VqG1iKp86L3dbb2lBzlVtoKpTy/0oQMc
         plDnCPO/pXGYbeSPDVzUt8J+7KIJMauwZH4patyXVISy18T4+ZrE9A2CkZ6shlGYUQm5
         ca0Pcb7hOM0GwVuVlsx/wGNDkcPMDLcjYxSc0WgAopP9NddSfuOkprUfN1fcJNMEeIoa
         s3phXkn71PBSnD3vpdGzN+Y+lVtAWkcOouQggM81pUz0mfolWuvAHaHL1Dk6/GQMvTYp
         5u93GnWBann865A96lDJLQnKOhi7IbNLQzCq9NecAjC6DCwZZI/DGN+jLLgv1LdXrWYv
         A8hg==
X-Forwarded-Encrypted: i=1; AJvYcCV25uCALOlajuGIkkmmfVFudBxDl6zs2+RAEJ/tCQcUSHKZPcPKn3bdeO8fwqib8s18N6U/sec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuEoyvqI18qE6XPQp2zmiixn7dXMNhBB4my2AymVA1QwLrC+KY
	hGuuUYJAo4pVaBkzcotvSA79rosfmToGgF/38gJyRSQBrz1V1yuJbHbZtobsPyEvMHbyY9QF6SW
	aI0HhjxKoAhvBtRbNGWbO+iDXP9r9pvZQ9WgAI6oLg0SSS7+LKhm4qORsfTc=
X-Gm-Gg: ATEYQzzqoszxsWK3PEQeihtuzeilLBEILUi3xjPJBuxCeQrxiJXT92zlUz7gyfO08s0
	JeDlU+5TaMAyuBcbk9T+rj0aWlg03FuS6L8eI3tYkvo+97Wy8SRJ+7gKDUIvR5SZru4j2a4Axdt
	3CuBSg5uKLoYWy6K6Vdl/tEG9GUqX1Fa4PG3ec7I8z94TuaoKE6bmXcjN4g0isIcBY8k9tPn3kL
	X1LeTFWdlsOFm3O8rZ+f5OhJO+NlazOwZHvs4HcGfdugFMj4Y2Nvgyo2JCylmakTyEIv4KqCO3q
	/5PL8SH/66jwrTgcoXC+ttlbd151pEJcKHtMraQruTddLH7njjS4lOXE2/FrrgYt2GIGHU9AW5N
	b83n4SrXw5dDk8sAg+nAQTiSLqK47tdGBerM=
X-Received: by 2002:a05:6a00:3022:b0:829:8e38:65f with SMTP id d2e1a72fcca58-829a2db935amr9010418b3a.8.1773054573141;
        Mon, 09 Mar 2026 04:09:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:3022:b0:829:8e38:65f with SMTP id d2e1a72fcca58-829a2db935amr9010380b3a.8.1773054572661;
        Mon, 09 Mar 2026 04:09:32 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b6f7sm11967292b3a.23.2026.03.09.04.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:09:32 -0700 (PDT)
Date: Mon, 9 Mar 2026 16:39:22 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Frank Li <Frank.Li@nxp.com>,
        imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Jan Petrous <jan.petrous@oss.nxp.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
        Samuel Holland <samuel@sholland.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH net-next v2 2/7] net: stmmac: convert
 plat_stmmacenet_data booleans to type bool
Message-ID: <aa6qYo+1san7jL/7@oss.qualcomm.com>
References: <aa6VEsmBK-S9eNYU@shell.armlinux.org.uk>
 <E1vzX59-0000000CVs2-3MHc@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vzX59-0000000CVs2-3MHc@rmk-PC.armlinux.org.uk>
X-Proofpoint-ORIG-GUID: ZwyvKgnb-lfurkvRmnzXUctEbuA7uLRA
X-Proofpoint-GUID: ZwyvKgnb-lfurkvRmnzXUctEbuA7uLRA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEwMiBTYWx0ZWRfX9PUqjOye4Z9y
 6fVF3Ft50xQA7XHd87f3r5b2CFmQs+JUbfgbiwt4o86gwpFOXyphcnwt8eZXvRrchZmXvvlZX6D
 Mg3Rq3VfsBDsl+6kvuWjJ1k5EbdIZU+Y9c/1MVY/qlFoK0TzEH4vNctUj9ukuqCpqveX4LrqVvf
 dD0l2c10GSHwTXAfXtwazXEYwDrOTELDG8oSGhAFJKD183Ionht0ER8sNp2RrvaJDZNJaJeg+Ab
 V28k/3RIOHhDZnnl3Zsuqc2IWWXFzo9TzdgyNSO0GqJe/dPhu4OuofnprbPBr8o7UNLvOkTNCQ3
 qUi3YaTrBU8TiMOISy94ZoK4ql2pEU4JIaSWsKAw++b70xjFQG5zMHPUKIogyevoT/caiRPwMk1
 3K2fSl+W38+/8pl1dzv8KVAW0YkRCxp/38y48CfFSgC8xwTHP/n6lAc5+DCWWqukEcT8+wB5Pkw
 2R8Ox0j9R+w3DAz5mnQ==
X-Authority-Analysis: v=2.4 cv=dcqNHHXe c=1 sm=1 tr=0 ts=69aeaa6d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=91TNVAZHAA1vfZ95losA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090102
X-Rspamd-Queue-Id: 218432379F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265481-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,armlinux.org.uk:email];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:39:23AM +0000, Russell King (Oracle) wrote:
> Convert members of struct plat_stmmacenet_data that are booleans to
> type 'bool' and ensure their initialisers are true/false. Move the
> has_xxx for the GMAC cores together, and move the COE members to the
> end of the list of bool to avoid unused holes in the struct.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

