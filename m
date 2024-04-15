Return-Path: <netdev+bounces-87980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8388A519B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178241C2270C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC374BF4;
	Mon, 15 Apr 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gsQYRiTO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3B274C19;
	Mon, 15 Apr 2024 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187822; cv=none; b=cl5ep9yV4ZJTU4Vv/n7ATYPdGa+Fc5JKVhHPYcnqOrMojhBUTPurzD8Zy8CmCBZCuehBNJ0w/UlWakMD6ykhIoljyhdSMxReaQY6E07sfqJ6PyY4lmyGv5Xwh3diCnDtI6nU+RH2167g0oJurdT+crnQfW85wk16eBuE9A3jXvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187822; c=relaxed/simple;
	bh=VLN7U2MWXkfek+C+HetpHRqueVgKzdk7GVGfNILmQKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVgQtkGRUuD4+nH869drGqXKWfm9Ezekeh7Ie3qquvx5m0WiXP/Fkizh0OViy55KGcTDLo2MGeWYx9DOGuBNZKTIIptGnRgvQkK2gb8UlKQpDoQVLUzeg2RzQxemsEYjlZWpZlshVSGUfAQVVijXiEYxttdBxxSSJTHDIYpomMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gsQYRiTO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L1ekA2H1TmIH/kCPYXXx1HrbqYaNja5ekOaa2gNDg/o=; b=gsQYRiTOvcIs5Hso82D6qn3ABi
	iskB3fzR2M7HQUdi+sgGpFhxBWQ+MtmD/nfYnndRds+kqRhoNF8fVAHfk+kizmnOBwQZt3O6ogKaq
	KXqfMDnFilxpaTAIL6rz1vyviTV1Xwq3PFFYTMaMaAb6m6G3qp8EaUfOXWP6xvGCmKMc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwMPY-00D2eo-6x; Mon, 15 Apr 2024 15:30:16 +0200
Date: Mon, 15 Apr 2024 15:30:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>
Subject: Re: [PATCH net-next v1 3/4] rust: net::phy support Firmware API
Message-ID: <d5713492-73e9-460e-a2df-8d72991d0b8b@lunn.ch>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104701.4772-4-fujita.tomonori@gmail.com>

On Mon, Apr 15, 2024 at 07:47:00PM +0900, FUJITA Tomonori wrote:
> This patch adds support to the following basic Firmware API:
> 
> - request_firmware
> - release_firmware

I fully agree with GregKH here. You should be writing a generic Rust
abstraction around firmware loading any Linux driver can use. There
should not be anything PHY specific in it.

	Andrew

