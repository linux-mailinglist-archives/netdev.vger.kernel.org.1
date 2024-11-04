Return-Path: <netdev+bounces-141437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B6D9BAE9E
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC111F21BDD
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43C1ABEB7;
	Mon,  4 Nov 2024 08:53:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A618A6C3
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710390; cv=none; b=fKAFBvj4n+KNcWfF/FaEHwIJVFmTaxe89jeVX/zIzdtfQSKeF9PghWG/2Gjd+APBltA5HTiWRnSURkabT0x2TTmTqvjnD4tce/QqDZ++KjKc8TAMrggS/0yJmkyRLkCoJ+2kxbg7FDf+DCIGYYLOl/Ueomod0UMgDY0308mBPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710390; c=relaxed/simple;
	bh=fOKmCxycDlf7GLnm1KtEkgjsbi8WHP37Yj1Sa2CnxNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=dGxktQccl4iRAG4+t0Y3CGVYV+Mj+6SzI66zER9+C7fCEqKvMwo1GIIov54ZgqqeJWu+KvOyR8deRM4ZboPDLBNFFsBB6/XH6l30htN+WxMUF4lqww5jdG1i8QuZH/c2ZfX1xKUBFXGz4r9LoMd+7UH6mG9ucV89PtsU+/M6EAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-96-WZK9QpgdPQ-pFjUIMEnDYg-1; Mon, 04 Nov 2024 08:51:26 +0000
X-MC-Unique: WZK9QpgdPQ-pFjUIMEnDYg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Nov
 2024 08:51:25 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 4 Nov 2024 08:51:25 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michal Swiatkowski' <michal.swiatkowski@linux.intel.com>, Michal Schmidt
	<mschmidt@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pawel.chmielewski@intel.com" <pawel.chmielewski@intel.com>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"pio.raczynski@gmail.com" <pio.raczynski@gmail.com>,
	"konrad.knitter@intel.com" <konrad.knitter@intel.com>,
	"marcin.szycik@intel.com" <marcin.szycik@intel.com>,
	"wojciech.drewek@intel.com" <wojciech.drewek@intel.com>,
	"nex.sw.ncis.nat.hpm.dev@intel.com" <nex.sw.ncis.nat.hpm.dev@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [iwl-next v6 2/9] ice: devlink PF MSI-X max and
 min parameter
Thread-Topic: [Intel-wired-lan] [iwl-next v6 2/9] ice: devlink PF MSI-X max
 and min parameter
Thread-Index: AQHbLogBIclfjUnNDkKuhxeYRHRRbbKmzwWw
Date: Mon, 4 Nov 2024 08:51:25 +0000
Message-ID: <ad5bf0e312d44737a18c076ab2990924@AcuMS.aculab.com>
References: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
 <20241028100341.16631-3-michal.swiatkowski@linux.intel.com>
 <CADEbmW0=G8u7Y8L2fFTzan8S+Uz04nAMC+-dkj-rQb_izK88pg@mail.gmail.com>
 <ZyhxmxnxPcLk2ZcX@mev-dev.igk.intel.com>
In-Reply-To: <ZyhxmxnxPcLk2ZcX@mev-dev.igk.intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTWljaGFsIFN3aWF0a293c2tpDQo+IFNlbnQ6IDA0IE5vdmVtYmVyIDIwMjQgMDc6MDMN
Ci4uLg0KPiA+IFRoZSB0eXBlIG9mIHRoZSBkZXZsaW5rIHBhcmFtZXRlcnMgbXNpeF92ZWNfcGVy
X3BmX3ttaW4sbWF4fSBpcw0KPiA+IHNwZWNpZmllZCBhcyB1MzIsIHNvIHlvdSBtdXN0IHVzZSB2
YWx1ZS52dTMyIGV2ZXJ5d2hlcmUgeW91IHdvcmsgd2l0aA0KPiA+IHRoZW0sIG5vdCB2dTE2Lg0K
PiA+DQo+IA0KPiBJIHdpbGwgY2hhbmdlIGl0Lg0KDQpZb3UgYWxzbyBuZWVkIGEgcHJldHR5IGdv
b2QgcmVhc29uIHRvIHVzZSB1MTYgYW55d2hlcmUgYXQgYWxsLg0KSnVzdCBiZWNhdXNlIHRoZSBk
b21haW4gb2YgdGhlIHZhbHVlIGlzIHNtYWxsIGRvZXNuJ3QgbWVhbiB0aGUNCmJlc3QgdHlwZSBp
c24ndCBbdW5zaWduZWRdIGludC4NCg0KQW55IGFyaXRobWV0aWMgKHBhcnRpY3VsYXJseSBvbiBu
b24geDg2KSBpcyBsaWtlbHkgdG8gaW5jcmVhc2UNCnRoZSBjb2RlIHNpemUgYWJvdmUgYW55IHBl
cmNlaXZlZCBkYXRhIHNhdmluZy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


