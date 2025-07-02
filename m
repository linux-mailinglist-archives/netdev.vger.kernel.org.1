Return-Path: <netdev+bounces-203080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D522AF0787
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BFBB7ACC39
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CACFBF6;
	Wed,  2 Jul 2025 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm7wauHs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAA1CD0C
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417769; cv=none; b=Wp2kiGO9gTJ9M0iKfDRIsZ2Hk1m3AOcHdrNhvjM/V+tQIm/bUmZbsowuiRtx+dRt5qoW42fXKZICfADDmMlTMxZnBAfAxtlzAFHK1TPVPWxi+DGrmLcNvj1WdR0veusqBELwyA/oKFEpeERHouSdR4c/8v3zuww12yjVNKO4tlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417769; c=relaxed/simple;
	bh=emjcxixWfsRyjbmBVGLczz5HMw/hsdMLQYXnR3V9LrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuNq5lbAREZfOBVA6KoLGRx82dHZjUKN4ttbWC+Ivc5/cxmLqckQuL8arlDZFUQJb1g9Pcanqj48VfDDHHE21xHpIAhC85vg1Tfv23fIQQCd675AyLE/K6u190zQPLtEveHnu/i2USweyVA+1uwA2/7fr4FhC+9rvl8v5EHu7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm7wauHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851F7C4CEEB;
	Wed,  2 Jul 2025 00:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751417768;
	bh=emjcxixWfsRyjbmBVGLczz5HMw/hsdMLQYXnR3V9LrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qm7wauHs+ylhmhfvj6F0PEnkXO0nCPy/xGwHUHSlXbTZ1ghqJfSTACakfRWOjtlAH
	 zWG7MZNv76S04qvD42z2krLydAHA/YbZanmdcgof+4AkrWj5JXXqBHnH+85Je0CfIJ
	 R3VJfdYEMz+oMKE2LdcdtfEHpgzL0GhCbBhYBtEkPufQ6tGKqIFTmyDcemzrdMamhK
	 O+GRYSN1UlNrfhDzRlsYf0xsTmuaITQWA2BqeeDsREg+r/ZbkL4i/4J5LqmSbiUOYc
	 72plvA0GuezPrkmbdUMhLP99+nYS5F9YWL8MsNnaquQ9M8fIZYRPJX/irDz20GCNQz
	 dfZHdNW2430Ug==
Date: Tue, 1 Jul 2025 17:56:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH net] bnxt_en: eliminate the compile warning in
 bnxt_request_irq due to CONFIG_RFS_ACCEL
Message-ID: <20250701175607.35f2a544@kernel.org>
In-Reply-To: <CAL+tcoAfV+P3579_uM4mikMkNK4L2dMx0EuXNnTeLwZ3-7Po2Q@mail.gmail.com>
References: <20250629003616.23688-1-kerneljasonxing@gmail.com>
	<20250630110953.GD41770@horms.kernel.org>
	<CAL+tcoDUoPe05ZGhsoZX24MkaRZx=bRws+kY=MuEVQdy=3mM1A@mail.gmail.com>
	<20250701171501.32e77315@kernel.org>
	<CAL+tcoAfV+P3579_uM4mikMkNK4L2dMx0EuXNnTeLwZ3-7Po2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Jul 2025 08:47:08 +0800 Jason Xing wrote:
> >  static int bnxt_request_irq(struct bnxt *bp)
> >  {
> > +       struct cpu_rmap *rmap = NULL;
> >         int i, j, rc = 0;
> >         unsigned long flags = 0;
> > -#ifdef CONFIG_RFS_ACCEL
> > -       struct cpu_rmap *rmap;
> > -#endif  
> 
> Sorry, Jakub. I failed to see the positive point of this kind of
> change comparatively.

Like Simon said -- fewer #ifdefs leads to fewer bugs of this nature.
Or do you mean that you don't understand how my fix works?

> >         rc = bnxt_setup_int_mode(bp);
> >         if (rc) {  
> 
> Probably in this position, you expect 'rmap = bp->dev->rx_cpu_rmap;'
> to stay there even when CONFIG_RFS_ACCEL is off?

no, dev->rx_cpu_rmap doesn't exist if RDS_ACCEL=n

> The report says it's 'j' that causes the complaint.

