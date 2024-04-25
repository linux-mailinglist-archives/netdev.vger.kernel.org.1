Return-Path: <netdev+bounces-91233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B258B1CCA
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14431B234E5
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDA275808;
	Thu, 25 Apr 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3TcolUz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830256F06A;
	Thu, 25 Apr 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033601; cv=none; b=YNazuEoJnksJoBHQema2hQ3xkrOm9vB6bXjtqMSxCzE5M/jFgWkljkXsatxLa4+VzYj+1osOJZ7vO7Qwx+Vlcyov/QAH6vweTgf18zmA8RveVxboTBxVDXRSjF72DhGmZdXh/Ubr24SALVcKrphhBMeAkdjlcwVLXZ2zgWTLDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033601; c=relaxed/simple;
	bh=y9sSLIMwYAS8y83em6ArzgpfKTsLxDnIAIP9bLbpEww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHDlRH0RsqGj/PkCZ6Y02ZkBpHdV38y6B5ljPf6IRF0rBzEo8vuIDYutwfksT0p990KsE36scEIE3jTqcCi2176ClJza3W2wdC0uMM/eSPfTTuq2DKdmiPkvDPo/f2tvrxE6RrxrVr9Ze7bmgXivZJEUujoYww2/1YwonCYIreg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3TcolUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6A9C113CC;
	Thu, 25 Apr 2024 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714033601;
	bh=y9sSLIMwYAS8y83em6ArzgpfKTsLxDnIAIP9bLbpEww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3TcolUzMNqZ71LfEYHyVXxM5Eqe5YNUdMd+koxS6N1SmQ44wgDbtut3bwlVf5YmB
	 oaq1dAxh/zj5RegbRhUWIRVJQ1LowCjvG/yrY+bx0RoqJOTRihzqOeKPgv0QTUar9K
	 n8Qe3NmR2+mKcTr7VXQ2NdRn5+oj7mApPoZNfdnO3eyxdlipJJY4rw7yUxo72JuNZ5
	 o06NKvx9hBzPZPlLA6OHiB069FEzRppb6wiCFPFlh3DSP47O0cx37aLdpv3I8JWvgy
	 Td2uwPbTKkG4FqJT90mlG/hCvnxO3w3wcPDYGoX3ZpIf+E5EX8Oglwx+jvAMPomDgx
	 M5dTVPnd6cz4w==
Date: Thu, 25 Apr 2024 09:26:37 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
	dev@openvswitch.org, linux-kselftest@vger.kernel.org
Subject: Re: selftests: openvswitch: Questions about possible enhancements
Message-ID: <20240425082637.GU42092@kernel.org>
References: <20240424164405.GN42092@kernel.org>
 <20240424173000.21c12587@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424173000.21c12587@kernel.org>

On Wed, Apr 24, 2024 at 05:30:00PM -0700, Jakub Kicinski wrote:
> On Wed, 24 Apr 2024 17:44:05 +0100 Simon Horman wrote:
> > I have recently been exercising the Open vSwitch kernel selftests,
> > using vng,
> 
> Speaking of ovs tests, we currently don't run them in CI (and suffer
> related skips in pmtu.sh) because Amazon Linux doesn't have ovs
> packaged and building it looks pretty hard.
> 
> Is there an easy way to build just the CLI tooling or get a pre-built
> package somewhere?
> 
> Or perhaps you'd be willing to run the OvS tests and we can move 
> the part of pmtu.sh into OvS test dir?

Thanks Jakub,

The plot thickens.
We'll look into this (Hi Aaron!).

