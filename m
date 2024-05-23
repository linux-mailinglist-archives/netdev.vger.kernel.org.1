Return-Path: <netdev+bounces-97820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EAE8CD5C9
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222F3282321
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07AF14BF98;
	Thu, 23 May 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YNNKtrAU"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561A14BF91
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474553; cv=none; b=J66Ym7lPA7FzyRe/3VwNDcIgy4D/9VF2gwzbp4fOwNI+17XUUz+yMBwk+kit8ydkw52o33tbhAxof8PiMOFuCCYNxSLR40eyzTutnssiGRvA8wOhJsrfFxjZpESXt0townj2Kw777y3EZG/yelJYTsPmb0BWl6UZH6DAR0EqDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474553; c=relaxed/simple;
	bh=zNeXYIRmWeVNuZh7yvoyX9Zd3iRuFuXuv90+Hi7C2AQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fIjqsTCC7YWW/4XFmm1rwZdEiM0gr6CG9j+/jm+zGyYRkngTFHca908o0ez6cTwV6iL4sRgX+mzgyP6fDzs2CfWK32k4nQ6MZznoNJn50NGxloTqMIafCcwLcCKcMTMNexuy6GyD6PQHpwq8Rq1C01h9tp/nUpPmZ0wryPdyL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=YNNKtrAU; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716474550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1geuTRiQ9L58Hyii4GnJITw0CY6fwOlEreaAc1ksOk=;
	b=YNNKtrAUf5YM21KJ8i/i0F4RyFpJedwIpImxImCEfYl9wSlPenD2CSC94h4/zmJ/R/rOPl
	lEoVEsQpI6qPcOZOWkh2h0/s+4uHcwbM/y7CReTV7wpjFdj0P809na7TovRx3uP2gPC1Os
	aCAvifBn/C+O+I4d8MFv5dmhqa8lceqN3qAbUaHwTtryUp5Mwdt1kDhilFvqNJ8XKTeySV
	p4BMmvU3g2bCEEn52X/GnLfn9KTECgtCs/duKWrQV6HIrgz7fXWkiA3s/ecdF+j/PHw7WJ
	3Lj2pps/E2FBBkhgLy50Lc6eVgcvD4hG4G252Wzozx5wx+L69fHc/60XSu8ohQ==
Date: Thu, 23 May 2024 16:29:10 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Sirius <sirius@trudheim.com>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
In-Reply-To: <75098eab3d18697b2728a4c8d14c5fd9@manjaro.org>
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
 <75098eab3d18697b2728a4c8d14c5fd9@manjaro.org>
Message-ID: <36106338ae3105ba9ef6c858f30efd67@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 16:28, Dragan Simic wrote:
> On 2024-05-23 16:19, Gedalya wrote:
>> On 5/23/24 10:11 PM, Sirius wrote:
>>> For the colours like blue and magenta, using \e[34;1m and \e[35;1m 
>>> would
>>> make it more readable against dark background. And testing with a 
>>> dark
>>> background right now, that would suffice the other colours are not
>>> problematic to read. (It uses the "bright" version of the two colours
>>> rather than the usual.)
>>> 
>>> That would be a miniscule change to iproute2 and would resolve the
>>> problem no matter what background is used. I need to test with 
>>> schemas
>>> like solarized light and dark as well, as they are finicky.
>> 
>> I find this constructive.
> 
> Agreed, find such a balance would be a really good stopgap measure.

Oops...  s/find/finding/

>> BTW I find that both current iproute2 palettes work with a light gray
>> background.
>> 
>> It stands to reason that foreground colors could be chosen such that
>> they work with black, several dark and several light background
>> colors.
>> 
>> And yes please iproute2 should not be built with colors 
>> default-enabled!

