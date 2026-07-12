Return-Path: <netdev+bounces-306948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LIijF+WbU2rocAMAu9opvQ
	(envelope-from <netdev+bounces-306948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 15:51:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CA1744DE9
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 15:51:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=d6UAqy4b;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306948-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306948-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E5813003622
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642BF3AA4F7;
	Sun, 12 Jul 2026 13:51:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9939A061
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 13:51:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783864291; cv=pass; b=RIAyNzaSWpzUHT0uPBsqJwV9dSZ39zbR83dLzPI+zICnRmEQu8l2Gib7FCFV9rxlBGBX2bsR6X90Y0ZK2O1/LaVsV6Wd4kytMPBouZi8U4jDHVbFcxA2BG6oal0SnAnJPXbIZlB10UNlfX4lEDlAlvf35AfIoM9Afymk3pcKqrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783864291; c=relaxed/simple;
	bh=oDP0mR1EofatT0pur4pCie4dYJKereMksrCnMIlZt88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=np4aqjWQ/yvtXieAg/m2JpQjXstm7gwaBrXi9j+l639roYKgl4tJXTyuc9sPY7a0JiPaqZrtmSL0fzMa8qzfa6/xbPqYSZv0Hv2H9vTPSCLd02Hb4twvmRIExo/Uc+cv/H+PKZlLQPgWNdbdogqjX0X4KnjiShk16pW0/bREgz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6UAqy4b; arc=pass smtp.client-ip=209.85.219.43
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efbafa1bacso18025496d6.1
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 06:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783864289; cv=none;
        d=google.com; s=arc-20260327;
        b=VQG54+nSbVkAsELcUAPqXU1al+aCWFS9h+7HwkdbLrBPRkZ1L+JtY5tZ3N1n5BZC3Z
         4559q6DRtWDTXWJmo7zAX/P/AeK+shF6NQL4ubJeOY99bKUVjUhWLc2F9RQpnGzy7CH9
         Ppu/2N6Fq2aTISzOhjMCHd02vzMkMuilWzRT3JJF4+9yAF4VRGYnwKaRZziMFI21fSkO
         5FQXw7jXJM9PuwPKbEUE6eii8HSnbMO7rXbfLj5ygF8Qo8HaMDBZhxRwluc6MG1aUHhf
         t0TUfQWm5nK4yP3/PJyKgWgQVhUHPYLeQ5mUo9qsHxwMvngM24dNRTVO5cTKfuaList2
         yrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KPaDnid7id71L8MuAGH6afuYcqEb9Qc/jYvhMfY03I8=;
        fh=v8UFJSeLPJt29zVL7fP/E9t0f4liOBi+1Pd+31yALhA=;
        b=H4T4qF0hF7NkJVV3kPC+8FUH3o++9lr35tOKkxvz07tlxogghjxFTFUlzn09yKuYuv
         Q3ZzGrU7gsnG08BD+hZLUCPC4fjs8+4ZxJMFs29RSBoSW/1VxwoS8gRxXoOp3NXxSaQj
         kpZkccFRd3zE97FNAGbJE5/ExYJ2almgCpnxj1BBaRv51NGj72KJ3iw+d1zg3MO1jRVH
         d+QSEGk9LwiwOhWyeEQXQeXJSYd2fHKba9jqO2NQoaYA3aYmvvRgdYfcKcjE0I9vwyCE
         gdX0ajHjzmzlsWpvUxphMmOd2lc9EMl+RvzYN7Qhf5hLh71eTceQ4WEMnCdcjmdLretP
         NRjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783864289; x=1784469089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KPaDnid7id71L8MuAGH6afuYcqEb9Qc/jYvhMfY03I8=;
        b=d6UAqy4bD8guehT/2lXLYkhjSaWDrHGdlPua9QEyr6BZBReXdyOdJ2XpyAHFKTeT/0
         a/2g/uH8FxpOYczmZnEYFtrc0+3pk4di3Kgkbim0pKoZAfknpRVTIgtdJeY0qpG+TlGc
         CaloSUDzIxgUbleeqT0wlReexKU61ujeiZl1wjkEG6pSWCnEsZsqB4z1YBwd1f3UTHZ9
         EsfCapkBZ9MMeOx2jCbpfP/5YDBIvj+EXxLvkW6FnhT2hsmqdRaFQw+pOBqoZIhZzT/W
         8YAAVmf/vyuQdA4GTxbKJn7FyHPw5ptLuonkur/SSk49WUeXYFaWPuR42+62LB35zy3F
         +qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783864289; x=1784469089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KPaDnid7id71L8MuAGH6afuYcqEb9Qc/jYvhMfY03I8=;
        b=ay9y59gRO2Te3ExMA934Uy/TZcj1NawHLOE40fgtaWA+9dH5wt4hHDBJy/0v6AwJy4
         2h8y7HXQ2RDAAK17bd0+8Ciwk6Ankt5U/Smquq8u6h9o3HH3sUhC343OMbKOMmYDGb3B
         bE4Zo1jTdDy1lIChQvbw8Qou89F/Q6zKpvGX6k5dsfbiSUioGp3nSs4YD9uYzHDkQeFk
         QeL76OJrZ//nfEmkG7cTHPlu4xgCaIrjjVbMlVPc/9Ij3yKPYkjd+Qwb9BPHQswItSmz
         umfXPJG4bEFZzMI+9jGFYye+tfjdg105OFO49WXU0tK+51jYpD6ZOl8kzCL9vmuHRWxz
         FaIw==
X-Gm-Message-State: AOJu0YxvhjPbppgpMSYgRRVUb4aY807rQ11DJT0BZZ/ZdDQDbBuD0xf5
	ohQtaZi6XGT5IfMzpH4V4PRTT54nNBWEg34oaHQOLC1Bv1oWMTGB7kKAZNvy0SsTXzEcMcrvacn
	uts3KPfh3fQxInIPVYA3EBm8m4rmjXdsZ9md07oBC
X-Gm-Gg: AfdE7clFj78TfU5fpZ5YXEq2Kyr8Vw+ZRmKtlU2I2DyZsd3tnpsoTqTIn1Kcyyeria6
	8jUA+GA79MbXz4+nFx35G6VGU0dAtTwgOGL31KeHZPu/lY9jLRJYqnLuquSf7CihH3CBMv4KR9h
	DPXir99x3EqOAg9EQB80MyRXl5fccOvcwseLfdJQmSsdTFYo/MDNpKtcRoQqKZNdQQmH3cD7mAZ
	uBWG8ojF2XYQ91L1fpaATR9SkyRaECalYq6F/gpifEi28hiFYBTOKsjN0ENmjfBWCQ8EAo0XjlN
	+eNDqKyJUuJP6VdUnDz0CCA8aIzHhOYhtqDsYddOW8/d7+id5DqVmo9IL5TT2vxA3b7yYD2B96o
	ct1q5dBmA
X-Received: by 2002:a05:6214:2aa4:b0:905:7415:d019 with SMTP id
 6a1803df08f44-9057415d14cmr22982556d6.36.1783864288356; Sun, 12 Jul 2026
 06:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712132531.33028-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260712132531.33028-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 12 Jul 2026 15:51:16 +0200
X-Gm-Features: AVVi8Cf9v2yHkrh7qafNb_R7r25uOxLYtf7c7-SgvEWHVnZtF95shTByiSnetF4
Message-ID: <CANn89i+X+VQ-4a-qbM1-qmykR9stXo+sEQMOgj9AkhXSHA7LYA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reject TIME_WAIT reopens when SYN queue is full
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-306948-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,tsinghua.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3CA1744DE9

On Sun, Jul 12, 2026 at 3:26=E2=80=AFPM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> A valid SYN that matches a TIME_WAIT socket is redirected to the
> listener with a non-zero tcp_tw_isn.  tcp_conn_request() deliberately
> exempts those requests from normal SYN queue throttling.  A peer can
> therefore create victim-side TIME_WAIT entries with short connections,
> replay valid reopen SYNs, and withhold the final ACK to allocate
> request_sock objects outside the listener's normal SYN-flood controls.
>
> Do not send syncookies for this path: tcp_timewait_state_process()
> derives tcp_tw_isn from tw_snd_nxt so that a direct reopen uses an ISN
> after the prior connection's sequence space.  A syncookie ISN is a
> hash-derived value and has no such ordering guarantee.
>
> Check the selected listener's SYN queue before descheduling the
> TIME_WAIT socket.  If it is full, account a request-queue drop, retain
> the TIME_WAIT socket, and discard the SYN.  Once the queue has room,
> the existing direct-reopen path and its TIME_WAIT ISN are unchanged.
> Normal SYNs continue to use syncookies when the listener is full.

I do not see it as a threat, sorry.

Say no to AI hallucinations.

