Return-Path: <netdev+bounces-205377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92643AFE6E5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952F116427E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D8288539;
	Wed,  9 Jul 2025 11:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10013265CBE;
	Wed,  9 Jul 2025 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059175; cv=none; b=JNwTklA4pu5IgwVxZxFqLlpDlZxYSwkFXuJznt+yo/75osR1asGKInIjhcHHTWV07OrQtox7KJxoX5BZwqWp35Zmi+ZTmWfadHMqX0Cl0Z6Zk6rq7U4Xm0Cfl4zn3BIBjJP7m9um9qk4iQOb47BtxSyrjXlFlZHDgyjsXCqaV0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059175; c=relaxed/simple;
	bh=7UH+NitmtShAKMej1iDR59vgq6OCawsU/qbLijymRUU=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=ARPP0KRMtGKzT03w3tnd+NCRUteGW/FlHkoB/64LLRiH51l2iDCFKvabui6bFAHWJk2HGfrI8M8xYGOT+EKWfYoZQvOIYUErZJq2pvq4vs2e0uooBeoSCmyrSa9HJFl+Q/55A2pgbywybTcNN4eYg9dU815+vv3HkqZRMKLR8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bcZsM6G7Bz8R043;
	Wed,  9 Jul 2025 19:05:59 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 569B5vN4059526;
	Wed, 9 Jul 2025 19:05:57 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 9 Jul 2025 19:05:59 +0800 (CST)
