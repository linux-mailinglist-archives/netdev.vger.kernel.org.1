Return-Path: <netdev+bounces-282671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCAQL0v68mnxwAEAu9opvQ
	(envelope-from <netdev+bounces-282671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:44:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 637DE49E30F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 878F9300C01C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D899377563;
	Thu, 30 Apr 2026 06:44:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5149443;
	Thu, 30 Apr 2026 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777531465; cv=none; b=dEWwRuuB4JR/xne+CN66zWbIXdHuUb5MEcpPt1la36M6pSge+YmkbQ5ied15F5zmq4e/Ra1H4HncA7pPMSsRdVRx8l0ZF1ELS9b4ukyUEQjmmYiq2vUfo/odhpwL1JFs7BphCDAgAffnJnR5SGq0BpPynYtH4juWkxNDR635Vac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777531465; c=relaxed/simple;
	bh=fgl1GEPklDOhWXvF7Mi2fECDUwjtNtSl9niLN5UtMT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=tmKwkOjVdCz5cQgD8/+cG7Dr2Bi4TzuE+AYOuGa4FYyBSwAC9yVUEYufil+I7/3iKXfoEEssSl/fUojMca/hpU+bMzvJGJEHxSOgbLPcHGFPR5auo6xw7dawxyFT8Q5zY8w5afu1Ap327DpTSVIxSyMPHVxCA/+W35PYtfQ9wqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from lizhi2$eswincomputing.com ( [10.11.96.26] ) by
 ajax-webmail-app1 (Coremail) ; Thu, 30 Apr 2026 14:43:50 +0800 (GMT+08:00)
Date: Thu, 30 Apr 2026 14:43:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
To: "Jakub Kicinski" <kuba@kernel.org>, andrew+netdev@lunn.ch
Cc: devicetree@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
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
In-Reply-To: <20260428180625.738223cf@kernel.org>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
 <20260427072508.1151-1-lizhi2@eswincomputing.com>
 <20260428180625.738223cf@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2117464.7991.19ddd2125d1.Coremail.lizhi2@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TAJkCgDHaXMm+vJp1e8VAA--.6484W
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/1tbiAQENDGnyMpsSHgAAs-
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWkCw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: 637DE49E30F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282671-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.436];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com,eswincomputing.com,einfochips.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiSmFrdWIgS2ljaW5za2ki
IDxrdWJhQGtlcm5lbC5vcmc+Cj4g5Y+R6YCB5pe26Ze0OjIwMjYtMDQtMjkgMDk6MDY6MjUgKOaY
n+acn+S4iSkKPiDmlLbku7bkuro6IGxpemhpMkBlc3dpbmNvbXB1dGluZy5jb20KPiDmioTpgIE6
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBhbmRyZXcrbmV0ZGV2QGx1bm4uY2gsIGRhdmVt
QGRhdmVtbG9mdC5uZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIHJvYmhAa2VybmVsLm9yZywga3J6
aytkdEBrZXJuZWwub3JnLCBjb25vcitkdEBrZXJuZWwub3JnLCBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnLCBwYWJlbmlAcmVkaGF0LmNvbSwgbWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbSwgYWxleGFu
ZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbSwgcm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWssIHBqd0Br
ZXJuZWwub3JnLCBwYWxtZXJAZGFiYmVsdC5jb20sIGFvdUBlZWNzLmJlcmtlbGV5LmVkdSwgYWxl
eEBnaGl0aS5mciwgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZywgbGludXgtc3RtMzJA
c3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbSwgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBtYXhpbWUuY2hldmFsbGll
ckBib290bGluLmNvbSwgbmluZ3l1QGVzd2luY29tcHV0aW5nLmNvbSwgbGlubWluQGVzd2luY29t
cHV0aW5nLmNvbSwgcGlua2VzaC52YWdoZWxhQGVpbmZvY2hpcHMuY29tLCBwcml0ZXNoLnBhdGVs
QGVpbmZvY2hpcHMuY29tLCB3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tLCBob3Jtc0Br
ZXJuZWwub3JnCj4g5Li76aKYOiBSZTogW1BBVENIIG5ldC1uZXh0IHY3IDIvNF0gbmV0OiBzdG1t
YWM6IGVpYzc3MDA6IGVuYWJsZSBjbG9ja3MgYmVmb3JlIHN5c2NvbiBhY2Nlc3MgYW5kIGNvcnJl
Y3QgUlggc2FtcGxpbmcgdGltaW5nCj4gCj4gCj4gV2h5IEZpeGVzPyBJZiBldGgxIG5ldmVyIHdv
cmtlZCB0aGlzIGlzIG5vdCBhIGZpeCBidXQgbmV3IGZ1bmN0aW9uYWxpdHkKPiBJZiB5b3Ugd2Fu
dCB0byBtYWtlIHRoaXMgYSBmaXggdG8gcHJldmVudCBpbmNvbXBhdGliaWxpdHkgLSBjdXQgaXQg
ZG93bgo+IGp1c3QgdG8gdGhlIGV0aDAgY2hhbmdlcy4KPiAKVGhhbmsgeW91IGZvciB0aGUgc3Vn
Z2VzdGlvbi4KCllvdSdyZSByaWdodCB0aGF0IGV0aDEgbmV2ZXIgd29ya2VkIGF0IEdpZ2FiaXQg
c3BlZWQsIHNvIHRoaXMgc2hvdWxkCm5vdCBiZSB0cmVhdGVkIGFzIGEgZml4LgoKSW4gdjgsIEkg
d2lsbCBzcGxpdCB0aGUgY2hhbmdlcyBpbnRvIHR3byBwYXRjaGVzIHdpdGhpbiB0aGUgc2FtZSBz
ZXJpZXM6Ci0gUGF0Y2ggMSB3aWxsIGNvbnRhaW4gb25seSB0aGUgZml4ZXMgYWZmZWN0aW5nIHRo
ZSBleGlzdGluZyBldGgwCmZ1bmN0aW9uYWxpdHksIGFuZCB3aWxsIGtlZXAgdGhlIEZpeGVzIHRh
Zy4KLSBQYXRjaCAyIHdpbGwgYWRkIHRoZSBldGgxIHN1cHBvcnQgKFJYIGNsb2NrIGludmVyc2lv
biB3b3JrYXJvdW5kKQphcyBuZXcgZnVuY3Rpb25hbGl0eSwgd2l0aG91dCBhIEZpeGVzIHRhZy4K
ClBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugd291bGQgcHJlZmVyIGEgZGlmZmVyZW50IHNwbGl0
IG9yIG9yZGVyaW5nLgoKPiAKPiBBSSBzYXlzOgo+IAo+ICAgVGhlIHN0ZXAgdW5pdCBpcyBiZWlu
ZyBzaWxlbnRseSBjaGFuZ2VkIGZyb20gMC4xIG5zIChkZWxheV9wcyAvIDEwMCkKPiAgIHRvIDAu
MDIgbnMgKGRlbGF5X3BzIC8gMjApLiAgVGhlIHNhbWUgRFQgdmFsdWUgbm93IHByb2dyYW1zIDV4
IHRoZSBudW1iZXIKPiAgIG9mIGRlbGF5IHN0ZXBzIGludG8gdGhlIGhhcmR3YXJlLgo+IAoKVGhp
cyBjaGFuZ2UgaXMgaW50ZW50aW9uYWwuIFRoZSBwcmV2aW91cyBkcml2ZXIgdXNlZCBhbiBpbmNv
cnJlY3QKY29udmVyc2lvbiAoMTAwcHMgcGVyIHN0ZXApLCB3aGlsZSB0aGUgYWN0dWFsIGhhcmR3
YXJlIHN0ZXAgaXMgMjBwcy4KClRoaXMgcGF0Y2ggY29ycmVjdHMgdGhlIGRlbGF5IGNhbGN1bGF0
aW9uIHRvIG1hdGNoIHRoZSBoYXJkd2FyZS4KClRoZSBEVCBiaW5kaW5nIGlzIHVwZGF0ZWQgYWNj
b3JkaW5nbHkgdG8gcmVmbGVjdCB0aGUgY29ycmVjdAoyMHBzIGdyYW51bGFyaXR5IGFuZCBlbmZv
cmNlIHZhbGlkIHZhbHVlcy4KClRoaXMgYmluZGluZyBoYXMgbm90IHlldCBiZWVuIHVzZWQgaW4g
YW55IHVwc3RyZWFtIERUUywgc28gdGhlcmUKYXJlIG5vIGluLXRyZWUgdXNlcnMgcmVseWluZyBv
biB0aGUgcHJldmlvdXMgYmVoYXZpb3IuCgpJIHdpbGwgY2xhcmlmeSB0aGlzIGV4cGxpY2l0bHkg
aW4gdGhlIHY4IGNvbW1pdCBtZXNzYWdlLgoKPiAKPiBBSSBzYXlzCj4gCj4gICBJbiB0aGUgZGVm
YXVsdCBjYXNlIHRoaXMgbG9ncyAiaW52YWxpZCBzcGVlZCAldSIgYnV0IHRoZW4gZmFsbHMKPiAg
IHRocm91Z2ggYW5kIHN0aWxsIGV4ZWN1dGVzIHRoZSByZWdtYXBfd3JpdGUoKSB3aXRoIHRoZSBi
YXNlIGRseV9wYXJhbS4gIEFuCj4gICB1bnN1cHBvcnRlZCBzcGVlZCByZXBvcnRzIGFuIGVycm9y
IGFuZCByZXByb2dyYW1zIHRoZSBoYXJkd2FyZSBhbnl3YXkuCj4gCj4gICBTaG91bGQgdGhlIGRl
ZmF1bHQgcGF0aCByZXR1cm4gd2l0aG91dCB3cml0aW5nLCBvciBzaG91bGQgdGhlIHdyaXRlIGJl
Cj4gICBtb3ZlZCBpbnRvIHRoZSB2YWxpZCBjYXNlcyBvbmx5Pwo+IAoKVGhlIGRlZmF1bHQgY2Fz
ZSBzaG91bGQgbm90IHJlcHJvZ3JhbSBhbnkgaGFyZHdhcmUgcmVnaXN0ZXJzLgoKSSB3aWxsIGNo
YW5nZSB0aGUgaW1wbGVtZW50YXRpb24gc28gdGhhdCByZWdpc3RlciB3cml0ZXMgYXJlIG9ubHkK
cGVyZm9ybWVkIGZvciB2YWxpZCBzcGVlZHMgKFNQRUVEXzEwLzEwMC8xMDAwKS4gRm9yIHVuc3Vw
cG9ydGVkCnNwZWVkcywgdGhlIGZ1bmN0aW9uIHdpbGwgb25seSBsb2cgdGhlIGVycm9yIGFuZCBy
ZXR1cm4gd2l0aG91dAphbnkgc2lkZSBlZmZlY3RzLgoKPiAKPiBBSSBzYXlzOgo+IAo+ICAgRmly
c3QsIHJ4LWludGVybmFsLWRlbGF5LXBzIGFuZCB0eC1pbnRlcm5hbC1kZWxheS1wcyBhcmUgc2ls
ZW50bHkKPiAgIGRlbW90ZWQgZnJvbSByZXF1aXJlZCB0byBvcHRpb25hbC4gIFRoZSBwcmV2aW91
cyBkcml2ZXIgcmV0dXJuZWQKPiAgIC1FSU5WQUwgd2l0aCAibWlzc2luZyByZXF1aXJlZCBwcm9w
ZXJ0eSAuLi4iIHdoZW4gZWl0aGVyIHdhcyBhYnNlbnQ7Cj4gICB0aGUgZWxzZSBicmFuY2hlcyBo
YXZlIGJlZW4gcmVtb3ZlZCwgc28gbWlzc2luZyBwcm9wZXJ0aWVzIG5vdyBsZWF2ZQo+ICAgZXRo
X2Nsa19kbHlfcGFyYW0gYXQgemVybyBhbmQgZml4X21hY19zcGVlZCgpIHByb2dyYW1zIHplcm8g
ZGVsYXkKPiAgIHdpdGhvdXQgZGlhZ25vc3RpYy4gIElzIHRoaXMgaW50ZW50aW9uYWwsIGFuZCBp
ZiBzbyBzaG91bGQgdGhlIGNvbW1pdAo+ICAgbWVzc2FnZSBhbmQgdGhlIERUIGJpbmRpbmcgcmVm
bGVjdCBpdD8KPiAgCj4gICBTZWNvbmQsIHRoZSBwcmV2aW91cyBjb2RlIHNpbGVudGx5IGNsYW1w
ZWQgb3V0LW9mLXJhbmdlIHZhbHVlcyB2aWEKPiAgIG1pbigpIGFuZCBvbmx5IHJlcXVpcmVkIG5v
bi16ZXJvIHN0ZXAgdW5pdHMgYnkgaW50ZWdlciB0cnVuY2F0aW9uLgo+ICAgVGhlIG5ldyBjb2Rl
IHJlamVjdHMgbm9uLW11bHRpcGxlcyBvZiAyMCBhbmQgdmFsdWVzIGdyZWF0ZXIgdGhhbiAyNTQw
Cj4gICBwcyB3aXRoIC1FSU5WQUwgYXQgcHJvYmUgdGltZS4gIERUQnMgdGhhdCBwcmV2aW91c2x5
IHByb2JlZCB3aXRoCj4gICBjbGFtcGVkIGRlbGF5cyB3aWxsIG5vdyBmYWlsIHByb2JlLiAgU2hv
dWxkIHRoaXMgc3RyaWN0ZXIgdmFsaWRhdGlvbgo+ICAgYWxzbyBiZSBjYWxsZWQgb3V0IGluIHRo
ZSBjb21taXQgbWVzc2FnZT8KPiAKClllcywgdGhpcyBjaGFuZ2UgaXMgaW50ZW50aW9uYWwuCgpU
aGUgcHJldmlvdXMgaW1wbGVtZW50YXRpb24gdXNlZCBpbmNvcnJlY3QgZGVsYXkgc2VtYW50aWNz
CigxMDBwcyBzdGVwIGFuZCBpbXBsaWNpdCBjbGFtcGluZyksIHdoaWNoIGRvZXMgbm90IG1hdGNo
IHRoZQphY3R1YWwgaGFyZHdhcmUgYmVoYXZpb3IuCgpUaGUgbmV3IGltcGxlbWVudGF0aW9uIGNv
cnJlY3RzIHRoZSBoYXJkd2FyZSBwcm9ncmFtbWluZyB0byB1c2UKdGhlIHJlYWwgMjBwcyBzdGVw
IGdyYW51bGFyaXR5IGFuZCBlbmZvcmNlcyB2YWxpZCByYW5nZXMuCgpSZWdhcmRpbmcgdGhlIERU
IGJpbmRpbmcgY2hhbmdlIChyZXF1aXJlZCDihpIgb3B0aW9uYWwpIGFuZCB0aGUKc3RyaWN0ZXIg
dmFsaWRhdGlvbiwgdGhpcyBpcyBhbHNvIGludGVudGlvbmFsLiBaZXJvIGRlbGF5IGlzIGEKdmFs
aWQgaGFyZHdhcmUgY29uZmlndXJhdGlvbiwgYW5kIHRoZSBzdHJpY3RlciBjaGVja3MgYXJlIGFk
ZGVkCnRvIGF2b2lkIHNpbGVudGx5IG1hc2tpbmcgaW52YWxpZCB2YWx1ZXMuCgpJbXBvcnRhbnRs
eSwgdGhpcyBiaW5kaW5nIGhhcyBub3QgYmVlbiB1c2VkIGJ5IGFueSB1cHN0cmVhbSBEVFMKeWV0
LCBzbyB0aGVyZSBhcmUgbm8gaW4tdHJlZSB1c2VycyBhZmZlY3RlZCBieSB0aGlzIGNoYW5nZS4K
Ckkgd2lsbCBleHBsaWNpdGx5IGRvY3VtZW50IGJvdGggdGhlIHNlbWFudGljIGNoYW5nZSBhbmQg
dGhlCmNvbXBhdGliaWxpdHkgbm90ZXMgaW4gdGhlIHY4IGNvbW1pdCBtZXNzYWdlIGFuZCB1cGRh
dGUgdGhlCmJpbmRpbmcgZGVzY3JpcHRpb24gYWNjb3JkaW5nbHkuCgo+IAo+IEFJIHNheXM6Cj4g
Cj4gICBUaGUgZXN3aW4saHNwLXNwLWNzciBwaGFuZGxlLWFyZ3MgbGF5b3V0IGlzIGV4cGFuZGVk
IGZyb20gNCBjZWxscwo+ICAgKHBoYW5kbGUgKyAzIG9mZnNldHMpIHRvIDYgY2VsbHMgKHBoYW5k
bGUgKyA1IG9mZnNldHMpLCB3aXRoIG5ldwo+ICAgaW5kaWNlcyAzLzQvNSBub3cgcmVxdWlyZWQu
ICBBbnkgRFRCIHByb2R1Y2VkIGFnYWluc3QgdGhlIG9yaWdpbmFsCj4gICBlYTc3ZGJiZGJjNGUg
YmluZGluZyB3aWxsIGZhaWwgcHJvYmUgaGVyZSB3aXRoIC1FSU5WQUwuCgpUaGUgcHJldmlvdXMg
cGhhbmRsZS1hcmdzIGxheW91dCAoNCBjZWxscykgd2FzIGJhc2VkIG9uIGFuCmluY29tcGxldGUg
aW5pdGlhbCBkZXNpZ24gYW5kIGRpZCBub3QgZnVsbHkgZGVzY3JpYmUgYWxsIHJlcXVpcmVkCmhh
cmR3YXJlIHJlZ2lzdGVyIG9mZnNldHMuCgpUaGUgdXBkYXRlZCA2LWNlbGwgZm9ybWF0IHJlZmxl
Y3RzIHRoZSBjb21wbGV0ZSBoYXJkd2FyZSBDU1IgbGF5b3V0CmFuZCBhbGxvd3MgZXhwbGljaXQg
Y29uZmlndXJhdGlvbiBvZiBhZGRpdGlvbmFsIGNvbnRyb2wgcmVnaXN0ZXJzLgoKSW1wb3J0YW50
bHksIHRoaXMgYmluZGluZyBoYXMgbm90IGJlZW4gdXNlZCBieSBhbnkgdXBzdHJlYW0gRFRTLApz
byB0aGVyZSBhcmUgbm8gaW4tdHJlZSB1c2VycyBhZmZlY3RlZCBieSB0aGlzIGNoYW5nZS4KCkkg
YWdyZWUgdGhhdCB0aGlzIGlzIGEgRFQgQUJJIGNoYW5nZSwgYW5kIEkgd2lsbCBleHBsaWNpdGx5
IGRvY3VtZW50CnRoZSBjb21wYXRpYmlsaXR5IGltcGFjdCBhbmQgdXBkYXRlZCBiaW5kaW5nIGRl
c2NyaXB0aW9uIGluIHRoZSB2OApzZXJpZXMgdG8gbWFrZSB0aGlzIGNsZWFyLgo=

