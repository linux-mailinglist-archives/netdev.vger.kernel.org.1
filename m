Return-Path: <netdev+bounces-116492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4218294A915
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737581C2101C
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D71200138;
	Wed,  7 Aug 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q/bdx3a/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C661EB4BC;
	Wed,  7 Aug 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038803; cv=none; b=WOqGi1j3V4EhlVbSC8zvSnX/RQYt/NNwZ9XR07+xHotyvHG/lobVfEiaWcUspfHRPieUOaiJ1uK1CcyXNK/SjPy8fmZn3VYuXdZib5ZvMm7OMP0Ns9tlokTFvjgi9ezMHqupefDdg3v1gGF/+hVUt1tBjqKmh55gL+8U544jh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038803; c=relaxed/simple;
	bh=ot7cc4U0rkJ0axOdl7GNhQJsZ44e5aRbMpFGjG4Fusk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0bVaLgzHHq9P3htnkOkSsN0VJAjarDuGlyV9pN56SV8nUYitEqICNtjvMMa1j3N7nAtRcGuhxfB2PGg2mcnr4/X+fUOu1c1VYNeBFreCsH4+UP1Izae3Q+rkiXMTIbrCVjTKguqo2E/Phf0w29DIEwyjosbf8HGJ4NXKmXJtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q/bdx3a/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cT79HP6UJo3eodRh6aV2qOpbH6cxSuNy98qu2H/XT6k=; b=Q/
	bdx3a/iCMRW93p5UYZeU9dy+pg1tIOl1c7FSTIXvhsztkVrHxwOd8sBR2zenA+DcQZlBVUX7YjPxf
	QGrwBBelAZ33HEfUCf+cjCVoNvj34C3rj5Z5bEl5HIYsPPvGxB30cidceRIMpz6UvS2icAHHjVxWu
	TDF/3NxXgufe1fo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbh6L-004Cqr-0s; Wed, 07 Aug 2024 15:53:17 +0200
Date: Wed, 7 Aug 2024 15:53:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Jakub Kicinski <kuba@kernel.org>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.li@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH resubmit net 1/2] net: fec: Forward-declare
 `fec_ptp_read()`
Message-ID: <1d87cbd1-846c-4a43-9dd3-2238670d650e@lunn.ch>
References: <20240807082918.2558282-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807082918.2558282-1-csokas.bence@prolan.hu>

On Wed, Aug 07, 2024 at 10:29:17AM +0200, Csókás, Bence wrote:
> This function is used in `fec_ptp_enable_pps()` through
> struct cyclecounter read(). Forward declarations make
> it clearer, what's happening.

In general, forward declarations are not liked. It is better to move
the code to before it is used.

Since this is a minimal fix for stable, lets allow it. But please wait
for net to be merged into net-next, and submit a cleanup patch which
does move fec_ptp_read() earlier and remove the forward declaration.

     Andrew

