Return-Path: <netdev+bounces-46879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542247E6E5B
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A111C2086F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C158A210F0;
	Thu,  9 Nov 2023 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Dedj1FOM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qJaNYVEd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9081CF83
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:14:10 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CA03588;
	Thu,  9 Nov 2023 08:14:10 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8AE995C0452;
	Thu,  9 Nov 2023 11:14:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 09 Nov 2023 11:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1699546449; x=1699632849; bh=kPd+scBALwPSSF853kD362qUH
	B1LZ1xYUAJPoV1UhaI=; b=Dedj1FOMixa6lnn5RVYSQ8Kf1xbeURB9ZOzGnvA43
	H9kl9Z/bAM/f+RnBnG2KCcHorhu5E2wkVusAl2HyHAEJl473RpF050Y1BN4/jxL6
	RLYgALwjIvrUIw5xg5sh+HPfCk6KYLmc0Kn8tAnCDNglfGow7cl9EqBhiDJCF9Xw
	L5kmTKHXG6z+k6VpmQL/pd7YsjiXSqOwD13P/slI06csVHUzd3+X71CqRjoUfJM2
	cw9HBnoTiamAjiIncxc2TB9kZCuv4RQpCQ08mtyVh+SehiC3aamHPj89ECJp5JPT
	6mDfZtXJO/7iuhZ15Cq/rSmn/Nld3YfVAuh8tG4afkHCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1699546449; x=1699632849; bh=kPd+scBALwPSSF853kD362qUHB1LZ1xYUAJ
	PoV1UhaI=; b=qJaNYVEdXy2vl+ilHLaqe3R2lluXxBhpOBIUhzvUKYXknKyev++
	EGIilHrj3nc14rOzRPpOLYV6pBbD+WtdATtCri/dnA7pi6NRqyBlVDyyDht4wPUo
	HRSkZ6xRYnJos6luoj8jpDfMwZZGNc0520qK8Tr8RWTNLdreCoSkV/M+mtpbXPEz
	XM0Yg/CBfT3khygQjJbzRLufpiPaGkKtwdnTRlT5qpOPZPIU7uxsZnpVM2uERndK
	1dUURhyJFhjr9wk/rjEq7tDU7HKWGCqins5edsxPsH692ji9yvIyqxu/qrhMht2j
	/tY1pMdIQuOWsBqJ6nrlhVFXj2zMEP/akkQ==
X-ME-Sender: <xms:UQVNZVzZLDWhROJB75YWn374RCyx8kLBZmyKE45Y5fuwJd6uBsoFrA>
    <xme:UQVNZVRQJ2CGm_WlzNd77ekLRwogrndWfnDYN2g8VmwyIJNfKfcKx23mrP1BZ9CHk
    uTReNjaW6fDxM6OOiM>
X-ME-Received: <xmr:UQVNZfUDuR_NQWa-bZhP2ZiHc4dTBXVTrfCNEN_7APaLN31suyayaIA3VxuzwhY1qlQwXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkedttddttdejnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepgfejieekffeffeevudfgtdekvdfhtddtieef
    vedtheeggfejffellefggffgvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:UQVNZXg5FByDJcUIxcSgtAp2HMCS_1rcZhnsIF_HFHTiLPwKVA-zTQ>
    <xmx:UQVNZXAMImd5MVs-dwUDB0-59hTIW27Z1_EQZ2Shzhv-fjPYOgzjQw>
    <xmx:UQVNZQKI0pg3tgOubirYIwAYZL7OM7WkOgh_927HQuoOsG_RLoI-iQ>
    <xmx:UQVNZb3TtGLElCFfdcp7oe5lujTeXao2LKw0NRE4apoSndBbGSJ7ZQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 11:14:08 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
	id B5ECC10A31E; Thu,  9 Nov 2023 19:14:06 +0300 (+03)
Date: Thu, 9 Nov 2023 19:14:06 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao1@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [GIT PULL v2] Networking for 6.7
Message-ID: <20231109161406.lol2mjhr47dhd42q@box.shutemov.name>
References: <20231028011741.2400327-1-kuba@kernel.org>
 <20231031210948.2651866-1-kuba@kernel.org>
 <20231109154934.4saimljtqx625l3v@box.shutemov.name>
 <CAADnVQJnMQaFoWxj165GZ+CwJbVtPQBss80o7zYVQwg5MVij3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJnMQaFoWxj165GZ+CwJbVtPQBss80o7zYVQwg5MVij3g@mail.gmail.com>

On Thu, Nov 09, 2023 at 08:01:39AM -0800, Alexei Starovoitov wrote:
> On Thu, Nov 9, 2023 at 7:49 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Tue, Oct 31, 2023 at 02:09:48PM -0700, Jakub Kicinski wrote:
> > >       bpf: Add support for non-fix-size percpu mem allocation
> >
> > Recent changes in BPF increased per-CPU memory consumption a lot.
> >
> > On virtual machine with 288 CPUs, per-CPU consumtion increased from 111 MB
> > to 969 MB, or 8.7x.
> >
> > I've bisected it to the commit 41a5db8d8161 ("bpf: Add support for
> > non-fix-size percpu mem allocation"), which part of the pull request.
> 
> Hmm. This is unexpected. Thank you for reporting.
> 
> How did you measure this 111 MB vs 969 MB ?
> Pls share the steps to reproduce.

Boot VMM with 288 (qemu-system-x86_64 -smp 288) and check Percpu: field of
/proc/meminfo.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

