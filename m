Return-Path: <netdev+bounces-291954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC5BNPsZFmqEhgcAu9opvQ
	(envelope-from <netdev+bounces-291954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:08:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7437A5DD183
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A0393031013
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EFB3C345F;
	Tue, 26 May 2026 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3OH9WlQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211D3B27D7
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833300; cv=pass; b=s/N1H/K3nLTFZalIL8PFg2F15WxPnX84c2Z4rbpH8kn8lLflpjA5TtzEOhV9mR4yuo8J9UkkWB26PiAejBMsgmErggwp02cWnoEg+lEE793Zl3q0WHzd6voF7XhY+92dMf0gNS0eQZLehgpKjt+Q1HLDruOFMYh4IeTD0P0O0eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833300; c=relaxed/simple;
	bh=E5eVcu06k2o3PY8A09XNvdjNWnpe+Yc96+AlUiI1rCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4s5x08hEn3RFsmrC/FbUQPl93uas3SwnRTTO6qqCRDg31+GRpDSDrcAzk5gYZa9mRGDFrEtc/uK+46znR2Qm3RRA6I+6JR8/8aUvdPbREdsyLns5nw/F/uR5x/sEdaXuqJh6dCC9aJuL8dGXk1H7sghTkbxAIiLpijQohecNu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3OH9WlQ; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso34202485e9.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779833297; cv=none;
        d=google.com; s=arc-20240605;
        b=Dnzip942PvVwMtrTjPUeXBJRUPLt2Yxp4HnBBsTx0TIPZkXMU/12GlqooTytgBJFxC
         mgLxWb+r+lYBgE6QrfzrLhaWps+vTmW4IZ7QZBbj2thvR95Qcht9Yqa2GR/J2UE8HHYB
         e65HdM1MaHOkkm+I7t4tmSZVApvtgLILutd96z5E+p8Y0o755AnKnZaSKxH+u1Hjlaz5
         HeqzcNFnV3vSp4wJi7BI4i95GxVRJF2rQplOr+Bg1szIjTl8NPt36kNuzx07LWJbH1T0
         ommaiKTgEf+89TeLoFk+SpT80VfO3i9lisMg9vtzKwXnffEMOZNfvQzi7c1hBnqWOEYG
         gR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3RWZTrTlmetuoLNV2ZDm5Lkp+qABxyw2h/aIwZbrBFY=;
        fh=3SKfkUzwyLk/rffJnl349fLiH8FQqgCsa3XouNYqBA0=;
        b=J9NRmHXxJK4iioSc4t2dXSfq9Q60SU8buMZfpFObwTF07UHBpDVgVD/epItklLmWxE
         lDFueFgwZaQifI5HiH1m7c/G8MzJg4TotMMOmTZMguiG7YJ8nf2gMJ+bMFc2fW1cXnvl
         xKOSGOpK+caZq6KILEn2duLM7qh1kz+plsHlf7VVFfypKbc5TfJ4D5+m2BLeVEFmXV1R
         zhH5nS+cBSFviBSUxifvFJpsghKDMnj0B0cQHem6Gy38jDwiYycyj+9AmoDZY1gYoYXI
         kiJ6iSDyrJ1TkgivwjQAjIISJiNzzboKNnW1OKMOvuDH8E4Hef29NWAUCyPLBg2VIlE0
         3TpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779833297; x=1780438097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RWZTrTlmetuoLNV2ZDm5Lkp+qABxyw2h/aIwZbrBFY=;
        b=j3OH9WlQ1ts8QFarLZzl677pF+Cb0EcpAd6njbMGwZCn1CKHhxh7onbuZy02ufV6y4
         lsX+w4BSZmX0EtZHHMMuZeDbR0hSbcuxMCXOO42JnRG4+S9lMaitqHOph0X8eqXyu/67
         RrahF/8WjjO1RilA/zmXhL0JAF8Nij8KB/JUh2QI4PfJ4EWei76Mk4CjgNMVNgBelP+7
         qMtBG7ZH+xex97BI4YfEZSRTrDUhO810DOq/tQ3WFeNnOY+ANI0dT3afO00pzs+Wcm6R
         kj1dTTUqV55QRo+IgFgiMbhqgrvS6eqBwA/GNQSUDeEMA0828F9BHvtQkdpFOmZfo8tt
         C+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833297; x=1780438097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3RWZTrTlmetuoLNV2ZDm5Lkp+qABxyw2h/aIwZbrBFY=;
        b=CGMWHg5zMORfuo5KUgjHvxSMJljP7Z5HqFIdH/T+FEq7TDCYaqvzsNnwbatClcP2L4
         xdDss8pDG9SW2GxtNk5EJglNoIt9LJ07umsr5IhmcE9ZDEboiHexTgKvab7AsTGlsqZw
         F2TnAB3I204rN6gZvVn8GQf95baoY/YS/QQkKmu85AxOKsUc+9siDcSMeKCp3jo9BfkK
         c6QJ1v3TPG67u6r366L2dp1gwSrURZfUzF7RUTn4izEVx/ak+H+5Cmflm01eRZq7WDaP
         H9s3CkVOkr9FT+k3Z6bXGlKdEyjWBxo3ZRkSnO1Bi1fewXBcdpsrhpq0h6Yq/oRGNDFX
         jonQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jyFUS70xSN2I4Q8uJYTuy0xtD3W7ggVLOL+XTG3KPwo2Nugzk+pc9Ago9e3XI/9i4Sn8wFRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0XzpGU1yeHVy3+1THCkN93zB5sTEa4LXX1F7FnipkIJutuVNd
	uYdtNjFE6Dtx3WW/BdBBfwOBTC3Q+Sq4LRdEMZQAZV9eqWEocmtLPxCTTWSb2zaKEG5kyPmDC+c
	frtOPIp4CouS09UTzo1+GP8XNLlljJtQ=
X-Gm-Gg: Acq92OEkWPDoszikPgHy5+vyxbodGRZYZRiBuk4fTv0RooiXLYzN9kd/4kFSPMH3Uzd
	6DYCp47jXOrOT8lPOWi+dlHt97IAf1b6+NZ4+/zT0wKLCGR/SR+o1TjAQZNULn80ZDgF3SDveTD
	TM26tmTY3xO+IYwjbpEUqAqdsfbf51cYy/xvhLaKLXrdwJ/w9TWRxLJWMuQZjRjzenL1/cppvcA
	hE1VkK5ozpTqV0PHKxXd+m24MCyIc4HTANhXpHRXr+cFXaZRNwx3Q6eDxzhbm5k1P6pHus010tL
	kriALGtX2WHMg4hyAhTaUZtaK6MJX6giP8gJdp5Ko3AUQmRx1Qm7w0gMb5dK5pa1IMKmhJF1xpu
	JmRuvnVQureXdDyA/b0GhhIi04B1NnpJS5aTG
X-Received: by 2002:a05:600c:4510:b0:48f:d5a0:284e with SMTP id
 5b1f17b1804b1-490428e03b8mr327634565e9.28.1779833297389; Tue, 26 May 2026
 15:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahWOVFZZScPjm2Ow@sirena.org.uk>
In-Reply-To: <ahWOVFZZScPjm2Ow@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 May 2026 15:08:06 -0700
X-Gm-Features: AVHnY4L80QQm6oMmZo64_ik7eu9jKD9D8sG_L1XILYcew8M4vDIlUwIvnSeQ_D0
Message-ID: <CAADnVQ+yjm0SJ0UQMeuS82MLDeo1bvZKSMMDh-K8D9-PNu=p8w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Mark Brown <broonie@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291954-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,etsalapatis.com,iogearbox.net,vger.kernel.org];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7437A5DD183
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 5:13=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> After merging the bpf-next tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> /tmp/next/build/kernel/bpf/core.c:3379:13: error: redefinition of
> 'bpf_arena_handle_page_fault'
>  3379 | __weak bool bpf_arena_handle_page_fault(unsigned long addr, bool =
is_write,
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /tmp/next/build/include/linux/bpf.h:9,
>                  from /tmp/next/build/include/linux/filter.h:9,
>                  from /tmp/next/build/kernel/bpf/core.c:21:
> /tmp/next/build/include/linux/bpf_defs.h:12:20: note: previous definition
> of 'bpf_arena_handle_page_fault' with type 'bool(long unsigned int,
> bool, long unsigned int)' {aka '_Bool(long unsigned int, _Bool, long
> unsigned int)'}
>    12 | static inline bool bpf_arena_handle_page_fault(unsigned long addr=
, bool is_write,
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   dc11a4dba2464 (bpf: Recover arena kernel faults with scratch page)

Tejun,

thoughts on the best way to fix it ?
Pls send it to bpf-next. I think it's fine for it to be in one tree only.

