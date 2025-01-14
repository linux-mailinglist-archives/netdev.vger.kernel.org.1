Return-Path: <netdev+bounces-158232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5666EA11293
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323981642AD
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA20820F96E;
	Tue, 14 Jan 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="bZqoH/M8"
X-Original-To: netdev@vger.kernel.org
Received: from mx13lb.world4you.com (mx13lb.world4you.com [81.19.149.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095C920F074
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888142; cv=none; b=uPVvC2gScL1eSB/ghZTOUjk9etUJo2XM8s5B324PZAbOG+KJm8f/Of+1m5F6gzP1euzI7kZEZn8bkdA4TF7mJ3vW6tQKqEsvpNuKz5Vti0cMbPB02W+JulkfCKSpKXTt3cFfw+tsCOVqroi+AIB8m2aPVABUCySnTbEPLFmOL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888142; c=relaxed/simple;
	bh=pzmadhYkTMkI43WUW3G5FN3Fe8070BhaK2gYuDHGRKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jN6PsVZm3JXldiHmL6cxOYL0zPlK16P5jymMFpuvcN6sF4uSj2hfC5B6PuwUXFRuepbD4OGHAekuIVhxt0qfGW0Bc0Jegea2kboEBqtuOIAShaXScCtmMzrQwOQaRUsUbZ8DnJZSdmsmk/rITUo9Nhpk85Os0EMyWHHbElJZ34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=bZqoH/M8; arc=none smtp.client-ip=81.19.149.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XB4WmD9WM9aCEc4XLwdCD379fnzOyzeI69BYBP/Dsh4=; b=bZqoH/M87k5WguX71njxQiNdN3
	Z7JbinRz3d29MrGBUuztWIxvUYZlEwVoMzgiJPdV8CHo3bnbc8oz+T4i7Q1iQ5kWB+4UzMDVASQjT
	JCsdWDjF4l43BLHSO+T6UPnsvKqRs7YhNEcv6Te4PImVI02z3PDMvsb/XzO+/FrVtZg0=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx13lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tXndw-000000001A6-2edz;
	Tue, 14 Jan 2025 21:36:08 +0100
Message-ID: <8944a472-7cfe-4f20-8da3-75ae5737ff94@engleder-embedded.com>
Date: Tue, 14 Jan 2025 21:36:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] tsnep: Add PHY loopback selftests
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20250110144828.4943-1-gerhard@engleder-embedded.com>
 <20250110144828.4943-6-gerhard@engleder-embedded.com>
 <b9ba6dd0-a978-421f-8d63-3366ea5e3991@lunn.ch>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <b9ba6dd0-a978-421f-8d63-3366ea5e3991@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 13.01.25 23:08, Andrew Lunn wrote:
> On Fri, Jan 10, 2025 at 03:48:28PM +0100, Gerhard Engleder wrote:
>> Add loopback selftests on PHY level. This enables quick testing of
>> loopback functionality to ensure working loopback for testing.
> 
> You don't appear to be sending any packets. So how do you know
> loopback is actually working? I'm not sure this is a useful test.

Yes with sending packets it would be a better test. This test would
detect if loopback link is not established with the requested speed
as it is the case since 6ff3cddc365b ("net: phylib: do not disable
autoneg for fixed speeds >= 1G").

I will check if sending packets can be added.

Thank you for the review!

Gerhard

