Return-Path: <netdev+bounces-71232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF7D852C24
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2118B21912
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6F2210E4;
	Tue, 13 Feb 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wG8G0Rg0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC19210FE
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815899; cv=none; b=kOG5BPugyDDNrKCg4MeDgRTfbcT8r18VSLy9gvAtkYP/Uqt94e1hXDc89LzlQIg2ZSML1yYph2DGcCmLpGSUWViVEG4NynEP/yUjM45Ilaek7E5kA5mZNHeN8XDvryhvTcgpDuCl/i23Z+V8lBuVAkG9Cn/aP5NTpdec6lwROus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815899; c=relaxed/simple;
	bh=MSDp//DB1JdtAdZqWc0Af8oLFpxYp4qzXB7Wf8BYknY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDKR4MGE79wJPwJMKtR/b3MqRZMqUjh4GkH6/S4f+yVyUeRwkWCVvq8lMP3covEugSL4wW6tSdS12ZMnYkN8Y/tDiUDe6mn3/Bap4CdyRJIhFjo3DsAMdvYS3PJsw3cGgif1FVkheWMVMn1MJpvhZ307kOK01rIIIedXoBrSuyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=wG8G0Rg0; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707815898; x=1739351898;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=MSDp//DB1JdtAdZqWc0Af8oLFpxYp4qzXB7Wf8BYknY=;
  b=wG8G0Rg04WsAgKpJgO9n38amEiZNupxSCLHVV8u0c2EzMtQfJ0eTMrb9
   dw8RNofS6mso1Q0C2TPiK3eEKHDxSVzHDsgqowqQFu8fswWgf+93PQXlm
   /xWrWS3eaq07leDfQk6KaLLdpSCAbGHWUPpMUO5srkcYKsFLEVP8lZZph
   0=;
X-IronPort-AV: E=Sophos;i="6.06,156,1705363200"; 
   d="scan'208";a="612699400"
Subject: RE: [PATCH net-next] net: ena: Remove redundant assignment
Thread-Topic: [PATCH net-next] net: ena: Remove redundant assignment
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 09:18:16 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:22670]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.48:2525] with esmtp (Farcaster)
 id f499020e-4a6e-40f5-b0c5-5aa0c444aec9; Tue, 13 Feb 2024 09:18:14 +0000 (UTC)
X-Farcaster-Flow-ID: f499020e-4a6e-40f5-b0c5-5aa0c444aec9
Received: from EX19D047EUA003.ant.amazon.com (10.252.50.160) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 09:18:14 +0000
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D047EUA003.ant.amazon.com (10.252.50.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 09:18:14 +0000
Received: from EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d]) by
 EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d%3]) with mapi id
 15.02.1118.040; Tue, 13 Feb 2024 09:18:14 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Brett Creeley <bcreeley@amd.com>, Kamal Heib <kheib@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: "Agroskin, Shay" <shayagr@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>
Thread-Index: AQHaXit3eGz/lD7gI0igsUIfxvNeAbEHqNIAgABU+GA=
Date: Tue, 13 Feb 2024 09:18:07 +0000
Deferred-Delivery: Tue, 13 Feb 2024 09:17:54 +0000
Message-ID: <3357edcdcafb4ce3aa36c6176d2352d6@amazon.com>
References: <20240213031718.2270350-1-kheib@redhat.com>
 <b6bc5d27-c0e8-4292-a49b-5d5d609a5d60@amd.com>
In-Reply-To: <b6bc5d27-c0e8-4292-a49b-5d5d609a5d60@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnJldHQgQ3JlZWxleSA8
YmNyZWVsZXlAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTMsIDIwMjQgNjox
MSBBTQ0KPiBUbzogS2FtYWwgSGVpYiA8a2hlaWJAcmVkaGF0LmNvbT47IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IERhdmlkIFMgLg0KPiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBKYWt1
YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBDYzogQWdyb3NraW4sIFNoYXkgPHNoYXlh
Z3JAYW1hem9uLmNvbT47IEFyaW56b24sIERhdmlkDQo+IDxkYXJpbnpvbkBhbWF6b24uY29tPg0K
PiBTdWJqZWN0OiBSRTogW0VYVEVSTkFMXSBbUEFUQ0ggbmV0LW5leHRdIG5ldDogZW5hOiBSZW1v
dmUgcmVkdW5kYW50DQo+IGFzc2lnbm1lbnQNCj4gDQo+IENBVVRJT046IFRoaXMgZW1haWwgb3Jp
Z2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrDQo+
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2Vu
ZGVyIGFuZCBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+IE9uIDIv
MTIvMjAyNCA3OjE3IFBNLCBLYW1hbCBIZWliIHdyb3RlOg0KPiA+IENhdXRpb246IFRoaXMgbWVz
c2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+IGNh
dXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9u
ZGluZy4NCj4gPg0KPiA+DQo+ID4gVGhlcmUgaXMgbm8gcG9pbnQgaW4gaW5pdGlhbGl6aW5nIGFu
IG5kbyB0byBOVUxMLCB0aGVyZWZvciB0aGUNCj4gPiBhc3NpZ25tZW50IGlzIHJlZHVuZGFudCBh
bmQgY2FuIGJlIHJlbW92ZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW1hbCBIZWliIDxr
aGVpYkByZWRoYXQuY29tPg0KPiANCj4gDQo+IFJldmlld2VkLWJ5OiBCcmV0dCBDcmVlbGV5IDxi
cmV0dC5jcmVlbGV5QGFtZC5jb20+DQo+IA0KDQpUaGFua3MgZm9yIHN1Ym1pdHRpbmcgdGhpcyBj
b21taXQuDQoNCk5pdDogdGhlcmZvcj0+dGhlcmVmb3JlDQoNCk90aGVyd2lzZSwNCg0KQWNrZWQt
Ynk6IEFydGh1ciBLaXlhbm92c2tpIDxha2l5YW5vQGFtYXpvbi5jb20+DQo=

