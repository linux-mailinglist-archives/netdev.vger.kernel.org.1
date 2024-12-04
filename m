Return-Path: <netdev+bounces-148981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04BC9E3B49
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E07285147
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE3B1B6D1B;
	Wed,  4 Dec 2024 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rebagfactory.vip header.i=@rebagfactory.vip header.b="DHUP4tzB"
X-Original-To: netdev@vger.kernel.org
Received: from static195-132.de.dm.aliyun.com (static195-132.de.dm.aliyun.com [47.245.195.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E27194C67
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.245.195.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319076; cv=none; b=DrMgXEtyfLA5hmsR3B7BJmG3Hj8+ivsbw3R0tlPqKOMVuAesRQfTnN+Cr2NoBIvME2djTCCfwXYLNJSXvT+Ks9hUs1r2x32aIi7DwPns7M+Qz8S6Z/M/PzBwXUagSzEVnFjVLz855KGLaYY+zFAqK/SYKUVV3wpAwpQXqzf4e/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319076; c=relaxed/simple;
	bh=xidDK/6IHGOKsnH15m+2xrDxjSQNiRb14+A6BgRVsGE=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=MkhnQrObZUtUnhYplN6pXHaGB0w8go7/V7029AKzHp3tbOFrsZbCqqtaVz/aWJ8cbqUrSEiI+1T7MFfgRBzIiIOOZ4aEsBq5PN0+8E3BHl2l550Q2qoF6HtAU5hfklsD+Cy4jCyQuYdc/q+TNsgK71mb3yEsbbKCkNlpL9nfiLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rebagfactory.vip; spf=pass smtp.mailfrom=rebagfactory.vip; dkim=pass (1024-bit key) header.d=rebagfactory.vip header.i=@rebagfactory.vip header.b=DHUP4tzB; arc=none smtp.client-ip=47.245.195.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rebagfactory.vip
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rebagfactory.vip
X-AliDM-RcptTo: bmV0ZGV2QHZnZXIua2VybmVsLm9yZw==
Feedback-ID: default:jessie@rebagfactory.vip:batch:27908
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=rebagfactory.vip; s=aliyun-eu-central-1;
	t=1733319068; h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type;
	bh=xidDK/6IHGOKsnH15m+2xrDxjSQNiRb14+A6BgRVsGE=;
	b=DHUP4tzBW5zZFcxzoA+H/EzhGWp4aoqJ5pqZJi5egNyBCt8rtdOjhoM3pEjWiJVUElKncYwexhUQjPPAW6e8XRDqOsaOmz473ZXJFn3tTPwX5bJz9h1tlcdzkrEXcQ4fevXPoLVU4FWm7ySw2YKLHTEGB/A9vKM4FiGAMCbAGog=
Received: from LocalHost(mailfrom:jessie@rebagfactory.vip fp:SMTPD_-----6KO4PN cluster:dm-ay35de-a)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Dec 2024 21:25:23 +0800
X-EnvId: 8965875418
Message-ID: <587631091877BA2717C948B0F7A72A4274FE80499@REBAGFACTORY.VIP>
From: "Jessie" <jessie@rebagfactory.vip>
Reply-To: <info@rebag.cn>
To: <netdev@vger.kernel.org>
Subject: Rebag: what's your category goal in 2025?
Date: Wed, 4 Dec 2024 15:58:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Priority: 3
X-Mailer: Joinf MailSystem 8.0
Content-Type: text/plain;
	charset="utf-8"

UmVzcGVjdGVkIFNpci9NYWRhbSwgDQoNCg0KUmViYWcgZmFjdG9yeSBob3BlIGZpbmQgeW91IHZl
cnkgd2VsbC4gU21pbGUgOiApDQoNCkluIHRoZXNlIGRheXMgd2UgYXJlIGRldmVsb3BwaW5nIHNv
bWUgc3R5bGVzIG9mIGZpcnN0IGFpZCBiYWcgYW5kIG1lZGljYWwgYmFncyBmb3IgYSBmZXcgb2Yg
Y3VzdG9tZXJzLCANCmFuZCB0aGUgZmVlZGJhY2sgc2VlbXMgZ3JlYXQsIHNvIHdlJ2QgbGlrZSB0
byBrZWVwIHlvdSBhbHNvIHVwZGF0ZWQgZm9yIHRoaXMgaXRlbSwgaWYgeW91IGFyZSBpbnRlcmVz
dGVkDQp0byBhZGQgdGhlbSBpbnRvIHlvdXIgY2F0YWxvZ3VlLCBwbGVhc2UgZmVlbCBmcmVlIGxl
dCB1cyBrbm93LlRoYW5rcyBpbiBhZHZhbmNlfiENCg0KQXR0YWNoZWQgeW91IHdpbGwgZmluZCBp
bWFnZSBmcm9tIG91ciBCU0NJIGF1ZGl0IGZhY3RvcnksIHRoYW5rcyBpbiBhZHZhbmNlIGFuZCBI
YXZlIGEgbmljZSBkYXkhIA0KUmVnYXJkcw0KDQoNClAuUywgd2UgZm91bmQgdGhhdCBzb21lIG9m
IG91ciB2YWx1ZWQgY2xpZW50cyBzZWVtcyBkaWQgbm90IHRvdGFsbHkga25vdyB0aGUgYmFnIGl0
ZW1zIHdlIHByb2R1Y2VkLCANCmFuZCB5b3UgY291bGQgY2hlY2sgdGhlbSBieSBvdXIgdXBkYXRl
ZCBob21lIHBhZ2UgbGlua2VkIGJsZW93IHRoZSBhZGRyZXNzLiBNYW55IHRoYW5rcyEgDQoNCg0K
U2hlaWxhIChzYWxlIGFzc2lzdGFuY2UpDQoNCg0KUkVCQUcNCg0KTm8uIDE4MSBKaWFuZ05hbiBT
dHJlZXQgVmlsbGFnZSwNCkZvdGFuZyBUb3duIFlpd3UsIDMyMjAwMC5DTi4NClRFTDogKzg2IDA1
NzkgODU1OTU5MDANCkZBWDogKzg2IDA1NzkgODUwMzkyODANCnd3dy5yZWJhZy5jbg==

