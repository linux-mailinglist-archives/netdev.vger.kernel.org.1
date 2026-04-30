Return-Path: <netdev+bounces-282916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFiYEj9482mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:41:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A77A74A4FF6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 443B7302736A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C122DAFD7;
	Thu, 30 Apr 2026 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lsvd0/PE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA52FF672
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563706; cv=pass; b=Ve+6EEVgsOtdW2OmUGegE4P6+vIu6CIAnIHg33cKPCZ6aUESxuRoKvEBp3JovU0/uJWfIysGSoAUkR4TWt16C8SBObJZPtPRCJA4iRwXpkzXxKXATp68yGRxBF95h59I78409afOJflkExX5iEmhd+2rY+dmmQL+/u7K6n7tUU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563706; c=relaxed/simple;
	bh=CTnm8jbixxkr+n0+syoF6WFncIQ1WX2G9KR4zzj6vcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+gg04YY9s/l+qX2Jiu8dWv9zGsSHVcAuyAm+HTwjhkifAmjpfMUZvr+uOlYx9l5PcLwEqX6MSAVBTatqDRnV+WdJO7op8v6mJL/tSlNkzR2U3TQ+jUEeTkjs6CIdeDUr6SRT4xr6UaEqQ/eLrKk7ZDT2PECp9jzk08DZ9ANiFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lsvd0/PE; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e5c7eb565so9425301cf.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777563704; cv=none;
        d=google.com; s=arc-20240605;
        b=M7hsMO6YY2kVH3mJ1rCalbOQWzPtOd5gslogpr2qnk6f6Uim+fq3TAxdVaFg57tDXe
         C9fFz29SsFXNqdY2K4K+BVbMhyvHPo4GuHM84wTr5kahG/SNGh3gXzhN0wwKcfrxU0BV
         EQS1q1IceiLuSz3bdUq3P3NUuRqYy5YL+w0nE4rb9P9h8AEwEem675GyAvFnCbElk0nD
         fvNggSqsfonVaNMG/HQWSHvc/iWoz9dwXLBJ93WdFa92/+TZNFbkawyR27M518T6ANUF
         GcTIeBlz8ZBLH2qyCqv+S/aBzUPWB+5YdwcQmTJciUWZmQNWOYkAU1aMF/cp+ds1Bdnk
         bCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4fWKCvUcYkO7KnC4xGz/XeA+D7NpQomx4e1roT5OH94=;
        fh=Iy2XQJamSMJoeWqwxtepJZ+MKGh8QDUjPwyraS3u70o=;
        b=IKLV9PkB5aNKbgGIUOV87IIz02x/8J6EBCfkZIrEL/z1013rUHW/x3BDiaGvlZihMV
         5Zx4c8TAgZ3APGU/Ry66Nv0z4TcmDNQauMxOljQvkWtk4DHTjDe7bSeqrCE8AMJO1+Jm
         bhU8vrrM48+dEA4NVZd+LzOY0hfYhypYPGmit3F5R3ge928tdOVxp+Wgd745OadWqHon
         T5ooc848rXipsmZfsgbgudXJoYcekmPfuKcXgtEpPjq1qxGlg7joE32v/1Dil+lBBnS4
         G1cRnj0uqbXwb8BCp5PfuJqMtUbHqmFU4X5hhJVMM3GTdat+Irpf7JvsYrPpUADyfw9y
         KZpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777563704; x=1778168504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fWKCvUcYkO7KnC4xGz/XeA+D7NpQomx4e1roT5OH94=;
        b=Lsvd0/PE5JuOV3gxqXCkHTg0Ao5QCACI0TuHMZaA0HQ7MGXFrsgStXef1tivxh6C0C
         e79NLqnKsm1b9FpCSp6/2ml0zePphn/iax84jTNIWzZneRlCoIrL5/Kjyaqu+gZIhFOD
         yoGOwVjqcmYhxxrPnCDuslqC2Xp8VzrHkr4weaEpND7wKVhZXQKkflGf2iHVh25dXRUO
         2hXbftVebChGb3ISm/ax8oTNkgDLSLSSetDYlMBTWIoyhqYvvwVhIi/UlUup1UHoN2rK
         69jMlmtqNGmWiYrsVbl7BoU/lJnBWVwf4zGRM3E3FZrIO+ulhBxpQ9rfBwIT0544gmk0
         Tqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563704; x=1778168504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fWKCvUcYkO7KnC4xGz/XeA+D7NpQomx4e1roT5OH94=;
        b=BkGKQWuepGZi2cfFuUsR6bnotTXdtFuVgFUXYV0LbltFVeMzIOeX30pp4KpUSmIgtD
         KBjRSnASNwPe3U3Z6ypqdMqlrI/Kzr3g94Ixc7Gd5P5ozTX17R8392LkbPWZ17HySox3
         IkHjrNObqTyBJ/LMsfr7NEOKxMlRbPCWlFXwzscrJicIlC3mvknE9ywUFMIQ/vtKnLA+
         wEZ0lzYRee5shUqxF5JM/7l6Dyr/4NuJIM1JH1WM7ynt70I9pAX6bJRECDvLHYVxmd3Z
         1mkkgulDfdqlrp9NLUgUKlnFBZSU/q/77ojqky43tosB2a+zZpljV7PBBuTUgQJChuPQ
         LNrQ==
