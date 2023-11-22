Return-Path: <netdev+bounces-50209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A21737F4ED1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7481F2061F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34358AA9;
	Wed, 22 Nov 2023 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGLMYMn7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8958AA2
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB851C433C8;
	Wed, 22 Nov 2023 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700675874;
	bh=N1yvqjTwVGaaVMR1e7EUwk/lhWb6MkdS/EbV1N84XtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGLMYMn7YA3Q9/O4UlrJduktZgez4OKx7PMbF1WzWhxIN1dZLuc7XzPw6Q9unGDiC
	 2usUUX48PzH0H8p6GFFat6JWflfY1x7wmJoJRFVg8cyniSkVscyVMpqB5um7Yr2+9I
	 Ef+aYKII5aqfvFRrlOae+F6kBLBuNHJwkrcTBsixbBYCCrqSF2s4xOyzCERjBJnZaK
	 MUwBBbBTGL+nAQj479K2/hOi0RJv0WZnLDj9tlqhtEaEmIqCtYgVwSvwUvAXZH3Sdf
	 3VA39V1eoM0Zh1jegsryMer+N1Wsguc18N5MCQiYwxO5HVMlKqcqcHuqYZDWAoTm95
	 G/ImhQxBFmqdw==
Date: Wed, 22 Nov 2023 17:57:50 +0000
From: Simon Horman <horms@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: bjorn@mork.no, andrew@lunn.ch, netdev@vger.kernel.org
Subject: Re: [RFCv2] usbnet: assign unique random MAC
Message-ID: <20231122175750.GA6731@kernel.org>
References: <20231120114438.12790-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120114438.12790-1-oneukum@suse.com>

On Mon, Nov 20, 2023 at 12:44:27PM +0100, Oliver Neukum wrote:
> The old method had the bug of issuing the same
> random MAC over and over even to every device.
> This bug is as old as the driver.
> 
> This new method generates each device whose minidriver
> does not provide its own MAC its own unique random
> MAC.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Thanks Oliver,

I agree with the approach taken here - using a random address as a fallback
if the driver (hw) doesn't provide one. The patch looks clean to me.
And, form my reading, addresses feedback provided on earlier versions.

Reviewed-by: Simon Horman <horms@kernel.org>

When you repost as a non RFC please consider if this is a fix,
in which case it should have an appropriate Fixes tag. Or
as an enhancement (I lean towards this), in which case it should
be targeted at net-next.

The target tree should be included in the Subject, e.g.

	Subject: [PATCH net-next] usbnet: assign unique random MAC

Link: https://docs.kernel.org/process/maintainer-netdev.html

Also, please expand the CC list as per the output of:

get_maintainer.pl  <this.patch>

...

