Return-Path: <netdev+bounces-186363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F01A9EA1E
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 09:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCEC1897524
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 07:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBEF2376E6;
	Mon, 28 Apr 2025 07:56:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833421CFEC
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745827002; cv=none; b=IpfMuYimBXFOWtlx6VezDuQSDP9RyhdSNiQ56D+OGWqDacITaNguTIngG+zqB51O7jyqAGZWutWFtP2K5TcZJmiOaTic/r7tggVnmtUKteL2tTT+9AcTOx0XhOSD9/8A6kJpAOTp+GqHY2NUr8vYhnd8v504d4ZF0rsu+N0Qfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745827002; c=relaxed/simple;
	bh=w+mZNTBJnBOEw7MpPlooA8dbf/ac0K+j6CtH8iLNtKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBYRJR1cnCSWkNDM9Nl5TIq89LeEIOjqIhLOlca6wtHrNtsFL0fYHyycTUr8+go2g4w92IogdnS9lGc3pQDxmpC2uzEEEAEYxT0LeBzHH+hpbUEKHD31Fgrkhx2IfyiMI/Ue9H+ebf3N5S0ZwqdqD+7yGQ1OEw/A44XXl8YCvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9JLn-0002Jw-KM; Mon, 28 Apr 2025 09:56:27 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9JLm-0003Yv-1s;
	Mon, 28 Apr 2025 09:56:26 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9JLm-008r7s-1P;
	Mon, 28 Apr 2025 09:56:26 +0200
Date: Mon, 28 Apr 2025 09:56:26 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <aA80qh01gosQvPEh@pengutronix.de>
References: <20250422123902.2019685-1-o.rempel@pengutronix.de>
 <20250423184400.31425ecd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250423184400.31425ecd@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Apr 23, 2025 at 06:44:00PM -0700, Jakub Kicinski wrote:
> On Tue, 22 Apr 2025 14:38:58 +0200 Oleksij Rempel wrote:
> > This patchset addresses two issues in the current net selftest
> > framework:
> > 
> > - Truncated test names: Existing test names are prefixed with an index,
> >   reducing the available space within the ETH_GSTRING_LEN limit.  This
> >   patch removes the index to allow more descriptive names.
> > 
> > - Inconsistent checksum behavior: On DSA setups and similar
> >   environments, checksum offloading is not always available or
> >   appropriate. The previous selftests did not distinguish between software
> >   and hardware checksum modes, leading to unreliable results. This
> >   patchset introduces explicit csum_mode handling and adds separate tests
> >   for both software and hardware checksum validation.
> 
> Doesn't apply, presumably because of the fix that's sitting in net?

Needed patch is already in net-next. Should i resend this patches?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

