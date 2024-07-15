Return-Path: <netdev+bounces-111437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A430F930FC1
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 10:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3529DB20A97
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 08:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BAB184134;
	Mon, 15 Jul 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYK4H83V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929A24B5B;
	Mon, 15 Jul 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032165; cv=none; b=UGlPpZ1k8DIBcY5TpGlJR6rz67BCeBfAOMTM7Bo46SyNmOakTZuhgeOBdTLhZ8sSE2NfLBXi10r/mDOH5TQdc7YHwbGlHv/I1PwjrD+SY6mgbQs6R6HZhHjBkpikEQVt7aLUO4Xv2eCtw6WGdN5pD06FxLp9GDjnYFVRtay8bY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032165; c=relaxed/simple;
	bh=cby1TPiBt8ufALYg+O0f93ZA73SqJpUmRjwv/o6jqyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPYiW3wg8nS1Eql1IBnwYd1wKDgnbNkf1KfPhHO0TZIQCN1axKEgfRd6cGSPfP5nFgccR7+JfSTZO31QVswz7Xe8npZcTVePYcxNhGHT5hPnEtF02sCgVO6JUZKDPdwx8qQn0Y/Hdi8TD5KYfOd7bDZCugAj/xH/uquOl5yHKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYK4H83V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065ACC32782;
	Mon, 15 Jul 2024 08:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032164;
	bh=cby1TPiBt8ufALYg+O0f93ZA73SqJpUmRjwv/o6jqyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYK4H83VCuYDSg0kNkH2rT5Ji2MiXnNMKOXvpub1fNnnw7Ox+hMm3vHAUxSj5Vjkm
	 J4fiR0eoI8OIltz3rNmBiCE1Wq95RvLYJ1D+20kBj1SLsJClBKuTmfvdo7YvFqsqS9
	 ThqL9u4yjJbpGdwYWeECbYM5RWjdaAaJFkC3LzxnNzCxQ5GgbtCKOSgkpKN0D//PDA
	 ltt2C4Dm3NDrDc17SUhs/jf9Ib5gRI7PukP+LQApwDWADTo8eL7gdPVRTX+0nu3bKK
	 4DCAlknw1yFVBgxSyimBUR1I+YN/a/jwSenb5CrG3Ji5AUNQBv/TSbRX2QRf2GugTR
	 BuGeDOf2bclaw==
Date: Mon, 15 Jul 2024 09:27:50 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH] llc: Constify struct llc_sap_state_trans
Message-ID: <20240715082750.GC8432@kernel.org>
References: <9d17587639195ee94b74ff06a11ef97d1833ee52.1720973710.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d17587639195ee94b74ff06a11ef97d1833ee52.1720973710.git.christophe.jaillet@wanadoo.fr>

+ Iwashima-san

On Sun, Jul 14, 2024 at 06:15:20PM +0200, Christophe JAILLET wrote:
> 'struct llc_sap_state_trans' are not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>     339	    456	     24	    819	    333	net/llc/llc_s_st.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>     683	    144	      0	    827	    33b	net/llc/llc_s_st.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.

Reviewed-by: Simon Horman <horms@kernel.org>


