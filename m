Return-Path: <netdev+bounces-290395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OpNDPr6DmoSDwYAu9opvQ
	(envelope-from <netdev+bounces-290395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:30:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCAC5A4D9C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDD51309E80A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B943CF967;
	Thu, 21 May 2026 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sLOUzZvC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70033B5F48;
	Thu, 21 May 2026 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366278; cv=none; b=KdMHDPHdJuP4Yon/Iqu9ioZMKbFspCHiLTK2m8H9rxWORzHyi7qrf7mUkUC6k99sdIacPL6MtqRHeA0wvjs5yB8Exe5JDGJNROVIzfmQEt44FFrEFkxg7nYdPUDYzC39mpo173Laxsi+0jQrgWwLgjBh15C1dfvIlxbHH9kpecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366278; c=relaxed/simple;
	bh=pgR/sfOkC+dxjzDy3Ty4FCZCllfFQJu94UTUwiCulR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dxa6Hped6Z1tn8Tc4WI4b5DcpZ09cZB04NjzMH7XzbOc9IjCgnCMq6hhvQkFYBizACcAjpmIUbPokDn+aDEMxbHrFYvqDVe1SoR+mOS4fU9xw6fGUKZ/wX9+Gkuxx7POhh9b4NhsaRnTXLR88F5Jp+A3vbt4Y8TNCPnADia8KLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sLOUzZvC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6Sq2Ha1ZC8o+rRc7gR1Qy/D/3XJfFdHu8duTVUUw/fQ=; b=sLOUzZvCCAz6CYaKHMGpe2AFD/
	GrJoU5KRtsxRsew7SdzfePt/+2C7sZigzcmH30yqXDryrfhlTQ2zDn7WCEVUO80qKQqslPu4H7fLu
	mVcYaY4WpBtvcD4jOLXx4jWSlWR86edXqixhLH+OkOEbBzK45KXs9ozWdItZVvQ9MrRw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wQ2Rm-00411s-2F; Thu, 21 May 2026 14:24:18 +0200
Date: Thu, 21 May 2026 14:24:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Cc: "anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>,
	andrewnetdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>,
	pabeni <pabeni@redhat.com>,
	intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: e100: replace silent 'hope for the best'
 with debug message
Message-ID: <db588334-0871-4b83-a020-da8f621816d5@lunn.ch>
References: <19e49280392.4757403170773.5767589851918809405@zohomail.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e49280392.4757403170773.5767589851918809405@zohomail.in>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290395-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,zohomail.in:email,checkpatch.pl:url]
X-Rspamd-Queue-Id: 5DCAC5A4D9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 11:40:19AM +0530, Ashwin Gundarapu wrote:
> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Sun, 10 May 2026 15:09:12 +0530
> Subject: [PATCH] net: e100: replace silent 'hope for the best' with debug
>  message
> 
> Replace a silent return with a debug message when no MII PHY is
> detected on known variants. This gives users visibility into the
> failure instead of silently hoping for the best.
> 
> Found by checkpatch.pl inspection.

Please make sure you really do compile test your changes.

Also, look at the history of a driver. How old is e100? I guess this
driver has been around 20 years? If this was an issue, somebody would
of fixed it 15 years ago? 10 years ago?

Please consider checkpatch as a tool which says there _might_ be an
issue at this line of code, not there _is_ an issue at this line of
code. You need to look at it, think about it, consider all the ways
checkpatch could be wrong, and only once you have convinced yourself
checkpatch is correct, fix it.

    Andrew

---
pw-bot: cr

