Return-Path: <netdev+bounces-295425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 91cIC+jvIWrZQgEAu9opvQ
	(envelope-from <netdev+bounces-295425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:36:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AC643A32
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:36:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=KmJL9Mxh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295425-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295425-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C82293019F31
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 21:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F7E39BFE0;
	Thu,  4 Jun 2026 21:32:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A653DA5AE
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 21:32:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608778; cv=pass; b=Pkk/c3D+3wliuiELFT2o1uQqhVXHlQcPBPLMs36sWBieJxSwEB4cg8jc8HYt8bR/k+qbEOeI7fB3qZM9nO77968OO3N5JEklKZYbB+/2zbxwd/lMNqbfR7AhDFLunAtYR7TenCF4ip8lqspmTWzkf3oGL4tNQ3vD9cf30iNnsPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608778; c=relaxed/simple;
	bh=Av0sHvdn29fm2C6t1HIlpl6qnYttHJO4691xFfVaAJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvz4iACcdXq7SrxZZAtaoU35kgE5kHVik/0ClGzuk9/wxqjCaX7DKAL0GldClqGitegI2gFqwpzc55SzFILkpvpVnw9beb8kb56jbxYCLUReIGLssbBywW/sOm89ouqRsYXYayLAjNFPRr6+jQCfg120qyn5EDzMyfmWsDlckus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=KmJL9Mxh; arc=pass smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7ea6923cc94so13457747b3.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 14:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780608776; cv=none;
        d=google.com; s=arc-20240605;
        b=f1VsevW+mhtC1p/o28XoX81J6pvbiexj7tw55ipifXqces3xuSw9aZYhbHDlHl8n/v
         rLDaNUUtfGXxCfeqQNge+9DLjMPfnJSG7TjC3bUwbSd0kXWteYDPd/Ha9SzGhs/YwoPu
         qf5ll8hqhUj+g+FdPLD37L388zE2zdLQ2P1fLtQUW9jwbzcQfkJMaBhe7ScjGeo/4CL8
         nQMAr/WSjXOm+9c0fJY9/WrI1/56n6KHS5mLSWRqfMwSSmji8IAA698VKRC0LTZLaOMV
         5by8hs5PdLVoappQzt7KLab0oU7UqQX2R9nM5hRNI21CrrKRuqg0cCwwx+x0vKBKVDPF
         JzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Av0sHvdn29fm2C6t1HIlpl6qnYttHJO4691xFfVaAJE=;
        fh=Tqr9mIwdU/SpPmGtMwJ/QNMjsIP335WBhivSwC0f2pI=;
        b=PVU8C07X7cz0tCwEI50fQ1l9XSqODx/ORT/oJr0Xl47t4EQAZOqrt+feLBIih1k7VB
         jcnczjDiLiDgcLbH26atyUJJFpmKS4kQ4Exw+DspuRlrD+OaueuVVMEQ0N1V4MtRlupj
         +yvMgbLo4PBNu6sKd8YUry0G3Lo7jItfZAdy0YpIjBPKBuCesbctgMgk3ZBNrUzVYNYq
         iD6IEpUMDLOn8KhD3HS5daIt2wcOnNjLEfTQaQox4R4/l/l14opHfTL4zTrpM33ev8vi
         TQb8nSdXNVDf9kmr9K6yIBowAIY4ZWhidsFZ/+WzQytGCf8X6jG2pCrvPmCNYJ5v75DS
         +aBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780608776; x=1781213576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Av0sHvdn29fm2C6t1HIlpl6qnYttHJO4691xFfVaAJE=;
        b=KmJL9MxhMXLjQk1CJeo6BfgTqpJ/CpAEeDpPEWK7mbOLaL9u+PutC7oRwNHULxHPUz
         aW8Q4JAn1lzaxYg6agx08sBCT9+zFhMVvpHHy4xu4e7SGO2uBuTO8Cv+QGCrIzqg7rvK
         a61aTUJ+bw8zzhHtZON6sPc1KNEYo+BoQ434I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780608776; x=1781213576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av0sHvdn29fm2C6t1HIlpl6qnYttHJO4691xFfVaAJE=;
        b=ZBXBd7gXMBK7QUNtR/eGZ4+jDmCmMeJ6p7RO8MLfYrRewdnzeLprO8txo63E8vD+bL
         e7oRkpDbQJLaefiJNYh68EwZk2mQTxefhzCO2dqjKaub5PCL3lBJZ1ozNHjcQa0HPn5o
         7Jnwsq7P69lnKtN407hC7niovuHEPw0+KoFG+n/C2p+ZzwJ+FQYn+btwdR0ewPZRMecf
         gs+ryMBl1jBGzO6X3+4g5/pFQ0JPUvcf5ReN1QZnKEV+pVC9RTW3nENIngxo1XaX7Uxu
         vuU/sXq5S27wyG9TURScXQtEY2OtIyM7xsHhWZBFN8Ce72Hn+aW2S0Tx6HfaTZOh22ON
         8opg==
X-Forwarded-Encrypted: i=1; AFNElJ+CdUTXAZryqtzDeijaLSxdN4DlJEA5ol9jEn2YtpqNUUxf0ZhH8sjs/m3oLQND1SHu38/Fm8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+VZsiRZDzjtFQEjGMJnzM6Mv9czd1nnYCYIJoKp/UlGkB/WdD
	ueHFAu7pSsG062SpViaB+zxEi5G6geT5AvY7ZnpbTLwHY6SOUMhKiDZziJ1YHFVQaivsmr3/0kh
	YDMDBMPiPFE6UxFyfvaUATaYM+MJPcaotwj9srNM3
X-Gm-Gg: Acq92OG7+PkX6wPjr9WD3u+bQWXXdeDWwGQBBco+DrtkJ6d9vduuj5W0OY24LbVsbvp
	U5fXLWOR6eUIarIDI764MRrBej2/swrmddoJdjB72onpc9dlUaAU/ymGCsYqSc0GZg0U91vMGlf
	zCMQbDo8c92Az4mdPaP6Jmn5k/juCcw0p+nvlQtdm2Tn6ZvqCtcLKdYOgleHoMx5fMw0dpS2cn2
	HJPfdAnojzTVGwVh/gAwjGmlhE55HROYkiAlza0CXyNPKSdadcUhGGHQfA1HY00lVWQPAo1n7MV
	OC18xPUiP0Rcp81IpkCPEbLxIqg3b3tQQhLFJmTqhxVlQyRE
X-Received: by 2002:a05:690c:710a:b0:7bd:5579:185a with SMTP id
 00721157ae682-7ed0c80a062mr7303137b3.25.1780608775885; Thu, 04 Jun 2026
 14:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com>
 <8978c158-b005-4b53-99d7-b475d9c4c665@mojatatu.com> <CAN2cbVenex+3wB0o+rvxcFrQOTjAL3W_WQ1sh7QZ_AKewgRVVQ@mail.gmail.com>
In-Reply-To: <CAN2cbVenex+3wB0o+rvxcFrQOTjAL3W_WQ1sh7QZ_AKewgRVVQ@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 4 Jun 2026 18:32:44 -0300
X-Gm-Features: AVHnY4Ih_py6v3ez32zzorvXVRPfROXrRyYheYlMzTGb1PlFd9AxpZelS7iQcis
Message-ID: <CA+NMeC-cpoV8X44wTXm=a+Xkpx0Ka0uydG1fUNqM_0vFEh2GTA@mail.gmail.com>
Subject: Re: [BUG] net/sched: HFSC + fq_codel stall on 6.6.116
 (qdisc_tree_reduce_backlog / qlen_notify)
To: Anirudh Gupta <anirudhrudr@gmail.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: "jhs@mojatatu.com" <jhs@mojatatu.com>, Anirudh Gupta <Anirudh.gupta@sophos.com>
Content-Type: multipart/mixed; boundary="00000000000092560006537449b3"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anirudhrudr@gmail.com,m:netdev@vger.kernel.org,m:xiyou.wangcong@gmail.com,m:jhs@mojatatu.com,m:Anirudh.gupta@sophos.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295425-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 447AC643A32

--00000000000092560006537449b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 11:23=E2=80=AFAM Anirudh Gupta <anirudhrudr@gmail.co=
m> wrote:
>
> The provided patch did not fix the bug.
>
> Observing the same issue, where sent bytes get stuck and backlog
> continues to increase, while traffic gets stuck.

I can't reproduce this locally with the previous patch, but investigating t=
he
code I think I understand what might be happening. Can you try the new
attached patch instead? If it still doesn't work, can you provide me with
more details on how you are reproducing (environment, traffic
generator and etc)?

cheers,
Victor

--00000000000092560006537449b3
Content-Type: text/x-patch; charset="US-ASCII"; name="hfsc_anirudh_fix_v2.patch"
Content-Disposition: attachment; filename="hfsc_anirudh_fix_v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mpzzrbo80>
X-Attachment-Id: f_mpzzrbo80

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfZnFfY29kZWwuYyBiL25ldC9zY2hlZC9zY2hfZnFf
Y29kZWwuYwppbmRleCAyNGRiNTQ2ODRlOGEuLjlhZWJmMjVkZGM3OSAxMDA2NDQKLS0tIGEvbmV0
L3NjaGVkL3NjaF9mcV9jb2RlbC5jCisrKyBiL25ldC9zY2hlZC9zY2hfZnFfY29kZWwuYwpAQCAt
MjgwLDcgKzI4MCw3IEBAIHN0YXRpYyB2b2lkIGRyb3BfZnVuYyhzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LCB2b2lkICpjdHgpCiAJcWRpc2NfcXN0YXRzX2Ryb3Aoc2NoKTsKIH0KIAotc3RhdGljIHN0cnVj
dCBza19idWZmICpmcV9jb2RlbF9kZXF1ZXVlKHN0cnVjdCBRZGlzYyAqc2NoKQorc3RhdGljIHN0
cnVjdCBza19idWZmICpfX2ZxX2NvZGVsX2RlcXVldWUoc3RydWN0IFFkaXNjICpzY2gpCiB7CiAJ
c3RydWN0IGZxX2NvZGVsX3NjaGVkX2RhdGEgKnEgPSBxZGlzY19wcml2KHNjaCk7CiAJc3RydWN0
IHNrX2J1ZmYgKnNrYjsKQEAgLTMxNywxMiArMzE3LDQ5IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVm
ZiAqZnFfY29kZWxfZGVxdWV1ZShzdHJ1Y3QgUWRpc2MgKnNjaCkKIAlxZGlzY19ic3RhdHNfdXBk
YXRlKHNjaCwgc2tiKTsKIAlXUklURV9PTkNFKGZsb3ctPmRlZmljaXQsIGZsb3ctPmRlZmljaXQg
LSBxZGlzY19wa3RfbGVuKHNrYikpOwogCisJcmV0dXJuIHNrYjsKK30KKworc3RhdGljIHZvaWQg
ZnFfY29kZWxfZGVxdWV1ZV9kcm9wKHN0cnVjdCBRZGlzYyAqc2NoKQoreworCXN0cnVjdCBmcV9j
b2RlbF9zY2hlZF9kYXRhICpxID0gcWRpc2NfcHJpdihzY2gpOworCiAJaWYgKHEtPmNzdGF0cy5k
cm9wX2NvdW50KSB7CiAJCXFkaXNjX3RyZWVfcmVkdWNlX2JhY2tsb2coc2NoLCBxLT5jc3RhdHMu
ZHJvcF9jb3VudCwKIAkJCQkJICBxLT5jc3RhdHMuZHJvcF9sZW4pOwogCQlxLT5jc3RhdHMuZHJv
cF9jb3VudCA9IDA7CiAJCXEtPmNzdGF0cy5kcm9wX2xlbiA9IDA7CiAJfQorfQorCitzdGF0aWMg
c3RydWN0IHNrX2J1ZmYgKmZxX2NvZGVsX2RlcXVldWUoc3RydWN0IFFkaXNjICpzY2gpCit7CisJ
c3RydWN0IHNrX2J1ZmYgKnNrYjsKKworCXNrYiA9ICBfX2ZxX2NvZGVsX2RlcXVldWUoc2NoKTsK
KworCWZxX2NvZGVsX2RlcXVldWVfZHJvcChzY2gpOworCisJcmV0dXJuIHNrYjsKK30KKworc3Rh
dGljIHN0cnVjdCBza19idWZmICpmcV9jb2RlbF9wZWVrKHN0cnVjdCBRZGlzYyAqc2NoKQorewor
CXN0cnVjdCBza19idWZmICpza2IgPSBza2JfcGVlaygmc2NoLT5nc29fc2tiKTsKKworCWlmICgh
c2tiKSB7CisJCXNrYiA9IF9fZnFfY29kZWxfZGVxdWV1ZShzY2gpOworCisJCWlmIChza2IpIHsK
KwkJCV9fc2tiX3F1ZXVlX2hlYWQoJnNjaC0+Z3NvX3NrYiwgc2tiKTsKKwkJCS8qIGl0J3Mgc3Rp
bGwgcGFydCBvZiB0aGUgcXVldWUgKi8KKwkJCXFkaXNjX3FzdGF0c19iYWNrbG9nX2luYyhzY2gs
IHNrYik7CisJCQlzY2gtPnEucWxlbisrOworCQl9CisKKwkJZnFfY29kZWxfZGVxdWV1ZV9kcm9w
KHNjaCk7CisJfQorCiAJcmV0dXJuIHNrYjsKIH0KIApAQCAtNzI1LDcgKzc2Miw3IEBAIHN0YXRp
YyBzdHJ1Y3QgUWRpc2Nfb3BzIGZxX2NvZGVsX3FkaXNjX29wcyBfX3JlYWRfbW9zdGx5ID0gewog
CS5wcml2X3NpemUJPQlzaXplb2Yoc3RydWN0IGZxX2NvZGVsX3NjaGVkX2RhdGEpLAogCS5lbnF1
ZXVlCT0JZnFfY29kZWxfZW5xdWV1ZSwKIAkuZGVxdWV1ZQk9CWZxX2NvZGVsX2RlcXVldWUsCi0J
LnBlZWsJCT0JcWRpc2NfcGVla19kZXF1ZXVlZCwKKwkucGVlawkJPQlmcV9jb2RlbF9wZWVrLAog
CS5pbml0CQk9CWZxX2NvZGVsX2luaXQsCiAJLnJlc2V0CQk9CWZxX2NvZGVsX3Jlc2V0LAogCS5k
ZXN0cm95CT0JZnFfY29kZWxfZGVzdHJveSwKZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfaGZz
Yy5jIGIvbmV0L3NjaGVkL3NjaF9oZnNjLmMKaW5kZXggODNiMmNhMmUzN2ZjLi5jNDgyOTRjYWEw
YWUgMTAwNjQ0Ci0tLSBhL25ldC9zY2hlZC9zY2hfaGZzYy5jCisrKyBiL25ldC9zY2hlZC9zY2hf
aGZzYy5jCkBAIC03NTMsNyArNzUzLDggQEAgdXBkYXRlX3ZmKHN0cnVjdCBoZnNjX2NsYXNzICpj
bCwgdW5zaWduZWQgaW50IGxlbiwgdTY0IGN1cl90aW1lKQogCXU2NCBmOyAvKiAsIG15Zl9ib3Vu
ZCwgZGVsdGE7ICovCiAJaW50IGdvX3Bhc3NpdmUgPSAwOwogCi0JaWYgKGNsLT5xZGlzYy0+cS5x
bGVuID09IDAgJiYgY2wtPmNsX2ZsYWdzICYgSEZTQ19GU0MpCisJaWYgKGNsLT5xZGlzYy0+cS5x
bGVuID09IDAgJiYgY2wtPmNsX2ZsYWdzICYgSEZTQ19GU0MgJiYKKwkgICAgY2wtPmNsX25hY3Rp
dmUpCiAJCWdvX3Bhc3NpdmUgPSAxOwogCiAJZm9yICg7IGNsLT5jbF9wYXJlbnQgIT0gTlVMTDsg
Y2wgPSBjbC0+Y2xfcGFyZW50KSB7Cg==
--00000000000092560006537449b3--

