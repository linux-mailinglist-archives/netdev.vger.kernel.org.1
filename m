Return-Path: <netdev+bounces-154367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F849FD70A
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 19:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F263A20AB
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A556A1F8ACF;
	Fri, 27 Dec 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgU+s3Ns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805D31F8ACA
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735325063; cv=none; b=YOCi2yYoD5Fai4kBe4L29DBYPi0rPpAqEATjibmRGH0MjD76/gTZa7YEymPq0b6AxAlEfk8kTcsQsBbfiAY402yfJ8+2NTnTW58FmIye1kRMNnK1tGHPkJEr1owlRZhCu9w4Oj+i70HbWDs9ITRF0E+/CrE400kch2f2dsyVmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735325063; c=relaxed/simple;
	bh=GTBQeE9E8LrpnefPV8QcLKPshy5gMwJ1bIcYqPBhZ0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaslZFUbE5evIZ08I+Mp6GTW5wN+SWutBL1HQ6dVr7ISQ4Xsbcby0fznhthhMPdhgzmWu0FiqURtLyzhLloCxMpJVlZIWrhhU5auNLxXMHHnPqaEWZRerfA4z98gQcveV8/tggw3xYkEgYyPNz7ElsnjJ/rqH5zd55Ieqnn7trg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgU+s3Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E852DC4CED0;
	Fri, 27 Dec 2024 18:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735325063;
	bh=GTBQeE9E8LrpnefPV8QcLKPshy5gMwJ1bIcYqPBhZ0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hgU+s3Nst9bL+0JfL6qzyV/hd1tmJcvuRTAh04VhOnT2BhQZk5watjXL2SdsksvGP
	 M38vAHo6P2D318fCrOkSIRJ45GIUk9tAwj/dhBLFNFrP/lG3MTDjiQypb9z0v3QAyc
	 /fQdlYN5ECIuhVR4IEmUPNzAjd1p/MXJmawLISIQWkBcu4Z6+V2N2+DUuECA0A9O4W
	 BUhPJ0Fxozqrsi36trz/XP3EY2hrGAcsdAaRQ6VPaGutfKluW1IJH4JNtjwklMB0E8
	 Tyc8k37RXemBXbtWifjimO//ngL0a3rtZJ339lB2mzRwzyf4fygod8r1GV1WESyF9M
	 XgeFJG0WVU0bg==
Date: Fri, 27 Dec 2024 10:44:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: tianyu2 <tianyu2@kernelsoft.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ipv4: remove useless arg
Message-ID: <20241227104422.5271208d@kernel.org>
In-Reply-To: <49312e2.9f6f.193fcf0ac4d.Coremail.tianyu2@kernelsoft.com>
References: <20241205130454.3226-1-tianyu2@kernelsoft.com>
	<20241207175459.0278112b@kernel.org>
	<2ce18155.9222.193a928231d.Coremail.tianyu2@kernelsoft.com>
	<49312e2.9f6f.193fcf0ac4d.Coremail.tianyu2@kernelsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Dec 2024 16:30:51 +0800 (GMT+08:00) tianyu2 wrote:
> > > As Paolo already pointed out the name portion of the sign off tag
> > > should be the Anglicised(?) form of your name, not the repeat of
> > > your login.
> > > -- 
> > > pw-bot: cr  
> > 
> > Yes, it's fine with that name.  
> Any other problems with this patch?

No other problems but you haven't fixed the problem we pointed out.

