Return-Path: <netdev+bounces-102363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7112E902B38
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FAC1C23105
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D405142E62;
	Mon, 10 Jun 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="OA6qjiDA"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6DA76026
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056834; cv=pass; b=WmkPPMSi8uMdEvWU2mtxPy+P0hk99O41r7ryZ7evpkUmCIIJyEqLX4NvHDZr1ShY1ZsThl9pKc0jEGnlRY2CVo7WeHLXglUZWPRYEuJqOTPGEhw39hU1QPYm10MBWzle2948jMhTUWaN8f/frKtO/lOE7tKMoo5rniD3SvlasXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056834; c=relaxed/simple;
	bh=sKfHZ/qg1Rc4h0OWnen+dGyCkEU/N/2kgbelh1SfXVE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VjNs44tHZKPVPPyPU7wfgjTArGVw7yV4I3eTVRWiEwYJgaDB3ZLpdxS1lKKqIDTCfZhBspfzSMtE+9bKB3czZhMYNKIThH9NplFGz0fIocPgTyyMo7pvm5nfqZIcnLVucYHY1zlnIVTwWWUz0dwu1YGK53JOFU9JssrKZWMO2ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=OA6qjiDA; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1718056828; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LX67qSS7jMiFrh9BjyyA2IUeSa2Pg2g5WQDcUVw/ae0KGp4bLxWahFLostM7afCKISDVV+EUa4ROq/6GPBnKnOJ7TI4ezTB6sTzB5Rzt2IVa+v5ZN3kqNttw+uOpqkR6CfAWEbrEuKGhnj5yE/xA509X5qcH+6892dR3nGkk8BM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1718056828; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CLXrfSTyByipGm3k0/eSOVJWmxe0OETPD3nsGV0CWSc=; 
	b=fa6Iq0XXo2R6ctEnsDIELDHCh0e4MwntjQ58aRVp8tvg7p5Zg1IfPIeY33hC19xfU5nTi59+gtMjA04+ZsTTDdJFbe6J5e0xCeKcO9J4wYTlMO0FROaifA09k4PPvnphbjZ4wU/sGgTnBvTQN2aY5L3biZoI8XJ7M57Xtl1A/tQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1718056828;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=CLXrfSTyByipGm3k0/eSOVJWmxe0OETPD3nsGV0CWSc=;
	b=OA6qjiDAD5Myd8OlZNnUFHCFQKQuBzxuCCKcfcQlnZQBynBnGZw7UvZsJ0wW7PQ2
	Vo31LIl0lmnmVw0NJUX9MEK4d+eWBKpzbxgCQDctL7+FNbQRTm8Sz1B/LZzQTZ3kPru
	AGjLel6TDNgxaTKWTjzT5ZP9O6kJZ4kBYovD5L6rhA6uQZnfFfZgIKqZN8nlC1FkHFW
	9je9beuX3+j4XnzaeBqPlVY/FPVaD5E/uHzhe6zlQVgsE/DQo/vyCz/RWzGTgtXNKp/
	ArsW/fYCwjSQhSLZI0E7z+YK1Kpyvj/vgz0C0WTcVTM+GcCI5QgtLpPXOD+Hhlb+jwd
	nKTt8wCHzA==
Received: by mx.zohomail.com with SMTPS id 1718056826558477.3081338412985;
	Mon, 10 Jun 2024 15:00:26 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [BUG] [PATCH net-next v3 0/2] netdevsim: add NAPI support
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <a8ac00ed-4ec1-4adf-ad37-2efa1681847d@davidwei.uk>
Date: Tue, 11 Jun 2024 00:00:12 +0200
Cc: Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <58F03FAF-855C-4938-A97D-55587A0E2E14@machnikowski.net>
References: <urn:uuid:d06a13bb-2b0d-5a01-067f-63ab4220cc82@localhost.localdomain>
 <708b796a-6751-4c64-9ee6-4095be0b62f2@machnikowski.net>
 <a8ac00ed-4ec1-4adf-ad37-2efa1681847d@davidwei.uk>
To: David Wei <dw@davidwei.uk>
X-Mailer: Apple Mail (2.3774.600.62)
X-ZohoMailClient: External



> On 6 Jun 2024, at 16:31, David Wei <dw@davidwei.uk> wrote:
> 
> On 2024-06-05 12:38, Maciek Machnikowski wrote:
>> 
>> 
>> On 24/04/2024 04:36, David Wei wrote:
>>> Add NAPI support to netdevsim and register its Rx queues with NAPI
>>> instances. Then add a selftest using the new netdev Python selftest
>>> infra to exercise the existing Netdev Netlink API, specifically the
>>> queue-get API.
>>> 
>>> This expands test coverage and further fleshes out netdevsim as a test
>>> device. It's still my goal to make it useful for testing things like
>>> flow steering and ZC Rx.
>>> 
>>> -----
>>> Changes since v2:
>>> * Fix null-ptr-deref on cleanup path if netdevsim is init as VF
>>> * Handle selftest failure if real netdev fails to change queues
>>> * Selftest addremove_queue test case:
>>>  * Skip if queues == 1
>>>  * Changes either combined or rx queue depending on how the netdev is
>>>    configured
>>> 
>>> Changes since v1:
>>> * Use sk_buff_head instead of a list for per-rq skb queue
>>> * Drop napi_schedule() if skb queue is not empty in napi poll
>>> * Remove netif_carrier_on() in open()
>>> * Remove unused page pool ptr in struct netdevsim
>>> * Up the netdev in NetDrvEnv automatically
>>> * Pass Netdev Netlink as a param instead of using globals
>>> * Remove unused Python imports in selftest
>> 
>> Hi!
>> 
>> This change breaks netdevsim on my setup.
>> Tested on Parallels ARM VM running on Mac with Fedora 40.
>> 
>> When using netdevsim from the latest 6.10-rc2 (and -rc1) I can't pass
>> any traffic (not completing any pings) nor complete
>> tools/testing/selftests/drivers/net/netdevsim/peer.sh test (the test
>> hangs at socat step trying to send anything through).
> 
> Hi Maciek, I'm trying to reproduce the issue.
> 
> Can you please share how you're setting up netdevsim to pass traffic?

I modified peer.sh to stop after creating and linking two netdevsim adapters
and then ran the ping from one namespace to another. The same script
and procedure worked fine when running 6.9.3, but failed with any 6.10-rc
releases. And the only delta between these two netdevsims is this patch.



