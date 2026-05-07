Return-Path: <netdev+bounces-285524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uISgHYYP/WmwXAAAu9opvQ
	(envelope-from <netdev+bounces-285524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:17:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4AC4EFAD6
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DDB6301AB94
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A173542F8;
	Thu,  7 May 2026 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Hcrw5OJh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45330595B
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192254; cv=none; b=hq1+jPJDcavoBrhBYnOyFCWzUxMhLDuX6RaQBp15n74qCCwYj0IrZSA342EztLjNwd4r1jk0Ju3yERM7At1p3U7bAWLtPIeK4QszDwQXzF/evF/sBE5lgCbsRRBl10f9tjURNNQGUnsRcw3Um2HlIY1p6yLC6sKrbjqkeLi+irA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192254; c=relaxed/simple;
	bh=nUqtAeSwtxg2g10Nn3t8JgkOkKTEyo+HUlH2xOySZMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j52tsnSM6gAkgIJlSNtwA56vFfGd/seaEzzaWT1N18efhIwdi2ow2lByi47sd10zeMu4SctzzVFn8Z5iScRoKEdkwNNxjjJRBWdbqmVtadcT/SHMwxh01BzKpH6sf17Ds6DW0PUZv02dp64bWqbOF0M3agqLAW32jC67dBD54qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Hcrw5OJh; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8eab809593cso136871085a.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778192252; x=1778797052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2Ov38+ykmqD6nZk6coLqjQ6cOEYuoDtYD74/Mx9UCo=;
        b=Hcrw5OJh6PlWZxzRnvFn+UW5odJBcqGZFJAcf1xuY+dVv+t7TCtX/vMaAWFjnVG6Yl
         s8oCh094BPUtVBIgneGKmDXKHHuzH8VjK4vRJtA4Rl6w91nS9Sa03BErXGDM8Oha97dk
         DFBaOSG2YwDEK8fJ5SrMSPqxu79cKZLhgnOh89+RnV+k7iyV/GB6Z7JdiAXASADEJvym
         oylte+CJp0zC4SJBr5DZIudaLYj/Q9TVVIuLGNsdPJISYCzy4uWhcPby4JoMNC8bsoET
         O9flifkcoqz6p1mZHo5I5LI206l8rwCXTCivGBs2kjGFapbOr5zY4k83j5vAUmXaArLP
         LNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192252; x=1778797052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2Ov38+ykmqD6nZk6coLqjQ6cOEYuoDtYD74/Mx9UCo=;
        b=MFYfhRuARkVsguKCKo8zsggF9h6szGdWo9qRpV7Rvl0o3k1QGjgS9e4hSDZB2ZxAAw
         mhv7r5da+DXUpSX7aFr4pPx9SGGvFzyIh0leCpw2H6IFoGkOeiOBB06DxpCnm0l1pkTX
         wonHiluIjKHi4aHGOWFtucolbtS8gDn/16yy1d1TrZ0itvNDJzfa3PuXTdnJE3ilI6Ka
         pdZuCBIFQRH2+FlEGfVWVCOZfU7pTh8/iNCK7odH1N8um+BJ9hvC2hKAKsbtfJ/CpkmI
         khp/je5XWxrrvFR1z2Roi9bXzwSs9Or3qa7l6r3OYubZy3xIMAMBFNWlnUxi/p2b5vNj
         Pi4g==
X-Forwarded-Encrypted: i=1; AFNElJ8r+W8j2cEI1nKmm7vv3NO01/2pRkBrvmXDfT80I8YpvJ00CHg1I1MmJJYAE+puiGLemkTPRmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3sfWXzBdvg//LFyGZgBh2X8nX5yZkPiv3XDF4/8wfBEKYwkI
	mi27MUUS2FDyXxm64fzNUSi0p8HK1HlSpiwi7rDZNBkgUNgoxZtgppOk28NNP66eZGs=
X-Gm-Gg: AeBDietqvmu3E4ntpmPIez+O2McieMHy4p9HDFR0Ip1nKjJHBVg0+aIEYi9g9a6QZJz
	IskSdBSK9n6Lzsg3wp0D0psMId+rXtcg/1C6E+52DunYffMx9lRm+FXl1JoFvSA5q75Hl0FftUJ
	1eXQ1UtZRxPou9ZNv+qNLvg8ZcCto6Q9hK4q4nsm2y+cyKpu1Dq2PwVGzdzAbW+FQMaXaFETNr6
	gy9IUIsRNqQr9+7mHOwCNoWqnb2M7KZ+RlLccuef5lE4uDVsIxaW2hwclMXZkXDu6rtnI1oBYAo
	hU1gANW7a2CskJSLZQysoTi4qiwa5dh9bjBY3JaL/i9ZMa7SwA95wxT0jBugkoKPVM9xOMre+T2
	p+65nMrsv4oo/tpW1wWrLFmyn26Xfjg6RK577Vf1epztf5N7G4MsjjHivEAZ0Pbmq/qfF3Gldai
	wKl2HElldLZI+Nr6qBENzWnlQwlj+bsVA0PjOKKJ4WcgXbiHn4kE7MZy4ZIjaqCAKqFjnYjo4X5
	LU=
X-Received: by 2002:a05:620a:29d0:b0:8cd:9033:1724 with SMTP id af79cd13be357-904d3cb8ed7mr1550360785a.9.1778192252020;
        Thu, 07 May 2026 15:17:32 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b986c371sm9463285a.2.2026.05.07.15.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 15:17:31 -0700 (PDT)
Message-ID: <967c1d96-9a48-48de-b7d9-58b63e782aee@riscstar.com>
Date: Thu, 7 May 2026 17:17:28 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
 a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, chenhuacai@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com,
 inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com,
 livelycarpet87@gmail.com, matthew.gerlach@altera.com,
 mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-9-elder@riscstar.com>
 <1f34cbce-e2dd-4e80-b136-55d0efa50002@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <1f34cbce-e2dd-4e80-b136-55d0efa50002@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DE4AC4EFAD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.94 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285524-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	NEURAL_SPAM(0.00)[0.661];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riscstar-com.20251104.gappssmtp.com:dkim,1c:email,riscstar.com:mid]
X-Rspamd-Action: no action

On 5/1/26 12:38 PM, Andrew Lunn wrote:
> Why not add an subnodes for the ethernet interfaces?

We will define "ethernet" devicetree subnodes of the PCIe functions
in the next version of the series.  Something like what's below.

					-Alex

pci@0,1 {
         compatible = "pci1179,0220";
         reg = <0x50100 0x0 0x0 0x0 0x0>;
         #address-cells = <3>;
         #size-cells = <2>;
         device_type = "pci";
         ranges;

         ethernet {
                 phy-mode = "sgmii";
                 phy-handle = <&tc956x_emac1_phy>;

                 mdio {
                         compatible = "snps,dwmac-mdio";
                         #address-cells = <1>;
                         #size-cells = <0>;

                         tc956x_emac1_phy: ethernet-phy@1c {
                                 compatible = "ethernet-phy-id004d.d101";
				...
			};
		};
	};
};

