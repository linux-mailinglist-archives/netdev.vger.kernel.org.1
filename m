Return-Path: <netdev+bounces-102359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F28902AD3
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F0D1C20EBB
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628626F319;
	Mon, 10 Jun 2024 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Oc0ke/5d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69816AB6;
	Mon, 10 Jun 2024 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056021; cv=none; b=S9FeAILTRtSW5rKLS8QOys3h1fGIqxg5Vi1kwdp0AJw2d8yUiBP+2azmyuII82+nrUS8hQ/IrV58qqiB4zWj0GbN8A/DQutkvQ3XEFiPhivn1aowI6H2/YuJlbq/l8gsgxgPZuBpfx6TukrZeT/TsqEGPSUvcTSNh4qS9jGc/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056021; c=relaxed/simple;
	bh=ez85eYPZIFWLit5B9AChaYfwww+u5CQV9dEvxEcQCwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0MgecEJw+WA4r5HVLkUBCDzPZFlFxgxMIIQMow7Bp7oGnSQXNfaYirCLueFV4ywsRsRIi6liYq3kY2iW1utcR/rLQrEcD6y2iabAmBxoSC3swLKWoDawiVcyBME3tXTY1K3E29oZiNK5wQZjqkAeV+V3hiI9cUj7uY4gUK7gYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Oc0ke/5d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a+TO7w2mi3YAysdgG3EQcCV6pyoeV6/ZVAZ0tqpKj/c=; b=Oc0ke/5d69pJRX5IgFUyaJQM8k
	LfKB//a/aJoJpsgQpYssJobe7hy3DFBebC0vQ2insfqIRFKfL6gx5kOgM33HIy3RgYSUgcgJfCsrq
	2gux21OYTOYLtDr6Kx57cCq6AVn+bx4LwuxkQViFyERgnZeiS/EX8TvEFRLTv2cEHwzA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGmql-00HKZv-IK; Mon, 10 Jun 2024 23:46:47 +0200
Date: Mon, 10 Jun 2024 23:46:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 03/12] net: dsa: lantiq_gswip: add
 terminating \n where missing
Message-ID: <50553bec-f9fc-43c8-a176-82e247f80214@lunn.ch>
References: <20240610140219.2795167-1-ms@dev.tdt.de>
 <20240610140219.2795167-4-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610140219.2795167-4-ms@dev.tdt.de>

On Mon, Jun 10, 2024 at 04:02:10PM +0200, Martin Schiller wrote:
> Some dev_err are missing the terminating \n. Let's add that.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

