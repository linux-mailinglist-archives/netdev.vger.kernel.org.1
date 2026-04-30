Return-Path: <netdev+bounces-282920-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH1lDZx582mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282920-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:47:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6CA4A5179
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66A49309F923
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B4E40759D;
	Thu, 30 Apr 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvWITKMm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88742401498
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563769; cv=pass; b=q3iirG27Ubt+LjcyzS0qJN6l1FpViEsyszQ6fuQC5rz/vSqaBQptflaOuLOIY6RyMdpadsXCckqg9vYXX1OmjC2Dhs7pg85WKhZ/2N3Fs4e9UvYM8OeJkFlrXH/pZeQjJrB/YTkEtZLtQD+dvLrMZoKnst0Bn6mkO9qYbzLDkf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563769; c=relaxed/simple;
	bh=/tI3nemy+5o5rhw9EKFifIfBFcxIAV5VrVbT9R0+NDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMthmaTAu0TNewNkVOaF2sMmUA/56ix5MUN1bXXoxQkJDDfltF4pedGS3+JgB9XuMHOplowmQnM2NzA2Po7CSAyCf84XsH3eNcD0ws2/hwC1yJcCLXwwhGCtqau1cTOirWfJa9dJzPx5Gu8Jh7PKFDRHbF6loATV6I4/INQzsvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvWITKMm; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e5ad864a6so10149001cf.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777563764; cv=none;
        d=google.com; s=arc-20240605;
        b=baL3hVm9POA+SpDAG+1dHUrGuVQ1dD1pDaqkgYoLADopUvYQcs32X49tjyUbE1EfVF
         /C52/9ItcwPQL9U+vXqj2pK3lWhF8uZKZEje6EK+M0P4uqvHkT+AiIVEzFASZHMn+m/x
         p4o0uUfa2JWf3DuXYsPGJg/24biacN5eRq1Kb6g837YmE8GJWVaOgjbBy34e7eBEGKCm
         p6iTn89di0GegPCWpE8X/56EwGwhlaLJ3WzOziads9dErknsHDKRx8M6KU9hDGPRvZI6
         74K7p2z0CDeHLbwLtx0shfjcqS4Ij8nb1BuPD8SAm9pBy6V4W1sOIwkrcNdM3L2LViLE
         xQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YS7pav7IZfZN0Z4brsPr4DcNsJFXH3CeO65Vi6O53oQ=;
        fh=R2COx0uBBaEQQdqDBAsdWXjsp35rvgMASrLLLw0YWs4=;
        b=Drl/0E+tuY/esh2cxfbk4iG0yDG8bJHq1d9deFy9u/g7kZpSQsB5Ry7B6cO97SdsAp
         FrVIlgOEYu5NlULe0s9x7mQd7I2TGMnJ0Hyz8wlsrm3NJjR/hJj1gc5TF1jwXphDaDOo
         L3t10z6HVeOK27sxhfAO0XvtkSOwLqISM8iL8BMF/V9bVrUEM9z18mYlqg53dzlTbpq8
         XuONSTzrRfcpv94vF9rNBumdSxzkgBDmrxEYEdP9SfEjwSHpoaNSz6q5bIaElDHiy/Wv
         dBV+BFDA+Pe0mOqxtU+VLS0jT9aNvCyMlZTDfX07b7r0eE+k1dFj7iJpnzzWoS+0ksnB
         61hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777563764; x=1778168564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS7pav7IZfZN0Z4brsPr4DcNsJFXH3CeO65Vi6O53oQ=;
        b=pvWITKMmiadqzo3snuRE/OBQt56lnsLKBmFSVmOC7rZXwSf3aMEnOOPQ/KNRaxNHKr
         Xfd5sejKkYu5xT/6FejBoXkZUiZgZQjOFGvV02W03Tp1dkWE5k6tSn+UroD3F74epE8e
         iF9r7mPVl5ShMpy5Yde97oXf/wt6/X0LN0ZOC+MnASUoYYv7FGmgb+S9Ro8BGpOJk46I
         d1+IOEuUhv9lb8qKzXGLJy1aMWJAuZPsqcoNs0f4NdqzPezEFbYbBvG4H/+Mqhh4Pazh
         Qc2/BzffWeD4QVMKE5g8pfVD0cjOiYmNoECnHTwhiExoBdgh774cdKHmccXgejuFbqA1
         xhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563764; x=1778168564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YS7pav7IZfZN0Z4brsPr4DcNsJFXH3CeO65Vi6O53oQ=;
        b=Y3vAdXguY4nrWhCdlRCjYvypPO2BUknrK/UfWtbCIXEvWtkwl7o7Q2B9qEAUTf5zGB
         6mG/H8wUxWCWvu1XeAOmezaY9+DStnq7VM3BHWninsyBXFEir67CTL1TwJ6L0YK7TVyY
         lJViXpLYG+TBtgeIpotg6wrY2RFtECRNGGipGGJRvMSc8VTiCiuh1K2jxFYx51QYqaUA
         fuzpw/cc/JVOkW7Vf60qnTlJWcXGgiFYRqzTYTg+kdaf1jGFmVa1I2H3UJFQFM+Xa82J
         sr1BeHkmjh42KWebwKyCUdjRU2rYW9rVxjozj4JkK+9SD9OsbkyMJ9OBjy6wGiJRSJ0s
         EGyA==
