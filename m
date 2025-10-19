Return-Path: <netdev+bounces-230763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF46ABEEE6D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 01:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E9E3AA749
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 23:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46E24729C;
	Sun, 19 Oct 2025 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="4nuaGIy/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QhDFAL4k"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8749202976
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760914850; cv=none; b=Zq208squ37Kf7sLsyk2z+i0ntqFgWqUW9NKsE/D3DCUxwb81CIRItSi8rXIbOym4MNp5HmHpvKXEJr/s+gdPCOJGsfGR9oyVOA61mTAbOuHICwuMup1B5X1sOfEebha7KvQ4G44quCv/Mh40TOr+RAYA4IyU1k4yI8C0dAzMtTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760914850; c=relaxed/simple;
	bh=vDSwGwbdYtsn7LQdKYHvWAIvfQA1/egDi0A2fjbkEuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHGXscAfy7HlQ6UEHETQTZwzhY8muvw6eV/aY3Y72VYNepYhBHBK5N1VJAJeJGrXvjfAJqKC7IhVPtuNFZSKkNc1CT/mQaJ5Smnvo40GxzbLsogYZZjSdMAfrphdivX3dCJEYsyU+CGaOF3/kID8Ej49q/UY8LHQdLVDQL4ggNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=4nuaGIy/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QhDFAL4k; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CC16EEC0122;
	Sun, 19 Oct 2025 19:00:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 19 Oct 2025 19:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760914845; x=
	1761001245; bh=29TPynyEp1oN42nw9gedUTkz9DI5eNHDBplK4IjE9YQ=; b=4
	nuaGIy/83sbxawN39TsBQQhjsOiAT+oPtOKIhWWZgkNHdeJZzcg5L95vBbxdNQ1n
	ihWEVwOrWJoDODxvmsFcUyzQO8autsuLbe+D4ze3vRZA+Lh7y78AHg9Yuu1q9X2U
	ibqGZ0Vf7KzDxqj4owsMe+uOKAsNFL1urUSbFS1W40CGh63aNyyufv+5EZpcl5I1
	4jfa7PuQEYj+bu+oc6mX+SE0rVHTq3D3jYa9xE7/wyagVqXs1A3qQ9kJy6++M5qf
	Lz6WjjNRXRSh/hHbN1aJui9/5PY6eiw2XgfqNII5JD7SMStf0yqOeLLI4mcSpXDL
	59SF1mcbazT3snIvExQCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760914845; x=1761001245; bh=29TPynyEp1oN42nw9gedUTkz9DI5eNHDBpl
	K4IjE9YQ=; b=QhDFAL4k5TSJ3JCM6xfHsPVvyQWBLAlmoBbeiYik6aFQq9WL98v
	1/+0OVLJ09WcPXfpLBq4Zw1+qVdEgHlgEILang0wzMAlelqcCeGmXFdoiIMLEDox
	Ia1gVelrenJIrZPtQ8biL1Xl7B/euJvWO4dQTGzjEGjdfnkdERue0hKJ7wLveAw9
	kjKJpecnLc9yKLClWw69QkRDlwVtRz8dzbqYs5JY3k031lh0LB/JFHDmiy5YaYmm
	eSfc4XEn5tv/KF7kH3Pik9NOrFbpFWgh6XjDf1KQqL0bbPNQP8sOoDKpp+Nzxm4M
	ddfSTeZLyvCWgiDlFkkkBj5mmBkwsR2pHUw==
X-ME-Sender: <xms:nG31aHnknRrm674WvE-ajArqsWxiFE6-0swwNyme_rip8i4JVT1D3Q>
    <xme:nG31aMUnrEO3x1G12IkzptbFNjpD8HxX0s0FDzRFWYtgadaJNH30VriqkQmC4k16D
    Y9XjggNKpt17ar9aAK8t106wpwuKtF8pSK3PE3lWxLW4sX-1e0EPg>
