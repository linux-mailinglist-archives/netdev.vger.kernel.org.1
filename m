Return-Path: <netdev+bounces-223337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F4CB58C72
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 05:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0301B26FD2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5141624DD00;
	Tue, 16 Sep 2025 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="eSvmCvKR"
X-Original-To: netdev@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF81B0F1E
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757994020; cv=none; b=S37SEIiYkYaTcBzO3NZkVxZ3WtR/+5mn/TmQ1V4LdaRJQKvUKHIJaYuU7fANko3EvVcjafR5WFMf1zG7Ma5vFxjfppAejnFQZbISPUGcdxq0qSy52JW5oLEzY2SGwq3Lw3lGADHea/n4epMu8N9H2206Nm2ZqRusQ/nY2OcLCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757994020; c=relaxed/simple;
	bh=oyMCGO1a6aNiZMUQ7sl2/U2TykMRg4cT5rWCugmHr+M=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=jNK1FIC7BaZUyi1+mqCKc1eDe79HGnLCiQuKOJmVH/tC7e/wVaTUP2HeZn6uekGwfdU4iSSfskC1W/K68tvAVEbUUfPArcznqLI+FAOwwgIVNCEcAapzCBAukaveJOhjekLlYBQRDdlSsmmvVDiBNL85qRUFOQ3FuLRsN9vIO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=eSvmCvKR; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr6.hinet.net ([10.199.216.85])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58G3e8Jd953307
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:40:09 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757994009; bh=AJRnvz1qGhekxTJ0olJE/B+ggew=;
	h=From:To:Subject:Date;
	b=eSvmCvKRst5//DKDn/8ri6rLw81LCW7hDqlf7KVVcGJ1xYLdm+inMl9da0V441P4e
	 92qspsS/DLHY064lwhQRrWyQSrFri+09+8vaUQKeH6zDqMNym1m8ueNp7UX8viHSjh
	 ArklyeWMTLdWSCZx79o9zdfje5tQNI9TDGJUlM0g=
Received: from [127.0.0.1] (114-36-80-110.dynamic-ip.hinet.net [114.36.80.110])
	by cmsr6.hinet.net (8.15.2/8.15.2) with ESMTPS id 58G3WW3x816062
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:35:04 +0800
From: "Info - Albinayah 646" <Netdev@ms29.hinet.net>
To: netdev@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNzI0NzMgVHVlc2RheSwgU2VwdGVtYmVyIDE2LCAyMDI1IGF0IDA1OjM1OjAzIEFN?=
Message-ID: <24fd7789-7e62-c1bb-73ee-a46d35d6a6bc@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Sep 2025 03:35:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=UojANPwB c=0 sm=1 tr=0 ts=68c8dae9
	p=OrFXhexWvejrBOeqCD4A:9 a=CYLkyOAMVnx1jOyxgnWgDg==:117 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10

Hi Netdev,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading

