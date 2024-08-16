Return-Path: <netdev+bounces-119033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8411D953E53
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76121C21EDD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 00:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD9F1FA5;
	Fri, 16 Aug 2024 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gs+aD2FX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACBF64D;
	Fri, 16 Aug 2024 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723768904; cv=none; b=r3LymcIqdzkfRrTGF89gWRxhSm2JPAazRCmGzzcq8whHUgJRTXa8z9nGoR1pBd4Wh0/Q1BOSn1pTl1+dpNVloAhjjC632Ar1flU6fJbayQmDixY8YejPJ9aX8SzyNVs+TRSC0GwFs9Ux1+vOX5OWNMKxAWJSHadGarbPhzCp3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723768904; c=relaxed/simple;
	bh=KX65Xf8GHqA2T2Gw3J/Xs+++WXEDR0ZpA5qpLN9rI44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dne4AkAQvBQVsFvJ/fMzaG9puct7JEedZRPRfmU8571hcwPkvcFRF5M3eYI+GT18jT3BLKiAuDeMYCgMunzmw6GYQb5cxQDQDPA6+veC6CWTLBF3I3TflLNw2m2hetvlIB47DfzfuJVJrroFjOiJ7FJxx39x+Rg48YsT0Ss9EJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gs+aD2FX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yFVbfOah576madugnu0PfK2BUlzCSBl6aVrXXG/CWkM=; b=gs+aD2FXQCiY0Dor3Wt9GQNL3s
	JaZy9okmFnfIwwejAWERZjcl2V4pYnLB8vvPG6vxWlj82Jesub3EG43Iuik3X5SKHHyH6IJ+vr8WK
	EM9c7AMXr/mHaDVlX6DK/F+f8OLv4yTtN341yPmSbfcBKU6D9cE0RcjBAkBV7uCUDCkw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sel2A-004spc-Uj; Fri, 16 Aug 2024 02:41:38 +0200
Date: Fri, 16 Aug 2024 02:41:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v3 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
Message-ID: <321193ce-10ef-4d3e-a2b5-bce5b1290b32@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
 <20240804233835.223460-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804233835.223460-4-fujita.tomonori@gmail.com>

On Mon, Aug 05, 2024 at 08:38:32AM +0900, FUJITA Tomonori wrote:
> Implement AsRef<kernel::device::Device> trait for Device. A PHY driver
> needs a reference to device::Device to call the firmware API.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

