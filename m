Return-Path: <netdev+bounces-131403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E6998E730
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53291C244E2
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA4919E99B;
	Wed,  2 Oct 2024 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yhePrbkq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31946194A6C;
	Wed,  2 Oct 2024 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912473; cv=none; b=uWwYVO/9WuaPJdcWp4mueD0cJHFXxKpM2cFwUkmuq0PyGmVqpBlHI2RdfXlMHdr1zdTmQqKe249y9Oom1Now7o8O1JmnSD4BAR0llrTAR6wyz/5Vgdoi7PoBx//DrrYXUNhJL3g99Z41VcigNWt995e8vcY6dpyM/51ym/zIwD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912473; c=relaxed/simple;
	bh=4SwDa8lM2MdfWnNuMuaKIAnYB6m3c8l0LOu0J9MotgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBN+YbW5PWrFA9bfgPTATQGNoBFosnjQJ5M/bufAVZY5kUIwbSp8VV4kEharpPM8b0lfl4ZaqxAUm7NYEVRGvApC73ReUBh90Cyu78Hka/vUFfZSM+htddkZKXN80zSMMXlv8wsJkOGWam08muW0i8r6q8cH59/l56I77+IpC3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yhePrbkq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EhSIo3f8674lHyEmzcNCF+aHuXIgRrjkoC0xeCu+z4c=; b=yhePrbkqBskmklCFPJE7mwAPzG
	FRvx5GSl6Kg6atYN/D2Agel/FZK7NghnERP+p12iHz+tF3WpQD/YKRQwsxE4E2smfcYPqpwEi1VF1
	bvl4l++AGTNPfnjKD/dwglAJcBX0389wt8MI/M274+DZlXIC494CMXViinVjZdnvNG5k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw8xq-008uCQ-Sa; Thu, 03 Oct 2024 01:41:02 +0200
Date: Thu, 3 Oct 2024 01:41:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 08/12] net: pse-pd: pd692x0: Add support for PSE
 PI priority feature
Message-ID: <1e9cdab6-f15e-4569-9c71-eb540e94b2fe@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-8-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-feature_poe_port_prio-v1-8-787054f74ed5@bootlin.com>

> +	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
> +	msg.sub[2] = id;
> +	/* Controller priority from 1 to 3 */
> +	msg.data[4] = prio + 1;

Does 0 have a meaning? It just seems an odd design if it does not.

	Andrew

