Return-Path: <netdev+bounces-197592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AAAAD9454
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7667D1E47AC
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AA422DA17;
	Fri, 13 Jun 2025 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u3yL3rS2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181E22A4FC;
	Fri, 13 Jun 2025 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749838938; cv=none; b=BsywMsGQcEPWlM8iG0LSheIF9yzcg61IHRB8dVOV1MYy0e7zBcJnvaZthdtfunWJV5ElW8aS8m6+IQUKp/sfYslLvcm/EHp1QmQrKCvHQCwmHgvA0DhsHyxNchxW3c6n+zPZafKPwFwcz5bVukWCB24WttxhKmtDAmX7bLa8sVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749838938; c=relaxed/simple;
	bh=clWfoyF/mtSbm1/X/8TvydgfywTH2e4h7wUD5Hf6mqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVPI+Rvp5gUeORh2RuGBe8RQ5OR/IQJLXgWu05VM1Pg/Ad5LLccfmKYDpAkM10/00sNqGZVEjT4ooVrNraTmRXqkf367Ol4jQ8qNA49cMbaw2qfYWNDqixIvq5ij4bfaao9iqWRWmLh9ZruSOYweKPYzZ5nhaJI9POu4VXF25M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u3yL3rS2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e+2ZgGgXqIukAKtz0KxvZTdIj9TTKcQVcejoF6HxVpE=; b=u3yL3rS2JcR5UYCXC0rHTxGyH7
	ct6l+QphsNU8mqJkRP4Ivw8uIeuAyq/uHhUH53oZHQa/0q7MmperxkjYvBrnm8pAkbUPzEEQm3Xab
	xFDRtb1eZAuR+9iYT+9fPLpleRaw8xShNWU5o3hX6MV79fTTxR84k6Es7jxxgUuxu4LI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQ92X-00FkqH-09; Fri, 13 Jun 2025 20:22:09 +0200
Date: Fri, 13 Jun 2025 20:22:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH net-next v2 03/10] net: fec: add missing header files
Message-ID: <0822e05f-16a3-4077-a046-1519f9f0ad98@lunn.ch>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-fec-cleanups-v2-3-ae7c36df185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-fec-cleanups-v2-3-ae7c36df185e@pengutronix.de>

On Thu, Jun 12, 2025 at 04:15:56PM +0200, Marc Kleine-Budde wrote:
> The fec.h isn't self contained. Add missing header files, so that it can be
> parsed by language servers without errors.
> 
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

