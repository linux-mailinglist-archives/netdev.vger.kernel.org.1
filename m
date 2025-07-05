Return-Path: <netdev+bounces-204276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6970AAF9E05
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 05:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD82F7AF099
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5821026C381;
	Sat,  5 Jul 2025 03:04:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40920D4F8;
	Sat,  5 Jul 2025 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751684678; cv=none; b=LPRDJmhWK6mmrw3cIGEJDIWQPWc6MTtds8CXG7qlC8fz4TI7svqxOWwJU6+ZzJ+QdSilx5ZNAr1a+XN+CwyhVc/Zqou1rSITmNJUSAw7fYVioBMtU7OohgBC0Y5dqlavG/tq3lRE3sV6uFTfLHs9UPo448k4wuy2+ZaoQ+4SABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751684678; c=relaxed/simple;
	bh=zwXjia0ZMQwWaaTuWEiF3YRzWzsjoWyb2njGQWUYGn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Ex5ryxlFCd8zVxAHUbA8FbEdGBgDnXqFW3wyOmZbLVCfWJKBwWHDEX0WRZ5NeqWw0BcCzsc5ad2xzo+gYOdB9E5rd1EqJa1E6neVx5Cu7B3pX0CNuw9eJ65yiSue7atb75jtqWIPjXEEq3kYlj0DyNXZolaI1KB4/Wf5cXeAONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.67.119])
	by mtasvr (Coremail) with SMTP id _____wBXXdwilmhoWr3qAw--.5988S3;
	Sat, 05 Jul 2025 11:04:03 +0800 (CST)
Received: from linma$zju.edu.cn ( [10.190.67.119] ) by
 ajax-webmail-mail-app1 (Coremail) ; Sat, 5 Jul 2025 11:04:02 +0800
 (GMT+08:00)
Date: Sat, 5 Jul 2025 11:04:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Simon Horman" <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mingo@kernel.org, tglx@linutronix.de,
	pwn9uin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: atm: Fix incorrect net_device lec check
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <20250704190128.GB356576@horms.kernel.org>
References: <20250703052427.12626-1-linma@zju.edu.cn>
 <20250704190128.GB356576@horms.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5c66d883.a83f.197d88a76c4.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yy_KCgBXF2IilmhoQ75rAA--.16537W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwQSEmhnrg4GVwADs6
X-CM-DELIVERINFO: =?B?xMG4SAXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHjQvNycrgoTwHXPMldsw/+RAtuZ4QGOhozV7SXDWkNylrO2+sck1Pcs1QST2M1wo7yiR
	7PXIWVw0tNIUhab/ZNoeAKkRtebu8swVQWrXJ5F+qJBoKCWkccKImELJaYKs0w==
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1UtrWUXFyrWw4xKFW3urX_yoW8Zw13pa
	1Y9a98KF4kG3yv9w47ZF10va4akw4xJw48GFy5Ga4jg3s0qr97ArW0ka15u3WUtrWfZFyY
	vF4jqryS93s3AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0VAYjx
	AxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU8rcTJUUUUU==