X-Gm-Message-State: AOJu0Yx264U3a9dlVKh2CTM1/gP/3ZzOZ2lTmk/KzsqFzaHJGhNSVqu/
	nW6ahdQOHknA66RofosLhhwHd1UwctGWC15d9iUiXAxyyfXZ/kIUpNqM8QobVEr5gBT3DhjNUKp
	6NuEE5kSe+QxvFXXq2DbVMgYu8HfV0Lm4W8BpgOjJ
X-Gm-Gg: AeBDietPQbekeIGKgF0mQd/SoJ1getoOCkFtpyd+93M2OaHS0qbbMb1qeyb2+IWWBxb
	Ug+Y1N0RH0/CZK+8ijFE68BzJvUu/DlyshdvEYwtxnQwEyT7APT7PuCfEg90rM8AuhUvSs/WTLe
	mb2ijwSgv1MzQxPpCP9yBNmWOwjqv4f4DOgZJLwX4wFl61m1VrIZLsS7YOCjz8ZNdNW7KpcsLVR
	uEDgKiS+R/VL9GNXTa/cN0POsLAXqsAdEL6Rd8PNMCak1BVUFVVciVi179AlH/I/Wwz66exmBAw
	xvuhUS2Q6Onfojs03X6nb6Vp2H+HW/H9ZJ07DVWI6p6fOeJ9sRgsEe4Ibva50moWCGC7Q/5hE4b
	tFDfZEd9NrPNAMBQbBE8MxWUV/q/RWzUbzHBilf9Q
X-Received: by 2002:a05:622a:1186:b0:50e:5cc7:97c9 with SMTP id
 d75a77b69052e-5102ae07329mr45719901cf.34.1777563703768; Thu, 30 Apr 2026
 08:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430152957.194015-1-jhs@mojatatu.com> <20260430152957.194015-2-jhs@mojatatu.com>
In-Reply-To: <20260430152957.194015-2-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Apr 2026 08:41:32 -0700
X-Gm-Features: AVHnY4L0ZMuYpEJ5g14e4qii1WBLn7wy0aw6djcbYX75S6c6yexgXJfpiaMN06o
Message-ID: <CANn89iLkdvOhBHnL37dWGPCHj9_j6aaXR+cgm0mTXHFPfxTywA@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net/sched: sch_red: Replace direct dequeue call
 with peek and qdisc_dequeue_peeked
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	pctammela@mojatatu.com, ghandatmanas@gmail.com, rakshitawasthi17@gmail.com, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A77A74A4FF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282916-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu.com:email]

On Thu, Apr 30, 2026 at 8:30=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> When red qdisc has children (eg qfq qdisc) whose peek() callback is
> qdisc_peek_dequeued(), we could get a kernel panic. When the parent of su=
ch
> qdiscs (eg illustrated in patch #3 as tbf) wants to retrieve an skb from
> its child (red in this case), it will do the following:
>  1a. do a peek() - and when sensing there's an skb the child can offer, t=
hen
>      - the child in this case(red) calls its child's (qfq) peek.
>         qfq does the right thing and will return the gso_skb queue packet=
.
>         Note: if there wasnt a gso_skb entry then qfq will store it there=
.
>  1b. invoke a dequeue() on the child (red). And herein lies the problem.
>      - red will call the child's dequeue() which will essentially just
>        try to grab something of qfq's queue.
>
>
> The right thing to do in #1b is to grab the skb off gso_skb queue.
> This patchset fixes that issue by changing #1b to use qdisc_dequeue_peeke=
d()
> method instead.
>
>
> Fixes: 77be155cba4e ("pkt_sched: Add peek emulation for non-work-conservi=
ng qdiscs.")
> Reported-by: Manas <ghandatmanas@gmail.com>
> Reported-by: Rakshit Awasthi <rakshitawasthi17@gmail.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

