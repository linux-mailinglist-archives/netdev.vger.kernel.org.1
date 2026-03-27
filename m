Return-Path: <netdev+bounces-272696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPWKCrkYx2mXSwUAu9opvQ
	(envelope-from <netdev+bounces-272696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 00:54:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C404D34C913
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 00:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C2E30490C1
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 23:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5174E32A3EC;
	Fri, 27 Mar 2026 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwLYaP5k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DD2877F7;
	Fri, 27 Mar 2026 23:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774655521; cv=none; b=VFIUgPnSalS0ziXyVAmqmhQE/iENoYOSrhY7ZUpVPGnAd91oy0kX9Kjlc9ZYnj7C03C35PNABAmEJoz6uU8vLluaq3canLLJ0yUfkZEefu2YBiD1infddbAskeYRPmxA2p7EKGJETgyYWJRXC02YvGWjddPQWVdszQyuyjECKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774655521; c=relaxed/simple;
	bh=n0HrjJh23j5s50K5kpsr4BouiZnYXdlRUEa9ow7Kb4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvRFB9lQMRs6hf1veIN/jjAgyi6yKW1CzqoDBOD4t6JTmIR+vnpyhiHyusHDUzKGB9+ljEXbmBLGJdERq29Ti107bZ0MQnTqg07g7mpIpoLgbXdgWsSA2jz3x0XFVmR/OX8ExcB18gc6e/U/9Qk06stOztixZ9j7QhYHqrXtPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwLYaP5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA5DC19423;
	Fri, 27 Mar 2026 23:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774655520;
	bh=n0HrjJh23j5s50K5kpsr4BouiZnYXdlRUEa9ow7Kb4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gwLYaP5ksGsFt8e4rlR7SJ0Rexulhn2UiIUQdWePHurcrDfv1XUoLkV8v1yMtYiPz
	 w4V9OzW0NWKHns3JnErxN2IWP0SCZYIKfUnkzvugOpIzXHua/OPeeznRCYLF4cvQmC
	 oYZCRIBRhFsCqN5AW4LpKe6P/EmsAYKb2/Pyt+jlRqa3LnoMdYdJuUiTXmzYelM855
	 mee2hSEVMth36KZYZeWy8am5Z5WDt6waeD1TR6EpZppbfDhEiZ5PZC9D0mrN34bJJo
	 YWKrt8xVFejfdb64NxAdCw10r6c9P9qc75tNuVdLscaIPRkaMHzNo2p/jNgpf192KD
	 C/JiPdPiOZNWw==
Date: Fri, 27 Mar 2026 16:51:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] Add support for PIC64-HPSC/HX MDIO
 controller
Message-ID: <20260327165158.505855eb@kernel.org>
In-Reply-To: <acZ5WDz5qVxBDj3e@bby-cbu-swbuild03.eng.microchip.com>
References: <20260323220254.3822444-1-charles.perry@microchip.com>
	<20260326203309.7154152d@kernel.org>
	<acZ5WDz5qVxBDj3e@bby-cbu-swbuild03.eng.microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272696-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,armlinux.org.uk];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C404D34C913
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 05:34:32 -0700 Charles Perry wrote:
> On Thu, Mar 26, 2026 at 08:33:09PM -0700, Jakub Kicinski wrote:
> > On Mon, 23 Mar 2026 15:02:52 -0700 Charles Perry wrote:  
> > >  .../net/microchip,pic64hpsc-mdio.yaml         |  68 +++++++
> > >  drivers/net/mdio/Kconfig                      |   7 +
> > >  drivers/net/mdio/Makefile                     |   1 +
> > >  drivers/net/mdio/mdio-pic64hpsc.c             | 192 ++++++++++++++++++  
> > 
> > Speaking under correction from PHY maintainers but I think we need 
> > a MAINTAINERS entry that will cover Microchip MDIO, or at least the
> > files you're adding. Important read:
> > https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html  
> 
> Sure, I think this should go under "RISC-V MICROCHIP SUPPORT" or maybe a
> new "MICROCHIP PIC64-HPSC/HX DRIVER" entry if the former was meant only for
> Polarfire SoC.
> 
> I'll add something in v3.

Thanks! FWIW I'd prefer the latter - smaller entries make the
responsibility clear. Under a big arch entry the maintainers are
usually seeing too many random patches to act. You can add
_both_ dedicated a entry and add the files to RISC-V MICROCHIP,
if you prefer, too.

