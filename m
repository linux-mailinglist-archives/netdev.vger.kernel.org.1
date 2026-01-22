Return-Path: <netdev+bounces-252333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M3yMa4ocmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:39:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C2F6768A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 832F17640E3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80563A1CE4;
	Thu, 22 Jan 2026 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vLBDx/d+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EF3502A4;
	Thu, 22 Jan 2026 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084207; cv=none; b=RQAp9PsoyVt7PaiuJ0eOSPidzRQ8VuzexathBkMfkCcM4TPOFcwHnl5Y1oujw2MgooOfi9j2AFSUFGjxGSyHKNa9+N9xoWNlWT0cio98I7mG/4EiDfcgjc1oRtsw4CGUfKNzqqMxyBe2fMpFhVJpX9wL5eeWSU9lYPyowC6GmOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084207; c=relaxed/simple;
	bh=WlyWSnfhnpblwx8zZtPl0q2t1AoQiYXkVgcJVu7xWf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay047HD83O9vzReRuXuerd/w8P/4JJjEONWOioTzsZX082r6FQQCrN/GfMwv/RbPxA1uaKy0VmrUCECxk66hhhHVvGUUE9qjewaQrvMGH8rjnar3Y29k7xwi+skrblYTPK9SiZZTi1jJLlvvnfnB8jcQ5KYlk2eI6/zBgvjua8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vLBDx/d+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uMyl9WGk6TsY212/ra2FFtO0bjOpRMAh9yfL2NWSmWg=; b=vLBDx/d+BCtqQLvGgiBsiwW+Ys
	8zITTruozts32Bd8p6KmbY1Pc+CnvJfE2mTMQKYUlLAx8b+/XutQIcsdJRUfc57ZmjfY6CZlruuDO
	6crdcH6Z4mUzfF6F16QHZD+eZVcuIz+5uEYkw95t2+b8UvfPC/gfHKoo+dnrH3PwsYlldvj6ID8Va
	Fhebw5Qog7tEaWypFg0g9LIOghw/lhM+kkQfKjTjKhzZy9CTx8PcYjBbdAlAW9YJT/8Iir6juAh3Z
	EMBpfTe4gqBBJNqWxIe3XxI/unO4lrRsp6myT4s+DMCmrv2WC2FUU5FJTcddlxVA8yxjE/yQZYbIg
	0157pl8Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48708)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vitc9-000000000Lu-0vFv;
	Thu, 22 Jan 2026 12:16:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vitc3-000000000zk-2nOX;
	Thu, 22 Jan 2026 12:16:35 +0000
Date: Thu, 22 Jan 2026 12:16:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 01/15] net: mdio-regmap: permit working with
 non-MMIO regmaps
Message-ID: <aXIVIw2SKsMfNVUm@shell.armlinux.org.uk>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
 <20260122105654.105600-2-vladimir.oltean@nxp.com>
 <aXISv3Acm1v6yS4V@smile.fi.intel.com>
 <20260122121301.cyxyevi7xvqw2axk@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122121301.cyxyevi7xvqw2axk@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : No valid SPF,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,trustnetic.com];
	TAGGED_FROM(0.00)[bounces-252333-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 52C2F6768A
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:13:01PM +0200, Vladimir Oltean wrote:
> On Thu, Jan 22, 2026 at 02:06:23PM +0200, Andy Shevchenko wrote:
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > 
> > FWIW, Cc list may be located after --- line. It will have the same effect on
> > emails (as regular tooling will parse and put them into email headers), but
> > will reduce unneeded noise in the commit message. List will be still available
> > on lore.kernel.org in the mail archives.
> 
> Thanks for the comment. I know it may be located after ---, but for me,
> doing that implies an extra step which I find unnecessary (moving them
> there after the git format-patch stage). I keep the Cc: in the commit
> message in git so that it's preserved across revisions.

What I do with my individual patch versioning is in the editor, after
my sign-off, add the "---" and put the version changes below. This means
git format-patch will do what it normally does, and as the commit
message is reproduced verbatum, you get all that included too.

You do get an extra "---" line between the versioning changes and the
diffstat, but that's fine.

So in the commit message:

Signed-off-by: ...
---
Cc: ...

Changes v2:
 ...

will work fine.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