X-ME-Received: <xmr:nG31aNupuTBjf8heh7x7k2RO02FZJxJafVaP3EoYiDutFktSpExfOT5yr5hn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeivdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepueejjeeivdejvddtgffgfeelvedvvdfgjeffudfhgefhudekkefhffef
    heduieeunecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhgihhthhhusgdrtghomh
    dpkhgvrhhnvghlrdhorhhgpddtuddrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghf
    fhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohepnhgvth
    guvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohgvqdhksghuihhl
    ugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlkhhpsehinh
    htvghlrdgtohhmpdhrtghpthhtoheprgguohgsrhhihigrnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:nW31aPZtiBE8qkt4xqWUb9j5UtBcMC5whh2X0fyJu79dD_9mP9HY5A>
    <xmx:nW31aMUd4xK-Fnh-vK1kOkpBAhISodgDt5sb52NTdawoZIZxT43BrQ>
    <xmx:nW31aETsf1bkqq3xW7U3s6PxoCHZdwxkgrLLhGtXMt_BXwUYnTFTVQ>
    <xmx:nW31aKMLMNLVGJbp6gA3JUkGqIatisQPFvj75-u3re7ksjJs0x_qfQ>
    <xmx:nW31aOTsDrisoF49dyF6deIW7Oiq9IGIAFpeV7DV2I_CF7QTmaAnyn_V>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 19:00:44 -0400 (EDT)
Date: Mon, 20 Oct 2025 01:00:42 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: steffen.klassert@secunet.com
Cc: netdev@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH ipsec 6/6] xfrm: check all hash buckets for leftover
 states during netns deletion
Message-ID: <aPVtmloGOCQi_7ue@krikkit>
References: <2a743a05bbad7ebdc36c2c86a5fcbb9e99071c7b.1760610268.git.sd@queasysnail.net>
 <202510172159.iLR9bfcc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202510172159.iLR9bfcc-lkp@intel.com>

Hi Steffen,

2025-10-17, 23:10:36 +0800, kernel test robot wrote:
> Hi Sabrina,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on klassert-ipsec-next/master]
> [also build test WARNING on klassert-ipsec/master net/main net-next/main linus/master v6.18-rc1 next-20251016]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sabrina-Dubroca/xfrm-drop-SA-reference-in-xfrm_state_update-if-dir-doesn-t-match/20251016-184507
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
> patch link:    https://lore.kernel.org/r/2a743a05bbad7ebdc36c2c86a5fcbb9e99071c7b.1760610268.git.sd%40queasysnail.net
> patch subject: [PATCH ipsec 6/6] xfrm: check all hash buckets for leftover states during netns deletion
> config: x86_64-randconfig-r123-20251017 (https://download.01.org/0day-ci/archive/20251017/202510172159.iLR9bfcc-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510172159.iLR9bfcc-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510172159.iLR9bfcc-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
[...]
>   3308	void xfrm_state_fini(struct net *net)
>   3309	{
>   3310		unsigned int sz;
>   3311		int i;
>   3312	
>   3313		flush_work(&net->xfrm.state_hash_work);
>   3314		xfrm_state_flush(net, 0, false);
>   3315		flush_work(&xfrm_state_gc_work);
>   3316	
>   3317		WARN_ON(!list_empty(&net->xfrm.state_all));
>   3318	
>   3319		for (i = 0; i <= net->xfrm.state_hmask; i++) {
> > 3320			WARN_ON(!hlist_empty(net->xfrm.state_byseq + i));

So, before my patch there was a sparse waraning on the

	WARN_ON(!hlist_empty(net->xfrm.state_by*));

lines, and now there's a sparse warning on the loop.
(and plenty on other lines in net/xfrm/xfrm_state.c)

This bot message gave me the push to finally take a look at all the
sparse warnings in net/xfrm/xfrm_state.c, I have solutions for a big
chunk of them (and a few in other files).

If you want to drop this patch from the set, I'll re-send it later, on
top of the sparse stuff. The rest of the series works without it. If
you want to take it as is, it doesn't change the sparse situation in
this file (a few warnings moved around) and I'll do the sparse
cleanups on top of it.

Thanks,

-- 
Sabrina

