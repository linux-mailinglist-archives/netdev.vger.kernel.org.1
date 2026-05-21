Return-Path: <netdev+bounces-290367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNx6GOvuDmqwDAYAu9opvQ
	(envelope-from <netdev+bounces-290367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:39:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD47D5A4215
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F6AF3058BB0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E13A544E;
	Thu, 21 May 2026 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+0YsV/G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0534245005
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363300; cv=pass; b=JovDD/50/bSzT8pZZ3tv9LRKBUfN3iJfCJHy9kWPkIgGFDxBaYRT8jM+z1bOtwdMY5lQZSxIMtegB/HPPb6qKCbEOcrAezWOwbxK3H/bNoywOJsMrhOlvifF7qxajZT8CPTj1PqWyYn9wtarmbkGw36cDzNhFf2Tq1h+JJadpGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363300; c=relaxed/simple;
	bh=aP5nBTKLtR0vHJWPnsAD++f7w9vfSgrU4tPms/fSVo8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OkYzdWz6vulF8mCb6ujEnArStw5wrk4/E+o+CXp6wsL8UOH/0I20PClFZVHHR3+fWAbb3jrNPUpPU3d+oICbBNwuQCsLvpW/4I296l74ISST6WKDgfOatc9Az5OY7BPJ4ZipulgD6BpMrLKttEP49LNfASg+2LC3qAbU9wAJHyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+0YsV/G; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67cac5ece75so11963354a12.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 04:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779363297; cv=none;
        d=google.com; s=arc-20240605;
        b=UwtJpWC5nhESeuCQPPmGPNvGu7z+XikVoQEs+cNJWlUQvTzq8a+y6Ksf3hlKt9YtXZ
         ACL5xDjLMdtwCfD9A8hO4tMdk0bl5A6uq7BFEmvj0W3OC0OsaY4SIAbnaNlZ1cUn0Uwx
         oPunDtvF+7Pz/K5ZWYnpOO4vWsLLl/5wYTesoQ/UUs90cQNyDfDtG4fs+7JKjTi9W7M8
         byMtKzG4u9ykPJU0kNmNSXKHtJOcpsSiuGorCqL1TTIimV6GsXJVlWeugXKtQ2gFEH3H
         u0Xob/8SFZR+mW7is2vK/L/snlXwIAK0Mpc4nQEtqdf84JDhAwh0g/K2cQ1FeJV2gujt
         XGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=yMvH2WdgZuCTGd18yRhISQQx/gCPgVQoP0rFR24imCU=;
        fh=rMOQLuS+UgXFcmpkSm38yeUn7tfMLQy9YfFUPWftp2M=;
        b=V+4F++9mcStkZNs/0887gveMRTNDDu0fdHhXcPYtkniL1F2E2eaayXg0luGFC6mTZ+
         wLpkBxJ1M6KUt/7h41CDYw7l9BriEeyC7NzJ1dK4QOCNQ+kmsdpEMCmZ4b0MFX45+yux
         o5ZxbyooEtoaK5mAK4PJbVwVQ/8U31B/r/ELMlQc1pozl9KCOpfKZl0pAPUBa4oygURk
         9vSOunpLMfuESsGSiJVWJ79IhTU/WROBA6L7KVqV9iEjBNKUKW0qOz4SYVvjfvJPSQs9
         ibJAWnyzLJh8Jg6RFddiGicqQgwQBaNaxuE48PEmL6cdlTQFkKaBzy0a4ZTSUVNAmqLE
         LNcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779363297; x=1779968097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yMvH2WdgZuCTGd18yRhISQQx/gCPgVQoP0rFR24imCU=;
        b=h+0YsV/GivF3fatPQtZmV27otUZNrMOi7YwEH/k0vHOxK1/3WTN7ykmTh/CqscaLHO
         h0bH92e70byDNlQaHokH66rKtXJyC0/BaDDtEBKnZnhP+ZjzeK6KuK0MbLW8pWWbqUrE
         6TPNxK4KjouVs49PC3KxQEId8UaN4lFTIN48VG8Sfi9lDFIAfJ77QzEwOLEa/kvATbdw
         mjGg+wFJWeczpDtscJhqSmtw0kPadkYmxv3Xjoc327pgQR5TTkdCpN8xdxRd1unlxDZO
         BSRga166v3IFkzw+IXeW2cJ38sKjLumRPlpvAXfjTUnlq7/tNQUMHNqYPn3G6xvumzQ0
         +KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779363297; x=1779968097;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMvH2WdgZuCTGd18yRhISQQx/gCPgVQoP0rFR24imCU=;
        b=Z9Frx38UBZsJD/azyVU4po2PtPTr+v6ikH7Tyeh0nYrOtlmGQA54pFfBQTbNr0RxIn
         iaaVnQzzvM51Dadw11VbGAHcjXPvYywBx4l0cHaUlUsvqEk5e9TLhsrRrN4Vn0GABNG5
         n1x9yajt4GKSQYrfl0DwUXqaMqAMU08jpIukAVYELo2o6AhFJT3xSkqgke5mJwFpMAbg
         2oBGU4RykB7yZ20U7bVhCyGa0EyBimHPWERyXrsPRKIbjB0XQzT9rez5RhHvkjbn7YHB
         ymnu13Kp9zX6xVm/E59DSnc+EXVl/OnTfLc497lAZ9/ruy5bi03DrsAqvOIh8hrTH/xX
         9EWg==
X-Gm-Message-State: AOJu0YwG3ObTeqW3GZuM7fH/1eE7/LunS6+1DLrks9Wy1vMIyA1hHVof
	BR0v+cF7W0p2QeGQC+ZTYmfIs08FyhNfNGv+ecMunnchkEBUjcErVD6kB/STGTz7uaHsGqL4RdY
	3oLpoqS8fnHWuUb4jKD+JyyrbqIopmFb3zTHb
X-Gm-Gg: Acq92OHEhQ3GO+Vb2bsJH1YoeGV+Qjo+obGqJoU5jzxLN3/NxblTR74P4Yu9HwBSp3G
	nLO3QRK82n3nOJi/VbYAYx1XdAEun83k9tKey/MZMi5CM2xHWIBu70flAFvld4+SsexuOOtJ29A
	1YeJA96vAgUiTDCTm4IrbkXbRnqKmW/zT94jJqx58RK664xZmCSgMasb67I74AFPStd5vDOZrys
	4B7lhwOgUtmRuHlkjZyZMLfzUEDg1HE/lUpDrWqPgjHJBGq61U5jYiNqKkihfNaTNliJkQn8XUS
	oQxCLcR37VrRDiYH72UGRsPahW4+kbjUsya1CiydJP+9bIdcBUNMyEy4jIwRrr7EFDi+e2DIrbt
	mLBEc5FW9aBwTOaWZjX2ee63NqA==
X-Received: by 2002:a05:6402:358f:b0:678:ce1e:a5cb with SMTP id
 4fb4d7f45d1cf-688365d4845mr1351765a12.21.1779363296741; Thu, 21 May 2026
 04:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Takao Sato <takaosato1997@gmail.com>
Date: Thu, 21 May 2026 20:34:43 +0900
X-Gm-Features: AVHnY4KElvMa4mLV9ZPI4lobp0MxymQb5B9M1nyQC5SMpj0V-vN1okvPKSUV9Xs
Message-ID: <CA+Dks+FXQju7ih8BMYAdOu+qhzGm2tr4A0qEr1PUcsoJt7A4JA@mail.gmail.com>
Subject: [PATCH net] xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: multipart/mixed; boundary="0000000000003acb220652524d88"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290367-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takaosato1997@gmail.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BD47D5A4215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000003acb220652524d88
Content-Type: multipart/alternative; boundary="0000000000003acb220652524d86"

--0000000000003acb220652524d86
Content-Type: text/plain; charset="UTF-8"

Hi

Thank you for the review. Please find v3 attached with the security impact
description removed from the commit message as requested.

Thanks,
Takao Sato

--0000000000003acb220652524d86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><br><div>Thank you for the review. Please find v3 at=
tached with the security impact description removed from the commit message=
 as requested.<br><br>Thanks,=C2=A0<br>Takao Sato</div></div>

--0000000000003acb220652524d86--
--0000000000003acb220652524d88
Content-Type: application/octet-stream; 
	name="0003-xfrm-iptfs-preserve-shared-frag-marker-v3.patch"
Content-Disposition: attachment; 
	filename="0003-xfrm-iptfs-preserve-shared-frag-marker-v3.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mpfesuw00>
X-Attachment-Id: f_mpfesuw00

RnJvbSAxYjBkNThiN2FlMjdmZGJiYjAzMGVhZjE0NmRlZjllMjc5YTgzMmZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYWthbyBTYXRvIDx0YWthb3NhdG8xOTk3QGdtYWlsLmNvbT4K
RGF0ZTogV2VkLCAyMCBNYXkgMjAyNiAwMjo0MTozMyAtMDMwMApTdWJqZWN0OiBbUEFUQ0ggbmV0
IHYzXSB4ZnJtOiBpcHRmczogcHJlc2VydmUgc2hhcmVkLWZyYWcgbWFya2VyIGluCiBpcHRmc19j
b25zdW1lX2ZyYWdzKCkKCmlwdGZzX2NvbnN1bWVfZnJhZ3MoKSB0cmFuc2ZlcnMgcGFnZWQgZnJh
Z21lbnRzIGZyb20gb25lIHNvY2tldCBidWZmZXIKdG8gYW5vdGhlciBidXQgZmFpbHMgdG8gcHJv
cGFnYXRlIHRoZSBTS0JGTF9TSEFSRURfRlJBRyBmbGFnLiBUaGlzIGlzCnRoZSBzYW1lIGNsYXNz
IG9mIGJ1ZyB0aGF0IHdhcyBmaXhlZCBpbiBza2JfdHJ5X2NvYWxlc2NlKCkgZm9yCkNWRS0yMDI2
LTQ2MzAwOiB3aGVuIGZyYWdtZW50cyBiYWNrZWQgYnkgcmVhZC1vbmx5IHBhZ2UtY2FjaGUgcGFn
ZXMgYXJlCm1lcmdlZCwgdGhlIG1hcmtlciBpbmRpY2F0aW5nIHRoZWlyIHNoYXJlZCBuYXR1cmUg
bXVzdCBiZSBwcmVzZXJ2ZWQgc28KdGhhdCBFU1AgY2FuIGRlY2lkZSBjb3JyZWN0bHkgd2hldGhl
ciBpbi1wbGFjZSBlbmNyeXB0aW9uIGlzIHNhZmUuCgpBcHBseSB0aGUgc2FtZSB0d28tbGluZSBm
aXggdXNlZCBpbiBza2JfdHJ5X2NvYWxlc2NlKCkgdG8KaXB0ZnNfY29uc3VtZV9mcmFncygpLgoK
Rml4ZXM6IGI5NmJhMzEyZTIxYyAoInhmcm06IGlwdGZzOiBzaGFyZSBwYWdlIGZyYWdtZW50cyBv
ZiBpbm5lciBwYWNrZXRzIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA2LjgrClNpZ25l
ZC1vZmYtYnk6IFRha2FvIFNhdG8gPHRha2Fvc2F0bzE5OTdAZ21haWwuY29tPgotLS0KIG5ldC94
ZnJtL3hmcm1faXB0ZnMuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9uZXQveGZybS94ZnJtX2lwdGZzLmMgYi9uZXQveGZybS94ZnJtX2lwdGZz
LmMKaW5kZXggOTdiYzk3OWU1Li40ZGI4NWUxNTggMTAwNjQ0Ci0tLSBhL25ldC94ZnJtL3hmcm1f
aXB0ZnMuYworKysgYi9uZXQveGZybS94ZnJtX2lwdGZzLmMKQEAgLTIxNjgsNiArMjE2OCw4IEBA
IHN0YXRpYyB2b2lkIGlwdGZzX2NvbnN1bWVfZnJhZ3Moc3RydWN0IHNrX2J1ZmYgKnRvLCBzdHJ1
Y3Qgc2tfYnVmZiAqZnJvbSkKCW1lbWNweSgmdG9pLT5mcmFnc1t0b2ktPm5yX2ZyYWdzXSwgZnJv
bWktPmZyYWdzLAoJICAgICAgIHNpemVvZihmcm9taS0+ZnJhZ3NbMF0pICogZnJvbWktPm5yX2Zy
YWdzKTsKCXRvaS0+bnJfZnJhZ3MgKz0gZnJvbWktPm5yX2ZyYWdzOworCWlmIChmcm9taS0+bnJf
ZnJhZ3MpCisJCXRvaS0+ZmxhZ3MgfD0gZnJvbWktPmZsYWdzICYgU0tCRkxfU0hBUkVEX0ZSQUc7
Cglmcm9taS0+bnJfZnJhZ3MgPSAwOwoJZnJvbS0+ZGF0YV9sZW4gPSAwOwoJZnJvbS0+bGVuID0g
MDsKLS0gCjIuNDMuMAo=
--0000000000003acb220652524d88--

