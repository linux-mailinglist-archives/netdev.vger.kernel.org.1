Return-Path: <netdev+bounces-49553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85D87F262D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 08:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D3A1C20908
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 07:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272DD1F93F;
	Tue, 21 Nov 2023 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="l3y/Gfkx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DieFae+I"
X-Original-To: netdev@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADE09D;
	Mon, 20 Nov 2023 23:12:18 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id EC98C5C0C58;
	Tue, 21 Nov 2023 02:12:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Nov 2023 02:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700550737; x=1700637137; bh=04
	AJGy4oa9MjsWPrnDD6xwdZTHm1YQvdW/pByyPc3e4=; b=l3y/GfkxohGfFNzHRn
	q6FVzZTcaDrXmOpvsaQHmG88ZqMXyAvxlK5ST3wLqsTS4nuaPcboBQCDMU5F88N9
	Rwo9MkPLprXRBCa0J9wNzSoH3Mz4r94RGGnIxY7fwdNHnA9V05TLW8YetDSc/8gF
	zFxMZNBdkDBDrtA4Mcmy4llX4R3uI7Lc5btmrwlwhekq9uS/X225pw34oNF0MLS4
	rvtgfVzfla49q6LF8nVYNgW+z/zc5DbNEBn+OAwooArtY1QKF0NcvHMcXF+btJTS
	wFkyJ6nXIzyJzbX16MUFEFwpqaYa3a7EWVqCdJavQYhhLi7BTQHj2LlBwSzGqjEV
	p6/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700550737; x=1700637137; bh=04AJGy4oa9Mjs
	WPrnDD6xwdZTHm1YQvdW/pByyPc3e4=; b=DieFae+IkvBry6ckdYrqzlm5f2EvV
	Gz4k1d/Nkf9QG+RK7385W/wqPjrEBmFDS7OvD1Y9kMtnlMThpZ8P7ETyUKi1fns/
	eelqEuahniXG1+M/Huws2Du8YG1IIrD0g0JdwhC1J0Ku8CHbUZiKZSIzFbifEfbZ
	KpXRRUJB7fhw+pknysF0mPVS5mgXGUXdQN/6DxkCvQlmfzlpswfX4NPz9I4c++Ij
	T0y7M3LfXFMFcET/dZz/VTUCEl5b53VyoJPhzmo4LhWCMmomkpp+9JX0qhG2wNh6
	D/3g9i7a4jucIVa6wYEAlMIAngRjInvFCjw8dxfOFSDeWU57EQkzvStug==
X-ME-Sender: <xms:UVhcZdhzHLX1f7YO0lRDCQH5RNOBmk7etLt49IPt_ygACfZ7IV16nQ>
    <xme:UVhcZSB_RxAVa3l8XFsGt-lPPlLq_hDnziSdTznTSN6c2DmipxIIBWvjKSQZPnJbF
    VJtljbJ3h97AA>
X-ME-Received: <xmr:UVhcZdE4iBOEOZAj25hW98bMC40B-aLu8PeDxwpMt4zwsN91G_v6Yw8-rcXQhk3Htb9TuBqnwWlrbjof1P35IlM-5j6bIlT5CSRdCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:UVhcZSRjm5e5ctBWRIev_eny3UvWzt27e4WdoSvuL1T6GxbVnwKM3w>
    <xmx:UVhcZaxSrwFbFSuLkwTyrGQVusaayxZXMiEmf3mv5fRdF1dbQ68Dbw>
    <xmx:UVhcZY5XYxslPmDaYixYkpwAd1kZ5kThJRYXzCZUDFJgFbSOmtL1zQ>
    <xmx:UVhcZfhbVYtcK7abWjliZJgHkXP-wYmi-tD_RekiGcq44sQZE-7B9Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 02:12:16 -0500 (EST)
Date: Tue, 21 Nov 2023 08:12:09 +0100
From: Greg KH <greg@kroah.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, aliceryhl@google.com, benno.lossin@proton.me,
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 5/5] net: phy: add Rust Asix PHY driver
Message-ID: <2023112136-paver-agreed-0bc1@gregkh>
References: <20231117093915.2515418-1-aliceryhl@google.com>
 <20231119.185736.1872000177070369059.fujita.tomonori@gmail.com>
 <363b810d-7d6c-48bd-879b-f97acffa70b6@lunn.ch>
 <20231121.151939.1903605088782465261.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121.151939.1903605088782465261.fujita.tomonori@gmail.com>

On Tue, Nov 21, 2023 at 03:19:39PM +0900, FUJITA Tomonori wrote:
> On Sun, 19 Nov 2023 17:03:30 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> >> >> +            let _ = dev.init_hw();
> >> >> +            let _ = dev.start_aneg();
> >> > 
> >> > Just to confirm: You want to call `start_aneg` even if `init_hw` returns
> >> > failure? And you want to ignore both errors?
> >> 
> >> Yeah, I tried to implement the exact same behavior in the original C driver.
> > 
> > You probably could check the return values, and it would not make a
> > difference. Also, link_change_notify() is a void function, so you
> > cannot return the error anyway.
> > 
> > These low level functions basically only fail if the hardware is
> > `dead`. You get an -EIO or maybe -TIMEDOUT back. And there is no real
> > recovery. You tend to get such errors during probe and fail the
> > probe. Or maybe if power management is wrong and it has turned a
> > critical clock off. But that is unlikely in this case, we are calling
> > link_change_notify because the PHY has told us something changed
> > recently, so it probably is alive.
> > 
> > I would say part of not checking the return code is also that C does
> > not have the nice feature that Rust has of making very simple to check
> > the return code. That combined with it being mostly pointless for PHY
> > drivers.
> 
> Understood. I'll check the first return value if you prefer. I might
> add WARN_ON_ONCE after Rust supports it.

Please don't, it shouldn't support it, handle errors properly and
return, don't panic machines (remember, the majority of the Linux
systems in the world run panic-on-warn).

thanks,
g
reg k-h

