Return-Path: <netdev+bounces-37437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C0D7B5578
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9DC23281F3F
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A891A1A70F;
	Mon,  2 Oct 2023 14:52:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB1468C;
	Mon,  2 Oct 2023 14:52:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F6A7;
	Mon,  2 Oct 2023 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F9ebOW58mJqTQNBYhfDZiXNY/bfWZLi0CCo+kl+A+Hg=; b=u/eFfoBIyo3jbVzuNPQDr8LL1n
	GuUmlpZryZ7jXCQEWDFYsTOxOJb080n6i/F7quh2g2pno0dXMTW3uAZRNQownI954U3MXRPqz2UYP
	8h38AL3w7m3BmN4Mr/MfC6AqQeKUKmMoN9EQXtbHXlmKGkHAhk9e6RYeeEZhLaDIAon0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qnKHt-0081q0-7b; Mon, 02 Oct 2023 16:52:45 +0200
Date: Mon, 2 Oct 2023 16:52:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v1 1/3] rust: core abstractions for network PHY drivers
Message-ID: <ec65611a-d52a-459a-af60-6a0b441b0999@lunn.ch>
References: <20231002085302.2274260-1-fujita.tomonori@gmail.com>
 <20231002085302.2274260-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002085302.2274260-2-fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +//! Networking.
> +
> +#[cfg(CONFIG_PHYLIB)]

I brought this up on the rust for linux list, but did not get a answer
which convinced me.

Have you tried building this with PHYLIB as a kernel module? 

My understanding is that at the moment, this binding code is always
built in. So you somehow need to force phylib core to also be builtin.
Or you don't build the binding, and also don't allow a module to use
the binding.

	Andrew

