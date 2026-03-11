Return-Path: <netdev+bounces-266447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFRECSXisGkuoAIAu9opvQ
	(envelope-from <netdev+bounces-266447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:31:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E61E25BA27
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DB6B323413C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211DE2F616B;
	Wed, 11 Mar 2026 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VEuMfloW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F232E06E6
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199564; cv=pass; b=X8pANXRIE0dpXkqYYlP+HPSIiWWcGc0PUB2LaS7D34ejiWk+4MwYLr3nYXApQlQS1z5nu9WwczUAyFvfxU4N2Qlt9FAfZW9e7iljtQctzrTsoxPofusqOMKXgWj/xansXV23MJVQTfMfX2DDMkbDtSVe0S5eMgr+LYYdhQOoOZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199564; c=relaxed/simple;
	bh=mzpAkzG9fjf9UXt86O4rB1ItbHSHGLkmwSbDibbg/nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2nwFf5S9nOEtylxLkluLdyXLAYXCwP3O3bd8nDN2X+4yrkGwbrlKzrOgCYnPGCaeU8gX0NyD/7EsBXmbpAGJGiGf5fTa1zv2tfzcd4cBTvLwQBixXP+9p7uu9qSf8H+4wvq3mW8zlJjO5nU0p/VFbV0zFNsde0U21jC9tipk5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VEuMfloW; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-128d2e3074fso4787536c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773199562; cv=none;
        d=google.com; s=arc-20240605;
        b=icp9IA+FnER4NTjkZyQ8crDBM66nmqkA4JCyqXFHfeUCCDngnbZDNK10LxM/fHEmFG
         29295z+CCyzqZRpjT5nsnT9cAqIHKucxCDrcMQLZWzLXYm01VJ0+fU5Lgbf3mmcqbTt7
         lFpo8ut61ZCvQW2I9R7S5OeufmwHuT3xkolAjrSS3kC5ZzWJwIYszZ54gFJ8iQTxle7G
         R23b48qweCRNu8L0w4n30NjH1yOwDAf85Al0b9It9i2nuncALUwuv4vPxKms/r+6ONYZ
         okBkmlo1ZmTd4bi5mY+1aGaSGI2r6V/q7GNTNHUephmO6LHR+XIANsyl3AroCpHeUQLb
         sLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lXS2GlmYXXSCq6gPG2JwjXS13V2LdQYrOfwZoD/0pWw=;
        fh=SmvcnGAznyaaAp3Z72I+PenSMMcXMJcNMakXzlTraUU=;
        b=DzQxCVFRuWCAlDMbWtHITxhUfSHVMjqCCn7nQhemonM4SU4PuSmfR4w7ezH7+WmTKl
         c3rBOpHeu93r22yZJZLziQBdrLUWuskrrPg31j+/qjBC9TbvhdP9VQQJW8jsmlR+6Uel
         XCIwIW8lReOpkI5GOt800G3wweRF0D0/RL4x7E2yMq4OyhiAchd3oXTh/PQ6BPs6cfg1
         UoiNdbCZIuteiNROnHAd4/YZ1+6plZWaq9Fk9yGdqsTl9WYK0BnUrusPMC6O6R1MvVcY
         UPSS3RORGGVUk7EIKhEChdpcFfFDJlmKVeLerN1Q/kWtEWbNMVjzOjmNz8GJeRdgp2KU
         jZRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773199562; x=1773804362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXS2GlmYXXSCq6gPG2JwjXS13V2LdQYrOfwZoD/0pWw=;
        b=VEuMfloWbLzEiHs2wVAQ9/djeyWswG0aofcqI6hKbWCY8gHQC/+C1ZRW8rx6qxR9QA
         intlb8UubImRZWjxMrWh+9MLgussgS1JEPBQTUyJP5N5T7cNwdUlGa+IMJIO3yICprrY
         apgrYp5CbD9zx2saN2UOAOhyx9BsS6fVtJfKRI3i9G6RiLVP+JthFmeBQJPnpmnYse2d
         OmzAF3xozYglAG39oFkNedHNuRbzhgaGeez2IA0uF0ndVaHi3qp9cvHAQhy26fvUovK9
         xTdBnQoX7Ow0TPAR/cBjwbzcCetQXAzQLPT3sCjbVYxxiDPXaxhnNVNOTyiZIQvm+fKi
         WAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773199562; x=1773804362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lXS2GlmYXXSCq6gPG2JwjXS13V2LdQYrOfwZoD/0pWw=;
        b=bpJPnEWm/0vucccOSH8BhCRUetNQZ0FaC8uSaRSFALbkT+T2hQVZMyjmyKIpV4cPbc
         x1X8TAB5H9qCHY0bevRH9sfdqYa/I56cbW/Ub0aD0yTREEincPEWI6Mg36pnt3KSTMFs
         ORHsozSTgvr4WecsYxl12uvs2fG3S4rnyFkpRiF+9IjzSIUfe9UK5hLl4gLoCvlts0nk
         5rMtJVTFehmA3IE3GNWVV/kymZK2ytU+5vq8yb/xXZH7P5tCVg5AmStIqZJBNFYqyzgU
         QtxacjAhD+TpMJxInJjC36RcKcItUtWSBim2ogYCLHdPWgCtS39M87BQtO30p5CKVhCx
         Rpyg==
X-Forwarded-Encrypted: i=1; AJvYcCUAJ97KI9OiVBtNF2g20qUtdAM5QdQv+oxwVNyYoIKLMYEblNpQq5oAcJWtR1/LQLeZb1LzipA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVHaBJhdLUWfgjl9JbT9GW+e3wxojrP9tQPXpZE8j4jIpHCKK
	ioZ+yUCiSCCdi5jbpmNN+mZQ+73dGMbExSSc9kDAQBAnriINz/Yk92ulC6s18BlCDhiw3wVgCPr
	44OmEtigQbPWozqbBG9cbGV9CRSuJikqn0c6493xR
X-Gm-Gg: ATEYQzzdmLqItJ8srySalYByS+rsg3N80PcTVAq4zGh2ZE5smX7mJ4VUdGagZtazSRP
	CnCxsc79SQj3Mf0NI4KcMpqN04j72I3SE3DPbYLOhfRHuitH4tLmXjXk3TaSPqomwkfsP62nTNS
	lue01nK2T2ixWUkX1Gj0oD+zLJzi5y8Kf3z8VpW5A1lxapMK94lCY0sEXeGhMZ+Mnd3UWx8lrcQ
	50kHgRqpnGTuApQisJelBhPiTejzXBIxK2OXaIxpDD2gHISsbUrEvsToZ5AtDx5kbR6uzucotaR
	cP1xDJD8/52dvvxABpgqKnr+cCG0frUMp0V1Ydg+r6bXW2d4Xw+FQyYAfLGyj6rF5udtec0=
X-Received: by 2002:a05:7022:78e:b0:119:e56c:18b3 with SMTP id
 a92af1059eb24-128e78494b8mr451366c88.27.1773199560464; Tue, 10 Mar 2026
 20:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309185823.3502204-1-kuniyu@google.com>
In-Reply-To: <20260309185823.3502204-1-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 20:25:49 -0700
X-Gm-Features: AaiRm526XuL2ztWrEOg3OaKtcleZy_oiQezgs8fv8vJP419eMQJxprMuKObl7RE
Message-ID: <CAAVpQUBEyvGA5JQgdmrxc3a-7p0E_gNmb2it17EsRgkwzy+PgA@mail.gmail.com>
Subject: Re: [PATCH v2 net] af_unix: Give up GC if MSG_PEEK intervened.
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, netdev@vger.kernel.org, 
	Igor Ushakov <sysroot314@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9E61E25BA27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-266447-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 11:58=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Igor Ushakov reported that GC purged the receive queue of
> an alive socket due to a race with MSG_PEEK with a nice repro.
>
> This is the exact same issue previously fixed by commit
> cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").
>
> After GC was replaced with the current algorithm, the cited
> commit removed the locking dance in unix_peek_fds() and
> reintroduced the same issue.
>
> The problem is that MSG_PEEK bumps a file refcount without
> interacting with GC.
>
> Consider an SCC containing sk-A and sk-B, where sk-A is
> close()d but can be recv()ed via sk-B.
>
> The bad thing happens if sk-A is recv()ed with MSG_PEEK from
> sk-B and sk-B is close()d while GC is checking unix_vertex_dead()
> for sk-A and sk-B.
>
>   GC thread                    User thread
>   ---------                    -----------
>   unix_vertex_dead(sk-A)
>   -> true   <------.
>                     \
>                      `------   recv(sk-B, MSG_PEEK)
>               invalidate !!    -> sk-A's file refcount : 1 -> 2
>
>                                close(sk-B)
>                                -> sk-B's file refcount : 2 -> 1
>   unix_vertex_dead(sk-B)
>   -> true
>
> Initially, sk-A's file refcount is 1 by the inflight fd in sk-B
> recvq.  GC thinks sk-A is dead because the file refcount is the
> same as the number of its inflight fds.
>
> However, sk-A's file refcount is bumped silently by MSG_PEEK,
> which invalidates the previous evaluation.
>
> At this moment, sk-B's file refcount is 2; one by the open fd,
> and one by the inflight fd in sk-A.  The subsequent close()
> releases one refcount by the former.
>
> Finally, GC incorrectly concludes that both sk-A and sk-B are dead.
>
> One option is to restore the locking dance in unix_peek_fds(),
> but we can resolve this more elegantly thanks to the new algorithm.
>
> The point is that the issue does not occur without the subsequent
> close() and we actually do not need to synchronise MSG_PEEK with
> the dead SCC detection.
>
> When the issue occurs, close() and GC touch the same file refcount.
> If GC sees the refcount being decremented by close(), it can just
> give up garbage-collecting the SCC.
>
> Therefore, we only need to signal the race during MSG_PEEK with
> a proper memory barrier to make it visible to the GC.
>
> Let's use seqcount_t to notify GC when MSG_PEEK occurs and let
> it defer the SCC to the next run.
>
> This way no locking is needed on the MSG_PEEK side, and we can
> avoid imposing a penalty on every MSG_PEEK unnecessarily.
>
> Note that we can retry within unix_scc_dead() if MSG_PEEK is
> detected, but we do not do so to avoid hung task splat from
> abusive MSG_PEEK calls.
>
> Fixes: 118f457da9ed ("af_unix: Remove lock dance in unix_peek_fds().")
> Reported-by: Igor Ushakov <sysroot314@gmail.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Use seqcount_t for proper memory barrier
> v1: https://lore.kernel.org/netdev/20260308030406.1825938-1-kuniyu@google=
.com/
> ---
>  net/unix/af_unix.c |  2 ++
>  net/unix/af_unix.h |  1 +
>  net/unix/garbage.c | 75 +++++++++++++++++++++++++++++-----------------
>  3 files changed, 50 insertions(+), 28 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 7eaa5b187fef..b23c33df8b46 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1958,6 +1958,8 @@ static void unix_detach_fds(struct scm_cookie *scm,=
 struct sk_buff *skb)
>  static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
>  {
>         scm->fp =3D scm_fp_dup(UNIXCB(skb).fp);
> +
> +       unix_peek_fpl(scm->fp);
>  }
>
>  static void unix_destruct_scm(struct sk_buff *skb)
> diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
> index c4f1b2da363d..8119dbeef3a3 100644
> --- a/net/unix/af_unix.h
> +++ b/net/unix/af_unix.h
> @@ -29,6 +29,7 @@ void unix_del_edges(struct scm_fp_list *fpl);
>  void unix_update_edges(struct unix_sock *receiver);
>  int unix_prepare_fpl(struct scm_fp_list *fpl);
>  void unix_destroy_fpl(struct scm_fp_list *fpl);
> +void unix_peek_fpl(struct scm_fp_list *fpl);
>  void unix_schedule_gc(struct user_struct *user);
>
>  /* SOCK_DIAG */
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 816e8fa2b062..5c9692c98d23 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -318,6 +318,21 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
>         unix_free_vertices(fpl);
>  }
>
> +static bool gc_in_progress;
> +static seqcount_t unix_peek_seq =3D SEQCNT_ZERO(unix_peek_seq);
> +
> +void unix_peek_fpl(struct scm_fp_list *fpl)
> +{
> +       if (!fpl->count_unix)
> +               return;
> +
> +       if (!READ_ONCE(gc_in_progress))
> +               return;
> +
> +       /* Invalidate the final refcnt check in unix_vertex_dead(). */
> +       raw_write_seqcount_barrier(&unix_peek_seq);

I'll add NULL check for fpl and spinlock for seqcount update.

pw-bot: cr

