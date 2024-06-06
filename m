Return-Path: <netdev+bounces-101482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7EC8FF097
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E2C1F245B9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2619645E;
	Thu,  6 Jun 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oJzPNfY/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YNyyZuVJ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B86947A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687432; cv=none; b=d4f7h1Ws3xWb8R4dhGc8bAFa8dDIX3IL1CgzZIzkEgKuD+JCybaYWE430enh3v/at6oLs/pqWyFwrT+7GBxHWI+cwU5OtSSUdL4+GcUXPIqrfMbjk18Eae1R2Aupw6AyU8F4n5BgklM4be7dSd2c57WtzpUSc6pmS5YpZr5l/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687432; c=relaxed/simple;
	bh=sYJEZrp8Y2M/DXE5buRsOvarKoWFrfjOx8RRju4iFck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDuvl6gns0L5Yjm+nyM2jpoECYotHfSdTTyhsiVy8YywxSG9/9lCbCg6V2Oclh8TtUwZACLDc6O3oqm/Uj746dpQh0g52Dodt3p9PKrTYG6+lMGHgBRz8+aMEeK4DlwiSa/4wtGeCkEFYQuhAky15U7oW6YcMan/gzFBDn6fqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oJzPNfY/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YNyyZuVJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Jun 2024 17:23:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717687428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYJEZrp8Y2M/DXE5buRsOvarKoWFrfjOx8RRju4iFck=;
	b=oJzPNfY/UT9rZ2UN44asUeIdZuMSg9fmSSHN92pm+L9KWxp0jZBe9UHsds8bwzrro8+r0M
	VJlSuPrF8zS7VrBMYSFMWnoAcCOhuU2byJF9zQYBHsbMhciscEndOHqEIJH5hIVNIQVUN/
	Z6X30tTIdxGZ8cyl/hN7SjAJaxlbl01MgX8DG3cWJkFRMtDf8rMoAh+yiT3M2hk57UEhsL
	oU8ECtTJEemBTeZ0BSTndnRmXAt8Ge+rQhCFQoc8dYD4NxdspeTiPcT5ZJ8ec/hduakyes
	gDRvpDO91lnXyI7BP4nXuSx1CBW6NhOxjAxUBfFSaa85Df4KKb8HWwe0OuVCMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717687428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYJEZrp8Y2M/DXE5buRsOvarKoWFrfjOx8RRju4iFck=;
	b=YNyyZuVJqHvOZjh0989ucxN4s7Tpmw11QsVcn7E4UowJkhO8x6c1zOTxjOCO/jNPLyJvVg
	/qMqh/F04OleeLDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, vschneid@redhat.com
Subject: Re: [PATCH net-next v8 0/3] net: tcp: un-pin tw timer
Message-ID: <20240606152346.mXZQ9s1d@linutronix.de>
References: <20240606151332.21384-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606151332.21384-1-fw@strlen.de>

On 2024-06-06 17:11:36 [+0200], Florian Westphal wrote:
> Changes since previous iteration:

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

