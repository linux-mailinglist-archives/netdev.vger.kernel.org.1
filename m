Return-Path: <netdev+bounces-255842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGYOC4KHgGnO9wIAu9opvQ
	(envelope-from <netdev+bounces-255842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:16:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EA6CB88F
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C87C030036DB
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 11:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD63612E2;
	Mon,  2 Feb 2026 11:16:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336B36074D;
	Mon,  2 Feb 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030964; cv=none; b=q1JLMUeW8fIq+3P0AlJWSm3EAhJ0F45MW8ufWlVbFHuLF4YZMW34TuRi18NBvrOe/ExJptoUgMkw8d6q9Q+2JfR2CDKB5CXBRboMbo2BnuTCnY6IndObEWywaMHj0OBFOZYXAT2CX/Co16UXEF3aunwP3kCwXPSFqcqRmxzc2rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030964; c=relaxed/simple;
	bh=+V2l2AI+iz4koqyoYFa4rFyV0qgxaJjUuwQW/iHCqvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkSqU4U0IZ3oldXZRLGzQRfFTF8qEZgoKFLM9FRBqahVtfhPyYfhS/VE92nHKnkT/ZksdW36Gq3f5dWllabV975AFKCOQ6D476yB0Ql6gLp3EPck7rZFABCilHUAGJbhqF8iZ1zPK0icSKoZl7ToiBIRHCk0kN1ZnZ2iGm5+cgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vmruQ-0000000081a-23b9;
	Mon, 02 Feb 2026 11:15:58 +0000
Date: Mon, 2 Feb 2026 11:15:54 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, lxu@maxlinear.com,
	hkallweit1@gmail.com, yweng@maxlinear.com, ajayaraman@maxlinear.com,
	andrew@lunn.ch, netdev@vger.kernel.org, bxu@maxlinear.com,
	olteanv@gmail.com, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	lrosu@maxlinear.com, chad@monroe.io, conor+dt@kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, edumazet@google.com,
	pabeni@redhat.com, cezary.wilmanski@adtran.com, davem@davemloft.net,
	john@phrozen.org, frankwu@gmx.de, jpovazanec@maxlinear.com,
	fchan@maxlinear.com, horms@kernel.org
Subject: Re: [net-next,v11,4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aYCHai1Fsedssibq@makrotopia.org>
References: <46226b74030f76bd04149ed5c92b3e263abbe6c2.1769817939.git.daniel@makrotopia.org>
 <20260131175243.1122906-2-kuba@kernel.org>
 <aX6keghdVMI-A6Fq@makrotopia.org>
 <aYCGNMAdZXsQnLKl@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYCGNMAdZXsQnLKl@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255842-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,maxlinear.com,gmail.com,lunn.ch,vger.kernel.org,monroe.io,google.com,redhat.com,adtran.com,davemloft.net,phrozen.org,gmx.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B8EA6CB88F
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:10:44AM +0000, Russell King (Oracle) wrote:
> On Sun, Feb 01, 2026 at 12:55:22AM +0000, Daniel Golle wrote:
> > Do you think it's worth to fix this also in other drivers which follow
> > the same pattern? (bcm_sf2, mt7530 and mv88e6xxx if OF node is NULL --
> > if there is an OF node it uses %pOF, and I'm not sure that's such a good
> > idea either)
> 
> So in v11 here, you ask a question of your reviewer. 2 hours later, you
> send v12 without waiting for a response.
> 
> Slow down. Give your reviewers time to respond before posting your next
> version.

Got it, just thought because the question wasn't related to that driver
but rather whether the same issue (or non-issue?) should also be fixed in
other drivers...

I'm going to wait now until all debates have settled and then post v13 :)

