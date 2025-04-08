Return-Path: <netdev+bounces-180287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC755A80E3D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23F48A04B8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359E22ACFA;
	Tue,  8 Apr 2025 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OFSxVztI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805C22AE45;
	Tue,  8 Apr 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122481; cv=none; b=QSV/9nOgeLcBAfPchtxAUWczDznnkIlKUsbQFc8V25DLqmNShzkCg48qqlOjuTqcFMaO6PRNIjJm2+RWl2T0TV29R6T3GRkn42RXbQX97FABnp9DGFOIRi6502SI+ZjRSsBLM8NNoxaQOFNj6m0WePct/J5ignUrR3TelB9Ayb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122481; c=relaxed/simple;
	bh=oBvPXTDoawXXTh1nSPqX82Qcczec9zWjDK26sxmbimg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMtN2+DEh1uOG1BtUzRG+hUEvA1agOcUTcqa0+cYosQzesxJJqCF2SJEOCg75iPDQwY9a416hCW7DGaeErIBoFB91udOiB7zfa/Glhn/PfjGOcV/fXvxUJQLAATmlvqBsY14sse/LSqEJmacUD3m2813BWyxCWzJKUT0r1vXxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OFSxVztI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AMa6u84bfpisRdGUTui7ZAbRD3OzT3HWV8+rzJ/A6mQ=; b=OFSxVztIM2I0QtONqn2shMWwB7
	oDpN5BuFtbvpECYu7FQdHPgKaUA7FlTYiiIyEhfbWdNyg2w0/PzRz0LeadbBjU8LW2SpJQ3qTECdL
	xG7Udlot7lnceivkfXJcOgvak/pfmTAhN1kgcsBkvkMtlejoMc6QrRCFttXrkRuEtCkag7Qz9CwAI
	NTUuQCDWIHAgjFqyegNHEwF62fvlmLfhNJdB9y8IIU44FVZo29iwbd6wetU+426tkuhLBS3rjexyc
	ffjtMGHoKvGOqsHWg39l58oSwSpDWH9Wq8J0oGqJpUM+P5UeXXzhc4PW9VfuYiFWpOpNbXjaemXvK
	lrqRFXJg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33128)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u29va-0007ZZ-0Z;
	Tue, 08 Apr 2025 15:27:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u29vX-0001Ux-0N;
	Tue, 08 Apr 2025 15:27:47 +0100
Date: Tue, 8 Apr 2025 15:27:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Joe Damato <jdamato@fastly.com>
Cc: Michael Klein <michael@fossekall.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND net-next v5 1/4] net: phy: realtek: Group RTL82* macro
 definitions
Message-ID: <Z_UyYgkLAvbU0ufp@shell.armlinux.org.uk>
References: <20250407182155.14925-1-michael@fossekall.de>
 <20250407182155.14925-2-michael@fossekall.de>
 <Z_SPgqil9HFyU7Y6@LQ3V64L9R2>
 <96fcff68-6a96-49fe-b771-629d3bef03ea@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96fcff68-6a96-49fe-b771-629d3bef03ea@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 08, 2025 at 02:17:19PM +0200, Andrew Lunn wrote:
> This i don't follow, you normally keep register bits next to the
> register. This is particularly important when the register bits don't
> have the register name embedded within it.

Agreed - the worst thing is when one reads driver code, where the
registers offsets are all defined one after each other, and the
individual register bits are defined elsewhere and without prefixes
that identify which register they pertain to or comments that identify
that.

So yes, please keep register bits and bitfield definitions next to
the register offset definition they pertain to, it's way nicer to
read that way.

Also, having register offset definitions sorted by offset means when
reading documentation, locating the definitions actually used is much
easier. Using the same value (hex or decimal) as the documentation
also aids this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

