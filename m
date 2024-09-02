Return-Path: <netdev+bounces-124179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1635296865A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439B01C217FF
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C584187550;
	Mon,  2 Sep 2024 11:40:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9446195;
	Mon,  2 Sep 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277216; cv=none; b=YwYeRlXPTnk9w+SfWjbcdCP8excP6mTuJwyreev9morvPzbn/c+r1AE35ykRaZaJ/NAmCDxVxWBYJ25hLrdfUhNIfj4Lqdla/007vw4rDzXOhwmbEp1G8+/tedFNq1AdwXb3VwlqjS0ZyhJstiZotbHLL2hRo8ZtuHix2j3uL1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277216; c=relaxed/simple;
	bh=VESC8W8ZnKWXDwdhkGq8CoyYDiNDMAQsT0XWy7z8/xs=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=TxuSfzV18RqPnRN7vTZLS3/H1YaUCYIwkjmMQJU3c3Dl1Kh6GMy5U7qfJanx7rIGvoInV7WL/7NXaMvEckwKw5bSEJnaEmaqbFOFY5GA78i6l53owyGAZs6gsMAfa4PiRtweGioRpwKbTplxqxy/e6q/0Vpt+hG56W416Q9pd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000000000
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-XMAILINFO: M1tjFO1fqc+09Asn1RkKL2iwftXwjDph7EWLDRN36iIb7bEnPphwSZ0j
	8AkdGU7Tn/9mjQAQQdxjdatyZ5YBIVAS7BNFRKV+9qy2RESXuKqXwkenB115CXAJLsGJ0kV
	3/usC2FbOnrB3wjeFv+A7iwdNfnUi068qiuPxossruxOHGnKWYC5M9dOfygKznao24IwxDU
	lbr+eugvq0qbXx5qfy9SHXYiIdod7yi9QQeCidvP5D9cl3UbFXRKRsVSHutShYWyHUgvUZC
	CaW6ihu0o4YpBOzI8PGPMVXNtEl/kwxz/tOe/9W2e2YU4c1iIkr17h+XcLdALRkrsgaD54D
	mMJftO/men5bMC835OkDOAKRFAuhfGqkhRxtNDYPovgZminsqWLctyp8I2Ph7sKng++uGQl
	ZZPunX12BJPerrMBrQCJTtBLiNveRVorrM5uGaMPLc7JKwmJQCmU2pYrHMjfMg/m45xGPi5
	NPjCS4Chfr5MFCWXye9eRbixbzbtg7g9A6cSa7d/bcFiNMFnHg3BZ2SNufVCVQ4ri3bxkIh
	wTQT9HQ8c5FWx78MJyJiqnWcr6bsEYQTW41Lq5ebWJ3t21RQu/jFxuk3AjkvM3GibIeF6GK
	et5QJ98Z1Ftr5RajC036ayfPEnklKiQqhTU4g4dFBh9QJVwBnMFNXZQKPXv1AFKntDyMiCk
	4MV24giexrtjImKBcGFZqadUmrzcM6qD8tyRjmXJDpYnVyqY1N3zOS08cStonNLb/JK97B/
	xTAL38Ep5ujUNcpgMNIfeDiYNfP/t9wPkhJTrxR1+vMGwJkDRe0PPTDaV+1w6NHUbX5dW1w
	eIA6yvqkwFNIRfsc+pnrsYq8ZtuwYR5knqR75rU/LseQ6v6aQpZ1rDAZJ45rWTnAFmCMVAO
	royIhwjMdGiJOMRFDYW5uZ5rUU5G/XE3QDYypgI6G+ytkDd6/MHEEA==
X-QQ-FEAT: 2Rmh/KmsIngRz4f3Vdqk0FJ5i7Yws3Tu
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: +voWeeea4CR6tuKXEBLtLqxdpPrmOzXy1CGecblwJfE=
X-QQ-STYLE: 
X-QQ-mid: t6sz3a-0t1725277062t4151801
From: "=?utf-8?B?V2VudGFpIERlbmc=?=" <wtdeng24@m.fudan.edu.cn>
To: "=?utf-8?B?UnVzc2VsbCBLaW5nIChPcmFjbGUp?=" <linux@armlinux.org.uk>
Cc: "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?5p2c6Zuq55uI?=" <21210240012@m.fudan.edu.cn>
Subject: Re: [BUG] Possible Use-After-Free Vulnerability in ether3 Driver Due to Race Condition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 2 Sep 2024 19:37:41 +0800
X-Priority: 3
Message-ID: <tencent_50BA792913CC5DFE57798C1F@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_4212C4F240B0666B49355184@qq.com>
	<ZtWD+/veJzhA9WH2@shell.armlinux.org.uk>
In-Reply-To: <ZtWD+/veJzhA9WH2@shell.armlinux.org.uk>
X-QQ-ReplyHash: 3514819522
X-BIZMAIL-ID: 7732441694849649170
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 02 Sep 2024 19:37:42 +0800 (CST)
Feedback-ID: t:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz7a-0

