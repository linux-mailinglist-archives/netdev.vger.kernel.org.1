Return-Path: <netdev+bounces-84281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CBB8964BE
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFBD283F69
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141AF548EF;
	Wed,  3 Apr 2024 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGbow7D4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478814006
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712126712; cv=none; b=LF0SHGr4olNJqgNvgY4eMVEBKw4l1bDvalvO5d8yWyp20rglhnsS5imID0cWYkHPBPEHCkymF/WR1Tmaa5XhaY9rYfpm6hFLiDdW108gqJZMu1O9UZS1L1z+ORUqWQmaJDga6WxIKvrS1tPm3RrVbZcAJWuTRu08P/FqsRXQYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712126712; c=relaxed/simple;
	bh=RKdr1dRu6XCngGwnksuzbKI1GZT505nAjljMuv0EuKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSzUHES2MowH97ZNvnSeZsymuCQFWC7gmAWqbfz5owb4GDtBZCH1iiZCipo7AMDagURkkYPcfSPDBqZxvpevVlxrb1xR0t+8GASmYxu/ySgzcudgziBvY0D3X0f0lgG0qtOAyWELY1hcYvSlewFqM/q4pJiKnxTEAmECldoRwGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGbow7D4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2426C433C7;
	Wed,  3 Apr 2024 06:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712126711;
	bh=RKdr1dRu6XCngGwnksuzbKI1GZT505nAjljMuv0EuKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGbow7D4oneOBpx31BHgtPPJKtwGWmFcaLlkzjSQRecfs7UM716elbUsW6i9YzSTz
	 AmYfHsu/SG8mahq9QEorMsBO9TXeNN43kXor0ng3nwYqYXrRWMTLHlklh8LlJLXmdd
	 jMmX72IHNooyJ6XaXq70j7BD6KjPEXUiv4hmnvVHJztSOPt6tzOeGcWammNYGlmDY3
	 4Brccz+MO0rxxCOThJ7EEaFgObzhmoAiCqSKpprrG9LLLCU5N3Qs2J7q5BO687kPkn
	 f6gz3BBnAeoUhL/u/SihLVPay1AuMFbiG6mziJRpocb9rQElChMY7FN/na4jNv7I72
	 XVGkNom5w3wdg==
Date: Wed, 3 Apr 2024 09:45:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net
Subject: Re: [PATCH] [PATCH ipsec] xfrm: Store ipsec interface index
Message-ID: <20240403064507.GR11187@unreal>
References: <20240319084235.GA12080@unreal>
 <CADsK2K_65Wytnr5y+5Biw=ebtb-+hO=K7hxhSNJd6X+q9nAieg@mail.gmail.com>
 <ZfpnCIv+8eYd7CpO@gauss3.secunet.de>
 <CADsK2K-WFG2+2NQ08xBq89ty-G-xcoV517Eq5D7kNePcT4z0MQ@mail.gmail.com>
 <20240321093248.GC14887@unreal>
 <CADsK2K8=B=Yv4i6rzNdbuc-C6yc-pw6RSuRvKbsL2qYjsO9seg@mail.gmail.com>
 <20240401142707.GD73174@unreal>
 <CADsK2K-VLdiuxeP82bmuGvmU6z848mLpk+JBYdhXppOq0B76VA@mail.gmail.com>
 <20240402075104.GD11187@unreal>
 <CADsK2K8WvGmUdno5X=_ebNF1mzP9=kd1=ve31Tb5hSk+q4VTkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADsK2K8WvGmUdno5X=_ebNF1mzP9=kd1=ve31Tb5hSk+q4VTkg@mail.gmail.com>

On Tue, Apr 02, 2024 at 02:10:16PM -0700, Feng Wang wrote:
> The xfrm interface ID is the index of the ipsec device, for example,
> ipsec11, ipsec12.  One ipsec application(VPN) might create an ipsec11
> interface and send the data through this interface.
> Another application(Wifi calling) might create an ipsec12 interface and
> send its data through ipsec12.  Both packets are routed through the kernel
> to the one device driver(wifi).  When the device driver receives the
> packet, it needs to find the correct application parameters to encrypt the
> packet.  So if the skb_iif is marked by the kernel with ipsec11 or
> ipsec12,  device driver can use this information to find the corresponding
> parameter.  I hope I explain my user case clearly.  If there is any
> misunderstanding, please let me know.  I try my best to make it clear.

Like I said before, please send the code which uses this feature. Right
now, packet offload doesn't need this feature.

Thanks

> 
> Thanks Leon.
> Feng
> 
> 
> On Tue, Apr 2, 2024 at 12:51 AM Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Mon, Apr 01, 2024 at 11:09:41AM -0700, Feng Wang wrote:
> > > Thanks Leon for answering my question.  In the above example, if we can
> > > pass the xfrm interface id to the HW, then HW can distinguish them based
> > on
> > > it. That's what my patch is trying to do.
> >
> > From partial grep, it looks like "xfrm interface id" is actually netdevice
> > index. If this is the case, HW doesn't need to know about it, because
> > packet offload is performed by specific device and skb_iif will be equal
> > to that index anyway.
> >
> > > Would you please take this into consideration? If needed, I can improve
> > my
> > > patch.
> >
> > As a standalone patch, it is not correct. If you have a real use case,
> > please send together with code which uses it.
> >
> > Thanks
> >
> > >
> > > Thanks,
> > >
> > > Feng
> > >
> > >
> > >
> > >
> > > On Mon, Apr 1, 2024 at 7:27 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > > On Fri, Mar 22, 2024 at 12:14:44PM -0700, Feng Wang wrote:
> > > > > Hi Leon and Steffen,
> > > > >
> > > > > Thanks for providing me with the information. I went through the
> > offload
> > > > > driver code but I didn't find any solution for my case.  Is there any
> > > > > existing solution available?  For example, there are 2 IPSec sessions
> > > > with
> > > > > the same xfrm_selector results, when trying to encrypt the packet,
> > how to
> > > > > find out which session this packet belongs to?
> > > >
> > > > HW catches packets based on match criteria of source and destination.
> > If
> > > > source, destination and other match criteria are the same for different
> > > > sessions, then from HW perspective, it is the same session.
> > > >
> > > > Thanks
> > > >
> >

