Return-Path: <netdev+bounces-51058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238947F8D04
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 19:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C054D2811A2
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8372DF63;
	Sat, 25 Nov 2023 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="nuW/XJFo"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206E5C5;
	Sat, 25 Nov 2023 10:18:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700936285; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=bas6VjemocG8TyCyF8HFuv/zFMao9cFMXTQ7t0cu/27MK9pCEqcIgQWVGbaR5MTM+PIyedsvn7M0bD4q5fyz2PVOhwQVnKQPDkeOqQrTg/QEYCqA1uU7CSIe4WagK7Wkbv7rnddP+fSDWhoSJe9NyQn/cpbw7SXcYzZlYtS5Sfo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1700936285; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fBDLnuxTYKM5FtsGLDrQ8Mws1yikp+Htr0jXUnTb6CU=; 
	b=QqLhrmTpThjCTY1ScEMFhXmcoEWOeOodX2HzDuHHsttvLIqb9nrN6jDDdYkU5laZNn3XRj16F6u3f7WgwpznP6qlT4sU6ne/Klflq9wkJcr2rYkXTvDT1bA3HhuetLGzT32TdjfR6yMMCSbAATgDIZqMNVfVlwLg6ng/GI5FEK4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700936285;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fBDLnuxTYKM5FtsGLDrQ8Mws1yikp+Htr0jXUnTb6CU=;
	b=nuW/XJFoL919srMjhZpfoKnhrZq7X7FZ3zg4Bj8zRsNoar9N47yt79+jjIpv8DP5
	cG+3nGvo++rwe7EX/54f5iQMP8o9nCt/pQeHwsQfmq4fTabghR0RMTxqWK4pOH9AsE1
	63ms1e8ZxrmCGzi7jjBipvUVJZbQ0YP11hlbT7gI=
Received: from [192.168.1.11] (110.226.61.26 [110.226.61.26]) by mx.zoho.in
	with SMTPS id 1700936284980449.10896378002474; Sat, 25 Nov 2023 23:48:04 +0530 (IST)
Message-ID: <f0c24608-a74a-40e3-a7b6-7dc7ca285a35@siddh.me>
Date: Sat, 25 Nov 2023 23:48:02 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000005abf1f060afd76bd@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
Content-Language: en-US, en-GB, hi-IN
From: Siddh Raman Pant <code@siddh.me>
In-Reply-To: <0000000000005abf1f060afd76bd@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

#syz test https://github.com/siddhpant/linux.git lock

