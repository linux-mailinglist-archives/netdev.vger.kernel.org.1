Return-Path: <netdev+bounces-240744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAEEC78E6D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D92694EA4C7
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5219D2EBBB7;
	Fri, 21 Nov 2025 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGb/YNf3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5C2882AA;
	Fri, 21 Nov 2025 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763725659; cv=none; b=eXDDoH577/PUvmv1fK4hkMfcjRcrkWp3hX2+yBBd0+ubUjtzV1IAR1+l9GT2Qt0zRJOBFCUtipHI8tKShSINNxGmc4YiLFXCecNHGK693BTNaz7YwjOkgARzuDu4G4qn226jD5O8/VNLGzgnKt8NBKIZudUjeWldCfEqDCpFPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763725659; c=relaxed/simple;
	bh=jriqeiIS1aR47ALhSwW4HrK/NHqJoj1Qhnwo1tEKLG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCk+mLnyUHpPPu8QpDccDpwyQLxjz4Lz4FGxrQkuMuc8EfJ53Pum57nNh2SOTqiIhC43u/HeRgHji2NihYAL/hbf1Fd+0of0yXZImJZgD5VrVs5qL/lw2WTsvCSaAl4rtbIEawaE2CStVjPVSTurPEbvNGQB3zWdsbLMEs01rjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGb/YNf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9564EC4CEF1;
	Fri, 21 Nov 2025 11:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763725658;
	bh=jriqeiIS1aR47ALhSwW4HrK/NHqJoj1Qhnwo1tEKLG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGb/YNf3n6BdIxur3EiArDGsETVo0r8DDrACfQb87luLiKtOUWAJD+BQiD+LiVO+F
	 KisM1arlM+xreFvSvGZGooxo+X13/wUEcm8ByQ/96OR15O84Ha6oHNCeRqEEvvLA/y
	 aJ9wdjjoIGp3ZO7oqYGM40Qhs0Mx9bWGfDUgTvbL+7LAqRBfogdhrry9n8x8udj1Uh
	 euCLSXlCwG2f+45G6FzpVSWHDpvchRvJmGYUz8PbFQ+ygtuiKXkcv9puM7W5Abzh/k
	 s4nZE+libZ+FRil6J1BIQ6TU3w9Jg1BqbMRqRZMCiFWL6SbaR6qIh3xWGkO9aBaWmP
	 LvHck8HGhLH6A==
Date: Fri, 21 Nov 2025 11:47:34 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: act_ife: convert comma to semicolon
Message-ID: <aSBRVrb0ic5h9DEZ@horms.kernel.org>
References: <20251112072709.73755-1-nichen@iscas.ac.cn>
 <CAM0EoMnQqNwkdUec0tX4cznZk8teiPRx9iBv5Ff-MeSDASj-zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnQqNwkdUec0tX4cznZk8teiPRx9iBv5Ff-MeSDASj-zQ@mail.gmail.com>

On Wed, Nov 12, 2025 at 05:50:36AM -0500, Jamal Hadi Salim wrote:
> On Wed, Nov 12, 2025 at 2:28 AM Chen Ni <nichen@iscas.ac.cn> wrote:
> >
> > Replace comma between expressions with semicolons.
> >
> > Using a ',' in place of a ';' can have unintended side effects.
> > Although that is not the case here, it is seems best to use ';'
> > unless ',' is intended.
> >
> 
> IIRC, Simon brought this up in the review as well...

Yes, I might have.
But at any rate I agree with the analysis above.

> 
> > Found by inspection.
> > No functional change intended.
> > Compile tested only.
> >
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> 
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

...

