Return-Path: <netdev+bounces-274807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDKYHzUOz2lysgYAu9opvQ
	(envelope-from <netdev+bounces-274807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:47:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB3B38FA60
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AADBE3049E2F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B769D20B810;
	Fri,  3 Apr 2026 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfWIcKvn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD7239E6C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177092; cv=pass; b=K4XL5NQ7SwcA02fR3AgaM+gdqhh7ojmvSSdoQHDMoIOXfhe6cl1HM9WvRnzfiwf0FnQPX97U9Jl+DdrxDqhUgIZcZOJRvV8s8ebdCoBkGwkVo+eKgQBTBu2v0d2qCoUGlmWpriol/KAX6NFqcN9KxAvZfVCFT8psG7ZpUSI+Huc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177092; c=relaxed/simple;
	bh=1TGiPZ0E/TiWquYkJ+GqPn2605yvKDUR7A65q5idzaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZCY/cmG9n2KyhKkB4i2jiMqvMOcSzQvUSekQH3F8Fi5vobVYlC2lmVDG9IjcxzR568/WC6xKgbKbg36UTf/A0nH9XKiFbsqvIGMcG69+gALo3lFpS0Ji7swHD2vnHnQPY88CKdi495kApGGjjhrCibvIzBjrDobxxRQ9xm3yyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfWIcKvn; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d744d9acbeso578643a34.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 17:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775177089; cv=none;
        d=google.com; s=arc-20240605;
        b=fqvmohyjOF1ubyk5DyGAXAKKPrqA5/exU2/IIs3KA3vOO42c6/vPWgLV/warpXP2Qj
         XAcbMKN2w2Za/VGGdOLE/DC1oUJjq4HbzuQ46QbPPzmrj2P3J50LqrJwPyCN5OcpcZFU
         JjIf4aKJqQdXPlXQGECA0Jl7C2fk6+7FeiuYlPpNYp7o1jUqpDcx80sr4YsFJIVqAYuj
         RGl5f/sLK4s8Wy5lLmxnh9sIgjzx2ShKRAyF4nNMipvmdzF9aqkNZ0N2Hpe8G8BaONS+
         PMKuwEU/YN3YWZL/OfVNGTOe5uftS4Uew6xrKW77GtoWd/eTl5KYbzJwld3jJ23M+dBL
         afRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/uKLs5sXjzRjDT+KuGM3nXX/PDvMAjn2HFtueCKeYro=;
        fh=1ffhz1LCn+XjckKwJV4d58j3PNJFvGXtZYChy/J7jCo=;
        b=JiulMY+Nt8NSJalROVVlHGXRaQjYlsNQUGJtAX9EEfkdIpDI8Qn9HmYEfyu+vxrG+N
         KWHxhcWqCmeFTrb6b1M52B+sHU/5hJbPpFXlNWPpMER3JYTx8V/o+WU24Waq1LiOrbR3
         vF7VHdliAe59ik+OLfkpfiA6zPPqmZvvOz6tjUJmXf1sYzKRVNY6krs57KSMnHEp9nFI
         jeO62CDJ56zhHKAefpjNOh5DEkOn7fSLbEaCWKYN62JelE85rp9dsFLMNz7fQT8XSNCJ
         pec7d4nmEOhPC2jgawn+EiZIyKBjxnAa7fO6z7qlW/EM9F/TuhcAzDSkMAQ97GTZQsFG
         GNgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775177089; x=1775781889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uKLs5sXjzRjDT+KuGM3nXX/PDvMAjn2HFtueCKeYro=;
        b=UfWIcKvn41lqL/rXF/QnygPbTNfTFlIBF0FxcFjGmcRtfA8F1dseX5LzldoE7uSAMg
         j1eOpHVSRn5OsunZh0WsZLDZkxm0QS+VFxuzqSlpbKAzsmTL0pj0OWCdAxMh77Ob/1os
         ux3SENzvnwnMSfM3DLnMjvYXBlksIxOeBIhbLPwDJWetKx59Q5gd/8O8++J5cOoMrSZl
         Vd/xx5CxbJoXDz72WUWkIa6tHyk5lZYU7R/O2ZYX7wn2GDCY9gp7UBUYdnKuBwdsgCs+
         6ZDjAxabScJ9DKjjxHDA+hWgeil0tdSEq+DiS9RKXXWbioxESI09GCDFHuhBcCE/GEDi
         E/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177089; x=1775781889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/uKLs5sXjzRjDT+KuGM3nXX/PDvMAjn2HFtueCKeYro=;
        b=LyWeJYJrsbsNzl+9+PpDksCbNZwfjNjX8nkgu2nyIlMymRboA+yZFfb3w8wysfzVj0
         YwwzzLkSr7vFqDZ6D/wViYoAktK8tm94Q3JqPGCyUPMtyefJxOyz1MRvnNiTj/rfWJDL
         5ch8727HqDCs6hBfq8FVvH9YK+4IAqS7Nuc7w/RV8fjmo2OUH4c/Fw3VlgJyAumtxWaF
         ed6zXy92WDnqAJI9DFrk5UfyWtstnysM9LXD4MGQZJC8EHplu+7u/DAD2MoxSkcrTo3m
         KpcsMF1Z145GsNlAkhWu5ALr0Z6Uh7gsy39PPUSrFfdjynwYgCZMotapE7Kvasnkx7KB
         Xmfw==
X-Gm-Message-State: AOJu0YyELR1ZKWvZOtqQtsfnl4Kr3uconQeMI/7LOjymVxLNCAAEldqD
	4adLcycNMj7t+TDhkVemnDSHdxmVt71sDpZ8wCsjYzjPPzZN42p6ZIctDYafzUavnsx4OHLiMLq
	K2llZJHKI/OY4eC2hfJrVeHbTpdmTDlAOpIZ2
X-Gm-Gg: ATEYQzw98z8UF60IC8oqlx3LjtjwGvQIl0Pgyqa64EWJt/PSBMjQv0c/RPPNPqWRqBP
	XxPWd/cmu61nCUYwkoqRitlTO1andg/S4SwLVY5CWYPWlKfsRSAGR6uAfESHSi5lmHlbNwh6pAp
	YfLfXCQmRs7+NwX4F5sCNBWVLrLHPberKncxaLVKop6HbGiynmFehrfw9CMPbGkjS/b+owi0ls0
	Jc+gqVKsCbpOK1DQN+nVqtu3rbrqtHehdTeGgJvei14lLqyUJGqqz8jRKL1ALQmywqWwG5INIq0
	daSFyviXCKoWWBut44sTRQejZY998fNXvWq0DLAJhg==
X-Received: by 2002:a05:6820:3084:b0:67d:95bf:b535 with SMTP id
 006d021491bc7-6821a137d9amr747371eaf.0.1775177088674; Thu, 02 Apr 2026
 17:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402223437.109097-1-mmyangfl@gmail.com> <20260402223437.109097-3-mmyangfl@gmail.com>
 <112370b9-0e2c-4d5c-a614-4eca5593b2d8@lunn.ch>
In-Reply-To: <112370b9-0e2c-4d5c-a614-4eca5593b2d8@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 3 Apr 2026 08:44:12 +0800
X-Gm-Features: AQROBzDbhyz0QNutXTT1RmE7-SXncYuSUwzOqV0VMTI8OBEW3Wo4_Go5XLX550Q
Message-ID: <CAAXyoMOYW1xZgZ3bYAEVnzMfJRBqtzxmZMz7GDHeyTqAByrp0A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/4] net: dsa: yt921x: Refactor long register helpers
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274807-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDB3B38FA60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 8:26=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > -static int yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, u64 v=
al)
>
> > +yt921x_reg64_write(struct yt921x_priv *priv, u32 reg, const u32 *vals)
> > +{
>
> The old reg64_write actually took a u64 value, so the name fit. The
> new one takes 2x a u32. So i'm not sure calling is reg64 actually
> fits. Maybe yt921x_reg32x2_write()?
>
> > +static int yt921x_vlan_del(struct yt921x_priv *priv, int port, u16 vid=
)
> >  {
> > -     u64 mask64;
> > +     u32 masks[2];
> >
> > -     mask64 =3D YT921X_VLAN_CTRL_PORTS(port) |
> > -              YT921X_VLAN_CTRL_UNTAG_PORTn(port);
> > +     masks[0] =3D YT921X_VLAN_CTRLa_PORTn(port);
> > +     masks[1] =3D YT921X_VLAN_CTRLb_UNTAG_PORTn(port);
> >
> > -     return yt921x_reg64_clear_bits(priv, YT921X_VLANn_CTRL(vid), mask=
64);
> > +     return yt921x_reg64_clear_bits(priv, YT921X_VLANn_CTRL(vid), mask=
s);
>
> Or you could make yt921x_reg64_write() continue to take a u64, and
> avoid all these changes?
>

I'd like so, but I hate much to use u64 for 2x and u32[] for 3x.

> How does the datasheet describe these registers? Are they 64bit
> registers, or 2x 32bit registers?
>

They act more like 64b/96b registers since there are unaligned fields
across the 32bit boundary.

>            Andrew

