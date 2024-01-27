Return-Path: <netdev+bounces-66380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1363783EB6A
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 07:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E822843DC
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 06:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C180171AB;
	Sat, 27 Jan 2024 06:18:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82CB665
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706336291; cv=none; b=ToVOoaKyuL37MFknr/wNdYh2/yPEd6p010N59Hz+TSppsHZhBeEwIp9lLR1L33TWMvSHEbtfeBdzN+C0NvxYUm5CqlldvpdW2f2uhY/6ks+2x9yvApIUcylMLKoJL51QBBJis6g8HvTDo3ELA3K38fOPFWoUTgNaAAlEsRR4nmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706336291; c=relaxed/simple;
	bh=W87pCcf7DhQ6QauO+qK/YLZNmloMmrL/KdEZQd2hFr4=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=pzBLPl0Yt6ye6Qle7vPoXSsOHI6NAqhxP/iWXbpKCvKAGFkpEMhmbH3bAcFSLKI8onZLaGuKBkaJKcHS7zqPsD2uTs+4+/cLTDcMZwFqwHSWSjBGjf9tveQyHSnZOUvoy4d4q4wOV4ZB0uou7ax3LcV7iXxxzHQeGHPFUIJgF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-GoodBg: 2
X-BAN-DOWNLOAD: 1
X-BAN-SHARE: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-FEAT: ILHsT53NKPj/LiHDt1+y1XznLHkZZf2uvgWXgf6Pb0tJCgu0SMEKyvb5wlLR4
	q49YqnLV2sXYr1iXwImx4LZru9r0mdpWcukEmfxJY7T9usvIyrxTfNumoj2TrUoehmny44A
	GjT4EFxlmX71HFYuJYFsSwHIePf5fd8T5TyrjsXFnrbCuI04V3va3T7CHOQO5mmqcJF1Qit
	GkQDU53TA1cqI80vIYqq25UpMl7lt2VF07mzUve/PVytBrSOQRV5soNHTV3v+s9zMYLGV7W
	82Uupoa+ESwj+zG9hCvQes/quObbV67eAbha5n5DRvXc9/Bh6IjaBq1+2iZhzSlo+aP4qVB
	S1RzBulaGoV5h7E8sq2kA2VbTX85+BOmUHrZeKU12afBdNT28k=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: AODbB5neAqU9hdf4HQV7mHwzb0Gwpuivre2KHH7Mooo=
X-QQ-STYLE: 
X-QQ-mid: t7gz7a-0t1706336280t4934149
From: "=?utf-8?B?6ZmI5ZiJ5piA?=" <jiayunchen@smail.nju.edu.cn>
To: "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>
Subject: Report on Abnormal Behavior of "ip help" Command
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 27 Jan 2024 14:17:59 +0800
X-Priority: 3
Message-ID: <tencent_4889D8DA6825DFE26A4EE1B5@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 14541606569405519984
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 27 Jan 2024 14:18:01 +0800 (CST)
Feedback-ID: t:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

VG8gd2hvbSBpdCBtYXkgY29uY2VybiwNCg0KSSBob3BlIHRoaXMgZW1haWwgZmluZHMgeW91
IHdlbGwuIEkgYW0gd3JpdGluZyB0byByZXBvcnQgYSBiZWhhdmlvciB3aGljaCBzZWVtcyB0
byBiZSBhYm5vcm1hbC4gSSBoYXZlIG9ic2VydmVkICJpcCBoZWxwIiByZXR1cm5zIC0xICgy
NTUpLCBldmVuIGlmIHRoZSBoZWxwIGluZm9ybWF0aW9uIGlzIHByaW50ZWQgdG8gdGhlIHRl
cm1pbmFsIHN1Y2Nlc3NmdWxseS4NCg0KVGhpcyBpcyBwb3RlbnRpYWxseSBjYXVzaW5nIHRy
b3VibGUgd2hlbiB3ZSdyZSBhdXRvbWF0aWNhbGx5IGNoZWNraW5nIHdoZXRoZXIgYSB0b29s
IGlzIGJhc2ljYWxseSB3b3JraW5nLCBieSBjaGVja2luZyBpdHMgcmV0dXJuIGNvZGUgKG5v
cm1hbGx5LCBsaWtlIGNvcmV1dGlscyB0b29scywgLS1oZWxwIHJldHVybnMgMCkuIElzIHRo
YXQgYmV0dGVyIHRvIG1ha2UgaXQgcmV0dXJuIDAgb24gaGVscCwgb3Iga2VlcCAtMSB0byBt
YWtlIGl0IGJhY2t3YXJkIGNvbXBhdGlibGU/DQoNClRoZSBpbmZvcm1hdGlvbiBvbiBteSB3
b3JraW5nIGVudmlyb25tZW50IGlzOiBVYnVudHUyMi4wNCwgaXByb3V0ZTItNS4xNS4wLCBs
aWJicGYgMC41LjAuDQoNClRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIGFuZCBlZmZvcnRzLCBJ
IGFtIGxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5Lg0KDQpCZXN0IHJlZ2FyZHMsDQpD
aGVuIEppYXl1bg==


