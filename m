Return-Path: <netdev+bounces-265019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HkSCt2Sq2nWeQEAu9opvQ
	(envelope-from <netdev+bounces-265019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:52:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FFF229AEE
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D761302335E
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 02:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79D82DCF41;
	Sat,  7 Mar 2026 02:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yKcO4mz2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855E19D891
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772851929; cv=pass; b=os4D7W6uxj0gaeQ7ZCpVIGGeZXu4qLnCPzlGAGo2Oqcmm24aB5wddoorYPgm8ZBIkQL4hxJ3Pt1OdeCHb5dwiYI+2/t9INDbxp2BO6RND4ehmsMNfslKVWpgaw9NiR1AUjq0766L/EHzRDhmHwAzngp0Pwcqk4Vw7FbdCQXPSpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772851929; c=relaxed/simple;
	bh=4BJbbBpB+4Ao+97wbkRI8QtTUQJaPUNX5MXyBu9vgsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUDmvOZuZP9j+YDok0VC8w42DgCdKfZ4bVIpOJhSEiIpDwIrQseS153Qa+tbMMpzIXpZvgQgWdYookd4X37kFkmT2BcrE2tUAuDHEMAdGMO7GOjJg5zPvH92XAqzP+cZLn6Et/jB64wrrsJghuCv5rRZzmDrpKFvNVkLN/G90tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yKcO4mz2; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1273349c56bso12127740c88.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 18:52:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772851928; cv=none;
        d=google.com; s=arc-20240605;
        b=lh5zdLFf9evyzFNZceJC2NQE/9FODLDiIvS7XxG6l5V3Q7AlOY4C+Odk+M++YxQ3e0
         QGDgQYxISBhnnw9bLEvq95H+6+MxITKbKzKz1KED914fJpNZdNrY2aoDgfWpeArqtkWd
         /yBm85UEkAYBRWcDHlXWhZAj+W0aPRu/rUkiD9T1oqy42kRdX9xhbnX4cEIDiICQWGzV
         EBAz5cApNFWjET511F4fRAGOCe0nxQ8zUFkqPeBiu3q4SI6ZAJgVDmIgpqI5y8c44QsT
         qI91pSk4C2CH8CyXW9ZHkQqnnyzmB3cQFgOt7h/lMlpzCaKIn0TSXu7DLRfAxLH6090w
         eeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xjakxqhkR6F6GvE5Rla3VN9z4lTj65H5ZSm8n5xtYXw=;
        fh=Ww/NWFhWQT4YPpDdLiYschkWUynmcyLVyf0N5L9GjVg=;
        b=Z62jqI8S9Oz9sxYk1BJ1SyfK863Ptgpny+UtsHMZ1l8te0uw1im6kOtXMaZHyiVpQm
         1H6yzWBDTZs95UQKtWeqZVuRtTos4vjOaEAEbyqTeJU+8tQT8WXnev3AEiBKrq80PgF2
         sRhEW8/bYkEUwxPQirClEgcDgtn7Eqhwt8qQrrfTMbdIBzC1O/eIJR0p+3KxVtONjZj2
         7Sy24Rq9sqdXYOWqmtIq1ahtpeZ0cxYO0WvLYZZeM1PZB00N4dlnl9uGxxUTuAW5bmBa
         2djRUDyx0RZVO93kdFRnusFl7gYrJlNKEQ+up2KeR0B4R4NlXj0g/pY2APsS+iGxvtpV
         Nl2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772851928; x=1773456728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjakxqhkR6F6GvE5Rla3VN9z4lTj65H5ZSm8n5xtYXw=;
        b=yKcO4mz2rKAWz1li/4+6ObzSAEkH58tIOniR0n4RM+ywaiTtppNvN9yeTIshQ4Z8dx
         Oga1l9jhPplxZrP7/BH38vo6dAqWg3dpJL0l8PYzzWbSj2URCuYboG3bNz2QY61uj6V7
         fOGdTLXBkniwlldEwy9+tzr0p4f54nawUY26CR4joyJ7PciNCSTUQzs3p0THZkmjsRMS
         okvUrCjdVFMOKYtmhGNOQZyk4rEap+Bp2dXzhhM6Z4C8Z0gHTHhFgu2+FqHKYViL20nJ
         xqfXLgg2GdPKjbPw9crEuM5jN8sw/mNzJDsacuBoPqzujWESvWkNqYdEUiKHszfo60S9
         Hb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772851928; x=1773456728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjakxqhkR6F6GvE5Rla3VN9z4lTj65H5ZSm8n5xtYXw=;
        b=qfJMLGkn7Oi17dPiy3ruuA1la49aYOW4yX2gaRyblQmS/rCXUlkicAtXNBEeWNapKY
         ueZ/KRw6S7utSzDeeF9zRBnKmxu6wKzzlHkVKMlhZZ/UmNWC+mcr0ikZAVyjp5J1KjYm
         QKWICk4KuI9/jRmnSKgeve9XtnmiN8ia48XMTfHNqTukxCsaGkHM3zReHNWXTQKo5xAE
         rPXu/wg9hfqv+tUKI4Fqo621nrtBFAs8jf5YNKeUNBqmglKh292PI1n89Lg6kQvNPbN+
         vvYc7CyZIWfB+N4ysMjBEcMcRUWspzYezjUsj9b4kD5x6VLuH1G50zlNMg3FafQ90FkF
         AV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLr21irB4ArMw0gbNy4LYIcpq4sWs1Xl/S40Xm+GkB4ZjQ73TY3xwvRnKJUec+d8QMj9q25hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyruyczQd6UkMxc6zPVMOENaS/bRagdXuRWfmEUikRxST00ZTU3
	Sj1LtO/yoX5ZH9PamsJ66LJzx5xi2MPh7BhZ4ACa3W9Yel2hYb7q9f0swJvoys4i+MsC+6g/QKZ
	bcs8TOYSwE2r08BxCAo91cv3q0D1iM93P3wtWQAXT
X-Gm-Gg: ATEYQzxmOaau9TPxiPDKnB5GbeSsYQztfTTgG5CmUgBbSTRj9lQgpQaOx8xA1cSY6Wq
	cPIh9Gr2D6t5jAVcQq7uOdMIQA8C7f7mWqp/cUottcxmsIPOsAxWF85YIf3Yy6EeESSlgIOQqXY
	AQcGaVXNN0N4ZW+qrY/HpGAEAyFghyhrjaEpn6+P7QIVC14aZbNHy2Ir62q9TmswTN3NC/jakSm
	ZmNPIMr5uexLrBIUdiNx/MLC01ZJbEcsRmaRewB1HhN91PjJhyxXtbo41NzzEWKnU69t+jlfemQ
	bV4xaFl+LfSsNEaqh2GvwdsQ3BjAGZF+zbeWHbkBdixUuhbre9/S4DvAZtWO+xZ0sTNSekD0
X-Received: by 2002:a05:7022:b97:b0:119:e569:f611 with SMTP id
 a92af1059eb24-128c2dbf473mr1823517c88.10.1772851927152; Fri, 06 Mar 2026
 18:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-3-kuniyu@google.com>
 <fjt7fesjnzwuzeuiouv6rpvoxebounjqv3jlc34tvmzh252zep@hizdvwr2qwe4>
 <CAAVpQUAJgFtcJGtuMufS9mhaShs7OQDxx7jTGOSbG9wCdeCN7Q@mail.gmail.com> <dc3a8b4c-32f3-4905-8cca-078f220abfef@linux.dev>
In-Reply-To: <dc3a8b4c-32f3-4905-8cca-078f220abfef@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 6 Mar 2026 18:51:55 -0800
X-Gm-Features: AaiRm53SH2xBuZiQ1NmUKZNE7yQ2FpyC_SMw6TEOzf7sARE4BLWXj9MismNDHqE
Message-ID: <CAAVpQUCSZY9qErcJfHR0S_D1=4mwhTDqZgRfECUaPg37D6xrOA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 77FFF229AEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,cloudflare.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265019-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 4:03=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
>
>
> On 3/4/26 7:43 PM, Kuniyuki Iwashima wrote:
> > On Wed, Mar 4, 2026 at 5:48=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux=
.dev> wrote:
> >>
> >> On Sat, Feb 21, 2026 at 11:30:49PM +0800, Kuniyuki Iwashima wrote:
> >>> UDP TX skb->destructor() is sock_wfree(), and UDP only
> >>> holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().
> >>>
> >>> Otherwise, sk->sk_write_space() is read locklessly.
> >>>
> >>> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
> >>>
> >>> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> >>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> >>> ---
> >>> v3: Use WRITE_ONCE() in udp_bpf_update_proto()
> >>> v2: Cache sk->sk_write_space in sock_wfree()
> >>> ---
> >>>   net/core/skmsg.c   | 2 +-
> >>>   net/core/sock.c    | 8 ++++++--
> >>>   net/ipv4/udp_bpf.c | 2 +-
> >>>   3 files changed, 8 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> >>> index 75fa94217e1e..3d7eb2f4ac98 100644
> >>> --- a/net/core/skmsg.c
> >>> +++ b/net/core/skmsg.c
> >>> @@ -1297,7 +1297,7 @@ void sk_psock_start_verdict(struct sock *sk, st=
ruct sk_psock *psock)
> >>>
> >>>        psock->saved_data_ready =3D sk->sk_data_ready;
> >>>        WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
> >>> -     sk->sk_write_space =3D sk_psock_write_space;
> >>> +     WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
> >>>   }
> >>
> >> I noticed that Patch 1 and 2 were submitted earlier and are on bpf tre=
e.
> >> Given that Eric's commit (which you reviewed) is now in net.git, these=
 two patches
> >> should probably be dropped in the next version, right? Just confirming=
.
> >
> > I was thinking git can just handle them well, and even the
> > patch 2 has a delta in sock_wfree().
>
> At least for patch 1, I am not sure git can handle it well without human
> intervention because the sk_write_space is backward from Eric.
>
> For the missing change in sock_wfree (?), it probably makes sense to
> create a separate patch on top of Eric's change and target net. My
> understanding is patch 3-6 can be on its own without patch 1+2.

Sure, I posted 1&2 in the same series as I thought they
are sockmap stuff, but I will post 3~6 separately.

