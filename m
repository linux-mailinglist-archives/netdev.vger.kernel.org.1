Return-Path: <netdev+bounces-97819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1B8CD5BB
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3B51F22058
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D993A14B96C;
	Thu, 23 May 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FkLDn1mU"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEEC13DBA0
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474511; cv=none; b=Xc0CGojgw5KBHeeNCebfk62R96woscY10y/dsYqFMGqBAw9oKvjyTmDdqbARxZ2vOx+h9wX7mPgVecqsT4mxqKz6xq60wrS9qeLMymVYMdlmk/BxiqslOv/Ac4p/lt2Ebdg+Y0bzIwJwCC44SRBcB/h6xjc5TJdpo37+x6tYtDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474511; c=relaxed/simple;
	bh=T6RuHd53HfEu/7RGBtnM3PJUSdWDXi9XaeVdg1xxIB8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kwKsqBxZImFHS8gBY8s4+W0jDP0+DS2sclBoqvPM8KHtQx3OrNnLgxzc/M34kaItlBaW8BU8gv5sFW+9vMbrRfaP3vKXohEbxfEAZom0QnocGWXOdb1k6O7SmZ208ZcXaFdgTB+6TbQfn7xtTIkBWrnYIn6gcRC7JTENMEOwNuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FkLDn1mU; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716474508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHpms0xq85XzGNj/p9uF9ZHK74pW7guZVT3+yLrYjJA=;
	b=FkLDn1mUVs+CPaPbLUYwfuzles6y3i3U9Tn+df1VmAVx9BdvxWVGw6lbR1THPEtpxbUbOZ
	Wcr8O8NGKhgpGhbFZaFu7mA5h1e7xihcdbTX9uDYeb4rhtTonqcftCDhO6aXVhYULoCwdp
	Tww039H9hJkiH1eLHo5oG0Sna8VoXfjNucNy/h2YpdLO51pF4vMOxhervCQjJtXZ5g09l0
	EEKMwEy/PZgHR62S1VfelqFyXHpavLVwISJlMHDRiW4RreEXbDwrOXmcxvjVVEy9/5Fubm
	YbagtzzEgmWhGmVg+BeJAu9dspBxtZ2fINXVQMdf7WY1/l33zafpymRJhWzpCQ==
Date: Thu, 23 May 2024 16:28:28 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Sirius <sirius@trudheim.com>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
In-Reply-To: <90bf7f9a-a409-4390-9c4e-af4c90549768@gedalya.net>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
 <7cfcca05-95d0-4be0-9b50-ec77bf3e766c@gedalya.net>
 <Zk9OmHeaX1UC8Cxf@photonic.trudheim.com>
 <90bf7f9a-a409-4390-9c4e-af4c90549768@gedalya.net>
Message-ID: <75098eab3d18697b2728a4c8d14c5fd9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 16:19, Gedalya wrote:
> On 5/23/24 10:11 PM, Sirius wrote:
>> For the colours like blue and magenta, using \e[34;1m and \e[35;1m 
>> would
>> make it more readable against dark background. And testing with a dark
>> background right now, that would suffice the other colours are not
>> problematic to read. (It uses the "bright" version of the two colours
>> rather than the usual.)
>> 
>> That would be a miniscule change to iproute2 and would resolve the
>> problem no matter what background is used. I need to test with schemas
>> like solarized light and dark as well, as they are finicky.
> 
> I find this constructive.

Agreed, find such a balance would be a really good stopgap measure.

> BTW I find that both current iproute2 palettes work with a light gray
> background.
> 
> It stands to reason that foreground colors could be chosen such that
> they work with black, several dark and several light background
> colors.
> 
> And yes please iproute2 should not be built with colors 
> default-enabled!

