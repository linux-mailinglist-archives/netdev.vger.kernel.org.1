Return-Path: <netdev+bounces-175297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685EAA64F9D
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7D41661DF
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9565158DA3;
	Mon, 17 Mar 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wic+sbb/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5E4A1C;
	Mon, 17 Mar 2025 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215651; cv=none; b=peDCit5dozcp63hE7vWU2bjHlD2TFq0Ucn3Z6IC2ZOZpbyQf2vKZvI/Un4GWm9MiXcTImAk9Q1YIxmHSdJYTcgLjJlafso77kFZwRTwMamV+kJa1B9R7+oU+Kd2w3RVGtZZGkErTNhwvVGjWCCWKl7fYZr7MDM6r30FvbR7rFic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215651; c=relaxed/simple;
	bh=DzH37UfXFhS0qsAr5+Goa4cCUsdvZCYwZL9iIvMydD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8eeyxaCEOCrRkV0NdWOAbFgWD89sfXBHXk7mdQhzUI+CsznlVYnKWPCfwQ/USHMrsOhnoBwlmukMOjOoZ/UhWk8YA+DYYCu0JZzKeD6zQ3RS3/lMY29tGkS8Gf/Pnd+Io/SgkEuiyv0dX89gJrtPwnIwfd7eGobH3Ayex8Bldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wic+sbb/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iNJJvO2bu+Nx0yChJk+GIzP3W85ueiBmXIziZPYbCvI=; b=Wic+sbb/02D7n4JVfpFeqLE3P+
	pJCxgsOJ6q1oubgXB2N9KrMuybB2/ntIuk9/EJjFchfkwKbMrUbp4KIE0AcSdg2AAdT6RG4KINigM
	gQ+E6izf3ww2MqXiXoSl3Jk9LjpaF/LKWWSZJp9CQVDESAe0RJ4G1QfFqlIua3aGlPkw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tu9sC-00683V-Of; Mon, 17 Mar 2025 13:47:16 +0100
Date: Mon, 17 Mar 2025 13:47:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, ratbert@faraday-tech.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, BMC-SW@aspeedtech.com
Subject: Re: [net-next 1/4] ARM: dts: aspeed-g6:add scu to mac for RGMII delay
Message-ID: <be284777-978d-470a-b38c-2f79a1d76134@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-2-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317025922.1526937-2-jacky_chou@aspeedtech.com>

On Mon, Mar 17, 2025 at 10:59:19AM +0800, Jacky Chou wrote:
> The RGMII delay of AST2600 MAC is configured in SCU
> register, so add scu regmap into mac node.

Don't you need to add the scu to the binding?

	Andrew

