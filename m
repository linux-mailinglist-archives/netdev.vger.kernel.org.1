Return-Path: <netdev+bounces-255839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFATOc+FgGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:09:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A308CB7F3
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D4A73006B7E
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 11:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C54A35EDD7;
	Mon,  2 Feb 2026 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F9Etb5hI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D203E35DD00;
	Mon,  2 Feb 2026 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030537; cv=none; b=rEkW/HcfaRq7LQR1hyOVHNiaymhexBqArVBTwpytteq0XB69xYAuSKWi+Vwu6kCvrm+NBCKhEnGzOwr+5Ly1Hq2/xujSSpRLFsQvtr7JwPb9goh8sNKi4dML4C0KwYnAQbjGbYsiuE3pGYcDkCmkmL6gUA4VYjBMQA6QDlxDFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030537; c=relaxed/simple;
	bh=PvKAovUNaJvC8+s0Jg843NaSI54s0Z6Fd/KSFiYQhqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA/pnjffIe75LpcaSUiz9DDsNs6K9OPReAVIpa6jSy30jjs8rYYLJQ1vvn5uZK2gDM5QNicnMAsEgrKbqFuGqgo0fWuOPr/+8OMIb8RexFELG0k/vz0pLwE7P/1nL79GJ/JCKaSXLo86oEIpVcRTJsopltjprlXumTfzW4wOpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F9Etb5hI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8GXEhcxnrPJI4HqzcHeRLssdsPmoUUVFpCoHDTkxVAc=; b=F9Etb5hI2eVAOtYnfwq1PhKWRr
	Cxwvs7OzaRLWoOt8d4xjM8NxNUc3bgFlM1aLM5AwIZXteKJtvYHUlhhpJq1uPvMLhRtZ3IU8LCH0K
	Rt4Y7jHpANwYAwqP6gDAHp1CwCKNvUfgLFXJEh0uYItOHCFsVLJv2HnRwYJ3cEo2EYm4rUGYHm3Nf
	mE7dLZC6VFu+oCc76dQn09tf5fL9Y6yPuxyARZLM/ycGAZebyBvmYMyBZBiLudkyUuZjY4w/S/ENa
	Fro0z79WPAvtQmDgPlfluyuW9MLatrhNiZ9KM5p+bL8TzELvT5Nb/A4WMR2a15XN8vlDlfMotX/gs
	GYc6ln4A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53754)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vmrnO-000000003vI-0rCx;
	Mon, 02 Feb 2026 11:08:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vmrnL-000000003LN-2QJr;
	Mon, 02 Feb 2026 11:08:39 +0000
Date: Mon, 2 Feb 2026 11:08:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v12 3/4] net: mdio: add unlocked mdiodev C45 bus accessors
Message-ID: <aYCFtyggDldJ-JMR@shell.armlinux.org.uk>
References: <cover.1769908155.git.daniel@makrotopia.org>
 <f50a5384d9d8bf677d016deb5844f0651c4b8a4f.1769908155.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f50a5384d9d8bf677d016deb5844f0651c4b8a4f.1769908155.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-255839-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8A308CB7F3
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 02:25:03AM +0000, Daniel Golle wrote:
> Add helper inline functions __mdiodev_c45_read() and
> __mdiodev_c45_write(), which are the C45 equivalents of the existing
> __mdiodev_read() and __mdiodev_write() added by commit e6a45700e7e1
> ("net: mdio: add unlocked mdiobus and mdiodev bus accessors")
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Sigh, there's too many versions of this patch series. While netdev has
a 24H period, there is also this - note the last sentence. The reason
this exists is to stop this exact problem, where ongoing discussion is
split across multiple different versions of the same series.

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewers
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for reviewers
to recall all the context.

Make sure you address all the feedback in your new posting. *Do not post a new
version of the code if the discussion about the previous version is still
ongoing, unless directly instructed by a reviewer.*


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

