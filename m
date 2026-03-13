Return-Path: <netdev+bounces-267332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOADCZHHs2kqawAAu9opvQ
	(envelope-from <netdev+bounces-267332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:15:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA2F27F707
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A38F23169EDB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAB03431E6;
	Fri, 13 Mar 2026 08:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B593161A3;
	Fri, 13 Mar 2026 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389140; cv=none; b=PyF+IrbfjtkQCVhuISK7Uzw0O1v9xDy8BD0Ft6Nkdbu1hKruWvK97aJqvdnGq5qwh3Ce3UHdegzPCGWdSNkaJ/kP6ZuToRVD3B+wrNleO/eiZDHF6GFJCO6+IMGMTK6nki8COX9X34w0/PncW++fu2Y36jO/XVY0YKlNqnvV0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389140; c=relaxed/simple;
	bh=7g0rVe5YRt2IuCl1m+8xOFew56k+2wH7gBl+CcqkD6c=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:References:
	 In-Reply-To:Content-Type; b=Hh6snCPihoItWRLY5cQ1FKg9+Vq+o+XoVBML/Z75VWTDS++Tgp9g2nXJPg2kQRDy28xZLSuDqcZStRihsMn3NIHE4tfzd94uiXX+9SR8qyyUETki8LBG9OsEHNtHalMyYIpkYVUwNfvWLOLZxFZbeBVKp2S8CdBouwSBJrtK5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.8550009|0.1203736;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.190698-0.00531997-0.803982;FP=16993061547175602569|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DW;RN=15;RT=15;SR=0;TI=W4_0.2.3_21251295_1773389119276_o7001c1700;
Received: from WS-web (Illusion.Wang@nebula-matrix.com[W4_0.2.3_21251295_1773389119276_o7001c1700] cluster:ay29) at Fri, 13 Mar 2026 16:05:23 +0800
Date: Fri, 13 Mar 2026 16:05:23 +0800
From: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
To: "Paolo Abeni" <pabeni@redhat.com>,
  "Dimon" <dimon.zhao@nebula-matrix.com>,
  "Alvin" <alvin.wang@nebula-matrix.com>,
  "Sam" <sam.chen@nebula-matrix.com>,
  "netdev" <netdev@vger.kernel.org>
Cc: "andrew+netdev" <andrew+netdev@lunn.ch>,
  "corbet" <corbet@lwn.net>,
  "kuba" <kuba@kernel.org>,
  "linux-doc" <linux-doc@vger.kernel.org>,
  "lorenzo" <lorenzo@kernel.org>,
  "horms" <horms@kernel.org>,
  "vadim.fedorenko" <vadim.fedorenko@linux.dev>,
  "lukas.bulwahn" <lukas.bulwahn@redhat.com>,
  "edumazet" <edumazet@google.com>,
  "open list" <linux-kernel@vger.kernel.org>
Reply-To: "Illusion Wang" <Illusion.Wang@nebula-matrix.com>
Message-ID: <388ff939-2eae-4cee-aac5-ca88dd37ef49.Illusion.Wang@nebula-matrix.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIHY3IG5ldC1uZXh0IDAzLzExXSBuZXQvbmVidWxhLW1hdHJpeDog?=
  =?UTF-8?B?YWRkIGNoaXAgcmVsYXRlZCBkZWZpbml0aW9ucw==?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][null][Chrome]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20260310120959.22015-1-illusion.wang@nebula-matrix.com> <20260310120959.22015-4-illusion.wang@nebula-matrix.com>,<f669062e-16f4-471a-9884-6441c478dd09@redhat.com>
x-aliyun-mail-creator: W4_0.2.3_null_EuMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjY5NDMuMTQyIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4yLjE1LVJlbGVhc2UuMjYwMjI1MDAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAxMjAwIEFyY2hpdGVjdHVyZS94ODZfNjQgd2ViRHQvUEM=uL
In-Reply-To: <f669062e-16f4-471a-9884-6441c478dd09@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nebula-matrix.com:replyto,nebula-matrix.com:mid];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_NA(0.00)[nebula-matrix.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267332-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[Illusion.Wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[Illusion.Wang@nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.844];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 9EA2F27F707
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SSBhbSBzbyBzb3JyeSwgTGFzdCB0aW1lIEkgbWlzc2VkIGEgJ25vdCcKClRoZXNlIGRhdGEgYXJl
IHVzZWQgdG8gY29uZmlndXJlIFA0LXJlbGF0ZWQgcmVnaXN0ZXJzLiBUaGUgZHJpdmVy4oCZcyBm
dW5jdGlvbmFsaXR5CgpkZXBlbmRzIGhlYXZpbHkgb24gdGhlc2UgcmVnaXN0ZXIgc2V0dGluZ3Mu
IFRoZXkgd2lsbCBiZSBkZWNsYXJlZCBhcyBjb25zdC4KCkJ1dCB0aGV5IGNhbiBiZSBub3QgbWFy
a2VkIF9faW5pdGRhdGEuIEJlY2F1c2UgaXQgd2lsbCBiZSBjYWxsZWQgYnkgcGNpX2RyaXZlci5w
cm9iZS4KClRoZXkgYWxzbyBzaG91bGQgbm90IGJlIG1vdmVkIGludG8gZmlybXdhcmUgZmlsZXMs
IGFzIHRoZSBzb2Z0d2FyZSBmdW5jdGlvbmFsaXR5CgppcyB0aWdodGx5IGNvdXBsZWQgd2l0aCB0
aGVzZSBjb25maWd1cmF0aW9ucy4gSWYgdGhleSB3ZXJlIG1vdmVkIHRvIGZpcm13YXJlLAoKdXNl
cnMgY291bGQgZWFzaWx5IGVuZCB1cCB3aXRoIG1pc21hdGNoZWQgdmVyc2lvbnMgb2YgdGhlIGZp
cm13YXJlIGFuZCB0aGUga2VybmVsCgpkcml2ZXIgbW9kdWxlLCBsZWFkaW5nIHRvIGZ1bmN0aW9u
YWwgaW5jb25zaXN0ZW5jaWVzIG9yIHN5c3RlbSBtYWxmdW5jdGlvbnMuCgoKT2xkIExpbms6aHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzViNjIwNWRkLWJjYTgtNDJlMS1iMjgxLTUyYmUx
MWYzMWY2OS5JbGx1c2lvbi5XYW5nQG5lYnVsYS1tYXRyaXguY29tLwo=

