Return-Path: <netdev+bounces-282232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBfeM5SB8WlYhQEAu9opvQ
	(envelope-from <netdev+bounces-282232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:57:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DE948EE73
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8E2330511B1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057632B99E;
	Wed, 29 Apr 2026 03:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQEXfko8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1134F247
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434824; cv=pass; b=LTVrDI4+cLL6p/WwsrDFI4o3JlSPHVs5b0yOgMF0mGk+CAfPtbl7PLrREXoqvgCOk5XbuoEAOCaeC4GY3vKfpl0p6DaNjjglnAOijOUTs4jP65majRe6YxbgWi3Z20YOJzOfjFDg0OaZ5YPimrkzWcpovihQ1/GZ0/Y9/kGimow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434824; c=relaxed/simple;
	bh=jr7BKBbh5jGTvbi7zkBQ34Cs1BnVSkpfW2B2SZZ/daA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lS859fUB6JIZqszpNoHDt+8iGzsygdgZG801PFye1Y6Os83lXczeeTPkZI4dwWRaxpuRJb0RlPadlkgZF/0bnwLho6TJBR69VRDaXEN7gGYFIzeVLHb1awUDtQP6Swto1laOSozgQfspQ96lnUqqs8C8gz8LIKSyVIewxcP1itA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQEXfko8; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so14975894e87.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777434821; cv=none;
        d=google.com; s=arc-20240605;
        b=Y71x6yi6KUVKHkl85p+Lk7kZOrjuVacghqgLbY96ao/KJhy9WA7w+Qa2Vb2TgT3jQI
         Ip4ya7KI3+gRH694oHCYiTJfeyQDN2d1NkKy4+xGiBDo6Mu1Iab+BNME0D2BjZXLq/P7
         4Whlx/kfMFRRiUjBAqGrC8sAhKBT48rUb1/SI1isC9vEB2U0ml2WxTr/jKVQ5D9rz6u2
         p5AW/XZVB8BPwScWn+fguv5+pjYnJ4r+27bRSoQyCvVemlDXRkFsrLQjRNlM7KG9MBRr
         HbnIiB2TSPJIt490/wGUKx/CR0aeUv14+fH1GPMM0MvDvQkYo8K6zJMh3xsZYIKBhdyW
         zCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnDN8j6rFwURVGMb90DGBXP2v8xXDb7wYPxZty6APdo=;
        fh=Hrny6KJ4r7tA4pB0RhhE3Hmy/3L+S84TJoSc/7aY5uQ=;
        b=SaBcWTDsNV/W8MagE3USAWJRVR7oK39rhhOetUGEPacKvaEAfiZBbsNfTIb5vK93Az
         Eho981WkR1NXBwzS+8Vxf71S8yhOw7bOxShrA9fskjkPKVBCR4VszQt22K/21tKZamV8
         G41CgamRtOhgU6Su5tcRXAIAVn9n76lm+jbeYZ0pvUPtxPUauicqq8rXvGImX/RnE6Z5
         2WpAmtGqSeK5hasqNSnfqE1Aps5i7oR7qjIuwJtfBUC5XCixf/uqd1ty7/EoiVI0eGDZ
         NEsRg5eZd71YXxJKtIumRlzR/J9GF+gnSy0k0n8PKrBriG3EltaQB+AtOhh7FOxaya8S
         heqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777434821; x=1778039621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnDN8j6rFwURVGMb90DGBXP2v8xXDb7wYPxZty6APdo=;
        b=IQEXfko8FmdLFhHNN+KIPakK11HImgdBpwUcOiPG7Kgx3JrPGTY5xDKBFUwF17jBFu
         z3D8E6MIUhDeZ37TqdRM2DKr5JHvMD/ncJZaS22cWFs+6d9UxW2A+BZP2yav5v9vnP1p
         Iq0fEqXAC35aq2emWJ55HhtNyd5ybILiNVvC4dWcny1I7zzBYx2UXMGj+kRjFU8MRcdb
         y9gq6Tdz4l+zCYgzpR9W6loAPpcQstkh0rHBw80W0H1UZ2OBIAaoTxlQ0kbv6Fs9zYzE
         DVf5h4u+afs0lSqF5PJSoRnd6cSEAMKdi5VIgQ++fN7nuNaKyP6nZJnnYIlxLLMN2496
         0gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777434821; x=1778039621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnDN8j6rFwURVGMb90DGBXP2v8xXDb7wYPxZty6APdo=;
        b=shE8TB2EABPdIOThFh9lrryTJ+zpc8nkMve0hs1RbHi8/EH/L8C9Db14L/kMPGphyU
         NSUzdZS65eb2NEM/bh2P3VWMVbeum9AJPeVVV2oGMAon6moVJ86BPiHcCv7X1pOPgOJx
         lP/nHIgKK/R0qOV5MzUE/eiZZC4FjZ73c53/vSSXYwjochGOuXDPE+hwG44vCXPmudJC
         qwl4mTlrOWG96z1rsnKKVSi6yngaloTBIWkm5vQXKgEQpubaWczb8mFFNhKj5nBZ68yA
         sY9Sh09IJNwzfQBec9L0xEW7O0ccEi0wzTSWWOyhbySsEYawUZa5mv8OEb0upxCMNTHO
         3zqw==
X-Forwarded-Encrypted: i=1; AFNElJ8+PuSBc1+EXEQJWdrmY2466tpqk470GJ+W/U9RyQ749wgmB3ZWzlZqTYnQgth48C8sxJDJep4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ny5eLCYqOOvlqTHQsoy7HnLEgac0nscSCwnZi0cOwuIIg6Ti
	/OmnsZrBXWZst403ugYnk6pMXfpGrSKzuApwKeACmXCLByp0ZKfdJGbx7iXhFuzQ3YL0SCkA9XZ
	HcBQcb+7B1OIlJkDz1FcJ9Um9uLY+2Sg=
X-Gm-Gg: AeBDiev4KCQojLtVY0z8FfAuwACD+UZOtw2KjnQojUD9m72fC3Lrc+Ilu7gJYjI4u6R
	IscO5v5J2SW9jvUgjVB18jwDdirSuqMvX9XL56SDYc8YTdOmNctRjxC0Wamf5prFq/oncVdxRA9
	eJV6ln3w6rVz8RK9tce98WD2P3I/BTLjuteDl5bBlDjifq4ngQq7Xjwrs/x4Fra/jlzuHjXnEHk
	q7JvpPDdMhYJLTrF9dDfFyHa49Z1bP+3qSBmLILkVZYGWBMprRgdXjE4dao1kauLtOlEQtYpEHL
	M8edHKJq8mX5obXze6A1F3aw/eQlGa9jkpidB/BENQEzT9Q=
X-Received: by 2002:a05:6512:3ca1:b0:5a3:f305:a50f with SMTP id
 2adb3069b0e04-5a749d22580mr788918e87.30.1777434820120; Tue, 28 Apr 2026
 20:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424053816.27965-3-kerneljasonxing@gmail.com> <20260428113333.1296663-3-horms@kernel.org>
In-Reply-To: <20260428113333.1296663-3-horms@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Apr 2026 06:53:01 +0300
X-Gm-Features: AVHnY4KRV0mHqqn8VKUS87OczdQmNsFbECenfmLn4La6QOdlu1I-B2kxFABo5kQ
Message-ID: <CAL+tcoBvDWKemw7hrf0J8zZwKTrHw+0H8rd1aCgtjgEKQVFhSw@mail.gmail.com>
Subject: Re: [PATCH net v4 2/8] xsk: handle NULL dereference of the skb
 without frags issue
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, aleksander.lobakin@intel.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, kernelxing@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 60DE948EE73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282232-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 2:35=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
>
> Simon says:
>
> Hi Jason,
>
> I'm providing this for informational purposes.
> My unedrstanding is that the problem flagged below
> is not present with the full 8 patches of the series
> applied.

Hi simon,

Thanks for letting me know:)

