Return-Path: <netdev+bounces-72927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1CD85A2EF
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 13:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFEB1C23610
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5682C842;
	Mon, 19 Feb 2024 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpi.de header.i=@hpi.de header.b="QjOLB39L"
X-Original-To: netdev@vger.kernel.org
Received: from mail2.hpi.uni-potsdam.de (mail2.hpi.uni-potsdam.de [141.89.225.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8291E2E40D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.89.225.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344849; cv=none; b=PzaDILsd5GFTD4yAWR/G6aJiVWyyN804QDnofJGzd1L4OVZuIfy7XmeGCnMSkYyvcpF9v9lbKenAFMgNHiEmPmkdmgNjCOJY4ja5+gV5xWToTYw1De0TuOzyoG35tv4KR2VsRCTuoQAKkv13X5jWE9xoIkOIj0e+vI4JO0H+avU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344849; c=relaxed/simple;
	bh=chGrc6X+8fOUIX3A4eLtiIG/5e4QEQ4/dqqHneNYSy0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hb6tR30JJpi5UeQRfZPhtCRu6IxZCBdm/xHB5bJ8CwneI6qpr7LkGSi5MZujQ3S14CHfevUuIFt314x86nyq/pUhi/XcaNsWyABfmDlloOlvh7jn20DyxWblgS5IC2cRrYlFNp8WlDN40dJmeAUjF+gMUs1BAvMiD8pK1gJ1Uqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=student.hpi.de; spf=pass smtp.mailfrom=student.hpi.uni-potsdam.de; dkim=pass (2048-bit key) header.d=hpi.de header.i=@hpi.de header.b=QjOLB39L; arc=none smtp.client-ip=141.89.225.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=student.hpi.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.hpi.uni-potsdam.de
Received: from MX2018-DAG1.hpi.uni-potsdam.de (unknown [192.168.32.11])
	by mail2.hpi.uni-potsdam.de (Postfix) with ESMTPS id 8D1B6443E0
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 13:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hpi.de; s=201701;
	t=1708344348; bh=chGrc6X+8fOUIX3A4eLtiIG/5e4QEQ4/dqqHneNYSy0=;
	h=Date:To:From:Subject:From;
	b=QjOLB39LhBBKLo/nXpYazPMvxfzNLXCX8P/u/snZ1pqFpEXZ6Hsi1aSWA+w+FNzOd
	 v/8CgCUDFKNUO57o8y7SfJFZq4DzpoqFHc/a1VtqmwKm8XxVrAzQ8sBLY6q5sYuqAs
	 eFMufBpMv+SyJePKdkeGFDC3C+09lt5Hw9lX6on7F8VWQd8ajPO3Ukp6Le5+Lc4HWH
	 dOigOTPuDXWi6HhEJ2a1vA6U+8URSxaKNnaE3w66oIrfZo+AgjAXl0Nyn4XH4dW5+/
	 HOSjX2Rveuqfc3UBDg1UkOMx+M7o9almuhSgGD8IGbaUVP9BWL0uDdCcceYcI32pUc
	 L88FJGfoa89VQ==
Received: from [IPV6:2001:638:807:239:c0:50d4:466a:271] (141.89.225.170) by
 MX2018-DAG1.hpi.uni-potsdam.de (2001:638:807:200::b:b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Feb 2024 13:05:48 +0100
Message-ID: <5f00a1f4-6b51-4a72-979d-f8ee182edb67@student.hpi.de>
Date: Mon, 19 Feb 2024 13:05:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <netdev@vger.kernel.org>
From: Antonio Dimeo <antonio.dimeo@student.hpi.de>
Subject: ematch random/qdisc ingress handles bugs
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MX2018-DAG1.hpi.uni-potsdam.de (2001:638:807:200::b:b) To
 MX2018-DAG1.hpi.uni-potsdam.de (2001:638:807:200::b:b)

Dear all,

In the past weeks I've worked with tc on some occasions, and in the 
process I have encountered two issues which I believe may be bugs.

The iproute2 maintainer directed me here for reporting, and I do hope 
that my descriptions are helpful.
All of these behaviors were observed on a 22.04 Ubuntu, I'm uncertain to 
which tc version that maps.



First, the basic filter with ematch expressions.
The man page for tc-ematch includes a "random" attribute, described in 
the man page as a 32 bit random value, which can be compared with e.g. a 
given value, which is truncated to 32 bits. However, in my testing a 
term like

basic match "meta( random lt {boundary} ) "

let to all packets being denied, while using gt as a comparator accepted 
all packets. The filter works as expected when the random is masked 
first. A colleague who supported me in debugging the issue mentioned 
that it appeared to him that random generated 64 bits of random instead 
of the documented 32, which would explain this behavior, but due to 
other obligations I've been unable to dig deeper myself.
This effectively leads to "random" not being random, unless explicitly 
combined with a mask.


Second, I believe that ingress qdiscs may not respect assigned handles. 
I'm using code like this:

tc qdisc add dev enp0s3 handle fffa: ingress
tc qdisc show

Which results in output containing

qdisc ingress ffff: dev enp0s3 parent ffff:fff1 -----------


Until observing this behavior I would have expected the ingress qdisc to 
have the fffa handle, since I haven't seen any mention of it defaulting 
to ffff in what appeared to be the relevant man pages. However, I'm 
still not confident in my understanding of tc, so this behavior may be 
caused by user error instead.

All the best
Antonio Dimeo


