Return-Path: <netdev+bounces-218968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA1AB3F1E6
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 03:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EA148266D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 01:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325D72DE711;
	Tue,  2 Sep 2025 01:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF131A288;
	Tue,  2 Sep 2025 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756776705; cv=none; b=qIdyaZBLJnnEJ+0Fi627Kmpf1RULwpNRJXOqahsBqxtZZjnTjgp+3C2406ePZSg+7ld1rms4ZNRaLigKiZlSDRbzX3ckkdSNwZ8Tynh0ccnYCJWzzTPXHc4+1o6yf5IfLM2F8CpoGKFQFHD+3tXAdXL3+f6mR0EB9jFY0uoagus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756776705; c=relaxed/simple;
	bh=VlGK73+2UsvCH2/UxRjr3vexyOny+hPU0H/RMxobD7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyUfY0FWLKtTue4EXLeH/gjp3qcCmpDyngeZDKxmvJQHvxJfT0/aX6qJkiI1QcJx387dW2DBHplg5x1uxu0qABfezGJFrzJEwaRbAB00o1KZ60zMS1uWbJuyGFycGWaBzCXgpld8HN3j8Bec0Kc6s6sl6HjneRPU+g1ki/ChEUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz3t1756776674t0376ccc7
X-QQ-Originating-IP: HnD05YW2Fm5i8g207GQNWjjPXwhJAhpiF2uBPQwqDl0=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Sep 2025 09:31:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16686580263834056200
Date: Tue, 2 Sep 2025 09:31:12 +0800
From: Yibo Dong <dong100@mucse.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v9 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <DD499CD3F59F91F1+20250902013112.GA101881@nic-Precision-5820-Tower>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-2-dong100@mucse.com>
 <dcfb395d-1582-4531-98e4-8e80add5dea9@lunn.ch>
 <8AD0BD429DAFBD3B+20250901082052.GA49095@nic-Precision-5820-Tower>
 <a3c51a9e-f0cb-4d25-a841-117da0ff943c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3c51a9e-f0cb-4d25-a841-117da0ff943c@linux.dev>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M4ZQYI3ba7Qf7PwhqL03NSnSHc0z9QYWtJs/Rh5VtFs9N7cliX3zbt1s
	vsKmyIcJW33c9x3wiPLwtAD3ayT//yEV+Bn//df7DNGF+CwQbpcmatXZM14rSwNkGrd/wop
	5DyVUWpSC7Zd5easECjag+SR1Fdwomz3HADXziqP5FDCnKeOp9/XTyhSTK+n5p7lb/qTLqF
	lSHBnLkObQ9c8ScNiPcAPV8OQwLuA9vkwxtmhQbYVAJb8F5uIhJFUUgeFh13ecTimFyCfhi
	ZmA/IqWNNRaTh+xHW4p2toNPxrYOf36brvf/kkpjObu5KLZaYfUpuCX4gXrg6uQnldth91p
	cVJXrBhBv/nP5Z8ORW/MigRROSqqHrv0E4qfPaaa1CV8pGtvYyIzFqy+yEWOzuYa+dB6OHQ
	hjGXJNvMQ3cu+KXokIwBExblGCcQmMHrmodXNWXhjTMiCreVEGsYVr4m03ur+3Rk1vs2+bq
	WGdkGQNRqfxUtCJlB/h/m2uH8z1/DfAy5pDf0790O3WP2AQKSxzfwol2TMvSwJpO1tGrGkQ
	oLC1kC5COtgONsO+tV1qqwNeJ2K+mqsYylhY6yuSGEhfIy6sV9KmIviSgcyWmrmaWvdwcVc
	e/dB1sEtRoWKXCIj1iJ1yUYR1VuvPaeU3xDzajZvtBLN1KLqum9HbEGEFTINwi8bjxGwKqf
	WO/MFXR/ngBEZrB/5aUmGP1iRW1Tx8Awl97hzUisePqU7DhA8kzR8S5OPz4ZreHA0WVL+Zr
	tAPgc/mRtirSIY1S5e+0eUg60fFH5NouYig32HdffFGwlXjdXnjEZD8dMNWzHVLO0wfcGW2
	0DgpK+rc77qqIcUVw1d23BMeS2R6UCI/v+weUBV+4lyxGquC2ryey765gn5szcHYwgQ6B0w
	lH5OI1BXGP9kl7tRD4D7scIHbQcUyrl0sXpNWLSX2/ZwXTRT5RL8roxELonzllJUiZdP04E
	+7tpvP4Kr4ntTMKPYpS+ZP3DmTWyjNNrXOjOS1DqRLLWCGAFQwccCQaBf
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Mon, Sep 01, 2025 at 10:58:48AM +0100, Vadim Fedorenko wrote:
> On 01/09/2025 09:20, Yibo Dong wrote:
> > On Thu, Aug 28, 2025 at 02:51:07PM +0200, Andrew Lunn wrote:
> > > On Thu, Aug 28, 2025 at 10:55:43AM +0800, Dong Yibo wrote:
> > 
> > Hi, Andrew:
> > 
> > > > Add build options and doc for mucse.
> > > > Initialize pci device access for MUCSE devices.
> > > > 
> > > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > 
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > > 
> > >      Andrew
> > > 
> > 
> > Should I add 'Reviewed-by: Andrew Lunn <andrew@lunn.ch>' to commit for
> > [PATCH 1/5] in the next version?
> 
> The general rule is to carry over all the tags if there is no (big)
> changes to the code in the patch.
> 

Got it, thanks.


