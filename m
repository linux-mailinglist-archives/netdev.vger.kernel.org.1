Return-Path: <netdev+bounces-94933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD648C1079
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9CD2834C4
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980C1527BF;
	Thu,  9 May 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX+3FdeO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4D1527A2;
	Thu,  9 May 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261968; cv=none; b=MKCPS9TdYVBARZr75ZU+y8k/0QgW8FpQlMM35+lpdiSSOUgU/+z4SXgTC2eui/M1GU1l9OND4SIDsUSDf8URF3qxsyYTdF4bBMCMLouNWB/c9w286B5nnvdOlzXXpQiuEntwO62O+q8VcUxckEPhKsi5ichr0M63guTQy3K3FLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261968; c=relaxed/simple;
	bh=jUr68MLDbSUnFqAm1vse81ZVzM/+9WHZZ9/wSq3eCiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFHyIJWxk1VRb39glOBXW0Nd79IrIZC86gMpRkRAP/N8K7jZkojk83NWtz5REFFMUyIX8G/nskZrVIIhVcY1yiJ+BnzWkZlFXFrSM4Uac1gsXtSkiD+RXHYmOLW8bxBJZ6MBZZR/1UthLzUeHx8IuvJiWW+vCIvX64Lbr03D/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX+3FdeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44001C116B1;
	Thu,  9 May 2024 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715261967;
	bh=jUr68MLDbSUnFqAm1vse81ZVzM/+9WHZZ9/wSq3eCiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YX+3FdeOTKKEw1qyHCMlwNbZqpZRGcwvdQ2kNdsWx+gcYh/014U2juYkWjLuxjGDe
	 4GMEZfDaldxnl9OfrJMFNVkDJF7AV5zStr9B46GCkmKQUzRWa0CTbiX0Eg6G/qVGdk
	 GG9JD+CtUiU7HMpnOUcf4iSP+JspX73jWsoSJB0nfASuFP9hcmOg9O1c/S0chuSwVq
	 bBioBRMdOPs2x18C+4+Ip+o7wvW4rkK6tvxsZuONGCMwAUGQssPsS4JFguylg6VZ0I
	 oC62okKZS0dFq7O4EldqCPgjG9rp+8vJfBPmW2zU3ZbwznKdDbwIFjcAplSouJd+gU
	 CrxaKshJ8vsrg==
Date: Thu, 9 May 2024 14:39:23 +0100
From: Simon Horman <horms@kernel.org>
To: Rengarajan.S@microchip.com
Cc: linux-usb@vger.kernel.org, davem@davemloft.net,
	Woojung.Huh@microchip.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, edumazet@google.com,
	UNGLinuxDriver@microchip.com, kuba@kernel.org
Subject: Re: [PATCH net-next v1] lan78xx: Enable 125 MHz CLK and Auto Speed
 configuration for LAN7801 if NO EEPROM is detected
Message-ID: <20240509133923.GZ1736038@kernel.org>
References: <20240502045503.36298-1-rengarajan.s@microchip.com>
 <20240504084931.GA3167983@kernel.org>
 <d5727bf3d176e3d71abeba7f7c3aa86cf96262cc.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5727bf3d176e3d71abeba7f7c3aa86cf96262cc.camel@microchip.com>

On Thu, May 09, 2024 at 06:59:03AM +0000, Rengarajan.S@microchip.com wrote:
> Hi Simon,
> 
> Apologies for the delay in response. Thanks for reviewing the patch.
> Please find my comments inline.
> 
> On Sat, 2024-05-04 at 09:49 +0100, Simon Horman wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > On Thu, May 02, 2024 at 10:25:03AM +0530, Rengarajan S wrote:
> > > The 125MHz and 25MHz clock configurations are done in the
> > > initialization
> > > regardless of EEPROM (125MHz is needed for RGMII 1000Mbps
> > > operation). After
> > > a lite reset (lan78xx_reset), these contents go back to
> > > defaults(all 0, so
> > > no 125MHz or 25MHz clock and no ASD/ADD). Also, after the lite
> > > reset, the
> > > LAN7800 enables the ASD/ADD in the absence of EEPROM. There is no
> > > such
> > > check for LAN7801.
> > > 
> > > Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
> > 
> > Hi Rengarajan,
> > 
> > This patch seems address two issues.
> > So I think it would be best to split it into two patches.
> 
> Sure. Will split the patch into two and will submit the updated patch
> in the next revision shortly,
> 
> > 
> > Also, are these problems bugs - do they have adverse effect visible
> > by
> > users? If so perhaps they should be targeted at 'net' rather than
> > 'net-next', and an appropriate Fixes tag should appear just above
> > the Signed-off-by line (no blank line in between).
> 
> The changes listed in the patch are feature additions where we give an
> option of configuring the clock and speed in the absence of the EEPROM.
> The current code does not have any bugs related to this. Since, these
> are the additional features/requirements, we are targeting at 'net-
> next' rather than 'net'.

Thanks, I agree net-next is appropriate for such changes.

