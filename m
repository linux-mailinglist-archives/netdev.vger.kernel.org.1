Return-Path: <netdev+bounces-212976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 618C0B22B68
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA16E1886D48
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BE02EBBA4;
	Tue, 12 Aug 2025 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GyBG++z1"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A32F49FF
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011152; cv=none; b=SnwZQI6lMJUc0zpz5C+9s5oqqcTU/paSuR3QDu06Nxvj8v01AeCKOtOzs68LohjrPJ9ynAebsj3R2C4SMnfkysUBFYkltphbxkA8rOh5PQ3HfRVCpUWvKVWkFHWmtzsZLctQlRSXIz2D69ik6QJUDdMi+m4aWXfO0EhFGOWWJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011152; c=relaxed/simple;
	bh=dETLW8I8onjKAA2dFwsj1xShWyMkZORC8+91l3Qu7og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPVGWMuKy6NcFRVCWviwRe7TCRuBeCs74AnaZX+Oyj5RLVW0l5nnpwtZ1EyhZdIeGc470UNSKqgX9par+xmAfqbYm8MagosliEEvvP5hjten9OGiGCYK2bPBl6ilqWps2skmvMkk5CT6I6BUYyR3M7aaFwYrXgQihKs0Wvj4WLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GyBG++z1; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <619df969-a001-4e3f-8b00-e0509db994eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755011138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTteeb5LmA7dChYA8Ykmu148m/jnqnVPThKMhgDVKAo=;
	b=GyBG++z18qJZ6TDO7SZxz9W6PMrWPiaM300dzoeQt3ktEbsj8CJwvnxC9iplh27aFkLpuR
	m4v/gRkUbNW8e+hnPzyXyxpsSguVmyNWpOjYyUTTXn6qpR22h9CShGd9M8j3mIJvHrbEBC
	eNDSmLI+U8/qqnIKp9SoTM1VJFfMSyM=
Date: Tue, 12 Aug 2025 11:05:30 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [ANN] netdev call - Aug 12th
To: Jakub Kicinski <kuba@kernel.org>,
 netdev-driver-reviewers@vger.kernel.org, netdev@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Russell King <linux@armlinux.org.uk>,
 Christian Marangi <ansuelsmth@gmail.com>
References: <20250812075510.3eacb700@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250812075510.3eacb700@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Jakub,

On 8/12/25 10:55, Jakub Kicinski wrote:
> Hi!
> 
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> 
> Sorry for the late announcement, I got out of the habit of sending
> these. Luckily Daniel pinged.
> 
> Daniel do you think it still makes sense to talk about the PCS driver,
> or did folks assume the that call is not happning?

I have a conflict every week at the meeting time, but I can join at 9 PDT.

--Sean

