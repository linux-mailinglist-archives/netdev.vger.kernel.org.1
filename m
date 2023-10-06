Return-Path: <netdev+bounces-38613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129E57BBAB4
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E4C1C209D5
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3553722EFC;
	Fri,  6 Oct 2023 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kRABifqY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AAF18021;
	Fri,  6 Oct 2023 14:47:31 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E388F;
	Fri,  6 Oct 2023 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bpn7VWeMy6+P0BoMXn6YXz/NjRccj3PfiO8R7PBM2nM=; b=kRABifqYSjxBi1eLx4OwcB8Rx+
	Ir3sYO5kWnPWPd/MXRXnxSfvi0vVf8T7QZso8IUmh3UH2oKvShvQDZHfxEczAtZNPwx2JG+gP4/t1
	lA5P5/zfMae1AnVU/IHLpY0s+AGCBZW3lkQ3fxYv8jDJboVxGSP6zpMsDxIGn8tWZl14=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qom6x-0001sq-Dq; Fri, 06 Oct 2023 16:47:27 +0200
Date: Fri, 6 Oct 2023 16:47:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH v2 0/3] Rust abstractions for network PHY drivers
Message-ID: <40859cee-2ee7-4065-82d0-3841e5d7838f@lunn.ch>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
 <6aac66e0-9cbd-4a7b-91e6-ea429dbe6831@lunn.ch>
 <20231006.230936.1469709863025123979.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006.230936.1469709863025123979.fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> A tree only that contains patches 2 and 3 allow the driver to be
> enabled, I think. The driver depends on CONFIG_RUST, which might
> doesn't have PHY bindings support (the first patch).

This is part of why i said there should be a Kconfig symbol
CONFIG_RUST_PHYLIB_BINDING or similar. With only patches 2 and 3, that
would not exists, and so you cannot enable the driver. Once all the
patches meet up in linux-next, you have both parts, and you can enable
it.

> So I think that merging the patchset through a single tree is easier;
> netdev or rust.
> 
> Miguel, how do you prefer to merge the patchset?

What are the merge conflicts looking like? What has happened in the
past? Or is this the first driver to actually get this far towards
being merged?

      Andrew