QXBvbG9naWVzIGZvciBzZW5kaW5nIHRoZSBlbWFpbCBpbiB0aGUgd3JvbmcgZm9ybWF0LiBJ
J2xsIGNvcnJlY3QgaXQgYW5kIHJlc2VuZCBpdCBzaG9ydGx5Lg0KDQogIC0tLS0tLS0tLS0t
LS0tLS0tLSBPcmlnaW5hbCAtLS0tLS0tLS0tLS0tLS0tLS1Gcm9tOiAgIlJ1c3NlbGwgS2lu
ZyAoT3JhY2xlKSI8bGludXhAYXJtbGludXgub3JnLnVrPjtEYXRlOiAgTW9uLCBTZXAgMiwg
MjAyNCAwNToyMyBQTVRvOiAgIldlbnRhaSBEZW5nIjx3dGRlbmcyNEBtLmZ1ZGFuLmVkdS5j
bj47IENjOiAgImRhdmVtIjxkYXZlbUBkYXZlbWxvZnQubmV0PjsgImVkdW1hemV0IjxlZHVt
YXpldEBnb29nbGUuY29tPjsgImt1YmEiPGt1YmFAa2VybmVsLm9yZz47ICJwYWJlbmkiPHBh
YmVuaUByZWRoYXQuY29tPjsgImxpbnV4LWFybS1rZXJuZWwiPGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZz47ICJuZXRkZXYiPG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+
OyAibGludXgta2VybmVsIjxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgIuadnOmb
quebiCI8MjEyMTAyNDAwMTJAbS5mdWRhbi5lZHUuY24+OyBTdWJqZWN0OiAgUmU6IFtCVUdd
IFBvc3NpYmxlIFVzZS1BZnRlci1GcmVlIFZ1bG5lcmFiaWxpdHkgaW4gZXRoZXIzIERyaXZl
ciBEdWUgdG8gUmFjZSBDb25kaXRpb24gT24gTW9uLCBTZXAgMDIsIDIwMjQgYXQgMDE6MTk6
NDNQTSArMDgwMCwgV2VudGFpIERlbmcgd3JvdGU6PiBJbiB0aGUgZXRoZXIzX3Byb2JlIGZ1
bmN0aW9uLCBhIHRpbWVyIGlzIGluaXRpYWxpemVkIHdpdGggYSBjYWxsYmFjayBmdW5jdGlv
biBldGhlcjNfbGVkb2ZmLCBib3VuZCB0byAmYW1wO3ByZXYoZGV2KS0mZ3Q7dGltZXIuIE9u
Y2UgdGhlIHRpbWVyIGlzIHN0YXJ0ZWQsIHRoZXJlIGlzIGEgcmlzayBvZiBhIHJhY2UgY29u
ZGl0aW9uIGlmIHRoZSBtb2R1bGUgb3IgZGV2aWNlIGlzIHJlbW92ZWQsIHRyaWdnZXJpbmcg
dGhlIGV0aGVyM19yZW1vdmUgZnVuY3Rpb24gdG8gcGVyZm9ybSBjbGVhbnVwLiBUaGUgc2Vx
dWVuY2Ugb2Ygb3BlcmF0aW9ucyB0aGF0IG1heSBsZWFkIHRvIGEgVUFGIGJ1ZyBpcyBhcyBm
b2xsb3dzOj4gPiA+IENQVTAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7IENQVTE+ID4gPiAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7IHwmbmJzcDsgJm5ic3A7ZXRoZXIzX2xlZG9mZj4gZXRoZXIzX3JlbW92ZSZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDt8PiAm
bmJzcDsgJm5ic3A7IGZyZWVfbmV0ZGV2KGRldik7Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7fD4gJm5ic3A7ICZuYnNwOyBwdXRfZGV2aWNlJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IHw+ICZuYnNwOyAmbmJzcDsga2ZyZWUoZGV2KTsm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDt8PiAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IHwmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDtldGhlcjNfb3V0dyhwcml2KGRldiktJmd0O3JlZ3MuY29uZmlnMiB8
PSBDRkcyX0NUUkxPLCBSRUdfQ09ORklHMik7PiAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7IHwmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsvLyB1c2Ug
ZGV2VGhpcyBpcyB1bnJlYWRhYmxlLj4gUmVxdWVzdCBmb3IgUmV2aWV3Oj4gPiA+IFdlIHdv
dWxkIGFwcHJlY2lhdGUgeW91ciBleHBlcnQgaW5zaWdodCB0byBjb25maXJtIHdoZXRoZXIg
dGhpcyB2dWxuZXJhYmlsaXR5IGluZGVlZCBwb3NlcyBhIHJpc2sgdG8gdGhlIHN5c3RlbSwg
YW5kIGlmIHRoZSBwcm9wb3NlZCBmaXggaXMgYXBwcm9wcmlhdGUuUGxlYXNlIHJlc2VuZCB3
aXRob3V0IHRoZSBIVE1MIGp1bmsgaW4gdGhlIHBsYWluIHRleHQgcGFydC4tLSAqKiogcGxl
YXNlIG5vdGUgdGhhdCBJIHByb2JhYmx5IHdpbGwgb25seSBiZSBvY2Nhc2lvbmFsbHkgcmVz
cG9uc2l2ZSoqKiBmb3IgYW4gdW5rbm93biBwZXJpb2Qgb2YgdGltZSBkdWUgdG8gcmVjZW50
IGV5ZSBzdXJnZXJ5IG1ha2luZyoqKiByZWFkaW5nIHF1aXRlIGRpZmZpY3VsdC5STUsncyBQ
YXRjaCBzeXN0ZW06IGh0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0
Y2hlcy9GVFRQIGlzIGhlcmUhIDgwTWJwcyBkb3duIDEwTWJwcyB1cC4gRGVjZW50IGNvbm5l
Y3Rpdml0eSBhdCBsYXN0IQ==


