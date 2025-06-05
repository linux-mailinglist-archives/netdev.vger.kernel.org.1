Return-Path: <netdev+bounces-195266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB5ACF1E7
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 16:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7347A4884
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A93078F2B;
	Thu,  5 Jun 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIP7LKJp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259002E659
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749133600; cv=none; b=PP/jR4XMdhXrG8Q92lO1XaAc1f9i+Fs7helYkfSNMDmAGiVGUGigfVcYHMy+9JD92u5MZOR+7MuOWd+YIACtKAQ4xju0bQBHNGxsKqW1gIEwhqt95lZU+0vGE3teOshpYt+7F5nvWbdW4cfrD0gFlhtbZ6WQebtK+kTai1FqrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749133600; c=relaxed/simple;
	bh=FgO/xYFGLmA3+zrMUPFQv8XM3nrP5MZZP2waJZ2YJbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzCx4/NgO/coDK9pvO3XYg180re4OJ3iTSTh2uEN4kUzWUt/I/+2jXJKH4+03wgCb2hYsEV5snBFV4GB/haIL2wnIsXuMvwowIkVT2etLSGOof63FMsOYEg5S4LjkFLFIV1FiGpSq784+Rp8F5mYhtGABDM47UBYBEfm9nIvzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIP7LKJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7EFC4CEE7;
	Thu,  5 Jun 2025 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749133599;
	bh=FgO/xYFGLmA3+zrMUPFQv8XM3nrP5MZZP2waJZ2YJbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GIP7LKJpZ6v6jCua+0EqP5HlvHjZzdWe6nAX5WfbzrZPE9Y2O8ZDcizuOz8eR4ozd
	 oEp0RCwJ9ox28h3EOTdhNlqelLSNHzmlMIrjfwHBfyyiEZ7EuZgFfhK034Yrx5V59B
	 g5IGH5H/zqpIPogRl0UYUqdpldqFqjcJtKNtOB1K8xMeEILtaixulNwt/w+M1ZXtmN
	 wM9ryXvdnnnRXUt1Ih+uzwpnMqrHkonC9D97mDktLy+9cIfOqExINZQiyKzTHGr4Jf
	 bIXRQZxlM2pSa25/XHrEmxDshmT9yCB5WKxiGcZpjNUBEif5vOawZBek5y0ensimms
	 u3Zj5AIFEhDSQ==
Date: Thu, 5 Jun 2025 07:26:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [ANN] pylint and shellcheck
Message-ID: <20250605072638.57c56f95@kernel.org>
In-Reply-To: <m24iwuv9wt.fsf@gmail.com>
References: <20250603120639.3587f469@kernel.org>
	<m2ldq7vo79.fsf@gmail.com>
	<20250604164343.0b71d1ed@kernel.org>
	<m24iwuv9wt.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Jun 2025 10:02:10 +0100 Donald Hunter wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> 
> > On Wed, 04 Jun 2025 10:41:14 +0100 Donald Hunter wrote:  
> >> This is a possible config for yamllint:
> >> 
> >> extends: default
> >> rules:
> >>   document-start: disable
> >>   brackets:
> >>     max-spaces-inside: 1
> >>   comments:
> >>     min-spaces-from-content: 1
> >>   line-length:
> >>     max: 96  
> >
> > This fits our current style pretty nicely!
> >
> > One concern I have is that yamllint walks down the filesystem
> > CWD down to root or home dir. So if we put this in
> > Documentation/netlink/.yamllint people running yamllint from main dir:
> >
> >  $ yamllint Documentation/netlink/specs/netdev.yaml
> >
> > will be given incorrect warnings, no? Is there a workaround?  
> 
> I don't see a workaround without some kind of wrapper.
> 
> Maybe just add a makefile? Looks like that was the approach taken for
> Documentation/devicetree/bindings

If we can live with the document-start annoyance I was wondering 
if we can stick to the "default" as is? We can fix existing
docs slowly, the patchwork script will ignore pre-existing warnings.

