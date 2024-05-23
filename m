Return-Path: <netdev+bounces-97668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB60A8CCA0E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 02:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D2B28209F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 00:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B56EED8;
	Thu, 23 May 2024 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="iWxO1/Bl"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392EEC5
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716423151; cv=none; b=BAZ1xRTihlrKkhO5Y0DL3U7udp1JbTy5YqN7eRhm5FFhOfWDRMsqCZw1gBucun5/Kr42GdwXBpY5g6GSmaR3IQZxB57R9qj7nG9x8q4KZd6HLpkP2hAEy3X8li+TGODufcqvgR1+mIn3S6uiBp3rjyXyUGqch3X7qJaZG0JHZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716423151; c=relaxed/simple;
	bh=ANkRUb1bwAgrDs4zvhPe0qOdkmBs0EVy6YlfAI2fat0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ml4Mss47nd8usLzY6gmuDYa/LCSBcNHu0X+XpH/gaR4Q6PpjpbUaEtWujVcryZZA/zaW2Se8lcWmp5BNjj6HbeV2ebWTofI9/f8TNmdoGcOsELOVGGWhf5kTjEasE/a4WYqL1mPt8ig3R561zy3EX7lC2HmloFTyYPNWdROkcmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=iWxO1/Bl; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716423145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orhR3mD5suZMwD6x94iKkyggewrD7PVZIqFS8QUYtHI=;
	b=iWxO1/Bl4KtvV+Vtw+G+L2RiYd1n0Y7L8+FbBtTsHoSLndn+JE6Rc/xYXnVRIUbPjRGpX5
	p797bZsXzfRJaKZh21DhIrHGfoKAeOePwMtZBwhNSXvs7nP+tvNL/9QtTVPKkdimOGRi+u
	2v5FhwNzqKuIG7uOBOjM1acy6Z9zEm5t5m2qCfNlci5EGG1IvyMh35xpL4K0qtUwB3GMU/
	NG+BFuTl+KEypAsVM5U+VtVBltwIfPEjbRmsRYq2Md9IStNEFAPt0yY53bwTqLUjlhiCn0
	RDR4JV5HSy05Qv5LYj/SQ5Kq868QBWakduGEtGsFRX7Xl0CGbGZaeJCG8Epdcw==
Date: Thu, 23 May 2024 02:12:25 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] [resend] color: default to dark background
In-Reply-To: <005513fa-85ce-4e9f-a357-e1d42944410d@gedalya.net>
References: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
 <20240522135721.7da9b30c@hermes.local>
 <67841f35-a2bb-49a5-becd-db2defe4e4fa@gedalya.net>
 <2866a9935b3fa3eafe51625b5bdfaa30@manjaro.org>
 <20240522143354.0214e054@hermes.local>
 <5b8dfe40-e72e-4310-85b5-aa607bad1638@gedalya.net>
 <20240522155234.6180d92d@hermes.local>
 <005513fa-85ce-4e9f-a357-e1d42944410d@gedalya.net>
Message-ID: <4e20a39f1796682b7637a010becc2527@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 01:41, Gedalya wrote:
> On 5/23/24 6:52 AM, Stephen Hemminger wrote:
> 
>> Overall, I am concerned that changing this will upset existing users.
>> Not that it is impossible, just need more consensus and testing.
> 
> Turns out people were complaining about it years ago, not realizing 
> that
> the color scheme they were looking at was actually not meant for dark
> backgrounds:
> 
> https://www.reddit.com/r/linux/comments/kae9qa/comment/gfgew0x/

That's what I also wondered about after enabling the color support
for the first time, which wasn't very unusable with dark background.
After a bit of reading, I got it all configured properly.

