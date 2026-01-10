Return-Path: <netdev+bounces-248716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E55D0DA15
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7436F3000915
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDC0244660;
	Sat, 10 Jan 2026 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s0h9zmTR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E21C3C08
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768067880; cv=none; b=oI8gxnKlKE9aWPqPtJDwt8udK5/1IIyew7rVNeKgEdRs+ZsIcqB+LPxxsaoPdbu4oIUTYNwDVn77cxz861MnFRToWLAX/rsgUePBTpz0qaX9uqJg9Po4SFuuHsyb/ZQRCNx8p6Aw6acAeiGep7EZjK92d+vmxz7T+s1k6KwRT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768067880; c=relaxed/simple;
	bh=a1E/gShRFIxm3/Z+Fu6kE6VGp0w2AcVd1OzYG71aqq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWBlouHCxOcn4NrqS4BCD8VAGL66jp+4zIdGPSd60wbzf7TPyE4Q+wQHplwrWs3q+UPF7U87aFOc0GDB3XxwCDoZsQ/zdBmsGI3YNO3d3ZNsbMIl6p4CzqOqts95o3lielRxX0pU0gA0Y9oyTV84fMHyrBIBNEzvHOrXlF5lq8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s0h9zmTR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=puxfefFprNB3SQUbQpm6V3t5QUMMxdRvcQAt++54mWw=; b=s0h9zmTRwXb1EPr/RnNCKPcw21
	Hqtw62BZkvb5O67+F/f2/DjHzHkgVom9px43Z9Y546J2sZhngPacB+ky4rDCjBikMm/ve58KOKdE6
	VG3i0WfffFvWO3P4Q4O48xk+6+st6zXlU9QTwoyMu2IA0RP0w6BA5u78/swNmkodfoqU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vedDk-002EAY-3e; Sat, 10 Jan 2026 18:57:52 +0100
Date: Sat, 10 Jan 2026 18:57:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <jv@jvosburgh.net>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RESEND net-next v2 1/5] net: thunderbolt: Allow changing
 MAC address of the device
Message-ID: <b41a629a-4e71-4f50-b7e5-fcbec88cc488@lunn.ch>
References: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
 <20260109122606.3586895-2-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109122606.3586895-2-mika.westerberg@linux.intel.com>

On Fri, Jan 09, 2026 at 01:26:02PM +0100, Mika Westerberg wrote:
> The MAC address we use is based on a suggestion in the USB4 Inter-domain
> spec but it is not really used in the USB4NET protocol. It is more
> targeted for the upper layers of the network stack. There is no reason
> why it should not be changed by the userspace for example if needed for
> bonding.
> 
> Reported-by: Ian MacDonald <ian@netstatz.com>
> Closes: https://lore.kernel.org/netdev/CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com/
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

