Return-Path: <netdev+bounces-100961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F498FCA89
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED921C21BD8
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A875E14D6EF;
	Wed,  5 Jun 2024 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="Zpqxr3Y1"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7714D447
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587533; cv=pass; b=Fcw9e5IsLr9xZoWjdbmb7JDypvuP0mMJBZWZKt6xFvi+6mhuI20ujMTBgij5OyB0KfAa1Dmd5v1XZ0+JcT47ziV2DsLwd0+b2wtmoEvZBPdO8LzE2I0NKdcVRc4qwuKVqy4NBfLYk3vrWiAn8Bo/LYM1L1pNJXMsAQ0w0mwHhgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587533; c=relaxed/simple;
	bh=ql6YXHvufZfMzAloRb+7z3xZw2XfdYYf9CC7couQrYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KfivXiwdStff5AZIKzdcblP0uEWtNlo7JSopwbIa3YShzUcZo2fUigrnKilUT444V+ajtLe1l84nX/4IBpBsjfcILQiMeU0sEXGhPeUoAFP+1/gWjbwhymuEeTG/Xrh094clDNeAV4s4WSZ8Ud/5RqeHG+WVMt0jrNkEqsWk1xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=Zpqxr3Y1; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1717587526; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a7vGUycAv3rbTetYtwqjcnCLGC1gdM438KsA9NC4eXfT8tCVSdnE6WcDcMgSrLvlv0skDgr/AUQTHPaxForY2r2sEYvVpXzj2+7+w0L0ojbf00QZv6kknYQkIjGvLCrIXYm3joDPQdfjKWVDiHXHr7/WlexxM1fRjbzz5ujdYis=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1717587526; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=IRGK1XCDaIb3L1kWZThEFZFv31U7RLaVPRj4xbN+Srs=; 
	b=WcQKolkRour3ISgdML6/Ip8qD1FvqtO4jdj90qy/icVDQ21gdp513tDIc/O7VfKBtbLhp79RIuVb/OVKGek5kIRiQ6p4FSGXcrcJdtbKH9TfEPSLQ3n4rmu6yLS0Igqq6yGogHewLemwRQa8NX4GFCz+wzHaO26fJIe3UKP3cG4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1717587526;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=IRGK1XCDaIb3L1kWZThEFZFv31U7RLaVPRj4xbN+Srs=;
	b=Zpqxr3Y1d5g46MwzQBo1SRaIM54YoZ4oMr5NGsaOfW8yPbeDvh/v2hdM5lhba5AW
	wTPh6Ax7It0LxhKoNpiN5WXLhHcHr7aLS5jHJ3Ea2b+vs7kdA7vK1iAK1ZuTSMHxRaJ
	2cn3RUv7pW9pbHrW6ZiQF3iCmnR537Sz70fx9Jjrt1mOZhhB2kzQLdd8qGZ/LbARzJv
	oNsQPAigBCAsLPjFmZcHDTLq5gX5iG08U7vdWcFd49dUSc4rAc4HU0rBTusl+zRbDLn
	8qlIOFxiycZFaWDtJDvznCUlL+dnRqwRwxb+Dn8mjK33GJzHlLs1o5VBWhQjcGlaish
	yipd2lrfMg==
Received: by mx.zohomail.com with SMTPS id 171758752482068.87433388529166;
	Wed, 5 Jun 2024 04:38:44 -0700 (PDT)
Message-ID: <708b796a-6751-4c64-9ee6-4095be0b62f2@machnikowski.net>
Date: Wed, 5 Jun 2024 13:38:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] [PATCH net-next v3 0/2] netdevsim: add NAPI support
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <urn:uuid:d06a13bb-2b0d-5a01-067f-63ab4220cc82@localhost.localdomain>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <urn:uuid:d06a13bb-2b0d-5a01-067f-63ab4220cc82@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 24/04/2024 04:36, David Wei wrote:
> Add NAPI support to netdevsim and register its Rx queues with NAPI
> instances. Then add a selftest using the new netdev Python selftest
> infra to exercise the existing Netdev Netlink API, specifically the
> queue-get API.
> 
> This expands test coverage and further fleshes out netdevsim as a test
> device. It's still my goal to make it useful for testing things like
> flow steering and ZC Rx.
> 
> -----
> Changes since v2:
> * Fix null-ptr-deref on cleanup path if netdevsim is init as VF
> * Handle selftest failure if real netdev fails to change queues
> * Selftest addremove_queue test case:
>   * Skip if queues == 1
>   * Changes either combined or rx queue depending on how the netdev is
>     configured
> 
> Changes since v1:
> * Use sk_buff_head instead of a list for per-rq skb queue
> * Drop napi_schedule() if skb queue is not empty in napi poll
> * Remove netif_carrier_on() in open()
> * Remove unused page pool ptr in struct netdevsim
> * Up the netdev in NetDrvEnv automatically
> * Pass Netdev Netlink as a param instead of using globals
> * Remove unused Python imports in selftest

Hi!

This change breaks netdevsim on my setup.
Tested on Parallels ARM VM running on Mac with Fedora 40.

When using netdevsim from the latest 6.10-rc2 (and -rc1) I can't pass
any traffic (not completing any pings) nor complete
tools/testing/selftests/drivers/net/netdevsim/peer.sh test (the test
hangs at socat step trying to send anything through).

Regards
Maciek

