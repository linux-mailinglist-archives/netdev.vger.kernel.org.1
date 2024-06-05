Return-Path: <netdev+bounces-101129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459058FD6CE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC21C225E2
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A3154C11;
	Wed,  5 Jun 2024 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8OcjhBH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD11154C05
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617248; cv=none; b=ADH5CmribsqlCDG5tnVksdCQBsZ0E1LY2LT6J2vfThWBTS7nelh0BJ7XZ6X9RwEz32yazeL9JO1kS9opcVaXgNNwPPh/lggTL5xtoFrTUvuZ+OKlA5qyq9hGSmkc+t3aMNTakKztXBTHKWJN4IKuR/bQ/IJH2hABf/vTwR4Bfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617248; c=relaxed/simple;
	bh=ZnCDNagvAZcc72EV5p9GFgEPkTuD01HczH0t///6cIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4bWG9f9zcAFZkSICgJCG4rvV9Etbnj7GZMvO7zcjILdrEXA7nqAewBmO564xISbfI6GYd3aI3+6sDoBrlCrDqt7qnjL6Es7yHIqTGhHJAtqKYZV/POVRrL8IcpD4H2B6fDNejcjxGjtuQmF/lmyEqUYF5TDlyPwPXaaRUe65WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8OcjhBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79620C2BD11;
	Wed,  5 Jun 2024 19:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717617247;
	bh=ZnCDNagvAZcc72EV5p9GFgEPkTuD01HczH0t///6cIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8OcjhBHqZaoujBbhDlZf6w8I49+tmsN9PIHsda+KdKubZyseni+BgvY5J/ot/rD9
	 8ElVTXZcFCtKs0vuVZ0doyo14pgntVdv8wnvkjF2FfQTfyDDmd551yVWtmi0Gu4XEA
	 z/HOtVp4E4JHVCIcVon9ELtiNF84zNPRCo/H8b66vTX6uxEY16IrSk3jC1woGr3MLS
	 zRQDOZYP4njYrHlpBqVBZfwIZdSlnRFLFMXnnQR0DFu+MRVE1dSOvAhDGnBOMs4ZeR
	 KCerj3B2si7zjEI3xOm8jlo2glWVNE5m+9SaX/2SfUPf0SN3pJAJ0rJeAqhX5NXTKx
	 tqcS4wa6vqwoQ==
Date: Wed, 5 Jun 2024 20:54:03 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] net: allow rps/rfs related configs to be
 switched
Message-ID: <20240605195403.GZ791188@kernel.org>
References: <20240531164440.13292-1-kerneljasonxing@gmail.com>
 <20240604170357.GB791188@kernel.org>
 <CAL+tcoCCEdLEOJj9G=3nxTeCHarMhFbh9KTLHKLDVWfhqWXy2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCCEdLEOJj9G=3nxTeCHarMhFbh9KTLHKLDVWfhqWXy2w@mail.gmail.com>

On Wed, Jun 05, 2024 at 08:54:03AM +0800, Jason Xing wrote:
> Hello Simon,
> 
> On Wed, Jun 5, 2024 at 1:04 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Sat, Jun 01, 2024 at 12:44:40AM +0800, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > After John Sperbeck reported a compile error if the CONFIG_RFS_ACCEL
> > > is off, I found that I cannot easily enable/disable the config
> > > because of lack of the prompt when using 'make menuconfig'. Therefore,
> > > I decided to change rps/rfc related configs altogether.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> > Hi Jason,
> >
> > FWIIW, I think it would be appropriate to also add help text for each option.
> > And I would drop "Enable", modeling Kdoc on, f.e. CONFIG_CGROUP_NET_CLASSID.
> 
> Thanks for your review.
> 
> I will adjust as you suggest in the next submission.

Thanks.

> > Likewise for CONFIG_BQL, although that isn't strictly related to this
> > patch.
> 
> Yes, I can see. I think I could write another patch to do this since
> currently I would like to submit a rps/rfs related patch.

Yes, of course.
It's a separate issue.

