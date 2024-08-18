Return-Path: <netdev+bounces-119479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06C3955D35
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF031C208FE
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E384071B3A;
	Sun, 18 Aug 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GC+d0YTF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF74C8E;
	Sun, 18 Aug 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723995488; cv=none; b=WqEXLJPsnRA1vX5qakqOe+fBMxPsZdZg7lXDiRCiXWl74ktgXLCe1ozPeQO0PpQP17orU62QG2E1iCUqcOBC2nMpxvfkhNUBJ38UnV0RripVdACP+Ot6S43Ii4f4kJelTXhMiiEk0sk7Ex0eiw39+11O1wiVjU6taZum8bjYn44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723995488; c=relaxed/simple;
	bh=rDBQpwuO6bjhFq4wfue+ifGsC+h2+pAxROTWcdKsADI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdpATkDkuqGGMdp+Acx2lhDOv257qFrHhmjQA4WzqmlLqY+z2bCQmxQueRmZATPT7XttTFTmb5ATFU1XZnpE3E9Uaky/zHppmh2dnx8gyWDLyY9Xf4YGiDDeF0DxSJKFX3aT2zD5tubM/ei5soZ5InXeTW/rvB1xfQvfe89U7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GC+d0YTF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+VrEIYLY0/b0iX4tFAE0puVZXs13Yf+4rnJxOQhlDWQ=; b=GC+d0YTFZUjG20h4gf3WHM+OPi
	+OHRfdNE9gCpi53uXEW3ZineHvd/gO9Sly4fasnczWYKONuP4DSBBJmZAHl0LlELBOi2YMxtUTDrc
	tHsa1ERybEyMhsaSHulyUXVJ44e5AaOH49Va7kYxaOhrwuoTgNsfYEPdk9/wq7hDtjdc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sfhyj-0052Zk-Eu; Sun, 18 Aug 2024 17:38:01 +0200
Date: Sun, 18 Aug 2024 17:38:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 3/6] rust: net::phy implement
 AsRef<kernel::device::Device> trait
Message-ID: <1afb6d69-f850-455f-97e2-361d490a2637@lunn.ch>
References: <a8284afb-d01f-47c7-835f-49097708a53e@proton.me>
 <20240818.021341.1481957326827323675.fujita.tomonori@gmail.com>
 <9127c46d-688c-41ea-8f6c-2ca6bdcdd2cd@proton.me>
 <20240818.073603.398833722324231598.fujita.tomonori@gmail.com>
 <f480eb03-78f5-497e-a71d-57ba4f596153@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f480eb03-78f5-497e-a71d-57ba4f596153@proton.me>

> Just to be sure: the `phydev.mdio.dev` struct is refcounted and
> incrementing the refcount is fine, right?

There is nothing special here. PHY devices are just normal Linux
devices. The device core is responsible for calling .probe() and
.remove() on a device, and these should be the first and last
operation on a device. The device core provides refcounting of the
struct device, so it should always be valid.

So i have to wounder if you are solving this at the correct
level. This should be generic to any device, so the Rust concept of a
device should be stating these guarantees, not each specific type of
device.

	Andrew

