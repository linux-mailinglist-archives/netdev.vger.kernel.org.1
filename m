Return-Path: <netdev+bounces-138690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5D39AE8FA
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BC1B23E33
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69E51E885C;
	Thu, 24 Oct 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K4L9UbyD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D351C1758
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780143; cv=none; b=iqrJ5KS1N7yJR7+kMize4HXWI8bFkvHRXBX2ji5Fg2B+8tbPEEpco7ZR+Y10ZpL0RpN+E4SkpFcq719+YaE9uOAgHi8G2KfzyPC9kka6+tSiLcCfu4wczzx4hJYI1XTRZcPlUrHfjCJCHrTKUtV4WvEFnLgPEf9sTywtrA8YM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780143; c=relaxed/simple;
	bh=kRraXyj/zyX9iVRQN6BJ5akwylfCpcykyXLVnXChja0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGv9gUl0ti1eMjBr/I0ntggT8HeqW7N4Et+1JPoXKIkA40kbropdTdq63bs+UHS2rQwv+xB79b8GmnzbYfoRD3eF54xwXH6P4DwrWPvm8tolac+5sMJFYqydTceegP1Xwo7513qwR+A05de0W0jESB7pwuWLtbgRSZnAFdVLWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K4L9UbyD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iyASL9wC/+oQqYvgQ1e8uhrRGAJR2Ozc7c2LpIQboPk=; b=K4L9UbyDBzwpJNPImMmNBLfK+o
	JH7ijPY7kt1ojixDUmZIXPdcbfayXnTskugFgNYoqbGhLCbE99LEWkHgUiOIoyIGapbbgYiSJS1c2
	IXsr8sTiVXLPJSGOFN8jq+6xWWJJG00Cfgb7M2TZ6BhaJKJAw3v219NDq2zyOk/0JNHI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3ypg-00B8O5-0r; Thu, 24 Oct 2024 16:29:00 +0200
Date: Thu, 24 Oct 2024 16:29:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: query on VLAN with linux DSA ports
Message-ID: <630f1b99-fcf6-4097-888c-3e982c9ab8d0@lunn.ch>
References: <CAEFUPH2npsz4XKna0KYjOeU_MfYN-bVTw25jn6m2dS+f32RuxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEFUPH2npsz4XKna0KYjOeU_MfYN-bVTw25jn6m2dS+f32RuxQ@mail.gmail.com>

On Thu, Oct 24, 2024 at 07:14:28AM -0700, SIMON BABY wrote:
> Hello Team,
> 
> Can I know what is the best way of  implementing VLAN on linux DSA user ports ?

Ignore the fact these are ports on a switch. How would you do this if
for any sort of linux interface?

	Andrew

