Return-Path: <netdev+bounces-45016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E633E7DA892
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 20:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E248281F06
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95CC17985;
	Sat, 28 Oct 2023 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vZJDHArA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615AFDF59;
	Sat, 28 Oct 2023 18:24:02 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AAFBF;
	Sat, 28 Oct 2023 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DB+7dIEPI+aux6JA1wW01k0XJ2TxAxInSwDCZh9Z/8A=; b=vZJDHArA5GOB9pLFAjM8di4GA0
	tfLTphtzWBOzU2+fSndfsf9+SI2ajXKo1wN9sRRBTMCPbqWJE/1EaAxjUEPDVMXyayDieItN8iyv4
	WoHQ7yJQxV/An43KKl838xZ6m+AtKbTR4XIJAa3yqIFHeswJJH7ZRyeRTfFwLymGGUpM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwnyY-000PpR-KO; Sat, 28 Oct 2023 20:23:58 +0200
Date: Sat, 28 Oct 2023 20:23:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, boqun.feng@gmail.com,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <ZTwWse0COE3w6_US@boqun-archlinux>
 <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
 <20231028.182723.123878459003900402.fujita.tomonori@gmail.com>
 <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me>

On Sat, Oct 28, 2023 at 04:37:53PM +0000, Benno Lossin wrote:
> On 28.10.23 11:27, FUJITA Tomonori wrote:
> > On Fri, 27 Oct 2023 21:19:38 +0000
> > Benno Lossin <benno.lossin@proton.me> wrote:
> >> I did not notice this before, but this means we cannot use the `link`
> >> function from bindgen, since that takes `&self`. We would need a
> >> function that takes `*const Self` instead.
> > 
> > Implementing functions to access to a bitfield looks tricky so we need
> > to add such feature to bindgen or we add getters to the C side?
> 
> Indeed, I just opened an issue [1] on the bindgen repo.
> 
> [1]: https://github.com/rust-lang/rust-bindgen/issues/2674

Please could you help me understand the consequences here. Are you
saying the rust toolchain is fatally broken here, it cannot generate
valid code at the moment? As a result we need to wait for a new
version of bindgen?

	Andrew

