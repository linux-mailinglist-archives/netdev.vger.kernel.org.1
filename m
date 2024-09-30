Return-Path: <netdev+bounces-130628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A198AF32
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4999C281E20
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14534154C05;
	Mon, 30 Sep 2024 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZB+GR19z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C827EDE;
	Mon, 30 Sep 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732017; cv=none; b=KNwXWiVM3Hp+gwCk2q5t0EHLRhqgLY2G/96xR+jyfj9ob6oFq+Ly0tmg+af5OyTlfxWJm6jsfGemYnedCKtkSKmxywbGA65oZSCZggtrJgydL3kZstAW+PWbf8GbQ6JhgmjD1jljFHRXfP5vg/Q3LKS4frgE7MjHebbTHIfMJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732017; c=relaxed/simple;
	bh=/SRb6Jaylu4nikGcNmpwMw1bw3/7CwlBvKRUqbu/Ye4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuFR43glBah1/EDya7KiNQ0OmscVDsMO/0yOvb9zY4RwDTt63JKstQfdidRzRtYGqDJnSp+sChy4J3aTfjvV1/xdbhWBPlD3MBMI6irENVpo4CsI8J0zYw87N2TjWpWyZQ1k8XdJbJJ8jY9JV7aLThfDdnNKV9GIUyLP0YJ/J5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZB+GR19z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tMoXWmbk6w2tetKwiah6k8IcqLtsrPCKf4dOWdpPRDU=; b=ZB+GR19zZEGaHm7Dxy6pqEpghx
	K0fE2ZiZZjS5oGfggtkaGpn48/Vkit/qePPbvtHMz0hsprwhicEGg1rq9mF+ooi1yOSqM7eKCYqo8
	DlSqAYMfjBxcLtxJ1my1aCjKqbPb3s+pCH6tM7mONIAkPbBPnjF7rpnEX5QWuivyfNF4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svO1B-008fY1-Br; Mon, 30 Sep 2024 23:33:21 +0200
Date: Mon, 30 Sep 2024 23:33:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	tobias@waldekranz.com, anna-maria@linutronix.de
Subject: Re: [PATCH net-next] net: marvell: mvmdio: use clk_get_optional
Message-ID: <d4ad72ed-9826-4524-8c4c-0fddc97a8670@lunn.ch>
References: <20240930211628.330703-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930211628.330703-1-rosenp@gmail.com>

On Mon, Sep 30, 2024 at 02:16:28PM -0700, Rosen Penev wrote:
> The code seems to be handling EPROBE_DEFER explicitly and if there's no
> error, enables the clock. clk_get_optional exists for that.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