Yes, it will disappear after applying the whole series.

>
> ---
> xsk: handle NULL dereference of the skb without frags issue
>
> This change guards the existing xsk_inc_num_desc()/xsk_drop_skb() calls
> in xsk_build_skb()'s free_err path with an xs->skb check, and adds a new
> else branch that cancels the reserved CQ slot and bumps invalid_descs
> when xs->skb is NULL.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 887abed25466..54d4895fc11e 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -973,9 +973,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_so=
ck *xs,
> >               kfree_skb(skb);
> >
> >       if (err =3D=3D -EOVERFLOW) {
> > -             /* Drop the packet */
> > -             xsk_inc_num_desc(xs->skb);
> > -             xsk_drop_skb(xs->skb);
> > +             if (xs->skb) {
> > +                     /* Drop the packet */
> > +                     xsk_inc_num_desc(xs->skb);
> > +                     xsk_drop_skb(xs->skb);
> > +             } else {
> > +                     xsk_cq_cancel_locked(xs->pool, 1);
> > +                     xs->tx->invalid_descs++;
> > +             }
>
> The changelog states:
>
>     In this series, the skb is already freed by kfree_skb() inside
>     xsk_build_skb_zerocopy for the first-descriptor case, so we only need
>     to do the bookkeeping: cancel the one reserved CQ slot and account
>     for the single invalid descriptor.
>
> Is that accurate for this commit?

The commit says "in this series,..." which might confuse the AI reviewer.
>
> Looking at xsk_build_skb_zerocopy() as it stands here, neither of its
> error returns actually frees the skb:
>
>     if (!skb) {
>             ...
>             skb =3D sock_alloc_send_skb(&xs->sk, hr, 1, &err);
>             if (unlikely(!skb))
>                     return ERR_PTR(err);
>
>             skb_reserve(skb, hr);
>
>             xsk_skb_init_misc(skb, xs, desc->addr);
>             if (desc->options & XDP_TX_METADATA) {
>                     err =3D xsk_skb_metadata(skb, buffer, desc, pool, hr)=
;
>                     if (unlikely(err))
>                             return ERR_PTR(err);
>             }
>     }
>     ...
>     for (copied =3D 0, i =3D skb_shinfo(skb)->nr_frags; copied < len; i++=
) {
>             if (unlikely(i >=3D MAX_SKB_FRAGS))
>                     return ERR_PTR(-EOVERFLOW);
>
>             page =3D pool->umem->pgs[addr >> PAGE_SHIFT];
>             get_page(page);
>             ...
>             skb_fill_page_desc(skb, i, page, offset, copy);
>             ...
>     }
>
> So on the first-descriptor -EOVERFLOW path (xs->skb =3D=3D NULL,
> IFF_TX_SKB_NO_LINEAR device), doesn't xsk_build_skb_zerocopy() return
> with the skb still allocated, up to MAX_SKB_FRAGS pages pinned via
> get_page() and attached through skb_fill_page_desc(), and an
> sk_wmem_alloc charge held by xsk_destruct_skb (installed by
> xsk_skb_init_misc)?
>
> Control then returns to xsk_build_skb():
>
>     skb =3D xsk_build_skb_zerocopy(xs, desc);
>     if (IS_ERR(skb)) {
>             err =3D PTR_ERR(skb);
>             skb =3D NULL;
>             goto free_err;
>     }
>     ...
> free_err:
>     if (skb && !skb_shinfo(skb)->nr_frags)
>             kfree_skb(skb);
>
> Since the local skb has been set to NULL, the kfree_skb() guard is
> skipped, and the new else-branch only performs the CQ cancel and
> invalid_descs bump.
>
> Doesn't that leak the sk_buff, the attached frag pages, and the
> sk_wmem_alloc charge every time a first descriptor hits the i >=3D
> MAX_SKB_FRAGS condition (or the xsk_skb_metadata failure)?

This is the issue that I fixed in the subsequent patches.

>
> A later patch in the series, "xsk: free the skb when hitting the upper
> bound MAX_SKB_FRAGS", adds an "if (!xs->skb) kfree_skb(skb);" inside
> xsk_build_skb_zerocopy() before the -EOVERFLOW return, which seems to
> confirm the skb is not freed at this commit. Should the changelog's
> premise be reworked, or the free added here so each patch in the series
> stands on its own?

It's only about the description of the patch and the whole series
IIUC. If a new version is needed, I will send a v5 then :)

Thanks,
Jason

