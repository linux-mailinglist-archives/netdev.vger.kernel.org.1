Return-Path: <netdev+bounces-89208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5298A9AEB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A951D285C4B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E01715F323;
	Thu, 18 Apr 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oxvXuZQJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C915E7E7;
	Thu, 18 Apr 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445839; cv=none; b=mmKdX4EFeNQM6/5+VlEMr6ZQiaONV6SNz5O5f6x88fNv0/bP/XJcGdmkWiHG9UbB3Aexm9UpjaoI4wXe/DizejFUe29CAnnWakaP2EknrHHw52fDC+c0M3ynHyxinZBWJiRTJVJHcH/FI0JLDxBjQZvRMBwpjnPA3rFpywMBxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445839; c=relaxed/simple;
	bh=TCPgT8xXertTlcQkGaswLBetbbLcmmhBrhPdmn6CHJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsZRzJQjJHpxrYY991AG00cRgpwiC8CW3iEcJv6/k3EGH+U0sRHES9u2KbldGA/9AlUQWU56bLFy/s3kqV5s6thl1/xyVbA5EDv/x3Y37/aZGXVNmrK7l3+P0y9UpdyB2tm2Bbp4ENua77Xcx1Y7j8hvg4tiHQpQ8C5/6W+ZO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oxvXuZQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805DFC113CC;
	Thu, 18 Apr 2024 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713445838;
	bh=TCPgT8xXertTlcQkGaswLBetbbLcmmhBrhPdmn6CHJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxvXuZQJWIvfyenn8iELyyqOqTl+7ClIS2fCrttMgnFjiRF+T4inCN2HTAHnKlVuN
	 VkBO6dB3JdJDwyX47LBuZt6GDYR5Rjn6M4Ps7tuwiBFRLg7eLToE/hAqHHWJa87AJL
	 +Bs3sQXA78Dfn131R21gQ8bEacLlIwVabzK6WPaQ=
Date: Thu, 18 Apr 2024 15:10:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <2024041801-anteater-cultivate-d8a0@gregkh>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-5-fujita.tomonori@gmail.com>
 <2024041549-voicing-legged-3341@gregkh>
 <20240418.220047.226895073727611433.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418.220047.226895073727611433.fujita.tomonori@gmail.com>

On Thu, Apr 18, 2024 at 10:00:47PM +0900, FUJITA Tomonori wrote:
> >> +            if i == 0x4000 {
> > 
> > What does 0x4000 mean here?
> > 
> >> +                a = MDIO_MMD_PHYXS;
> >> +                j = 0x8000;
> > 
> > What does 0x8000 mean here?
> > 
> >> +            }
> >> +            dev.c45_write(a, j, (*val).into())?;
> >> +
> >> +            j += 1;
> >> +        }
> >> +        dev.c45_write(MDIO_MMD_PCS, 0xe854, 0x0040)?;
> > 
> > Lots of magic values in this driver, is that intentional?
> 
> The original driver uses lots of magic values. I simply use them. As
> Andrew wrote, we could infer some. I'll try to comment these.

Wait, this is a rewrite of an existing driver in the tree into Rust?
Why is that happening again?  Why not a new one instead?

thanks,

greg k-h

