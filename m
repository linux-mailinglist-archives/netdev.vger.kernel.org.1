Return-Path: <netdev+bounces-19615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B725F75B6B6
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B551C21466
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E5519BC8;
	Thu, 20 Jul 2023 18:26:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4519BC5
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 18:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4062C433C7;
	Thu, 20 Jul 2023 18:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689877589;
	bh=xha2iXtDT4iIsye4s+aA5Kiqrk4hNe9ZAS+tEs71g+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amNiniA08uTgnSyLnoLNygaQQ/+mDsLy+preW5cAxap2xGZmBUCdonM2RqhcQdO9H
	 qVRpqzDErPrIgPS7jzjlZLI+NhH4TWbuDquIFXxAS6skFdpwyDGeWSGyJ5vvEPG4a2
	 6H+/5Cjg1ssLt0nRNEPNvXHBRXaxFNWvBFNfc2iY=
Date: Thu, 20 Jul 2023 20:26:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net,
	Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
	benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <2023072012-subzero-maturity-b6cd@gregkh>
References: <20230719183225.1827100-1-kuba@kernel.org>
 <50164116-9d12-698d-f552-96b52c718749@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50164116-9d12-698d-f552-96b52c718749@gmail.com>

On Thu, Jul 20, 2023 at 07:23:56PM +0100, Edward Cree wrote:
> On 19/07/2023 19:32, Jakub Kicinski wrote:
> > We appear to have a gap in our process docs. We go into detail
> > on how to contribute code to the kernel, and how to be a subsystem
> > maintainer. I can't find any docs directed towards the thousands
> > of small scale maintainers, like folks maintaining a single driver
> > or a single network protocol.
> > 
> > Document our expectations and best practices. I'm hoping this doc
> > will be particularly useful to set expectations with HW vendors.
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> 
> Thanks for writing this.  One question—
> 
> > +Reviews
> > +-------
> > +
> > +Maintainers must review *all* patches touching exclusively their drivers,
> > +no matter how trivial. If the patch is a tree wide change and modifies
> > +multiple drivers - whether to provide a review is left to the maintainer.
> 
> Does this apply even to "checkpatch cleanup patch spam", where other patches
>  sprayed from the same source (perhaps against other drivers) have already
>  been nacked as worthless churn?  I've generally been assuming I can ignore
>  those, do I need to make sure to explicitly respond with typically a repeat
>  of what's already been said elsewhere?

No, you can ignore them if you don't want to take them :)

