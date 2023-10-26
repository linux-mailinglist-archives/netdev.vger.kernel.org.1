Return-Path: <netdev+bounces-44609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 912EE7D8C51
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 01:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E90B211F9
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 23:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFB13FE35;
	Thu, 26 Oct 2023 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DGNSsf1w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3218050;
	Thu, 26 Oct 2023 23:48:46 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6F41A5;
	Thu, 26 Oct 2023 16:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=A1G3XwA17+lul+TwoDNyC2Tm65smi0FiIfd0a7wJkmI=; b=DG
	NSsf1wo+zxHxtQ4wyo3G7pEz0CPXgLSdSATU8ZMmG62awi2YJBArddxWorXWOMwzoji9qGJWwgua0
	YigXFlLTzRpsrT38Z5/bHNb3fhbVYBrV/YyxWp1za6eYziSxMiBbCeaE5L/MQqb7KO6bjcLsV31si
	urVzJJTtjQUXxuA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwA5i-000IDP-36; Fri, 27 Oct 2023 01:48:42 +0200
Date: Fri, 27 Oct 2023 01:48:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Message-ID: <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>

On Thu, Oct 26, 2023 at 12:39:46PM +0200, Miguel Ojeda wrote:
> On Thu, Oct 26, 2023 at 2:16 AM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > This patchset adds Rust abstractions for phylib. It doesn't fully
> > cover the C APIs yet but I think that it's already useful. I implement
> > two PHY drivers (Asix AX88772A PHYs and Realtek Generic FE-GE). Seems
> > they work well with real hardware.
> 
> This patch series has had 8 versions in a month. It would be better to
> wait more between revisions for this kind of patch series, especially
> when there is discussion still going on in the previous ones and it is
> a new "type" of code.

That is actually about right for netdev. As i said, netdev moves fast,
review comments are expected within about 3 days. We also say don't
post a new version within 24 hours. So that gives you an idea of the
min and max.

It is however good to let discussion reach some sort of conclusion,
but that also requires prompt discussion. And if that discussion is
not prompt, posting a new version is a way to kick reviewers into
action.

	Andrew

