Return-Path: <netdev+bounces-136407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150B29A1AAD
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D1F1C2246E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E23189906;
	Thu, 17 Oct 2024 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="JXUVfMP8"
X-Original-To: netdev@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE713D24C;
	Thu, 17 Oct 2024 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729146568; cv=none; b=ZEdAo6VppGJ+SF6UvMXJD6j6Q2B/ikgckrjaPCtqtaHiBM3EQxOeT+/Xy6R9+X/qLoljiRPHcAmZ8Ktx7CloapRyC6MaNWionhCY6TToQDe4vd4ZF5wC/sFhzxL2UfvbB4P3/fYL/DCUS3Y4mfTZoKg5CpafYVFCnF4cLRKCOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729146568; c=relaxed/simple;
	bh=s4nhpDsm0T9hY1XZ+ZmlcuwoPC7+usKDApntGAfXH/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn813DKWyMXxcOETsEAtnmrcfj+sx19M4S/5MEJLS9uea38nRVAiZq/8eGsY3cKLy8tNSAgkjo0x8CfeT84er++LXqedmS47zGocbX+iDFGaZJc0Plb5uLoMMxpWTgWjuMteWZlRVQu74IgrlOAxN6vScEOjarWWO+sn7wtc6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=JXUVfMP8; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DBBDC1484F3D;
	Thu, 17 Oct 2024 08:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1729146563; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1jroyLa3IOkny/YPUFBr1HHAZoT/a5l4o8j/iFhQogo=;
	b=JXUVfMP8Bv46MjY1Ljd2/FloLUgnQ6F36eU82RxJE7iVgi1mLtRIr9C0IjgFUe3rrYRWKR
	LGvMJdS2btBPeLiVeKy2pEVuvDMiZhpeRndmcohaxEGAbZzP4s8QgUV+UOkn2IOQHG1zIe
	9uE0w+bY/DU5sPiCAOQ3U4dkDo+sn8IFP5ruOK60PgQ16xX4jpFZVUxruakPMq3LzKvuZa
	/INMcjZFR4diWO56wOi9SFgkvRvfY2vSWyxvokpA8mal9FDQ3fFjQKK41DZx8LJK4E0euv
	A6tRMB46rjUlzJUBXKmf4uU1qlGGwfCvn/UfzAk35uNbHAnceR7+aiTFZuQqTA==
Date: Thu, 17 Oct 2024 08:29:17 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: micrel ksz8081 RMII phy and clause-22 broadcast
Message-ID: <20241017-skirmish-various-4e334907784c@thorsis.com>
Mail-Followup-To: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20241016-kissing-baffle-da66ca25d14a@thorsis.com>
 <8bbe2e1a-3ff0-4cf2-8d46-5f806f112925@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bbe2e1a-3ff0-4cf2-8d46-5f806f112925@lunn.ch>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Andrew,

Am Wed, Oct 16, 2024 at 11:43:31PM +0200 schrieb Andrew Lunn:
> > Would be happy if anyone could suggest a path forward here?
> 
> The hardware is different, so have a different dts file. You can then
> list the PHY at is real address, which will stop the phantom broadcast
> address PHY being created, and use a phy-handle to point to the real
> PHYs, so when the phantom broadcast PHY is disabled, it does not
> matter.

Yes, I think separate dts is a clean solution, creating those files is
no problem.  I just wanted to avoid the additional work for
integrating this into build, bootstrapping scripts, firmware upgrade
etc.  O:-)

Thanks for confirming, seriously appreciated. :-)

> I would say that listing multiple PHYS is just an opportunistic hack,
> which might work for simple cases, but soon leads to difficulties as
> the situation gets complex.

Right.  Thank you for taking the time to read.

Greets
Alex


