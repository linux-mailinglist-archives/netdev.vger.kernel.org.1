Return-Path: <netdev+bounces-287205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDNrI7hGA2ri2QEAu9opvQ
	(envelope-from <netdev+bounces-287205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:26:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E12075239C9
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 688AB3338D1F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2004C3B5DE6;
	Tue, 12 May 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6m41eCO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F943905F0
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596410; cv=pass; b=Bv3DEB2Fct7qCoE50kn/n11/6ShTnfhnKttI8qMgrcf9UUCB79etUWwHvbvVRTrl899XL95tovH1lPiTsIKWkw7Vzh0lmo0jchU34rZkOAd6Vnnw/uvfQilhiA6Up0cDLgQkH+9M/EWpY5IRvsl4P68tZlQ4D+pQw+eZPKISDlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596410; c=relaxed/simple;
	bh=tGgX0l6ytIx698dvDPac8KCkKialk7vhswDMJfEF6Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBH1RbT9lSqt+utVUmaU5LxlMl6+6wjdGMNm4wZ5W3cer7OXINAaUG8mzWyBgf03R7FUV3HP3zi0Un9/cMWfEkcS3iMfd5jOTCXMYHJ99mgbF6WNa/hfObcVs/e7qRj0cbMX60VYbpPIFgWLQB1vWO5RwChQruAQA4DK0aYItb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6m41eCO; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3939d2bd739so48754211fa.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778596406; cv=none;
        d=google.com; s=arc-20240605;
        b=dQ4XsmNCiQQULbUhynSmq5X7I3Db5dWlVzZ7BP+M6f5YxLNKCB4NWajB7zxzHsJNbU
         vRHyDPb5w+o+ShQ+0JknKwhg6aCQlH9IkxT8gLI8j+gLbektnKr6brIxUOalYF6nVJpZ
         DJknRKpWGTsFvclg9Q6g+rt8JWVExXyCvl1NIXo24LSoDRrQSq+7hTCJ8ul1TmsdoXQd
         6CpG9Tpbm98dDxmE7L0jbswy5hZfOuUk1jDRi5zv83k7sttBuL3sXRykCmMGFp789V6w
         T9FpJe9JBU+Or4Gx9/CT2ATvZouE3DU34eUTPh2z1eMwCQYMFE4NKWldnr2MP8sk3G98
         lloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EXUv7LZ3hil13DS+1vWxEoJG7EI40S6boiJv/fJ2an8=;
        fh=XQ8BlnyBzVC2ALxko/hhi0vBFPMFSkW3JnrCLcDX09A=;
        b=HobFEKNFk0Vt5vVSQ/4kpacUfGiiOWjBM5asNQQJvD6Y5TBcTXc3tRehkkcHqFhny8
         /aXoGecelWA5KrSSLC9GQ23+oCqL1DJSS+VgAeJSWD0vlkmXEHmXHz9e0kiBX8RgJw9i
         vRrs1Pv//n9zn65TdwTTpvoDupLMiWKqngzkGjnRa6U077Q1CodEw20vFq099+/aafhY
         UW1rnxj1KypxIIbchWvrQH1k7OX7FT/zaChFiOVJDqXhptIiRANhOj5UmLLV/MzNQ3ag
         JZt85EpIW+dey061tsprxhP9s4Yn/MiW3hZQhqCdLD0AsM+m7e02zQO6mYnum0L/KnmX
         4CyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778596406; x=1779201206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXUv7LZ3hil13DS+1vWxEoJG7EI40S6boiJv/fJ2an8=;
        b=U6m41eCOsygw2T7/afuG1MX35qhXbh8UCAWxWC9H3xdWOiqThEn6NCtS8QACCwZo4D
         ClqFdrEsj8BneboRIF9rqsyZJ6h6aKsIx66dJvg0dNcQfLgCcuu3vG/eBTNACcvPOxgL
         Mqe4AXpgKoHPCb+/Kbqt6QJQMD/EOjbzONU4rm1NgWJbVOh502Dp5W2AIVttdivMmvG6
         4AAEbhxEwuYpkSB2vp1S+iwCRm5+SYGG9qBeMR8VMVHigbRnTT2weQTRjPF1Lu3RQYsh
         uARJPmrjD+AAVzWtrP6WLjTli1SH+8D6LS5b6yYdIPoTPNBdpBkbShB8dcL0cDDm+PPE
         lH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596406; x=1779201206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXUv7LZ3hil13DS+1vWxEoJG7EI40S6boiJv/fJ2an8=;
        b=NOqSt1tLiteWk8qKqeceqzblNy8/noCmVz+dnKeYK853IVxjvorpn8Lxqawlb5YPwq
         LPvS7p9gJgjdwIZRt3MRBYaRnZXuj105IeZ/Y7JTjsBro8HEQwX6jNDidy6+UxsScleW
         4AWE62QCKnhrBZMXL8kqv53e/fA1EVeH5cKjEmz+tzz2gRcg1i1ZXEctCkv6o8RihW0Q
         W+2W8GtJRIsRG+Y2lN+SHD3SdkARQlRZ4c1G+incnIzSt32c4zdDKjZ4+tYzotbr4NZm
         4emGB+Duixs0x0BNcgeG/TfJ901bmDI3juCqr7n6f89CrOihs5fM2Nms05LRV6vxjqT8
         wOVw==
X-Forwarded-Encrypted: i=1; AFNElJ9btQt1nwoSmfpUmQchezeVIlSb4nJj6NYxH4O8+t8+6kpdo5l98WtXUk837SoYtLFaWwagocE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1oDWfHNsxQyeKo9PG2YRbg8a2WMMNv0osKBW57PNn31LFMGef
	n/3gyWusiWelh3rNz3QNnycWOyxXNcX92g7mMR9Bj7rsrP5m4hMPsHeaFB0aFmcHk/9MeVIW0Ms
	4M88kPnehODAOWODz766es1efPb2QhtE=
X-Gm-Gg: Acq92OFzyfRV/PsbBGrB434+us5+Ny9yrwkiWXYlvRgNNY/TT0QpJpR9ALdZwadazVY
	sZhnJCZpd7brYXlWg8m0rxIeKesCrPzJU2NzL/vC297VmqzTQwgQL8Ee8+n5tdjH0xpba9lqPM2
	oC1FGVtONGqqYiIL97IE3+Tk2zMM8d85kUBe91SOfm3XwiLQT6JXLe4O27MNzK39uxBdWsRalaY
	YfJ7yyfEC4NE5BbEhlN1177cIIzZrXWRUglC2Rbb79FVM2zgW8DB3zKBsDUnJUc8w2fdToprG8f
	nG8GKEQx0VhL+j5PeTRoVGI4vyfo983jque9yiU=
X-Received: by 2002:a05:6512:a8b:b0:5a8:6d09:483c with SMTP id
 2adb3069b0e04-5a887cde8b0mr9177414e87.22.1778596406090; Tue, 12 May 2026
 07:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com> <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
In-Reply-To: <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 12 May 2026 22:32:48 +0800
X-Gm-Features: AVHnY4LzRy-kEe49ipIAtXqtdtfngArZKEyPOI6lhrhr2J7k4GL9DmZHDRGpq_s
Message-ID: <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E12075239C9
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
	TAGGED_FROM(0.00)[bounces-287205-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 11:03=E2=80=AFPM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/10, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The TX metadata area resides in the UMEM buffer which is memory-mapped
> > and concurrently writable by userspace. In xsk_skb_metadata(),
> > csum_start and csum_offset are read from shared memory for bounds
> > validation, then read again for skb assignment. A malicious userspace
> > application can race to overwrite these values between the two reads,
> > bypassing the bounds check and causing out-of-bounds memory access
> > during checksum computation in the transmit path.
> >
> > Fix this by reading csum_start and csum_offset into local variables
> > once, then using the local copies for both validation and assignment.
> >
> > Note that other metadata fields (flags, launch_time) and the cached
> > csum fields may be mutually inconsistent due to concurrent userspace
> > writes, but this is benign: the only security-critical invariant is
> > that each field's validated value is the same one used, which local
> > caching guarantees.
> >
> > Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.ker=
nel.org/
> > Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload sup=
port")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 6bcd77068e52..cd039e397018 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, vo=
id *buffer,
> >                           u32 hr)
> >  {
> >       struct xsk_tx_metadata *meta =3D NULL;
> > +     u16 csum_start, csum_offset;
> >
> >       if (unlikely(pool->tx_metadata_len =3D=3D 0))
> >               return -EINVAL;
> > @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, =
void *buffer,
> >               return -EINVAL;
> >
> >       if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > -             if (unlikely(meta->request.csum_start +
> > -                          meta->request.csum_offset +
> > +             csum_start =3D meta->request.csum_start;
> > +             csum_offset =3D meta->request.csum_offset;
>
> Wondering if it's better to READ_ONCE(x) these?

I still chose not to use it after reading the suggestion from local
AI. The reason is there is no WRITE_ONCE pair to make sure everything
is no data-race. I also checked some existing implementations around
the shared buffer (between userspace and kernel) and didn't manage to
see the usage of XXXX_ONCE(). Does it make any sense to you :) ?

Thanks,
Jason

