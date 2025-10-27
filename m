Return-Path: <netdev+bounces-233057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0C6C0BADF
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4898D18A2F8D
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D097B2C08D1;
	Mon, 27 Oct 2025 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kqQVxuCS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D442C0269;
	Mon, 27 Oct 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761531044; cv=none; b=dnBi3hS/GHV3q7niivcI6D2SyOUFiVpPLt3ABC3qJEjWokebn3FGZg17p9YeF/mOGvuBeaxx3lpmqbTHCtAqeXM0jPbF6cg9jKCT/PdYSjSpVzXjpzcGa8PoT6GpRAlvTwNp4C5lXNOwSD6aVUXc0TPH2Pc4aXu337EDwS5BTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761531044; c=relaxed/simple;
	bh=NbdLCrUjtfVlTEdHY9PLnvIAzhp5OlD1x2Oh838UX2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6Ly1HoC0cAyad3IUriYXpaFhrSCywfjNbcOMHU+45BOKKPnrjgfP+PCawrIsed8vsbu+mwvqn5kS0CY5QHXOey2GUgPiUZ4hpL4ovJP26PPThRJpTQu75UuMZQkyInx8ov0xCRD1NHmmJm3LQl70DgaFcLpluEoSmEds4sGRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kqQVxuCS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T10yHN9xQQhtSif+fMluAF713gT0sRu+SWOyNYIrMSk=; b=kqQVxuCSWCkzmMRudTI2APnVqQ
	n6+wbguUSzN19EbGFiVxo6HmhPjwOUEIJ1RjkQ8IgJQd0fUJ35PLyQV403aTthkWT8U6XGMUptxrC
	dez6ThjbfwUX9h3TnCsEdYqOsbLAOfgaTZ6W8kNnpweww1GR0uG4F6jtyhde+3ujCZRw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDCgi-00C9K9-Mc; Mon, 27 Oct 2025 03:10:24 +0100
Date: Mon, 27 Oct 2025 03:10:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tianling Shen <cnsztl@gmail.com>
Cc: Frank Sae <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jijie Shao <shaojijie@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: motorcomm: Add support for PHY LEDs on YT8531
Message-ID: <70e72da6-9f07-457a-9e0f-c5570ab6fe9c@lunn.ch>
References: <20251026133652.1288732-1-cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026133652.1288732-1-cnsztl@gmail.com>

On Sun, Oct 26, 2025 at 09:36:52PM +0800, Tianling Shen wrote:
> The LED registers on YT8531 are exactly same as YT8521, so simply
> reuse yt8521_led_hw_* functions.
> 
> Tested on OrangePi R1 Plus LTS and Zero3.

In future, please could you put the tree name into the subject.
See:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

