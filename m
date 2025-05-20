Return-Path: <netdev+bounces-192080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C78ABE800
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351E618956CF
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 23:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5995E255F2C;
	Tue, 20 May 2025 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RV9O4OWG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B00213E76
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747783509; cv=none; b=cCnhkUGU1SQRg1jZIcPRxjJRWeFIrg3woQMCqchmt3nxuAfMnWmZ9Tr8eJOgEvbHnGxr5IvKteOjvwWaFF2CrTodPOH985q0SXnYKaOlHqDQAvhkWKsLm9ulW1k/KUGr6n0WrTI045++P5JZHu7BE8ZHq6XGiO1EysYJfJ34uns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747783509; c=relaxed/simple;
	bh=0nAGhdSt8KKovTH0c2u+nYiWrkV9cxmVHZT0NjVS158=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3wZQnZWE030m37rs/ISmCZCL4pL7f1b7cegg4kxvKy7PPYNBUfWoIw4FvBdUMrZREWBbOdByYkscI+R92OxFA/yJw2FY1Ix3f7VXOTJqdKmWV0DJNLlq5pn4d0sFIU6rPShmu5R6hqhTm1C/paRAtarNRIixfqYjKvPJB0jDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=RV9O4OWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AEAC4CEE9;
	Tue, 20 May 2025 23:25:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RV9O4OWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747783506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuu/7fl+tvtLIiwh+f++ddFznWSzjojrQ3mv7QSHujE=;
	b=RV9O4OWGpOsDv0b941CB9fcNkOMiPf2bglBs7GjAWJjhMu3xLREPvgsRWIfC8jHxzhcLwf
	lMN57OCXhxhEScopjHlW1W6Y4SuP0Q75dGz2MILftnatZp+nLWHXYRaEFFFV4YRJlP1XYQ
	5fnenIq989iGrT9Z+ial96fMTvOvtfw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 67eaa621 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 May 2025 23:25:06 +0000 (UTC)
Date: Wed, 21 May 2025 01:25:04 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jordan Rife <jordan@jrife.io>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RESEND PATCH v3 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
Message-ID: <aC0PUO0V_osG_ZrN@zx2c4.com>
References: <20250517192955.594735-1-jordan@jrife.io>
 <20250517192955.594735-2-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517192955.594735-2-jordan@jrife.io>

On Sat, May 17, 2025 at 12:29:52PM -0700, Jordan Rife wrote:
> Introduce a new flag called WGALLOWEDIP_F_REMOVE_ME which in the same
> way that WGPEER_F_REMOVE_ME allows a user to remove a single peer from
> a WireGuard device's configuration allows a user to remove an ip from a
> peer's set of allowed ips. This enables incremental updates to a
> device's configuration without any connectivity blips or messy
> workarounds.
 
Applied as:
  https://git.zx2c4.com/wireguard-linux/commit/?h=devel&id=8f697b71a615c5dfff98fe93554036a2643d1976

And the userspace changes have been released already:
  https://lists.zx2c4.com/pipermail/wireguard/2025-May/008789.html

Thanks for this! And sorry it took so long to get it applied. I'll send
this up via net-next in a few days after a bunch of testing.

Jason

