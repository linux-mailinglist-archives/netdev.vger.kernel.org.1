Return-Path: <netdev+bounces-268414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHMkJv7JuGmcjQEAu9opvQ
	(envelope-from <netdev+bounces-268414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:26:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7842A32C4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 908C83013480
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24872D46A1;
	Tue, 17 Mar 2026 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkR7dLbx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1B27FD51;
	Tue, 17 Mar 2026 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717710; cv=none; b=uolhGoI7zWiMrZhMCR13vkhgMNXBLc2yaq3iZ86mFSTCZ7gUrvMs+vfeC96cKIuzSNd3B3lELZHQPtfbKYr3yRpFRHifLOrJ3CRTM1PZzOEfbdm/DhqesV2xhgwtucmFPJqMxf9SlrITU8LRsNf+kJMI/Vy5H8CtWl+qekf98/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717710; c=relaxed/simple;
	bh=2kpU1JJYKn+nMJDIDxbv+GgYoKMUunK160GUW0ypx78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOcMx69HWoytee1l3a53cOCE9i2fUVUUqZtDD5uGzFud8yDtHVWQcDIyqcHKY4nrph32XW7FaPaH/A8D19JXjvuRPjqyMirAvlArZDVyMnkU53pNgWFCsQPEaf8D2iaCe3zPZ94PkVD9iiOn99iayVUqZrDGo5tV+Y5SjSGV39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkR7dLbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F062C19421;
	Tue, 17 Mar 2026 03:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773717710;
	bh=2kpU1JJYKn+nMJDIDxbv+GgYoKMUunK160GUW0ypx78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QkR7dLbx7a+ct3rh6FeCJn220b3UqKaggyq5g81S7cnw62UX0l7QtHtlT6WUT8nVf
	 0P/55uZOqYzMpW1nX8TzE5zbl7eS1GKOndPmR9IZKHBFHjTKHHph3Dl3L4s//urtTh
	 O0chTqs2zZAGdT1EQUb1upXGG64C/1ygiBwAf/qjasVWc0dFXMXQKCjOK9gpk6PUPD
	 ta/YVxTk5siE/1FomstF9a9eomkwKr4Rv9AWXq7wbE9/W6bbCAK/WIu2AsuQtZxyIv
	 OXguMWyKO56lKOePBow329/2cT6vdJqB/64+b9omo5dd/sXVErzbwsC+2Mj/2M77y3
	 ZlF9paWqkmyUA==
Date: Mon, 16 Mar 2026 20:21:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan
 <dlan@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Richard Cochran
 <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Yao
 Zi <me@ziyao.cc>, Yanteng Si <siyanteng@cqsoftware.com.cn>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Shangjuan Wei
 <weishangjuan@eswincomputing.com>, Chen-Yu Tsai <wens@kernel.org>, Zhi Li
 <lizhi2@eswincomputing.com>, Boon Khai Ng <boon.khai.ng@altera.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin
 Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v10 1/4] dt-bindings: net: Add support for
 Spacemit K3 dwmac
Message-ID: <20260316202147.431d9aeb@kernel.org>
In-Reply-To: <20260316010041.164360-2-inochiama@gmail.com>
References: <20260316010041.164360-1-inochiama@gmail.com>
	<20260316010041.164360-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268414-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,nxp.com,bp.renesas.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A7842A32C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 09:00:37 +0800 Inochi Amaoto wrote:
> The GMAC IP on Spacemit K3 is almost a standard Synopsys DesignWare
> MAC (version 5.40a) with some extra clock.
> 
> Add necessary compatible string for this device.

In the previous version the AI reviewer complained that we're not
adding the new entry to the select at the top of the file. Other
compatibles appear in 3 places in
Documentation/devicetree/bindings/net/snps,dwmac.yaml

Also I asked whether we can drop the "default m"

Did you disagree with those comments or did you miss them?
stmmac is a strange beast I don't really know what's going on in 
the binding, so just double checking this is intentional.. 

