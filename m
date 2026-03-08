Return-Path: <netdev+bounces-265338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLjJLwXZrWlq8QEAu9opvQ
	(envelope-from <netdev+bounces-265338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 21:16:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA5232180
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 21:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8042D3008682
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 20:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371C3A7F50;
	Sun,  8 Mar 2026 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV4Dxjzl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C231353C
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773000959; cv=pass; b=ER5Jkwjo+n/Lufh7NUk4+RpzQNM0f97G0bQeHRWIhwihO1HHgOYdeqJSKN+Y57BHaaOpnse0tPBn76CklgxnAFlOjm+acQdrk3Pbg2rsTm6Q06fLXXt85NLE1sDhILvYRMqzqW8AIleiFbWP3f3U1zWlbDmOYRt7fSUosmzLF/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773000959; c=relaxed/simple;
	bh=6ggepZMAg0JrHp39M0Te9lYXYNGU/F4JLASr9MnjpeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3ZnzkjTK12/wbfH93g4DRwV3FJxj0ZK7D/HfFLU+ci/lGsDJLePzmItTBfqiWEeilfOmSDkEgSxrtFNIHY0VNVHwwQiFh69D50g/EivhCwqnivtwmhIi7jomeufCq9PCzymBQjnnCBsLrsN/mIEVsgqg7A4BYJxXLNfL15nagE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV4Dxjzl; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso10363885d50.2
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 13:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773000953; cv=none;
        d=google.com; s=arc-20240605;
        b=XdUzxwEd9dlS/4J1jgQczB4tyF6YDCT33jh5FuCPwue0TPO7f2ke+wHEB01FoOMjEr
         O60jmTUjIQuXyEN1istb76KGZ+D67W1AVzvvRkEZA9aQKEwTuwODqkU9IRghReJJ/0EH
         ueEB9CM9nP3LdNqZQnV6sa1qAGrfq42gVIamy40Rcfogijm7zMelhX9dDwnyqpusVP4c
         slPJrcviHomUj10eYIEx2QXOp+NiXc+jPBfIzrZ8fBm4SiyuwXa6kgsHBs8b0AFZGAQi
         sGZ0oUFBHOJH4G4JUYOYi7J+5MuCbGRbr86SBg0lKcMAs9qHDrGL7b8JexVfCGhamR+r
         eLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9YlElFdxzataVjXLJvplvKS9itJLM14qSw+zGia4I1g=;
        fh=jQWKEXwnuwMPGOP9i1nFJ5Bu0qnuA/OV+Gxj3R7hheg=;
        b=Gy4fTmHO5U6y4/Hs9Mwis5ayCBcF0rCRTIFmI3pD54IH+N3X+74thPiq4vBtX5A758
         Tr/A8jvloFQ0FAF81qRrYMr5lgt5uSdEiSUkBENuWMj7qYMeUEG3Cs9N7gze+JSndgMO
         XEySjnvOETSYK0bIF+XU0kG6cBHDuTY/0z3NG5ZP9un+gro1LgYWTaLgMOquLN0qwGcP
         W410tzvH79+v8/s1OaDGlXytvTYTRAnBEGfcu//0tL1zht6xQAGKHi8n+QUh6DMStI1s
         tQY4bDhcAYfPvhq+kGgouwBwq8GdgWDkL6OQelfFzFzJ6cPCZAQYdB4yEZpDBCnj9KCd
         MvAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773000953; x=1773605753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YlElFdxzataVjXLJvplvKS9itJLM14qSw+zGia4I1g=;
        b=iV4DxjzlTw6eWmDWM9aw82bqpmOpDCitLiYSQ09doA9hUYKuVLIAv2OSBc5VEBQgtV
         XTA9a73CaETAQZCtGUGu4ZDl9+Wk5xYVvWWtUQiqnMYcRcq/cecFN/pQ30qWmhd14NnD
         zb06+1w9l7Mwb7HCq6+xcUv4Ti03JW1XPPpae2DWvTbgXbC1t/fhMftMUUU1j0rv+xpi
         QBxmNkuhCtPS/JTCHGORjfq3mDbqa5/b2+rZAzEWTxWVPEao4XRzhsIP+xNuPWxvFQbN
         bCt1r3NXiRQfMVEKB9GQjm38zuXxL6Q78JLkt62433gqijT9FbhGZWqr8OsGyOQZx8YL
         vJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773000953; x=1773605753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9YlElFdxzataVjXLJvplvKS9itJLM14qSw+zGia4I1g=;
        b=m+gjqboBmxJ9HLTh67I2eWJxxb+5kPVLC1RD43/g7lEwPJacYu1NmmKGM9L6YtWJrC
         FEF6Fxk5phTVV2WSsCvGvijYQ2L1KHtVY88HTUAro+PA47goy/un6XJMbJ8TWkTlycCh
         bsukJH1z1a/BPvwvjMJpCnXhBm4VE5xIqlCZm9yKq2KUCHS/RZl69W2UzbJdO2igwW5g
         RLVUGKwdGXWfzH9MEwecdXZQE51qK0bhBoNjvIzvjx/bPBZPTznuJqixtwSXpgm2bnBg
         nen6wWbx9K4ZP/RouGAdJ2+FrKc9EUppI0p4pdvK9fMZgwwvpJw/3D+Y7dHO0sMw9HZX
         rQBg==
X-Forwarded-Encrypted: i=1; AJvYcCUrm2L/E2prvRrF77y1yGhHj24dBpAVf6KnUmro5+BWxmf9th8IZ3yhlSSIGfEDX1ClIYBh+Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxre25fPNHDyUNCb3dMaSy1ua9WtY7qQ41j/fCFKDD3yLvyGX4Z
	bWpzYWKvSJoPsFCEbO3bp+1HLD9zFT27mOShY9JFmsw/L/0i8eCfTrqMlCsePFg5Bcab85njFGK
	mtRIVQz7xwPi+3mwLR1ohOHwIk8XWRAQ=
X-Gm-Gg: ATEYQzzAppWZPpclN9NMTlpsrTcHnX8bhZE0oS0h5qMDPkyPHrnusVmpTLyc2rHqg+V
	k2caq1dLwCZKf4CrApBl/H86ZXFFl5zJllTtY1BtALkGZ4medJH02jMGErQfvji3HlWAlWQ/itM
	JhF3LshaK29Zsz6S3QbPgScv0tV/5xM7otb4XC03Vu7jIbzK/HMW+0WrOh8Hx4QczutpCd0mfc+
	a0ErDa+ROpZ53s5+fj6tF8CelbO/RAJkmIfHQi0qvZglhUJ4MD68puMrfy1DVRP1z9EIqvN5ziq
	KrmY8Q==
X-Received: by 2002:a05:690e:134a:b0:64c:f195:381b with SMTP id
 956f58d0204a3-64d142b9d6fmr8897680d50.52.1773000953191; Sun, 08 Mar 2026
 13:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772853341.git.daniel@makrotopia.org> <d9d8e6058e635c1fdd4689c875204d48d0235295.1772853341.git.daniel@makrotopia.org>
 <3bee5ef1-0692-4779-832f-193017810c38@gmail.com> <aa2TYxEHQ91SbT3A@makrotopia.org>
In-Reply-To: <aa2TYxEHQ91SbT3A@makrotopia.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sun, 8 Mar 2026 21:15:42 +0100
X-Gm-Features: AaiRm515dHdiuzexSxrpvoFwTpesTmXvPgVPPS5UZXA0W94MCl3G1CcGX5MwmLs
Message-ID: <CAOiHx=n9_asSiAhB=aZKRenh6BsBAYP_3i7WxfBsbUBDz3BrWw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dsa: tag_mxl862xx: set dsa_default_offload_fwd_mark()
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>, 
	Cezary Wilmanski <cezary.wilmanski@adtran.com>, Liang Xu <lxu@maxlinear.com>, 
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>, Jose Maria Verdu Munoz <jverdu@maxlinear.com>, 
	Avinash Jayaraman <ajayaraman@maxlinear.com>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F0AA5232180
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265338-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, Mar 8, 2026 at 4:19=E2=80=AFPM Daniel Golle <daniel@makrotopia.org>=
 wrote:
>
> On Sat, Mar 07, 2026 at 10:57:56AM +0100, Jonas Gorski wrote:
> > Hi,
> >
> > On 07/03/2026 04:30, Daniel Golle wrote:
> > > The MxL862xx offloads forwarding between bridged ports to the
> > > hardware, so set dsa_default_offload_fwd_mark() to avoid duplicate
> > > forwarding of packets of (eg. flooded) frames arriving at the CPU
> > > port.
> > >
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  net/dsa/tag_mxl862xx.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
> > > index 01f2158682718..c02f69de61cbb 100644
> > > --- a/net/dsa/tag_mxl862xx.c
> > > +++ b/net/dsa/tag_mxl862xx.c
> > > @@ -92,6 +92,8 @@ static struct sk_buff *mxl862_tag_rcv(struct sk_buf=
f *skb,
> > >     skb_pull_rcsum(skb, MXL862_HEADER_LEN);
> > >     dsa_strip_etype_header(skb, MXL862_HEADER_LEN);
> > >
> > > +   dsa_default_offload_fwd_mark(skb);
> >
> > Does the switch (by default) also flood link local traffic (e.g. STP, L=
ACP,
> > etc)? If not, you should not mark these as fwd offloaded.
>
> No, it doesn't. Testing revealed that apparently it silently consumes the=
m.
> I assume we'll need something like
>
> if (likely(!is_link_local_ether_addr(eth_hdr(skb)->h_dest)))
>     dsa_default_offload_fwd_mark(skb);
>
> similar to tag_brcm.c, right?

Yepp, that would have been my suggestion :-)

> > Is there is a bit in the header that says whether a packet was flooded =
or
> > trapped that you can check?
>
> Earlier testing showed that frames arriving at the microcontroller under
> some conditions are relayed to the DSA CPU port -- and are destinguishabl=
e
> as such. However, there is not bit directly indicating whether the packet
> was (also) flooded already.

So you know if they were copied to the cpu port due to some rules, but
not if they were snooped or trapped?

Best regards,
Jonas

