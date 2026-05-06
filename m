Return-Path: <netdev+bounces-284665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a5swJH2j+mltQwMAu9opvQ
	(envelope-from <netdev+bounces-284665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:12:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CC64D5956
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D7163042C50
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 02:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963C2280CF6;
	Wed,  6 May 2026 02:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF1274B28;
	Wed,  6 May 2026 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033517; cv=none; b=CZVMpEQDkWjYQEmYC2wZ70JMUlk1/jNFXxGqOsA9+07NaeLwqOFD2MAA1eFmlTD/ILgwrcXgtD5AMurSa8nslIXfC/A+FQOJGFssJWyaDOPFc4pXgAPDsBGSxEm+szzCgJ4fH+HPfIO0gvGs1q2lOp7uRbXApmH+FF+T4O+DikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033517; c=relaxed/simple;
	bh=OyJWM5q8wlnOqWx5bMCl7ppdv5LJ0QqOaQ1SST/zF5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=D62sqxB8Vnf1kBkNJLx9noxpIqqAH3ixx1m8FZ2Bdr50molSokDO5GIcu0TRzxPSRlf7ssiMyb5BLtOv03CLU77CQw7IB7sUkSoyXnqRTLr99v0qMduC2P0XEPYzq1N8so5mHZkkpuWChFDLMGg6FqVUCFjsOBQPy0NpwO+W/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Wed, 6 May 2026 10:10:57 +0800 (GMT+08:00)
Date: Wed, 6 May 2026 10:10:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, devicetree@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com,
	horms@kernel.org
Subject: Re: Re: [PATCH net-next v7 2/4] net: stmmac: eic7700: enable clocks
 before syscon access and correct RX sampling timing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260430163551.7491407a@kernel.org>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
 <20260427072508.1151-1-lizhi2@eswincomputing.com>
 <20260428180625.738223cf@kernel.org>
 <2117464.7991.19ddd2125d1.Coremail.lizhi2@eswincomputing.com>
 <20260430163551.7491407a@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <38d052b7.7a70.19dfb0d782b.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgDHaXMyo_ppwzEXAA--.6613W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQETDGn6G5we7wACs4
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: 42CC64D5956
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284665-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiSmFrdWIgS2ljaW5za2ki
IDxrdWJhQGtlcm5lbC5vcmc+Cj4g5Y+R6YCB5pe26Ze0OjIwMjYtMDUtMDEgMDc6MzU6NTEgKOaY
n+acn+S6lCkKPiDmlLbku7bkuro6IOadjuW/lyA8bGl6aGkyQGVzd2luY29tcHV0aW5nLmNvbT4K
PiDmioTpgIE6IGFuZHJldytuZXRkZXZAbHVubi5jaCwgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcsIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIHJvYmhAa2VybmVs
Lm9yZywga3J6aytkdEBrZXJuZWwub3JnLCBjb25vcitkdEBrZXJuZWwub3JnLCBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnLCBwYWJlbmlAcmVkaGF0LmNvbSwgbWNvcXVlbGluLnN0bTMyQGdtYWlsLmNv
bSwgYWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbSwgcm1rK2tlcm5lbEBhcm1saW51eC5vcmcu
dWssIHBqd0BrZXJuZWwub3JnLCBwYWxtZXJAZGFiYmVsdC5jb20sIGFvdUBlZWNzLmJlcmtlbGV5
LmVkdSwgYWxleEBnaGl0aS5mciwgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZywgbGlu
dXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbSwgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBtYXhpbWUu
Y2hldmFsbGllckBib290bGluLmNvbSwgbmluZ3l1QGVzd2luY29tcHV0aW5nLmNvbSwgbGlubWlu
QGVzd2luY29tcHV0aW5nLmNvbSwgcGlua2VzaC52YWdoZWxhQGVpbmZvY2hpcHMuY29tLCBwcml0
ZXNoLnBhdGVsQGVpbmZvY2hpcHMuY29tLCB3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29t
LCBob3Jtc0BrZXJuZWwub3JnCj4g5Li76aKYOiBSZTogW1BBVENIIG5ldC1uZXh0IHY3IDIvNF0g
bmV0OiBzdG1tYWM6IGVpYzc3MDA6IGVuYWJsZSBjbG9ja3MgYmVmb3JlIHN5c2NvbiBhY2Nlc3Mg
YW5kIGNvcnJlY3QgUlggc2FtcGxpbmcgdGltaW5nCj4gCj4gT24gVGh1LCAzMCBBcHIgMjAyNiAx
NDo0Mzo1MCArMDgwMCAoR01UKzA4OjAwKSDmnY7lv5cgd3JvdGU6Cj4gPiA+IFdoeSBGaXhlcz8g
SWYgZXRoMSBuZXZlciB3b3JrZWQgdGhpcyBpcyBub3QgYSBmaXggYnV0IG5ldyBmdW5jdGlvbmFs
aXR5Cj4gPiA+IElmIHlvdSB3YW50IHRvIG1ha2UgdGhpcyBhIGZpeCB0byBwcmV2ZW50IGluY29t
cGF0aWJpbGl0eSAtIGN1dCBpdCBkb3duCj4gPiA+IGp1c3QgdG8gdGhlIGV0aDAgY2hhbmdlcy4K
PiA+ID4gICAKPiA+IFRoYW5rIHlvdSBmb3IgdGhlIHN1Z2dlc3Rpb24uCj4gPiAKPiA+IFlvdSdy
ZSByaWdodCB0aGF0IGV0aDEgbmV2ZXIgd29ya2VkIGF0IEdpZ2FiaXQgc3BlZWQsIHNvIHRoaXMg
c2hvdWxkCj4gPiBub3QgYmUgdHJlYXRlZCBhcyBhIGZpeC4KPiA+IAo+ID4gSW4gdjgsIEkgd2ls
bCBzcGxpdCB0aGUgY2hhbmdlcyBpbnRvIHR3byBwYXRjaGVzIHdpdGhpbiB0aGUgc2FtZSBzZXJp
ZXM6Cj4gPiAtIFBhdGNoIDEgd2lsbCBjb250YWluIG9ubHkgdGhlIGZpeGVzIGFmZmVjdGluZyB0
aGUgZXhpc3RpbmcgZXRoMAo+ID4gZnVuY3Rpb25hbGl0eSwgYW5kIHdpbGwga2VlcCB0aGUgRml4
ZXMgdGFnLgo+ID4gLSBQYXRjaCAyIHdpbGwgYWRkIHRoZSBldGgxIHN1cHBvcnQgKFJYIGNsb2Nr
IGludmVyc2lvbiB3b3JrYXJvdW5kKQo+ID4gYXMgbmV3IGZ1bmN0aW9uYWxpdHksIHdpdGhvdXQg
YSBGaXhlcyB0YWcuCj4gPiAKPiA+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugd291bGQgcHJl
ZmVyIGEgZGlmZmVyZW50IHNwbGl0IG9yIG9yZGVyaW5nLgo+IAo+IElmIHlvdSB3YW50IHRvIGNv
bnNpZGVyIHNvbWUgcGFydCBvZiB0aGlzIGNvbW1pdCBhIGZpeCBpdCBoYXMgdG8gYmUKPiBwb3N0
ZWQgc2VwYXJhdGVseSB0byB0aGUgbmV0IHRyZWUgKHJhdGhlciB0aGFuIG5ldC1uZXh0KS4KPiBP
bmNlIGl0J3MgbWVyZ2VkIGFuZCBtYWtlcyBpdCB3YXkgb3ZlciB0byB0aGUgbmV0LW5leHQgdHJl
ZSAoZWFjaAo+IFRodXJzZGF5KSB5b3UgY2FuIHBvc3QgdGhlIG5ldC1uZXh0IGNobmFnZXMgZm9y
IGV0aDEKClRoYW5rcywgdW5kZXJzdG9vZC4KCkkgd2lsbCBzcGxpdCB0aGUgY2hhbmdlcyBhY2Nv
cmRpbmdseToKLSBTZW5kIHRoZSBldGgwIGZpeGVzIGFzIGEgbmV3IHYxIHNlcmllcyB0YXJnZXRp
bmcgbmV0LgotIFNlbmQgdGhlIGV0aDEgZW5hYmxlbWVudCBhcyBhIG5ldyB2MSBzZXJpZXMgdGFy
Z2V0aW5nIG5ldC1uZXh0LgoKVGhhbmtzIGZvciB0aGUgZ3VpZGFuY2UuCg==

