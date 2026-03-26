Return-Path: <netdev+bounces-272162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKKGEaRrxWl1+AQAu9opvQ
	(envelope-from <netdev+bounces-272162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:23:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA8D3391AD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2B86300C24A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAC22EB859;
	Thu, 26 Mar 2026 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ruj8Lsbc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057725EFBB;
	Thu, 26 Mar 2026 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545720; cv=none; b=NCSx/ti6LidZMi71A2yQgG2S4TK/eV3AtaJfAZe4j4izIn2merhmuir7eM0VUCPtMuat4YmpPaSSBS16iDNQk5zwg+PUtkFYKK6h61TIXewrL7eMhHA4FcUxudpHp7MnuoWiJsmoVtXZe1ZqB9WQE+/8JSZpVpst4wvrgfjx9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545720; c=relaxed/simple;
	bh=gWAQKtriBxFBte89uPYeWlvezYh2OvK63i/Tp6/VF7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH9y8M1K/RpTaRzSUi5hOtpyrSpOAEL0DAJ3iyCBx7KMISHnRMFVompaKMhCnF7l0lwKzErnZj2JMYf/7XsbDp5qicXyYIP0CspKTBNm7oiWI1Y3MXVJCGIPqKIkGXzMyFnUv6JgdK32j9iEcRBu9yhqb6WK/VT73oYoO9JBtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ruj8Lsbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC95C2BCB0;
	Thu, 26 Mar 2026 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774545720;
	bh=gWAQKtriBxFBte89uPYeWlvezYh2OvK63i/Tp6/VF7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ruj8LsbcbV4dCDq0E48OMRhVzsMLuW17ySAFidrwpOPI40LzVLOiGQ8tlIpee46IV
	 NVnj/U+ctWN8apMnF7ah0Z3pKHeoYBjboAHwulMGFECwUtBmsUbqZElv8W1/Rhnjjj
	 cdxnu5ZGxYk9zca2iRoQ7nuKRj8+/FhHDSPUuFWcAajYRoZuibqnMX7q51UAhjTwnE
	 VdRHq5EpNHzWQEoZibO89qbiOBYCdScrXm11x8doEqQ0e64wsj3Qmep3EO9qmp3YMy
	 EDl7rxZQeMxuvDvukj9qbgbHeJ33ud4N3udWdBh4q0bSCB3iXYH/sb5PVHHkBAHaCB
	 IXnzD3kyCiDSA==
Date: Thu, 26 Mar 2026 17:21:52 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH net-next v5 3/3] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
Message-ID: <20260326172152.GQ111839@horms.kernel.org>
References: <20260324073017.376-1-lizhi2@eswincomputing.com>
 <20260324073408.439-1-lizhi2@eswincomputing.com>
 <20260325180330.GL111839@horms.kernel.org>
 <2a12c839.5e64.19d28232537.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a12c839.5e64.19d28232537.Coremail.lizhi2@eswincomputing.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272162-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com,eswincomputing.com,einfochips.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: AEA8D3391AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 11:14:45AM +0800, 李志 wrote:

...

> Hi Simon,
> 
> Thanks for your review.
> 
> You're right, this build failure is due to an invalid clock reference
> ("clk") in the Ethernet node, which does not correspond to an existing
> clock provider label in the current DTS.
> 
> For context, this was discussed during an earlier revision:
> https://lore.kernel.org/lkml/5dea8ce0.4435.19c471231f5.Coremail.lizhi2@eswincomputing.com/
> 
> The EIC7700 clock controller support has since been applied, so I will
> update the DTS to reference the correct clock provider and ensure the
> build passes cleanly.
> 
> I will fix this in the next revision (v6).

Thanks.

Please be aware that if the patch is routed via net-next,
then the dependency will need to be present in net-next.

