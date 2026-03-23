Return-Path: <netdev+bounces-270715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDtOCVWdwWmFUAQAu9opvQ
	(envelope-from <netdev+bounces-270715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:06:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED92FCDF5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A235A30CCFCA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDFA36A027;
	Mon, 23 Mar 2026 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfwJxvy3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA736B04E
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296119; cv=pass; b=PGaPBY9uiIj8/WNek5s09Q5Q3DScn7sjWn4Z5ki6C/Sxcq+dM08tpRmq/a3cPNlnizxwsYD43/K7hsMF1iNmgtNNd8Ps1lR6+4c95jxZm/ibHT6mfR2v9LMKNvO0lnXmnK5vubO2ms057Ix/pjqfj8GhtKWKP6xL6pE2zck6amQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296119; c=relaxed/simple;
	bh=Tlp+lJfyp95vJQs35m1dmjtFUmnMeO401FStvstIVLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcExQgFYwPOXoVJ/gy557bQJMS4L/owYLs8eX18dnZgpQTzXsgwd+68tKdTsuGYwDMWns8axlUL70hBPcvCRmo1IQdtUbppvgl3tK4T76p73ZqOWZVf5/zXrAFw2NQ9fzK9ge0R53ZlxVGHnmzVZCYQ52+eoztjWxFzzc+j4s2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfwJxvy3; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38bd3bc3061so5165891fa.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 13:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774296116; cv=none;
        d=google.com; s=arc-20240605;
        b=AL3cn4Qd/FHpojnfSG9MKVtc9Srrs2Wx4im081+rkDXZuEfLRwf0wZQk/ZvNOu7jK5
         g3KaxJmCLLDnAj1vXi/qhhIYSrE0F3Xmtw1KRtN0UJhyJhJ5eioim0DIsB50e7TKBnGC
         MpcZGCUL26jqi5Ow/Xhfw1r392thNojxJDYkS9cgMAcLgCrVkUIA8bFFN4a3Sxct7/M/
         fPvBPNuQ9yYqzgAaQEEjbJkzJxeiq0MIHV5jgU0paqw0zXPMOb5sE0bxOcnzvs7+Q0fD
         ZNkseOrSYOcLjYZbDWJDffiWBv0OdRKoST+GR4H6PqgZfKAQ/34k0Uf9nNWU+fquMowe
         a+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wc4FZh89TF5QoyDdncx8+R5TP1/bGV0DGvKJ7mX0G2s=;
        fh=qTxyfbCVreCTq9HLGtBx9uEpBQpACpPNwWnMjOaWrjg=;
        b=L+bcXO2LHuOD7FS+NGLQdp1WqPi5pqYH24y690Ut46KoG5dxiyM3/7+t9v+ovNcLbX
         lz6kmG/4KUSHzB39t0UF7ML+1NH32BS1Ek45cZTal7IpfujYoqFh+Imct7l0Sj4D/+Eo
         e4e2cs+iG5EF5wNj2PIy2GXQSU4BphKXK3W9d/SaDjsSU94c255WurOl8GmyzU52QEbZ
         cImVk72KhMMkbdWfvuIVwIU7jhvZlaE0kcm8HNPTq1RyemcZu91fczNLvOlQ+BolKaAS
         SyHBgbZrIV+GBWMJ1k/ZmIJpuWInC2lurTuKuQ7/dvRzwqNSyZFb1JtQ/JRvFIcNMgQ2
         CQ0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774296116; x=1774900916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc4FZh89TF5QoyDdncx8+R5TP1/bGV0DGvKJ7mX0G2s=;
        b=FfwJxvy3o6ZSWo99rpdjavXxAmxrl6y1Li5eD4RweQTM3KWsaSplrQJhQ/W6lQW/lN
         0trlHS0Jdn9xmIHFs4krURcXC3Sr1UTg7d30hv+ZVp45XinWJRcxcPh85qLo0pYbmxP2
         RvUecojNXDUbbYxvNg0CDJF3ZRSGP5GCIolg5Xk2HmFQbvle7s+jk578jMi/pFUMsrDI
         hMS40/B4VATfOUBr8dM1bl8S6onCPmiWyDATnShlZTG3/+OqUMPCv5HYrdZ/WNNcxCSt
         VIRhDlove7cjpRDk0V1PPhn54Q2E4ahGw6O5oDFRa5BRxEYtmT8nEfdUvcrFaJYS/AAH
         TOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774296116; x=1774900916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wc4FZh89TF5QoyDdncx8+R5TP1/bGV0DGvKJ7mX0G2s=;
        b=TPHTHzXlUo6a2akVGdvYBgxwGW19bqzigw3HfeW0cEym2iAWg0eZwW2+BcU1unr/cU
         HuFd71q9EPxucUpk68TRTZte4ncI99fjs97KOERLdCL9QwbsQcBCrWPACMngkgyHDuOY
         GJHWBGGm2LSsWzAwBV9IxCd3A3IfvCwPhL6mKCCgCKpOKxp1vMVxJ9Y1HYNwvorWgYip
         lZRn0/7qMlpxLhINZh+3K+tlYszVw77ihQIdkIrcuwXLsMlfvQ7cVm1jEd8qqqBIYu9S
         lNVLEkQ5OJhyBOPLJWV7WMJqzqSAAWdmQrosSHOizAEH/Dw/0UGHHuFhhr4fu8ql4VTP
         Mn8Q==
X-Gm-Message-State: AOJu0YwqYtrOVcLUFhEsIxhtlJ6aABHrW0a45Gk4/C2O3bm5Zf4StwF+
	jxGBBm8Q7VdQd33QSCsMT01GPE1F1QOnBoOg6BrDViPKeOoxJi/ZQWY7Ju9kHf+HzliIiABSTuk
	roaS9UlWUnMHGKzajL9kUH3OE+NSBye0oHuA/LsJA
X-Gm-Gg: ATEYQzwtZqH8LJsJTa29zjz7S6ysnccNsRdecW8NQVDmvEiRA+UhrA9yo44FSlUOySj
	xgNCQ7Sv3bUhXqKs5Ee48aC4GM37fgVoSa0vcyN7CafaIGw07zSBJ2XIQuLlOFLZKLYyWrzX5C1
	bD1yawGDxXpIxUeKQH+NcQwBSPekv8qQp8Jy76lwAqGKBofYX9IAVR9RUh1UEPdnPbNIyT+9xdz
	GAGt1g5wffp0IXOcZs0iVkDkgY2QriW2gYS11Lsrsc9BLYQnfbRCyX2cPgOyBwoYEfbRJhVaN1U
	iWF+meACILop9Qvz7lyhtwFbxPZInJYrKFf3
X-Received: by 2002:a2e:bc83:0:b0:389:e6d4:e7cb with SMTP id
 38308e7fff4ca-38bf96d4978mr44138121fa.22.1774296115882; Mon, 23 Mar 2026
 13:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318192450.3400774-1-joshwash@google.com> <20260320185546.6f7e95c0@kernel.org>
In-Reply-To: <20260320185546.6f7e95c0@kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 23 Mar 2026 13:01:43 -0700
X-Gm-Features: AaiRm52ue7c-WC307Fjz_fnNrmCK4W9Lk9Y6g6yN01Wq9hoWYtCeBnkluHofDOA
Message-ID: <CALuQH+VpVpWq6yvRSCpyOSkWBEOXsKF05=fz67J8zWB8gcbzfw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] gve: add XDP metadata support for DQ RDA
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270715-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EED92FCDF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 6:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 18 Mar 2026 12:24:50 -0700 Joshua Washington wrote:
> > Commit 1b42e07af1ee ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
> > exposes support for the XDP RX timestamping metadata operation in the D=
Q
> > RDA mode. While the operation works on its own, the intent was to enabl=
e
> > XDP metadata support for the queue format as a whole along with it.
> > Currently bfp_xdp_adjust_meta fails because meta_valid is set to false.
>
> bfp -> bpf

