Return-Path: <netdev+bounces-253977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NQKIScGeWk3ugEAu9opvQ
	(envelope-from <netdev+bounces-253977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:38:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00330993AA
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E18E6300DA50
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9DE328246;
	Tue, 27 Jan 2026 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5np0NK2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE703327C10
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539107; cv=none; b=oEF7TvbZIUVEPI4lbMKJzownvXyvMmpKQthiUBHIKDhjBux6VGiPmIVpSI4nZ9f1QQiZANu0B69k5Ihs25JeZCImLvKF+dULlANtQ4KfI83aLJuaRpgwmwBl5crUFO06BxzxQDVuXQz+UmvH1nSm+hs7157EhO95Za8ym3EcQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539107; c=relaxed/simple;
	bh=xnxW/CWgie/RiC6ceA36oB6xfFtPTb0OHKlujCG/RnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8qkHu2axHE8jL2u7+G0hSZKIWxeuQ96fuH2Kr1toNbmFO9vsUyo5hjq+3DKPL5GyH5sxQ+hIXM+wfa7e5NRrMp9p7F2G93vZrnuT3chB975e9p5EioO/4YbWpUwVv4ic0bMQ0bP2TULVOg+HXDwP4lcRtmyHuwMic78oqBT0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5np0NK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2020C116C6;
	Tue, 27 Jan 2026 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769539107;
	bh=xnxW/CWgie/RiC6ceA36oB6xfFtPTb0OHKlujCG/RnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R5np0NK2ji0Bvsl4dkcDUf6Xv2tMqnpoJLp4Su5Tlndt1VH/kgo9IUEOMlFv3g9hf
	 NWV0vMSiUt0Ty/+U6OkCTNW7gPzsWU9IOwm4NP/q5gZJ4Esj35k51DOxS3iV4/uDUI
	 r0/gFI1VqGmeoEIcPLpLYMl6CMlt+j3gVMklN0OPTIDr57Yo8dQ/9w49avkrhqjMWe
	 XNqSSCWoK8aqFKZcnqXAHKFmUxbuT0758wx7jjFn63jK8Ko/tcSEWTYyh9Lj4B0l5P
	 lEjH0UyOmDHgFdhCsYpefGH9u4MZh4NhGRVvU6hty2mnsoQtj4rt0oK0ZJsPNFyc0I
	 aQrFGI9h1BMXQ==
Date: Tue, 27 Jan 2026 10:38:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-stm32@st-md-mailman.stormreply.com, andrew+netdev@lunn.ch,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 pabeni@redhat.com, linux-rockchip@lists.infradead.org, heiko@sntech.de,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [net-next,v2,06/22] net: stmmac: rk: add SoC specific ->init()
 method
Message-ID: <20260127103825.7fcc86e3@kernel.org>
In-Reply-To: <aXjq3VisP4XjWYSi@shell.armlinux.org.uk>
References: <E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
	<20260127004020.3785641-1-kuba@kernel.org>
	<aXgMIYPiL9JK-c_K@shell.armlinux.org.uk>
	<aXidBha0FahIS6Du@shell.armlinux.org.uk>
	<20260127081804.64841f65@kernel.org>
	<aXjq3VisP4XjWYSi@shell.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253977-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00330993AA
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 16:42:05 +0000 Russell King (Oracle) wrote:
> If I'm going to have to split it up just for the sake of reducing the
> cost of AI review,

Incorrect, as previously stated do not worry about the cost.
I was citing the cost as the reason we can't give people open 
access to the AI bot.

> can I ask for a moritorium on other development changes to dwmac-rk
> until this is merged?

Seems reasonable, as long as you're posting and making active progress
we can prioritize merging this work.

> As I see it, this is required _because_ of the introduction of AI
> review, not because something has actually changed.

Can't argue with how you feel.

> You have said in the past to me that the 15 patch limit is only
> advisory and can be exceeded where it makes sense to, and for this
> series, it does make sense.

Advisory is too weak. Unless there's a strong reason not to break up
the series it should be under 15 patches.

This conversation doesn't feel very productive. Let me just apply
patches 1-4 and move on :|

