Return-Path: <netdev+bounces-121677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299CB95E007
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 23:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C53282857
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EE47F490;
	Sat, 24 Aug 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdYMnj4i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D529A1
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724534843; cv=none; b=avt1pOF1be40yD2Z4QG4OPyJPnMeh7qvm6Fas3lGjy5fQjdUwiYBV6+/J0miFCgSXY54Ir9zm8DHLvbUObi518pzjXWAHemBl9j2+aQd7OPNWkcocZvWdkPLGv6UNuSaS4cvrLK7l4iXWkUxNfDXMAlDYTzi3vfvvsZBp+pNviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724534843; c=relaxed/simple;
	bh=/z5llz51kyrimXVLsEJENL05nSG70TvBsdWSQghjCVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVlfOKnfszA0ity5dW/tvmgtDljqZDc1lz5XXzRHGDDZLwqG2PZ9BsWWJhWLG8E/vQJa2KvHXxltmEG9iATlvBvVKELq7FXPLoyOK1rDdqKnQKVOB/7lzlek64H2mUmOqEdGcpxXr+6NGMcvZRMxbOWMVaBYkJRDfPaibu6UsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdYMnj4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430E1C32781;
	Sat, 24 Aug 2024 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724534842;
	bh=/z5llz51kyrimXVLsEJENL05nSG70TvBsdWSQghjCVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SdYMnj4iovYCI6cE9sTIi7bURO6gSGMil12ohNeahevspNRYX2nNew6hpWbjN0/AE
	 XxMformZPCC5I+lRGFjZxDzlLEHKKrz0QxMq42Ku3wHm3ggvOreire8eGAP65Yyn89
	 U7gP673QQm7o/4jjO9QCoVEsNRTdYFP0t34EpYMeCgN7d4nOVfcHA7PhKkZ1iqawnu
	 IFbs8+AH6/FKaMdBJf5hRJ/kQ+6GMQ/hulwrry5szWTtqczAbcE7Kpb/yy37UFHvqv
	 jBsyIAyziLJEaqInqhCRAMzYQMH9DALM7uoPc/8HxTabCK532io24RxVqh0H0ClnDz
	 6QSf/ZtJislAA==
Date: Sat, 24 Aug 2024 14:27:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu
 <liuhangbin@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] forwarding/router_bridge_lag.sh started to flake on
 Monday
Message-ID: <20240824142721.416b2bd0@kernel.org>
In-Reply-To: <87ttfbi5ce.fsf@nvidia.com>
References: <20240822083718.140e9e65@kernel.org>
	<87a5h3l9q1.fsf@nvidia.com>
	<20240823080253.1c11c028@kernel.org>
	<87ttfbi5ce.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 18:13:01 +0200 Petr Machata wrote:
> >> +	ip link set dev $swp2 down
> >> +	ip link set dev $swp1 down
> >> +
> >>  	h2_destroy
> >>  	h1_destroy
> >>    
> >
> > no_forwarding always runs in thread 0 because it's the slowest tests
> > and we try to run from the slowest as a basic bin packing heuristic.
> > Clicking thru the failures I don't see them on thread 0.  
> 
> Is there a way to see what ran before?

The data is with the outputs in the "info" file, not in the DB :(
I hacked up a bash script to fetch those:
https://github.com/linux-netdev/nipa/blob/main/contest/cithreadmap

Looks like for the failed cases local_termination.sh always runs 
before router-bridge, and whatever runs next flakes:

Thread4-VM0
	 5-local-termination-sh/
	 20-router-bridge-lag-sh/
	 20-router-bridge-lag-sh-retry/

Thread4-VM0
	 5-local-termination-sh/
	 16-router-bridge-1d-lag-sh/
	 16-router-bridge-1d-lag-sh-retry/

