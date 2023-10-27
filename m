Return-Path: <netdev+bounces-44904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B8E7DA3C9
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F90A2824A5
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B15639871;
	Fri, 27 Oct 2023 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IpV9dsQC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5203A38BAC;
	Fri, 27 Oct 2023 22:55:35 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1F1B8;
	Fri, 27 Oct 2023 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8BJbEzI3b4RN/xcGusAHw9OPgretZQ0T2NC2/av2UlQ=; b=IpV9dsQCA839lbeS8qlJ8dUbMP
	+beKq06CQA3qjAXfuOSEVbK/k5XRnIW2jG0fneKb7XE0Lx54TVDuXsPQSjfBkPND2sb+BTgPOpQcQ
	L2/m8dK5wa18V4P/u7G1qaDlZs14V0P7yUn04P47/49UvIP/Lis0/+6//ZJhbVaFXzp0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwVjn-000NZx-Kv; Sat, 28 Oct 2023 00:55:31 +0200
Date: Sat, 28 Oct 2023 00:55:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Message-ID: <ca9fc28e-f68a-4b80-b21f-08a3edf3903a@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
 <CANiq72mDVQg9dbtbAYLSoxQo4ZTgyKk=e-DCe8itvwgc0=HOZw@mail.gmail.com>
 <20231027072621.03df3ec0@kernel.org>
 <CANiq72n=ySX08MMMM6NGL9T5nkaXJXnV2ZsoiXjkwDtfDG11Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72n=ySX08MMMM6NGL9T5nkaXJXnV2ZsoiXjkwDtfDG11Rw@mail.gmail.com>

> For instance, as a trivial example, Andrew raised the maximum length
> of a line in one of the last messages. We would like to avoid this
> kind of difference between parts of the kernel -- it is the only
> chance we will get, and there is really no reason to be inconsistent
> (ideally, even automated, where possible).

It should be noted that netdev prefers 80, which the coding standard
expresses as the preferred value. checkpatch however now allows up to
100. The netdev CI job adds an extra parameter to checkpatch to
enforce the preferred 80.

You will probably find different levels of acceptance of 80 to 100 in
different subsystems. So i'm not sure you will be able to achieve
consistence.

It should also be noted that 80, or 100, is not a strict limit. Being
able to grep the kernel for strings is important. So the coding
standard allows you to go passed this limit in order that you don't
need to break a string. checkpatch understands this. I don't know if
your automated tools support such exceptions.

     Andrew


