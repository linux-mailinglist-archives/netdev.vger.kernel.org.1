Return-Path: <netdev+bounces-79448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD98794AC
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 13:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8F92812AB
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552F58112;
	Tue, 12 Mar 2024 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="spPciKRK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1127711
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710248320; cv=none; b=WdBaY/10kXL7+e0IiQOVJ5eWRj4xKych1EepHouFW0f6qUCLPTrlQhtv2SSJEg2/XeTaNBConqz05/UisviaenIDm5iHWCXqFVXeZ3KfTdxcK5n2woBjis1CqjV8z2vOwabkg1RKlzINffhfxHbRD2M7mFtsMBI4547SDwIokBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710248320; c=relaxed/simple;
	bh=M8z+3ZKQrccTZsT6PKf6jkLxJKx6W7r5XtnE/A/yC9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR5UbiUxijn4EHMutuhOeYmwS1BG5l/+CK2WL4X0J23Vm/1K3uP9VUJzs068C7ncrObyOHds7Cvc3A9HD6OLpZiTId6xe8v9kcXMH/5rseSfM1T5lSmY0D4Au8vmuYzdNZmifGFoAsBQOb9bO5xLheluYNQVhrMIMFLk+mzPFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=spPciKRK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WtqmHXGgHtIZ6DnzZaq7SY2tmaIJKS9HVcEognB7D4M=; b=spPciKRKMvWs1lDnuag5Fq/WUz
	SdfYX303plWtYfOD3VcUQaz6EVTFaEq6ciA30nrYsJFTZfMfu5AQ2iLsul5OIJnpS4q20UmbqsvLT
	fNxH4ud6D6RVf/BhegiA0p19EPARKxHjUKU4kk6JCxwPrD/5Mk6JO/BFykLmEIIF5h/I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rk1io-00A3Ff-NU; Tue, 12 Mar 2024 13:59:10 +0100
Date: Tue, 12 Mar 2024 13:59:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: mahendra <mahendra.sp1812@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: USGV6 test v6LC.2.2.23: Processing Router Advertisement failure
 on version 5.10
Message-ID: <4d156374-c1d9-453a-8a98-30b1c38a2dd2@lunn.ch>
References: <CAF6A85__pPB_K1iuzVSrKXd+AWXkO4NDYBWbeDfGJEphvvuzzQ@mail.gmail.com>
 <ec033a36-c352-43c9-b769-41252ff18521@lunn.ch>
 <CAF6A85_31JO3-9UxYb=AqDW98bVgqhTufN3mUYtgtKuoyWNB2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6A85_31JO3-9UxYb=AqDW98bVgqhTufN3mUYtgtKuoyWNB2A@mail.gmail.com>

On Tue, Mar 12, 2024 at 11:16:02AM +0530, mahendra wrote:
> Hi Andrew, All,
> 
> Update on this:
> We used 6.7.6 and the test case passed. However it failed in the 6.1 version.
> So from our testing, a change between 6.2 and 6.7.6 has fixed the issue.
> Looking at the change log, there are many commits and also related to
> IPv6 and it would be difficult to determine a specific commit that has
> addressed this issue.
> 
> Could someone please help if you know the commit details that might
> have fixed it?

git bisect will help you find the patch which fixed the issue. Once
you know, we can get it back ported to stable kernels.

    Andrew

