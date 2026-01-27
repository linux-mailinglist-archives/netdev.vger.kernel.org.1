Return-Path: <netdev+bounces-253859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMmDD5e3eGlzsQEAu9opvQ
	(envelope-from <netdev+bounces-253859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:03:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA82949FA
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0953029AD8
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD753559D2;
	Tue, 27 Jan 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2titWda"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C13355811;
	Tue, 27 Jan 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518652; cv=none; b=ezLSO05OcVub8BseEkaIKdtSRE38+b/3M9OjiA90Zd7qfQGYW8u0AMzZg41DjxKtz6CrWe5ifHAuu0KZSpEzfILtycgTxcUOYiUYr6ZkM8IZnrqU+xjRTc9mAdQBsOOMmMPVGiWKGmpwdq63tpjKOFfeJbbGmd67ChgkhSVifbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518652; c=relaxed/simple;
	bh=Uksvj+xXNbVKjMG5czjlohyQ4d21ktvK52mNzFdDWSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0kG3SDk2ld1oELQLPgdHe+Mfod7qsCIvdOKvQ0TaHg6VRtYy5Mg4EcleqFhY4HpZnTCX7VWUxq3jsPW7V7OUzTneV+WRbOUMzVGhANihRiG4mPoUy9HNDOF9k10H5K4yS/XLjHXMj19xQBJoXwTJfCdnH/oSQPdMHvU0onVQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2titWda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6540C116C6;
	Tue, 27 Jan 2026 12:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769518652;
	bh=Uksvj+xXNbVKjMG5czjlohyQ4d21ktvK52mNzFdDWSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2titWdaXnkx9/wH5ayXFTvKiWmyHCAO8bcKIHk4uZrSAs2NX+pxPZdkVMuOoshFa
	 z2f89ClcaabsmFC5zc8BHWMsac5YaecrFYqEIMVJF5gyjpgMYX45Ml1DqTTMb+0l/6
	 xJrX6e7Xd8xG/rY9QA25VZjGqvXckuXAbh/doJWcC4YULkXmQy/iv5AiTRvp+L0lto
	 KGkm4paaRX+qB+0cSzTnY6aDlLbwOPoUC9fb3EzM4pJC5Vs97KC/bFwzz8pzWYvEZ4
	 ZOnuCJ4wpITzFDsJ8YBiKUcOOA9i9p32TSXh8efo4+bfc5P4Vv6wWlTuTcLYs1UUOu
	 8xZUI4lq6HPEA==
Date: Tue, 27 Jan 2026 12:57:24 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, robh@kernel.org,
	kuba@kernel.org, festevam@gmail.com,
	ghennadi.procopciuc@oss.nxp.com, alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	shawnguo@kernel.org, mbrugger@suse.com, mcoquelin.stm32@gmail.com,
	linaro-s32@linaro.org, davem@davemloft.net, s.hauer@pengutronix.de,
	edumazet@google.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, conor+dt@kernel.org, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, Frank.li@nxp.com,
	chester62515@gmail.com, netdev@vger.kernel.org,
	kernel@pengutronix.de, pabeni@redhat.com, jan.petrous@oss.nxp.com,
	linux-stm32@st-md-mailman.stormreply.com, s32@nxp.com
Subject: Re: [v4,1/3] net: stmmac: s32: use a syscon for
 S32_PHY_INTF_SEL_RGMII
Message-ID: <aXi2NJcwM4-mrgrj@horms.kernel.org>
References: <8f2139e8adf02b485a4c84d558fc23f78cf04add.1769195864.git.dan.carpenter@linaro.org>
 <20260126152430.1390514-1-horms@kernel.org>
 <aXeJYo-0iiNuXVGH@shell.armlinux.org.uk>
 <aXeP1y7cK0XRx3Wo@horms.kernel.org>
 <aXh9lcfw6D6KouI_@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXh9lcfw6D6KouI_@stanley.mountain>
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
	TAGGED_FROM(0.00)[bounces-253859-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,kernel.org,gmail.com,oss.nxp.com,foss.st.com,vger.kernel.org,lunn.ch,suse.com,linaro.org,davemloft.net,pengutronix.de,google.com,lists.infradead.org,lists.linux.dev,nxp.com,redhat.com,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[29];
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
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: ABA82949FA
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:55:49AM +0300, Dan Carpenter wrote:
> On Mon, Jan 26, 2026 at 04:01:27PM +0000, Simon Horman wrote:
> > But at any rate, I think the key question is should the case
> > where regmap_write() returns an error be handled in
> > s32_gmac_write_phy_intf_select() (by some means)?
> 
> Generally if register read/writes fail then there is nothing you
> can do a the software level, you need to buy a new computer.  However,
> in this case we may eventually put the registers behind an SCMI
> interface so probably checking is a good idea.
> 
> Could I leave the error message out?  The callers has an error
> message and if you ever see the error message, and even with SCMI,
> the fix is probably still to buy a new computer.

FWIIW, that seems reasonable to me.

