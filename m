Return-Path: <netdev+bounces-212988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0122B22BE0
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2193503AE4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4362DC34B;
	Tue, 12 Aug 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iSprueJI"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5C2EFD99
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013168; cv=none; b=Nme0bm/mT7qPCnnHZDfB4RGn364EYtq6c2i8YlZXilsxZcf490SctcCO0dHvHSvGN2Yj1URJbN7znOKrVGBosGYoI6nFhpZob7JnZJu8HVAwSyNy8emxnwj2xyRyAsQnckRoEQei9Hekl8ee5+UIyMl+vRJ2W8r0sWlzzUsS0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013168; c=relaxed/simple;
	bh=QoSsGpX4ZpBeW6fW0sNW/Wul5s615JjOUmmijQ7xjzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unKRKlyQU1Rl8DOxCWAz25B4/85epvPSr7JihTfq9gFT0pu24Ib9twX9L9xeiARhEeFkOAXIJgd8OsdZqLRuKAd9JjSLgt7WOvawKv9+NESAF46MlxUBgxF1tWFf4O68CByCob7kKFEFrkxjDtaZjqT8b43JeXahR1wSPWqsKUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iSprueJI; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2ce5d8f-139b-4460-bc01-1d6e348ec31a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755013164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TtFSSiaSDA9pTAkvw8qVIRM5brgvEaajrZzPrhNUjI=;
	b=iSprueJIpW5ZzcJ0fGOOmH1FeEll2xORdcHnI+fixLdhrZ5w+EZU40kMLZaX5c7Tbu7n+o
	gXeA7kNM2x7WE5Noc8z/Y/MP37jQ/TXMarkKMwCqbLURmvGLxxZz4mfoWDlpYogzUiF+UK
	K+MlFs5Z4/wpVUEbd/o0iHCm4DvxMPc=
Date: Tue, 12 Aug 2025 11:39:04 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [ANN] netdev call - Aug 12th
To: Jakub Kicinski <kuba@kernel.org>, Daniel Golle <daniel@makrotopia.org>
Cc: netdev-driver-reviewers@vger.kernel.org, netdev@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Russell King <linux@armlinux.org.uk>,
 Christian Marangi <ansuelsmth@gmail.com>
References: <20250812075510.3eacb700@kernel.org>
 <aJta5YNhKM9OqEmg@pidgin.makrotopia.org> <20250812082920.26bae903@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250812082920.26bae903@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/12/25 11:29, Jakub Kicinski wrote:
> On Tue, 12 Aug 2025 16:16:53 +0100 Daniel Golle wrote:
>> On Tue, Aug 12, 2025 at 07:55:10AM -0700, Jakub Kicinski wrote:
>> > The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
>> > 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
>> > 
>> > Sorry for the late announcement, I got out of the habit of sending
>> > these. Luckily Daniel pinged.
>> > 
>> > Daniel do you think it still makes sense to talk about the PCS driver,
>> > or did folks assume the that call is not happning?  
>> 
>> It could make sense to talk about it, but maybe we talk about other
>> topics first to Sean can join us as well. However, I think mostly we
>> depend on Russell or someone else to make a decision in terms of how the
>> three of us (Christian, Sean and I) should continue.
> 
> Well, then I'm not sure if a meeting is the right approach in the first
> place. Perhaps it's just my feeling but in corporate world managers call
> meetings to force a decision (conclave-style). Upstream we force
> decisions by having patches ready to be merged on the list.
> 
> I would like to avoid anyone ever feeling obligated to join a meeting
> as part of their upstream work.

Personally, I am willing to swap things around as necessary, but I haven't
gotten that impression from Daniel/Christian. I have provided feedback on
Christian's series, but I haven't gotten the follow-up discussion I was
looking for. I think there may be a perception that Russell needs to make
a decision, but I think it would be better for us to come to an agreement
about the best architecture.

I think at this point I (and hopefully Daniel/Christian) have a good idea
of the strengths/limitations of our proposed implementations. I would like
to meet and discuss the best path forward in terms of how we want to solve
the problems. I would also appreciate input from the netdev maintainers who
may have broader experience and perspectives (and who are likely to spend
the most time interacting with whatever solution we come up with).

--Sean

