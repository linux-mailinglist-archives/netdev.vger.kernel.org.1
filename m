Return-Path: <netdev+bounces-96378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498558C5824
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F9A1F232E5
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70361586C6;
	Tue, 14 May 2024 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1Uq+In2C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05418144D01
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697608; cv=none; b=EG9C9T6fzex12dlDFqUnpCzoF53K1/ala0kK1NN3HoWaA+PaF7lwhxxRhDcKQZ6F2dsxC51Wyir1JTO2cEwwTjdskLgjezdqZqtA4Myh/A1Xs+X5ifFgDplSLouKR5dLljVTJ+GaXkDpBWFApeIKwzH6bmnaYFbUZxJoAosX7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697608; c=relaxed/simple;
	bh=34412/uB/5KGZUNEIEUPCf8vNT0T1Q2LJb9Ukub2WJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJPU5KLdPWJr4GIF/RkTVBqE1YViOYiemXRzqPByH+y70wfcWCT0OnZJs6VY0FWq4d9YRaDnd31IgqA2vz7MvpUrcFq64BnvCmzv+Fln3oYTAK2IyMPk6DvtGyLTFn6og2z810FYlkUFxfgkHG1gqFMACrVnO1tiCjbVfE0Zwtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1Uq+In2C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=7h/y1gRYtuUpIVYM/KFLxBK1msBAYCpV20ArwysoWsI=; b=1U
	q+In2CuSPufR9Y6BO4qz6+nTzLo/mmRTL7IsqeF7/AgYQg8UaiNeTHVVgqDDNhnULaXw4AJkd0Gw3
	5xczU2PzPzmPQr4TsMvBUpx479juoqxBItPAYDjZgtMM7wJ+I1H2+ZbZJQ/Xrq370AjATDhCeH3nS
	r7f2k/UfYdMTvaA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6tK0-00FOTn-Ja; Tue, 14 May 2024 16:40:04 +0200
Date: Tue, 14 May 2024 16:40:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: William <wtrelawny@proton.me>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: How to submit pull request to ip(8) manpage
Message-ID: <da56268c-f74c-41d6-b396-893e57267fc8@lunn.ch>
References: <lcAJXzyuvgWzFPAZ0cW9Y2z21zgYiYVSLXj4i9u-i6dXP47oMmbDDrMlVfT47GltBXynLRXZk-3rMZ4eS37WCgPIQrEF1J4NwqnvgEfZ-ik=@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lcAJXzyuvgWzFPAZ0cW9Y2z21zgYiYVSLXj4i9u-i6dXP47oMmbDDrMlVfT47GltBXynLRXZk-3rMZ4eS37WCgPIQrEF1J4NwqnvgEfZ-ik=@proton.me>

On Tue, May 14, 2024 at 01:45:15PM +0000, William wrote:

> Hello, I would like to submit a pull request for clarifications on
> the manpage for the `ip` command, but I cannot find a way to do
> this. Can you please direct me to the git repo containing the
> manpage so I can fork it?

You can clone git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

then email patches to this list. See:

https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/README.devel

	Andrew

