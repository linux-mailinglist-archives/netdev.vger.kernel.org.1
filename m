Return-Path: <netdev+bounces-52963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D79800EE9
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEDE28100A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31164BA80;
	Fri,  1 Dec 2023 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s3koMnr6"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7343F1A6
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 08:01:45 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1G1XSY072187;
	Fri, 1 Dec 2023 10:01:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1701446493;
	bh=J18vovuYFe3+ePZ5T+hOH80JZjzvurmDXMaV4oeJIM4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=s3koMnr6dfbGP4bZ7gD83knyIzJEz//frjEf+99s79noEUGU/O1TWXgrks6hZ9OEK
	 Y7c4UDDRKuYz4TMJK5HtZKQt0dsc6wd2WwT1z+ANy9oRQq2WnRTbVJQalEmgOBsH+0
	 VgOS/e001iagSNtGJGVdyXwUWND4slvoaK/olm48=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1G1Xn1038132
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Dec 2023 10:01:33 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 10:01:33 -0600
Received: from DFLE105.ent.ti.com ([fe80::48d3:ae6d:c4d6:9f16]) by
 DFLE105.ent.ti.com ([fe80::48d3:ae6d:c4d6:9f16%17]) with mapi id
 15.01.2507.023; Fri, 1 Dec 2023 10:01:33 -0600
From: "Varis, Pekka" <p-varis@ti.com>
To: Roger Quadros <rogerq@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
CC: "Vadapalli, Siddharth" <s-vadapalli@ti.com>,
        "Gunasekaran, Ravi"
	<r-gunasekaran@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "Govindarajan, Sriramakrishnan" <srk@ti.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH v7 net-next 6/8] net: ethernet: ti:
 am65-cpsw-qos: Add Frame Preemption MAC Merge support
Thread-Topic: [EXTERNAL] [PATCH v7 net-next 6/8] net: ethernet: ti:
 am65-cpsw-qos: Add Frame Preemption MAC Merge support
