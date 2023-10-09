Return-Path: <netdev+bounces-39151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9A77BE3B2
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F991C20A67
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA5128DD9;
	Mon,  9 Oct 2023 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0OqTOii3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84E1A582;
	Mon,  9 Oct 2023 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF77C433C7;
	Mon,  9 Oct 2023 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696863409;
	bh=OBBS9Y7ppYPt/1t48qLHR6+TDFPlDzCneFFVnF6W1U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0OqTOii3eC8VOtzWzC6qGOVNsglcOQPh82q6aW3prf7ad2HzJYPTTmsB5OeDKSxee
	 LhoeFcyogw3ipvd7s1NccTBrR3hkbpmE63uQOiH6npWV9oLmjDUx/LcQBhFY2a/gVo
	 YBVNg4lhUKfT8t36BPD/wyeS6FnzELAlzpwdYnc8=
Date: Mon, 9 Oct 2023 16:56:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
Message-ID: <2023100901-panic-strobe-5da7@gregkh>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch>
 <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
 <ZSQMVc19Tq6MyXJT@gpd>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSQMVc19Tq6MyXJT@gpd>

On Mon, Oct 09, 2023 at 04:21:09PM +0200, Andrea Righi wrote:
> On Mon, Oct 09, 2023 at 02:53:00PM +0200, Miguel Ojeda wrote:
> > On Mon, Oct 9, 2023 at 2:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > Any ideas?
> > 
> > That is `RETHUNK` and `X86_KERNEL_IBT`.
> > 
> > Since this will keep confusing people, I will make it a `depends on !`
> > as discussed in the past. I hope it is OK for e.g. Andrea.
> 
> Disabling RETHUNK or IBT is not acceptable for a general-purpose kernel.
> If that constraint is introduced we either need to revert that patch
> in the Ubuntu kernel or disable Rust support.

Why is rust enabled in the Ubuntu kernel as there is no in-kernel
support for any real functionality?  Or do you have out-of-tree rust
drivers added to your kernel already?

thanks,

greg k-h

