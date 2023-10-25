Return-Path: <netdev+bounces-44309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F67D786C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8FD281723
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA1937153;
	Wed, 25 Oct 2023 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgmEMd1L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858B266BC
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9C7C433C7;
	Wed, 25 Oct 2023 23:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698275654;
	bh=YuzQLvRrbzw4UDQnxTXrR95omgySHjSLxXR6bZ+EjBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XgmEMd1LKs6FSYauABooUgMOuTzbaOyZwDVMi6Q/JdisBlZqK3SLINK/gPNwqq+RU
	 cm3jfn54HnLa0V3CLd52xDc8ud03OQrg31a8wjWm+Y5DgvxngrmRl8Wd2XyriVJVJ7
	 k7IhioX0WVKSnRxt+cAZ8uIUzfc7Nqxtm9i4FXpsVNwjO4YC200ZucP7PL0r3K/Ozr
	 HoDTIiaIZwRKhb62+79qo5mAOJE+6TptH4c/u2k1RwZRNItYoas306LtP0MJzCb7Re
	 YBeGu42CHAUNRzmtwbnqHTRJsfHuhwx79QNQwfdpD6ryaYoRJ02p1aky472kobM6q3
	 2r0gPE/APMAog==
Date: Wed, 25 Oct 2023 16:14:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Willem de Bruijn <willemb@google.com>,
 syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com
Subject: Re: [PATCH net] llc: verify mac len before reading mac header
Message-ID: <20231025161412.340d9737@kernel.org>
In-Reply-To: <CAF=yD-JV031xfCDwb_=GG-i8+CR3OnQMCMTsMvWU0vwDtByB=w@mail.gmail.com>
References: <20231024194958.3522281-1-willemdebruijn.kernel@gmail.com>
	<20231025160119.13d0a8c2@kernel.org>
	<CAF=yD-JV031xfCDwb_=GG-i8+CR3OnQMCMTsMvWU0vwDtByB=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 19:05:59 -0400 Willem de Bruijn wrote:
> > I think this one may want 1 to indicate error, technically. No?  
> 
> Absolutely, thanks. For both tests.

Both state machine callbacks (functions with names ending with 'test_r'
in the patch), right? Perhaps 'goto out' is what's expected here.  

The fixup function seems to have inverse return semantics, because 
why not.

