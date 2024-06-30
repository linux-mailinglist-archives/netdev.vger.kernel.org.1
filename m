Return-Path: <netdev+bounces-107952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 495BB91D312
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 19:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D52B203C8
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FE01527BF;
	Sun, 30 Jun 2024 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dan.merillat.org header.i=@dan.merillat.org header.b="GlJ4S8Pq"
X-Original-To: netdev@vger.kernel.org
Received: from penfold.furryhost.com (penfold.furryhost.com [199.168.187.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887305B1E0
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.168.187.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719769076; cv=none; b=Y9H9sfXtAZILrg6MvF30LnW6TlMLPJ5wM+JJBLzeMMwbcGEKjm+RN5rLXugx6YtnXkys0pY5s5cactde4/g5yANhcwAJNiIk0jVbh0qGtXRmCQxLQufM9F2nlE2QDlNeKebNCP/wqDjL/Z98v43RiCt1VSj+StuyStkiSy+ZHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719769076; c=relaxed/simple;
	bh=Wq5+2r3S6wIRgrDCKKfUxRTZlp1TNI+6xhU1nm2+Km8=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:To:Subject; b=rqKgpura1SCsWVAVQ1Bj5FGGm6uqq/nKWwVlaBzw6591ZMVTKXGs/MkXGBsG1eptP+56yZ3kdLxguYDKeyTa7YQhEMbR8w9D9AEKYNTdRWjpP0SjcbrdfqEHebDIbdlgHAbIzq/gYjGOObLhB4X3Ay7ZxKjdHUPO9wuMnkpA21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dan.merillat.org; spf=pass smtp.mailfrom=dan.merillat.org; dkim=pass (1024-bit key) header.d=dan.merillat.org header.i=@dan.merillat.org header.b=GlJ4S8Pq; arc=none smtp.client-ip=199.168.187.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dan.merillat.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dan.merillat.org
Received: from [192.168.0.10] (syn-050-088-096-145.res.spectrum.com [50.88.96.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dan@merillat.org)
	by penfold.furryhost.com (Postfix) with ESMTPSA id DEC0D217F0;
	Sun, 30 Jun 2024 13:27:08 -0400 (EDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.10 at penfold
DKIM-Filter: OpenDKIM Filter v2.11.0 penfold.furryhost.com DEC0D217F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dan.merillat.org;
	s=default; t=1719768429;
	bh=3hImxf1OXVu61h6TqD95o5EnOy7CuotWHcdZdkfVrV8=;
	h=Date:From:To:Subject:From;
	b=GlJ4S8Pq80NNOu2oz/F2hKGTz1DeVF2jl1mKtXSZZdjD2Fm80paIVLDIqel2ZQom6
	 kvFbTg2I4C5MseEGEQx9bMvXofJolskVtQjLh6oeyX7KYA/0yPPkGmQfnFpGqkLaYj
	 wJ8N+RC5S8DsgRV/pIub+6fvFlSz3BpduQ27kQvo=
Content-Type: multipart/mixed; boundary="------------KmBJbHVrA7B63hUs4UnWG4ah"
Message-ID: <54b537c6-aca4-45be-9df0-53c80a046930@dan.merillat.org>
Date: Sun, 30 Jun 2024 13:27:07 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dan Merillat <git@dan.merillat.org>
To: Michal Kubecek <mkubecek@suse.cz>, netdev <netdev@vger.kernel.org>
Subject: ethtool fails to read some QSFP+ modules.

This is a multi-part message in MIME format.
--------------KmBJbHVrA7B63hUs4UnWG4ah
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


I was testing an older Kaiam XQX2502 40G-LR4 and ethtool -m failed with netlink error.  It's treating a failure to read
the optional page3 data as a hard failure.

This patch allows ethtool to read qsfp modules that don't implement the voltage/temperature alarm data.
--------------KmBJbHVrA7B63hUs4UnWG4ah
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Some-qsfp-modules-do-not-support-page-3.patch"
Content-Disposition: attachment;
 filename="0001-Some-qsfp-modules-do-not-support-page-3.patch"
Content-Transfer-Encoding: base64

RnJvbSAzMTQ0ZmJmYzA4ZmJmYjkwZWNkYTQ4NDhmYzkzNTZiZGU4OTMzZDRhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW4gTWVyaWxsYXQgPGdpdEBkYW4uZWdpbml0eS5j
b20+CkRhdGU6IFN1biwgMzAgSnVuIDIwMjQgMTM6MTE6NTEgLTA0MDAKU3ViamVjdDogW1BB
VENIXSBTb21lIHFzZnAgbW9kdWxlcyBkbyBub3Qgc3VwcG9ydCBwYWdlIDMKClRlc3RlZCBv
biBhbiBvbGRlciBLYWlhbSBYUVgyNTAyIDQwRy1MUjQgbW9kdWxlLgpldGh0b29sIC1tIGFi
b3J0cyB3aXRoIG5ldGxpbmsgZXJyb3IgZHVlIHRvIHBhZ2UgMwpub3QgZXhpc3Rpbmcgb24g
dGhlIG1vZHVsZS4gSWdub3JlIHRoZSBlcnJvciBhbmQKbGVhdmUgbWFwLT5wYWdlXzAzaCBO
VUxMLgotLS0KIHFzZnAuYyB8IDggKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9xc2ZwLmMgYi9xc2ZwLmMK
aW5kZXggYTI5MjFmYi4uMGExNmI0MiAxMDA2NDQKLS0tIGEvcXNmcC5jCisrKyBiL3FzZnAu
YwpAQCAtMTAzNyw5ICsxMDM3LDE1IEBAIHNmZjg2MzZfbWVtb3J5X21hcF9pbml0X3BhZ2Vz
KHN0cnVjdCBjbWRfY29udGV4dCAqY3R4LAogCQlyZXR1cm4gMDsKIAogCXNmZjg2MzZfcmVx
dWVzdF9pbml0KCZyZXF1ZXN0LCAweDMsIFNGRjg2MzZfUEFHRV9TSVpFKTsKKworCS8qIFNv
bWUgbW9kdWxlcyBhcmUgcGFnZWQgYnV0IGRvIG5vdCBoYXZlIHBhZ2UgMDNoLiAgVGhpcwor
CSAqIGlzIGEgbm9uLWZhdGFsIGVycm9yLCBhbmQgc2ZmODYzNl9kb21fcGFyc2UoKSBoYW5k
bGVzIHRoaXMKKwkgKiBjb3JyZWN0bHkuCisJICovCiAJcmV0ID0gbmxfZ2V0X2VlcHJvbV9w
YWdlKGN0eCwgJnJlcXVlc3QpOwogCWlmIChyZXQgPCAwKQotCQlyZXR1cm4gcmV0OworCQly
ZXR1cm4gMDsKKwogCW1hcC0+cGFnZV8wM2ggPSByZXF1ZXN0LmRhdGEgLSBTRkY4NjM2X1BB
R0VfU0laRTsKIAogCXJldHVybiAwOwotLSAKMi40NS4xCgo=

--------------KmBJbHVrA7B63hUs4UnWG4ah--

