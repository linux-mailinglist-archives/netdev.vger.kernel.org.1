Return-Path: <netdev+bounces-253645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDh4GNsReGn7ngEAu9opvQ
	(envelope-from <netdev+bounces-253645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:16:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE24D8EA49
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 714643013A91
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0313619D07E;
	Tue, 27 Jan 2026 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmxrjDsL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD718E1F
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769476568; cv=none; b=ouwDU7BHRm1HK10h8CCZQ+RXP/66AwNIVVn4K1yTX1pvPusu9IgBxdoARMUTXOVRMrH06u080Z1Hw28H+uP9qnkuG16AIJHjBKzAImXgxejsU1GXRwBLq8l+FBtRDdwpFcJf20S+f055YtqjTXQj8ho3Alj9Hr2rtLWtkekIXJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769476568; c=relaxed/simple;
	bh=PWUrFDaZymwHGwAF/jInaMszPNXRgniP+HW2yijeOLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpW0AU6I9i/JNeMhMgJkeX3B8pSGUfdAcxwDMiPwAsIIhEnyVtj/OlGm+IYY15JTRnhPgWMdHYUe1rulavwcQo4dzkO/2lNmtxVis2sNFsAAQeQUFys2CHfRt40NAJ8Xeuj4x2Z4fQA8n06n/VGZ6VAZxa3LaCL67Rxk+D4uKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmxrjDsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FBBC116C6;
	Tue, 27 Jan 2026 01:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769476568;
	bh=PWUrFDaZymwHGwAF/jInaMszPNXRgniP+HW2yijeOLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dmxrjDsL4BXwTxbaXPruNdQTZilZ/Es6cUwSrTDI19LNLLlOVul/Eg/QnBdhGLH0V
	 1Y/GOeFtRavJcbwq3NjPxWKjX/zIteq4DJdVmSwFyw16zeyoGGO3WchvvWOWVHJTIt
	 clBGn5qiuEfaQzlx0itO79PSMDK0dHYIHcKUb99YwyQ6kKIKZ+t+E10aDKxoPVBUiF
	 WCGimFuhpZyqOdeiEEJurPrVRvuycnoiaw3KCN2VI0CMFFUSgGTCQjOObWQq5GZ5sn
	 MFYSdTzI6xhw5iR34dRNtCiAKypxeHHLd5tpbgRHvVj3diZJOlj+QpTTlk1/fD1VgI
	 Kvwol6/iDxGoQ==
Date: Mon, 26 Jan 2026 17:16:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiko
 Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 06/22] net: stmmac: rk: add SoC specific
 ->init() method
Message-ID: <20260126171606.6153aa1a@kernel.org>
In-Reply-To: <aXgN2UjiI_OxWHH-@shell.armlinux.org.uk>
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
	<E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
	<aXd7aSk7KIxlQd5z@shell.armlinux.org.uk>
	<20260126165144.25055591@kernel.org>
	<aXgN2UjiI_OxWHH-@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253645-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE24D8EA49
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 00:59:05 +0000 Russell King (Oracle) wrote:
> > > and there's no way to find out for about 9 hours (more like 19 hours
> > > for me because of the timezone) as the AI reviews are not accessible
> > > until then.  
> > 
> > The patchwork checks are for maintainers. If someone wants to build
> > a public CI for contributors that'd be great. We can even provide
> > funds from the netdev foundation. But let us be clear that the current
> > setup is until now maintained primarily by me for me on the weekends.
> > Unless you make an effort to actually help I don't think it is in good
> > taste to complain.  
> 
> This sounds like my contributions to netdev aren't valued, and if that's
> the case, I will stop.

Quite the opposite, what I'm saying is that your complaints make me
feel like the weekends spent on trying to make this project come out 
of stone age testing-wise are not appreciated. Of course your
contributions are appreciated.

The AI code reviews on existing buggy code are indeed very painful.
Not sure what we can do here to make the contributing easier.
It costs us around $2 now to review a single patch so we can't afford
public access. I think Google is working on making Gemini code reviews
public and free, hopefully that materializes.

