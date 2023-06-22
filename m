Return-Path: <netdev+bounces-13128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4DC73A62A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5FA1C21128
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D221F925;
	Thu, 22 Jun 2023 16:36:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95DE557;
	Thu, 22 Jun 2023 16:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87F3C433C8;
	Thu, 22 Jun 2023 16:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687451809;
	bh=pjzGP8R3SPlmAyHxL8Ci6L9a/VYrrsL3N2kb9NS++3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AH0Vg54iyLm1ss/adA4DhrQGdrGEfvYWoDA2wFK2DHDppXKNoysk5XoG2PlPoibAS
	 sA69c3hiN0f2AyVBphkp7NSM3XWtVxEAuihcBh93+UYoAp+7f29WnKKBH0Mu1lpIJg
	 spe3v1eZWxbNJntqvmykMb+PYDaHP9Fob+q2ZBtidnFfa0KtFO2SGQIM0uFy2/uAiA
	 SebmjtnhWVXthwU5jaoo5ymrz3Lr4IzaFcLtrkx9BFD76PqHyfOeqAWmuyGebo0uiv
	 MFILz2lMvgj7JyKyfHzM3rmaIUsKPYWk8QNwPLLSrNQKcukJCgeFdBcSMuAIyXIX5v
	 s5Kk7+gRBS5Vg==
Date: Thu, 22 Jun 2023 09:36:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Igor Russkikh <irusskikh@marvell.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Simon Horman <simon.horman@corigine.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix
 <trix@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [EXT] Re: [PATCH] net: atlantic: fix ring buffer alignment
Message-ID: <20230622093648.3795e325@kernel.org>
In-Reply-To: <98b9dc2d-9232-d0e0-022e-2e8339b3cb66@marvell.com>
References: <20230616092645.3384103-1-arnd@kernel.org>
	<ZIxfK1MVRL+1wDvq@corigine.com>
	<20230620120038.0d9a261c@kernel.org>
	<98b9dc2d-9232-d0e0-022e-2e8339b3cb66@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jun 2023 07:49:52 +0200 Igor Russkikh wrote:
> > Agreed that the comment is confusing seems to be incorrect post-change.
> > Flags for instance are overlapped with len, is_gso etc. so they can't be
> > a separate 8B at the end.
> > 
> > Igor, please advise how you want to proceed.  
> 
> I do agree better to remove the comment at all - it explains almost nothing.
> 
> Thats not a hardware related structure, so explicit pack is for sure not required.
> 
> Acked-by: Igor Russkikh <irusskikh@marvell.com>

Thanks Igor! 
Arnd, could you respin with the comment removed?

