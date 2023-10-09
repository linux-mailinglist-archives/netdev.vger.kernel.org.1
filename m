Return-Path: <netdev+bounces-39159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E91D7BE408
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92461C20975
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAACA358A5;
	Mon,  9 Oct 2023 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DyvZ7DRM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8457358A1;
	Mon,  9 Oct 2023 15:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F347FC433C7;
	Mon,  9 Oct 2023 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696864314;
	bh=k/0FHcU9Z5oRcvhuVZGBQb8npBBzkse68C6uKrz+tGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyvZ7DRMeBSeA5ukSsdB28CHCWPgpg8L2ltkrATEKA/Jf4sqSUmp9cuRnwib9pmf1
	 U4V3nvX7fOCXmk/BEIR0D56JlucDuJB9VWMzA7ZfMAATz66KkfvLL7RVMe0PikAJ/8
	 JEagGr99/ZBk79NVpqQAy5qeqhd2075DW44nayRE=
Date: Mon, 9 Oct 2023 17:11:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <2023100926-ambulance-mammal-8354@gregkh>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-2-fujita.tomonori@gmail.com>
 <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
 <20231009.224907.206866439495105936.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009.224907.206866439495105936.fujita.tomonori@gmail.com>

On Mon, Oct 09, 2023 at 10:49:07PM +0900, FUJITA Tomonori wrote:
> On Mon, 9 Oct 2023 14:59:19 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> 
> > A few nits I noticed. Please note that this is not really a full
> > review, and that I recommend that other people like Wedson should take
> > a look again and OK these abstractions before this is merged.
> 
> We have about two weeks before the merge window opens? It would great
> if other people could review really soon.
> 
> We can improve the abstractions after it's merged. This patchset
> doesn't add anything exported to users. This adds only one driver so
> the APIs can be fixed anytime.

There is no rush, or deadline here.  Take the time to get it in proper
shape first please.

thanks,

greg k-h

