Return-Path: <netdev+bounces-166860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E020EA3797E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 02:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A757A2A6F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 01:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F9120DF4;
	Mon, 17 Feb 2025 01:48:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B551CFBC
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739756895; cv=none; b=nhRuzFt2Lw0wRmMzu5nTr/YNNJInDofLa7w3D4ytdqN3dZAXPXUS2D/Es1sbKcgcz17+2x2O8xxjZp8FO7CL2xR1wFA6vyEnj7q2LkHNr1oeM9RxK10jluPEwciYNh4vo/tJjlupCBzOyhrRtfdrRDJjhr5jNnJNSPENc1tGvCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739756895; c=relaxed/simple;
	bh=SPsunDBPiK8LKYg952xV2FoyU77eKeZ+RklBgkS7puw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MA1x4xlsTEKBGIS7GkSO+5CVh0GnOqnFQtmvM09KP1q/LvdwXMkQnLFDGC26UyqkKbyXlZA5T+fElt80ZAMR5cW5l0RMWmPhj/hu17RhxGVjZiSCx1rUIb9pSlDaBd8PsongjuJnF1kxuSF1xyHRJF2rkeqhwoklEWqZkVSSxDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1739756873t074t61148
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.205.26])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17215311018305959511
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>,
	<mengyuanlou@net-swift.com>
References: <20250213083041.78917-1-jiawenwu@trustnetic.com> <20250214165218.5bce48c3@kernel.org>
In-Reply-To: <20250214165218.5bce48c3@kernel.org>
Subject: RE: [PATCH net-next v7 0/4] Support PTP clock for Wangxun NICs
Date: Mon, 17 Feb 2025 09:47:51 +0800
Message-ID: <050201db80dd$f4b45bb0$de1d1310$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGUGoOS8IXF4ptWDFBIVDWWEs4OAQMHYeYks8FKdCA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mutteg8H72qDJ0RXW8KZoUAu0sWTePdDZ8aWgwtzibo2pf+TqafNfOWS
	lCWQCFnplttm/HL34q++oiz4Yb9Gg6GDS0XOaJWbG6I9nr7yVKr7kbYNBbIZAXZXYhdG1ba
	ZrsphOG1BuFx1X1sHHz323prY5TYIHAhpft4ESDXaO57d38DQHl53hHALJYFCMD9cbiaBpe
	kjzz8klyEhJmZbzmD40lwDf8jourpvQ5dvjFoJcP5TttL5fFPT2j1MQF9R0SN4J2lsJmlh4
	qPbwDsb/7zeRM7b26J7k2si3CLRaFA9TrRE/b1Qsqchq++BfhcFoaqHWxYe39IrGI8BRWWM
	eF1soos4B2Vuhy3ynFVOt3RbloDeok9+VG8wVNA8wn4fRpkA3QjOe7/Y/ktlXPrdtIa/TyO
	wqgRTqJdOorWcHuhoDwhfAPTekEOmpGng6LfMxlmbWa1sZMvhiMzVDHYjTbocf7h0Bxd5TX
	5Zg1VBbIaBP7fddOfJS6fysZP4MAVipYQCzfwbEBcRYc4U18qGoOzMtlP24C2HRTbEctrWs
	+sXRXi0b0dy1uzmbLjI8Xn9I49z924Lj4eK6SowfQS3q+2pjVwTIHd6gxE8y69f1fV+qAIH
	8EezXN0Gl5DoY7GrU8m6JZp98uSlhObPMN/PnnmtVhQqxBGu+LBGTZBlbcugZEE78QEuat0
	0VolcSblQQjbyfCKPN9zFimZDLtyG4hUgjg8wwcPuMqE9StRGw3XEWpiPa5aprFQOur+adY
	5vGssTScF2/QwWod3VY4O8+PKKUtcpHVhHI5ZHn0/A9D/AkkJL7yVzR+b9WuGkyLx2U8jh8
	OG1j30+c5vH0hVuwXxgFnG/yS9CjFmlhbJM32W/1Z/aO2kS300x9BxMT8KWSe27OWis4QTO
	hSF2px8KhIDsP8XtcANDmqbDqFN6mvwy0wzr9k7SHWTGkrlYoh5jtffpMs10nDC9ZSosbm5
	E8WtP7r4DNF1OmP/4Rn5avmiwg1WEb0OzidRcJX3SCk4jK/vJpZ+tKgj7
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Sat, Feb 15, 2025 8:52 AM, Jakub Kicinski wrote:
> On Thu, 13 Feb 2025 16:30:37 +0800 Jiawen Wu wrote:
> > Implement support for PTP clock on Wangxun NICs.
> 
> Please run:
> 
> ./scripts/kernel-doc -none -Wall drivers/net/ethernet/wangxun/*/*
> 
> Existing errors are fine, but you shouldn't be adding new ones.
> You're missing documentation for return values for a lot of functions.
> 
> Note that adding kdoc is not required, you can just remove it where
> it doesn't add value. But if you add kdoc comments they need to be
> fully specified.

OK, I'll fix it in the V8 patch set.
So what is the conclusion about the "work" item. Should I revert it to V6?


