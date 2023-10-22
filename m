Return-Path: <netdev+bounces-43290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7957B7D2394
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 17:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3321C208D3
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2F4DDB8;
	Sun, 22 Oct 2023 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AWXz3J/m"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192D1FD9;
	Sun, 22 Oct 2023 15:34:10 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B618E9;
	Sun, 22 Oct 2023 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=txCRBNVhG01Iz4fCLIHgxiWEZs781Kdfj2fihtzyBDc=; b=AW
	Xz3J/mIFTejtEn7p2Y/6H4rWL6lenlQQkA6mU09rH1Oq8m3cpjymmgzTrHRx+cG0kDOKadrblKQSa
	Xbn954/3e7XUww3dsWUMVgZJgEIVkf+gnumP4RRrDoU/PHYYzsfqLPCj9IZA4jWp50rfThtRRtGtU
	+ImUy+rSUF0OO+Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1quaSq-002x2V-G0; Sun, 22 Oct 2023 17:34:04 +0200
Date: Sun, 22 Oct 2023 17:34:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, benno.lossin@proton.me,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <798666eb-713b-445d-b9f0-72b6bbf957ff@lunn.ch>
References: <e361ef91-607d-400b-a721-f846c21e2400@proton.me>
 <4935f458-4719-4472-b937-0da8b16ebbaa@lunn.ch>
 <CANiq72nOCv-TfE3ODgVyQoOxNc80BtH+5cV2XFBFZ=ztTgVhaw@mail.gmail.com>
 <20231022.184702.1777825182430453165.fujita.tomonori@gmail.com>
 <CANiq72mDWJDb9Fhd4CHt8YKapdWaOrqhJMOrQZ9CDRtvNdrGqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mDWJDb9Fhd4CHt8YKapdWaOrqhJMOrQZ9CDRtvNdrGqA@mail.gmail.com>

On Sun, Oct 22, 2023 at 01:37:33PM +0200, Miguel Ojeda wrote:
> On Sun, Oct 22, 2023 at 11:47 AM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > Agreed that the first three paragraphs at the top of the file are
> > implementation comments. Are there any other comments in the file,
> > which look implementation comments to you? To me, the rest look the
> > docs for Rust API users.
> 
> I think some should be improved with that in mind, yeah. For instance,
> this one seems good to me:
> 
>     /// An instance of a PHY driver.
> 
> But this one is not:
> 
>     /// Creates the kernel's `phy_driver` instance.
> 
> It is especially bad because the first line of the docs is the "short
> description" used for lists by `rustdoc`.
> 
> For similar reasons, this one is bad (and in this case it is the only line!):
> 
>     /// Corresponds to the kernel's `enum phy_state`.
> 
> That line could be part of the documentation if you think it is
> helpful for a reader as a practical note explaining what it is
> supposed to map in the C side. But it should really not be the very
> first line / short description.
> 
> Instead, the documentation should answer the question "What is this?".
> And the answer should be something like "The state of the PHY ......"

Its the state of the state machine, not the state of the PHY. It is
already documented in kernel doc, so we don't really want to duplicate
it. So maybe just cross reference to the kdoc:

https://docs.kernel.org/networking/kapi.html#c.phy_state

> Yes, documenting that something wraps/relies on/maps a particular C
> functionality is something we do for clarity and practicality (we also
> link the related C headers). This is, I assume, the kind of clarity
> Andrew was asking for, i.e. to be practical and let the user know what
> they are dealing with on the C side, especially early on.

I don't think 'early on' is relevant. In the kernel, you pretty much
always need the bigger picture, how a pieces of the puzzle fits in
with what is above it and what is below it. Sometimes you need to
extend what is above and below. Or a reviewer will tell you to move
code into the core, so others can share it, etc.

	Andrew

