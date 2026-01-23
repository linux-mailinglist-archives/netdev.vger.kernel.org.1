Return-Path: <netdev+bounces-252738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABo9A4xFc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:55:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6579A73B92
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D763C3038A5C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADC33793CD;
	Fri, 23 Jan 2026 09:53:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F87B33F8A2;
	Fri, 23 Jan 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161982; cv=none; b=bP+IytFAwopJ4Cu9QURAmIeo/VAWPNJuuq1MNHrPmMRJwnJnnrj1yrWK5THvKoU1GvgTnK3n/Y7ySK1HyK2dmQKTOoof//XKWW5pRI1Y9amNeerQ+nY5w0+yt2Lw6O6n/P9abJ4/CYUAiRMeo3v82QcB9zdA/xDWWLrF6PNqDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161982; c=relaxed/simple;
	bh=cCxEDZ1fr3n/f4NkfiMVSfrHEnYkdcSQlaoo5wWCwKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DSX4awDbCgT2PY9inYxRIhMRHW5LnF+Wf5CyGCUPuu9sKY0jxDPeTnTiUbQQ6Tab2SIJFCM14k0vGISaAzXkJSxo8GyRu4JApCMc4T66R6QPxNKizbMntJP6krKOfyaTEMtxUZ559Jy89dTfXr0FqtTVXfaiaXPsL6IcFttvNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Fri, 23 Jan 2026 17:52:28 +0800 (GMT+08:00)
Date: Fri, 23 Jan 2026 17:52:28 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Bo Gan" <ganboing@gmail.com>
Cc: "Andrew Lunn" <andrew@lunn.ch>, devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock
 sampling control
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <abf12a3f-9cdd-472d-a02e-af4da594b84f@gmail.com>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>
 <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
 <4e2a55e7.3662.19be8cb9c3c.Coremail.lizhi2@eswincomputing.com>
 <c5c0bfdb-316d-4796-afa0-f6f018ceb414@lunn.ch>
 <abf12a3f-9cdd-472d-a02e-af4da594b84f@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <29b8c4d2.3704.19bea44fe53.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgCn+2zcRHNpGxgFAA--.1620W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQEQDGlyUQwdaAABsu
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252738-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[st.com:email,stormreply.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,davemloft.net:email,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 6579A73B92
X-Rspamd-Action: no action

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiQm8gR2FuIiA8Z2FuYm9p
bmdAZ21haWwuY29tPgo+IOWPkemAgeaXtumXtDoyMDI2LTAxLTIzIDE1OjM5OjI5ICjmmJ/mnJ/k
upQpCj4g5pS25Lu25Lq6OiAiQW5kcmV3IEx1bm4iIDxhbmRyZXdAbHVubi5jaD4sIOadjuW/lyA8
bGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbT4KPiDmioTpgIE6IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnLCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVkdW1h
emV0QGdvb2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgcm9iaEBrZXJuZWwub3JnLCBrcnprK2R0
QGtlcm5lbC5vcmcsIGNvbm9yK2R0QGtlcm5lbC5vcmcsIG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcs
IHBhYmVuaUByZWRoYXQuY29tLCBtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tLCBhbGV4YW5kcmUu
dG9yZ3VlQGZvc3Muc3QuY29tLCBybWsra2VybmVsQGFybWxpbnV4Lm9yZy51aywgbGludXgtc3Rt
MzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbSwgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBuaW5neXVAZXN3aW5j
b21wdXRpbmcuY29tLCBsaW5taW5AZXN3aW5jb21wdXRpbmcuY29tLCBwaW5rZXNoLnZhZ2hlbGFA
ZWluZm9jaGlwcy5jb20sIHdlaXNoYW5nanVhbkBlc3dpbmNvbXB1dGluZy5jb20KPiDkuLvpopg6
IFJlOiBbUEFUQ0ggdjEgMS8yXSBkdC1iaW5kaW5nczogZXRoZXJuZXQ6IGVzd2luOiBhZGQgY2xv
Y2sgc2FtcGxpbmcgY29udHJvbAo+IAo+IEhpIEFuZHJldywKPiAKPiBPbiAxLzIyLzI2IDE5OjE5
LCBBbmRyZXcgTHVubiB3cm90ZToKPiA+Pj4gWW91IHNheSBpbnRlcm5hbC4gU28gdGhlIHNrZXcg
aXMgZml4ZWQsIGl0IGlzIGEgcHJvcGVydHkgb2YgdGhlCj4gPj4+IHNpbGljb24/IElmIHNvLCB3
aHkgYSBEVCBwcm9wZXJ0eT8gV2h5IG5vdCBqdXN0IGhhcmQgY29kZSBpdCBpbiB0aGUKPiA+Pj4g
ZHJpdmVyPyBTaW5jZSBpdCBpcyBpbnRlcm5hbCwgZGlmZmVyZW50IGJvYXJkcyBzaG91bGQgbm90
IG5lZWQgaXQgc2V0Cj4gPj4+IGRpZmZlcmVudGx5Pwo+ID4+Pgo+ID4+IFRoYW5rcyBmb3IgdGhl
IHF1ZXN0aW9uLgo+ID4+Cj4gPj4gRUlDNzcwMCBoYXMgdHdvIEV0aGVybmV0IE1BQ3MuIE9ubHkg
ZXRoMSBoYXMgdGhpcyBpbnRlcm5hbCBSWEMvUlhEIHNrZXcsCj4gPj4gZXRoMCBkb2VzIG5vdC4K
PiA+Pgo+ID4+IFNvIHRoaXMgaXMgbm90IGEgY2hpcC13aWRlIGNvbnN0YW50IHRoYXQgY2FuIGJl
IGhhcmRjb2RlZCBpbiB0aGUgZHJpdmVyLgo+ID4+IFdlIG5lZWQgYSB3YXkgdG8gZGlzdGluZ3Vp
c2ggdGhlIHR3byBNQUMgaW5zdGFuY2VzLCB3aGljaCBpcyB3aHkgdGhpcyBpcwo+ID4+IGRlc2Ny
aWJlZCBwZXItcG9ydCBpbiBEVFMuCj4gPiAKPiA+IEkgYXNzdW1lIHRoZSBhZGRyZXNzIG9mIHRo
ZSBpbnRlcmZhY2UgaXMgZml4ZWQuIFNvIHlvdSBjYW4ganVzdCBrZXkKPiA+IG9mZiB0aGF0IHRv
IGRpc3Rpbmd1aXNoIHRoZSB0d28gaW5zdGFuY2VzLgo+ID4gCj4gPiBTaW5jZSB0aGlzIGlzIGFu
IGludGVybmFsIHByb3BlcnR5LCBub3QgYSBib2FyZCBwcm9wZXJ0eSwgaXQgaXMgbm90Cj4gPiBj
bGVhciBpdCBhY3R1YWxseSBiZWxvbmdzIG9uIERULgo+ID4gCj4gPiAgICAgIEFuZHJldwo+IAo+
IElNTywgdGhleSBzaG91bGQgYmUgaW4gRFQgdG8gcHJvdmlkZSBtYXhpbXVtIGZsZXhpYmlsaXR5
LiBUaGUgU29DIC5kdHNpCj4gY2FuIHByb3ZpZGUgc29tZSBzYW5lIGRlZmF1bHRzLCBhbmQgdGhl
IGJvYXJkIHZlbmRvciBjYW4gbGF0ZXIgb3ZlcnJpZGUKPiB0aGVtIGlmIHRoZSBtYWMvcGh5IHJl
cXVpcmVzIGZ1cnRoZXIgdHVuaW5nLiBBcHBseWluZyBzdWNoIHR1bmluZyBieQo+IHRoZSBhZGRy
ZXNzIG9mIE1BQyBzZWVtcyBtZXNzeSBhbmQgaXQgaGlkZXMgdGhlIHBhcmFtZXRlcnMgdXNlZCBi
ZWhpbmQKPiBkcml2ZXIuIFRocm91Z2ggRFQsIGV2ZXJ5dGhpbmcgYmVjb21lcyByZWFsbHkgY2xl
YXIuCj4gCj4gSSBhc3N1bWUgdGhpcyBpcyBub3QgdW5jb21tb246IEUuZy4sIHN0YXJmaXZlL2po
NzExMDoKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA3MTQxMDQ1MjEuMTg3NTEt
My1zYW1pbi5ndW9Ac3RhcmZpdmV0ZWNoLmNvbS8KPiAKPiBCVFcsIG5vIG5lZWQgdG8gd29ycnkg
YWJvdXQgYmFja3dhcmQgY29tcGF0LiBFU1dJTiBoYXNuJ3QgY2hlY2tlZC1pbiBhbnkKPiBEVCBm
b3IgZXRoIHlldC4gQXMgeW91IGFuZCBSdXNzZWxsIHNhaWQsIHRoZXkgbmVlZCB0byBkbyBpdCwg
cHJvbnRvLgo+IApZZXMsIHRoaXMgY2FuIGJlIGhhcmRjb2RlZCBmb3IgZXRoMSwgc2ltaWxhciB0
byB3aGF0IGlzIGRvbmUgaW4KZHdtYWMtbG9vbmdzb24xLmMuCgpIb3dldmVyLCBjb25zaWRlcmlu
ZyBFSUM3NzAyLCB3aGljaCBpbnRlZ3JhdGVzIHR3byBFSUM3NzAwIGRpZXMgYW5kIHRodXMKaGFz
IGZvdXIgTUFDcyBpbiB0b3RhbCwgd2UgYmVsaWV2ZSBkZXNjcmliaW5nIHRoaXMgdmlhIERUUyBp
cyBtb3JlCmFwcHJvcHJpYXRlLiBXZSBhcmUgY3VycmVudGx5IHdvcmtpbmcgb24gdXBzdHJlYW1p
bmcgdGhlIERUUyBzdXBwb3J0IGZvcgpFSUM3NzAyLgoKV2l0aCB0aGUgRFQgYXBwcm9hY2gsIHRo
ZSBpbnRlcm5hbCBSWEMvUlhEIHNrZXcgY2FuIGJlIGRlc2NyaWJlZCBleHBsaWNpdGx5CmZvciBn
bWFjMSBhbmQgZ21hYzMsIHdpdGhvdXQgcmVxdWlyaW5nIGNoYW5nZXMgdG8gZHdtYWMtZWljNzcw
MC5jIHdoZW4KYnJpbmdpbmcgdXAgRUlDNzcwMi4KCkFzIEJvIEdhbiBhbHNvIG1lbnRpb25lZCwg
dGhlcmUgYXJlIHZlbmRvcnMgaGFuZGxpbmcgc2ltaWxhciBpbnRlcm5hbApxdWlya3MgdGhyb3Vn
aCBEVCBjb25maWd1cmF0aW9uLgoKLS0KTGkgWmhpCg==

