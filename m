Return-Path: <netdev+bounces-55907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DACB80CC71
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091D0281AAD
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECEE482CB;
	Mon, 11 Dec 2023 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GYstUn6C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C92D4E;
	Mon, 11 Dec 2023 06:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FTx9In7nzqT/6sQ6DfpiMYwwj1SCTODIoowrPqH3gUg=; b=GYstUn6C+W2RDEwXgu28exhPuU
	bEaCcYWEh/TN85SZsFfNDnCEooKmTGI+fYcL0zFqsJerECTclNYVfpdNE2Jva49W0dDNwvwTsNkNt
	2Dfk4gGSaqecfaNqdtZPbDKr9HOPoiixAHg1WWQhVme1z0gia0NogvJz3xZ08FEMVmmA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rCgqV-002clJ-RW; Mon, 11 Dec 2023 15:01:19 +0100
Date: Mon, 11 Dec 2023 15:01:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com,
	boqun.feng@gmail.com
Subject: Re: [PATCH net-next v10 2/4] rust: net::phy add module_phy_driver
 macro
Message-ID: <d8b9ae9c-f374-458e-aab1-dfd68ae64dd8@lunn.ch>
References: <20231210234924.1453917-1-fujita.tomonori@gmail.com>
 <20231210234924.1453917-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210234924.1453917-3-fujita.tomonori@gmail.com>

On Mon, Dec 11, 2023 at 08:49:22AM +0900, FUJITA Tomonori wrote:
> This macro creates an array of kernel's `struct phy_driver` and
> registers it. This also corresponds to the kernel's
> `MODULE_DEVICE_TABLE` macro, which embeds the information for module
> loading into the module binary file.
> 
> A PHY driver should use this macro.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

