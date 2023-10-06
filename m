Return-Path: <netdev+bounces-38585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE097BB829
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AD32821B5
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4021F5F5;
	Fri,  6 Oct 2023 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e+PwAyyl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873161D6A8;
	Fri,  6 Oct 2023 12:54:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0434DB;
	Fri,  6 Oct 2023 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nj8di1Doiv9HJrh6Mz+/sHoFuT+RYme/VOtqumM9Ryg=; b=e+PwAyylswn4ZzFzOXXg5n30qS
	TVxssA9K2wZsy0WTjdUlXonYafhPs8bCj73Uy22bvZxmAyl4RJTs0QmeDMf53jc/IxTrK+1J82Mei
	lgJZx0WtYDz1q/NxJqzqzGlMcrxVFGHw3TYWo98HLfyVjoNVyUk+FtKD8A7JHhIJlTjI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qokLr-008QWN-8k; Fri, 06 Oct 2023 14:54:43 +0200
Date: Fri, 6 Oct 2023 14:54:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH v2 0/3] Rust abstractions for network PHY drivers
Message-ID: <6aac66e0-9cbd-4a7b-91e6-ea429dbe6831@lunn.ch>
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006094911.3305152-1-fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 06:49:08PM +0900, FUJITA Tomonori wrote:
> This patchset adds Rust abstractions for network PHY drivers. It
> doesn't fully cover the C APIs for PHY drivers yet but I think that
> it's already useful. I implement two PHY drivers (Asix AX88772A PHYs
> and Realtek Generic FE-GE). Seems they work well with real hardware.

One of the conventions for submitting patches for netdev is to include
the tree in the Subject.

[PATCH net-next v2 1/3] rust: core abstractions for network PHY drivers

This is described here, along with other useful hits for working with
netdev.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

This tag helps patchworks decide which tree to apply your patches to
and then run build tests on it:

https://patchwork.kernel.org/project/netdevbpf/patch/20231006094911.3305152-4-fujita.tomonori@gmail.com/

I don't know if it made the wrong decision based on the missing tag,
or it simply does not know what to do with Rust yet.

There is also the question of how we merge this. Does it all come
through netdev? Do we split the patches, the abstraction merged via
rust and the rest via netdev? Is the Kconfig sufficient that if a tree
only contains patches 2 and 3 it does not allow the driver to be
enabled?

	Andrew
	

