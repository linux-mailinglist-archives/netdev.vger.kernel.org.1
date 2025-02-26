Return-Path: <netdev+bounces-169883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A40A463DC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96711899474
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D694022171E;
	Wed, 26 Feb 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NX4BKJiv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF72222A5;
	Wed, 26 Feb 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581863; cv=none; b=myzrd0cQF1bJWov/5L25FsovV0CxDyPRcN9DH1Uq+qZToHMzjLUfOz2qTryLTBesZzsbFQE0rntwaxAW3aIlHk4pw/6rECllJlrPoXB8kjeDewh2gCgJA3sP3+k26i/aZkPhVwoO0zguRsKq2aT50Twjc60guHjBdmDUK/2ud10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581863; c=relaxed/simple;
	bh=VzDBuRQvjb/GCcIODjubWoSHDKtfNYXExhZZfzkCsx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzBvp9tXL1Zn9DUEUXuxS2mcLRo6aD/zI/l65hOjM9rz1G4u8qnjkXC6SL5LVmRTOZqZuU2WzJcyc1XpaTVOEph/39gWoxcLVqmOsry1Mk72kgnpkcSoX42uap+/gt6ggeUYpacwbRjVxZmah8/pAyzy2dr2BZXVc4DdzV0ZlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NX4BKJiv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=grc4ux5OReL3pnr6Hl6e4E/LOxqUGGiI9yJSHG5rTCA=; b=NX4BKJiv9c2+CNDXdJpcUUYJkd
	+nvZ2nub2Ay2Af1ymc9/+QbDT87YhaoL7cOwZrhdJWxzyFbUT9FFv+Q66uEVgcvES8NRzhTqk2n3O
	1xZaT2tggAg+XunsWSae5xwvReVOTuwdvZlI7NXoKPRqFLRBZydvdEHIJOtar7jPb+88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnIqr-000HvP-NG; Wed, 26 Feb 2025 15:57:33 +0100
Date: Wed, 26 Feb 2025 15:57:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Message-ID: <b85b14c1-611c-4002-8fc9-cf23bc849799@lunn.ch>
References: <20250225214458.658993-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225214458.658993-1-shenwei.wang@nxp.com>

On Tue, Feb 25, 2025 at 03:44:58PM -0600, Shenwei Wang wrote:
> Retrieve the "ethernet" alias ID from the DTS and assign it as the
> interface name (e.g., "eth0", "eth1"). This ensures predictable naming
> aligned with the DTS's configuration.
> 
> If no alias is defined, fall back to the kernel's default enumeration
> to maintain backward compatibility.

GregKH and others will tell you this is a user space problem. Ethernet
names have never been stable, user space has always had to deal with
this problem. Please use a udev rule, systemd naming, etc.

	Andrew

