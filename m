Return-Path: <netdev+bounces-267215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LRVL8c+s2k/TgAAu9opvQ
	(envelope-from <netdev+bounces-267215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:31:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF5A27AEA8
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C9E13060B17
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68D2E11D2;
	Thu, 12 Mar 2026 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DdDsoHbQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129A13FF1
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354681; cv=pass; b=JVzqFBuiuAyMyIVzybLmrCpYG+SOXkkvRFkvGDe3Jf/+FpxDC/WgrIgbapW6ITJ8uK1gmOCfvY+CawKuiWxDQ0ojX2TFCnBpxKfq7yDq3IQutvrfi3cpXKy7GBkYUeImadHA56573zuz9UMy6wTCd4JG63AVq5HhU2cHug9X4Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354681; c=relaxed/simple;
	bh=jIysDDa+z2vnCpZjDOfTgI4RhgB7fGnohz/dtG6w9Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxoZJ+b1LTXbyp3uaQhV+Se8Ityflmc7hHy4mtjRjTWu/YZq2du4vqpxnIjaz7sOYuKklWs7yHNBZT4M2bTQksMJwUEFdI5jZ9E0pkpiiXdy3L8mAFBwZxYcIvVnmSDpyGM/yNI/GPGYeGsWGYWxI29a9nSVavokngNcaqkCoec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=DdDsoHbQ; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a142464316so2093702e87.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773354678; cv=none;
        d=google.com; s=arc-20240605;
        b=DCVwE5ugWP8AT4WEROnY9lYf0pBFWaOZXcnZ40E+yx1Rx5ttrrGVMtC98niZJhzXux
         CL/l/iyx8lnMTz8TWhr1jcOjMCjmb1QnTPZ0vY5WGnL2RhfeFRdLsCarC8BdpnSbYQsR
         8faSvxS8k+Rqxk2ilq8cuLUgniU7TxiP5WJlA5B/aNpgAD5H5na6rlTsTkwuuEQRgMxl
         Hmzx/U+VutgYV/zqHHkKCLIt8SssXowSEstNDGYzaVrckDPxV2xhq1E5NaJHCfPka29c
         kq/jHae92zcfaOklpEPDz6El7RBrWo9p++EUfm1fwVUDwIrBFf3vTqb46h+7DP3aZ551
         yN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MpQacvF+mAyXs6pqu3/eg9OImF2i4oKZdu4qdPo1RFg=;
        fh=q0q1LVsW8KZ2S2nG+Sea99yxc8SYnmwKK3DHkvnAhBw=;
        b=BwwS9YvjqIQ5WhdmhFQGRw3SafUlF08QxZC0ZURnr8vvl31JCCiTLXxFei+9F64wGV
         47x7P72yCoeea3odxgTx1HMOtCjX1NYfBADDj0LpGnImue3DpCkapoDSadhRVuGPV3l1
         QpxYzwTe/anMRZTX97bU00UXCaLp907TWZPM50s1I9f3AsflzCuRzZPXmbt00hA2DT2F
         3N/ZNhP4l4DPEpOtB5QKrFOkM71gtyNzJRGv+Be7S1u8LRpK4X20BGd6VQN+QAq7PJzr
         hjSYXPFEI9/xEoNJ7V/s60/tOPFRYB77UQSb/uiAeCVXhh/6UfqYzBXAqM+x8IdYVC1g
         Addg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1773354678; x=1773959478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpQacvF+mAyXs6pqu3/eg9OImF2i4oKZdu4qdPo1RFg=;
        b=DdDsoHbQQpbbpq/aniI/yWh5R3J55sdzc7y2esgxiVMBisQV0mmbw7J4xD/vbx6mnA
         vZ8MpbdMgXHHlRXWTxBxL7+mrlGy7fqAIHEgqzgT3obuSy3vgGwsV0KKK6MeP3QFBQqX
         0ZPWU0FcDSs+SmnsWSVO1OISQfSdr4cJpvqEpszw+AtoZzw4bgqphM23E01clD8k7vFU
         QKRcIakSsMXB10ZpuLVugLShLtv/MSWXphLe7Kr2qvBL67NWdaYqLkPXM7ipPB96f8QW
         Lg2NHqumobwW9ZnPfCupHFpLNIb6ABk2sFwbLhNEImG8FSNaL6R6vv0XnAn+HiIFK9Hd
         netw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354678; x=1773959478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MpQacvF+mAyXs6pqu3/eg9OImF2i4oKZdu4qdPo1RFg=;
        b=dJlE2fYhZCoDearmEgcP2vu2Bwb8yXdGQFFkTQ0np/Hf0h0DicVlwVDhVcWWJHdvKs
         rqe9qseLaDYnv0cwRdpLceJAWJmQT34S+Os+kxbPFFT0BsjYrA+qFkChqtFxX3f4189p
         Ic4/dGRnnLMtL3xLM8BgadT4fi87pAxXX07oIMi5FdyxBr4ZEuloeTnesOd/Tg3pG/cf
         eitXAVhOe9VwjjCmJF1yGa1j47drB8IeYlV5w4ynRVwGUMtcSvWZf08oDJsd1GCGZQDk
         JTwwYSPHalkbC6wh4R1Lu6yQ89D1r41Tx2Qwqo3zG/bPhfuOLfmIiwXxEF8mmixFQZ+N
         s9qw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ5Go98EGpHOhMwLj+RlxYzeBwDXxGiQzSxMOLatScaLYRzQ5WuNjhgU3I2VX5U6fSp3JJOGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Ku6FYD9SgmD/1ENsI6xqobhRT/qwzH6d4RTVwB/Naa//GbM6
	kG0wp4LClyUcaIN3OsojIMxAOfH3WFuXYiD4T9xOkSqyQ0xWX8wpJ0mtKRgEHcpBBsGpnCXpURL
	PitTxtzUkj2Bn3T8IUfdSHYcRDG6/sSUSjItkl4on
X-Gm-Gg: ATEYQzwq25fFqpj5CCWr7J8zgFv8KlLWMvvR5Sud1Bdl2WwgWDb402TxBY0oGF8Qtkc
	i1SDcl6TiDGyQz58+nRZECCPRvgOSQAuIhjCiaFde/6QGD326JDfoTuDW+DuCPE+r042Kz8BgSR
	AgfL6pYwDjLItY03ukyQyPOg8grQX1rxhAaOp8eIM5R2UMdSW76pQaA9OtBreNVhBuJVrpJuwdT
	MzWuzucjqLJrgArGMaMOGVCT+u3A+u+Vnb6ME2lwCV+1nGgRN+fjM32xkMZBS3MsrmIiE0STg1n
	SFFabg==
X-Received: by 2002:a05:6512:3b99:b0:5a1:36ac:2ca9 with SMTP id
 2adb3069b0e04-5a162b2fd47mr388247e87.49.1773354678175; Thu, 12 Mar 2026
 15:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311194058.13860-1-panchamukhi@arista.com> <abKzWIhVz_SeiSOa@strlen.de>
In-Reply-To: <abKzWIhVz_SeiSOa@strlen.de>
From: Prasanna Panchamukhi <panchamukhi@arista.com>
Date: Thu, 12 Mar 2026 15:31:06 -0700
X-Gm-Features: AaiRm51ZlKY4h04uIgBgBAaeWon8_os3iwnwKSpFi3tkPhPpb-qpMihKuCf8Q-8
Message-ID: <CACqWiXD2_O32K4NhmNBZrAUG7U9-N93LTFjJHG6Tq=4vuafNuA@mail.gmail.com>
Subject: Re: [PATCH net-next] netfilter: conntrack: expose gc_scan_interval_max
 via sysctl
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Phil Sutter <phil@nwl.cc>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267215-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchamukhi@arista.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEF5A27AEA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 5:36=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Prasanna S Panchamukhi <panchamukhi@arista.com> wrote:
> > The conntrack garbage collection worker uses an adaptive algorithm that
> > adjusts the scan interval based on the average timeout of tracked
> > entries.  The upper bound of this interval is hardcoded as
> > GC_SCAN_INTERVAL_MAX (60 seconds).
> >
> > Expose the upper bound as a new sysctl,
> > net.netfilter.nf_conntrack_gc_scan_interval_max, so it can be tuned at
> > runtime without rebuilding the kernel.  The default remains 60 seconds
> > to preserve existing behavior.  The sysctl is global and read-only in
> > non-init network namespaces, consistent with nf_conntrack_max and
> > nf_conntrack_buckets.
>
> This was proposed before, see:
>
> https://lore.kernel.org/netfilter-devel/aO-id5W6Tr7frdHN@strlen.de/
> https://lore.kernel.org/netfilter-devel/aRsuU57juCvsMBKE@strlen.de/
>
> I did not hear back wrt. the horizon cache.
>
> I'm not 100% opposed to this, but I do wonder if we really can't do
> better than the current avg strategy.

Hi Florian,

Our primary goal is to cap the maximum time taken by the GC to clean
up expired entries. We rely on user-space notifications to clean up
these entries from the hardware, so ensuring a predictable upper bound
is important for our use case.

Regarding the adaptive strategy, we are using this sysctl to address
environments where the current average-based calculation delays the
cleanup of short-lived entries.

Thanks,
Prasanna

