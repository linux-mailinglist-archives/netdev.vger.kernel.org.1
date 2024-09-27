Return-Path: <netdev+bounces-130149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4394988A16
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 20:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754A9282F88
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 18:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FB615B57C;
	Fri, 27 Sep 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNBD/UnR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C52E630;
	Fri, 27 Sep 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727461904; cv=none; b=f6XOVMO/OaXjVI8KUK7XWwfQGJ97s9UQ6hVez16i1REve/P+/upBOl29N9OYGk8/3IWevCJmw9/gkRvei2ViiBBtL0oiOymLOFpDPo9GsbxvmCPPM/gJHC5DesZ7CBtTnitOC2l2kZNcDaJpfA2mrWTEJFSi1YehRx7hyQlXJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727461904; c=relaxed/simple;
	bh=pRgcucGGq3NpbF+6ZpQ5ul4mRjbMP2mSXTKpDowm/hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEvedEPtuin8pGuxJsu+JaOeFh64nMdFuCJoee6i1tbkGg1lHIVIe5XKt3PsT3A3935CqLyX913nNh8ngsvC3lazHHu0P29FwulE0yb+nYPksxYDgbcYeUd/dCovLrJhp01z+YnZ2TiGLgTcsHFvQ8ZDKdbesG3MRYgxDrBFm2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNBD/UnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C54C4CEC4;
	Fri, 27 Sep 2024 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727461904;
	bh=pRgcucGGq3NpbF+6ZpQ5ul4mRjbMP2mSXTKpDowm/hQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNBD/UnRsDKpRqriN9jslLVWaPnk+tEw810sivK70VMFzCw938UlOdoIuuYs5YohD
	 5rCYjPQF6c0JGqbECwrpnfG0RXmFvpYB6ZrehBUCpMSiYdFroUcOxE6fP4d1m9LHSW
	 d5mCqo/Vs4Hd/gKt1QEoxPK5Cdx1WOavVDwI4yU5KZ3VK02Z1jgAfSXYPbQErkucvH
	 N3cxxukgXCtcshYOtnWyrMgk8v1Dn+ejKHrjbTbfyLsUry0ntWv5ScNJ5O+WHT/AKm
	 QRTcc5K91IHUJ0NzToiqxZ5VUVwauPzcZINUK0TzJDckqQMFj6RAylOekUq5Thurls
	 p6cI1mW6se7Zw==
Date: Fri, 27 Sep 2024 19:31:40 +0100
From: Simon Horman <horms@kernel.org>
To: yanzhen <11171358@vivo.com>
Cc: Yan Zhen <yanzhen@vivo.com>, 3chas3@gmail.com,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] atm: Fix typo in the comment
Message-ID: <20240927183140.GM4029621@kernel.org>
References: <20240925105707.3313674-1-yanzhen@vivo.com>
 <20240925200539.GA4029621@kernel.org>
 <812b36ac-2fcc-4107-99ad-a44e3e2eda71@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <812b36ac-2fcc-4107-99ad-a44e3e2eda71@vivo.com>

On Fri, Sep 27, 2024 at 04:22:19PM +0800, yanzhen wrote:
> 
> 在 2024/9/26 4:05, Simon Horman 写道:
> > On Wed, Sep 25, 2024 at 06:57:07PM +0800, Yan Zhen wrote:
> > > Correctly spelled comments make it easier for the reader to understand
> > > the code.
> > > 
> > > Fix typos:
> > > 'behing' ==> 'being',
> > > 'useable' ==> 'usable',
> > > 'arry' ==> 'array',
> > > 'receieve' ==> 'receive',
> > > 'desriptor' ==> 'descriptor',
> > > 'varients' ==> 'variants',
> > > 'recevie' ==> 'receive',
> > > 'Decriptor' ==> 'Descriptor',
> > > 'Lable' ==> 'Label',
> > > 'transmiting' ==> 'transmitting',
> > > 'correspondance' ==> 'correspondence',
> > > 'claculation' ==> 'calculation',
> > > 'everone' ==> 'everyone',
> > > 'contruct' ==> 'construct'.
> > > 
> > > 
> > > Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> > Hi,
> > 
> > I am curious to know which tree is this based on?
> > I don't seem to be able to apply it to net-next, linux-net,
> > or Linus's tree.
> I apologize, I may not have generated the patch based on the latest branch.
> Is the net-next branch currently closed? Should I wait for it to reopen
> before submitting?

Yes, net-next is currently closed.
And yes, I think it would be best to wait for it to reopen.
I expect that will happen next week.

-- 
pw-bot: defer

