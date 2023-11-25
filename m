Return-Path: <netdev+bounces-51047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8BB7F8CAE
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 18:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5B7281394
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F262C84D;
	Sat, 25 Nov 2023 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="qGfDUrpJ"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93431B6;
	Sat, 25 Nov 2023 09:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700932654; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=dPhaBVAFZasjjGxq7ujaojaqxTLtmlSUMVh3qKjIbnzn6plXixbuHgN9o8IrzoQfUOHOJo+DFeLiMT3fCbPzaFLShipnYl84AdPSlps3YEwQGb76P02ititV7VV0+lh8zzFWaI9X9eV02fSmXqNyyNv9utj0EaaxGt9fuxO6n8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1700932654; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fBDLnuxTYKM5FtsGLDrQ8Mws1yikp+Htr0jXUnTb6CU=; 
	b=bC0HLIW7REAPtn5AhksSUEwk8U3M4GFw5agGIXDNY7owAI1DTKmEWShcsa332nGHtytutEwbkkzp8bbZ72tTanPjUakFhYCvrgMMUub0203B9xiqHf6gtyl4wAFqTtddEBptKNYGQp++/ByXZbAJ5Wy0xsXRddEUtQUFLhisQUU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700932654;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fBDLnuxTYKM5FtsGLDrQ8Mws1yikp+Htr0jXUnTb6CU=;
	b=qGfDUrpJHG4dvV6EDaqb1+TmZ7QBB8diSout/SOszTrc/1zuqkYeiW+Uqgu9ePB9
	aLT7OSgR0UQYe7dJCER8EDebAntIgFU7HjCcPMXsJZlHpH/05qcuCBTVii0Ym0WnzYN
	vks/Zv/dcUoDbc9pQgdPf744dabbIr48wOsSR4FU=
Received: from [192.168.1.11] (110.226.61.26 [110.226.61.26]) by mx.zoho.in
	with SMTPS id 1700932653544242.58251468981325; Sat, 25 Nov 2023 22:47:33 +0530 (IST)
Message-ID: <8aa60891-cd52-42c0-b9a2-594d69b133fd@siddh.me>
Date: Sat, 25 Nov 2023 22:47:30 +0530
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
References: <000000000000cb112e0609b419d3@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
Content-Language: en-US, en-GB, hi-IN
From: Siddh Raman Pant <code@siddh.me>
In-Reply-To: <000000000000cb112e0609b419d3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

#syz test https://github.com/siddhpant/linux.git lock

