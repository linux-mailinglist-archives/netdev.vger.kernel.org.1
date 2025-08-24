Return-Path: <netdev+bounces-216305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9DCB33032
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FCB44021F
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2C2D7382;
	Sun, 24 Aug 2025 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n6QTekPD"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B5221348
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756042824; cv=none; b=n61O40hrx8kVg/slHHfjtz6TS0WOVL5T1XB8jK4fM1CsnU0SQDkJlt4MyIo10kTcjbXx2fsE/2RYy/VNYISpaAIUmbbbWrLa3Sm9ZPu3iKAqaKpUtRU9HHU5nOllce8eSxQmDXM/8JdrqpzJF8owTgxn1/eTsQOtWajKftQktho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756042824; c=relaxed/simple;
	bh=p91xh87VAGJQ8cnVENNwQKbmr968aV5sZ2E2tCBsNm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZCwXU6K/iSg+6HC98/wYyHOY6dfQR7je0hhsPZ8cs7EmnmfrqOYk5K+ZnISbMEgntfDSHahJQV0WHw8mBP+6rZk8w+3tz2ST2qh8Rpkr0DHUDg5Dqjm69Lp2VlJAoL+K5R6K6wm1KwSFfRCHWEwQKkTisDDVsfRqeiX/YuBnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n6QTekPD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C1F3E2015BA0; Sun, 24 Aug 2025 06:40:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1F3E2015BA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756042817;
	bh=4BQtc0wiyYy1xD+tptaoIm84Lk8u/oqtUCnoyTUXGFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6QTekPDZ6i7wHNUNpY6SKq9a3YPfG+G1gFYfaisPea2c4KaYNabUgDCns2j6aKOF
	 Lo2i1YEGuP2BGB0H/iDRHdYmfUOkkSc+Agajbgo8o+oioutywEbyYOwMWJPT/EuRuG
	 rs2U/AZlV7TRySHwbGeMf1lt19tjSC7EMQ1bBJX8=
Date: Sun, 24 Aug 2025 06:40:17 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dsahern@gmail.com,
	netdev@vger.kernel.org, haiyangz@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
	dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250824134017.GA2917@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
 <20250816155510.03a99223@hermes.local>
 <20250818083612.68a3c137@kernel.org>
 <20250821110607.GC7364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250821071259.07059b0f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821071259.07059b0f@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 21, 2025 at 07:12:59AM -0700, Jakub Kicinski wrote:
> On Thu, 21 Aug 2025 04:06:07 -0700 Erni Sri Satya Vennela wrote:
> > > Somewhat related -- what's your take on integrating / vendoring in YNL?
> > > mnl doesn't provide any extack support..  
> > 
> > I have done some tests and found that if we install pkg-config and
> > libmnl packages beforehand. The extack error messages from the kernel
> > are being printed to the stdout.
> 
> Sorry, I wasn't very precise, it supports printing the string messages.
> But nothing that requires actually understanding the message.
> No bad attribute errors, no missing attribute errors, no policy errors.

Are you referring to the following error logs from the ynl tool?

$./tools/net/ynl/pyynl/cli.py
 --spec Documentation/netlink/specs/net_shaper.yaml
 --do set 
 --json '{"ifindex":'3',
	  "handle":{"scope": "netdev", "id":'1' },
	  "bw-max": 200001000 }'

Netlink error: Invalid argument
nl_len = 92 (76) nl_flags = 0x300 nl_type = 2
        error: -22
        extack: {'msg': 'mana: Please use multiples of 100Mbps for
bandwidth'}

If yes, would it be reasonable to add support in iproute2 itself for
displaying such error logs?

