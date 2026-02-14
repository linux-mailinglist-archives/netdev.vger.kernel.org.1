Return-Path: <netdev+bounces-258704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFuDK4BxkGncZgEAu9opvQ
	(envelope-from <netdev+bounces-258704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:58:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2394613BFD8
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D5E230157FB
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 12:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88730BF69;
	Sat, 14 Feb 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="t8E2frql"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F712701CB;
	Sat, 14 Feb 2026 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771073906; cv=none; b=u7CWuN1Q5eqMm0+UgXUJKzlv94blTrdywc0B80sOrdOLJC5E7pzlBEDRkggfAV7C19CutfvWEVnL9K3FasuadkZYXg/AzXST6BQUuCoXORgJOlhB31fXI+9kElkZ6oEARr1UVGhvgfXPPH2NWmqVnzl0LBss3OGbbHLdfFEjJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771073906; c=relaxed/simple;
	bh=W8A8g2qWmEpP4o/TxlFpdC3YmPi+aRf5GTb6INyo0fM=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=fFi1jEOIlmUVEA06VaQVHpQUYoPaTN9+mrpHK6G2wRqW5trKhwJYKxb5UUn8ZspdWom2W1024r4/kn8aqyeMNf+Z2IsvXX09sk5XbV29GdUJlQptPnLjc/VhPBABhTOdNnlX+CJm4l+s8MsWGYDYZO7/JfSw9/h88zT6+aYzTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=t8E2frql; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1771073868;
	bh=W8A8g2qWmEpP4o/TxlFpdC3YmPi+aRf5GTb6INyo0fM=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=t8E2frqlr9n50Daug9aWZXU0/3RNDOMt6s04rx5xUrZ1d+vluntpI729glCn3O880
	 8LBJikX21LXh0bMFFvZ3xxi0Q3foptrpRgukgNFG2qzp2UmgvxuHI2foObgU3N9vF8
	 lh3zlXnf2XdlAaf4mI9NVo9Ybug7ZxPK6bkXMuM0=
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqR3BzPw6xF2yYOMzhADaK1k6/GpcrrpT/I=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 79+WDgcPixSUuHdDzyLhrs5cGFI4zjnAdGjh3Qgm/Yg=
X-QQ-STYLE: 
X-QQ-mid: lv3gz6b-1t1771073862tfe5d746b
From: "=?utf-8?B?5Yav5ZiJ5Luq?=" <23210240148@m.fudan.edu.cn>
To: "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>
Cc: "=?utf-8?B?ZHNhaGVybg==?=" <dsahern@kernel.org>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: [BUG] Potential Null Pointer Dereference in rt6_device_match Function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 14 Feb 2026 20:57:41 +0800
X-Priority: 3
Message-ID: <tencent_080DAAF351096CB43CF4BC40@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 15226508013664464835
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 14 Feb 2026 20:57:42 +0800 (CST)
Feedback-ID: lv:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NSRW7JPcNpf/Xn0snypuk43OfT60EIt4DB3bivtoIHDh6nwpLkx3FdCh
	9OprFOtdEJTnKMWpH4K9kZsJDcppFX/Sj1raDyT8602J8qp6aITqh66UTEnZtFKWMCAT1Fc
	vcafsYeH7FIG4b+nQrWeiLWSgzh4KMEoXDxzj4Dz6h9hALGwUPyKzzmuRZDyW+70ZtSd8a6
	wdCbBpKLANRbJDFZfRidPJCOiRlI0UyN7cFT98viHkriJ2cS4h1KIFadfp+X0l2hm4BYhG1
	u3A4CuiD4sgll3IcDOhZR6jkUEqJRTAX5r0HilOYaYb/+XdyXjLp4/ao0mdgQFNGIyb1y5G
	DmcnhJyDfO6BVBTQat6qOGvBDkwn+8uIlialNBqsz0IyqS3zifv+97/keUAiDgutcHFUmLK
	0j1/Xev6a6yW3DO4ph0D8bsSBBaNiTmiU/hpxyT52KobFkal0em69dyMuPsU+UCQ2Swnl61
	CESpGCStNKDGxVckmysYNhEZsJkaDWCjh1IpmzUR7DHvUq0U/NwfzWYBtym0Y0/rPr8OHkJ
	DxRT2qn6PBgT75bu3nPeqKyqvSb6FemfIveCNpyz2vY96wUTu8VAs6mBYknpQsLJjLxmiMA
	2A4q3AQTjkgCiYQBzUFaTbHFHAZuqbqOPMuNkithq+JXHzAeZZm//p2yOWPK5jA90qqVZOF
	evug3lf9t7+1dwPxuI6sPxUdV/+bSaAko1kPb92/sMZmInhKDBmrMELZ6GKZogta5fN7W6o
	E/AEraz5vvtaJVFbLVTAcByzjCRd/5/pzDTJTP39emSProdIoYHARuPF7/ToYOOB2KsDc0K
	tyUpT5zL6PcMLpOhMy0furLOKNVeT8D66mCLKZgsUAjOWjUrLaAnmdOQaOBJKjyiXD/O2wF
	o22JGdwrhU1+sQ8jIsjLIYIT2Jnpn1QQdLhkb+U8S3iNTOMijtQADCS8c9G+vm48x9q5hZs
	qY+UbxspjiDCbJWLmoG+DqhHMU9keXiCFEWeDCVrYl5xH1hM1m7DuBUvSAWfYlWHfJZqQ+j
	L10WC4Zr1+Jc5LZEyX0Gyw9KME2dZu5Hc2VQwws619tfSyK5KcvDlxaLji5wuKEEY3RYnNh
	A==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[m.fudan.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[m.fudan.edu.cn:s=sorc2401];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258704-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[m.fudan.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[23210240148@m.fudan.edu.cn,netdev@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,m.fudan.edu.cn:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 2394613BFD8
X-Rspamd-Action: no action

RGVhciBNYWludGFpbmVyLA0KDQpPdXIgdGVhbSByZWNlbnRseSBkZXZlbG9wZWQgYSBudWxs
LXBvaW50ZXItZGVyZWZlcmVuY2UgKE5QRCkgdnVsbmVyYWJpbGl0eSBkZXRlY3Rpb24gdG9v
bCwgYW5kIHdlIHVzZWQgaXQgdG8gc2NhbiB0aGUgTGludXggS2VybmVsICh2ZXJzaW9uIDYu
OS42KS4gQWZ0ZXIgbWFudWFsIHJldmlldywgd2UgaWRlbnRpZmllZCBhIHBvdGVudGlhbGx5
IHZ1bG5lcmFibGUgY29kZSBzbmlwcGV0IHRoYXQgY291bGQgbGVhZCB0byBhIG51bGwtcG9p
bnRlciBkZXJlZmVyZW5jZSBidWcuIFdlIHdvdWxkIGFwcHJlY2lhdGUgeW91ciBleHBlcnQg
aW5zaWdodCB0byBjb25maXJtIHdoZXRoZXIgdGhpcyB2dWxuZXJhYmlsaXR5IGNvdWxkIGlu
ZGVlZCBwb3NlIGEgcmlzayB0byB0aGUgc3lzdGVtLg0KDQpWdWxuZXJhYmlsaXR5IERlc2Ny
aXB0aW9uOg0KRmlsZTogIG5ldC9pcHY2L3JvdXRlLmMNCkluIHRoZSBmdW5jdGlvbiBydDZf
ZGV2aWNlX21hdGNoLCB3ZSBmb3VuZCB0aGUgZm9sbG93aW5nIGxpbmUgb2YgY29kZToNCg0K
aWYgKG5oLT5maWJfbmhfZmxhZ3MgJiBSVE5IX0ZfREVBRCkgew0KDQpUaGUgaXNzdWUgYXJp
c2VzIGJlY2F1c2UgdGhlIG5oIHBvaW50ZXIgbWF5IGJlIHBhc3NlZCBhcyBOVUxMIGluIGNl
cnRhaW4gc2l0dWF0aW9ucy4gU2luY2UgbmggaXMgTlVMTCwgYWNjZXNzaW5nIG5oLT5maWJf
bmhfZmxhZ3MgaW4gdGhlIHN0YXRlbWVudCBjb3VsZCByZXN1bHQgaW4gYSBudWxsLXBvaW50
ZXIgZGVyZWZlcmVuY2UuDQoNClByb3Bvc2VkIEZpeDoNClRvIHByZXZlbnQgdGhlIHBvdGVu
dGlhbCBudWxsLXBvaW50ZXIgZGVyZWZlcmVuY2UsIHdlIHN1Z2dlc3QgYWRkaW5nIGEgTlVM
TCBjaGVjayBmb3IgdGhlIG5oIHBvaW50ZXIgYmVmb3JlIGF0dGVtcHRpbmcgdG8gZGVyZWZl
cmVuY2UgbmgtPmZpYl9uaF9mbGFncyBpbiB0aGUgbGluZS4NCg0KUmVxdWVzdCBmb3IgUmV2
aWV3Og0KV2Ugd291bGQgYXBwcmVjaWF0ZSB5b3VyIGV4cGVydCBpbnNpZ2h0IHRvIGNvbmZp
cm0gd2hldGhlciB0aGlzIHZ1bG5lcmFiaWxpdHkgaW5kZWVkIHBvc2VzIGEgcmlzayB0byB0
aGUgc3lzdGVtLCBhbmQgaWYgdGhlIHByb3Bvc2VkIGZpeCBpcyBhcHByb3ByaWF0ZS4gSWYg
dGhlcmUgYXJlIHJlYXNvbnMgd2h5IHRoaXMgaXNzdWUgZG9lcyBub3QgcHJlc2VudCBhIHJl
YWwgcmlzayAoZS5nLiwgdGhlIE5VTEwgY2hlY2sgaXMgcmVkdW5kYW50IG9yIHVubmVjZXNz
YXJ5KSwgd2Ugd291bGQgYmUgZ3JhdGVmdWwgZm9yIGNsYXJpZmljYXRpb24uDQoNClRoYW5r
IHlvdSBmb3IgeW91ciB0aW1lIGFuZCBjb25zaWRlcmF0aW9uLg==


