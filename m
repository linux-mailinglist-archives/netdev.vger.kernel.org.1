Return-Path: <netdev+bounces-83907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CC2894CE7
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9862822D0
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FFA3D0B8;
	Tue,  2 Apr 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjgpnG3t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E03CF74
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044269; cv=none; b=BIhovAFTP33nQuxfgwLCY3iocL1tjzWp3mCIpBYq+fKiQN6VkcL4MmuXE2d7p9p2CGTD+XtN7SeR5w5iuTFSkxcGxgVe/jJkbsnikKqDWin8fGZk4xxtv2eoOMxbTA/QrM8gtGK7z9QSkwmVKGn65NsIdBJwBe83lT3goznHozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044269; c=relaxed/simple;
	bh=PZt8fmx8gOLs4VILhco3ToiwYNJQfxyFdPVTqzkQXWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMgYfw4KzR/J18LdQL9AM5bcEf8hZ9HEIDFemcrb+1pMpCgktPN+eZmdUOhr6NjH2qEocOjtz7PhFgVcOtetxFt1eN7uU/mT2n5XAPY+Svd39kUhHuehmgywHN2Dly511RHbnkMhVwi+/W93BMB0K1H14goRiXYqkMIPF2lP+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjgpnG3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C24C43394;
	Tue,  2 Apr 2024 07:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712044269;
	bh=PZt8fmx8gOLs4VILhco3ToiwYNJQfxyFdPVTqzkQXWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjgpnG3tE+KCQnaj9M73nywhzRmPg6mYPTpMVIhm2RuF44wS54pyyo3I8qVsHVwpv
	 hgwCBVqk1yUDgI1hJpNtPiBj9rIon61slOw50WjhQUrCUggboCvE+WFsRg0x4Bm8Pq
	 QaYD3DAZzIsPZYrHkhdusaXz6KlPRyTQ1WJdlkBqvJKwDIuqsTcdx0hX4k3CpSbn5X
	 D0z6DWvJasQtsD3vDIZsACcFaJ3bEXFWuRPzcvtKE/dCwiItGHZzUBgfbZGE7NuXun
	 zWLDqxdTO/4AEjs35Yqnzzlr4FKidiagvlW+0EBU7fNg4Q71Lr5i1fkBc3mNupxMHv
	 lvke49wxkjErg==
Date: Tue, 2 Apr 2024 10:51:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net
Subject: Re: [PATCH] [PATCH ipsec] xfrm: Store ipsec interface index
Message-ID: <20240402075104.GD11187@unreal>
References: <20240318231328.2086239-1-wangfe@google.com>
 <20240319084235.GA12080@unreal>
 <CADsK2K_65Wytnr5y+5Biw=ebtb-+hO=K7hxhSNJd6X+q9nAieg@mail.gmail.com>
 <ZfpnCIv+8eYd7CpO@gauss3.secunet.de>
 <CADsK2K-WFG2+2NQ08xBq89ty-G-xcoV517Eq5D7kNePcT4z0MQ@mail.gmail.com>
 <20240321093248.GC14887@unreal>
 <CADsK2K8=B=Yv4i6rzNdbuc-C6yc-pw6RSuRvKbsL2qYjsO9seg@mail.gmail.com>
 <20240401142707.GD73174@unreal>
 <CADsK2K-VLdiuxeP82bmuGvmU6z848mLpk+JBYdhXppOq0B76VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADsK2K-VLdiuxeP82bmuGvmU6z848mLpk+JBYdhXppOq0B76VA@mail.gmail.com>

On Mon, Apr 01, 2024 at 11:09:41AM -0700, Feng Wang wrote:
> Thanks Leon for answering my question.  In the above example, if we can
> pass the xfrm interface id to the HW, then HW can distinguish them based on
> it. That's what my patch is trying to do.

From partial grep, it looks like "xfrm interface id" is actually netdevice
index. If this is the case, HW doesn't need to know about it, because
packet offload is performed by specific device and skb_iif will be equal
to that index anyway.

> Would you please take this into consideration? If needed, I can improve my
> patch.

As a standalone patch, it is not correct. If you have a real use case,
please send together with code which uses it.

Thanks

> 
> Thanks,
> 
> Feng
> 
> 
> 
> 
> On Mon, Apr 1, 2024 at 7:27 AM Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Fri, Mar 22, 2024 at 12:14:44PM -0700, Feng Wang wrote:
> > > Hi Leon and Steffen,
> > >
> > > Thanks for providing me with the information. I went through the offload
> > > driver code but I didn't find any solution for my case.  Is there any
> > > existing solution available?  For example, there are 2 IPSec sessions
> > with
> > > the same xfrm_selector results, when trying to encrypt the packet, how to
> > > find out which session this packet belongs to?
> >
> > HW catches packets based on match criteria of source and destination. If
> > source, destination and other match criteria are the same for different
> > sessions, then from HW perspective, it is the same session.
> >
> > Thanks
> >