X-Gm-Message-State: AOJu0Yy1PfEsUT2wxOfdrb0IZEcHeQHs3COMXUkrxosQztdzFvD3iVW0
	00imyE10oip6RcevLPnaofe37hqQMS3GdO7PKPwOi4s51sMve3AZnXFhtOcODFCuvwZ5mwqCMXI
	JhGpJmMN9lLsKzEkUgVJiBnem84nbpIKs0QV5tueJ
X-Gm-Gg: AeBDieu2DVcyvPmScDJn6q+sXU1vM8T54lerWbZ5x3GRn/2FXKSxDg9BcpjAqBybSjk
	cw6O7Mquoy2y8gQsgLhO1xYSL+PIb8VZiWgoSPBexM9yQoQgnhrmmn02mdZCd+yrPj9geUmQt2c
	1jOCoK0hrtjD7cL4Y62AEIKQIX32Nji/yxRn5uCxk5ZuKCx9Lury64XM/EtXANt0HAC6NKKcFc5
	gg8N9zd+3DfXP1eYd1TR9oYIt80H6Q8SSX3usgBTwtBAM829pb0pms+2uPW2M/TlCOuCawFcJYX
	OgihkuanE80tKddpxo2AaK3fBLJ9T8m4zM9B1/18pJgXcofGFYkhkoUgiU0LZcW1Qraupthyrtd
	XqmvzqqxdOg1SZRVwVpM2VMAtKMjtTZ91aq7EIoiAmzSF+eCzpuQ=
X-Received: by 2002:ac8:5915:0:b0:50d:81c4:4c79 with SMTP id
 d75a77b69052e-5102ada8998mr45823981cf.35.1777563763230; Thu, 30 Apr 2026
 08:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430152957.194015-1-jhs@mojatatu.com> <20260430152957.194015-3-jhs@mojatatu.com>
In-Reply-To: <20260430152957.194015-3-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Apr 2026 08:42:31 -0700
X-Gm-Features: AVHnY4KP2NlXdbXHzcxnYeCvdy_BmqdXq3xr0rIRVXYtQ61GDJPVTRlE7iYayis
Message-ID: <CANn89iJxyiuwXOTX2yvKZMwdmKndNABd-4dbMha=TbJqE6WKVQ@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net/sched: sch_sfb: Replace direct dequeue call
 with peek and qdisc_dequeue_peeked
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Victor Nogueria <victor@mojatatu.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	pctammela@mojatatu.com, ghandatmanas@gmail.com, rakshitawasthi17@gmail.com, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AB6CA4A5179
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282920-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,davemloft.net,kernel.org,redhat.com,resnulli.us,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 8:30=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> From: Victor Nogueria <victor@mojatatu.com>
>
> When sfb has children (eg qfq qdisc) whose peek() callback is
> qdisc_peek_dequeued(), we could get a kernel panic. When the parent of su=
ch
> qdiscs (eg illustrated in patch #3 as tbf) wants to retrieve an skb from
> its child (sfb in this case), it will do the following:
>  1a. do a peek() - and when sensing there's an skb the child can offer, t=
hen
>      - the child in this case(sfb) calls its child's (qfq) peek.
>         qfq does the right thing and will return the gso_skb queue packet=
.
>         Note: if there wasnt a gso_skb entry then qfq will store it there=
.
>  1b. invoke a dequeue() on the child (sfb). And herein lies the problem.
>      - sfb will call the child's dequeue() which will essentially just
>        try to grab something of qfq's queue.
>

> The right thing to do in #1b is to grab the skb off gso_skb queue.
> This patchset fixes that issue by changing #1b to use qdisc_dequeue_peeke=
d()
> method instead.
>
> Fixes: e13e02a3c68d ("net_sched: SFB flow scheduler")
> Signed-off-by: Victor Nogueria <victor@mojatatu.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

