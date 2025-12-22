Return-Path: <netdev+bounces-245721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D97BCD61F5
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 14:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C8443012CB2
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479052DE1E0;
	Mon, 22 Dec 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aSLodgw7"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DC22DCC1F;
	Mon, 22 Dec 2025 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766409579; cv=pass; b=GYAHxGd9feoGdwdF0BRc0F1lqRza5BmX+kiQXY+vzWE6y2eRD/1vD0FzF/EAN3f0NT9L6V1DOJUktNgML/orp+RKCAN6dmv3fqvzjbDxYajYcuO8cZwL8RqsVMwXe3A/J5OsJhbNOZ36TfYB/r6YIT040e5Y3TGAfHNtI4TOEi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766409579; c=relaxed/simple;
	bh=rEKf9AR0cJBECPa1iBnJ/w+YsO8G4tjQY+QjRhBb/io=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=N4b3Najy9fMvGP8Z6qdhbLaiGy82P3R7fUHmUimJLgpZaZhnj9Jg6h+Q7XS+FQNDS925phYE/6AYrOaQA0KqBtZB8EFJJ4B/E3s98vp6XHcfipckeevvS5dkITWg9N7uW3DIi3O1jAYGniZRl1Sm8g834iDUj/Qm3ouPSXBi3/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aSLodgw7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766409541; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ar87KirNmd9hoMJZlsGbuJPTka7iRdnCZ4jcuII4rOhkqE8Vj6LjART2XyKwQ4xR5npUSL4xids4bLoG95ObjPjbfZwKXwDPHkwZAzrgRbrFz9GNncxmWjNoAccfMIl1K5mIIQg8qM484G9XX71YQs79Wft+gj+1VqDDNR2KlkA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766409541; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oJfnIhzSYoRQErDHTI984cPYRPM4JO5Jy6LW8nvc4eM=; 
	b=SZwXpmlHguDgMnTXlwxZWGh8BM+3CYDykpxEMv/Z2b117uHDIaTSbZUO9Y+vPQGK6smIyGZK5WqTDo90rxH6iOvJcCLTcvAsAwt0mj2dze/Jm1b6+WTkK0zdMkwWqSvY/wfz1+d2sUTIk47m9v5UqyFAEBrkFeCZ1mfc1B3m/oo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766409541;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=oJfnIhzSYoRQErDHTI984cPYRPM4JO5Jy6LW8nvc4eM=;
	b=aSLodgw7DQ89QAJO6gTYhH/qoJdOcCRwADesyamB/eQ2okAbh97vTweZlIBbut0q
	SFQ4Q66nihShThRMVMgPR65djcF8u6H92WsiRYeAHllcY9NfY4aHkT5zooOx9Xr5Dd7
	4ocMI6H/g1+STlNNaugYsxOootD/AgwEZ4eaLSxg=
Received: by mx.zohomail.com with SMTPS id 1766409540750877.1476290034648;
	Mon, 22 Dec 2025 05:19:00 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 0/2] rust: net: replace `kernel::c_str!` with C-Strings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com>
Date: Mon, 22 Dec 2025 10:18:43 -0300
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Trevor Gross <tmgross@umich.edu>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Tamir Duberstein <tamird@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: 7bit
Message-Id: <AC5BB42B-B29C-4A4C-9F95-BCDAA72ED0FB@collabora.com>
References: <20251222-cstr-net-v1-0-cd9e30a5467e@gmail.com>
To: Tamir Duberstein <tamird@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Dec 2025, at 09:32, Tamir Duberstein <tamird@kernel.org> wrote:
> 
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Tamir Duberstein (2):
>      rust: net: replace `kernel::c_str!` with C-Strings
>      drivers: net: replace `kernel::c_str!` with C-Strings
> 
> drivers/net/phy/ax88796b_rust.rs | 7 +++----
> drivers/net/phy/qt2025.rs        | 5 ++---
> rust/kernel/net/phy.rs           | 6 ++----
> 3 files changed, 7 insertions(+), 11 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cstr-net-3bfd7b35acc1
> 
> Best regards,
> --  
> Tamir Duberstein <tamird@gmail.com>
> 
> 


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

