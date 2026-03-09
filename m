Return-Path: <netdev+bounces-265780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FCdIaFJr2krTgIAu9opvQ
	(envelope-from <netdev+bounces-265780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 23:28:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF8B242396
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 23:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 840B1302195B
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 22:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A438F627;
	Mon,  9 Mar 2026 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOv2SQa4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4838F242
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773095327; cv=none; b=Lrh1siytuf7QTjqMfK2tVAYnlN58yOoXA5JW3xKaMhMgzSSp9K/BmVxNxVFV6Vb7cRbQWbbGHJwGII9oyd/v+D+kZf8H1djFYkwoTaAL6vzRou3uO8dOLxZX9eTJbk1MDHFKGj0BccFFIvQm2BM63VXfukmRGmg5T+8zr5z1Uic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773095327; c=relaxed/simple;
	bh=jZe33NHvCpQzQ05RR193bC1srRh1cAqWr65aMtAsAwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jj9q3M8VveBMLh3k71WUXQGpKNpsxSwiKV8nG8mczeqB3YLqpy2Jd3qCIa8Ny/KawtASmIJG9Ln628zm0FE1JUFkC/fPJ6MVCGVdzbzTwTxmc7aRoHGiR5qTT22esUkoYmdzFyf5QfPzkObstObM9ocKj4be/hWNKajcjrHrrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOv2SQa4; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899fa9610bbso136604866d6.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773095325; x=1773700125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uelqhot/SS82mnivEOGwZ5YeQ/ZVb2Ub9laQIz/Sv+M=;
        b=WOv2SQa4QVLsDrZMUgqqUxwhimqRna7bBMLT2t7DAgtaPKnMxyzxXqtS9BpvXyBkEm
         LQBG+TTtAl7a2hLZb5CBrdSVY23jQTdaqb/2Gj2zYmBPy5Jfx4/Qy2wfxkhGtHMOQXXP
         katLe/1YrePIKqBWJFeu8EIgxpOIwPnXhaX+NoJfaO49U9bEZDa/ZAx6Nt7Gw9+FxDr7
         TpXOZlp81m/ATHgjCt4eUtJv3wckiErYoEPCNS673GPwdeLzwEIT9VUcgBU/3Gndzi1y
         5TQR8YG2LnEqZtRTNXjPxRJsHa/UPBNzIDwCaUAK60Siph46n13Hb2wCQ4aYdaO1fEkG
         7wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773095325; x=1773700125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uelqhot/SS82mnivEOGwZ5YeQ/ZVb2Ub9laQIz/Sv+M=;
        b=JrDU7QvTYXvQq+g+pzjyeLtV4zO9XrmPKxRrZ6ibBg+o9TlejKlU+YrDpjjeO4vhjV
         447scJtLq3SZ9iTlfuhcDmGnvlJvcBe6wVe6d4CWvdpNnBM9DHgDO+NrKAOsqvYgknBP
         u3rx0S2FC0DXw2jPP8Ow7Avp0bokbnvyJkZ/U04upGWbRvAr06rJ5HGTg7CcxjOjDZ5G
         b8zZVlrdWK3Dahx2tx4tJrkCCKCTOkJPCXfJD85VA3tOk2ZfEy125WlK9WEl0+diifnx
         8kQtV1zafbw7Aoe2puRRxt2qCugvmk/hL/VqyAT/kFOyLrj26OX5CPqhf+b3kIUDz6dr
         29eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDAHjp8UVoHmsx+YF0cyOvhbVkOhZ5u/R4wFqI//j8PQinZbXuwcRp6oaDPXL4zQ0xcRLlWqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzyWxxMyL+oNwbevFpu0qYvgwm0BOemYArFZL3dH5qNtdWCvo
	u3ZBsGIwHggRSM2ssUFvnxqvGwf67zVukOCP3ierHR3bph0KYQXzY2sh
X-Gm-Gg: ATEYQzxlu1umn/aXgJfi66B5R9/VU5fi3V6cfDc9Q4oqYb89EEV9yvV2TK/GiDszG2U
	Pc9EP5iZmZGQ59BiTTvpnVovIxOh6b5+86XhPuQZkZwaDvN2d6rXUw7pKcIiolrLZVxR8wMOv5h
	RA1AwOpEh+pvwWnRs03Jeq0c8bTgc6kReot98bPft3xYCxTXyY0ibUYbUbD58V1ncv3evQ5kNfy
	WlFlSA7gjSLhwMmGp/lL4BVVBZPi6OoWLAIlzBFjqNnj8DK7nBSBDL8XiCTOYQAWhXGxJqVCXXx
	Rl6dgR+jMUw49DCPYX0LF0uhQswTA4HA0RPtKc7dfSgbFU7dWahifJjEfxD7WYlDHR7yVmOKEVk
	7pExY/jjQyjr9BnTbJnEhMHaJtvX0Rt6FYrKgyCbyra5xVbeJaVBGNBYekAXRIBArGGXmgnvZxK
	tHECH/24wOyN68UdiYpR6fnBc=
X-Received: by 2002:a05:6214:e4c:b0:897:255:d5c2 with SMTP id 6a1803df08f44-89a30a4d3cdmr192944066d6.26.1773095325119;
        Mon, 09 Mar 2026 15:28:45 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a1e68esm6918006d6.2.2026.03.09.15.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 15:28:44 -0700 (PDT)
Date: Tue, 10 Mar 2026 06:28:08 +0800
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
Message-ID: <aa9JCWpJ_EJbUzXV@inochi.infowork>
References: <20260309004305.315018-1-inochiama@gmail.com>
 <20260309004305.315018-4-inochiama@gmail.com>
 <aa61v7MQoYq10Jes@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa61v7MQoYq10Jes@shell.armlinux.org.uk>
X-Rspamd-Queue-Id: 1FF8B242396
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265780-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[inochi.infowork:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:57:51AM +0000, Russell King (Oracle) wrote:
> On Mon, Mar 09, 2026 at 08:42:44AM +0800, Inochi Amaoto wrote:
> > +static int spacemit_dwmac_update_irq_config(struct spacmit_dwmac *dwmac,
> > +					    struct stmmac_resources *stmmac_res)
> > +{
> > +	unsigned int mask = CTRL_WAKE_IRQ_EN;
> > +	unsigned int val = stmmac_res->wol_irq >= 0 ? CTRL_WAKE_IRQ_EN : 0;
> 
> This looks like the last thing I can spot that needs to be addressed.
> netdev wants to see "reverse christmas tree" local variable
> declarations.
> 
> Please reverse the order of these two declarations to achieve that.
> 
> With that fixed:
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thanks!
> 

Great, after some lookup, I find the variables in function 
spacemit_set_phy_intf_sel() are also needed to reversed.
I will also fix this in the next version.

Regards,
Inochi


