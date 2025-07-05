Return-Path: <netdev+bounces-204275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737EAF9DAE
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 04:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7BF5448E1
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 02:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C24F26B955;
	Sat,  5 Jul 2025 02:14:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888F31BF58;
	Sat,  5 Jul 2025 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751681675; cv=none; b=IlUwHVlKcwBRyTN2fCEXCGZmAZDSwlUTmlIzBSq5pOHAu+z20waOR947uRgfVvAMaZCkygaum/XBPUKOoZYzYgid+7UMnTJPd7gU6aTMXc9SnYRIfohqNaoTVaVtqNy3JSvzpTuGgjU5SAskzmV4wcKF2YTW1uROM/sjcQaUbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751681675; c=relaxed/simple;
	bh=DnwXkV3mh2xNWLLry95sYPXozKXFK8Czxdfs07K9YpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=s3Jbg7fofPWuXEZwFM1lOCouIsIxHnk5MVHkHNsxD1csmhCDJPARMpwB1AKV3q9csOmkTbk2vLBKrrAtm+sBe2rmC8039s4Wrp2vFae1d75xMRGTzL54WFtO63vvInOMVIwLyh+Pu0u6lDuSo/tiQ4BQEBAaYSpiWkZlicPCtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.10.226.58])
	by mtasvr (Coremail) with SMTP id _____wDHRSxbimhoyH7qAw--.5558S3;
	Sat, 05 Jul 2025 10:13:48 +0800 (CST)
Received: from linma$zju.edu.cn ( [112.10.226.58] ) by
 ajax-webmail-mail-app3 (Coremail) ; Sat, 5 Jul 2025 10:13:46 +0800
 (GMT+08:00)
Date: Sat, 5 Jul 2025 10:13:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "kernel test robot" <lkp@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, mingo@kernel.org,
	tglx@linutronix.de, pwn9uin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v3] net: atm: Fix incorrect net_device lec check
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <202507050831.2GTrUnFN-lkp@intel.com>
References: <20250703052427.12626-1-linma@zju.edu.cn>
 <202507050831.2GTrUnFN-lkp@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <208fe08d.af32.197d85c6fb6.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zS_KCgD3_Ilbimho74xkAA--.19191W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwcQEmhlCw4N8wAKs6
X-CM-DELIVERINFO: =?B?jiZXnQXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHs9E3REyVLMz4DLkghFkBLqH5QYsdiIeS7um6fpDNefWi4wE3F/NAR45aDN/ORt2VyFM
	7zRxcFgotyfKCrND2Di8M1FrbpUWplBdpdkwTnOMjT390PyTZ68sFSMcKOis0w==
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr17ZrWxuw1DJr1xGFWkKrX_yoW8Wr13pa
	18JayqgrZ8Wry0ga97Ka4j9ws8t395W3sxWF15Ar15ua1DAFyDWrWIgrnxXryUKr4qg348
	KF9FgFnayw1UAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUQYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwAC
	I402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0VAYjx
	AxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU8rcTJUUUUU==

SGkgcm9ib3QsCgo+IAo+IEhpIExpbiwKPiAKPiBrZXJuZWwgdGVzdCByb2JvdCBub3RpY2VkIHRo
ZSBmb2xsb3dpbmcgYnVpbGQgZXJyb3JzOgo+IAo+IFthdXRvIGJ1aWxkIHRlc3QgRVJST1Igb24g
bmV0L21haW5dCj4gCj4gdXJsOiAgICBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwtbGFiLWxrcC9s
aW51eC9jb21taXRzL0xpbi1NYS9uZXQtYXRtLUZpeC1pbmNvcnJlY3QtbmV0X2RldmljZS1sZWMt
Y2hlY2svMjAyNTA3MDMtMTMyNzI3Cj4gYmFzZTogICBuZXQvbWFpbgo+IHBhdGNoIGxpbms6ICAg
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MDMwNTI0MjcuMTI2MjYtMS1saW5tYSU0
MHpqdS5lZHUuY24KPiBwYXRjaCBzdWJqZWN0OiBbUEFUQ0ggbmV0IHYzXSBuZXQ6IGF0bTogRml4
IGluY29ycmVjdCBuZXRfZGV2aWNlIGxlYyBjaGVjawo+IGNvbmZpZzogeDg2XzY0LXJhbmRjb25m
aWctMDc4LTIwMjUwNzA1IChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2FyY2hpdmUv
MjAyNTA3MDUvMjAyNTA3MDUwODMxLjJHVHJVbkZOLWxrcEBpbnRlbC5jb20vY29uZmlnKQo+IGNv
bXBpbGVyOiBjbGFuZyB2ZXJzaW9uIDIwLjEuNyAoaHR0cHM6Ly9naXRodWIuY29tL2xsdm0vbGx2
bS1wcm9qZWN0IDYxNDZhODhmNjA0OTJiNTIwYTM2ZjhmOGYzMjMxZTE1ZjNjYzYwODIpCj4gcmVw
cm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKTogKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBk
YXktY2kvYXJjaGl2ZS8yMDI1MDcwNS8yMDI1MDcwNTA4MzEuMkdUclVuRk4tbGtwQGludGVsLmNv
bS9yZXByb2R1Y2UpCj4gCj4gSWYgeW91IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRj
aC9jb21taXQgKGkuZS4gbm90IGp1c3QgYSBuZXcgdmVyc2lvbiBvZgo+IHRoZSBzYW1lIHBhdGNo
L2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZ3MKPiB8IFJlcG9ydGVkLWJ5OiBrZXJu
ZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4KPiB8IENsb3NlczogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDI1MDcwNTA4MzEuMkdUclVuRk4tbGtwQGludGVsLmNv
bS8KPiAKPiBBbGwgZXJyb3JzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Piwgb2xkIG9uZXMgcHJl
Zml4ZWQgYnkgPDwpOgo+IAo+ID4+IEVSUk9SOiBtb2Rwb3N0OiAiaXNfbmV0ZGV2X2xlYyIgW25l
dC9hdG0vbXBvYS5rb10gdW5kZWZpbmVkIQo+IAo+IC0tIAo+IDAtREFZIENJIEtlcm5lbCBUZXN0
IFNlcnZpY2UKPiBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvbGtwLXRlc3RzL3dpa2kKCllvdSBh
cmUgcmlnaHQsIHRoaXMgcGF0Y2gganVzdCBjb21waWxlIHdoZW4gQ09ORklHX0FUTT15IGJ1dCBy
YWlzZQplcnJvciBpZiBDT05GSUdfQVRNPW0uIEknbSBzbyBzdHVwaWQgdGhhdCBJIG1hZGUgdGhp
cyBzeW1ib2wgbWlzdGFrZSA6KAoKVW5kZXIgZml4aW5nIGl0IGN1cnJlbnRseS4KClRoYW5rcwpM
aW4KCgo=


