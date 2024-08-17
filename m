Return-Path: <netdev+bounces-119435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1C995594F
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 20:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA751C20BC3
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 18:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754CD225A2;
	Sat, 17 Aug 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xWNgSibC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5A440C;
	Sat, 17 Aug 2024 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723920235; cv=none; b=IzovS8vCA/0JiWin8ajbdWOK0Nd5H3YmvaE/m6dEet/3v9GBTKPMwl6jGCtci7eg1e5q+U6sMPC689OoqEfplliVirCccbOgPTvRKaDDgg4Ydw5JtfrttI2g+PjvCBDAfShzfXdBzqDEg2570ojWx4OTHYAOndi5zp+iKT048us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723920235; c=relaxed/simple;
	bh=TLMhnCNzxFvgSXOepq/M/B371LfD1h6QMOnwS74Y5Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WK/QcdsMleCpmrQcPgcISRhtgfbZjZVmzhBGbl9BrqdmdgjXzi88TE534tuYdFUlb7ot0HzTNNkBLp7KmDgAsr576ep8wIgUKSqE5INQ8cpJtARzNmYLL9I1za2BfKcaxa1XCn61zeMs15oGFV/NXiSkZkfE8MCc+1N+kIM1y9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xWNgSibC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AbIYY58M0xzO1lHb5rqK15bcilbMy5FrPL1/w3PskfI=; b=xWNgSibCL/1TfFP/hGPMWiD5bG
	eexhIKd09JQ712zqYFiequ+IUytaSnhpCcqJehQoVMSQlluzQdB1/79KRDvqUACTgaGQ2J6FQpmwX
	wlLtlSAvw+sydMvvaiZcbb2HikAMalmK796q+QyA9DoBNDajk8pR9eG3pH8sQo+3V9JE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sfOP0-0050ea-Qd; Sat, 17 Aug 2024 20:43:50 +0200
Date: Sat, 17 Aug 2024 20:43:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 4/6] rust: net::phy unified read/write API
 for C22 and C45 registers
Message-ID: <4315c9fb-772f-441a-a267-1f51277d5a86@lunn.ch>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
 <20240817051939.77735-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817051939.77735-5-fujita.tomonori@gmail.com>

On Sat, Aug 17, 2024 at 05:19:37AM +0000, FUJITA Tomonori wrote:
> Add the unified read/write API for C22 and C45 registers. The
> abstractions support access to only C22 registers now. Instead of
> adding read/write_c45 methods specifically for C45, a new reg module
> supports the unified API to access C22 and C45 registers with trait,
> by calling an appropriate phylib functions.
> 
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

