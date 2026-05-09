Return-Path: <netdev+bounces-286161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FJtCzIV/2lg2AAAu9opvQ
	(envelope-from <netdev+bounces-286161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 13:06:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7361F4FF730
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 13:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79F8B300E733
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B48F371D16;
	Sat,  9 May 2026 11:06:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7EB35B63D
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778324783; cv=none; b=sVUYB6IwfvTaXewLpZ79DyFS/DmnEcqtS6RscF9MiA1mLOkdMSPBFLvWgm8uiwY5SH8i98uVQY3C+jhbRWf9Mr4z+Xymyqved8atjlRV11NUOtMtFBhHs6vAARkWrOQISGIAkvc/UP35WnFNmGzKnrSFsLBP8XGRG25niF+ZRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778324783; c=relaxed/simple;
	bh=yzot4h43WPl5avDZCWvjdktyZAY+2T74QFGAmTDAPJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKXW8ifgJWnTg8zPMSvDLGUVX/trBF6nwKDU2wMii4/TSwthBNsxpVYxsVl8+8xqOKKXFsVfDO8HShnrr8pY7Tru6bzJ5rp8Vp2ubw/RSeEOtbZ6AlnfJWQNgwWKQbGCaBGL6bgiN0RfgI1hVaEY040wVt9QSO4xWtCTKO6z98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gCNTG26SNz5BNS0;
	Sat, 09 May 2026 19:06:10 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 649B5x5M067046;
	Sat, 9 May 2026 19:05:59 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
	by smtp (Zmail) with SMTP;
	Sat, 9 May 2026 19:06:02 +0800
X-Zmail-TransId: 3e8169ff1505001-648a6
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: han.junyang@zte.com.cn
From: Junyang Han <han.junyang@zte.com.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, han.junyang@zte.com.cn,
        ran.ming@zte.com.cn, han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v3 1/3] net/ethernet: add ZTE network driver support