Will make this change in V3.

>
> > This change updates xdp_buff preparation to set meta_valid to true, so
> > metadata can be fully used by XDP programs.
> >
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Joshua Washington <joshwash@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net=
/ethernet/google/gve/gve_rx_dqo.c
> > index 7924dce719e2..48945b4b6766 100644
> > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > @@ -877,7 +877,7 @@ static int gve_rx_dqo(struct napi_struct *napi, str=
uct gve_rx_ring *rx,
> >                                buf_state->page_info.page_address +
> >                                buf_state->page_info.page_offset,
> >                                buf_state->page_info.pad,
> > -                              buf_len, false);
> > +                              buf_len, true);
> >               gve_xdp.gve =3D priv;
> >               gve_xdp.compl_desc =3D compl_desc;
> >
>
> AI says:
>
> While this allows XDP programs to write custom metadata via
> bpf_xdp_adjust_meta(), does the driver correctly propagate this metadata
> to the SKB after XDP_PASS?
>
> https://sashiko.dev/#/patchset/20260318192450.3400774-1-joshwash%40google=
.com
> --
> pw-bot: cr

Thanks for bringing this to my attention. I'll introduce a new patch
updating the XDP_PASS paths to make use of `xdp_build_skb` kernel
methods, which should handle metadata implicitly. Besides
commonization, this also removes an extra copy in the XDP_PASS case
for copy mode XDP.

