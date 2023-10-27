Return-Path: <netdev+bounces-44765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 687CE7D995C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989FC1C21052
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 13:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C29A1EB2B;
	Fri, 27 Oct 2023 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dACx6wfW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC381A738;
	Fri, 27 Oct 2023 13:09:04 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7F818A;
	Fri, 27 Oct 2023 06:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=vL/LUB6nOOmefweeZ3ko/vRVrkJA310HuEs8O1np44E=; b=dA
	Cx6wfWNnJsAb2aSpeL6NsQpS6EVryxUh9Epv2kM10m8rEfpL7tXCeFXfnngYYFUYf4NRghIur2xny
	GE5F3ETHAkPYG4Q4DE4uSctTVm2kt787WZwbycLLou1RKmGVJQrCbMbXG6kPdc5KJ5Hhzizt37ppP
	CuRXJd9PbAR3eOs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwMaD-000LAn-4R; Fri, 27 Oct 2023 15:09:01 +0200
Date: Fri, 27 Oct 2023 15:09:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Message-ID: <bed6f04f-48ab-4cd9-8342-e4f619c91369@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
 <ZTsbG7JMzBwcYzhy@Boquns-Mac-mini.home>
 <c40722eb-e78a-467d-8f91-ef9e8afe736d@lunn.ch>
 <CANiq72nwy6n1_LXGxq7SU6wFmoci_aE2qn5qyzuW7jo8mqTvQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nwy6n1_LXGxq7SU6wFmoci_aE2qn5qyzuW7jo8mqTvQg@mail.gmail.com>

On Fri, Oct 27, 2023 at 12:22:07PM +0200, Miguel Ojeda wrote:
> On Fri, Oct 27, 2023 at 4:47 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > It should also be noted, patches don't need reviews to be merged. If
> > there is no feedback within three days, and it passes the CI tests, it
> > likely will be merged. Real problems can be fixed up later, if need
> > be.
> 
> Passing CI tests does not tell you whether abstractions are
> well-designed or sound, which is the key property Rust abstractions
> need.

We see CI as a tool to do the boring stuff. Does the code even compile
without adding errors/warnings. Does it have the needed signed-off-by,
does checkpatch spot anything nasty going on. Part of being able to
handle the volume of patches in netdev is automating all this sort of
stuff.

> And I hope by "don't need reviews to be merged" you mean "at least
> somebody, perhaps the applier, has taken a look".

A human is always involved, looking at the CI results, and if nothing
bad is reported, looking at the code if there are no Acked-by, or
Reviewed-by from trusted people.

The API being unsound is just another bug. I nobody spots the problem
it can be fixed, just like any other bug. 

	Andrew

