Return-Path: <netdev+bounces-286845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHf7F5dhAmposAEAu9opvQ
	(envelope-from <netdev+bounces-286845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:09:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6951726A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E8C3019917
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B77356759;
	Mon, 11 May 2026 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCJHZAyH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872EF34DB46
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540948; cv=pass; b=MdztayFJk6nxGjebTaOhclT5Klquwwgq3X+pdfx9QeGZDPSlSQLSC85IRnLiTPPxi5pAX+Xg3ZyxrBdY1lQ9i5YXhFU99U1R+yDspUrTPpKhk8ggpfHBRnLCpWD/YnAPhCWKxpUF06AXJHXZCmnyC1lNtJzMxTEC4YNSAEsS2vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540948; c=relaxed/simple;
	bh=cNsdw7g/MrqmszFIbkH6/LfQ50TlmEUmn8TbKqKMgN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDJz3PLiODVNB+2S1cbDc8wZzjFci0pn0m1eg+oucW51bFJ0svX9M+VJQRXxUUCjsaSDupAuz9IEO9FDw41TVNYG/vGIRNIZwvp55Oawc3QxO93hzeglrdG+A1dytF/uW+yE81h+Co5t1PiKI72BQw7gFBd45qy9a/U06UDwyDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCJHZAyH; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7bf0b47d2f1so45466177b3.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778540945; cv=none;
        d=google.com; s=arc-20240605;
        b=O9G20VQUZbOcvmsIZwEpZ7NyMPb9rPY5QQfh3Y9GvyQdbbCDf9pTJzRZ3/fnQgaI6l
         lTynfErnHL2c3vido0TBsC6RYVoM95sdeNc3YtvPxrwPQKL7T9U2R0TsqVtM0eWo+snz
         Rw5CcIG5L0aDsaLaiOk0asvX8pnaxDJ2EFG6afyb81B6dC2wlx93z80iDeSqdUU0gWEv
         sp2MGNiU7RB6648ZFZ3wtsudTssYCF+4bIC6OU1rxNUIXbPD5AhGGarHjsdksGBe4/EK
         cWXjKXF1IaPFrupNWRw5js/cGbm64P/qe0NsVkijRn/Xx6pbKTJdJbof/u8fjg8+z95v
         eZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PXC3S4tQXXBF/WZfZZtgdixtBOfU7xmOv6VXX9PDdSY=;
        fh=eE/lC2T1dPqvX4yxO0hh5+LrW0OLUTRZUyf3dt4vd6U=;
        b=ZpaHMs1SJ40pTjT0TlXbrTPDsn/tqV5WzU5bMMui3jDCbJpdEcakhmseLfj6inbvk3
         5KQRWa2c5M33Ij36d3jip1TmyfTGcagyIumQshAmAC6Z2nvcE9KTV9bu4ndfWyDDUGQl
         TpeDqsihi6VyI94ckQzMYVYAP/szQJq8lguWKxTGdzEL27PcAigqWb+uXNxz9s3rFR53
         zygkBoyCc/BaG0dftq9u4+yeA4SRgSYg46zxFHMSNNpcrYMD+Csjv3ARByFNmPinVX/W
         WwCT5BGQVQ0do/5iAGSS5IJd6bYtrrzd2fFZogqnM06V4pdHvoiI3wkuG0sCbzCzQw9S
         Rt+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778540945; x=1779145745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXC3S4tQXXBF/WZfZZtgdixtBOfU7xmOv6VXX9PDdSY=;
        b=aCJHZAyHOC4DFFv91nL3emV+PxxlwaBrJNr5vho0nSYUw2lUcIngid1E8WwrBXBoqZ
         21Lr7Ht0eiV1FGJsDLkxg8oQav4GTGUqZ2qH9xdESmNuTqI7JLCLeGBEZwAoZKoW9qxi
         Wci+JjCgZKU1wYFWfZ86+iC5F6xGL7t2+PQCvqau34nTQ7DykDmUF89+KkxCDox0mMsg
         9CzIWxi4XZHL7BqIUeFROYEts8kyUlmxN898Puyq+HoQaPvSpnm88fIeBjQtvTcswQs4
         F0+XkIIaqPNDBdOPtp0vy6BHyRCm+ihSoKcKUvJe6mbtcfw/ZjFxfdcB4umB/lQULgAY
         hezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778540945; x=1779145745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PXC3S4tQXXBF/WZfZZtgdixtBOfU7xmOv6VXX9PDdSY=;
        b=N+lrK4l5tFY2HHpH7LnaIjXY5PhoY9ytA3t1jEUO+b/BhgHv6HLsb0OE8vLtozBmi/
         BNog09QmUMUrnus8SUPuuaY/YYaK0v3jHc3pnKF5URtB4l4WtjRJZCJMcbwOgpP//pa1
         q7N8n0GS0CQpQ+GW9oPF3l7IUsnifSV3k6XiDZ1Ob+GBSHwyj469Ez28K+JnPCQbuoGJ
         DZriu8H+6Ie39hgf0Diuk9UI6Xw7l54qetDUu8ohUuMzFiZyjj7jcWyGD4/0tsXu0csc
         ADfJeKSSCyHVntHuGoklze7sggua8SGjDGNIWdUhFUodbwKQN+ELcHZydcaqR3A7EaDb
         P6kA==
X-Forwarded-Encrypted: i=1; AFNElJ8noBMZY16GlWTTNo6jgTWPyJtDwHgzupau/WI5ciB7dyiZJGtroaB7Q9TtchRG3Z0R7heqgWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzALWPshI+kiaTdJGBMgEdtfVV07KXuQgUZn/fyR207CXG8GgiP
	T0LQACc74ThFUbyJwNvzQ1kMtdydr82o2/D3BGcYE261xGthR+Ji3NAiqeKdMrSxI3dhx7RvPrV
	YdAS0mBl+l8TbY4jRd0yvmGMB7T5H7UAWQ4QG
X-Gm-Gg: Acq92OFqoa9g+7kOQL5otw8e6Dwb/eh+XPKYbyP8yc1uNBfvJk+Evzx3m8wmesNx/SE
	JLXHvNBGt7Sk6jbSuyjcXd/otA1dbl+ghTELEO7vIgDkgl1HupaX1nNPjoxa3uzc8SAD8s6kMI2
	NhytgTTcxSczSJqG+koN0W32OrtSL3kTmdAsfQ8VXL/s3vosfqOaVMlWk/JH7v0H5vS08omGOM9
	kcuzLIrw6bNaDenX30clC4Yy8znJrw3OmT7rAz/e29NpZwVzln5tbk9jgcgcBVDED13l7yPi7r4
	zy4s3u59KzdrldRlxJfh
X-Received: by 2002:a05:690c:97:b0:7b3:6c50:2e8f with SMTP id
 00721157ae682-7bfb9f8eccbmr164762087b3.41.1778540945359; Mon, 11 May 2026
 16:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507095330.318892-1-tariqt@nvidia.com> <20260507095330.318892-3-tariqt@nvidia.com>
 <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
 <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com> <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
 <70d0b319-178f-4233-b0da-9618489a1dd6@nvidia.com> <CAMB2axPdqBUORn7Qy35Xccqbn+8aArZ-weegZyz=j0STh+iPNA@mail.gmail.com>
 <6b7998e7-b2c1-4650-9564-679d647146cf@nvidia.com> <ef926d49-81d6-4d26-8d74-440d4a6bb8b1@nvidia.com>
In-Reply-To: <ef926d49-81d6-4d26-8d74-440d4a6bb8b1@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 01:08:52 +0200
X-Gm-Features: AVHnY4KLKD6htIEllFdI8dqPO2D1AdH38X59DFCpiZ_6MmShTen909W_j38aiKs
Message-ID: <CAMB2axN6USwsGaUQWkL52G=9V=kSe2La_gE-ppOFLWbPCnaVKQ@mail.gmail.com>
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Christoph Paasch <cpaasch@openai.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B3A6951726A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286845-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[nvidia.com,openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sat, May 9, 2026 at 11:51=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 08.05.26 20:42, Dragos Tatulea wrote:
> >
> >
> > On 08.05.26 19:44, Amery Hung wrote:
> >> On Fri, May 8, 2026 at 2:15=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> >>>
> >>>
> >>>
> >>> On 07.05.26 22:50, Amery Hung wrote:
> >>>> On Thu, May 7, 2026 at 4:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvid=
ia.com> wrote:
> >>>>>
> >>>>>
> >>>>> Hi Amery,
> >>>>>
> >>>>> On 07.05.26 15:53, Amery Hung wrote:
> >>>>>> [...]
> >>>>>> Am I understanding correctly that the better performance comes wit=
h
> >>>>>> the assumption that the XDP does not change headers?
> >>>>>>
> >>>>>> headlen is determined before the XDP program runs. If it push/pop
> >>>>>> headers, there could be headers in frags or data in the linear reg=
ion
> >>>>>> after __pskb_pull_tail().
> >>>>>>
> >>>>> That's right.
> >>>>>
> >>>>>>>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XD=
P_XMIT, rq->flags)) {
> >>>>>>>                                 struct mlx5e_frag_page *pfp;
> >>>>>>> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct m=
lx5e_rq *rq, struct mlx5e_mpw_info *w
> >>>>>>>                                 pagep->frags++;
> >>>>>>>                         while (++pagep < frag_page);
> >>>>>>>
> >>>>>>> -                       headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD =
- len,
> >>>>>>> -                                       skb->data_len);
> >>>>>>> +                       headlen =3D min_t(u16, headlen - len, skb=
->data_len);
> >>>>>>
> >>>>>> headlen - len can underflow but will be capped by skb->data_len, s=
o
> >>>>>> this should be okay, right?
> >>>>> It is safe. But it might trigger an extra allocation in the pull wh=
en
> >>>>> len > headlen. We could also skip the pull in that case. Or do a
> >>>>> min(headlen - len, min(skb->data_len, MLX5E_RX_MAX_HEAD)). WDYT?
> >>>>
> >>>> Make sense, but this line took me a bit to understand. Maybe conside=
r
> >>>> checking len < headlen first?
> >>>>
> >>>> if (len < headlen) {
> >>>>         headlen =3D min_t(u32, headlen - len, skb->data_len);
> >>>>         __pskb_pull_tail(skb, headlen);
> >>>> }
> >>>>
> >>> Yes, that's what I had in mind when skipping the pull. I would also
> >>> tag this as likely.
> >>>
> >>>> Another clarifying question. So this patch will improve the
> >>>> performance when the XDP programs don't change header length. For
> >>>> those that encap/decap, they should precisely pull only headers into
> >>>> the linear area for optimal performance. Is it correct?
> >>>>
> >>> Right for encap, but for decap not quite:
> >>>
> >>> Let's say that the XDP program pulls 64B header into the linear part
> >>> and snips 4B of the encap out. This would result in a pull of an
> >>> additional 4B (headlen (64B) - len (60B) =3D 4B) which are now
> >>> data bytes =3D> sub-optimal layout.
> >>>
> >>> I don't see how we can improve this corner case though.
> >>
> >> I see. Thanks for the clarification.
> >>
> >> I think the "if (len < headlen)" makes too many assumptions about what
> >> the XDP program did.
> >>
> >> How about this policy instead: If the XDP program did not create/pull
> >> data into the linear area, pull the parsed headers; otherwise, assume
> >> the XDP program owns the geometry. min() is still needed since the
> >> program can shrink the packet.
> >>
> >> if (!len) {
> >>         headlen =3D min(headlen, skb->data_len);
> >>         __pskb_pull_tail(skb, headen);
> >> }
> >>
> >> This preserves the optimization for the default no-modification case,
> >> and most importantly allow XDP program to get the optimal performance
> >> if it gets the final geometry right.
> >>
> > I like this. It will also save us some neurons next time we need to
> > touch these lines.
> >
> Sashiko disagrees:
>
> """
> If an XDP program changes the packet geometry by prepending data, len wil=
l
> be greater than 0, which skips the __pskb_pull_tail() call entirely.
> The resulting SKB's linear part will only contain the prepended data, wit=
h
> the Ethernet headers remaining in the fragments.
> When the network stack later calls eth_type_trans(), it unconditionally
> pulls ETH_HLEN:
> net/ethernet/eth.c:eth_type_trans() {
>     ...
>     skb_pull_inline(skb, ETH_HLEN);
>     ...
> }
> Could pulling 14 bytes from a smaller linear area cause skb->len to drop
> below skb->data_len and trigger a BUG() in __skb_pull()?
> """
>
> So I think we need an else where we preserve the old behavior:
>   if (!len)
>           headlen =3D min(headlen, skb->data_len);
>   else
>           headlen =3D min(MLX5E_RX_MAX_HEAD - len, skb->data_len);
>
>   __pskb_pull_tail(skb, headlen);

I see. I am okay with the fallback.

One last question: if the fallback is mainly to preserve the minimum
linear head needed by eth_type_trans(), can we make that explicit
instead?

unsigned int pull_len =3D 0;

if (!len)
        pull_len =3D headlen;
else if (len < ETH_HLEN)
        pull_len =3D ETH_HLEN - len;

if (pull_len)
        __pskb_pull_tail(skb, min(pull_len, skb->data_len));

This keeps the parsed-header pull for the fully nonlinear case, but once
XDP leaves some linear data, the driver only pulls enough to satisfy the
Ethernet header invariant and otherwise leaves the final geometry to XDP.


>
> Thanks,
> Dragos

