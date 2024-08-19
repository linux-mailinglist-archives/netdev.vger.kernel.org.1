Return-Path: <netdev+bounces-119920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE5A957807
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707A81F22ACA
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD611DC46C;
	Mon, 19 Aug 2024 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KvUdsQUz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EAD1DD3BE;
	Mon, 19 Aug 2024 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107590; cv=none; b=uMFVPSHlIxKXvTr0GX57NjdFA7rs1iIgGJ4UBKI5mGedCAXNqMIzo0xVJKk6Kwivob4dWFuOIwfP8eYJz+9zNFuxmFeWsOua4LaoXonSn11hD9AaowM5uTkRzi7FMTjaClekxyATlBIsWpmM5B99WIV/7thyRhtKpI9rdheqINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107590; c=relaxed/simple;
	bh=YeI+c5WvDzru7+/xMcVttNeBu1UXihiWYeaeNU6/BSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMxFbMP5tFWbJX2RBCrS0QG/1IwaG24h9kpuI7mOi1hmozX9Hn/HrAL3DferNuTDOMIIYlQ6JFbwraejRQ+DHAoxxLqd5UfsiNOekBG3vldVegbVbuGQhD3Yn/GSEkcJbr9NR+3Wx3vr9FAG3D4O6BX3CTVUxkkDGmT2UEUaVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KvUdsQUz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XJ9tVL1kIeuNmlrENC1i7J8LwpXeoRweT1+rYLUPcCA=; b=KvUdsQUzt0wVZlvrt068EL1Lz8
	qa0/daRg7uuGCQCPSOPH3UurIoP1R7xgLW1ixTnJu2vsreBx6Irw/iakQgrqm6YSXEo3czbxfqca9
	XIU1WHSx+sGZnzsv0oLJ+lzUnhHBm5WAHKwq9AutYfBNXunH5lAB4H0vlJi8tf0Awfjs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sgB8r-0059zT-Ba; Tue, 20 Aug 2024 00:46:25 +0200
Date: Tue, 20 Aug 2024 00:46:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Trevor Gross <tmgross@umich.edu>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v5 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <5a063eb5-923e-4743-b72e-57f3fbf82107@lunn.ch>
References: <20240819005345.84255-1-fujita.tomonori@gmail.com>
 <20240819005345.84255-7-fujita.tomonori@gmail.com>
 <CALNs47siFZQDE8_N2FyLhCMfszrcX7f5Q=rj8c9dzO9Q=hQsmQ@mail.gmail.com>
 <20240819.121936.1897793847560374944.fujita.tomonori@gmail.com>
 <CALNs47u8=J14twTLGos6MM6fZWSiR5GVVyooLt7mxUyX4XhHcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALNs47u8=J14twTLGos6MM6fZWSiR5GVVyooLt7mxUyX4XhHcQ@mail.gmail.com>

>     //! This driver is based on the vendor driver `qt2025_phy.c` This source
>     //! and firmware can be downloaded on the EN-9320SFP+ support site.
> 
> so anyone reading in the future knows what to look for without relying
> on a link. But I don't know what the policy is here.
 
Ideally, the firmware should be added to linux-firmware. It will then
appear in most distros. That however requires there is a clear license
which allows distribution.

	Andrew