Date: Wed, 9 Jul 2025 19:05:59 +0800 (CST)
X-Zmail-TransId: 2afc686e4d171be-63e8a
X-Mailer: Zmail v1.0
Message-ID: <20250709190559883SkXisbe8RTqw6jz6kycBo@zte.com.cn>
In-Reply-To: <CANn89i+JGSt=_CtWfhDXypWW-34a6SoP3RAzWQ9B9VL4+PHjDw@mail.gmail.com>
References: CANn89iJvyYjiweCESQL8E-Si7M=gosYvh1BAVWwAWycXW8GSdg@mail.gmail.com,202507071846455418y7RHD-cnstxL3SlD6hBH@zte.com.cn,CANn89i+JGSt=_CtWfhDXypWW-34a6SoP3RAzWQ9B9VL4+PHjDw@mail.gmail.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <edumazet@google.com>
Cc: <xu.xin16@zte.com.cn>, <kuba@kernel.org>, <kuniyu@amazon.com>,
        <ncardwell@google.com>, <davem@davemloft.net>, <horms@kernel.org>,
        <dsahern@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dCB2Ml0gdGNwOiBleHRlbmQgdGNwX3JldHJhbnNtaXRfc2tiIHRyYWNlcG9pbnQgd2l0aCBmYWlsdXJlIHJlYXNvbnM=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl2.zte.com.cn 569B5vN4059526
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 686E4D17.001/4bcZsM6G7Bz8R043



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PiA+ID4gPg0KPiA+ID4gPiAtLyoNCj4gPiA+ID4gLSAqIHRjcCBldmVudCB3aXRoIGFyZ3VtZW50
cyBzayBhbmQgc2tiDQo+ID4gPiA+IC0gKg0KPiA+ID4gPiAtICogTm90ZTogdGhpcyBjbGFzcyBy
ZXF1aXJlcyBhIHZhbGlkIHNrIHBvaW50ZXI7IHdoaWxlIHNrYiBwb2ludGVyIGNvdWxkDQo+ID4g
PiA+IC0gKiAgICAgICBiZSBOVUxMLg0KPiA+ID4gPiAtICovDQo+ID4gPiA+IC1ERUNMQVJFX0VW
RU5UX0NMQVNTKHRjcF9ldmVudF9za19za2IsDQo+ID4gPiA+ICsjZGVmaW5lIFRDUF9SRVRSQU5T
TUlUX1FVSVRfUkVBU09OICAgICAgICAgICAgIFwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIEVO
VU0oVENQX1JFVFJBTlNfRVJSX0RFRkFVTFQsICAgICAgICAgICAicmV0cmFuc21pdCB0ZXJtaW5h
dGUgdW5leHBlY3RlZGx5IikgICAgXA0KPiA+ID4gPiArICAgICAgICAgICAgICAgRU5VTShUQ1Bf
UkVUUkFOU19TVUNDRVNTLCAgICAgICAgICAgICAgICJyZXRyYW5zbWl0IHN1Y2Nlc3NmdWxseSIp
ICAgICAgICAgICAgICBcDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBFTlVNKFRDUF9SRVRSQU5T
X0lOX0hPU1RfUVVFVUUsICAgICAgICAgInBhY2tldCBzdGlsbCBxdWV1ZWQgaW4gZHJpdmVyIikg
ICAgICAgIFwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIEVOVU0oVENQX1JFVFJBTlNfRU5EX1NF
UV9FUlJPUiwgICAgICAgICAiaW52YWxpZCBlbmQgc2VxdWVuY2UiKSAgICAgICAgICAgICAgICAg
XA0KPiA+ID4gPiArICAgICAgICAgICAgICAgRU5VTShUQ1BfUkVUUkFOU19UUklNX0hFQURfTk9N
RU0sICAgICAgICJ0cmltIGhlYWQgbm8gbWVtb3J5IikgICAgICAgICAgICAgICAgICBcDQo+ID4g
PiA+ICsgICAgICAgICAgICAgICBFTlVNKFRDUF9SRVRSQU5TX1VOQ0xPTkVfTk9NRU0sICAgICAg
ICAgInNrYiB1bmNsb25lIGtlZXB0cnVlc2l6ZSBubyBtZW1vcnkiKSAgIFwNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIEVOVU0oVENQX1JFVFJBTlNfRlJBR19OT01FTSwgICAgICAgICAgICAiZnJh
Z21lbnQgbm8gbWVtb3J5IikgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4NCj4gPiA+IERvIHdl
IHJlYWxseSBuZWVkIDMgKyAxIGRpZmZlcmVudCAnTk9NRU1PUlknIHN0YXR1cyA/DQo+ID4NCj4g
PiBZZXMsIGRpZmZlcmVudCAiTk9NRU0iIHN0YXR1cyBwaW5wb2ludCBleGFjdCBmYWlsdXJlIHN0
YWdlcyBpbiBwYWNrZXQgcmV0cmFuc21pc3Npb24sDQo+ID4gd2hpY2ggaGVscHMgZGlzdGluZ3Vp
c2ggd2hpY2ggcHJvY2VzcyB0cmlnZ2VyZWQgaXQuIEJlbmVmaWNpYQ0KPg0KPiBFTk9NRU0gaXMg
RU5PTUVNLiBIb25lc3RseSBJIGZhaWwgdG8gc2VlIHdoeSBpdCBtYXR0ZXJzLg0KPg0KPiBJZiB0
aGlzIHdhcyB0aGUgY2FzZSwgd2Ugd291bGQgaGF2ZSB0aG91c2FuZHMgb2YgZGlmZmVyZW50IEVO
T01FTSBlcnJub3MuDQoNCkhpIEVyaWMsDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRj
aCBhbmQgeW91ciB2YWxpZCBmZWVkYmFjayDigJMgSSBhZ3JlZSB3aXRoIHlvdXIgcG9pbnQNCnRo
YXQgZXhjZXNzaXZlIEVOT01FTSBncmFudWxhcml0eSBjb3VsZCBjcmVhdGUgdW5uZWNlc3Nhcnkg
cmVkdW5kYW5jeSBpbiB0aGUga2VybmVsLg0KDQpNeSBpbml0aWFsIGludGVudCB3YXMgdG8gZGlm
ZmVyZW50aWF0ZSBhbGxvY2F0aW9uIGZhaWx1cmVzIGluIFRDUCByZXRyYW5zbWlzc2lvbg0KKFRS
SU1fSEVBRCwgVU5DTE9ORSwgRlJBRykgdG8gcGlucG9pbnQgZXhhY3QgZmFpbHVyZSBwb2ludHMg
ZHVyaW5nIGRlYnVnZ2luZywNCnNpbmNlIHRoZXNlIGVycm9ycyBvY2N1ciBhdCBkaXN0aW5jdCBz
dGFnZXMgd2l0aCBkaWZmZXJlbnQgc3RhY2sgY29udGV4dHMuDQpIb3dldmVyLCBJIHJlY29nbml6
ZSB0aGF0IEVOT01FTSBpdHNlbGYgc3VmZmljaWVudGx5IGNvbnZleXMgdGhlIGNvcmUgaXNzdWUu
DQoNCldlIHdpbGwgY29uc29saWRhdGUgdGhlc2UgaW50byBhIHVuaWZpZWQgVENQX1JFVFJBTlNf
Tk9NRU0gaW4gdjQgb2YgdGhlIHBhdGNoLg0KQXBwcmVjaWF0ZSB5b3VyIHRpbWUgYW5kIGV4cGVy
dGlzZSE=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPiZndDsgJmd0OyAmZ3Q7ICZndDs8L3A+PHA+Jmd0
OyAmZ3Q7ICZndDsgJmd0OyAtLyo8L3A+PHA+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtICogdGNwIGV2
ZW50IHdpdGggYXJndW1lbnRzIHNrIGFuZCBza2I8L3A+PHA+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAt
ICo8L3A+PHA+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtICogTm90ZTogdGhpcyBjbGFzcyByZXF1aXJl
cyBhIHZhbGlkIHNrIHBvaW50ZXI7IHdoaWxlIHNrYiBwb2ludGVyIGNvdWxkPC9wPjxwPiZndDsg
Jmd0OyAmZ3Q7ICZndDsgLSAqJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7YmUgTlVMTC48L3A+
PHA+Jmd0OyAmZ3Q7ICZndDsgJmd0OyAtICovPC9wPjxwPiZndDsgJmd0OyAmZ3Q7ICZndDsgLURF
Q0xBUkVfRVZFTlRfQ0xBU1ModGNwX2V2ZW50X3NrX3NrYiw8L3A+PHA+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyArI2RlZmluZSBUQ1BfUkVUUkFOU01JVF9RVUlUX1JFQVNPTiZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO1w8L3A+PHA+Jmd0OyAmZ3Q7ICZndDsgJmd0
OyArJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
O0VOVU0oVENQX1JFVFJBTlNfRVJSX0RFRkFVTFQsJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsicmV0cmFuc21pdCB0ZXJtaW5hdGUgdW5leHBlY3RlZGx5IikmbmJzcDsg
Jm5ic3A7IFw8L3A+PHA+Jmd0OyAmZ3Q7ICZndDsgJmd0OyArJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO0VOVU0oVENQX1JFVFJBTlNfU1VDQ0VT
UywmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
InJldHJhbnNtaXQgc3VjY2Vzc2Z1bGx5IikmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgXDwvcD48cD4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICsmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7RU5VTShUQ1BfUkVU
UkFOU19JTl9IT1NUX1FVRVVFLCZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsicGFj
a2V0IHN0aWxsIHF1ZXVlZCBpbiBkcml2ZXIiKSZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBc
PC9wPjxwPiZndDsgJmd0OyAmZ3Q7ICZndDsgKyZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtFTlVNKFRDUF9SRVRSQU5TX0VORF9TRVFfRVJST1Is
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyJpbnZhbGlkIGVuZCBzZXF1ZW5jZSIp
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDtcPC9wPjxwPiZndDsgJmd0OyAmZ3Q7ICZndDsgKyZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtFTlVNKFRDUF9SRVRSQU5TX1RSSU1fSEVB
RF9OT01FTSwmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsidHJpbSBoZWFkIG5vIG1lbW9yeSIp
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgXDwvcD48cD4mZ3Q7ICZndDsgJmd0OyAmZ3Q7ICsmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7RU5VTShUQ1BfUkVUUkFOU19VTkNMT05F
X05PTUVNLCZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsic2tiIHVuY2xvbmUga2Vl
cHRydWVzaXplIG5vIG1lbW9yeSIpJm5ic3A7ICZuYnNwO1w8L3A+PHA+Jmd0OyAmZ3Q7ICZndDsg
Jmd0OyArJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwO0VOVU0oVENQX1JFVFJBTlNfRlJBR19OT01FTSwmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAiZnJhZ21lbnQgbm8gbWVtb3J5IikmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtcPC9wPjxw
PiZndDsgJmd0OyAmZ3Q7PC9wPjxwPiZndDsgJmd0OyAmZ3Q7IERvIHdlIHJlYWxseSBuZWVkIDMg
KyAxIGRpZmZlcmVudCAnTk9NRU1PUlknIHN0YXR1cyA/PC9wPjxwPiZndDsgJmd0OzwvcD48cD4m
Z3Q7ICZndDsgWWVzLCBkaWZmZXJlbnQgIk5PTUVNIiBzdGF0dXMgcGlucG9pbnQgZXhhY3QgZmFp
bHVyZSBzdGFnZXMgaW4gcGFja2V0IHJldHJhbnNtaXNzaW9uLDwvcD48cD4mZ3Q7ICZndDsgd2hp
Y2ggaGVscHMgZGlzdGluZ3Vpc2ggd2hpY2ggcHJvY2VzcyB0cmlnZ2VyZWQgaXQuIEJlbmVmaWNp
YTwvcD48cD4mZ3Q7PC9wPjxwPiZndDsgRU5PTUVNIGlzIEVOT01FTS4gSG9uZXN0bHkgSSBmYWls
IHRvIHNlZSB3aHkgaXQgbWF0dGVycy48L3A+PHA+Jmd0OzwvcD48cD4mZ3Q7IElmIHRoaXMgd2Fz
IHRoZSBjYXNlLCB3ZSB3b3VsZCBoYXZlIHRob3VzYW5kcyBvZiBkaWZmZXJlbnQgRU5PTUVNIGVy
cm5vcy48L3A+PHA+PGJyPjwvcD48cD5IaSBFcmljLDwvcD48cD48YnI+PC9wPjxwPlRoYW5rcyBm
b3IgcmV2aWV3aW5nIHRoZSBwYXRjaCBhbmQgeW91ciB2YWxpZCBmZWVkYmFjayDigJMgSSBhZ3Jl
ZSB3aXRoIHlvdXIgcG9pbnQ8L3A+PHA+dGhhdCBleGNlc3NpdmUgRU5PTUVNIGdyYW51bGFyaXR5
IGNvdWxkIGNyZWF0ZSB1bm5lY2Vzc2FyeSByZWR1bmRhbmN5IGluIHRoZSBrZXJuZWwuPC9wPjxw
Pjxicj48L3A+PHA+TXkgaW5pdGlhbCBpbnRlbnQgd2FzIHRvIGRpZmZlcmVudGlhdGUgYWxsb2Nh
dGlvbiBmYWlsdXJlcyBpbiBUQ1AgcmV0cmFuc21pc3Npb248L3A+PHA+KFRSSU1fSEVBRCwgVU5D
TE9ORSwgRlJBRykgdG8gcGlucG9pbnQgZXhhY3QgZmFpbHVyZSBwb2ludHMgZHVyaW5nIGRlYnVn
Z2luZyw8L3A+PHA+c2luY2UmbmJzcDt0aGVzZSBlcnJvcnMgb2NjdXIgYXQgZGlzdGluY3Qgc3Rh
Z2VzIHdpdGggZGlmZmVyZW50IHN0YWNrIGNvbnRleHRzLjwvcD48cD5Ib3dldmVyLCBJIHJlY29n
bml6ZSB0aGF0IEVOT01FTSBpdHNlbGYgc3VmZmljaWVudGx5IGNvbnZleXMgdGhlIGNvcmUgaXNz
dWUuPC9wPjxwPjxicj48L3A+PHA+V2Ugd2lsbCBjb25zb2xpZGF0ZSB0aGVzZSBpbnRvIGEgdW5p
ZmllZCBUQ1BfUkVUUkFOU19OT01FTSBpbiB2NCBvZiB0aGUgcGF0Y2guPC9wPjxwPkFwcHJlY2lh
dGUgeW91ciB0aW1lIGFuZCBleHBlcnRpc2UhPC9wPjxwPjxicj48L3A+PHA+PGJyPjwvcD48L2Rp
dj4=


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


