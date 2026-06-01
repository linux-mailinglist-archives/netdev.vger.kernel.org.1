Return-Path: <netdev+bounces-293670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PpWNpRcHWoBZwkAu9opvQ
	(envelope-from <netdev+bounces-293670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:19:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 680B161D368
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFA0230FC526
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8FB3A450F;
	Mon,  1 Jun 2026 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gk3pH9hc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFC39F19C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307821; cv=pass; b=CAFgP7twKVXXXdjj1peYCqJbdLJmU5GPeerM9/zBJ8Q70fOERZYAcDTiBQkmDsoTFeIt22hWB27ovHQdv9+sHoON3RnDVpicTEVoe0+kJWq7y687ihTJL1x5d9RZSZKGwg43kgwozRdNXbErPRa6Op+UW0lIFAcyu5c+zee0dC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307821; c=relaxed/simple;
	bh=6qMrL5EX4/Xrak0iglb2/UKbPMOkaa9nU0fmroaKenE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRFD8rDtcVdC/8XHwLgozlFH8zOH+8isqsPByoTeUzzwkP1l1bo26dC/cOr9fyW6njdKN+GCRJa1xEqKhN14BEridbjHRg1fkbXNRvxz8V6mqmrW+sEc9nuOSw/nNiOAqJ5i7qRWcsBoK9cS+ZNbqfrV5/mOGJGLTsKuNlLRLHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gk3pH9hc; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-914bbfc2464so783691985a.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 02:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780307809; cv=none;
        d=google.com; s=arc-20240605;
        b=FsnrJb64gpUHJckGIlYaqKB52pJMruPpK53k1haaDi5IKgDuhBsh7e0snlhM4/zz0q
         U7kS2zSDu7jgxEYKH9GfLpfHuKp/bfI9Hf68FQrL2854LT+4+LhX5N/h7KF3z19MHVz7
         mkgO548zyAoZcg5y/ATP1OUaeH780RAwnEMGJsQoeDki4saPNOwhncsVB1I60deOkQyw
         o6USWuX8wW4P/DQsrAs7DSJ1qCcaLN+Iaqvi898GbwUdgdAJ6MuGYf7fd5Z2vflHQzN5
         HKb4zmCudOC9AJ7bDBSTgv87cgCxXlRg+dntjJHRU2E15DcAyQa4MyoENbFaA7Yiyazp
         LQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8WWtkgmjIFBwz49S/NP4aTlcwW1QtM142ocS4oceiSk=;
        fh=yVrfOl5WXUobyHxB4BMusetll9IPwS0Qi2k3sEJRJTk=;
        b=gTZnZGJv4mlhXJU9k1Oho7gq25iyZYnHlnIwCQsxdB6ltieq2AbjdcPg9QSxLc4tV4
         WwqqN1qxqJKJ8yeB7HqLiTptuM9vF/vtSbKQ5at5ia8GzJ1Rya7ApuPuLnB4kM2JoDZu
         P+dXnXp6Cfcfs4P8S+xT6FMjLmwGyLf9ylEYx7aCR9oYVlvDB0Pfg2BfoLJpQyycUnLC
         5yN+ejem0Ehw0xwGs83sfxJVZF2L7eFFWl3CeU4jvBfYX3NYuEGzV06xHLps+Zxk1m+0
         8rPlxzwN+qZQgEKb0sV7NcNLLzebP53PfUjwbyms2I0quPsCyOwVUyV9jIPsO5cJZ8WJ
         qBcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780307809; x=1780912609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WWtkgmjIFBwz49S/NP4aTlcwW1QtM142ocS4oceiSk=;
        b=Gk3pH9hcArGEdtOshW8CUOQVjNbevLn+LCLCJXo2eQn8ZnOSswehHpBZ02j5EeoSYN
         elqmogDHQTHxQOgs+73F6adD+c73W+M3jNJ2tg0bYWiML6L0eGIdGhbwBkRfuk2pgGuS
         VnHgvkDiGjEhNpUMGTO23XPdtW28CTzdy4tLIxdtPbFAqrIvvMCnlz5Qri9HKZIVZ9wz
         IZ7YGg/NWmRHmIRVAq4oLvDxXboaurcGpwnRtVIwIPU2VpgVpt36wt66rDeNFgNi4H9P
         E4t3Nq0rzbeVNU/dHUbxfuLYFWJlR8+qhFY5AVknjRsrMNMXrA/e/J6nyRrB8D13WSJR
         D5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307809; x=1780912609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8WWtkgmjIFBwz49S/NP4aTlcwW1QtM142ocS4oceiSk=;
        b=fIiXPlkVu7f245z/VArkYM4a+s7ZqzobXuG0ctUjbwEk+tWLWcC5TNJBot62Nv8IEI
         BQ4ED+U1xYudyY3efgMcgMpOx5xnyZsRZFoVuIko6njl0c0zd0utiUUMXxtbwcQs05GW
         6xteeBG3Rg2c9Eenv/MTQhaeQ09+ma/B46wmyTIA37cDGwPaQFzQVBqNYMX6YhqZlR8F
         RLYdAmHvHJZeYn3LtFnP7oO7GL2Obccz4uygwLZvnWvjLnof8P4pn2IeImfFh+9gPbi+
         aDL7OPN94pjisU6DwKl9bGikS+EPPJ7i3v5zRH5RVJgr+BhMtshMXS2BH/WWSfoqZwSh
         eBug==
X-Forwarded-Encrypted: i=1; AFNElJ8nfS9i+l5k70H0dlNnlJEqr/VfQIWxHXonfh6Qv3Vuarejhs6VKrGnFX/D6TwLovstNvziwJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyervEJXKcR/TjbsXVyPXH8gc6riuIlNMBMzc4+9ir/uBA6KFAw
	t/Z8YrLjNiCLZ1A+cB5J8rPHoCOY5tsmVcWlUCLQ00DK5I9dkDdjS9jxFgPT/UiQlYnzk0e4+ki
	zxvhKNGImzafLsMtZ8qKn/rX0YrkwMJVlz407XE14
X-Gm-Gg: Acq92OHvoh98ghbFhk0/8OS9NILWYc+QMnHsR8M7106ehDxcBd8I/m2O6py6sHaKguO
	UGuSQqTnXpOTE8TA8D8UFLVLxzgtlwF2Ts4z/eqRSbn558Mak97z+FLF+92g6dl1M/ntzweo+vb
	787EIlrxGZoYI6SvqlnVPMXqWO4qJMzXBqaRmEyqr3haxXe5wmxDLW9YckM+/or+1bVDMI8lLCw
	C3xBkFwYnfq0HQFLIg0YhKfI/1ONXDozStQmze6sRmGygDqTEG4xQ23CtAGypwAht8EwNJJgP3Z
	s//wObea+O6viOwPB0uTJ8EduuqNpN69s1vVKI2dMSeHH+yhftvHsQ8y8wbDNZvm8Itqp2V6J3r
	cRjHtzNo3Ha7g/BgkSiuNrdynJIge
X-Received: by 2002:a05:620a:649c:b0:8ee:630e:351a with SMTP id
 af79cd13be357-9153d99648emr1577013385a.27.1780307808535; Mon, 01 Jun 2026
 02:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah1Sw2g-I89BRRiT@v4bel>
In-Reply-To: <ah1Sw2g-I89BRRiT@v4bel>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 02:56:37 -0700
X-Gm-Features: AVHnY4INcjp5rdu6uAwfJd9rymmh8udkVXYJ_7PAsacX57eqTiUgVf5L2fMjV4Q
Message-ID: <CANn89i+q8uKxsjCCe6Gz-YcHTwGZQsDWRKNO2FP=+0Z4S7uQCg@mail.gmail.com>
Subject: Re: [PATCH net] inet: frags: fix use-after-free caused by the
 fqdir_pre_exit() flush
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293670-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 680B161D368
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 2:37=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com> wrot=
e:
>
> On netns teardown, fqdir_pre_exit() walks the fqdir rhashtable and
> flushes every fragment queue that is not yet complete using
> inet_frag_queue_flush(). That helper frees all the skbs queued on the
> fragment queue but does not set INET_FRAG_COMPLETE, and leaves
> q->fragments_tail and q->last_run_head pointing at the freed skbs.
> The queue itself stays in the rhashtable.
>
> fqdir_pre_exit() first lowers high_thresh to 0 to stop new queue lookups,
> but it cannot stop a fragment that already obtained the queue through
> inet_frag_find() earlier and stalled just before taking the queue lock.
> Once that fragment resumes after the flush and takes the queue lock,
> it passes the INET_FRAG_COMPLETE check and then dereferences the freed
> fragments_tail. inet_frag_queue_insert() reads FRAG_CB() and ->len of
> that pointer and, on the append path, writes ->next_frag, causing a
> slab use-after-free. IPv6, nf_conntrack_reasm6 and 6lowpan reassembly
> share the same flush path and are affected as well.
>
> Mark the queue complete and reset its remaining pointers under the same
> lock right after the flush. With INET_FRAG_COMPLETE set, the insert in
> each reassembly path bails out at its check as soon as it takes the
> queue lock and no longer accesses the freed fragments_tail.
>
> Fixes: 006a5035b495 ("inet: frags: flush pending skbs in fqdir_pre_exit()=
")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv4/inet_fragment.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
> index 393770920abd..d532f6182c8a 100644
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -243,8 +243,13 @@ void fqdir_pre_exit(struct fqdir *fqdir)
>                         continue;
>                 }
>                 spin_lock_bh(&fq->lock);
> -               if (!(fq->flags & INET_FRAG_COMPLETE))
> +               if (!(fq->flags & INET_FRAG_COMPLETE)) {
>                         inet_frag_queue_flush(fq, 0);
> +                       fq->flags |=3D INET_FRAG_COMPLETE;
> +                       fq->rb_fragments =3D RB_ROOT;
> +                       fq->fragments_tail =3D NULL;
> +                       fq->last_run_head =3D NULL;
> +               }


Any reason this is not done from inet_frag_queue_flush() so that we can
remove the related code from ip_frag_reinit()?

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 86b100694659ee51292625216113f9411b98a351..6c5f373e55d3a39a581a6364599=
d911782469f77
100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -326,6 +326,10 @@ void inet_frag_queue_flush(struct inet_frag_queue *q,
        reason =3D reason ?: SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
        sum =3D inet_frag_rbtree_purge(&q->rb_fragments, reason);
        sub_frag_mem_limit(q->fqdir, sum);
+       q->flags |=3D INET_FRAG_COMPLETE;
+       q->rb_fragments =3D RB_ROOT;
+       q->fragments_tail =3D NULL;
+       q->last_run_head =3D NULL;
 }
 EXPORT_SYMBOL(inet_frag_queue_flush);

diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 56b0f738d2f27b6b4c4b55f5ca9368305ce1eb4f..c790d2f494870e1debd7e73b2d6=
7df017a29f8a8
100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -250,9 +250,6 @@ static int ip_frag_reinit(struct ipq *qp)
        qp->q.flags =3D 0;
        qp->q.len =3D 0;
        qp->q.meat =3D 0;
-       qp->q.rb_fragments =3D RB_ROOT;
-       qp->q.fragments_tail =3D NULL;
-       qp->q.last_run_head =3D NULL;
        qp->iif =3D 0;
        qp->ecn =3D 0;

