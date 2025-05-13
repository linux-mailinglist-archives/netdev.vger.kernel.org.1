Return-Path: <netdev+bounces-190254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB48AB5DED
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547D93A778D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5451F4180;
	Tue, 13 May 2025 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z4cVA8sz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BF81BD035
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747168932; cv=none; b=Wgf8o9zvOcyUnBQeKzP8xRGojWZYpL28xNyVsa5jbCBK80ga5vi+lGllb97wCWTemeLoYmioL0iw0PbujLVoyvZYSGk04SjXa6Z1r3PxBgsn8Tm+BMeLuav2uoaBMmGVZYu6JvNUhABU/RBgSPFmZm0tTbhVvzbhIPW0XTMy5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747168932; c=relaxed/simple;
	bh=wftshGu/RJmOp+i0fiW0y3cX1/f64a4Anoj5lZRKWI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAMDSzqtS+lVt8+BRfMJMYQV1+XqfyMzcaV6SnMRiRLGD5igTKeHJbdqrpWkDCq3o8U8xNBaK+WLOeJuLk3CXLv3iGiI5Rz6Hm+0ETvNEVh4mn+AJq5X6V6Qr+g32yvhXahFAJpci4IOojLm1Pkl/r75/CBg3NAuEiRBvZN9Fcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z4cVA8sz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SfluA/HEPvkA0pwhBCrRLHuQb5zXIG27uwoSvNecAN8=; b=z4cVA8szeIn1w0pJDAOBIthp9t
	hj3HYcWdAz5eBWNVNcuYESHb2vfFwpqRpjiRGDOOJthKKbAGL7tqLWSb3dmlHTx5uNJuJ2O14O3vw
	qXXkYswsjkB2QJlOk3tp+beWtWrJ5ziGbrJ/Mhe428NJVU0H6sGSrVRn1c9zOk0c7SRU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEvxk-00CUtj-PQ; Tue, 13 May 2025 22:10:52 +0200
Date: Tue, 13 May 2025 22:10:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] netlink: add NULL check for get_string() in features.c
Message-ID: <aa6f1788-9e1c-47f2-860c-3527187bcce2@lunn.ch>
References: <20250513200128.522-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513200128.522-1-ant.v.moryakov@gmail.com>

On Tue, May 13, 2025 at 11:01:28PM +0300, Anton Moryakov wrote:
> Report of the static analyzer:
> Return value of a function 'get_string' is dereferenced at features.c:279
> without checking for NULL, but it is usually checked for this function (6/7).

It is a good idea to include the Maintainer in To: otherwise the patch
might get lost.

	Andrew

