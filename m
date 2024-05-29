Return-Path: <netdev+bounces-99207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE78D41DD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9677528703E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 23:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE11CB328;
	Wed, 29 May 2024 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="diGMsovk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CE15D5A0;
	Wed, 29 May 2024 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024452; cv=none; b=MDAu7Nar/Rb0HTNB8S5t0TuNHEvrbNPiK85gpu4Gug5387F7+XjRp/psorc1bnGQAGwonccmpRJ7X/zUqC3WdRIZDgpEIP7B+XbQD7eGIb9S+q74zvg5A+WMLTkMOjJZt4/islALem2PHoM6ocBroW+v0QVgPUnkkSDQK2TcJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024452; c=relaxed/simple;
	bh=O66tJp8SsOURZgCfCBnNp3tlo69phkl6Wc+whNYcxn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlxZTDxT98Fjn+K0fLFBbUykgWpCGRH29Cq3j4ABqLQIq2U8PMCnz6kNJUZ3evkxxL3zbvtgFFeJV3idi5NMly3ZSpmfBAoPy5T6jRgDDz4HaCVJA97SwIYN+Fe2gT3qnJhTXp02m0LvjaoIhQ+zKMNouoCbyRKTwm4vAZdYW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=diGMsovk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hVTZvPLU/CqK7pqt4DIZRXqEAzW4xgug/5xCB3GNQoU=; b=diGMsovko+dnfmZUS4RwN+/ORC
	2TZp3ZxMumDsnauaAOvoGqVAdSgZm618w3ZsajKh2ScEU8LBDqRuCd9e80EEDEkYbyVJAqvNiXiXT
	ZBcrhhSQntSie3J75Umjjsqe/A1hQ1JgF+qPFEVU2ACSBhHp0HYc/NBkPiEekIF82CbY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sCSUZ-00GIcm-TM; Thu, 30 May 2024 01:13:59 +0200
Date: Thu, 30 May 2024 01:13:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH 4/8] net: pse-pd: pd692x0: Expand ethtool status message
Message-ID: <d6aab44f-5e9a-4281-8c67-4b890b726337@lunn.ch>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
 <20240529-feature_poe_power_cap-v1-4-0c4b1d5953b8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-feature_poe_power_cap-v1-4-0c4b1d5953b8@bootlin.com>

> +static const struct pd692x0_status_msg pd692x0_status_msg_list[] = {
> +	{.id = 0x06, .msg = "Port is off: Main supply voltage is high."},
> +	{.id = 0x07, .msg = "Port is off: Main supply voltage is low."},
> +	{.id = 0x08, .msg = "Port is off: Disable all ports pin is active."},
> +	{.id = 0x0C, .msg = "Port is off: Non-existing port number."},
> +	{.id = 0x11, .msg = "Port is yet undefined."},
> +	{.id = 0x12, .msg = "Port is off: Internal hardware fault."},
> +	{.id = 0x1A, .msg = "Port is off: User setting."},
> +	{.id = 0x1B, .msg = "Port is off: Detection is in process."},
> +	{.id = 0x1C, .msg = "Port is off: Non-802.3AF/AT powered device."},
> +	{.id = 0x1E, .msg = "Port is off: Underload state."},
> +	{.id = 0x1F, .msg = "Port is off: Overload state."},
> +	{.id = 0x20, .msg = "Port is off: Power budget exceeded."},
> +	{.id = 0x21, .msg = "Port is off: Internal hardware routing error."},
> +	{.id = 0x22, .msg = "Port is off: Configuration change."},
> +	{.id = 0x24, .msg = "Port is off: Voltage injection into the port."},
> +	{.id = 0x25, .msg = "Port is off: Improper Capacitor Detection"},
> +	{.id = 0x26, .msg = "Port is off: Discharged load."},

I don't know of any other driver returning strings like this. Have you
seen any other PSE driver with anything similar?

> +	{.id = 0x34, .msg = "Port is off: Short condition."},
> +	{.id = 0x35, .msg = "Port is off: Over temperature at the port."},
> +	{.id = 0x36, .msg = "Port is off: Device is too hot."},
> +	{.id = 0x37, .msg = "Unknown device port status."},
> +	{.id = 0x3C, .msg = "Power Management-Static."},
> +	{.id = 0x3D, .msg = "Power Management-Static\u2014OVL."},

Is there something going on with UTF here? the \u2014 ?

	Andrew

