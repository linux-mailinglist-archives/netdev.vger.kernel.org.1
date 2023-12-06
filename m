Return-Path: <netdev+bounces-54495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB89A8074AB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD901F21119
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFDE4652F;
	Wed,  6 Dec 2023 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDaBk8oy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215A45C07
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 16:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC7EC433C9;
	Wed,  6 Dec 2023 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701879366;
	bh=TW0AmPkYX24sBHeEG3RakYksjiTRdyI8dsuTvaSIDg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FDaBk8oy/g6GOx3UZ6ZZczWbcJXNktCKvfjCqSKKlELCVDIUTdbkKX0QQ6Exfu153
	 N7bQX6AxgGvfmA0SwqLqpf8J/JYFwkzAPnoz4SNiEdJOhTQxgZH3Yv4rX6T9WzqTLw
	 yJXik30CM2zcbDhwwTqRItdie9Aqj2Ow5hHS3ps/JDg8JohyaQyrSjjmESqrDdAz5E
	 i9ygd+NWAWe0IGloqL2gj2i2u1sMPy4q+dTvO/SNRp/e3tjNtv8LBI7EPg69LFlQfw
	 nAfuGWmNFDqBa3BTzBxcNw80lEntgcXlJe1qa77pnXQGPz4bP6dAJxa74xKTwvD1Ru
	 zu6D9Ocd2SIIA==
Date: Wed, 6 Dec 2023 08:16:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <mkubecek@suse.cz>, "Chittim, Madhu"
 <madhu.chittim@intel.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>
Subject: Re: [RFC] ethtool: raw packet filtering
Message-ID: <20231206081605.0fad0f58@kernel.org>
In-Reply-To: <459ef75b-69dc-4baa-b7e4-6393b0b358ce@intel.com>
References: <459ef75b-69dc-4baa-b7e4-6393b0b358ce@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Dec 2023 11:23:34 -0700 Ahmed Zaki wrote:
> We are planning to send a patch series that enables raw packet filtering 
> for ice and iavf. However, ethtool currently allows raw filtering on 
> only 8 bytes via "user-def":
> 
>    # ethtool -N eth0 flow-type user-def N [m N] action N
> 
> 
> We are seeking the community's opinion on how to extend the ntuple 
> interface to allow for up to 512 bytes of raw packet filtering. The 
> direct approach is:
> 
>    # ethtool -N eth0 flow-type raw-fltr N [m N] action N
> 
> where N would be allowed to be 512 bytes. Would that be acceptable? Any 
> concerns regarding netlink or other user-space/kernel comm?

We need more info about the use case and what this will achieve.
Asking if you can extend uAPI is like asking if you can walk in
the street. Sometimes you can sometimes you can't. All depends
on context, so start with the context, please.

