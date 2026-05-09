Return-Path: <netdev+bounces-286103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM4HFE2s/mkyuwAAu9opvQ
	(envelope-from <netdev+bounces-286103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 05:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5EF4FDED9
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 05:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF56530090BB
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 03:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9253603D3;
	Sat,  9 May 2026 03:38:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3598C1F;
	Sat,  9 May 2026 03:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778297927; cv=none; b=sFwrOknNKArvk83FtiUZ7DxKfTMushvwKcTY8r1Bdlmy2dxp/57CKcyNkoumVfCt88A5Lcg4RUGQa5YxSLt7/mUSaA9nl6FWQlIgbJF4nUMlXQvAXEnwZerYzL/kYGAes3B6/y2SCuvU4/KoN5DNjKFSkjF/ewBS4LtJKMUFxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778297927; c=relaxed/simple;
	bh=QKdMqpj3zuyhgykdtMOpS/13BuHhXD0mhIJDPFVa1aM=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=M0Wdt8ismlmrHBdKRLascVjjWEC2TlKj7AQRNTLbM5somat/rlo9qffpoAaEzpNj8GBGmuM7E7btDGUsxGYgvxW9NFNlv1WmsdNo797G1k1UMNjAxPoQ7x+5pDIIlhT5cTtCpdOyLCBoROmac0kwwckdu/MQqGclP6k6vl4289w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.4282901|-1;BR=01201311R121ec;CH=green;DM=|CONTINUE|false|;DS=SPAM|spam_education_ad|0.850318-0.00164876-0.148033;FP=3408002840867165954|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=19;RT=19;SR=0;TI=W4_0.2.3_212509C9_1778297879228_o7001c164s;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_212509C9_1778297879228_o7001c164s] cluster:ay29) at Sat, 09 May 2026 11:38:27 +0800
Date: Sat, 09 May 2026 11:38:27 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Paolo Abeni" <pabeni@redhat.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>,
  "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "lorenzo" <lorenzo@kernel.org>,
  "horms" <horms@kernel.org>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "enelsonmoore" <enelsonmoore@gmail.com>,
  "skhan" <skhan@linuxfoundation.org>,
  "hkallweit1" <hkallweit1@gmail.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <e35c8cf4-73f0-4847-b1b1-8f424a805a71.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77ya5Zue5aSN77yaW1BBVENIIHYxMyBuZXQtbmV4dCAwMy8xMV0gbmV0L25lYnVs?=
  =?UTF-8?B?YS1tYXRyaXg6IGFkZCBjaGlwIHJlbGF0ZWQgZGVmaW5pdGlvbnM=?=
X-Mailer: [Alimail-Mailagent revision 745868][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260428114910.2616-1-illusion.wang@nebula-matrix.com> <20260428114910.2616-4-illusion.wang@nebula-matrix.com> <e41adaad-8937-4b5d-bdbf-d57d3efe2855@redhat.com> <b240b971-81b8-4325-80b6-5352e1515f07.Illusion.Wang@nebula-matrix.com>,<bdaf51a9-66d1-4469-960f-d5ec74f870de@lunn.ch>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4zLjE1LVJlbGVhc2UuMjYwNDI0MDA0KSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <bdaf51a9-66d1-4469-960f-d5ec74f870de@lunn.ch>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: CA5EF4FDED9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286103-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[Illusion.Wang@nebula-matrix.com];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Illusion.Wang@nebula-matrix.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,linux.dev,google.com,gmail.com,linuxfoundation.org];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Cj4+IEJ1dCBJIHByaW50ZWQgb3V0IHRoZSByZXN1bHRzOiAKPj4gQVJSQVlfU0laRShuYmxfc2Vj
MDA5X2RhdGEpIGVxdWFscyBOQkxfU0VDMDA5X1NJWkUsCj4+IEFSUkFZX1NJWkUobmJsX3NlYzAy
NV9kYXRhKSBlcXVhbHMgTkJMX1NFQzAyNV9TSVpFLAo+PiBhbmQgQVJSQVlfU0laRShuYmxfc2Vj
MDIyX2RhdGEpIGVxdWFscyBOQkxfU0VDMDIyX1NJWkUuCj4+IAo+PiBJcyB0aGUgQUkgbWFraW5n
IGEgbWlzdGFrZSBoZXJlPwoKPkp1c3QgYSBndWVzcywgaSd2ZSBub3QgbG9va2VkIGF0IHRoaXMg
cGF0Y2ggYXQgYWxsLgoKPkFyZSB5b3UgZG9pbmcgdGhpcyBvbiBhIDMyIGJpdCBidWlsZD8gTWF5
YmUgdGhlIEFJIGlzPwoKwqA+IMKgIEFuZHJldwoKIFdlIGFyZSB1c2luZyB0aGlzIG9uIGEgNjQg
Yml0IGJ1aWxkLg==

