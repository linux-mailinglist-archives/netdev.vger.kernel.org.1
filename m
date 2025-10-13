Return-Path: <netdev+bounces-228947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA43BD64D5
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 22:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C640188BCB7
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEE82DE1F0;
	Mon, 13 Oct 2025 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dod3PK9j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654971D618E;
	Mon, 13 Oct 2025 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389120; cv=none; b=r7zO2FFuAhjfapm2+Cmnz70IBrIwGxug7XA9rZe6Ipp/TW9j7jO54cngRtX4notLniDlcKbMQfjrk4RKFjucHEb7p4YTgTqFm5TNED0GFRZ8LVlQbBDx2Ikpjd+Jl3wYx9yObRqXDpUogvh/gBTeSCNoNCeGmg2LuvI0leE5fK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389120; c=relaxed/simple;
	bh=ZLMOYXdGkPVZxvZex41E5YaIlwF+jW9uMwcs1J+3ERk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRkTrxhTXy7f6yp2XS4KZ4grIePTTpEjzQghRiKFyXn+821nE+JlapZT6N09JZ666HOU7OXw0FC37WL7l5DgPpKEM2WwF+gq5nU/6qYn4wHlwWgv53LF1e1jRawvJ8opzu94fXfDkbkSq432SSZnEXA+BWm8ElkMGu5NfpV2+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dod3PK9j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lefGc/4TkfHmx8o0Y4gAe9QYz9+YikedJfN4gQ335Ns=; b=dod3PK9jTI2hpvAD4+SKvmXcd7
	ggs5kba0Ilft1Rnd6hQ++NTgcasRLB+xWEW+79fXQpN92Yx1MafthZrF3iNzBSKAfvyqLXqxPp5K4
	UlmlDTtQQdwhWB66zt841YBRfzeSQmHJsm3WPH2OILEKsb9lW6ahtczBTD/8tR+SaU+o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8Pci-00Aq3X-2f; Mon, 13 Oct 2025 22:58:28 +0200
Date: Mon, 13 Oct 2025 22:58:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: add myself as maintainer for b53
Message-ID: <345b0ee5-aee1-43c9-83f6-3b03f367bc8a@lunn.ch>
References: <20251013180347.133246-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013180347.133246-1-jonas.gorski@gmail.com>

On Mon, Oct 13, 2025 at 08:03:47PM +0200, Jonas Gorski wrote:
> I wrote the original OpenWrt driver that Florian used as the base for
> the dsa driver, I might as well take responsibility for it.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Thanks for volunteering.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

