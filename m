Return-Path: <netdev+bounces-285921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL5HL2gH/mkxmQAAu9opvQ
	(envelope-from <netdev+bounces-285921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:55:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EFE4F90B8
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 810F33033D2D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA08031196F;
	Fri,  8 May 2026 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="r+qYdjAF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18E3093DB
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255700; cv=none; b=uSZ3o7gIkNPfL1Jj8cg+WPC751JX564fMJPTAPjRHts2aHp6Ao8QeZAFieynuD5VmknVcOlVmjIA5KIGM/7V+oHeyP06H6BErEcsngbkG8oW1I2lZBsZDYKwtzzUq/Qm++4C5I/6CMxAm4SyFHcLgONDVr84GUL3wHD4wB9PXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255700; c=relaxed/simple;
	bh=beGQbSohbqovdwuat6nKIVAFYzmFCR8PUrxcs94i44o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGN25t4IyuBt2EZPlspRBfZk3/+FgBmH145ixqwfUC74hoeNEBqcFwrIuNY/ALIURlW4nI3zw1xLRTYg1uDyR/wF/OjDUPe901BLoC9t+oeGDhXvFGxJzmblPorT8HM7MvPnqYPFjipgwW1HR2hkt5yPmCADGBb7Kmzodvm38DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=r+qYdjAF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d73352cf2so1754367f8f.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778255698; x=1778860498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=beGQbSohbqovdwuat6nKIVAFYzmFCR8PUrxcs94i44o=;
        b=r+qYdjAFZkJSnq1CvRGaZ/LI0eK8QVoWEZ9b1iPl9bQ4fUagPkJ5pED9ioSpKvlsoO
         DrvL7Bh6e3tvTGaMBZXU0PYwKOPjbw7Sxw8y8vdeE77aWvjecDLGUuyegp7slaeFmOFc
         m8b3MlNirSpcUJr7Z89UYmFHcLpaWwjHk3JoHle6AcfeIevgB9PUjiGrTg/M1Lqj8hxx
         PjZvZhERjKUMRpg7w0l/re/UGKYWkC3uMKgNovGFMng5MGmX24mwGtoGrEHnwpwLAyrb
         /RbxexjnFUp6MOGJNDbI6hH+pNv1l2PtOczm5KPhE+ZYhNqqtd0WXLpNUXVKFjvbIaXe
         H2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778255698; x=1778860498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beGQbSohbqovdwuat6nKIVAFYzmFCR8PUrxcs94i44o=;
        b=iBRndzQJIv9JRC3omkIRLtOI+oztAWDOLj7oAIR51WH80tgfVvRU2J7uwYqO5OjY6F
         W0LogsPVBBg8kn9FdurhYyC19EcrdCaO5BgTxWWhCrP2EHya2l9TakJEj6hoieU5I/MA
         7w+Hee4cNXI/mCgYY5OMrWBERA2bc41AaTTYp0T9hZVNeH1wBvih31xunygI/Ff06Rnh
         eidnAMUJS1KQZjhhqymGanCcReEGH6Rh4K4yv1elAzo7hKBjpgYxnMAN1j62fK8Tawqm
         moq6Yx2F+9RcSnJxE7zyK297N8i8+da9bYTKS/7VN38PZZ/zbKotQCcsQ4lWJe8K2na9
         nt+w==
X-Forwarded-Encrypted: i=1; AFNElJ9D1fSjz0LeoBFuL2Zzcts+IEqGEvbhsXqU/BUYxE6y4nHfbHvqdJsnxzySqBcJtV5TY1oBChA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1b38+h8mKpjg08PzkqCltJG5+UaOvCddFwQexl2V71tbpFVh0
	HNBYWEMkhpAec8po1/JJDEGKS6WPhyA/8+ADfnl3W1mLr7QIB5jTMqvHmbykrpbOn0E=
X-Gm-Gg: Acq92OGj6zypafq//ga036Gt2hY70H/vk74otRln2UTJ9JvQg+40eMZCt77oQvyezsB
	kr1o+LHgYLSuj9lF0OFoCpRGJ5E4kH/utEikXSQMYBWJHDn5JU8twSw79fEZY7pOZ5/VlfXdmdS
	FXePEssrrolPHtOiC0Z3LQnCkDJpFjkWc7x85UIWdKytmuOP1/uP7zVBDGavpS2B8WIw89RUnI5
	ZXE2wsSSl70pdRxZd7i3E10vQri+pC+TMxEc3inaHONffUKkF40nj3WHlfHg5rcZ4fXrbC/RhC6
	8uyutk1N0QKCYOZaWgkSwtHGYTshfdC+J6vHq36NvQKXJcmkVWSCNZN66KqXx3spdfyHurlkC1j
	d7cCQ0b/sTOCLgj8DWgg6PrCclrXNNLW1oEU8jZvc9ZYIINuMAVrV6IAJ3qmae/cMuC+3igSIVu
	ZvDVK5n5h0/Z2CyaW3xa1pAgjuopvmrvFHwqM0hY+W21J1YNhX9gVyTA3KzKLPv5C22qsGoDh3N
	cliIf7RvzvA6I7hZsVORjl76FhptEKumEWm2juaLxRORZ2jeFd6nQPXxLHJ6E7OYYH1IXVBujoS
	BeXiWL8/
X-Received: by 2002:a05:6000:22c4:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-4515ce1c6bcmr21753628f8f.22.1778255697345;
        Fri, 08 May 2026 08:54:57 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548eb75c29sm5680163f8f.9.2026.05.08.08.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:54:56 -0700 (PDT)
Date: Fri, 8 May 2026 16:54:54 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
	alexandre.torgue@foss.st.com, ast@kernel.org,
	boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
	julianbraha@gmail.com, livelycarpet87@gmail.com,
	matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
	rohan.g.thomas@altera.com, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
Message-ID: <af4HTg5P3j0GsNvt@aspen.lan>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
 <2ce5897d-5bbb-486a-b0f0-0e30e54b451a@lunn.ch>
 <afy34kj2hPxIlArO@aspen.lan>
 <ef6df85f-11ac-404d-958a-8cf69b3b6bb6@lunn.ch>
 <af3IKKkjl0jK8GGB@aspen.lan>
 <f15e2fe2-88c9-409d-b953-cdc94aee4e16@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f15e2fe2-88c9-409d-b953-cdc94aee4e16@lunn.ch>
X-Rspamd-Queue-Id: 12EFE4F90B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[riscstar.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,oss.qualcomm.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-285921-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@riscstar.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aspen.lan:mid]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:34:42PM +0200, Andrew Lunn wrote:
> > BTW if you are bothered by SP_SEL_SGMII_2500M, that name comes directly
> > from the TRM and I'd prefer to keep it if I can. The enumerated value
> > we have to write into the SP_SEL for 2500base-X is "SGMII 2500M".
>
> We try to avoid anything to do with SGMII and 2500 because it is
> technically wrong. Cisco never defined SGMII for 2500, it is something
> silicon vendors have made up, without any foundation in any
> standardisation. We much prefer to refer to it as 2500BaseX with
> broken signalling, which is a much more accurate description.
>
> The TRM is also not a public document. If it was, i could see some
> value in keeping with the naming, but since ~0 developers have the
> document, this is less useful.

This is a pretty obscure register buried on some of the TC956x glue
logic (e.g. it's not part of the DWMAC's register set). I take the view
that if someone is debugging the hardware interactions deeply enough to
care what this is called then the odds of them having access to the TRM
are actually pretty good.

However having a different name would be only a minor irritant to the
poor soul trying to debug the thing! I'll rename to SP_SEL_2500BASEX
in the next rev of the patchset.


Daniel.

