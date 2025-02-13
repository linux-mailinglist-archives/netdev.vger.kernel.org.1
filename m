Return-Path: <netdev+bounces-166117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C5EA34958
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF26163877
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2261FF7D8;
	Thu, 13 Feb 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVbkAzt5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE181FECCA;
	Thu, 13 Feb 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463260; cv=none; b=A2H3oO275pb30gaQPibECnLMPw2rFllDj6P6fLhLPqceop37a7HqUj+WAI+EzDw7hAamypX87cDjOu8aBKPY1ZAFnhSQcc7ar1VBADutSWTvWSZsBL1EGrFdnBcbul0q5sTuvHJpwQ2rokNCE2f/oacO6LcN1JqHqarGAGcZbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463260; c=relaxed/simple;
	bh=G6cjVJpboDfJPKkTHx0NgdsYqd0fONgDYXmdRT7GVCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2kU946AlLAPI8OslAS42my7e9MwhMIB/ET8Jj8xsTBtWwCUWLTR4Lakg+2VzxYdYNYk+gFqj2yRIHI0B21BBEEmPJVkgYngkpNfoDG3AqHCeO6tDOjWls68H0vi/vm7QkxQLXtFLoHowqm0aA3Y06K5FfLa8ATN/ngw0tLr/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVbkAzt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3FCC4CED1;
	Thu, 13 Feb 2025 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739463259;
	bh=G6cjVJpboDfJPKkTHx0NgdsYqd0fONgDYXmdRT7GVCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CVbkAzt5yvYnfw2Sq0Qi7BWnhuC23Fmz8tv6H7yaGpJxnOUVdBaVUMlaH2H212m8J
	 p920+c30/ZKkMWC03uL/pdiXmTzYByFwNWxfJNH9ItS2PVNiZbOUTqmOhoOyO015I0
	 vOAO9qT0c8R6N9DRz+9GOEUsHLEJUzH2BMmdn7RXixOEJolPgqRLjkBbDflgtmPqoH
	 XPA3jsCTSFvAYzDdXdeWLkNKg81UdymE66B2zRTFsHuTMD65Cnewogru1zA8md57b8
	 UGic4HHNukPG3Dds5YUb5spQfwMJRFZ6Gf7pi3h9et7PhlhQlBKp3TSU0B7imhQf4T
	 Em9Rm1KnHxGEA==
Date: Thu, 13 Feb 2025 08:14:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 rdunlap@infradead.org, bagasdotme@gmail.com, ahmed.zaki@intel.com, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] documentation: networking: Add NAPI config
Message-ID: <20250213081418.6d3966af@kernel.org>
In-Reply-To: <Z633ggyM-F2pfAkG@LQ3V64L9R2>
References: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
	<013921c8-1fd0-410d-9034-278fc56ff8f5@redhat.com>
	<Z633ggyM-F2pfAkG@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 05:45:38 -0800 Joe Damato wrote:
> On Thu, Feb 13, 2025 at 12:45:01PM +0100, Paolo Abeni wrote:
> > On 2/11/25 9:06 PM, Joe Damato wrote:  
> > > +++ b/Documentation/networking/napi.rst
> > > @@ -171,12 +171,43 @@ a channel as an IRQ/NAPI which services queues
> > > of a given type. For example,  
> > 
> > It looks like your client mangled the patch; the above lines are
> > corrupted (there should be no line split)
> > 
> > Please respin  
> 
> I must be missing something: I don't see the line split when looking
> at the original email and I just tried applying the patch directly
> from my email and it applied just fine.
> 
> Are you sure its not something with your client?
> 
> See the message on lore:
> 
> https://lore.kernel.org/netdev/20250211151543.645d1c57@kernel.org/T/

It's also broken on lore.

The first diff block starting with the @@ line overflows and gets
broken into the next line. All lines within a diff block must start
with a space, + or -. The "of a given type. For example," line breaks
that.

