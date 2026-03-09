Return-Path: <netdev+bounces-265779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFZCBytJr2krTgIAu9opvQ
	(envelope-from <netdev+bounces-265779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 23:26:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B49B024234B
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 23:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B9B330219F8
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 22:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE82038F940;
	Mon,  9 Mar 2026 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/4Ury2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705A38F245
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773095207; cv=none; b=e7bEilWG7wukJSBuJyx6yleNAaLxBoNp7Ri8ewRbl+hzkyUfqOYOQPkq+1RlH4ggtsAMZ/IAjWEZTZBeoBLQG88n5C9PxEMuPgjg2j8VD2g6ZtgkbPlHAgwcAKji61NzZHYjhYbdEAnpB1cxwbypfgGLSezk0d7yC6m6B0RkGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773095207; c=relaxed/simple;
	bh=i0GRJfSHh/D61KwItNe6fb7adZHJMaGkMix9ht+i3A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re1OlPiSMdvQtdj4U727PWtjmng2i6Dowl7fHjVbUJRFOUcHQ2qKXDITk5cXP5xRVXZJ+Jyd7j0vI5M8rpZzz9JNORlnK0I7SZIBjD6a+bvAsWIkRNobhp5DwgVFaqkFRJ1OX/xwIkPqr1cosQN3OtnmdBiGJ+yayKdEv84Wj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/4Ury2o; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd8c6e365eso126964085a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773095205; x=1773700005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0qmAnC6DnZWfkO5AOHdxhn/T13J7DQN3esTSP9cxW4=;
        b=C/4Ury2oopotKm4qQe5ULNnB41cyLLpNkR2VwqK3MczAcqUb7MHZ3lNd9wt1yUxOn3
         ULpsbAx/v0MrbHPh/ZGuR7E40U0dMcJmHVbFmaR3zidTpKjvVW/c/CvxhnzlKaQEd9TH
         QdSKViAMLpfz//6F6jKX2EnCw3POpeKqmL0hkH+6vUeLeyZA/UDwUq3XDPald81m0RTT
         Cf63g7mzXZfoLx3G0PrWF1Zx1OvY7IFNSNW6+pmu6h2fwuMfAKgjGQODZ0XItscgWkxW
         qxXwJqZ9WH0zT4grYRuzGrDqi50x/RsHV2rWHk8xLPrGAEytC1OOAnw9JTdQ1LARc9Ox
         BEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773095205; x=1773700005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0qmAnC6DnZWfkO5AOHdxhn/T13J7DQN3esTSP9cxW4=;
        b=ogYI34O9ytCsCoNW9G95RceK8xCrTbxpKdrUm4yLRfKm2Mo7alMc1jS61sWbqMvVr7
         CbY4cNiBweD0LxKXfqP5LMjQwvfDogTongIfczFzXpBwHgtWkrxJjQZxtZa/ZrKMGMd2
         qbDSIpaRuyZ3Y5WuyoQni223K7xOZr6mMgWyFBt/sFa/eDwUNheXf+h5qqLu/05P4AUl
         YS57EfmInt5p4Hs4UxuBxU8jxoWja2kD085JvMVcQYgnzI8307zkXRaBZFLr+TDK/sVx
         WsFJaLQjQoe67DHa0wBzIaBMKOmTa1RXas9wnzvB1c0SGPOh8X1eg2607XdtUtouOesJ
         jBew==
X-Forwarded-Encrypted: i=1; AJvYcCUwqv8Yhm3AXaNUsHIhy64HZf7JNcg0baXBBspVqV/qc9M5Dsp0o4bwWbpfUmBbufLh0snkJQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCjpVOTrNB0ikz8DzsztFbZUmkj5zTzZnZ+JgtSKV70yriYsj
	o2pxPdZATVY863bnhnfIwEYTiR+MU+1zCPAVuPLwQ96r50Crz5yNUYMn
X-Gm-Gg: ATEYQzw8GZutNmWtbHovhxkdYoAfCEcexhPuchDPsHPshVhKA0EzfE2Iz9LS5wjyWph
	PmKJa09OmXluir6Ex/otmX2cCVDh0Ouh8Dy5XR4Xk/Dx+y5AMU8myJB+MFg74Zx3KG/mGGSz198
	KNApWTjzH7D3wG6/56by7hO5APCX3/OQd/FuyiLh2eODQsSdL903yaVRAhJm3OCvolTgot52b1G
	q4ne1qQFvDb5nfFo5mgfBTHh2g5ENpeZl6WAMv/NRJA3zMEX4xeiAxNg0f3nO3Xn/ioyrWrSji+
	2sI/3Qc/wqB01G6BYG+QUSe7RgpIufQFKZtpifDST2GraxyFp6ESRUQJ52xI19xZYVwYVO/WwGU
	a8G0eLcK528gqIAEOxhsfxMVIjIwMh1DVz8fVHtsRbozeblBqIfKbc3pN9aqKC5To2KjuQgU/Mc
	t8u99J+sIPdBJVkp5nzZoY73YxIfwDg7Wr1Q==
X-Received: by 2002:a05:620a:c55:b0:8cb:4289:6c1a with SMTP id af79cd13be357-8cd6d549b1fmr1572894885a.75.1773095205343;
        Mon, 09 Mar 2026 15:26:45 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd866f7074sm325445485a.6.2026.03.09.15.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 15:26:44 -0700 (PDT)
Date: Tue, 10 Mar 2026 06:26:07 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>, Yanteng Si <siyanteng@cqsoftware.com.cn>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Shangjuan Wei <weishangjuan@eswincomputing.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Boon Khai Ng <boon.khai.ng@altera.com>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v8 3/3] net: stmmac: Add glue layer for Spacemit
 K3 SoC
Message-ID: <aa9I4pIZs5-TDdXo@inochi.infowork>
References: <20260309004305.315018-1-inochiama@gmail.com>
 <20260309004305.315018-4-inochiama@gmail.com>
 <aa62FTHMOJGhVKTv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa62FTHMOJGhVKTv@shell.armlinux.org.uk>
X-Rspamd-Queue-Id: B49B024234B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265779-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ziyao.cc,cqsoftware.com.cn,nxp.com,bp.renesas.com,eswincomputing.com,bootlin.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:59:17AM +0000, Russell King (Oracle) wrote:
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> >  .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 227 ++++++++++++++++++
> 
> One last point, please add another patch which adds a MAINTAINERS entry
> for this file, so you can be Cc'd with future stmmac developments.
> 
> Thanks.
> 

OK, I will add a MAINTAINERS entry for both this file and
binding file.

Regards,
Inochi

