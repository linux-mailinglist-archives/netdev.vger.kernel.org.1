Return-Path: <netdev+bounces-264155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK20GNzwqGkwzAAAu9opvQ
	(envelope-from <netdev+bounces-264155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:56:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB27A20A5E0
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CC87302AAED
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A482B270540;
	Thu,  5 Mar 2026 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z43L6+n6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A45326FDBF
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679379; cv=pass; b=jqrNz2/fKFn86YmaYXNQYlCMzmiYs325JF6J69QrfMB4aYOvaSYCUgpUcDb5hOwaHVLWUx1yx4RBiGle7ldVt9GHLPAzjMbM9sg1zwTXvGOc5E5Zt59L3er3Bt1ygRyMFfZQuJIlRRV4o9UCK77a2NKx/9mgoBSQX5z0IcxSoeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679379; c=relaxed/simple;
	bh=ht0IGVrcPcqFRSOu+ncWUiZxG9IqJ2nk/+tnQHCgpC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niYTZC0boUGBAlHNiw6W2mq41LaZu/Jt483X6JWxCxBtRWnbFBaT3WlH38ue44u9RaLBdXaLVY/FwPVTD4qsNyoPq/UucP2L501b7rQV23Eb3qyvXnTnPW6LIexNq4SfEFfVqKvtVSrJoKgI6gPCEiKD1SEJjzn6y24cHYj1D0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z43L6+n6; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899fc265126so53605746d6.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 18:56:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772679377; cv=none;
        d=google.com; s=arc-20240605;
        b=Kp+Zcr1t6noX2Cw70UcGpzMjFk0pzguQ87rqAXAK03Fs+T7RGB7XeJwTn0vja/rA+x
         psX5UIlTfbZWhDfEsxEA1rLMiTyFk8011uJyIOl/eEd8FUFjLfc6/JnjV+lKYrEu43yf
         2dUkBFR539sI0N+B+cAuvGIfwhsiXqNQRtf1aM313C7iRCYcVGoDQ3dj4pVBY6LBbAuX
         /G6886fgnFSsE57tPhbxlbzWXoICAHJcm4vS2YcNuxCyLWTMnVJQs8iXgQJMjbUpHpXE
         r6nqak8kRqnO6Dms7x+AIwn7H2fTNmyI+yQkILB8m/VWIbNl1XDIpQmEw3/CQodG+Dgt
         jdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eMF/EB+rx/MfBSExBw84OsxodquHZQeuxST++EgCN98=;
        fh=XfCb3eNq/RGbC5BsCr+eUb6udVwBJngX6r0yZyh9j30=;
        b=MFAG7asly2WajL4/qNWQXpyTeOIfomIusma0F/pk+kW1Ed5bZ6CTmJhTx/89Fl/5Wo
         ocpU0KYFjQ/TXWk3I1oAfrxtE1oSOiQwLkdw8f/b7WjgxviSu67J46WJ4Pn7vy7ya4hf
         Q0EES/luO+E/iToRSmLIA5Og3fpTqDDVGTdqI1xti1o8k4D74JQ2ifKr2Kdyp3mEdjxu
         SHBdKYEr+xHE+geU9HZeA/2egxSUXDAeSHJ+3asKh/o30+yYXFvdSwqZ41ridrftbCzR
         zA56z0QOJ7DH2y2YU0KYYzBJXwYXJbcM+CxaHL+wq3SxpiyhmLU3wOQsKnqCefahbB1u
         QvQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772679377; x=1773284177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMF/EB+rx/MfBSExBw84OsxodquHZQeuxST++EgCN98=;
        b=z43L6+n6wdO2eIfNmc9WRZ4B0WGoO0PWeFFl2xcu8EVaYTX/S761dFxMoTI5C5+kza
         L547znwtnIYMkS4czmpzMpXZJ6/g59byEFnu98aHe0T+Mqm8D85N+w91AEYGFvQmHfCm
         Yqd5/CRogfmpoh5QJpxEEvEzer1V4qHi3heKg+bNvPIV/V0YgUcGcwI4gqOceaeBLuyt
         BpabpdmoLB9SzF7GfxaI7DJfDUgfhxJlPTSKhOdg7uXxG/Sa7JhKrdg6W+RVq9W96Eh6
         7alz5GRoI0JQtcX79eDbYGtB4bxn7om/Qm/4NpxFBGA0s6xXjsGnomKmYhoChFFZzCS+
         6m5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772679377; x=1773284177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eMF/EB+rx/MfBSExBw84OsxodquHZQeuxST++EgCN98=;
        b=MmhJaEqM9zBj4zs+5GMvVAXbwYi9lRjesQsBOJDh/TC+nZPCmu6REFws7/oQjx9g47
         yJSTvdb35GLp5B3NX3hYOBCySLdtlE1LapFuHc3NEEt1NKHZLOyh/E2KNlXEG8QlTxg2
         2b7wxXpLpmjM178r/yDzbTgyMT9cnbZ+JESXyVpm1EhfauWsVfRZAAHCtlOYeYxyuTHr
         DWRC4OK6gu42zmZvef4Y7eFhsBDrhtZfUFdD0+uu6Nsnql/bPkEd1Srnb8OY05kfJHl1
         Cc7BeQ8eXibWC5MirOdvudrSL/SRtybMs1VCnnJ8dUR9pAeskdpdGbQIXf9qmQRNM1cW
         Wj2w==
X-Forwarded-Encrypted: i=1; AJvYcCU4GZp1MOT/9IUtYBndYw1WmQoes4YiOTnFsWx2QOgGoC0e5ScppUU7VGQzoBQhAF1ibbojAuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwytPLL6dY8OlbFwbxucneL1txGPKan4Rjo7iCgcPxUDz4DoZm6
	daaNJBieUwynUZ1DWzv90hsAY4d3Foi2ivyQpB4YY9H/LAVPS3xXdR09dx+QBcuI8YuKR7Jfvzi
	8EP25O3gnjA6yVPirgfHGUCr+sPY9S7eSsIXIOLfS
X-Gm-Gg: ATEYQzyhyrH27FV1uFvEv2OHBSy44uLZNvWof9NgcL+azOK0a2v3fo0T8tza8MoPRrt
	LD19Jj/Kdw8iT4g3z7mHHJbgYYRAWECac25APLhJSFGEZi/SUCQYm0lsONKoC+66cx2PSqpC2F4
	VSYvIBfFog2qRawOb9rn3oRcKOgPA/Y5phEtyez/BOoAckgYud88t7YbXM6b7x+xnSKQj8QGEF/
	PadmYyBGH2Ut120C+OVgmrSm5fwypG9eLn/TltT2MV7tnX8yawJvIXpU4llJAUWgFTVYFVvwaXA
	fy+X4cSE
X-Received: by 2002:a05:6214:1d05:b0:89a:1321:2ac1 with SMTP id
 6a1803df08f44-89a19aee6famr66349396d6.34.1772679376785; Wed, 04 Mar 2026
 18:56:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304012747.881644-1-edumazet@google.com> <CAL+tcoC=0mGFBiOpo4Zbf5u3CkJRkp55x6sqFy47yeAbTECO2w@mail.gmail.com>
In-Reply-To: <CAL+tcoC=0mGFBiOpo4Zbf5u3CkJRkp55x6sqFy47yeAbTECO2w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Mar 2026 03:56:04 +0100
X-Gm-Features: AaiRm51TWB7EVKotvSXUOiO9KyXI7YpwUTpuxeslDJ_KsataQdIKsfR7URcmO3c
Message-ID: <CANn89i+pebidxUkiO7p9UP2Yuk4QGAcmBHq6hmLWdg_UEvZc1Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: use ktime_t in struct scm_timestamping_internal
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EB27A20A5E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264155-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 8:12=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Wed, Mar 4, 2026 at 9:30=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > -       if (has_timestamping) {
> > -               tss->ts[1] =3D (struct timespec64) {0};
> > +       if (tss->ts[0] | tss->ts[2]) {
>
> Maybe use tss->ts[0] || tss->ts[2]? It's a bit weird to use a single |
> as to readability.

This was done on purpose.
Code is more efficient, with a single conditional.

Thanks.

