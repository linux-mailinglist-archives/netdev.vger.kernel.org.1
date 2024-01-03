Return-Path: <netdev+bounces-61234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E65822F31
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCDC0B21510
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8798F1A582;
	Wed,  3 Jan 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3IzLCSvY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA861A28A
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FaC2Cmx83sRkZWGfOOwsZ9z/MLcl9GnReERD/IcXfRg=; b=3IzLCSvYWFBoz2oAdYNfFvesfy
	0qE6KC4rxUCbYHalNkeFF10Cz5sSH08oI7eHmtYlTlP2iCxwihnOQWL/vogMG4ctHb0H3vaPCoDSi
	sXozyAiAcZtRvbJZW/ImFMdi/E61cGoaTFXx36jgCE0zPk1LXubJDzIYjiiOabA71MOo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rL1vv-004GGS-D1; Wed, 03 Jan 2024 15:09:23 +0100
Date: Wed, 3 Jan 2024 15:09:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: Add LED infrastructure
Message-ID: <8f9b8a8f-6741-4676-900a-e5832eb31fba@lunn.ch>
References: <20240103103351.1188835-1-tobias@waldekranz.com>
 <20240103103351.1188835-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103103351.1188835-2-tobias@waldekranz.com>

On Wed, Jan 03, 2024 at 11:33:50AM +0100, Tobias Waldekranz wrote:
> Parse LEDs from DT and register them with the kernel, for chips that
> support it. No actual implementations exist yet, they will be added in
> upcoming commits.

Hi Tobias

There are three of us now working on this. Linus, you and me. We all
have different implementations.

What i don't like about this is that is has code which is going to be
repeated in all DSA drivers, and even in all MAC drivers. I've already
posted one patch series which added generic DSA support for LEDs, and
some basic mv88e6xxx code. It got NACKed by Vladimir. So i'm slowly
working on making it more generic, so it can be used by any MAC
driver.

I will try to post it in the next couple of days.

    Andrew

---
pw-bot: cr

