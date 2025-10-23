Return-Path: <netdev+bounces-232244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B48C03220
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83ADF4E884B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2B34B408;
	Thu, 23 Oct 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qJ007V3W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8329A326;
	Thu, 23 Oct 2025 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246366; cv=none; b=i6iw/axl/n/hF/IuW9qLdaQK/1vEP1zUuIwLgDRa3U7VFnlCmSsYasbKo4yvi6bS+2r+glEY/v7YuApVpcC93ijGZOE0G2cwYxLBfWC0oOiay7C3fGS8FWwqkVuD8aSif/CootlVCkQCxI7FGPPHKfD4fgIeaWYOQbBmbcqYCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246366; c=relaxed/simple;
	bh=5TrQ4ReadJnIwufEtLKIZ+wUt/q6obr4KI9Yec1wPRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwt4IrNJBjIoBNWM7/atz19jtSgSqwa0D5ioZVL4WwnsDCUGxLM1qg9llkX6v1EUOIMkIyryTYqWf8xJDPVcJgAOWEsq46qOry4u8XiBCFJMnXUfp2h7nXlpd2jNH4VQCZ1mhVC9XNspqPNLfEH6eDEwqoNJMuFGeRyjN2jYH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qJ007V3W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=464PWrbWh1H9qK8kcv6CGx6Y3A8dHPHV/Bs4nGZeoRk=; b=qJ007V3W+Lunut+Y6O3OxCT+VN
	/6Yz7ctxkMWdGqg7eWZx25oVcFFTcHUPrjKNq/puCtyqvOM/n6GYr4dO0M9gXojQxiPfuGOT2iYlS
	hEELowNEjbMDVcuhap69DSq8yDIMzgAlQ9Tn/tHeKhFRZYjceXj4YKzR2e3072LdV80o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0dE-00Buju-OM; Thu, 23 Oct 2025 21:05:52 +0200
Date: Thu, 23 Oct 2025 21:05:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul SAGE <paul.sage@42.fr>
Cc: vinc@42.fr, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tg3: replace placeholder MAC address with device property
Message-ID: <6e1641fe-e681-414e-bd51-e20cf511f85a@lunn.ch>
References: <20251023160946.380127-1-paul.sage@42.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023160946.380127-1-paul.sage@42.fr>

On Thu, Oct 23, 2025 at 06:08:42PM +0200, Paul SAGE wrote:
> On some systems (e.g. iMac 20,1 with BCM57766), the tg3 driver reads a default placeholder mac address (00:10:18:00:00:00) from the mailbox.
> The correct value on those systems are stored in the 'local-mac-address' property.

Is this the DT property? I don't see any compatible in tg.c, so it is
not clear to me how this driver gets probed. 

Also, please wrap the commit message to around 70 characters.

    Andrew

---
pw-bot: cr