SGkgU2ltb24sCgo+IENhbiBzdGFydF9tcGMoKSBydW4gb24gZGV2IGJlZm9yZSB0aGlzIGZ1bmN0
aW9uIGlzIGNhbGxlZD8KPiBJZiBzbywgZG9lcyB0aGUgY2hlY2sgYWJvdmUgc3RpbGwgd29yayBh
cyBleHBlY3RlZD8KCkdyZWF0IHBvaW50LiBJIGZvdW5kIHR3byBsb2NhdGlub3MgdGhhdCBjYWxs
IHN0YXJ0X21wYygpLiBPbmUKaXMgYXRtX21wb2FfbXBvYWRfYXR0YWNoKCkgYW5kIHRoZSBvdGhl
ciBpcyBtcG9hX2V2ZW50X2xpc3RlbmVyKCkuCgpTaW5jZSB0aGlzIHBhdGNoIGNvdmVycyB0aGVz
ZSB0d28gZnVuY3Rpb25zLCBJIGJlbGlldmUgc3RhcnRfbXBjKCkKcnVuIGFmdGVyIHRoZSBjaGVj
ay4KCkhvd2V2ZXIsIHNpbmNlIHN0YXJ0X21wYygpIGluZGVlZCByZXBsYWNlcyB0aGUgbmV0ZGV2
X29wcy4gSXQgc2VlbXMKcXVpdGUgZXJyb3ItcHJvbmUgdG8gcGVyZm9ybSB0eXBlIGNoZWNraW5n
IHVzaW5nIHRoYXQgZmllbGQuIE1vcmVvdmVyLAp0aGlzIHBhdGNoIHJhaXNlcyBhIGxpbmtpbmcg
ZXJyb3IgYXMgc2hvd24gaW4KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8y
MDI1MDcwNTA4MzEuMkdUclVuRk4tbGtwQGludGVsLmNvbS8uCkhlbmNlLCBJIHdpbGwgcHJlcGFy
ZSB2ZXJzaW9uIDQgYW5kIHRyeSB0byB0aGluayBhYm91dCBvdGhlciBzb2x1dGlvbnMuCgo+Cj4g
MSkgSXMgdGhpcyBjb2RlIHBhdGggcmVhY2hhYmxlIGJ5IG5vbi1sZWMgZGV2aWNlcz8KPgoKWWVz
LCB0aG91Z2ggdGhlIG1wb2FfZXZlbnRfbGlzdGVuZXIoKSBpcyByZWdpc3RlcmVkIGZvciB0aGUg
bmV0L21wYyBtb2R1bGUsCnRoZSBub3RpZmllcl9ibG9jayBjYWxscyBldmVyeSByZWdpc3RlcmVk
IGxpc3RlbmVyLgoKLyoqIC4uLi4KICogIENhbGxzIGVhY2ggZnVuY3Rpb24gaW4gYSBub3RpZmll
ciBjaGFpbiBpbiB0dXJuLiAgVGhlIGZ1bmN0aW9ucwogKiAgcnVuIGluIGFuIHVuZGVmaW5lZCBj
b250ZXh0LgogKiAgQWxsIGxvY2tpbmcgbXVzdCBiZSBwcm92aWRlZCBieSB0aGUgY2FsbGVyLgog
KiAgLi4uCiAqLwppbnQgcmF3X25vdGlmaWVyX2NhbGxfY2hhaW4oc3RydWN0IHJhd19ub3RpZmll
cl9oZWFkICpuaCwKICAgICAgICB1bnNpZ25lZCBsb25nIHZhbCwgdm9pZCAqdikKCkluIGFub3Ro
ZXIgd29yZCwgZXZlcnkgcmVnaXN0ZXJlZCBsaXN0ZW5lciBpcyByZWFjaGFibGUgYW5kIGlzIHJl
c3BvbnNpYmxlCmZvciBkZXRlcm1pbmluZyB3aGV0aGVyIHRoZSBldmVudCBpcyByZWxldmFudCB0
byB0aGVtLiBBbmQgdGhhdCBpcyB3aHkgd2UKc2hvdWxkIGFkZCBhIHR5cGUgY2hlY2sgaGVyZS4K
Cj4gMikgQ2FuIHRoZSBuYW1lIG9mIGEgbGVjIGRldmljZSBiZSBjaGFuZ2VkPwogICBJZiBzbywg
ZG9lcyBpdCBjYXVzZSBhIHByb2JsZW0gaGVyZT8KClRvIG15IGtub3dsZWRnZSwgdGhlIGNoYW5n
aW5nIG9mIGEgbmV0X2RldmljZSBuYW1lIGlzIGhhbmRsZWQgaW4KbmV0L2NvcmUvZGV2LmMsIHdo
aWNoIGlzIGEgZ2VuZXJhbCBmdW5jdGlvbmFsaXR5IHRoYXQgYW4gaW5kaXZpZHVhbCBkcml2ZXIK
Y2Fubm90IGludGVydmVuZS4KCmludCBfX2Rldl9jaGFuZ2VfbmV0X25hbWVzcGFjZShzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2LCBzdHJ1Y3QgbmV0ICpuZXQsCiAgICAgICAgICAgICAgICAgICBjb25z
dCBjaGFyICpwYXQsIGludCBuZXdfaWZpbmRleCkKewogICAgLi4uCiAgICAgICAgaWYgKG5ld19u
YW1lWzBdKSAvKiBSZW5hbWUgdGhlIG5ldGRldiB0byBwcmVwYXJlZCBuYW1lICovCiAgICAgICAg
c3Ryc2NweShkZXYtPm5hbWUsIG5ld19uYW1lLCBJRk5BTVNJWik7CiAgICAuLi4KfQoKTmljZSBj
YXRjaC4KSWYgYSB1c2VyIGNoYW5nZXMgYSBsZWMgZGV2aWNlIG5hbWUgdG8gc29tZXRoaW5nIGVs
c2UgdGhhdCBpcyBub3QKcHJlZml4ZWQgd2l0aCAibGVjIiwgaXQgY2F1c2VzIGZ1bmN0aW9uYWxp
dHkgaXNzdWVzLCBhcyBldmVudHMKbGlrZSBORVRERVZfVVAvRE9XTiBjYW5ub3QgcmVhY2ggdGhl
IGlubmVyIGxvZ2ljLgoKVGhhdCB3aWxsIGJlIGFub3RoZXIgcmVhc29uIHRvIGFkb3B0IGEgZml4
LgoKUmVnYXJkcwpMaW4K


