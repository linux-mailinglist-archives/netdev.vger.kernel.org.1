Return-Path: <netdev+bounces-213054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F38FB23052
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C62B56552C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220332D46AC;
	Tue, 12 Aug 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fbWgHwij"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2E2868AF
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021037; cv=none; b=W2+q3h92dHmVO1JOFuY8kS5x5NfU3lQPrKBNymj5xd6oabaxa04IswHChKVFSMPYBLydyj4URYBCb0MZPNF4+iyzasAJYYYPblORfT/qePq9LemUiSA27Ai5Ry7X2bUq9f295devDgjnrxpGhHbruKoEwOO3BIXcEPNmdz1BTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021037; c=relaxed/simple;
	bh=/CZdHiKW+arh7TP/60XkdkhemHylpfCrSV/hr94xRpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qwr9OPREFi1V+BnN98H5xgCH7GGLGMatngexadgNowpolujHhy99e50mEzwxVpvSCMA7pbLXdoKGX3c9+n4tU4AYwaA3SBmPrzShZhc2Gxww+lMsAB/Sh5vcl1MAXtgPvNCtFDk2UD64kqZqwyXm8UG4WO5DlX5ZSZ0QAOehwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fbWgHwij; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <47d0924c-db37-4c83-8525-60d9d5a37771@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755021031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lofYCCXYeNA66GAQPT3Sw8V0vQwqU35smEvh1XYMrao=;
	b=fbWgHwijUkO4Dp4GYuIPTrKzfDAdQ8e01eAeq9dPLq5MpcLEzrbgJViuAiSwB8sVtzOkt8
	6Ob9UJr9vodvrWxOdlG383LX7/WZHm1oZhZEI0HtF1dBjdPXCrO+vx6u9DTWf1PHuv1XfH
	d8AqVuGa/6OwwzSFW2IgaKVZISPktv8=
Date: Tue, 12 Aug 2025 13:50:27 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [ANN] netdev call - Aug 12th
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Daniel Golle <daniel@makrotopia.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 netdev-driver-reviewers@vger.kernel.org, netdev@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>
References: <20250812075510.3eacb700@kernel.org>
 <aJtvp27gAVz-QSuq@shell.armlinux.org.uk>
 <aJtycOgN-QL7ffUC@pidgin.makrotopia.org>
 <aJt2mg4vxRHSvDTi@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aJt2mg4vxRHSvDTi@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/12/25 13:15, Russell King (Oracle) wrote:
> On Tue, Aug 12, 2025 at 05:57:20PM +0100, Daniel Golle wrote:
>> On Tue, Aug 12, 2025 at 05:45:27PM +0100, Russell King (Oracle) wrote:
>> > On Tue, Aug 12, 2025 at 07:55:10AM -0700, Jakub Kicinski wrote:
>> > > Hi!
>> > > 
>> > > The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
>> > > 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
>> > > 
>> > > Sorry for the late announcement, I got out of the habit of sending
>> > > these. Luckily Daniel pinged.
>> > 
>> > Only just seen this. Apparently, this is 4:30pm UK time, which was over
>> > an hour ago.
>> 
>> I was also confused by the date in the subject (August 12th) and the mail
>> body saying "tomorrow" which is the 13th...
>> So tomorrow (13th of August) it is?
> 
> Hmm, if it's tomorrow, I can only spare the first 30 minutes up to 5pm
> BST.
> 

I cannot attend anything tomorrow. I'm available Thursday and Friday.

--Sean

