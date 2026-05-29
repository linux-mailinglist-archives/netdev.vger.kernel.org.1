Return-Path: <netdev+bounces-293134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMgPNj+hGWq7xwgAu9opvQ
	(envelope-from <netdev+bounces-293134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:22:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4180C603749
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22CD23249F33
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6EA30F934;
	Fri, 29 May 2026 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="pppsoiza"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686FF19E96D
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064020; cv=pass; b=my+i7Q8K8McfyGGi5AsVzEXmcn3siE27LEsCdxeeBTXU3UbNGdx34S5fEe6u1NFV7KrhB+/rVnBqKQx3LQFpsNK5gKk5TBjyqiulgxyypBcAPFqrmaZyHoa+CNOHP+QcA4navCcfm+I5iC/6fjbHKuFjnN/F3eP/av036I0lVfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064020; c=relaxed/simple;
	bh=IO/YFPRgNajc6XStG8eCy9xjEm5grYWbIdLNhKrND3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efGeaeXvb+eNMxmYriEmEkdvWhdYG6E7Wc1drZi7JJHxPFt29rFIfd7zpw1GDIidN7Di2UDOxOZX0HbpiSKTXUZs0GdhlArunuN4D2RWq6JsDwFRucLCElItSc7CH2hZydsoUqOBSk5nkoRzIkkxF2hDvP6iXGJRFKxBm78IFrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=pppsoiza; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-83945063f70so6725132b3a.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780064018; cv=none;
        d=google.com; s=arc-20240605;
        b=Zk+0fbnhtjkOLv9OkljWNKIJYzmGwyp+xc2qyjhc0cJlb43UHro7hWYCWWMpLdM8xF
         63tpXAuW0Eo1qD9ZI2s37xaBTt0fGAmdZeC4TUiMevlW1uOh3fp8ukswINO8KxJ8hiaw
         izls13sNKvGJd+5yREEmEltV3MEfioU73fYo3orURlTydu6gNtXsMET6cJdSxpLUG9nI
         r6gCFKRBEUvo/aKlK58b5LhbpoOdsuQRsZB+Dp8OP/l7bWK0JKooWzl3lERzZG189ajf
         I5auCZCu8JyYNLWxpDuJnO0YRkt0Xl1jbtTPOgVG1mUObXi0xfEIMepaYqf0nVxf0K+W
         2y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IO/YFPRgNajc6XStG8eCy9xjEm5grYWbIdLNhKrND3k=;
        fh=bemypGnOICR+NY6gNUZmR9H1RcYZY7hhmOXIHIsjNgI=;
        b=TSPs1kRTQv+tS/iWltV+7z9C0Wc/rEzFVVTywIm8ZkZRhw34hZxTMnAgKmNcPkQoHG
         Vzd2LI3wgVM+hNxnV8NCq1VDU7IkD7S3gHyyPvIyowH/4Quf8UAhl2Hs4HLsPZxKRXqy
         3hXIGTXgMuT75CvX9okTHDCDb4zysfQxlkMsvQUfvbzGVWwt59a5N1UDsZ1wI+KUdjVK
         8mrVthEbwU1fBlh4QLdqsJLMGRXGKF/s/3Tqh5O+yahtk1CeIOQfxMPiZanKwOEHsEQI
         vYx1sezfpnfPKKLPynZWlz4/vNZ910e2FaMVrN4LLdllz4wGs/GyRS2DxdjwXsXWjvjh
         9PBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1780064018; x=1780668818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IO/YFPRgNajc6XStG8eCy9xjEm5grYWbIdLNhKrND3k=;
        b=pppsoizaNg4nRkk078D3LJpIr8G2xqPYFfzL+6NdQ8L6+XbFHqiWnVv+LsjBUzSYsL
         4yy5hAkJPr9jqvho9427D6lwpM0mJw8Mxb1RD9ECQdEIZVcF5JIGERl/O+apEqd5aGCN
         LmfVRvRmkr2+sjPsaJhUIy84Yv84BbhjgF94W+vQ+s+x2hnhbH9qlbvloFqyqBMxrP/7
         zpq0/6NWH0myeSveuGpw9fJ+Bj0YduA6bnVa7nRgWEhOHjUoOf9Pe/F311Oscjfu9wyx
         Va2x1tQx/CeVUmO/IyDVGql2nv9IPmcibEgcpH7jf+aMBriOgilOEss6eNLMWeN9mKAU
         wz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064018; x=1780668818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO/YFPRgNajc6XStG8eCy9xjEm5grYWbIdLNhKrND3k=;
        b=ZffFgCsA3BQSlBlt2gSq5yH9IunvPTpw+rC9u248Elkw7T7TtrDVXLswWPvEd5nReS
         uJWtgj10OOOeugd13EFvtxnLVk8owbe6tkcx1WYdvUiiZof2LC/mXYxxTyACKbMGwj37
         3uZ/O+3tqToFuBUlNYSWnWYrbuc0mLtYCYxDVxPfaVyEeNAkZpjD4QNaSGi4GChaNIin
         8f6QgbFzwqL6yG81Dj8p5iHr7hW/cNQaFzfl9HF9YIpQrhifluhs8NxgNhWaz/UjPy5W
         TM1iBIl70sGgUzWRrTAWp5iamP6O48/wAd+d7jhuSUwEXPC2pYEdWwM93elkzjhRDmvx
         WIow==
X-Forwarded-Encrypted: i=1; AFNElJ879Xk2z0OZuyO2GEk2Ip5pWPbQH+hIuHKhqWkd14i0iZFBMPjg819cHGuMTwywdZNs2gNDGxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWDv6wIFYEvj+JJSCS53XqhXgSnflI5GxqHof1nHiueii8i/x
	O0QaD6W8lz/k58NiRvciDJxw8ge/16eTQLzZPBMooD8+JLCKxU1pnsanItG3yRmso4KGbuaYSVp
	i6xGZ+JGxs5/B+siaZa5XFAdcuav6LWNW1bedggGm
X-Gm-Gg: Acq92OGw8fVJcXfH04q6xfr1BkaUKeyY9F9Cl5zRCR5ZYNFNII/+8asx3IBRcLI0US+
	USiPF5CITgV5wcYFJTdE9YM7IAKgT/aI2WPhusVJujKJ2xuOiDD2xoKXPwaSXnqGkU0qYjfSPv0
	+HtIC08fT7UmAtM0kB/lzXhZruTNHewUQBBZo3lvmkVsD07PDjpgOOZS5cNYxIYpzpM8kYOpJx6
	Yp9277X02VWHvnJlyIOGaZLyWXWyD6Bar3VswTnLJkbkGdhFnEwo6kisUar6A7aESj96Cm+XudX
	/8kvltkgCDJ8l6Tx6OM=
X-Received: by 2002:a05:6a00:e07:b0:82f:7762:3eb2 with SMTP id
 d2e1a72fcca58-84210b38e3bmr2833623b3a.17.1780064018592; Fri, 29 May 2026
 07:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526220847.28365-1-kylebot@openai.com> <20260528181319.79aeb1b2@kernel.org>
In-Reply-To: <20260528181319.79aeb1b2@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 29 May 2026 10:13:26 -0400
X-Gm-Features: AVHnY4JwOVyizoVt8YUaaVVFmd-d6i7NGSR_mZvIstxoxa-g6-g0cPSMXRNA8qg
Message-ID: <CAM0EoMmH+5q1JXH0c0GRJHLF3sN-BjpO+4X+ESjARz_rmZZ28Q@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_api: use mutex in tcf_idr_check_alloc
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kyle Zeng <kylebot@openai.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008198a10652f5732e"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293134-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4180C603749
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000008198a10652f5732e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 9:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 26 May 2026 15:08:47 -0700 Kyle Zeng wrote:
> > Currently, the NEWTFILTER path uses RCU to guard action idr accesses wh=
ile
> > the DELTFILTER path uses mutex to guard action accesses. This
> > inconsistency leads to a race condition scenario, which can lead to
> > erroneous operations on refcount, eventually leading to use-after-free
> > situation.
> > In this patch, we revert the introduction of RCU back to mutex in the
> > NEWFILTER path, which is consistent with the DELFILTER path, avoiding
> > the race condition.
>
> The commit message is quite inadequate here. Looks like a
> run-of-the-mill UAF so you should explain the flow / race that leads
> to it properly.
>
> Doing some extra digging with Jamal off-list we can't find the reason
> why normal RCU protection wouldn't work here so maybe hold off reposting
> until you hear from Jamal.

Kyle, can you try the attached patch?

cheers,
jamal

--0000000000008198a10652f5732e
Content-Type: application/octet-stream; name=patchlet-action-rcu
Content-Disposition: attachment; filename=patchlet-action-rcu
Content-Transfer-Encoding: base64
Content-ID: <f_mpr05ath0>
X-Attachment-Id: f_mpr05ath0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L2FjdF9hcGkuaCBiL2luY2x1ZGUvbmV0L2FjdF9hcGku
aAppbmRleCBkMTFiNzkxMDc5MzAuLmZkMjk2N2VlMDhmNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9u
ZXQvYWN0X2FwaS5oCisrKyBiL2luY2x1ZGUvbmV0L2FjdF9hcGkuaApAQCAtNDUsNiArNDUsNyBA
QCBzdHJ1Y3QgdGNfYWN0aW9uIHsKIAlzdHJ1Y3QgdGNfY29va2llCV9fcmN1ICp1c2VyX2Nvb2tp
ZTsKIAlzdHJ1Y3QgdGNmX2NoYWluCV9fcmN1ICpnb3RvX2NoYWluOwogCXUzMgkJCXRjZmFfZmxh
Z3M7CisJc3RydWN0IHJjdV9oZWFkICAgICAgICAgdGNmYV9yY3U7CiAJdTgJCQlod19zdGF0czsK
IAl1OAkJCXVzZWRfaHdfc3RhdHM7CiAJYm9vbAkJCXVzZWRfaHdfc3RhdHNfdmFsaWQ7CmRpZmYg
LS1naXQgYS9uZXQvc2NoZWQvYWN0X2FwaS5jIGIvbmV0L3NjaGVkL2FjdF9hcGkuYwppbmRleCAz
MzJmZDk2OTVlNTQuLjMxNDgxNDJiYjU0MyAxMDA2NDQKLS0tIGEvbmV0L3NjaGVkL2FjdF9hcGku
YworKysgYi9uZXQvc2NoZWQvYWN0X2FwaS5jCkBAIC0zNzAsNiArMzcwLDE0IEBAIHN0YXRpYyB2
b2lkIHRjZl9hY3Rpb25fY2xlYW51cChzdHJ1Y3QgdGNfYWN0aW9uICpwKQogCWZyZWVfdGNmKHAp
OwogfQogCisvKiBSQ1UgY2FsbGJhY2sgdG8gZnJlZSBhY3Rpb24gYWZ0ZXIgZ3JhY2UgcGVyaW9k
ICovCitzdGF0aWMgdm9pZCB0Y2ZfYWN0aW9uX3JjdV9mcmVlKHN0cnVjdCByY3VfaGVhZCAqcmN1
KQoreworCXN0cnVjdCB0Y19hY3Rpb24gKnAgPSBjb250YWluZXJfb2YocmN1LCBzdHJ1Y3QgdGNf
YWN0aW9uLCB0Y2ZhX3JjdSk7CisKKwl0Y2ZfYWN0aW9uX2NsZWFudXAocCk7Cit9CisKIHN0YXRp
YyBpbnQgX190Y2ZfYWN0aW9uX3B1dChzdHJ1Y3QgdGNfYWN0aW9uICpwLCBib29sIGJpbmQpCiB7
CiAJc3RydWN0IHRjZl9pZHJpbmZvICppZHJpbmZvID0gcC0+aWRyaW5mbzsKQEAgLTM3OSw4ICsz
ODcsOCBAQCBzdGF0aWMgaW50IF9fdGNmX2FjdGlvbl9wdXQoc3RydWN0IHRjX2FjdGlvbiAqcCwg
Ym9vbCBiaW5kKQogCQkJYXRvbWljX2RlYygmcC0+dGNmYV9iaW5kY250KTsKIAkJaWRyX3JlbW92
ZSgmaWRyaW5mby0+YWN0aW9uX2lkciwgcC0+dGNmYV9pbmRleCk7CiAJCW11dGV4X3VubG9jaygm
aWRyaW5mby0+bG9jayk7CisJCWNhbGxfcmN1KCZwLT50Y2ZhX3JjdSwgdGNmX2FjdGlvbl9yY3Vf
ZnJlZSk7CiAKLQkJdGNmX2FjdGlvbl9jbGVhbnVwKHApOwogCQlyZXR1cm4gMTsKIAl9CiAKQEAg
LTYyMCw3ICs2MjgsNyBAQCBzdGF0aWMgaW50IHRjZl9pZHJfcmVsZWFzZV91bnNhZmUoc3RydWN0
IHRjX2FjdGlvbiAqcCkKIAogCWlmIChyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJnAtPnRjZmFfcmVm
Y250KSkgewogCQlpZHJfcmVtb3ZlKCZwLT5pZHJpbmZvLT5hY3Rpb25faWRyLCBwLT50Y2ZhX2lu
ZGV4KTsKLQkJdGNmX2FjdGlvbl9jbGVhbnVwKHApOworCQljYWxsX3JjdSgmcC0+dGNmYV9yY3Us
IHRjZl9hY3Rpb25fcmN1X2ZyZWUpOwogCQlyZXR1cm4gQUNUX1BfREVMRVRFRDsKIAl9CiAKQEAg
LTc2MSw3ICs3NjksNyBAQCBzdGF0aWMgaW50IHRjZl9pZHJfZGVsZXRlX2luZGV4KHN0cnVjdCB0
Y2ZfaWRyaW5mbyAqaWRyaW5mbywgdTMyIGluZGV4KQogCQkJCQkJcC0+dGNmYV9pbmRleCkpOwog
CQkJbXV0ZXhfdW5sb2NrKCZpZHJpbmZvLT5sb2NrKTsKIAotCQkJdGNmX2FjdGlvbl9jbGVhbnVw
KHApOworCQkJY2FsbF9yY3UoJnAtPnRjZmFfcmN1LCB0Y2ZfYWN0aW9uX3JjdV9mcmVlKTsKIAkJ
CW1vZHVsZV9wdXQob3duZXIpOwogCQkJcmV0dXJuIDA7CiAJCX0K
--0000000000008198a10652f5732e--

