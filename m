Return-Path: <netdev+bounces-162155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36877A25E87
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4980F3ADD39
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE3C208969;
	Mon,  3 Feb 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JyR4WKj9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427E201270;
	Mon,  3 Feb 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595791; cv=none; b=nK1HLSdepvuIPliRZU2Pm92OKnPPz67YNgGRKWIl7KnBKUB2iXmhYWPhJPHJ2tFFl0qBqPGLbAWdMZqKgyzC3/TgO+qeDsf06sal3AqkxNxir7iBQQd4eWbAxioLi/JTDjMKANQ9W+lRZ3KeRyuzAriOuLMeBgLBdOR4afdjXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595791; c=relaxed/simple;
	bh=CpdxEgWxsh/HD3WPMCKSXTB1zyGno1z1Tpc3+MlTe9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC5/htlN5o7rsp6z7IJxgdnhPLk6luXiSRwlwJfwq/sPAlGTqEvMtPSq0ShJ3cocPk89hUuYuTdYHehXWYndj64gYMeZGlbshCBT2u867V9OHK/fBO7ylPW/AX1xgg7pBJWNKfeVvgHDymB7cmHTVmap5objf+x0rwKZbx4mkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JyR4WKj9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N3u4JBf86fRDaSu925+9l7ZXKLUFVUb4F+sjhB0CDjY=; b=JyR4WKj9O7+8WVc6f0z25l3VeL
	GpN7qM6xi4rS8W/kFcOaJgCCq8nZFNWlvePbHN8EFfQruPlfI6Mf5zH1w4hnsA3Uo+I3JLhe2Lo4H
	tzOTntfq1IGMMG3CF/wIC5gwS0xWNCapdDQ5+5o1TrYzcT3w1Pw1UTEyF9Qf+XCb8SM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1teyBL-00AZ0H-LV; Mon, 03 Feb 2025 16:16:15 +0100
Date: Mon, 3 Feb 2025 16:16:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ratbert@faraday-tech.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dt-bindings: net: faraday,ftgmac100: Add phys mode
Message-ID: <e8cf65f4-a7d8-486e-b055-11f304c8feae@lunn.ch>
References: <20250203151306.276358-1-ninad@linux.ibm.com>
 <20250203151306.276358-2-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203151306.276358-2-ninad@linux.ibm.com>

On Mon, Feb 03, 2025 at 09:12:55AM -0600, Ninad Palsule wrote:
> Aspeed device supports rgmii, rgmii-id, rgmii-rxid, rgmii-txid so
> document them.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

