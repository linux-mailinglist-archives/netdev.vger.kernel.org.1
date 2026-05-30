Return-Path: <netdev+bounces-293301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DN1M1NmGmqF4AgAu9opvQ
	(envelope-from <netdev+bounces-293301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5FB60B3DB
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C438B303ED29
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 04:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A7F35201F;
	Sat, 30 May 2026 04:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slhL4tno"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7AF344DB9
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 04:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780115026; cv=pass; b=FXs8hGfb4FJf9EsGnMUujv97L9qZnajJval9UODl9LFRZkuZoBnPbFRtpglbYP9eN3covrTd5pTpAjWwrpyc43h7kMfLxPKIGLkrvPfWRA4LdD/XwPd0CANTJXQyihmUnXaQrYtRR9VyBwbapDVxn890vgakiwi4hbRKqxsxmRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780115026; c=relaxed/simple;
	bh=//q737ToXy0G7dhSHINOmKdOjqSOPFPxK8MSSj31p+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJTUKQXexLi//hikpIsMiDrOUGLjykkSNqXr037MCEOFrB2RKFnDHR2Yum0y7mNwkmPVnXb/NZe4mnTeglpbXhFSnJd5HveXQhvf42lW2iIJk7O636NW+5M2Tlr0A3F9EKCF1WO5yEoZHE6MICzvL5WsrQYV4mHhXxxXezxCpV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=slhL4tno; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-137d452574cso1180951c88.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 21:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780115024; cv=none;
        d=google.com; s=arc-20240605;
        b=LmeoNpJiYeFx7vJlS99J8xb0Q5hpo1lrcRYN7kzF4dgQrliuX6VrJLNQnDPRwc9aQD
         y+Lc5VRrUUFfgYESnRXHKrkeT3vjldQDLZhkqRTNKhSJHVOqEgxOz7uTyXF/5OS2xMJw
         gvD+KuMyopplIUDaY3cScDYoMrY6tHaEoOZfd2KHF7DHOA0HqAnbqjQ0kuX57iLVQtnP
         EgE9CknMc50M5UIiHLwaaBZpsBhpNtCFZA/DuNcdwf8trMA5m5cL+eoJ+Mi8eW2QtD4J
         KFSIGU4Pn66JvTwqvD9RoRx3SntGDuvzsDGB7RMP7jGhBTDIBDmIxOlyER6Xili2kttL
         tZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cgIZVFIsr51yCf+bNFGTrWmECg3/hvbAnI6e+Grx4Ak=;
        fh=WhBVqsTsU6Sqztgix6dsb31VbufVaKi3MksF68BOH/I=;
        b=TKPZKtrmtRmzIdDMOmE0ETf5AqAzB52lKam96b4wxuiVMM4KQ1xSEmFB1ThsBpithM
         rZPG/BcBXPZX8slmnc+x7dvvOjaIGLsFIthzm7hovqXALqj1/DTthoxr1oaB09+97x6s
         VdbcRuar4Nq1Pd/P8cgcEje9QRKDKcaCa1ZaG1tOS5KtpPltA02/2H0G6UyiYskdCR9t
         Cr8ZbccqPSNkE3f7R6IC8oprgFKYs+Au0LmxsxvdCs3UCXZ0aqVWErL0mMTCe31LU23B
         BuC5naJdBtzT4c3qf7sU3GVbV7JXwoOLWzhTIHhQSUmtE63D91grGr5QpfFDRWFPUdIr
         NgKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780115024; x=1780719824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgIZVFIsr51yCf+bNFGTrWmECg3/hvbAnI6e+Grx4Ak=;
        b=slhL4tnoUhtsDqwWgKqvXi+Zmze3Wtz+suPXx5OrkDwq08oESBWASO4O4TZyAg1R+O
         l/rIa6taAvF1cl+SR5EMJX7Hohzt5M4Xqt1fRsmi1VF8rbY3AiHy7Td1PhMtT+vj34u2
         Ehjz+DDe3Eyo4sf5QJqm7CDJc3JlD49Z8dTZZwQechpPD5ffEUwGGUggpYH0K5zhNcuI
         HBUuQtTiKaJEhHbrzFv89zjn0M/13dFgTiMybkuzh9Tz9rFYq3FR3kJJ3yMusxq7yJYR
         dJ4S3M353yVVEtgtcstipPhbVf1eDJ25l3qiiqiZMwV8W1hgpQYVpEWMaiULtZ/y35/z
         TkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780115024; x=1780719824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cgIZVFIsr51yCf+bNFGTrWmECg3/hvbAnI6e+Grx4Ak=;
        b=opuqmOoq1ACUr31e+Gb5VUq7s9eEOEGuH8Z8+Qdq/FxQgDByUjJ6uWR1G4ZFIaZh2t
         hs70vR1OE9qXfcJxZ57HssjNq05GL5ADiB7EjKF4swn7qxn3iNAWJKxfl/ZY5AQgUJd8
         QESIaqB6ZLCDPDVsGw55SL7saLNsPjoYnb/3v1s+Am9w/Kzta39vflkV6eOK06wCOEPq
         NOLDRxH8W6Eb3ckD5zJ7UM4mTuDMI2nCEiBuaR+K4gkqKdBvGmtCgCFfFTOp0+5zd35V
         B9herDpmjHFlcIwKwZygs9wveRc3d4wMMgZJC4LVVPuoA4G4yv2QGXOqy+4PSoVgNsLP
         RhXA==
X-Forwarded-Encrypted: i=1; AFNElJ8wZxBfYoIT9NwCnjEhvAy31aWXcFELA8G0Zziukj7ywpWqByJFNK0TVqXspE0cfC6+/9HCZbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFPexQ0JtEUbL/LDzpbMP6WO949MKWJb/Hx8x/0kO30V5AIraD
	EO62vfwL2KJi91GJjLGVPFPd/N9I8LxEJZt1EcILodHet20hLRXkWy0Ng63zO47BvYxdUP/deOR
	HLTntiy2tRFu3h5Scl1HmokCFDC95pQ9Ef29HPyVI
X-Gm-Gg: Acq92OHezvrDZslq7RRQT4ngbE60g8CqxXxb5fP9zwICwKssToVCzK1qeMapfxDd8rE
	gcbLb4keez9k0h1CC4hWLkV+yUGQuRTXSO/1fjU1n5l6aWdnUm9fzUQFtnTvhzMzBnD/GFANkkd
	TX7LqIrjCB7O8R6xLKsjZeqYh3WGgkiGzGah12pAIcVxLrALkReYqyI17Tz2XwhxjtO6UGuPSao
	26OvnyNliQPSodbKPZlKL0OXGArCSoPuc2fPZOnXXxQUjA918yqrDP81ItO6BNvHaFEqSJxJzQr
	Geud8Zt/wpNsXY0lINHG9w598MH2bVp1zbvCVKwlXQrz2qE70nasNn/WuBms/Mylmw5BVMxN6Jp
	85rE9x21A0ciXQTtHDVyemNasVefHPZEEqv7TJ44UBzDUzThPpDHeAcJaU14pYV8=
X-Received: by 2002:a05:7022:e24:b0:12c:6a24:a24f with SMTP id
 a92af1059eb24-137d4294858mr1136530c88.33.1780115023471; Fri, 29 May 2026
 21:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528110033.3327744-1-jianyu.li@mediatek.com> <20260528110033.3327744-3-jianyu.li@mediatek.com>
In-Reply-To: <20260528110033.3327744-3-jianyu.li@mediatek.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 29 May 2026 21:23:32 -0700
X-Gm-Features: AVHnY4LcIbNowi28Nnxn_RdeBADlfc85e19YyBGUPkL7FIFAkT0Ut5CmHA64BnI
Message-ID: <CAAVpQUDg-oSRvG4h+YinP8TSPfR+ug=_Fn1ON-TL5WsAvj8Oog@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] af_unix: Add test for SCM_INQ on partial read
To: jianyu.li@mediatek.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infrade, black-ch.chen@mediatek.com, 
	ivan.tseng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293301-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7C5FB60B3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 4:00=E2=80=AFAM <jianyu.li@mediatek.com> wrote:
