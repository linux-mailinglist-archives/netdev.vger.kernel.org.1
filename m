Return-Path: <netdev+bounces-280461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGgMDd7v6GkdRwIAu9opvQ
	(envelope-from <netdev+bounces-280461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:57:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD54482C7
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA7CE3012A92
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E4F36213E;
	Wed, 22 Apr 2026 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SkjhoE67"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BC23D291
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873431; cv=pass; b=u4FWhB1GTfJE9V6SXSxRuTJFrqqdAihjaJsrIfu2hZQd3PteQcfh8DLYnb/MSrUjpZZK+Bc37fzrKmTjwYEixyFb2gaPEusam8xA2pWBEEQnIgtKMAm8WO3F4CbhPF9PPdG5il/3ZLRXns/pX0349Rrc9y+qpCYBKnhbWVU1aLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873431; c=relaxed/simple;
	bh=NieXPC3YS6T5Y8AdieDzRo0mzb0fpU++KX+cXLQAlNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bfxb4B+TwZDPHXGHc0fEa8R9RNmaybFXkVuKI6lYeoy7Tjx7etkQoFItogJ6vYIFMMgatFyJ1/Wi5A9OCKjQJANHLmNAq3yQLQLekqPsdlRnbvIidxe4zF5KBzlV1pRtbSpb09W6Z9tlQghGBJeSGYS97idVaG9ibKv6UYTbNXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SkjhoE67; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e614fdb42so32337791cf.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776873429; cv=none;
        d=google.com; s=arc-20240605;
        b=WBScaQOeuh6Vl2V1imf4EaJUM2xcNMB9sV5Nk58W7yVC5hRIlVTeS49e94fEDo4uk5
         Bb6eIgXW10WvnFTRrt2GHqteVmyokG4yF9+vUUA4XJnjetE+dNbGRfxU+NT55D51sujz
         N3WKDXwMdmozn+kcFn8iKotNuF6eMT8I70EOSzcW//H1Bq7cKOaHH770n1atOFR5lLnJ
         AN6Nz0h3AMAc3IkIPuh7VtjH0S0D0rvO/hUgiPNeB4MVvcWwG/UGb9c5xiOEYyXkjpWW
         pfcBUZcUXUqj0Jp6o1O9SzhqFTyLAjzNzGGsqe5QxfQjGuK8WvcJ1beM2Shsn+3vRIkf
         Zclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NieXPC3YS6T5Y8AdieDzRo0mzb0fpU++KX+cXLQAlNM=;
        fh=Awrco3dRq6rRba0geolah6bcgAgwGukE+i0cFcadf3U=;
        b=X90vWGChHDG3iTvh7Z0ud2t/9AxQvnKhMsIWOj+r7DyVnukMiwTLUquB+Ziut3gHE5
         iAmSJ2uYvQ8uIeyB4QlVo4bsCXWJzI35K1G0UhUPoiIyWeWVZKTUhgtT68/ZfYsWxq9B
         NlVgP9UJhwmhZwzPZc2aaCNd7jvBVAA+Nao8AAfE7rgihWmml4M8QHxOMIlRkPyq9YzX
         Zs9uBPUL3O/0D72C/VXbuNN5p6WZcspFbFL3Qs0qCtSTYkRQz6U5e5iuUssB1HIKGOQ+
         JQXaro/d+Jx3moMxDnr46TmKD14N09KUwJTIIzGaFegipiXDCamxmXkDi7GQU8U5ZOda
         /Dbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776873429; x=1777478229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NieXPC3YS6T5Y8AdieDzRo0mzb0fpU++KX+cXLQAlNM=;
        b=SkjhoE67dnRKt0g0ZeQ6NFvfbtBvQcZglYg3UgL8ahdJQXdxyy84Mbq8XO0OP88GuB
         HyJnMnGbCraKStvZ4L+7WOr7skiWRCrcgHyHk+tc1JjYhMHIoBtwLm6SG8b+olKPNZCW
         fZSlQ4s0jFwIlxklMcAwPnCr7hvyOAx2VOwgwD32AnZeVKf1pe7BgqQQkdCYGBI9+fh1
         GXMWI/W/myQflGSUzZUrJTOrOns/7itz3XCuV/eenXc2wgIeZsH1L8A4yTpTAZbWXPCI
         fMjxWVCEMHm7SVUSZJ3e7M1PSYKBUjmbgrlHjJ+WgebzeNccoNuwxjyqs7mYiOYy6nyH
         BvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873429; x=1777478229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NieXPC3YS6T5Y8AdieDzRo0mzb0fpU++KX+cXLQAlNM=;
        b=H3DWmnQ6suKumCLD4a5GppGj0DWOKreRmEjMZvKkp74WBVeG9Lcz/BbRGD3EEE8id0
         bDLilj97Y98RjCSDRGhJ6cQER5xMEMdcUvS9OS5RwImS216VCskCGRPPFNnmGwRglkh0
         u3UVczMjyrvlqB/MS/XEW2j4Bi191NecaFhudJVNB/r2TUdyQgsv1ULkko+EvSvnMvjX
         Shyuk3kOtL8aTPGH7jecc7QEGEbkCc6hhXvuPQBUQ4Q5trnqW7IIT7OhQD94fEUvqZRc
         rlIxGsGOe3ILVOVbjSPQQfprbXxzk94XhHTN6Dhe9Onow0Eh1q776dLwHV7mViTeCy/i
         lk4g==
X-Gm-Message-State: AOJu0YyPTjz+cG8diTCJVROUBARmTNvo+vi12RmMrOVsJh8KthsVmIGd
	4xXbdqhVImO3yXDRJlHxooE3NL58xR1G5KWDu5Cl2p0I9IqcG5M/tGK9CwQ9x3JGhwXjumFX+yB
	ToIuXMPaH15HRDAdj+cwGYjg6Ek2s6ID0O1ILQ/xx
X-Gm-Gg: AeBDiev+uxPMHmwtr1ut2SV4gfFYP5eXwvYOpGqICdLkmfQOIYJVwuIny98rjgl4SgB
	TVhuCfQXHguLo2nmnyc3IJkTvALynEmm5DtCJg/VkHAO1wEmOiPac1wN4MPzS99iz5zj+Br1XHK
	Ta9DoLVP6rYCTPwSHO6JbgYxq5YsDMKYPj1wDL5ITJBWWiZptCn+jMcGEqOZ9P3VoxZYGj4Snak
	Trr4FFBlW3ZiSEVzduYyuN1Gb8l8S0Der7zi3x/H1wnoxr/q5U+r2+8JmntjHv8o6B9wES01Dj9
	aWuMDZaiD4vzQg5TprY08V79Ho5EtFO4B6FiJRCNz7cAhMzee3/LROa57Jq2TGgrXaHCHpGrnga
	SDoLTRFqJ
X-Received: by 2002:a05:622a:4c87:b0:50f:bdeb:1e47 with SMTP id
 d75a77b69052e-50fbdeb24e1mr81744721cf.44.1776873428348; Wed, 22 Apr 2026
 08:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422024554.130346-1-jt26wzz@gmail.com> <20260422024554.130346-2-jt26wzz@gmail.com>
In-Reply-To: <20260422024554.130346-2-jt26wzz@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Apr 2026 08:56:56 -0700
X-Gm-Features: AQROBzAxAmfFhRZGfkUgjI6oI5pnFyMaVXwdwbwsAVkf7mnNe9dRlKDjPQZm21w
Message-ID: <CANn89i+RuNBmUuacPLv9oKNFA0g71z65Fy-tFRjW7gm0TSGbqw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] tcp: call sk_data_ready() after listener migration
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, tamird@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280461-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4AFD54482C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 7:46=E2=80=AFPM Zhenzhong Wu <jt26wzz@gmail.com> wr=
ote:
>
> When inet_csk_listen_stop() migrates an established child socket from
> a closing listener to another socket in the same SO_REUSEPORT group,
> the target listener gets a new accept-queue entry via
> inet_csk_reqsk_queue_add(), but that path never notifies the target
> listener's waiters. A nonblocking accept() still works because it
> checks the queue directly, but poll()/epoll_wait() waiters and
> blocking accept() callers can also remain asleep indefinitely.
>
> Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
> in inet_csk_listen_stop().
>
> However, after inet_csk_reqsk_queue_add() succeeds, the ref acquired
> in reuseport_migrate_sock() is effectively transferred to
> nreq->rsk_listener. Another CPU can then dequeue nreq via accept()
> or listener shutdown, hit reqsk_put(), and drop that listener ref.
> Since listeners are SOCK_RCU_FREE, wrap the post-queue_add()
> dereferences of nsk in rcu_read_lock()/rcu_read_unlock(), which also
> covers the existing sock_net(nsk) access in that path.
>
> The reqsk_timer_handler() path does not need the same changes for two
> reasons: half-open requests become readable only after the final ACK,
> where tcp_child_process() already wakes the listener; and once nreq is
> visible via inet_ehash_insert(), the success path no longer touches
> nsk directly.
>
> Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets i=
n accept queues.")
> Cc: stable@vger.kernel.org
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

