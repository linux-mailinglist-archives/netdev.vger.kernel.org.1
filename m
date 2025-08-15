Return-Path: <netdev+bounces-213879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BCFB2734F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FEA189FC4F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90D3632;
	Fri, 15 Aug 2025 00:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR/WtMJm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E019A;
	Fri, 15 Aug 2025 00:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216316; cv=none; b=Z5ef6UWOfEVV2EC7ADjyy2oPmV9IWBps8wy/9E1JD1x/lnrjbrckNoCYKyCYo+/GStX20xiEa68cAe8PJlUsJ/Wd7wzo6crHqK1s/Z13hrBVnfdxQsR3oj5EpYymZ+z26t7s/Ix7Yi0dJvLbIDPt7q1rXmwmlTAAcVKCLLYL6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216316; c=relaxed/simple;
	bh=7dUsTsSK7gqVGOxQ1zAJsMO6P3fVMBi+evB+rC2jmUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrKwTWYAEqnce4uaODbm9qXLcJZA9CB9VwrDfVb7mc7j87x9CNzDix8DHjCH9t40gkApQFIdIihMdv7shcNOq6CBTjrL5F2lj2Vaw3imupFVV1AsbW6zXaq2qqZt64G5rtw3shmrBB8OdTmI003bhD0gAVv04PJd2yY/FoYQ03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR/WtMJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81F1C4CEED;
	Fri, 15 Aug 2025 00:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755216316;
	bh=7dUsTsSK7gqVGOxQ1zAJsMO6P3fVMBi+evB+rC2jmUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cR/WtMJmGk8TLTLepN6v3fkzooEqcO0S6zzuKG6ehadShbxLY4Pkd4PB9J6Jqpuqj
	 bQs+XSOuwGRFXeVVPaewgPry/pCHke/T++S3ecxtUCpGt5PpbMqXDHcH4UquHfGvJ/
	 hRJZjhsqV2Sykf0Yt5eEcySPd3nNm2aO9Pa3dBXhdJCj6dakjYbvNDFTKnXzN8w/f0
	 kdJmUxUtb09PD5/VUKEqksEPgjF9CQgtRMNnGZ/3M9M5dUiownyl/XsBwpWgzTh9hy
	 P3sS13YBqx4fhzvt+mcIXpOpJ8vD45ssexEQ7rXfFmd/bSaERvIqbKplXi4Qj4s5Uz
	 0mFJRQOyF9+GA==
Date: Thu, 14 Aug 2025 17:05:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, horms@kernel.org, jstancek@redhat.com,
 jacob.e.keller@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl: make ynl.c more c++ friendly
Message-ID: <20250814170514.3fb6e690@kernel.org>
In-Reply-To: <aJ5y-WWCZAlJ9QUy@mini-arch>
References: <20250814164413.1258893-1-sdf@fomichev.me>
	<20250814152707.6d16c342@kernel.org>
	<aJ5y-WWCZAlJ9QUy@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 16:36:25 -0700 Stanislav Fomichev wrote:
> > As I mentioned in person, ynl-cpp is a separate thing, and you'd all
> > benefit from making it more C++ than going the other way and massaging
> > YNL C.
> > 
> > With that said, commenting below on the few that I think would be okay.  
> 
> Ok, and the rest (typecasts mostly and the namespace) - you're not supper
> happy about? I can drop that test_cpp if that helps :-)

No, they are illogical from C's standpoint :(
I really don't get the need for the adjustments, the code generator is
obviously different for C++, and that's a major effort. The ynl.c casts
are trivial in comparison.
 
> > > @@ -149,7 +153,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
> > >  		return n;
> > >  	}
> > >  
> > > -	data_len = end - start;
> > > +	data_len = (char *)end - (char *)start;  
> > 
> > can we make the arguments char * instead of the casts?  
> 
> Let me try. That might require to char-ify helpers like ynl_nlmsg_data_offset
> and ynl_nlmsg_end_addr.

Hm, then probably let's leave it as void *