>
> From: Jianyu Li <jianyu.li@mediatek.com>
>
> Add test to verify that when a skb is partially consumed,
> unix_inq_len() return correct remaining byte count.
>
> Before:
>
>   #  RUN           scm_inq.stream.partial_read ...
>   # scm_inq.c:165:partial_read:Expected remain (512) =3D=3D *(int *)CMSG_=
DATA(cmsg) (768)
>   # partial_read: Test terminated by assertion
>   #          FAIL  scm_inq.stream.partial_read
>   not ok 2 scm_inq.stream.partial_read
>
> After:
>
>   #  RUN           scm_inq.stream.partial_read ...
>   #            OK  scm_inq.stream.partial_read
>   ok 2 scm_inq.stream.partial_read
>
> Signed-off-by: Jianyu Li <jianyu.li@mediatek.com>
> ---
> v2: Follow reverse xmas tree ordering in partial_read test case
> ---
>  tools/testing/selftests/net/af_unix/scm_inq.c | 54 ++++++++++++++++++-
>  1 file changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/testin=
g/selftests/net/af_unix/scm_inq.c
> index 3a86be9bda..49cfa6ef07 100644
> --- a/tools/testing/selftests/net/af_unix/scm_inq.c
> +++ b/tools/testing/selftests/net/af_unix/scm_inq.c
> @@ -8,8 +8,9 @@
>
>  #include "kselftest_harness.h"
>
> -#define NR_CHUNKS      100
> -#define MSG_LEN                256
> +#define NR_CHUNKS                      100
> +#define MSG_LEN                                256

nit: please align the indentation of the above two lines
with the line below.

Sorry, I should've looked closer.

> +#define NR_PARTIAL_READS       3

Otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks

