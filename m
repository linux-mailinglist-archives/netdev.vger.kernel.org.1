Return-Path: <netdev+bounces-285670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGK7IyKC/WnSfAAAu9opvQ
	(envelope-from <netdev+bounces-285670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:26:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA624F2740
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84A26301981D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 06:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C58434EF0E;
	Fri,  8 May 2026 06:26:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E2E355F22;
	Fri,  8 May 2026 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221597; cv=none; b=mjLD5vSzacAmLqt6MI3fz5W/E74YtitVRWZ76ndTR/XlnclGe+XBVc1eVzjtyt/k5xDXqNFRyFhX9xDvgOB95u5GW/7EA7tI4f2/DaDzEpCisHQxs0h2cV68kgoBTZxCUeDjiJ/xs0rgW7rSbA759r9d6+xVowAFzi62S6OsJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221597; c=relaxed/simple;
	bh=Ydxsd6hZUidkzxIW3fGDiTXZBTSpFb3lbhvgRh09Rjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=RnZo8zKFjwF+jibF2OI2mGJ6bbyeo9gfrINYaywzgsWMwevYONed5YsCojwb0P6HWr1M56K5mlJRltseLzzuPOMV8r5FO9Usq/G7Ug8IndMYXvCqBNooF92+1GKDjZTvIu4MUXF+wwxi5hobad2joKcA4xakLZeF4wL8QIgUTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Fri, 8 May 2026 14:25:53 +0800 (GMT+08:00)
Date: Fri, 8 May 2026 14:25:53 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Maxime Chevallier" <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH net v1 2/2] net: stmmac: eic7700: fix delay step
 calculation and ensure safe register initialization
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <92e8a3dd-a46a-499f-b5f6-99f7b99f45f5@bootlin.com>
References: <20260507083037.152-1-lizhi2@eswincomputing.com>
 <20260507083214.192-1-lizhi2@eswincomputing.com>
 <92e8a3dd-a46a-499f-b5f6-99f7b99f45f5@bootlin.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2cfe5945.7d11.19e064395e0.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TAJkCgBn_HDxgf1pndsXAA--.6347W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAgEBDGn8vxET+gAAsc
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: 0DA624F2740
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285670-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	NEURAL_HAM(-0.00)[-0.264];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiTWF4aW1lIENoZXZhbGxp
ZXIiIDxtYXhpbWUuY2hldmFsbGllckBib290bGluLmNvbT4KPiBTZW5kIHRpbWU6VGh1cnNkYXks
IDA3LzA1LzIwMjYgMTk6MjE6NDEKPiBUbzogbGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbSwgYW5k
cmV3K25ldGRldkBsdW5uLmNoLCBkYXZlbUBkYXZlbWxvZnQubmV0LCBlZHVtYXpldEBnb29nbGUu
Y29tLCBrdWJhQGtlcm5lbC5vcmcsIHBhYmVuaUByZWRoYXQuY29tLCByb2JoQGtlcm5lbC5vcmcs
IGtyemsrZHRAa2VybmVsLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZywgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcsIG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20sIGFsZXhhbmRyZS50b3JndWVAZm9z
cy5zdC5jb20sIHJtaytrZXJuZWxAYXJtbGludXgub3JnLnVrLCBsaW51eC1zdG0zMkBzdC1tZC1t
YWlsbWFuLnN0b3JtcmVwbHkuY29tLCBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKPiBDYzogbmluZ3l1QGVzd2luY29tcHV0aW5nLmNvbSwgbGlubWluQGVzd2luY29tcHV0aW5n
LmNvbSwgcGlua2VzaC52YWdoZWxhQGVpbmZvY2hpcHMuY29tLCBwcml0ZXNoLnBhdGVsQGVpbmZv
Y2hpcHMuY29tLCB3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBuZXQgdjEgMi8yXSBuZXQ6IHN0bW1hYzogZWljNzcwMDogZml4IGRlbGF5IHN0ZXAg
Y2FsY3VsYXRpb24gYW5kIGVuc3VyZSBzYWZlIHJlZ2lzdGVyIGluaXRpYWxpemF0aW9uCj4gCj4g
SGksCj4gCj4gT24gMDcvMDUvMjAyNiAxMDozMiwgbGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbSB3
cm90ZToKPiA+IEZyb206IFpoaSBMaSA8bGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbT4KPiA+IAo+
ID4gRml4IHNldmVyYWwgaXNzdWVzIGluIHRoZSBFSUM3NzAwIERXTUFDIGdsdWUgZHJpdmVyIHJl
bGF0ZWQgdG8gZGVsYXkKPiA+IGNvbmZpZ3VyYXRpb24gYW5kIHJlZ2lzdGVyIGluaXRpYWxpemF0
aW9uLgo+ID4gCj4gPiBUaGUgaGFyZHdhcmUgaW1wbGVtZW50cyBUWC9SWCBkZWxheSB3aXRoIGEg
Z3JhbnVsYXJpdHkgb2YgMjAgcHMgcGVyCj4gPiBzdGVwLCBidXQgdGhlIGRyaXZlciBwcmV2aW91
c2x5IGFzc3VtZWQgYSAxMDAgcHMgc3RlcC4gVXBkYXRlIHRoZQo+ID4gZGVmaW5pdGlvbnMgdG8g
bWF0Y2ggdGhlIGFjdHVhbCBoYXJkd2FyZSBiZWhhdmlvdXIgYW5kIGFsaWduIHdpdGgKPiA+IHRo
ZSBiaW5kaW5nIGNvbnN0cmFpbnRzLgo+ID4gCj4gPiBJbnRyb2R1Y2UgZXhwbGljaXQgZGVmaW5p
dGlvbnMgZm9yIHRoZSBtYXhpbXVtIHByb2dyYW1tYWJsZSBkZWxheQo+ID4gcmFuZ2UgYmFzZWQg
b24gdGhlIGhhcmR3YXJlIGxpbWl0cy4KPiA+IAo+ID4gTW92ZSBIU1AgQ1NSIGNvbmZpZ3VyYXRp
b24gaW50byB0aGUgaW5pdGlhbGl6YXRpb24gcGF0aCBhZnRlciBjbG9ja3MKPiA+IGFyZSBlbmFi
bGVkLiBUaGlzIGVuc3VyZXMgdGhhdCBhbGwgcmVnaXN0ZXIgYWNjZXNzZXMgb2NjdXIgd2l0aCB0
aGUKPiA+IHJlcXVpcmVkIGNsb2NrcyBhY3RpdmUsIGF2b2lkaW5nIHVuZGVmaW5lZCBiZWhhdmlv
dXIuCj4gPiAKPiA+IENsZWFyIHRoZSBUWEQgYW5kIFJYRCBkZWxheSBjb250cm9sIHJlZ2lzdGVy
cyBkdXJpbmcgaW5pdGlhbGl6YXRpb24KPiA+IHRvIG92ZXJyaWRlIGFueSByZXNpZHVhbCBjb25m
aWd1cmF0aW9uIGxlZnQgYnkgdGhlIGJvb3Rsb2FkZXIuIFRoaXMKPiA+IGVuc3VyZXMgZGV0ZXJt
aW5pc3RpYyBSR01JSSB0aW1pbmcgYW5kIHByZXZlbnRzIHVuaW50ZW5kZWQgZGVsYXkKPiA+IGJl
aW5nIGFwcGxpZWQuCj4gPiAKPiA+IFRoZSBNQUMgUkdNSUkgZGVsYXkgcHJvZ3JhbW1pbmcgaXMg
b25seSByZXF1aXJlZCBmb3IgMTAwTWJwcyBhbmQKPiA+IDEwMDBNYnBzIG1vZGVzLCB3aGVyZSBw
cmVjaXNlIGNsb2NrLXRvLWRhdGEgYWxpZ25tZW50IGlzIG5lY2Vzc2FyeSBmb3IKPiA+IHJlbGlh
YmxlIHNhbXBsaW5nLgo+ID4gCj4gPiBGb3IgMTBNYnBzIG9wZXJhdGlvbiwgdGltaW5nIG1hcmdp
bnMgYXJlIHN1ZmZpY2llbnRseSByZWxheGVkIGFuZCBubwo+ID4gYWRkaXRpb25hbCBkZWxheSBj
b21wZW5zYXRpb24gaXMgcmVxdWlyZWQuIEluIHRoaXMgY2FzZSwgdGhlIGRyaXZlcgo+ID4gZmFs
bHMgYmFjayB0byBhIHNhZmUgZGVmYXVsdCBjb25maWd1cmF0aW9uIHdpdGggZGVsYXkgZGlzYWJs
ZWQuCj4gPiAKPiA+IEZvciB1bnN1cHBvcnRlZCBvciB1bmV4cGVjdGVkIGxpbmsgc3BlZWRzLCB0
aGUgZHJpdmVyIGF2b2lkcwo+ID4gcHJvZ3JhbW1pbmcgaW52YWxpZCBkZWxheSB2YWx1ZXMgYW5k
IGZhbGxzIGJhY2sgdG8gYSBzYWZlIGRlZmF1bHQKPiA+IHN0YXRlIGJ5IGV4cGxpY2l0bHkgY2xl
YXJpbmcgdGhlIGRlbGF5IGNvbmZpZ3VyYXRpb24uCj4gPiAKPiA+IEV4cGxpY2l0bHkgcHJvZ3Jh
bW1pbmcgemVybyBlbnN1cmVzIHRoYXQgbm8gcmVzaWR1YWwgZGVsYXkgc2V0dGluZ3MKPiA+IGZy
b20gcHJldmlvdXMgY29uZmlndXJhdGlvbnMgb3IgYm9vdGxvYWRlciBzdGF0ZSByZW1haW4gYWN0
aXZlLgo+ID4gCj4gPiBUaGVzZSBjaGFuZ2VzIGZpeCBpbmNvcnJlY3QgZGVsYXkgcHJvZ3JhbW1p
bmcgYW5kIGluaXRpYWxpemF0aW9uCj4gPiBvcmRlcmluZyBmb3IgZXhpc3RpbmcgdXNlcnMuCj4g
PiAKPiA+IFRoaXMgYWxzbyBhbGlnbnMgdGhlIGRyaXZlciBpbXBsZW1lbnRhdGlvbiB3aXRoIHRo
ZSB1cGRhdGVkIGRldmljZQo+ID4gdHJlZSBiaW5kaW5nLgo+IAo+IFRoZXJlJ3MgYSBsb3QgZ29p
bmcgb24gaW4gdGhpcyBwYXRjaCwgY2FuIHlvdSBzcGxpdCB0aGlzIGludG8gcGF0Y2hlcwo+IHRo
YXQgc29sdmVzIGVhY2ggb2YgdGhlc2UgaW5kaXZpZHVhbCBpc3N1ZXMgPwo+IAo+IEl0J3MgYSBt
aXggb2YgZml4ZXMgKHRoZSByZWcgYWNjZXNzIG1vdmVkIGFmdGVyIGNsayBjb25maWcgZm9yIGV4
YW1wbGUpCj4gYW5kIG5vbi1maXhlcyAodGhlIFJHTUlJIHRpbWluZ3MsIHlvdSdyZSBpbXByb3Zp
bmcgdGhlIGdyYW51bGFyaXR5IG9mCj4gdGhlIGRlbGF5cywgaXMgdGhpcyByZXF1aXJlZCB0byBm
aXggZXhpc3Rpbmcgc2V0dXBzLCBvciBpcyBpdCBhIGdlbmVyaWMKPiBpbXByb3ZlbWVudCA/KSwg
c3BsaXR0aW5nIHRoaXMgd291bGQgbWFrZSBpdCBib3RoIGVhc2llciB0byByZXZpZXcsIGFuZAo+
IGVhc2llciB0byBiaXNlY3Qgc2hvdWxkIHByb2JsZW1zIGFyaXNlIGluIHRoZSBmdXR1cmUuCj4g
CgpUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCByZXZpZXcgYW5kIHN1Z2dlc3Rpb25zLgoKWW91J3Jl
IHJpZ2h0IHRoYXQgdGhlIGN1cnJlbnQgcGF0Y2ggbWl4ZXMgc2V2ZXJhbCBsb2dpY2FsbHkgaW5k
ZXBlbmRlbnQKY2hhbmdlcywgYW5kIHNwbGl0dGluZyB0aGVtIHdpbGwgbWFrZSB0aGUgc2VyaWVz
IGVhc2llciB0byByZXZpZXcgYW5kCmJpc2VjdC4gSSB3aWxsIGZvbGxvdyB5b3VyIHN1Z2dlc3Rp
b24gYW5kIHNwbGl0IHRoZSBjdXJyZW50IHBhdGNoIGludG8KbXVsdGlwbGUgc21hbGxlciBwYXRj
aGVzIHdpdGhpbiB0aGUgc2FtZSBzZXJpZXMuCgpBbGwgZml2ZSBjaGFuZ2VzIGJlbG93IGFyZSBj
b3JyZWN0bmVzcyBmaXhlcyBhZGRyZXNzaW5nIGhhcmR3YXJlIG9yIGRyaXZlcgppc3N1ZXMsIG5v
dCBpbXByb3ZlbWVudHMgb3IgbmV3IGZlYXR1cmVzLgoKQmFzZWQgb24gdGhlIGN1cnJlbnQgY2hh
bmdlIHNldCwgdGhlIGluZGl2aWR1YWwgZml4ZXMgYXJlOgoKMS4gVFgvUlggZGVsYXkgZ3JhbnVs
YXJpdHkgY29ycmVjdGlvbiAoMTAwIHBzIC0+IDIwIHBzIHN0ZXApCiAgIFRoaXMgY29ycmVjdHMg
YW4gaW5jb3JyZWN0IGhhcmR3YXJlIGNhcGFiaWxpdHkgbW9kZWxpbmcgaW4gdGhlIGRyaXZlci4K
ICAgVGhlIGRyaXZlciBwcmV2aW91c2x5IGFzc3VtZWQgYSAxMDAgcHMgc3RlcCwgd2hpbGUgdGhl
IGhhcmR3YXJlIGFjdHVhbGx5CiAgIGltcGxlbWVudHMgMjAgcHMgZ3JhbnVsYXJpdHkuCiAgIFRo
aXMgZml4ZXMgaW5jb3JyZWN0IGRlbGF5IHByb2dyYW1taW5nIHRoYXQgY291bGQgb2NjdXIgd2hl
biBmaW5lLWdyYWluZWQKICAgZGVsYXkgdmFsdWVzIGFyZSB1c2VkLCBlbnN1cmluZyBjb3JyZWN0
IHJlcHJlc2VudGF0aW9uIG9mIHRoZSBoYXJkd2FyZQogICBjYXBhYmlsaXR5LgoKMi4gSW50cm9k
dWNlIGV4cGxpY2l0IG1heGltdW0gZGVsYXkgcmFuZ2UgZGVmaW5pdGlvbnMKICAgVGhpcyBmaXhl
cyBtaXNzaW5nIGVuZm9yY2VtZW50IG9mIGhhcmR3YXJlIGNvbnN0cmFpbnRzLCBwcmV2ZW50aW5n
IGludmFsaWQKICAgZGVsYXkgdmFsdWVzIGZyb20gYmVpbmcgYWNjZXB0ZWQgb3IgcHJvZ3JhbW1l
ZC4KCjMuIE1vdmUgSFNQIENTUiBjb25maWd1cmF0aW9uIGFmdGVyIGNsb2NrIGVuYWJsZQogICBU
aGlzIGZpeGVzIGEgcmVnaXN0ZXIgYWNjZXNzIG9yZGVyaW5nIGlzc3VlIHdoZXJlIGFjY2Vzc2lu
ZyBIU1AgQ1NSIGJlZm9yZQogICBjbG9ja3MgYXJlIGVuYWJsZWQgbWF5IHJlc3VsdCBpbiB1bmRl
ZmluZWQgYmVoYXZpb3IgZHVyaW5nIGluaXRpYWxpemF0aW9uLgoKNC4gQ2xlYXIgVFhEL1JYRCBk
ZWxheSBjb250cm9sIHJlZ2lzdGVycyBkdXJpbmcgaW5pdGlhbGl6YXRpb24KICAgVGhpcyBmaXhl
cyByZXNpZHVhbCBjb25maWd1cmF0aW9uIGxlZnQgYnkgYm9vdGxvYWRlciBzdGF0ZSwgZW5zdXJp
bmcKICAgZGV0ZXJtaW5pc3RpYyBiZWhhdmlvciBhY3Jvc3MgcmVib290IGFuZCBkcml2ZXIgcmVs
b2FkLgoKNS4gRGVsYXkgaGFuZGxpbmcgZm9yIDEwTWJwcyBhbmQgaW52YWxpZCBsaW5rIHNwZWVk
cwogICBUaGlzIGZpeGVzIGluY29ycmVjdCBhcHBsaWNhdGlvbiBvZiBSR01JSSBkZWxheSBwcm9n
cmFtbWluZyBvdXRzaWRlIHZhbGlkCiAgIG9wZXJhdGluZyBtb2RlcywgcHJldmVudGluZyBpbnZh
bGlkIGNvbmZpZ3VyYXRpb24gZnJvbSBiZWluZyBhcHBsaWVkLgoKSSB3aWxsIHNwbGl0IHRoZXNl
IGludG8gc2VwYXJhdGUgcGF0Y2hlcyBpbiB0aGUgbmV4dCByZXZpc2lvbiwgd2hpbGUga2VlcGlu
Zwp0aGVtIHdpdGhpbiB0aGUgc2FtZSBzZXJpZXMuCgpGb3IgdGhlIERUIGJpbmRpbmcgc2lkZSwg
d291bGQgeW91IGFsc28gcmVjb21tZW5kIHNwbGl0dGluZyB0aGUgYmluZGluZwpjaGFuZ2VzIHRv
IG1hdGNoIHRoZSBkcml2ZXItbGV2ZWwgZ3JhbnVsYXJpdHksIG9yIHdvdWxkIGl0IGJlIGJldHRl
ciB0byBrZWVwCnRoZW0gY29uc29saWRhdGVkIGluIGEgc2luZ2xlIGJpbmRpbmcgcGF0Y2g/CgpJ
ZiB5b3UgaGF2ZSBhbnkgZnVydGhlciBzdWdnZXN0aW9ucyBvbiB0aGUgc3BsaXQgb3IgY2xhc3Np
ZmljYXRpb24sIHBsZWFzZQpsZXQgbWUga25vdy4KClRoYW5rcywKWmhpCg==

