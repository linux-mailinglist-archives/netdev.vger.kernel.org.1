Return-Path: <netdev+bounces-12691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C2573881B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39081C20EF3
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7B18C2D;
	Wed, 21 Jun 2023 14:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C118C2A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC82C433C0;
	Wed, 21 Jun 2023 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687359380;
	bh=ln2lWCijb2V4mFtJBQotSwtqT0uvIw8cIIaLNs8TBV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDjz09CpApkkd08SxYoRrpdpQAfOz2L+/IjSDTWC5mwYrPpO6rjL02A2gakb5TGor
	 odIiypj5ogfEYDfE5Y6yCsiJl+FgV02kiVD4ntFaMSXTZ/pKyjLIP6f9tXGfh8Urey
	 HxoYfAbYc3tX85ec14PaVXemjsI87fsd3c7gXyqhTbh+1d65ZhxSEepqQ1nPzGaWWg
	 +fna6f7Bt80m4FnpSRn6c9gGWKqXWZj6eFFWTaualuKq3viMnq7HPdp0KhmrZuWNfC
	 d9nQ/25S9tzSxNgC6UaA7HIIRwaO5CniGH5yr1WN40MxAFn1rpDX5rGG6t7wJ0ZVnA
	 /Xt1elswPC8VQ==
Date: Wed, 21 Jun 2023 15:56:15 +0100
From: Lee Jones <lee@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v4 0/3] leds: trigger: netdev: add additional
 modes
Message-ID: <20230621145615.GD10378@google.com>
References: <20230617115355.22868-1-ansuelsmth@gmail.com>
 <20230619104030.GB1472962@google.com>
 <dd82d1bd-a225-4452-a9a6-fb447bdb070e@lunn.ch>
 <20230620102629.GD1472962@google.com>
 <0462a658-8908-4b8c-9859-8d188f794283@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0462a658-8908-4b8c-9859-8d188f794283@lunn.ch>

On Tue, 20 Jun 2023, Andrew Lunn wrote:

> > > If you do decided to wait, you are going to need to create another
> > > stable branch to pull into netdev. I know it is not a huge overhead,
> > > but it is still work, coordination etc.
> > 
> > Can you clarify you last point for me please?
> 
> This patchset extends the conditions on which the trigger blinks the
> LED. It adds a couple more values to enum led_trigger_netdev_modes in
> include/linux/leds.h. Once it gets merged, i will have a followup
> patch extending the Marvell PHY driver to make us of them. It will
> need these additional enum values. I also expect other PHY drivers to
> gain support for them. Probably the dp83867.c driver since Alexander
> Stein already has a patch merged adding support for what the current
> API supports.
> 
> If we merge this patchset now via netdev, -rc1 should have everything
> we need for this continuing development work. If we wait to merge
> these patches until -rc1, only the LED tree has the needed patches, so
> these network drivers will need a stable branch we can pull into
> netdev.
> 
> Both ways work, we can do either. But it is probably easier for
> everybody to merge now via netdev.

Got it, thanks.

-- 
Lee Jones [李琼斯]

