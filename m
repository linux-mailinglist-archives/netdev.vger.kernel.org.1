Return-Path: <netdev+bounces-186716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A90E8AA0801
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C7E46261D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18352BE7C3;
	Tue, 29 Apr 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="0JOzSXfq"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531D22E40E;
	Tue, 29 Apr 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921114; cv=none; b=mwbE4i6VW36ff868XkWXUFNFWjIw2f64c7f0KDOd3D0EaEoBB4lD01UV0YmTaYWDpopHGimM5YBMBkwKqitmuQbnjx/lERuNoazczkM/3Kil8eR10KH1unoLZvjstO95hGBmktpwWOhoqc7fWQLvks4hBW8N2dcSPmQjau43KE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921114; c=relaxed/simple;
	bh=oT8jmdKRD53dK1OsOJGBSBEwoTPzjwLFCjZkXjFpL0w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YKiwEsEavb/7yNVRdlhOoG6hZfeImuSLL++hPIzI1DiI63xnJhsR3wXwKVFEzfxzp509ykHLaxp0ZVD8SErOWJn0l27XAAFcZilLI/tuDq3pb0Rqx/uYPzLclQCVEkDOrFRzwl0Ej+seJZs42JxdK2JKItuyWTlM1+5YXl6vbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=0JOzSXfq; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oT8jmdKRD53dK1OsOJGBSBEwoTPzjwLFCjZkXjFpL0w=; b=0JOzSXfqdcMYGwC0bPRPLnnAcf
	PCwW6kpNicsWBKSdKcaD29OYqQG3kreVd+vU8ncE8bDZufHD3/huCJRuajpikIbr/zacfgk6YYDv6
	Yg34PKJjMp2V3I5yNfTcd8VRGbhf13g3JMoHcy6p6vHXNh2b/MPs9ZR7v9ZGS6hZXALr8xT3Boloe
	vvAi3f3QXTgo3UWC8xw/FAd/Zfi3rWyPp24XIfWiNEtZZdOpPdaHcjhFPKEcmnXDD10H6g45EG9Uo
	usiMcM79UHCrk8AOuBNWRit2KTMmiFiwu1pLlK/+PwBEuLr3vb2slyshnWvu/GCbqjfooCLz00Xvg
	Sw+o+dVQ==;
Received: from [122.175.9.182] (port=32794 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1u9hpq-000000008U8-2FW1;
	Tue, 29 Apr 2025 15:35:06 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 58E801783FDC;
	Tue, 29 Apr 2025 15:34:54 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 48A6D178245B;
	Tue, 29 Apr 2025 15:34:54 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qr0AbpeTHHwl; Tue, 29 Apr 2025 15:34:54 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 108DD1782431;
	Tue, 29 Apr 2025 15:34:54 +0530 (IST)
Date: Tue, 29 Apr 2025 15:34:53 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	nm <nm@ti.com>, ssantosh <ssantosh@kernel.org>, 
	tony <tony@atomide.com>, richardcochran <richardcochran@gmail.com>, 
	glaroque <glaroque@baylibre.com>, schnelle <schnelle@linux.ibm.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	rdunlap <rdunlap@infradead.org>, diogo ivo <diogo.ivo@siemens.com>, 
	basharath <basharath@couthit.com>, horms <horms@kernel.org>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	m-malladi <m-malladi@ti.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	afd <afd@ti.com>, s-anna <s-anna@ti.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <663252690.1172927.1745921093992.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250424191600.50d7974c@kernel.org>
References: <20250423060707.145166-1-parvathi@couthit.com> <20250423072356.146726-7-parvathi@couthit.com> <20250424191600.50d7974c@kernel.org>
Subject: Re: [PATCH net-next v6 06/11] net: ti: prueth: Adds HW timestamping
 support for PTP using PRU-ICSS IEP module
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds HW timestamping support for PTP using PRU-ICSS IEP module
Thread-Index: rMCkv9aSBafPeayIWiLctpQIplkvYA==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On Wed, 23 Apr 2025 12:53:51 +0530 Parvathi Pudi wrote:
>> +static inline void icssm_prueth_ptp_ts_enable(struct prueth_emac *emac)
>=20
> Also do not use "inline" for functions which are not called from
> the fast path. Basically no "inline" unless you can measure real
> perf impact.

We will review and remove =E2=80=9Cinline=E2=80=9D keyword in the next vers=
ion.

Thanks and Regards,
Parvathi.

