Return-Path: <netdev+bounces-87073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7AC8A19B9
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEC61F218BA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D801A200110;
	Thu, 11 Apr 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAMZhgaa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0820010C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849791; cv=none; b=P5Y2H9/p1jHFajLf3a5q5FTjwqGMgkd5IMWlj4/xTFz+TwUXajWsu4DEq0dxmF5Z1qcTcZ/kVM2ZSBXpW9RsmG+14GbXvq5eMs9UR4qVAc4xzOWdx1tskoQA0zrKFTpnTpowjLuj5S+SBBD6+x54NOQ+J9q08SDbChB6svxb3p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849791; c=relaxed/simple;
	bh=N9wN6EAvnpP4i/W9YsKuvnKBZBc9V0CyYKTWesyJsPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLLPEJGtFNhV52qhoG6OO/UhxJIkgzUg3yapswm8agfk/HHRAQrNNFaoVIvZkeH6p2KbfaQWwejKyYoSa+Es8L5HX5Hm3kX1SIX5bo+0Tm1Ex7oK8kweQFkChhZHpPx2Dgp7BIes7Hu7siCJ/BJk4/xGptTXGxG3V0elTErwguY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAMZhgaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C716C072AA;
	Thu, 11 Apr 2024 15:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712849790;
	bh=N9wN6EAvnpP4i/W9YsKuvnKBZBc9V0CyYKTWesyJsPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QAMZhgaaB5PAlmpumRzUjoQaIIKvo8S5VGYtNk49xqfEFY0fjL61G41ipqPdnkOnf
	 nRc1M9uNuPkXdnJB4wA1jZRDlYdAPrsoc9L9nDR9hMqhbX+HcaSJMKYgMe5du/zkzv
	 Z5ji3SXjT3J76Rs4eXLYB6X+cXnRonWbfRwPzyN1kQgGDoWlToRRHs6x+qq3r+zUaH
	 4A5dw4yHHA2OhKkESnGrTTNd6rw/z7pMr1/xOqNMt139Cz44y7xJQBkv3M+gBWVnN0
	 EjPlGhV/xQRXMvHN47SqykmlJ6tSKgnldscRp+SXrIKr6Vv0tRGJyXIzbO6ZtNbieh
	 P2HPo2GmLrR6Q==
Date: Thu, 11 Apr 2024 08:36:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] TCP-AO got a bit more flaky
Message-ID: <20240411083629.3eb2fc22@kernel.org>
In-Reply-To: <CAJwJo6ZQAEb6v4S_BgPqZv8W5W0hizvxyzv0K_M7domgOwTEJg@mail.gmail.com>
References: <20240325064745.62cd38b3@kernel.org>
	<CAJwJo6ZQAEb6v4S_BgPqZv8W5W0hizvxyzv0K_M7domgOwTEJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 14:16:04 +0000 Dmitry Safonov wrote:
> > the changes in the timer subsystem Linus pulled for 6.9 made some of
> > the TCP AO tests significantly more flaky.
> >
> > We pulled them in on March 12th, the failures prior to that are legit:
> > https://netdev.bots.linux.dev/flakes.html?br-cnt=184&min-flip=0&pw-n=n&tn-needle=tcp-ao
> >
> > PTAL whenever you have some spare cycles.  
> 
> Certainly, will do this week, thanks for pinging!

Hi Dmitry! Do you have any spare cycles to spend on this?
It's the main source of noise for us. It's not a huge deal
but if you're busy I'd like to disable the rst-ipv* tests, at least.

