Return-Path: <netdev+bounces-252532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GTg5KGSLcmlJmAAAu9opvQ
	(envelope-from <netdev+bounces-252532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:41:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D92E76D791
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 731ED30160DA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC339BA49;
	Thu, 22 Jan 2026 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2m796+7Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E33994D3
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114462; cv=pass; b=SN0B8YgySTZTOtCrvdfvtbpTjf48fpjURzsRt6cn4/ll3DWAWE77NYmCpxHi0/xY+1tuUmSVtFBYYm+HU+Oj8Y1qMoxxS0ZrZF3PmkvsczwqlcCfuhRD6+V8+o50BJBMbMiKLKCMR7Eg1pqFHUpnwoK/8ashhUg5/A/23q/4pxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114462; c=relaxed/simple;
	bh=tflMyQ1zkRZbF7CT+JDn+GX3XTDq76TurCjH38/ZmFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c21d9g7AfhiR6LYHLfJ+HYUCwvmw2dUBcCHC8IxonSUrzlJAGPxkJqUp4HoX6rohBB2dxI1sn2eDFo1GbyBcD7atjwCOX/+paTSj+rQ4UnQ4hmVVxuzhqt32wXYcRj9eBAQoSQgV13F9kmvz+uWi72muRZLRGKcSCaZjzLgFpAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2m796+7Y; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014e8a42aeso19397921cf.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:40:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769114455; cv=none;
        d=google.com; s=arc-20240605;
        b=EaYLV209U+234P3UeW+QVuVBP57Q3eCUS+jx1BLd2bcW2pbVIiRF5hI1Ou8CoAqbd2
         /6mXNG72VxTFrtwx6fsTeT1N1s4Z6mDCsqAwZbh3WybODAun7DrOTzE/8uR4K22SbPkD
         LCumu2fBuvB3EyUQND2qY0SiCMbzCfMI8SzmhJDlS1NyD5GiHAyGLhZ8FRREe+gzuFAE
         8s7tJYg3tUS4UCv0iA+KZo1NQ+V7AmzCv1gpp3IIRTBus0Zccn5sVk0d8GcnQYSf5rgd
         H+gSL0Ygv/Mf4WJqZsvNU75F5jGvAfZlVELkpXQ5JGovqzadGJm/P82eALWbuwytXQrP
         uMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UN8q4DbLW93bpHvl/o2md+omTMbMEdaam/1XLNOA9+4=;
        fh=pjHO1zGu5QF/3sLQxg0pgMjJrixD/VetJ45yVJ2daSQ=;
        b=EGSTf8f6Z/FY/gsBz50v+gbihCPekvv0IRvAJPJTzwLZ7bXXv+YFDymC6kHFgVMIDe
         7eqIvQ9eVvGJpkiXC+6KxKJml3tOZ0IsLxJbKFj5zlGYJPjBQFZa2RIEXwvZwlRQjXEk
         skBM1S+eABrqCuWxyfjdxAI5HL/ovPc0c/4AGKTaTQDiIqD2VwqLLokuPxu1ExfIsCTh
         vddsejp4ushrFv739d6X2J1VubpHF9nfd4q3v7WPOsEb4Qv+kilIB7JD4epdC9k36wKQ
         6nUO32YNO2uXzhocslRppfpBmAlP8GTyB3kfAf2DBlnQwfsk05ps3Jg2lCHp5sAlakLK
         Ys8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769114455; x=1769719255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UN8q4DbLW93bpHvl/o2md+omTMbMEdaam/1XLNOA9+4=;
        b=2m796+7YpLR2xRYjN7vzEvm5THdIWdEyJeeIghUMm/SbP3XGw46Lvn3oXi4Y0CllZO
         293S9eHyJZ7sEa/dlIwnjxvDnljB2CaIKNj3wzEi8orH2t7ENUFquEZUFd8B0pnovOGN
         1lTZ7/Hm37y/Jyw9wS2KkjFLn9MlDTl9vFDNNrAaQti/GOjcHBMomjteZGpKSybjRsBN
         ynov1dXyHU12MA5TDpvEtT7et13z0xa6mRhqcwF5vyjzG/ANHDQhg+e/FOPGkVbXc1HO
         W7D1Hka0uJIFJgpLXdjaKLSCCDaA0a+R2pTe6FC/kzDafYLjDmqAnE/Qtb0J9lqlKQi2
         B+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769114455; x=1769719255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UN8q4DbLW93bpHvl/o2md+omTMbMEdaam/1XLNOA9+4=;
        b=WuKadWZS78jsdvommvUNuBppX2qa7KWFxbBQsQJZqw3ikQ45WdkG9/KaR0eEpb8hY6
         OM/L9Gw6mBrUie0n3jPb+/DVLVHrsy4sPGQufb40N/AX1vGGIEtCasjthRxqtEnGpNOd
         Hcx6+rtPNmjbEWla+DKWoCiMJPkc+VmLXskSMV4vPuz8cnkmm2xLsWeVNI8Nz1cTwKX1
         HcTQ9cdJc2JpxYFs+2aluQrajKQYyUOnUrj5P4tkDl+EgJuOaXKk2t3bC2KO4haHIagk
         RNKU4ofi04fL2YGKb1XRreg0mz1fuQrwMe3Y7DQ2JcmZ4+MVTsf02i94K8QWSjb4NWKd
         WA9A==
X-Forwarded-Encrypted: i=1; AJvYcCWZSC1Hhxk+9eEWjhR7Wu+2RMaCojHJpzvS6YMOIBL2bUtUFYWXyG2rNwr7CAlnxIauauinS4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcK9An5OhVn0xFKPzYRAmIUQYYwTFsuliITfMOmdz1ggiRmytP
	7W3gaVCXwtHDSuoZ6rgUCGAv/HBQn/tXN5AYRjkQJ6ShTMW3f7r27IRg7aLdnP+rUrU2wtHXbzF
	zwk1T9oEIuF273d/CWmM+JgdiXlV6l5ReXlsSpiL1
X-Gm-Gg: AZuq6aKX2DXWted61goTWAHizvmIM2F/Fie74gKA/3/N/CLHh+NLmLAXcJsHisSKcj2
	bN3rsilJv06cewY3D+c358Y3hSruSgduH10mTakKymAjtICQpaJJcrc0fKDBPL3qeZ3ucWu5X9E
	Y798Xqv/nnvvBwqkZfwyEEEJSACpB5zv4ioyYTl3XrE7f36s/T5y3ROk7dM8DFwvY+LrGOn2iNC
	I05TSdlt60Ep3v6Gl4lp/GHzpC37fH6QQFDTmZkpZZkpmUathRpibbT6y9fdm8JpIUbqOEx
X-Received: by 2002:a05:622a:1654:b0:4e6:ebcc:23fb with SMTP id
 d75a77b69052e-502f7740664mr11822421cf.36.1769114454809; Thu, 22 Jan 2026
 12:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122190349.2771064-1-edumazet@google.com> <willemdebruijn.kernel.65df45c3b4fe@gmail.com>
In-Reply-To: <willemdebruijn.kernel.65df45c3b4fe@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jan 2026 21:40:43 +0100
X-Gm-Features: AZwV_Qg0iMrjE34FKU1EfWyAL9AH28EYostcXDeivDEPJmpRibys3FIW0Yi8xC4
Message-ID: <CANn89iKtX7Omh7qXwt7A1=Q3nQ4VgVOAzWfgNBO-t0xWP7RKpQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: expand NETDEV_RSS_KEY_LEN to 256 bytes
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252532-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D92E76D791
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 9:22=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > NETDEV_RSS_KEY_LEN has been set to 52 bytes in 2014, until now.
> >
> > Jakub suggested we bump the size to 128 bytes or more.
> >
> > Some drivers (like idpf) were already working around the core limit.
>
> Idpf still bounds to the max?
>
> Iff respinning it may be informative to explain how drivers intend to
> use limits beyond standard Toeplitz. The tunneling that Jakub
> mentioned. AFAIK there is no Linux control API to configure the device
> RSS block in that way?

How the NIC does header analysis and RSS computation is up to the NIC vendo=
r.

They provide some knobs, but not a way of using user-defined RSS
hashing for some particular encapsulations.

Some NIC use a TCAM, and they do not use the RSS keys in sequence.
Say if one 4byte member of the L4 4-tuple starts at offset 130, the
NIC will use rss_key[130-xx] :rss_key[133-xx]

>
> >
> > Since this change might cause some issues in admin scripts,
> > bump it directly to 256 in one go.
> >
> > tjbp26:~# cat /proc/sys/net/core/netdev_rss_key | wc -c
> > 768
> >
> > tjbp26:~# ethtool -x eth1
> > RX flow hash indirection table for eth1 with 32 RX ring(s):
> > ...
> > RSS hash key:
> > fe:16:5b:2f:93:85:c2:c9:c1:ef:bd:60:c6:e0:2b:99:4d:bf:b7:14:c8:1e:8d:cb=
:31:17:51:da:55:eb:91:d9:9e:f9:89:9b:44:a1:dc:08:72:3a:b3:d6:31:86:9a:fe:02=
:3a:0d:eb:a1:7c:f5:a3:51:3b:08:56:c9:3f:71:69:01:ba:70:38
> > RSS hash function:
> >     toeplitz: on
> >     xor: off
> >     crc32: off
> >
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Link: https://lore.kernel.org/netdev/20260122075206.504ec591@kernel.org=
/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index 05dd55cf8b58e6c6fce498a11c09f23fd56d8f34..0f761d4b94471a5f8bbe081=
0922cf59e009be99d 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -325,10 +325,16 @@ static int proc_do_dev_weight(const struct ctl_ta=
ble *table, int write,
> >  static int proc_do_rss_key(const struct ctl_table *table, int write,
> >                          void *buffer, size_t *lenp, loff_t *ppos)
> >  {
> > -     struct ctl_table fake_table;
> >       char buf[NETDEV_RSS_KEY_LEN * 3];
> > +     struct ctl_table fake_table;
> > +     char *pos =3D buf;
> > +
> > +     for (int i =3D 0; i < NETDEV_RSS_KEY_LEN; i++) {
> > +             pos =3D hex_byte_pack(pos, netdev_rss_key[i]);
> > +             *pos++ =3D ':';
> > +     }
> > +     *(--pos) =3D 0;
> >
> > -     snprintf(buf, sizeof(buf), "%*phC", NETDEV_RSS_KEY_LEN, netdev_rs=
s_key);
>
> Why change the print method?
>

Because the existing one is limited to 64 bytes.

lib/vsprintf.c

 * - 'h[CDN]' For a variable-length buffer, it prints it as a hex string wi=
th
 *            a certain separator (' ' by default):
 *              C colon
 *              D dash
 *              N no separator
 *            The maximum supported length is 64 bytes of the input. Consid=
er
 *            to use print_hex_dump() for the larger input.