Date: Sat,  9 May 2026 18:34:48 +0800
Message-ID: <20260509103448.3263890-1-han.junyang@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <eabcb0c3-324f-4fd7-992e-8d517980ea27@lunn.ch>
References: <eabcb0c3-324f-4fd7-992e-8d517980ea27@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 649B5x5M067046
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sat, 09 May 2026 19:06:10 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69FF1522.000/4gCNTG26SNz5BNS0
X-Rspamd-Queue-Id: 7361F4FF730
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	URIBL_RED(0.50)[zte.com.cn:mid];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/related,multipart/alternative,text/plain];
	HAS_ANON_DOMAIN(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	BAD_REP_POLICIES(0.10)[];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286161-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[han.junyang@zte.com.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zte.com.cn:mid]
X-Rspamd-Action: add header
X-Spam: Yes



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

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHRha2luZyB0aGUgdGltZSB0byByZXZpZXcuDQoN
Cj4gKyAgICBzdHJ1Y3QgZGV2bGluayAqZGV2bGluazsNCg0KPiArICAgIGludCByZXQ7DQo+ICsN
Cj4gKyAgICBkZXZsaW5rID0gZGV2bGlua19hbGxvYygmZGhfcGZfZGV2bGlua19vcHMsIHNpemVv
ZihzdHJ1Y3QgZGhfY29yZV9kZXYpLA0KPiArICAgICAgICAgICAgICAgICZwZGV2LT5kZXYpOw0K
DQo+IFdyb25nIGluZGVudGF0aW9uLiBJbiBmYWN0LCB0aGlzIHNlZW1zIHRvIGhhdmUgc3BhY2Vz
IG5vdCB0YWJzLiBXaGF0DQo+IGRvZXMgY2hlY2twYXRjaCBzYXkgYWJvdXQgdGhlc2UgZmlsZXM/
IE9yIGlzIHlvdSBlbWFpbCBzdGlsbCBicm9rZW4/DQoNCg0KSSBkb3VibGUtY2hlY2tlZCB0aGUg
cGF0Y2ggZmlsZSBsb2NhbGx5LiBUaGUgaW5kZW50YXRpb24gZG9lcyB1c2UNCnRhYnMsIG5vdCBz
cGFjZXM6DQoNCiAgJCBjYXQgLUEgdjMtMDAwMS0qLnBhdGNoIHwgZ3JlcCAtQTMgImRldmxpbmtf
YWxsb2MiDQogICteSWRldmxpbmsgPSBkZXZsaW5rX2FsbG9jKCZkaF9wZl9kZXZsaW5rX29wcywg
c2l6ZW9mKHN0cnVjdCBkaF9jb3JlX2RldiksJA0KICArXkleSV5JXkkmcGRldi0+ZGV2KTskDQog
ICteSWlmICghZGV2bGluaykkDQogICteSV5JcmV0dXJuIC1FTk9NRU07JA0KDQpBbmQgY2hlY2tw
YXRjaC5wbCAtLXN0cmljdCBhbHNvIHJlcG9ydHMgMCBlcnJvcnMsIDAgd2FybmluZ3M6DQoNCiAg
dG90YWw6IDAgZXJyb3JzLCAwIHdhcm5pbmdzLCA0IGNoZWNrcywgMzIwIGxpbmVzIGNoZWNrZWQN
Cg0KSSBjaGVja2VkIHRoZSByYXcgZW1haWwgb24gbG9yZS5rZXJuZWwub3JnIGFuZCBmb3VuZCB0
aGF0IG91cg0KY29ycG9yYXRlIG1haWwgc3lzdGVtIGlzIGNvbnZlcnRpbmcgdGhlIG9yaWdpbmFs
IHRleHQvcGxhaW4gZW1haWwNCmludG8gYSBtdWx0aXBhcnQgTUlNRSBtZXNzYWdlIHdpdGggYm90
aCB0ZXh0L3BsYWluIGFuZCB0ZXh0L2h0bWwNCmFsdGVybmF0aXZlcy4gSW4gdGhlIEhUTUwgcGFy
dCwgYWxsIHRhYnMgYXJlIHJlcGxhY2VkIHdpdGgNCm5vbi1icmVha2luZyBzcGFjZXMgKEhUTUwg
Jm5ic3A7IGVudGl0eSkuIFRoaXMgaXMgbGlrZWx5IHdoYXQNCnlvdSBhcmUgc2VlaW5nLg0KDQpJ
IHdpbGwgZml4IHRoZSBtYWlsIHNlcnZlciBjb25maWd1cmF0aW9uIGFuZCByZXNlbmQgdGhlIHNl
cmllcy4NCg0KU29ycnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlLCBhbmQgdGhhbmtzIGFnYWluIGZv
ciB5b3VyIHBhdGllbmNlLg0KDQpCZXN0IHJlZ2FyZHMsDQpKdW55YW5nIEhhbg==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGkmbmJzcDtBbmRyZXcsPGJyIC8+DTxiciAvPlRoYW5rJm5ic3A7eW91Jm5ic3A7Zm9yJm5ic3A7
dGFraW5nJm5ic3A7dGhlJm5ic3A7dGltZSZuYnNwO3RvJm5ic3A7cmV2aWV3LjxiciAvPg08YnIg
Lz4mZ3Q7Jm5ic3A7KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3N0cnVjdCZuYnNwO2Rldmxpbmsm
bmJzcDsqZGV2bGluazs8YnIgLz4NPGJyIC8+Jmd0OyZuYnNwOysmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDtpbnQmbmJzcDtyZXQ7PGJyIC8+Jmd0OyZuYnNwOys8YnIgLz4mZ3Q7Jm5ic3A7KyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwO2RldmxpbmsmbmJzcDs9Jm5ic3A7ZGV2bGlua19hbGxvYygmYW1w
O2RoX3BmX2Rldmxpbmtfb3BzLCZuYnNwO3NpemVvZihzdHJ1Y3QmbmJzcDtkaF9jb3JlX2Rldiks
PGJyIC8+Jmd0OyZuYnNwOysmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
YW1wO3BkZXYtJmd0O2Rldik7PGJyIC8+DTxiciAvPiZndDsmbmJzcDtXcm9uZyZuYnNwO2luZGVu
dGF0aW9uLiZuYnNwO0luJm5ic3A7ZmFjdCwmbmJzcDt0aGlzJm5ic3A7c2VlbXMmbmJzcDt0byZu
YnNwO2hhdmUmbmJzcDtzcGFjZXMmbmJzcDtub3QmbmJzcDt0YWJzLiZuYnNwO1doYXQ8YnIgLz4m
Z3Q7Jm5ic3A7ZG9lcyZuYnNwO2NoZWNrcGF0Y2gmbmJzcDtzYXkmbmJzcDthYm91dCZuYnNwO3Ro
ZXNlJm5ic3A7ZmlsZXM/Jm5ic3A7T3ImbmJzcDtpcyZuYnNwO3lvdSZuYnNwO2VtYWlsJm5ic3A7
c3RpbGwmbmJzcDticm9rZW4/PGJyIC8+DTxiciAvPg08YnIgLz5JJm5ic3A7ZG91YmxlLWNoZWNr
ZWQmbmJzcDt0aGUmbmJzcDtwYXRjaCZuYnNwO2ZpbGUmbmJzcDtsb2NhbGx5LiZuYnNwO1RoZSZu
YnNwO2luZGVudGF0aW9uJm5ic3A7ZG9lcyZuYnNwO3VzZTxiciAvPnRhYnMsJm5ic3A7bm90Jm5i
c3A7c3BhY2VzOjxiciAvPg08YnIgLz4mbmJzcDsmbmJzcDskJm5ic3A7Y2F0Jm5ic3A7LUEmbmJz
cDt2My0wMDAxLSoucGF0Y2gmbmJzcDt8Jm5ic3A7Z3JlcCZuYnNwOy1BMyZuYnNwOyZxdW90O2Rl
dmxpbmtfYWxsb2MmcXVvdDsNPGJyIC8+Jm5ic3A7Jm5ic3A7K15JZGV2bGluayZuYnNwOz0mbmJz
cDtkZXZsaW5rX2FsbG9jKCZhbXA7ZGhfcGZfZGV2bGlua19vcHMsJm5ic3A7c2l6ZW9mKHN0cnVj
dCZuYnNwO2RoX2NvcmVfZGV2KSwkPGJyIC8+Jm5ic3A7Jm5ic3A7K15JXkleSV5JJmFtcDtwZGV2
LSZndDtkZXYpOyQ8YnIgLz4mbmJzcDsmbmJzcDsrXklpZiZuYnNwOyghZGV2bGluaykkPGJyIC8+
Jm5ic3A7Jm5ic3A7K15JXklyZXR1cm4mbmJzcDstRU5PTUVNOyQ8YnIgLz4NPGJyIC8+QW5kJm5i
c3A7Y2hlY2twYXRjaC5wbCZuYnNwOy0tc3RyaWN0Jm5ic3A7YWxzbyZuYnNwO3JlcG9ydHMmbmJz
cDswJm5ic3A7ZXJyb3JzLCZuYnNwOzAmbmJzcDt3YXJuaW5nczo8YnIgLz4NPGJyIC8+Jm5ic3A7
Jm5ic3A7dG90YWw6Jm5ic3A7MCZuYnNwO2Vycm9ycywmbmJzcDswJm5ic3A7d2FybmluZ3MsJm5i
c3A7NCZuYnNwO2NoZWNrcywmbmJzcDszMjAmbmJzcDtsaW5lcyZuYnNwO2NoZWNrZWQ8YnIgLz4N
PGJyIC8+SSZuYnNwO2NoZWNrZWQmbmJzcDt0aGUmbmJzcDtyYXcmbmJzcDtlbWFpbCZuYnNwO29u
Jm5ic3A7bG9yZS5rZXJuZWwub3JnJm5ic3A7YW5kJm5ic3A7Zm91bmQmbmJzcDt0aGF0Jm5ic3A7
b3VyPGJyIC8+Y29ycG9yYXRlJm5ic3A7bWFpbCZuYnNwO3N5c3RlbSZuYnNwO2lzJm5ic3A7Y29u
dmVydGluZyZuYnNwO3RoZSZuYnNwO29yaWdpbmFsJm5ic3A7dGV4dC9wbGFpbiZuYnNwO2VtYWls
PGJyIC8+aW50byZuYnNwO2EmbmJzcDttdWx0aXBhcnQmbmJzcDtNSU1FJm5ic3A7bWVzc2FnZSZu
YnNwO3dpdGgmbmJzcDtib3RoJm5ic3A7dGV4dC9wbGFpbiZuYnNwO2FuZCZuYnNwO3RleHQvaHRt
bDxiciAvPmFsdGVybmF0aXZlcy4mbmJzcDtJbiZuYnNwO3RoZSZuYnNwO0hUTUwmbmJzcDtwYXJ0
LCZuYnNwO2FsbCZuYnNwO3RhYnMmbmJzcDthcmUmbmJzcDtyZXBsYWNlZCZuYnNwO3dpdGg8YnIg
Lz5ub24tYnJlYWtpbmcmbmJzcDtzcGFjZXMmbmJzcDsoSFRNTCZuYnNwOyZhbXA7bmJzcDsmbmJz
cDtlbnRpdHkpLiZuYnNwO1RoaXMmbmJzcDtpcyZuYnNwO2xpa2VseSZuYnNwO3doYXQ8YnIgLz55
b3UmbmJzcDthcmUmbmJzcDtzZWVpbmcuPGJyIC8+DTxiciAvPkkmbmJzcDt3aWxsJm5ic3A7Zml4
Jm5ic3A7dGhlJm5ic3A7bWFpbCZuYnNwO3NlcnZlciZuYnNwO2NvbmZpZ3VyYXRpb24mbmJzcDth
bmQmbmJzcDtyZXNlbmQmbmJzcDt0aGUmbmJzcDtzZXJpZXMuPGJyIC8+DTxiciAvPlNvcnJ5Jm5i
c3A7Zm9yJm5ic3A7dGhlJm5ic3A7aW5jb252ZW5pZW5jZSwmbmJzcDthbmQmbmJzcDt0aGFua3Mm
bmJzcDthZ2FpbiZuYnNwO2ZvciZuYnNwO3lvdXImbmJzcDtwYXRpZW5jZS48YnIgLz4NPGJyIC8+
QmVzdCZuYnNwO3JlZ2FyZHMsPGJyIC8+SnVueWFuZyZuYnNwO0hhbg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


