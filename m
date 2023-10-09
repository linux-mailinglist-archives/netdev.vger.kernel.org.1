Return-Path: <netdev+bounces-39110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25257BE1E1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C93628162F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB8D347B2;
	Mon,  9 Oct 2023 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0SQw8JdN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56862341AC;
	Mon,  9 Oct 2023 13:54:53 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617EC9C;
	Mon,  9 Oct 2023 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J33hQG28OSXL/FnKVl4YRpOTbwKnzBmGvHcBq2Ewt88=; b=0SQw8JdNkYgwGWMOd3b7kTC4Cv
	FjtVwDa9Fy/s3UAndZPEugYzW8FxGecF/sofV338XNjYcqYpaIrbefoZKvjuO6dorLOjadTSMKtRQ
	I96HVUSHimf8Z4SSH9MfNlHvv94lmL68lVSCOabDryZd8+M7MDy0xpgyFXTGM+/EujeI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qpqid-000tXG-70; Mon, 09 Oct 2023 15:54:47 +0200
Date: Mon, 9 Oct 2023 15:54:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <183d4a59-acf1-4784-8194-da8e484ccb1b@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-2-fujita.tomonori@gmail.com>
 <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > +/// This is used by [`module_phy_driver`] macro to create a static array of phy_driver`.
> 
> Broken formatting? Does `rustdoc` complain about it?

For C code, when you do a kernel build with W=1, it enables the
kerneldoc checker on each file:

e.g:

./scripts/kernel-doc -none   arch/x86/entry/vdso/vdso-image-32.c

Can rustdoc be invoked in a similar way? Perform a check on a file,
issue errors, but don't actually generate any documentation? If it
can, it would be good to extend W=1 with this.

The netdev CI instance builds with W=1, so we get to see problems like
this, and we ask for it to be fixed up before the code is merged.

      Andrew

