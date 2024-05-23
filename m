Return-Path: <netdev+bounces-97669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1D98CCA0F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 02:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893131F21B0D
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 00:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A5196;
	Thu, 23 May 2024 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bQnLTZ42"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198C193
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716423271; cv=none; b=rMuRwnLlyHSaUnOWx7wMFaz9NfXzh20RVav1BfFENfTCK2AjWchVLbQ0iakILR+/GrfKbTUDknbfB2Lah9kk42Zpd89+f1wmPsFjnUaxr6nykpDU/rxPNcrfLOUOV0IxgBWnFBa5dfUwRoOznLnZK1YGpH6nybvAy/x0zLBb/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716423271; c=relaxed/simple;
	bh=lgxnAR/cFdYfgfqcGpo/wLG8CvOCgtcf56uwmKAUrKA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WLsMtcUSc/bw+EM19ztGf678AdeTeZhctOBuGWNkw0+i+ol70RmBBKv9dzjmJ4yNT+iX5hC2TeffAkcdKUj9GFDOmifYAGNbQQHZ31FJoR5x+nkGzcMsoy/ypoN7GJyOXS6DnnZgQndsnoeGCIt03/xU0D4D9k9lA8TUdSDIuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bQnLTZ42; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716423266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hu99SIR8Jx45xr+X4jph+CmWAb+rt/P2J85WXkILwrY=;
	b=bQnLTZ42WwlHtabvtcIZ+BddyQ4hK+vqWzh5lCeBW6Nz+ibHC+dIQpuWNhkDabcDrZigZ0
	z1wlhDWhtJLRMERaD/uwXmLZ+0ahTAd0bEE/G+EZSNaYeMXXFTY3jbQx7k0cfVYX/NGx6H
	SuIPN6RnhA9G2+ao9bNySJT4zBbCMO9AJPM0Mt8cucc64uIa1aG/CdozktjEQI1RubGVRU
	dUw6l6TqmlVXdkluzvzacPY7fiCEZylzTzZHYfZwv42D4n29avHDKOsSkgQMUJzP9xo0Lz
	UKTpHmXeBJsOoFggTCefxlA2NfASL0vEOmb/IoMvl8xr1+u76WdDNwNiw+2m0w==
Date: Thu, 23 May 2024 02:14:26 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] [resend] color: default to dark background
In-Reply-To: <4e20a39f1796682b7637a010becc2527@manjaro.org>
References: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
 <20240522135721.7da9b30c@hermes.local>
 <67841f35-a2bb-49a5-becd-db2defe4e4fa@gedalya.net>
 <2866a9935b3fa3eafe51625b5bdfaa30@manjaro.org>
 <20240522143354.0214e054@hermes.local>
 <5b8dfe40-e72e-4310-85b5-aa607bad1638@gedalya.net>
 <20240522155234.6180d92d@hermes.local>
 <005513fa-85ce-4e9f-a357-e1d42944410d@gedalya.net>
 <4e20a39f1796682b7637a010becc2527@manjaro.org>
Message-ID: <a829bf85715456be3f3aa48eed854908@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 02:12, Dragan Simic wrote:
> On 2024-05-23 01:41, Gedalya wrote:
>> On 5/23/24 6:52 AM, Stephen Hemminger wrote:
>> 
>>> Overall, I am concerned that changing this will upset existing users.
>>> Not that it is impossible, just need more consensus and testing.
>> 
>> Turns out people were complaining about it years ago, not realizing 
>> that
>> the color scheme they were looking at was actually not meant for dark
>> backgrounds:
>> 
>> https://www.reddit.com/r/linux/comments/kae9qa/comment/gfgew0x/
> 
> That's what I also wondered about after enabling the color support
> for the first time, which wasn't very unusable with dark background.
> After a bit of reading, I got it all configured properly.

Oops...  s/very unusable/very usable/
Sorry for the noise.

