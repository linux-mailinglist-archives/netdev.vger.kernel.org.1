Return-Path: <netdev+bounces-289457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHkfMIZeDGq5gQUAu9opvQ
	(envelope-from <netdev+bounces-289457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:58:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF3C57F2D0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39DED304CF55
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89D64DD6DA;
	Tue, 19 May 2026 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHHOpMAu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445374E3781
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195457; cv=pass; b=m0hi7ZCpiqF1RTbTEiIYO4AYK83khjBXKcUyg961E5U2GL/c7nxr7EeT8U3D8n2Ma1KaKqH+vLTdOeHRfiibgBnKwT7e87+lRqZuM3gIiL+HQevt/aN6XG1XMfcAe3ARH16McmQtqQNr5nwA+UkDh4Kr3pd6V80EmFEtFjM6Cm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195457; c=relaxed/simple;
	bh=syki1LcY9HcC9sEvA/osomvyfE2utk7kCHBpcweDB1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0dUV7wlXHbdfGvMqS+nK/C56PS6HXIfY0ilAxdtez+MjeGaLWALi9BicFabH/1yL5YOhRrmxrYluvkErRcj3CJ4ngvOV/Ace7S3cqoFoDTT/BkStIIqzLBnsdfQaqjSZpU9oapf8+GdpLlcN6GleHVsL2AicVIMVj6Ah8f6zsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JHHOpMAu; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-910f734b477so409280185a.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 05:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779195455; cv=none;
        d=google.com; s=arc-20240605;
        b=fw7pmzhfn9vN2w2fdoWZoPJx0W5yZJ/IqncBsdxqij/nmBEWSSHS1z2T7UhQQTd8yq
         i/Yz/GIvVvSg2a/lmog7dCpvh2gDmr4yaHHV6oImJBn3Xacnhezh5L9CvwOaOYGosNYz
         LHY5pUAOu1S/410lEwUUGEqqWTcIEVuMPPAAAg7c7fSappT3xLgUzaGIMULfNfOcRPiK
         fyzTZwBTrcafsWvt6R/Djf7a/zRr2JBHRWoTiaCHfBxCa3YCiZAZd5UIkdy3xFjScg9V
         rIpH1SoKTH33pM+nY3iJ21w5RN/0jSBh/gT+YGOmdIDljFBLU363lVRiqdIUN5zsUBNK
         bT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e9IdxpJyv+V3JPoCN9VNaCT4NZj9yJLeNXfr5f3Dpm0=;
        fh=GFn6lLVdtTWT69leMbZP2QWVG4n8g5YEWUkpkSe12zE=;
        b=bOW1lkVd+kOcmEjmiT0EfirllGP2CrODwyGDxgv+U8uersLQunFI7PDtO5iFiWPD7s
         ljnYY6xJ8ngGETB12RU/0s5Ju+eo8MAD9H+2ul1Ddk+wwhGlzH5x+qfXXi778voy/k9b
         hmUA4gXRHxUNTeDXY/kVRHfHW2z+PtEC9oe6sMsfeJN0Mk2fayCqU3/ifStAuiEn/LFx
         1GG/6oIAWP1VS5qbMeSly5XVYGVW5E1jVfKwEum2N4/KloA77jotXRHYQfLFcpu+f2AK
         9Spb/OuJSfAclVBicLNgzVRDpwjn521RZrq3AXYrBPQpitcWCIeIWc3TmkIz0yW6Qx/j
         G9ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779195455; x=1779800255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9IdxpJyv+V3JPoCN9VNaCT4NZj9yJLeNXfr5f3Dpm0=;
        b=JHHOpMAuBAMDpqcqEiuIgKslMpO1VnvpdNC7Wn1hJ22+GhZd26XA1mNUycjPI0Itqi
         JDBt/Fn7W6vGI8cHoUsYcAEiQasa8nXizzXv+dyskyDYZ5Z8N8CV/ukLfFTXjJcfgjy+
         Fi8BwRPqIlL5NuGpg2JR3Dy0VOuEFQvRixdKnJWOtiPjef2PZ4i6xoCC7s9x6cEvmXkH
         2h0dGuG+BdBmgZH/+Jmjs5UDvyhVWcYyPLrDcBKOx3MFVcXcifYSKhpxiqRhPozBFAuH
         Q4xTqYtJOlGbkYJdzqOIrFPbyM+xlEcT6HEJp7gZmNrl+4N7L8FlChOH/cGHH3RPlwdY
         rPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779195455; x=1779800255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e9IdxpJyv+V3JPoCN9VNaCT4NZj9yJLeNXfr5f3Dpm0=;
        b=PM0ivcictl1gOvfNAlLaA3MwaATItmSu5djf/b4yomvacKJGlwT35BEOdD/IMyM6N1
         cklolqwWAd8oo1iX1nublCBvQunVzy3NCGzs0yDAElgjD6m4inQySlUoqo/QLg2ib3DH
         3L1670mkTli3BIRUCdySFa1xTNkLclyRriWS8g7Eqp5ahiuudanueKSXOC4j9QhJrZGY
         1RUyl0CE+4rQMIYLa7e0g3mkbkO1m1Xbj/f2u5atzikn7u2gNwAtyyEymnVWG2J9rUtd
         mmrzRIgYh3Lb73zL47/OtuOTjCQkInWssXv8UnapTiN4YpsgPGZ6gmkylwSwhkQ0dv7T
         2Uiw==
X-Gm-Message-State: AOJu0YykoGOurKFBXFEYH7iIVLEn4pNteIb3rfU8FcgQUbHAj1V1jE53
	S6AuNodIiVcxVVOVMl6pRzNYOg2fVaAJFuEbztTVQhcO5NIEYGGRtMjnHnMambzdS0JZ5Q3icIS
	IeyduC13+sEwWRZLgZDyrlHE9VGOh2H4rYyfhmCTU
X-Gm-Gg: Acq92OGu2vPaXkpBQQNtkThoxKnUGOh3DSJrCwKFiAunAxoHaxn2EQw+YY0x/XqWSlf
	lnSSyYk/WZ5ALoUQwnKqriOTlGSx1p2pNVhJPuGuAhT39G/y0HeraIINoNax5sMqP3yC5FKN1Q0
	v/zk0bXzWTEvHPCXkaGov5c5xzmQKSORuj3RRKrKwdA3t+JlNs2j9SqutkmuCrJZ+thrXwkP/9y
	EufOmHdkB5HD+rFgTsKbfdAH2mAK08a/X04vzhkwCt77jv9AKudYoV71+pnpQMOZrJYlQpLouVU
	HX+JBYjhxTNSqvD+tYy3Fff6srOP0at9YqAiLMcwSrdMWK2xAsERFLw/NpFGN41VhYQlHV3m5tP
	rcN/iG2CZdS3ASrPa06ZlU2VTUbEaLLoBKb5yvzlVBtDmqEkfHRXuNWDR0BIaS+E=
X-Received: by 2002:a05:622a:4d09:b0:509:2527:d789 with SMTP id
 d75a77b69052e-51659fde5ecmr279342441cf.6.1779195454133; Tue, 19 May 2026
 05:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net>
In-Reply-To: <4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 May 2026 05:57:22 -0700
X-Gm-Features: AVHnY4J-s1Pz69JZvWlwC3nxLmgDfJNgiuhqmlFvPNZjcnyZxeD1ZIK9j5iF2P4
Message-ID: <CANn89i+w93DBm_yo5DZ6K_dgV4Gst=vb5OnTcXi2rKqeNHZSbQ@mail.gmail.com>
Subject: Re: [PATCH net] net: gro: don't copy frags between mixed zcopy skbs
To: Sabrina Dubroca <sd@queasysnail.net>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, Huzaifa Sidhpurwala <huzaifas@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289457-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,davemloft.net,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,queasysnail.net:email]
X-Rspamd-Queue-Id: 6EF3C57F2D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 5:40=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> skb_gro_receive() can currently copy frags between the source and GRO
> skb, without checking the zerocopy status, and in particular the
> SKBFL_MANAGED_FRAG_REFS flag.
>
> When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
> on the pages in shinfo->frags. Appending those frags to another skb's
> frags without fixing up the page refcount can lead to UAF.
>
> When either the last skb in the GRO chain (the one we would append
> frags to) or the source skb is zerocopy, skip the frags copy, and just
> append the new skb to the frag_list.
>
> This is probably a bit less efficient than calling
> skb_zcopy_downgrade_managed(), but then we'd also have to handle the
> rest of the zerocopy flags/machinery. This can be improved in
> net-next.
>
> Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
> Reported-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
> Assisted-by: Claude:claude-mythos-preview
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/core/gro.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> Huzaifa has found this to be exploitable to overwrite the page cache
>
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 31d21de5b15a..cae0a0dbfa69 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -123,6 +123,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff=
 *skb)
>         lp =3D NAPI_GRO_CB(p)->last;
>         pinfo =3D skb_shinfo(lp);
>
> +       if (skb_zcopy(skb) || skb_zcopy(lp))
> +               goto merge;
> +
>         if (headlen <=3D offset) {
>                 skb_frag_t *frag;
>                 skb_frag_t *frag2;

Do we really want to merge these skbs in the first place?

What about play safe?

diff --git a/net/core/gro.c b/net/core/gro.c
index 31d21de5b15a76439239d15f10d0fd6b6c8ab328..bae89062a053dd9804e772e711e=
277645e6fee4a
100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -109,6 +109,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *=
skb)
        if (p->pp_recycle !=3D skb->pp_recycle)
                return -ETOOMANYREFS;

+       if (skb_zcopy(p) || skb_zcopy(skb))
+               return -ETOOMANYREFS;
+
        if (unlikely(p->len + len >=3D netif_get_gro_max_size(p->dev, p) ||
                     NAPI_GRO_CB(skb)->flush))
                return -E2BIG;

