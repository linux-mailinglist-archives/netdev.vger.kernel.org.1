Return-Path: <netdev+bounces-111258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F0A930706
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 20:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B671C2123F
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7884413B2B2;
	Sat, 13 Jul 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hb3SY8YR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409A25779
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720895639; cv=none; b=pVfJF9JvciAb0svMbQhYP/v45HskomxdJwE2ZmMPudOUEgQIxPl1zdIOJUVWDXUoGz2SE8OWzrsu7wD374Lqxb0OfI4K0L6oLnKRfd7TweJJwUHmlf8bXtEGEIIMDMamDQ/wW3Bcf3Xvx3IUV2jaDLr5c2ATwbzfHgJmfSxwfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720895639; c=relaxed/simple;
	bh=VdtnTZerjEWluUkjs7l2OrXmMX0m8OfwoGJDz3V6rV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXm5OYHPJKqt1nLxKMUJSJlXHefjPvPlD7N9qffuM9WC/cbYSgtafB/dshtJgt1I1CENN6R/enWDEyRdGKypGkwqLd2CCiWVix99J9X0f1tFcQrYUdwmI+HZ8J7qSusuSYYwNUurx64MoBx3SHgvZmeUmLej3AHEFR8tFmKvmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hb3SY8YR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=svmbo4tNiqsHV20/VXzy+oMFDHLSGntTfysFVEjuAZ0=; b=Hb3SY8YRlehKQe0FKwLExCIj9g
	zkTdwGAtJWDfYYUhU75w9rzUOGVltpyYQFQclGv5Fqy3EaaBjAlpHY1amX1KwfafsRJ5J5sZzw2R4
	zL9ihJ3MglJ39vS3O8CY/4A0jA7FIDwUYeoVd/+zh3ZCqkV819FEeFFEdw+mwXIQ893c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sShZC-002TEo-LZ; Sat, 13 Jul 2024 20:33:54 +0200
Date: Sat, 13 Jul 2024 20:33:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, kernel-team@meta.com
Subject: Re: [net-next PATCH v5 02/15] eth: fbnic: Add scaffolding for Meta's
 NIC driver
Message-ID: <44e46e45-09e8-45cf-97d0-3518039fdc3b@lunn.ch>
References: <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
 <172079935646.1778861.9710282776096050607.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172079935646.1778861.9710282776096050607.stgit@ahduyck-xeon-server.home.arpa>

On Fri, Jul 12, 2024 at 08:49:16AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Create a bare-bones PCI driver for Meta's NIC.
> Subsequent changes will flesh it out.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

