Return-Path: <netdev+bounces-97702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C238CCCBD
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A725DB20D58
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 07:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2C13C9B8;
	Thu, 23 May 2024 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="prb7HfHh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09813C9AB
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448106; cv=none; b=HhvZS8UNtZIhBbsZoKopTp75vDtoGPXraGKXbuj2ekdvRlX74N0jYuQHuIf8DJUD+mKmKePY0+CrVOViMMozfBBbbtiNCv12erfzHW2P3BQ2XQOhEFfqgUCQBMQAo3ImY3Vmam2mMR3Hw0osVAtuK7BMvdLd3ormX95n3bBc/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448106; c=relaxed/simple;
	bh=/wU7wTaTH/FshKjBxN8UPhZS4dimdJ8t2PbvsU+0eq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQ1Omh7S75tov0ghB0NZufzIWWEmrXghOZVqZiU+Iq8MGuL3ANXxOW1P1IbguM7N7PWKs1cns91XvOU2NNgcjRGOHinTdnk7loqyHqxGISUK+JNFJsNx/WtfRKG5c3fd7fPOJU4bNlsdq+za7AOuW/BAFIz0rgUjhLE0fu5CRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=prb7HfHh; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=/wU7wTaTH/FshKjBxN8UPhZS4dimdJ8t2PbvsU+0eq8=; b=prb7HfHhhLo2eqYSnfqDpq2VW4
	N5/PNqIqAnqClJrphUPyflA8myC74MZT+4KeIIGFawDHiUI14NFx+BrRy/RqgFt+20LnlOe8NigPA
	yOTDG57kai8CCBYnLFceoF56IlgPVbUfik0/MR1adapf6I2RDM8YFXW3L1P//jEFXul1jDop1AuBK
	8DKzdGDi2BqcFpFlb3ltgcl1BYwYjBgXCmxsIGG3BpDHZvTbDPbvuTQQnZieI6qQXsvmHsqogzEQJ
	k4MA1ir01IVAXboO5j9hbiyr4OQlPpMANmevD7jYH832fLyQWug/vRFC6rNEE6iOAkb75LzcrXpB4
	jiNxX16w==;
Received: from [192.168.9.10]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1sA2Yo-000fi4-1D;
	Thu, 23 May 2024 07:08:22 +0000
Message-ID: <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
Date: Thu, 23 May 2024 15:08:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iproute2: color output should assume dark background
To: Sirius <sirius@trudheim.com>
Cc: netdev@vger.kernel.org
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 2:39 PM, Sirius wrote:
> what terminal background should be used,
It's not about prescribing what should, but about guessing what is, when that is not explicitly stated. The only "right" way to guess is to always choose what is more probable (common, in this case).
> read what the background is of the console
That's COLORFGBG. It is set by some terminal emulators as a way to advertise the colors being used.

I'm no expert but AFAIK there is no uniform way to do this that is supported by all major terminal emulators.

> adapt the foreground colours to that. I would guess that means holding two
> sets of the eight colours and if the background is "dark", use the lighter
> set and if the background is "light", use the darker set.

That's what iproute2 currently does.

In fact this can't be adequate. You can't turn the question of best contrast against 16(million?) different colors into a binary. But this is a simple CLI command, not a full-screen productivity app.



