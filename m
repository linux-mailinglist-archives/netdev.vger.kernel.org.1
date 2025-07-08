Return-Path: <netdev+bounces-205072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86347AFD04F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DE03A918C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A932E7196;
	Tue,  8 Jul 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkkJTDJc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA62E718D;
	Tue,  8 Jul 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991002; cv=none; b=pYAMC+we1Y2sjr2RZ7J53BtN5pwRumWa3mIN2qPVRBPMOif9zQ3I3MeNzBkkoBlzi07ultZ61fFx2E+W5geVe/Dcp64Kap6czBwPXj+f3W3JAZo9JchCp9QQ/nAwPPLcGgSbLmhpDQaaTO3RKr7/W+x9RPmGUw2R0DBCxa+pJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991002; c=relaxed/simple;
	bh=Vo8fKYBnprjiGYOH/VOVRMxkPm6Y8f4SzUdQeB2EkvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJWCA7g0iARzZQas3EMYnrkjT8XFVX2t4qTgTBJtff8fYj4B5Mi7DvkjDkoja/4z07Qrx0rJm8afyHUutE37Zg5nTUb6crAHxiGbfUORNqcfucnGQXLW7NZJlLMV3KvOVWID4z1LrZKrUKbEBNHNqfJ9blph2WNPRqyLxFvS8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkkJTDJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86690C4CEEF;
	Tue,  8 Jul 2025 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991001;
	bh=Vo8fKYBnprjiGYOH/VOVRMxkPm6Y8f4SzUdQeB2EkvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkkJTDJcoQWJRX4CtG/Y5eIzaZrwjy+ME+DhcB/IdLAp/Zzij3x06XuRDm4RHHK8Q
	 A+ZwodpgOWg5DHRJHYZ523KyUEygCcYwsDYunVlxcRsKa/KzhAIc7yW4AfMX8ceAt+
	 e7MPYC9Y7eaxEqJOdnqcQkXSW+est2B7m3DtFUvi3JA0c6X8jyglTh0Xgu9tiP4RIx
	 qXz8879OEWmFFouCA2bJjOkCLBRGleCc4VuDMLc2euvcqgg7s8o3NhhrG9CenJMvWt
	 0YaMp8d+IuvC4zPN4xlrOJyZ0gosL1KVK38ZJ3dHnOCdJR+o+l3rjlcQ+tf0Fh73Z5
	 O8luVhEZMEUJg==
Date: Tue, 8 Jul 2025 17:09:57 +0100
From: Simon Horman <horms@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	darren.kenny@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [External] : Re: [PATCH net] net: thunderx: Fix
 format-truncation warning in bgx_acpi_match_id()
Message-ID: <20250708160957.GQ452973@horms.kernel.org>
References: <20250706195145.1369958-1-alok.a.tiwari@oracle.com>
 <20250707191644.GC452973@horms.kernel.org>
 <96f8e9d7-6e4c-4f7a-bb66-a3b43e30182a@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96f8e9d7-6e4c-4f7a-bb66-a3b43e30182a@oracle.com>

On Tue, Jul 08, 2025 at 08:34:39AM +0530, ALOK TIWARI wrote:
> 
> 
> On 7/8/2025 12:46 AM, Simon Horman wrote:
> > >    drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:23: note:
> > > directive argument in the range [0, 255]
> > >      snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
> > >                           ^~~~~~~
> > >    drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:2: note:
> > > ‘snprintf’ output between 5 and 7 bytes into a destination of size 5
> > >      snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
> > > 
> > > compiler warning due to insufficient snprintf buffer size.
> > > 
> > > Signed-off-by: Alok Tiwari<alok.a.tiwari@oracle.com>
> > Thanks Alok,
> > 
> > I agree this is a good change.
> > 
> > However, by my reading the range of values of bgx->bgx_id is 0 - 8
> > because of the application of BGX_ID_MASK which restricts the
> > value to 3 bits.
> > 
> > If so, I don't think this is a bug and it should be targeted at net-next.
> > With a description of why it is not a bug.
> > 
> > Conversely, you think it is a bug, then I think an explanation as to why
> > would be nice to add to the commit description.  And A fixes tag is needed.
> 
> Thanks Simon,
> It is compile warning, We can target it for net-next.
> 
> I will resend it with [PATCH net-next]

Thanks, good plan.

