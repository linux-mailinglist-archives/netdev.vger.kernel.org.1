Return-Path: <netdev+bounces-40846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F2C7C8D4E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 20:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A88C282EB1
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2E91CFA4;
	Fri, 13 Oct 2023 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0g4VdTy8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9E1BDE4;
	Fri, 13 Oct 2023 18:49:36 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEFEBB;
	Fri, 13 Oct 2023 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=dopeytwENW76hQH4O25uQJREIk9PlvPUQ+YaAx2KNAQ=; b=0g
	4VdTy8KD7HH2jDJZQEaqa6NxHFe9ip9rQ8dZekwAhCUoGnElWrxKR9oIt5F/+hbYSHJN/Udnt0Fpo
	iHkkmeWoWW784Lx4ShEvzdN9hD6T39jSlEQPyGse0aId5/IUl75uNITObmeb1AjSVphgpxyxBHAKI
	CygVHNt593C1NaY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrNE1-0027kL-Fv; Fri, 13 Oct 2023 20:49:29 +0200
Date: Fri, 13 Oct 2023 20:49:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun.feng@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
	benno.lossin@proton.me, greg@kroah.com
Subject: Re: [PATCH net-next v4 3/4] MAINTAINERS: add Rust PHY abstractions
 to the ETHERNET PHY LIBRARY
Message-ID: <0948fa3f-2421-47ad-89fc-8b0992d9f021@lunn.ch>
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
 <20231012125349.2702474-4-fujita.tomonori@gmail.com>
 <ZSlVgAfz-O5UR_ps@Boquns-Mac-mini.home>
 <CALNs47u9ACA3MO2soPueeGZe=yZkieKb6rDr-G1fGQePjJ5npg@mail.gmail.com>
 <CANiq72kS=--E_v9no=pFtxArxtxWNrAbgcAa4LUz28CYozbVWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kS=--E_v9no=pFtxArxtxWNrAbgcAa4LUz28CYozbVWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 08:43:21PM +0200, Miguel Ojeda wrote:
> On Fri, Oct 13, 2023 at 6:17 PM Trevor Gross <tmgross@umich.edu> wrote:
> >
> > Thanks for the suggestion Boqun :) I would be happy to be a reviewer
> > for the rust components of networking.
> 
> Thanks a lot Trevor!
> 
> > As Tomo mentioned I am not sure there is a good way to indicate this
> > niche, maybe a new section with two lists? Andrew's call for what
> > would be best here I suppose.
> 
> Yes, maintainers may prefer to split it or not (e.g. "ETHERNET PHY
> LIBRARY [RUST]"). Then Tomo and you can be there.
> 
> That also allows to list only the relevant files in `F:`, to have an
> extra `L:` for rust-for-linux (in the beginning), a different `S:`
> level if needed, etc.

Yes, this seems sensible.

I would also suggest a new entry for the driver.

Play with ./script/get_maintainer.pl --file and make sure it picks the
right people for a particular file.

      Andrew

