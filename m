Return-Path: <netdev+bounces-199907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7938AE219A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A4B3A1DF1
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E7C2E2657;
	Fri, 20 Jun 2025 17:52:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CF81E2606;
	Fri, 20 Jun 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.128.96.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441932; cv=none; b=tdGukG+47RegtISzCjiMEwSZUc2o0I8XAdRfayERCnqjADxVMiLWQ7MIXeOjvCme3OgCr9b44MG5yJYMiV+GYHe/XycqHZFFk2sjrzW1uIiLidHxf6/qPagYfvyFrIXaV8TjpR8O3evHFvZJlTYpQn+4L1foS/cC9vlPvywFPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441932; c=relaxed/simple;
	bh=Dy+p15HC9zP/n/4KM5eMWzVkPkNU3THZSPGOgrzcbL0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gJ15V3E4rkeanFpc/q68putI6teA3G/j/jK0RYZ9ZA2I3yDw3jyIrjsZrm3voTxX+JTo/+r+3E+kn284yba2y0bCQxsgvvinRI6iOT1ZnePqa9eChATZ3f9ItsAS5NWp4nbGf4cpe734lIwSaxL8n5+uh0OyVeH90syLKPXU0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net; spf=none smtp.mailfrom=davemloft.net; arc=none smtp.client-ip=23.128.96.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davemloft.net
Received: from localhost (brnt-05-b2-v4wan-161083-cust293.vm7.cable.virginm.net [86.11.207.38])
	by mail.monkeyblade.net (Postfix) with ESMTPSA id EFA01841F1AE;
	Fri, 20 Jun 2025 10:52:06 -0700 (PDT)
Date: Fri, 20 Jun 2025 18:52:02 +0100 (BST)
Message-Id: <20250620.185202.1877972778102559754.davem@davemloft.net>
To: arnd@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, arnd@arndb.de, horms@kernel.org, linux@treblig.org,
 aleksandr.loktionov@intel.com, dawid.osuchowski@linux.intel.com,
 jedrzej.jagielski@intel.com, mateusz.polchlopek@intel.com,
 piotr.kwapulinski@intel.com, slawomirx.mrozowicz@intel.com,
 martyna.szapar-mudlaw@linux.intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ethernet: intel: fix building with large NR_CPUS
From: David Miller <davem@davemloft.net>
In-Reply-To: <20250620173158.794034-1-arnd@kernel.org>
References: <20250620173158.794034-1-arnd@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 20 Jun 2025 10:52:10 -0700 (PDT)

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwub3JnPg0KRGF0ZTogRnJpLCAyMCBKdW4g
MjAyNSAxOTozMToyNCArMDIwMA0KDQo+IEZyb206IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+DQo+IA0KPiBXaXRoIGxhcmdlIHZhbHVlcyBvZiBDT05GSUdfTlJfQ1BVUywgdGhyZWUgSW50
ZWwgZXRoZXJuZXQgZHJpdmVycyBmYWlsIHRvDQo+IGNvbXBpbGUgbGlrZToNCj4gDQo+IEluIGZ1
bmN0aW9uIKFpNDBlX2ZyZWVfcV92ZWN0b3KiLA0KPiAgICAgaW5saW5lZCBmcm9tIKFpNDBlX3Zz
aV9hbGxvY19xX3ZlY3RvcnOiIGF0IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQw
ZV9tYWluLmM6MTIxMTI6MzoNCj4gICA1NzEgfCAgICAgICAgIF9jb21waWxldGltZV9hc3NlcnQo
Y29uZGl0aW9uLCBtc2csIF9fY29tcGlsZXRpbWVfYXNzZXJ0XywgX19DT1VOVEVSX18pDQo+IGlu
Y2x1ZGUvbGludXgvcmN1cGRhdGUuaDoxMDg0OjE3OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFj
cm8goUJVSUxEX0JVR19PTqINCj4gIDEwODQgfCAgICAgICAgICAgICAgICAgQlVJTERfQlVHX09O
KG9mZnNldG9mKHR5cGVvZigqKHB0cikpLCByaGYpID49IDQwOTYpOyAgICBcDQo+IGRyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmM6NTExMzo5OiBub3RlOiBpbiBleHBh
bnNpb24gb2YgbWFjcm8goWtmcmVlX3JjdaINCj4gIDUxMTMgfCAgICAgICAgIGtmcmVlX3JjdShx
X3ZlY3RvciwgcmN1KTsNCj4gICAgICAgfCAgICAgICAgIF5+fn5+fn5+fg0KPiANCj4gVGhlIHBy
b2JsZW0gaXMgdGhhdCB0aGUgJ3JjdScgbWVtYmVyIGluICdxX3ZlY3RvcicgaXMgdG9vIGZhciBm
cm9tIHRoZSBzdGFydA0KPiBvZiB0aGUgc3RydWN0dXJlLiBNb3ZlIHRoaXMgbWVtYmVyIGJlZm9y
ZSB0aGUgQ1BVIG1hc2sgaW5zdGVhZCwgaW4gYWxsIHRocmVlDQo+IGRyaXZlcnMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiAtLS0NCj4gdjI6
IG1vdmUgcmN1IHRvIGp1c3QgYWZ0ZXIgdGhlIG5hcGlfc3RydWN0IFtBbGV4YW5kZXIgTG9iYWtp
bl0NCg0KQWNrZWQtYnk6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4NCg==

