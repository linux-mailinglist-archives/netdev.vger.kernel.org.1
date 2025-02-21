Return-Path: <netdev+bounces-168664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DD4A4014C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1D019C660D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488C1FF5F9;
	Fri, 21 Feb 2025 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="NW/SdKYv"
X-Original-To: netdev@vger.kernel.org
Received: from mx12lb.world4you.com (mx12lb.world4you.com [81.19.149.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253C1FF1A2
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170811; cv=none; b=N498P0dHCgnmFiWtY9kIzKIADRe1aNguMwKBzzMHOWz58WJyPbGFo2/nJPDaVjxnTL2P6ATEkqd4BPzYMZEO6gsszDexycAr5xyWTTpCTi5Hllrj8oQvz5hX3jWJO5IvpNQ6X1dBILWGvYctALVaUuQ+hxOf7O5vVCtFFK01DSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170811; c=relaxed/simple;
	bh=oiPIa6UFtcLyDXb3TVPU4dq0PZc7Wf/wQ4WmDCQ+s7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVuhS3hmcNPorKscKLjlCgrWd/c78qngCMIguDzvvsKPgVf5unUt9fawTIQo4gGHtc/Q06Njxwvk8slDCqG0fabk7I+GtOYkLen2QeJVMhew/ZeRsbffyZVvV3c3e8FzYwhtjqs919+MqmlznAaJnKcPSxTFm6W5qZ0TDxf85FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=NW/SdKYv; arc=none smtp.client-ip=81.19.149.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zRM4ZeBVNHnzdRR9c9SOkgYxlcFJUwX6fNRxKOiLX5c=; b=NW/SdKYvjkCLEDJhnPbX17Ke6h
	5n6NZuoXcSojU5Mnr8LRg7jIhfcoNv3tUsg4aKy6PS3g7oRtW9MPWZR4cc0nsKJyG1tMxTg3Zt6fx
	2Bl81ZJfld0FeM3+tBwUwF3YCpELSY2feqv/MpC06fvg/eM6jy8WCHxhK07D9hM8npXI=;
Received: from [88.117.55.1] (helo=[10.0.0.160])
	by mx12lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tlZv3-000000001aq-2lgN;
	Fri, 21 Feb 2025 21:46:46 +0100
Message-ID: <b9ed9e8b-4af8-4dcb-88fe-8507134348a9@engleder-embedded.com>
Date: Fri, 21 Feb 2025 21:46:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 7/8] net: selftests: Add selftests sets with
 fixed speed
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20250219194213.10448-1-gerhard@engleder-embedded.com>
 <20250219194213.10448-8-gerhard@engleder-embedded.com>
 <20250220181419.54155bd0@kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250220181419.54155bd0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 21.02.25 03:14, Jakub Kicinski wrote:
> On Wed, 19 Feb 2025 20:42:12 +0100 Gerhard Engleder wrote:
>> Add PHY loopback selftest sets with fixed 100 Mbps and 1000 Mbps speed.
> 
> Maybe an obvious question, maybe I'm missing something - but how
> is this going to scale? We have 120-ish link modes.

I will try to make the speed configurable by the driver which uses the
selftests.

Gerhard

