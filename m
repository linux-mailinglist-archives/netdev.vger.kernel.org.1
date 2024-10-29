Return-Path: <netdev+bounces-139932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC449B4B0F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0740DB21D1E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA03204931;
	Tue, 29 Oct 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl8dzTKP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677079F5
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209181; cv=none; b=D6lxxU01KD73VUD9WJmTpBrR+fElmiDOqngGhVjLgFux3zHUvTeSA17+Wt0Aosc212NaPFlhe8CXO8AqsM5UNhyW8HDTcO9EEecaE+eyE9O5mc1zj/64+Ie3RvNehVhfzbfpmMLN5r0sqa9lXkkjGvWZQBaqlbGSu/5lXkHz0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209181; c=relaxed/simple;
	bh=MGyqMtpkm1wE269hy2r7sWu3bo7+Q7Eve5acmdCyWkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U97Bd1cqQ64WzA9kiiz5omtaorftDDyTUdgW8zlAF5ABvEoz82FkIMG5LnS4QZjPa/bxUZONMZYtdrZWJHpqhQw9EA55W/BE8UlZo7UPHBgsjssJ/pYwPzP4JLN2Dy9zcOaglCnzrNzmU21zfkjkxlfim4zy0u8qsSZrxtYSkjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl8dzTKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE254C4CEE3;
	Tue, 29 Oct 2024 13:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730209181;
	bh=MGyqMtpkm1wE269hy2r7sWu3bo7+Q7Eve5acmdCyWkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yl8dzTKPltu8BDiR7dJ/tHA7eMrsuUFW+cFdXJZKjVTLaCms+v7d8ge9Q2sdtaCR9
	 6292okL2acRAzMRQ1KSYnRKVZIPfs8TSQVbRHB9iSrMy2ZYtX9jElQP38V1DLfXFym
	 9Hpl5v7KCYW9U46FKs0AHpWshcjNwb/bPKf9rOz7caLxju5PPoS7Hoar1N7jQW+bVk
	 kZvAxWS+3KHha9aJ51jR/pIWUcesciqc3q4M9o6Zp6z3qUi5njo1zy+/w2VHKcN38G
	 sEmYwjQ6A4MWu4E322jvyc6FSSetbSfjKMCCoR2dW0fSTcRRdfG7yEg5D05YRIG9Nq
	 MsQcD8ffAEWfA==
Date: Tue, 29 Oct 2024 06:39:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Joe Damato <jdamato@fastly.com>, David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: yaml gen NL families support in iproute2?
Message-ID: <20241029063939.244e2c67@kernel.org>
In-Reply-To: <46b77837-2f87-44aa-a6f2-e61919591659@redhat.com>
References: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
	<61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>
	<ZxbAdVsf5UxbZ6Jp@LQ3V64L9R2>
	<42743fe6-476a-4b88-b6f4-930d048472f9@redhat.com>
	<20241028135852.2f224820@kernel.org>
	<46b77837-2f87-44aa-a6f2-e61919591659@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 10:29:15 +0100 Paolo Abeni wrote:
> > That's assuming that by
> > 
> >   so that end-users/admins could consolidated administration/setup 
> >   in a single tool
> > 
> > you mean that you are aiming to create a single tool capable of
> > handling arbitrary specs. > If you want to make the output
> > and input more "pretty" than just attrs in / attrs out -- then
> > indeed building on top of libynl.a makes sense.  
> 
> My understanding is that a similar/consistent command line and man page
> based documentation will preferable for the end-user - say to configure
> ip addresses and configure tx shaping on a given device.

I see. You got me slightly confused with "single tool" as iproute2
itself contains multiple tools. Sounds like you just want to write
a tool / add to ip the ability to talk net shaper nl.