Thread-Index: AQHaJF6A2qL9iga+FEuH0ihhNOzKfLCUlOkg
Date: Fri, 1 Dec 2023 16:01:33 +0000
Message-ID: <c773050ad0534fb3a5a9edcf5302d297@ti.com>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
In-Reply-To: <20231201135802.28139-7-rogerq@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9nZXIgUXVhZHJvcyA8
cm9nZXJxQGtlcm5lbC5vcmc+DQo+IA0KPiBBZGQgZHJpdmVyIHN1cHBvcnQgZm9yIHZpZXdpbmcg
LyBjaGFuZ2luZyB0aGUgTUFDIE1lcmdlIHN1YmxheWVyDQo+IHBhcmFtZXRlcnMgYW5kIHNlZWlu
ZyB0aGUgdmVyaWZpY2F0aW9uIHN0YXRlIG1hY2hpbmUncyBjdXJyZW50IHN0YXRlIHZpYQ0KPiBl
dGh0b29sLg0KPiANCj4gQXMgaGFyZHdhcmUgZG9lcyBub3Qgc3VwcG9ydCBpbnRlcnJ1cHQgbm90
aWZpY2F0aW9uIGZvciB2ZXJpZmljYXRpb24gZXZlbnRzDQo+IHdlIHJlc29ydCB0byBwb2xsaW5n
IG9uIGxpbmsgdXAuIE9uIGxpbmsgdXAgd2UgdHJ5IGEgY291cGxlIG9mIHRpbWVzIGZvcg0KPiB2
ZXJpZmljYXRpb24gc3VjY2VzcyBhbmQgaWYgdW5zdWNjZXNzZnVsIHRoZW4gZ2l2ZSB1cC4NCj4g
DQo+IFRoZSBGcmFtZSBQcmVlbXB0aW9uIGZlYXR1cmUgaXMgZGVzY3JpYmVkIGluIHRoZSBUZWNo
bmljYWwgUmVmZXJlbmNlDQo+IE1hbnVhbCBbMV0gaW4gc2VjdGlvbjoNCj4gCTEyLjMuMS40LjYu
NyBJbnRlcnNwZXJjZWQgRXhwcmVzcyBUcmFmZmljIChJRVQg4oCTIFA4MDIuM2JyL0QyLjApDQo+
IA0KPiBEdWUgdG8gU2lsaWNvbiBFcnJhdGEgaTIyMDggWzJdIHdlIHNldCBsaW1pdCBtaW4gSUVU
IGZyYWdtZW50IHNpemUgdG8gMTI0Lg0KDQpTaG91bGQgYmUgMTI4IG5vdCAxMjQNCg0KPiANCj4g
WzFdIEFNNjJ4IFRSTSAtIGh0dHBzOi8vd3d3LnRpLmNvbS9saXQvdWcvc3BydWl2N2Evc3BydWl2
N2EucGRmDQo+IFsyXSBBTTYyeCBTaWxpY29uIEVycmF0YSAtIGh0dHBzOi8vd3d3LnRpLmNvbS9s
aXQvZXIvc3ByejQ4N2Mvc3ByejQ4N2MucGRmDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBR
dWFkcm9zIDxyb2dlcnFAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5l
dC90aS9hbTY1LWNwc3ctZXRodG9vbC5jIHwgMTU3ICsrKysrKysrKysrKysrKysrKw0KPiAgZHJp
dmVycy9uZXQvZXRoZXJuZXQvdGkvYW02NS1jcHN3LW51c3MuYyAgICB8ICAgMiArDQo+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC90aS9hbTY1LWNwc3ctbnVzcy5oICAgIHwgICA1ICsNCj4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1xb3MuYyAgICAgfCAxNzUgKysrKysrKysrKysr
KysrKysrKysNCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1xb3MuaCAgICAg
fCAxMDIgKysrKysrKysrKysrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDQ0MSBpbnNlcnRpb25zKCsp
DQo+IA0KPiBDaGFuZ2Vsb2c6DQo+IA0KPiB2NzoNCj4gLSB1c2UgZWxzZSBpZg0KPiAtIGRyb3Ag
RklYTUUgY29tbWVudA0KPiAtIGZpeCBsbGRwIGtzZWxmdGVzdCBmYWlsdXJlIGJ5IGxpbWl0aW5n
IG1heF92ZXJpZnlfdGltZSB0byBzcGVjIGxpbWl0IG9mIDEyOG1zLg0KPiAtIG5vdyBwYXNzZXMg
YWxsIGV0aHRvb2xfbW0uc2gga3NlbGZ0ZXN0cyAocGF0Y2ggOCByZXF1aXJlZCkNCj4gDQo+IHY2
Og0KPiAtIGdldCBtdXRleCBhcm91bmQgYW02NV9jcHN3X2lldF9jb21taXRfcHJlZW1wdGlibGVf
dGNzKCkgaW4NCj4gICBhbTY1X2Nwc3dfaWV0X2NoYW5nZV9wcmVlbXB0aWJsZV90Y3MoKQ0KPiAt
IHVzZSAicHJlZW1wdGlvbiIgaW5zdGVhZCBvZiAicHJlLWVtcHRpb24iDQo+IC0gY2FsbCBhbTY1
X2Nwc3dfc2V0dXBfbXFwcmlvKCkgZnJvbSB3aXRoaW4gYW02NV9jcHN3X3NldHVwX3RhcHJpbygp
DQo+IC0gTm93IHdvcmtzIHdpdGgga3NlbGZ0ZXN0IGV4Y2VwdCB0aGUgbGFzdCB0ZXN0IHdoaWNo
IGZhaWxzDQo+IA0KPiB2NToNCj4gLSBObyBjaGFuZ2UNCj4gDQo+IHY0Og0KPiAtIFJlYmFzZSBh
bmQgaW5jbHVkZSBpbiB0aGUgc2FtZSBzZXJpZXMgYXMgbXFwcmlvIHN1cHBvcnQuDQo+IA0KPiB2
MzoNCj4gLSBSZWJhc2Ugb24gdG9wIG9mIHY2LjYtcmMxIGFuZCBtcXByaW8gc3VwcG9ydCBbMV0N
Cj4gLSBTdXBwb3J0IGV0aHRvb2xfb3BzIDo6IGdldF9tbV9zdGF0cygpDQo+IC0gZHJvcCB1bnVz
ZWQgdmFyaWFibGVzIGNtbl9jdHJsIGFuZCB2ZXJpZnlfY250DQo+IC0gbWFrZSBhbTY1X2Nwc3df
aWV0X2xpbmtfc3RhdGVfdXBkYXRlKCkgYW5kDQo+ICAgYW02NV9jcHN3X2lldF9jaGFuZ2VfcHJl
ZW1wdGlibGVfdGNzKCkgc3RhdGljDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjMwOTE4MDc1MzU4LjU4NzgtMS1yb2dlcnFAa2VybmVsLm9yZy8NCj4gDQo+IHYyOg0K
PiAtIFVzZSBwcm9wZXIgY29udHJvbCBiaXRzIGZvciBQTUFDIGVuYWJsZQ0KPiAoQU02NV9DUFNX
X1BOX0NUTF9JRVRfUE9SVF9FTikNCj4gICBhbmQgVFggZW5hYmxlIChBTTY1X0NQU1dfUE5fSUVU
X01BQ19QRU5BQkxFKQ0KPiAtIENvbW1vbiBJRVQgRW5hYmxlIChBTTY1X0NQU1dfQ1RMX0lFVF9F
TikgaXMgc2V0IGlmIGFueSBwb3J0IGhhcw0KPiAgIEFNNjVfQ1BTV19QTl9DVExfSUVUX1BPUlRf
RU4gc2V0Lg0KPiAtIEZpeCB3b3JrYXJvdW5kIGZvciBlcnJhdHVtIGkyMjA4LiBpLmUuIExpbWl0
IHJ4X21pbl9mcmFnX3NpemUgdG8gMTI0DQoNClNob3VsZCBiZSAxMjggbm90IDEyNA0KDQo+IC0g
Rml4IGFtNjVfY3Bzd19pZXRfZ2V0X3ZlcmlmeV90aW1lb3V0X21zKCkgdG8gZGVmYXVsdCB0byB0
aW1lb3V0IGZvcg0KPiAgIDFHIGxpbmsgaWYgbGluayBpcyBpbmFjdGl2ZS4NCj4gLSByZXNpemUg
dGhlIFJYIEZJRk8gYmFzZWQgb24gcG1hY19lbmFibGVkLCBub3QgdHhfZW5hYmxlZC4NCj4gDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvYW02NS1jcHN3LWV0aHRv
b2wuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1ldGh0b29sLmMNCj4g
aW5kZXggYjllMWQ1Njg2MDRiLi41NTcxMzg1YjRiYWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3RpL2FtNjUtY3Bzdy1ldGh0b29sLmMNCj4gKysrIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvdGkvYW02NS1jcHN3LWV0aHRvb2wuYw0KPiBAQCAtMTEsNiArMTEsNyBAQA0KPiAg
I2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gDQo+ICAjaW5jbHVkZSAiYW02NS1jcHN3
LW51c3MuaCINCj4gKyNpbmNsdWRlICJhbTY1LWNwc3ctcW9zLmgiDQo+ICAjaW5jbHVkZSAiY3Bz
d19hbGUuaCINCj4gICNpbmNsdWRlICJhbTY1LWNwdHMuaCINCj4gDQo+IEBAIC03NDAsNiArNzQx
LDE1OSBAQCBzdGF0aWMgaW50IGFtNjVfY3Bzd19zZXRfZXRodG9vbF9wcml2X2ZsYWdzKHN0cnVj
dA0KPiBuZXRfZGV2aWNlICpuZGV2LCB1MzIgZmxhZ3MpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+
IA0KPiArc3RhdGljIHZvaWQgYW02NV9jcHN3X3BvcnRfaWV0X3J4X2VuYWJsZShzdHJ1Y3QgYW02
NV9jcHN3X3BvcnQgKnBvcnQsDQo+ICtib29sIGVuYWJsZSkgew0KPiArCXUzMiB2YWw7DQo+ICsN
Cj4gKwl2YWwgPSByZWFkbChwb3J0LT5wb3J0X2Jhc2UgKyBBTTY1X0NQU1dfUE5fUkVHX0NUTCk7
DQo+ICsJaWYgKGVuYWJsZSkNCj4gKwkJdmFsIHw9IEFNNjVfQ1BTV19QTl9DVExfSUVUX1BPUlRf
RU47DQo+ICsJZWxzZQ0KPiArCQl2YWwgJj0gfkFNNjVfQ1BTV19QTl9DVExfSUVUX1BPUlRfRU47
DQo+ICsNCj4gKwl3cml0ZWwodmFsLCBwb3J0LT5wb3J0X2Jhc2UgKyBBTTY1X0NQU1dfUE5fUkVH
X0NUTCk7DQo+ICsJYW02NV9jcHN3X2lldF9jb21tb25fZW5hYmxlKHBvcnQtPmNvbW1vbik7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGFtNjVfY3Bzd19wb3J0X2lldF90eF9lbmFibGUoc3Ry
dWN0IGFtNjVfY3Bzd19wb3J0ICpwb3J0LA0KPiArYm9vbCBlbmFibGUpIHsNCj4gKwl1MzIgdmFs
Ow0KPiArDQo+ICsJdmFsID0gcmVhZGwocG9ydC0+cG9ydF9iYXNlICsgQU02NV9DUFNXX1BOX1JF
R19JRVRfQ1RSTCk7DQo+ICsJaWYgKGVuYWJsZSkNCj4gKwkJdmFsIHw9IEFNNjVfQ1BTV19QTl9J
RVRfTUFDX1BFTkFCTEU7DQo+ICsJZWxzZQ0KPiArCQl2YWwgJj0gfkFNNjVfQ1BTV19QTl9JRVRf
TUFDX1BFTkFCTEU7DQo+ICsNCj4gKwl3cml0ZWwodmFsLCBwb3J0LT5wb3J0X2Jhc2UgKyBBTTY1
X0NQU1dfUE5fUkVHX0lFVF9DVFJMKTsgfQ0KPiArDQo+ICtzdGF0aWMgaW50IGFtNjVfY3Bzd19n
ZXRfbW0oc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYsIHN0cnVjdA0KPiArZXRodG9vbF9tbV9zdGF0
ZSAqc3RhdGUpIHsNCj4gKwlzdHJ1Y3QgYW02NV9jcHN3X3BvcnQgKnBvcnQgPSBhbTY1X25kZXZf
dG9fcG9ydChuZGV2KTsNCj4gKwlzdHJ1Y3QgYW02NV9jcHN3X25kZXZfcHJpdiAqcHJpdiA9IG5l
dGRldl9wcml2KG5kZXYpOw0KPiArCXUzMiBwb3J0X2N0cmwsIGlldF9jdHJsLCBpZXRfc3RhdHVz
Ow0KPiArCXUzMiBhZGRfZnJhZ19zaXplOw0KPiArDQo+ICsJbXV0ZXhfbG9jaygmcHJpdi0+bW1f
bG9jayk7DQo+ICsNCj4gKwlpZXRfY3RybCA9IHJlYWRsKHBvcnQtPnBvcnRfYmFzZSArIEFNNjVf
Q1BTV19QTl9SRUdfSUVUX0NUUkwpOw0KPiArCXBvcnRfY3RybCA9IHJlYWRsKHBvcnQtPnBvcnRf
YmFzZSArIEFNNjVfQ1BTV19QTl9SRUdfQ1RMKTsNCj4gKw0KPiArCXN0YXRlLT50eF9lbmFibGVk
ID0gISEoaWV0X2N0cmwgJg0KPiBBTTY1X0NQU1dfUE5fSUVUX01BQ19QRU5BQkxFKTsNCj4gKwlz
dGF0ZS0+cG1hY19lbmFibGVkID0gISEocG9ydF9jdHJsICYNCj4gQU02NV9DUFNXX1BOX0NUTF9J
RVRfUE9SVF9FTik7DQo+ICsNCj4gKwlpZXRfc3RhdHVzID0gcmVhZGwocG9ydC0+cG9ydF9iYXNl
ICsNCj4gQU02NV9DUFNXX1BOX1JFR19JRVRfU1RBVFVTKTsNCj4gKw0KPiArCWlmIChpZXRfY3Ry
bCAmIEFNNjVfQ1BTV19QTl9JRVRfTUFDX0RJU0FCTEVWRVJJRlkpDQo+ICsJCXN0YXRlLT52ZXJp
Znlfc3RhdHVzID0NCj4gRVRIVE9PTF9NTV9WRVJJRllfU1RBVFVTX0RJU0FCTEVEOw0KPiArCWVs
c2UgaWYgKGlldF9zdGF0dXMgJiBBTTY1X0NQU1dfUE5fTUFDX1ZFUklGSUVEKQ0KPiArCQlzdGF0
ZS0+dmVyaWZ5X3N0YXR1cyA9DQo+IEVUSFRPT0xfTU1fVkVSSUZZX1NUQVRVU19TVUNDRUVERUQ7
DQo+ICsJZWxzZSBpZiAoaWV0X3N0YXR1cyAmIEFNNjVfQ1BTV19QTl9NQUNfVkVSSUZZX0ZBSUwp
DQo+ICsJCXN0YXRlLT52ZXJpZnlfc3RhdHVzID0NCj4gRVRIVE9PTF9NTV9WRVJJRllfU1RBVFVT
X0ZBSUxFRDsNCj4gKwllbHNlDQo+ICsJCXN0YXRlLT52ZXJpZnlfc3RhdHVzID0NCj4gRVRIVE9P
TF9NTV9WRVJJRllfU1RBVFVTX1VOS05PV047DQo+ICsNCj4gKwlhZGRfZnJhZ19zaXplID0NCj4g
QU02NV9DUFNXX1BOX0lFVF9NQUNfR0VUX0FEREZSQUdTSVpFKGlldF9jdHJsKTsNCj4gKwlzdGF0
ZS0+dHhfbWluX2ZyYWdfc2l6ZSA9DQo+ICtldGh0b29sX21tX2ZyYWdfc2l6ZV9hZGRfdG9fbWlu
KGFkZF9mcmFnX3NpemUpOw0KPiArDQo+ICsJLyogRXJyYXRhIGkyMjA4OiBSWCBtaW4gZnJhZ21l
bnQgc2l6ZSBjYW5ub3QgYmUgbGVzcyB0aGFuIDEyNCAqLw0KPiArCXN0YXRlLT5yeF9taW5fZnJh
Z19zaXplID0gMTI0Ow0KDQovKiBFcnJhdGEgaTIyMDg6IFJYIG1pbiBmcmFnbWVudCBzaXplIGNh
bm5vdCBiZSBsZXNzIHRoYW4gMTI4ICovDQpzdGF0ZS0+cnhfbWluX2ZyYWdfc2l6ZSA9IDEyODsN
Cg0KICBQZWtrYQ0KDQo=

