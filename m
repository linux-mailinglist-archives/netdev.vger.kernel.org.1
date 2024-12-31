Return-Path: <netdev+bounces-154638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD1A9FF046
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 16:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A036A161B89
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801736F30F;
	Tue, 31 Dec 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="emsUG/Yf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A116426
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735659651; cv=none; b=I9YDW470t69f3PFnQTH0N+0t+uunhAZ20G/izwqoS7tGqCv9EE2sbp0FPSX3eFG6/3AbrUnVahj2leloyyds+suu9BnZh0o7bm+ABCfU/nsXkZR1s3dg26mkBCfCj5i9bGoPhaFbBySqww5AcghU4A8DkVBBtEgdVT4ENwf+KFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735659651; c=relaxed/simple;
	bh=a7Cg+T110u09zW5ieKwBWvrFJywQ3Iru6wcPS3DpBKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5eYtxD9FBJBb50+WjMcTH9B0IVeWB2PHAuF00zmVNJdXcGgcXsM5UmM0Gnc/GbowSbLJO2UecFoJkVtP8qDssf5di7y/zrElEtDJFkAqxzJQBMJI/sruxUKd/dcORV13lVCNfEAbXkKKjMkMk0AVzTFA8VHO0mTBMDtg8qkF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=emsUG/Yf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=3lk6FQ1TeFq3azjhvr9i7HbJAysBwmIauZ2Vy/DkseI=; b=em
	sUG/YfTeg55D3aRpT2CrUc9axx3AjhQKOt7dLU1K3SuLmP+n7nwZ1EIuvwb5J/ed/ftVLUTH5Csew
	i5hDZl3vE9O6UvUOlElc4YhqpW/FQZ+woejYuIuO0IAuP4oQvZph7YeBkxz2ggqP12Ak48/F/dSgd
	+DfvXF38N6gyAQs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tSeMG-000FgZ-UF; Tue, 31 Dec 2024 16:40:36 +0100
Date: Tue, 31 Dec 2024 16:40:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: tianx <tianx@yunsilicon.com>
Cc: weihonggang <weihg@yunsilicon.com>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	wanry@yunsilicon.com
Subject: Re: [PATCH v2 08/14] net-next/yunsilicon: Add ethernet interface
Message-ID: <c2df7bd7-ae7f-4080-a4e3-aacdfb5d86c2@lunn.ch>
References: <20241230101513.3836531-1-tianx@yunsilicon.com>
 <20241230101528.3836531-9-tianx@yunsilicon.com>
 <9409fd96-6266-4d8a-b8e9-cc274777cd2c@lunn.ch>
 <98a2deaf-5403-4f85-a353-00bfe12f5b13@yunsilicon.com>
 <45dfc294-76d8-4482-b857-4e3093ac829d@lunn.ch>
 <a09b9cda-5961-452b-84cb-844262e5b71a@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a09b9cda-5961-452b-84cb-844262e5b71a@yunsilicon.com>

On Tue, Dec 31, 2024 at 05:40:15PM +0800, tianx wrote:
> On 2024/12/31 13:12, Andrew Lunn wrote:
> > On Tue, Dec 31, 2024 at 12:13:23AM +0800, weihonggang wrote:
> >> Andrew, In another module(xsc_pci), we check xdev_netdev is NULL or not
> >> to see whether network module(xsc_eth) is loaded. we do not care about
> >> the real type,and we do not want to include the related header files in
> >> other modules. so we use the void type.
> > Please don't top post.
> >
> > If all you care about is if the module is loaded, turn it into a bool,
> > and set it true.
> >
> > 	Andrew
> 
>   Hi, Andrew
> 
> Not only the PCI module, but our later RDMA module also needs the netdev 
> structure in xsc_core_device to access network information. To simplify 
> the review, we haven't submitted the RDMA module, but keeping the netdev 
> helps avoid repeated changes when submitting later.

So you might be rewriting this all in order to get the RDMA code
merged.... But if not, just drop the void * cast. Make xdev_netdev a
struct net_device *, etc.

	Andrew

