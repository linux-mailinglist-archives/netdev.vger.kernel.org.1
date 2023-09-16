Return-Path: <netdev+bounces-34280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756E57A2FB1
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 13:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235C7281B68
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E2134DB;
	Sat, 16 Sep 2023 11:30:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6871107
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 11:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846A0C433C8;
	Sat, 16 Sep 2023 11:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1694863835;
	bh=tb+xo4fSb2SK2auJNGK/z1wJlI5Gm2K/RpR33D1BATs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGQMC0Ox58Vgmg3+ioBFg0bugTtas2Yo/HziA7VXJv7+Y7RDAHLkW774S3K9c6Ka1
	 AmxjLqDPpbVDYVI6XMoKBTzszdjmnfFb4SOQ3pG9enVCSOSU4Cpvd5DawMRkGzMUND
	 /qYJJv9ygWxEkNv17GiewZFDdsBKRS0rBIbfzF3w=
Date: Sat, 16 Sep 2023 13:30:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ajay Kaher <akaher@vmware.com>
Cc: stable@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, alexanderduyck@fb.com,
	soheil@google.com, netdev@vger.kernel.org, namit@vmware.com,
	amakhalov@vmware.com, vsirnapalli@vmware.com,
	er.ajay.kaher@gmail.com
Subject: Re: [PATCH 0/4 v6.1.y] net: fix roundup issue in kmalloc_reserve()
Message-ID: <2023091600-activate-moody-bd24@gregkh>
References: <1694802065-1821-1-git-send-email-akaher@vmware.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694802065-1821-1-git-send-email-akaher@vmware.com>

On Fri, Sep 15, 2023 at 11:51:01PM +0530, Ajay Kaher wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> This patch series is to backport upstream commit:
> 915d975b2ffa: net: deal with integer overflows in kmalloc_reserve()
> 
> patch 1-3/4 backport requires to apply patch 4/4 to fix roundup issue
> in kmalloc_reserve()

Thanks so much for these backports.  I attempted it but couldn't figure
it out myself.

all now queued up,

greg k-h

