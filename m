Return-Path: <netdev+bounces-306620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1GozOCkRUWrW+wIAu9opvQ
	(envelope-from <netdev+bounces-306620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:35:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7249473C4D7
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:35:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=a8oD3tTa;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306620-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306620-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFF033008C19
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97842B324;
	Fri, 10 Jul 2026 15:35:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2F3839B2
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:35:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697702; cv=pass; b=pDTZ95dDLGAWA3JPCGV7Rt8/h/t+ilZFuP1VsRfEea7Tzxwe84iF/SkYzbWHRs9LiSYmOkHY47nQ518a2gF261apYERymmnhac1Av/NfJbXfgAJPQodfc/szbJXQmsH39l2c67RgB1ejqi5BjVmA4cOiqkrb9hoft2IeJABZUnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697702; c=relaxed/simple;
	bh=lKiZCBDDETUpGjxrmw9i9h3I0UoRrm7LD3o1s0rYbt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uj+V3WvdlEoATsNG6WzMaw7iRm4uOqKWEgdpFE0V3Pq8VwtRKQIMLxLSA+c25W/2zuNmEDZGgL9UEpbm/9UZ4EQhComEXb8iuw7IHE3KCfQzVTnCV/+5wyu0EV6WVHgX55sGznXFvYJW2q+TcpdYZW8jd5LaFboJyhncYGDxiWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8oD3tTa; arc=pass smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so870142b3a.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 08:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783697700; cv=none;
        d=google.com; s=arc-20260327;
        b=QQvKhT6r6ysMylDvwjZoPDt6l+Wqfxy4Mg/wpxY4oQKK6/P/H5oH04CIOIOUKB//fK
         qpcZymOAKH4Ws1puusaZ7npntJigsvBk80/eDo9pM3MXRVwzx/qrgUubdl3emA4uHtmR
         iLz595MfidHlwLoef3jSsLeUjvpoCLQoq7ZzSEsi2DEtz+hIKj3qfyUsuGDJAsntG07t
         bFcRiycx4lskon2Uky6FB0HvijfO4Pe5DGDXnDkMmPQdeDD/alUZrijkslYy53q1c/Ly
         LoBUe9aSC5fBthRcO4mV2wxj0BLUqTlqnO3Ff5xrj7gB3SwXsqymK9EMjdeuSnkb095I
         Muiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lfqsy36kEg0n71UWqhMQmPaJ8MvzIuF/nMwbLEQv8KY=;
        fh=ack3tQHSP/QhJghwl9uAgZQI8e2FChbKM2a+P4uYisE=;
        b=IdyNgB4yBprW6MyvJF0wpw68/mbKb6Yj/g3O6JLfCyE/m0cq/IgNlYOkWM93ILOaD0
         asiKgrY3KIkLIazN4GqwN1sxUh9ABQ0SwjD0FaypI10eCnROdAfA8TPXhUfZz4XmrlHT
         4+zc9QS21J6lQq+qHVGNkDV2lF236ZZlEz7myls+IO3rErXqbrdxv8Q8FxOWEZJwjjEY
         iVl4xAe3CVutg2ZtEvbxMFYOECjg4V7mU7Uysr5g+U0GWY8iLeyyEBUNLDvTyWPKnlfk
         Av4wqq1mKfrSjSJk589gSX5P1Il5q4IrkBFAthPt68Gr6/yia39EDq24Q0BO4AfeCjCz
         gFvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783697700; x=1784302500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lfqsy36kEg0n71UWqhMQmPaJ8MvzIuF/nMwbLEQv8KY=;
        b=a8oD3tTaRKi4aTkrkspHVR/eFsSuVsDdmHub1TGYRTsaYEwWotKCTegELXvcOQwKL9
         fqIxCSwukN0Jk6qnHF4ctBJZt212taAkwtLCjSm3ecBYmxtw7hSpi/QDkuMsa/EOTPJE
         NnlnodRyG9SdC0uHp0GoreDvv4DBEXUZrbf+jHL2cSitDkS3Wn1dCHYWIUzkBZNDm+qj
         FYcizqVrmUwZWuJ+OkofQxypC+hahkOe4J+xAuetPU2TESH+ukDSMKR9p92xSuZU3tAG
         uxWfFx1E8OBT6xL/NAR5eg4rUa9+g1NpdGX8qLuUdsaCA1mmS7fVXKbbNeAGuapXiy7w
         v8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783697700; x=1784302500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lfqsy36kEg0n71UWqhMQmPaJ8MvzIuF/nMwbLEQv8KY=;
        b=qpvs5UFJeVrOagM9zLNZfnsnlwaFtop0kpsh16VQ5QlxFlDE9LR4EwOMdEt/mqAgZg
         Gc7Hg9DUPq0So47Qj6Y5s2N1wq/lkyxnNZJiTfq6Cnn5EwK9Rk23bPBM/pzS6n8aBmex
         OOtbdl+mXSwDPQGIai2SDkobpd2LzWzvA35TZI5q5aXCgwV+EN+KDNYQbnBCCbx5kEDF
         PAKcMFPgDQUV0ZdmWYM+iAdg3kF/tOno2u8Oz+a1hUy9gWYKeJW9tw57v7Newy7Mr4Wf
         8ljskIzJVYmAjqYbcvJN3DYyTwlLozOItRas4I3MLeCGlnekPbkhKdaVIM9XQoduZDhP
         6DwA==
X-Forwarded-Encrypted: i=1; AHgh+RqemfhdzhMtBy5A8NGhF5x25VZlVTzCOC+c63i7yE6JTnv5dWHIzGp+W3hr7g4AccB0AvWHB54=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmv0xYwhpXCexulPfOOwWoBcUspu8SWMYRF8fjjlYckR6/kYVO
	0UUfwxxYSwOzDw4gQYKgnZDD5aIMGSnxpIvkULaC4Qg34nQziVin0SN7Rsz4JUw0ep2EdMsYwP8
	+L+CHXru9aR+WADfElSujJS34e4HVLSk=
X-Gm-Gg: AfdE7clKyoeyjS2fKlABLmEQERbtVYlEhtIbqmy0crZxOjZ1j7DFgUKDNiy84mkVi8Q
	uNpBEE2iFsfMjBO52AhszyRJax/YqUW46pZXvUw/ZPzytNCg58YB1qchvwi4q+nKs5/RxxD2VEt
	oCcXV2YDXdfh6hAKhnlo7dFTnffYK5IOxYX89E8GI6PiWDUnU5RxgzF4U2qAZkj4Ke6OYXSRQ9n
	pF+kbUS8B8OWOCNySsQ10mYHaTH8sm30waW8Xd1Hh5PDqEDA+LLj8MH+tdUPbc5AwuPxVHnZOeL
	oWGeAcZ3wpZAcD4Evw4dJ9PNBhkIKUb3u5DdQ1Mk0viLFAsryBqmr6Ry/js2kDqGO9eDJGvBHEO
	A0UvkesA=
X-Received: by 2002:a05:6a00:94ed:b0:848:42a7:1854 with SMTP id
 d2e1a72fcca58-84843437157mr10598707b3a.39.1783697700484; Fri, 10 Jul 2026
 08:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710010718.20318-1-blbllhy@gmail.com> <20260710092559.40f37700@pumpkin>
In-Reply-To: <20260710092559.40f37700@pumpkin>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 10 Jul 2026 11:34:47 -0400
X-Gm-Features: AUfX_mzmhSy_FTOCbC6jONxJg6y1CF6hzGKuPLQMVmanaYtYZMtGKwJe5pMpPNs
Message-ID: <CADvbK_cKB+t2LJOs-VQKP9svHURckHpuYdwwZB9an0+FYuomxg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: validate stream count in sctp_process_strreset_inreq()
To: David Laight <david.laight.linux@gmail.com>
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:blbllhy@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:davidlaightlinux@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306620-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,microsoft.com,linux.microsoft.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7249473C4D7

On Fri, Jul 10, 2026 at 4:26=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu,  9 Jul 2026 21:07:18 -0400
> "Cen Zhang (Microsoft)" <blbllhy@gmail.com> wrote:
>
> > When processing a RESET_IN_REQUEST from a peer,
> > sctp_process_strreset_inreq() derives the stream count from the
> > parameter length but does not check whether the resulting
> > RESET_OUT_REQUEST would exceed SCTP_MAX_CHUNK_LEN.
> >
> > The OUT request header (sctp_strreset_outreq, 16 bytes) is 8 bytes
> > larger than the IN request header (sctp_strreset_inreq, 8 bytes).
> > Generally, the IP payload is bounded to 65535 bytes, so the stream
> > list cannot be large enough to trigger the overflow. However, on
> > interfaces with MTU > 65535 (e.g., loopback with IPv6 jumbograms), a
> > stream list that fits within the incoming IN parameter can cause a
> > __u16 overflow in sctp_make_strreset_req() when computing the OUT
> > request size, leading to an undersized skb allocation and a kernel
> > BUG:
> >
> >   net/core/skbuff.c:207         skb_panic
> >   net/core/skbuff.c:2625        skb_put
> >   net/sctp/sm_make_chunk.c:1535 sctp_addto_chunk
> >   net/sctp/sm_make_chunk.c:3695 sctp_make_strreset_req
> >   net/sctp/stream.c:655         sctp_process_strreset_inreq
> >
> > The local setsockopt path validates the generated reset request size.
> > However, for an incoming-only reset, it accounts for the smaller IN
> > request even though the peer must generate an OUT request with the same
> > stream list. Such a request cannot be completed successfully by the
> > peer.
> >
> > Reject peer IN requests whose corresponding OUT request would exceed
> > SCTP_MAX_CHUNK_LEN. Also tighten the local check so it does not send an
> > IN request that would require an oversized OUT request from the peer.
> >
> > Fixes: 7f9d68ac944e ("sctp: implement sender-side procedures for SSN Re=
set Request Parameter")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Closes: https://lore.kernel.org/all/20260707203215.2752-1-blbllhy@gmail=
.com/
> > Suggested-by: Xin Long <lucien.xin@gmail.com>
> > Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> > ---
> > v2: Add the OUT request length check to the send path, as suggested by =
Xin Long.
> >
> >  net/sctp/stream.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> > index 5c2fdedea088..34ffe6c945a4 100644
> > --- a/net/sctp/stream.c
> > +++ b/net/sctp/stream.c
> > @@ -308,7 +308,8 @@ int sctp_send_reset_streams(struct sctp_association=
 *asoc,
> >                                       goto out;
> >
> >                       param_len +=3D str_nums * sizeof(__u16) +
> > -                                  sizeof(struct sctp_strreset_inreq);
> > +                                  (out ? sizeof(struct sctp_strreset_i=
nreq)
> > +                                       : sizeof(struct sctp_strreset_o=
utreq));
>
> Does it really make any sense to have a connection with the 32k streams
> that would be needed in order to send a maximal length request?
> (Or more likely a user requesting the same streams be reset multiple time=
s.)
> So an initial check that str_nums < SOME_CONSTANT_JUST_BELOW_32K would do=
.
>
Yes, that would be a simpler fix.

However, 32K is not a limit defined by the RFC. While 32K streams may seem
excessive in practice, we cannot say that such a configuration is invalid.
If an application legitimately needs more than that, it would be difficult
to argue that it is not using SCTP correctly.

> Looking at the code I'm sure the kmalloc() shouldn't be done in the
> 'str_nums =3D=3D 0' case either.
> In fact it is probably worth doing the kmalloc() earlier to avoid two
> scans of the array.
> I even wonder if it should be possible to allocate the chunk without fill=
ing
> in the data and then put the values in afterwards (freeing the chunk if t=
here
> is an error).
>
> Then there is the code that reverts the state to OPEN if sctp_send_reconf=
()
> fails - nothing check that is the original state.
>
That would be another issue that we can address separately.
It would be great if you could follow up on this one. :-)

>         David
>
>
> >               }
> >
> >               if (param_len > SCTP_MAX_CHUNK_LEN -
> > @@ -639,6 +640,9 @@ struct sctp_chunk *sctp_process_strreset_inreq(
> >
> >       nums =3D (ntohs(param.p->length) - sizeof(*inreq)) / sizeof(__u16=
);
> >       str_p =3D inreq->list_of_streams;
> > +     if (nums * sizeof(__u16) + sizeof(struct sctp_strreset_outreq) >
> > +         SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_reconf_chunk))
> > +             goto out;
> >       for (i =3D 0; i < nums; i++) {
> >               if (ntohs(str_p[i]) >=3D stream->outcnt) {
> >                       result =3D SCTP_STRRESET_ERR_WRONG_SSN;
>

Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.

