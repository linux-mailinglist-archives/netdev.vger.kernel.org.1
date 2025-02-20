Return-Path: <netdev+bounces-168287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC20A3E660
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED5D700BA0
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ED32641D2;
	Thu, 20 Feb 2025 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbuewJak"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC21EBFFC
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085862; cv=none; b=j/rbd05Ke8zEQZIM3QAT7oBjQZk8miPLvmTK6YHmtsQi0GpQvh/MRtzqut2O3zBGEL7fcvctARIxdiWugo3gyr0QvxP+8NzkJhwwa+hdEj14V1t0FQ9cbUFWUNzqaZFjPMInr/HNB4MMW1gcBqUqComiYo7e2aefvv/RuCNP5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085862; c=relaxed/simple;
	bh=sDt/Ja0tPmDhARhwBebHYt/DiDW1QuTAQlDG4Rrx6lI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0nLR16kTeHvK6fqNqnY2bJ7a339OYM+VQAx2Jn0erexLAZRBIeJXo3YCviUeTutLPCB63ZWYybxLc7cQl9+BC12hF9YZk4PCUTyrHdo/VX+zI1i8KADNWuP2n/4Gx73M8IGTpx5WC9fvAgnoSDmG4XeuKITMEIi1quQ5E1oEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbuewJak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80205C4CED1;
	Thu, 20 Feb 2025 21:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740085860;
	bh=sDt/Ja0tPmDhARhwBebHYt/DiDW1QuTAQlDG4Rrx6lI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QbuewJakecEjrFhbrnWk9J9mL4567tai/P78XxxUQyfhk41JcTHbiK66WnBI+hrAV
	 NWoiTzjeS/gN/RiTnRqtSWtUmMVfxszY+fUaSzrUtYwoVqGZOAmHxwbEhhDrSxyeyo
	 DFLVFIjaBZANVem2BIFWlUJfNYHI0AaObest4WrHIs2MhGBOCTuC9kjMtQsemH0Wgw
	 UKef2Qn17j7lfHlPK3s1ovh4T2Bp2+ea4A6qCJReNUpUA2jLJ5mN9l/DsSBJ/f9Zwz
	 Tf9M3D6q1vLN7+svBDshLKtzG4GbNbWRpbIHPP7/vOb5wS2pzGizIU/FVhCauvp9nB
	 ON3b9TvNcw9ZQ==
Date: Thu, 20 Feb 2025 13:10:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 stfomichev@gmail.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 1/7] selftests: drv-net: add a warning for
 bkg + shell + terminate
Message-ID: <20250220131059.66d590e0@kernel.org>
In-Reply-To: <Z7eDF2lsaQbWl0Yo@LQ3V64L9R2>
References: <20250219234956.520599-1-kuba@kernel.org>
	<20250219234956.520599-2-kuba@kernel.org>
	<Z7eDF2lsaQbWl0Yo@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 14:31:35 -0500 Joe Damato wrote:
> > +        if shell and self.terminate:
> > +            print("# Warning: combining shell and terminate is risky!")
> > +            print("#          SIGTERM may not reach the child on zsh/ksh!")
> > +  
> 
> This warning did not print on my system, FWIW. Up to you if you want
> to respin and drop it or just leave it be.

You mean when running this patchset? It shouldn't, the current 
test uses ksft_wait rather than terminate. The warning is for
test developers trying to use the risky config in new tests.

> I am fine with this warning being added, although I disagree with
> the commit message as mentioned in my previous email.

I'll edit the commit message when applying. Unless you want to dig
deeper and find out why your bash/env is different than mine :(

GNU bash, version 5.2.32(1)-release (x86_64-redhat-linux-gnu)

We know that "some shells" fork, that's the important point.

