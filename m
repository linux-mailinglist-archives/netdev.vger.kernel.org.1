Return-Path: <netdev+bounces-264099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Kz4lA9XJqGlBxQAAu9opvQ
	(envelope-from <netdev+bounces-264099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 01:09:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F967209578
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 01:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0B8C30247E4
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 00:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDE3171CD;
	Thu,  5 Mar 2026 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ripCYaey"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D6CA5A
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772669393; cv=pass; b=rTN3xoBS+X+xZTcXSVP0zYytUFzEAjpVWRdNateDD9Rv7X8AI/Ow4tBSPIraso2fpnQiDGAATFJluSOYkJ9Qzy6BRRhbmYmFMQgmqhe5RXrUKz3B44jBUgGT/aFSLo/R4ayauADfXIgIzenDpTBgOzc2pJQXnCdZ86Zndm/sQYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772669393; c=relaxed/simple;
	bh=C2+saKEmVU7yZBPycXogd2EqB3Fic1F22/hijYHPR/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2Oo5+92UkVFWrs2Wcv0F69aGcpEmNW1KtmyCRO08AkGczpFAN9zKKieQ7OQn9P0REdWFADSNVBiB2jq9VFJ8XRbR1on5dPsndNVP7CQsVmq2hnk+ntIi2N9WhaKA7G6WfQs17pUNK6Z/sm8zpOJU/8C9ispWI0cXpqslntZ0r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ripCYaey; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-126ea4e9694so3502556c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 16:09:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772669392; cv=none;
        d=google.com; s=arc-20240605;
        b=aR7/t6D8aWEx591iWR+22QdOpBLDhwk4WexZ+zYfMcpfxlwRJ7auKa/060Ut/zLGlH
         pIfnxrd/1liLCY9hN1qMZkAo/HswGzYcHrMAZQYZGrmzp6ZORjJq/kS6xNWmzQGlreHl
         V0XTp5goaOQeOPiPY/d2lf7EiBZtDxU8DgW2jaunZUdJ/eYUfucF4t79hIq8aUDGD0ya
         znhWA7OL1zsrya15MeyV7y3WNlqYflvqvrz00p0WGi5wh0oYMVvM6iJIm5k3kcC4aBiB
         dCQWiS+4ihzRsiRa7bnnMOfC5fI+9RTyru4442nAKfwIoCUIEzI4gwPvAwKUyidCKWqZ
         K8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vlzmc4LiqZz1NhBLWJHnwJuIqPaJvCNbGNsBtcuSUBs=;
        fh=WpDCwX53ZzBPpnOvYIlX9exMz1x+VvJHpH+IXQjUF/0=;
        b=N5c5SW8fZNoA0MtJOtBUBB41W3uNN4lFzRZxDLxNkRP6m61Y1l+glNaRLSg6PXWcM4
         rdH9Lkkx7U1xGQTl+9M6CSFUY40BfxV78XtkULjzEUyj829GMiIpqB2Q3STgICv9y1w/
         lORVj082fFfNRBwDyO3194ZBeqNHtsOv6Zzus4ymGbSSpARW8xwmh/wN3IBD/tXn77La
         OtQANfnxgIlvE/XSvlXVSbMTO9navzeGafgd/GAwUVRoL1SHrlhGIEvicPNVjqCsuYRd
         kxrYRiauyJlybofVh99g7C3U8B1yHeO6adTOFoMBeeeypueJCgXpd/0pG5u20g0fdZ/H
         KanQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772669392; x=1773274192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlzmc4LiqZz1NhBLWJHnwJuIqPaJvCNbGNsBtcuSUBs=;
        b=ripCYaey3oQtjiYqkt0+eO5dnwH7w+hNuNaxTroI07dBTs31PyTZHrkW3KPVBXeBF2
         D4tQ8btgKgkxXx2lD/bGl/BprO7ldzt+FNaBgrfoXotZhxqYj5XOHPoG3qeCGioTxeTW
         ZMqrl9KvPRZ7GRV7674IsS1fEwr3zYFJoPOxGcPozBXYC24Z+d3NS0gjZOtBXI+vvoRg
         7qwaIJhOipKjeLKAju6dLMkGZuQPTgUvNmG8OX2qzRGfBeWwBALdv/0aMguMBBEXcFZ3
         GiZ6oRW7VuxVyp73r42ucN7hRJHpf8Cf8ZCifBgklxEsSFQpLFXJgfUld25jN9FmojnK
         KbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772669392; x=1773274192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlzmc4LiqZz1NhBLWJHnwJuIqPaJvCNbGNsBtcuSUBs=;
        b=DpOKIYVnfyhPtnEecquYqXL97gtqnghMuphFdkos4JUPynlbn6M0rsm/PWW85mn/S+
         uCW560GUsgsQgK7JJMNtWSSFkS7S9sTkxiIScHMghezJzIRH17uKkzeML9dkLG01VDba
         FGYpFxsb9Hhr9dtYorxSs+Qd20bYenY9lzClsp59SCEkQkCJyic3rnXHekwkAZ6uo7J2
         83wfJmKx7pHlwUKAsrS+ShDMr8QX/bkRJl54ZqSlSKMHFAe5hMzDo2J06ZfnZVoZK0lH
         lbEyd6jCC/CgDMl2JrmbZH5922cWLNaGOdlA/MjHuZ5SGopj7TW5N5sRBwQWwEvHL6ZN
         WNJg==
X-Forwarded-Encrypted: i=1; AJvYcCW3JSFU+e6KPQG5dhTMErXJ3JVPU0TEKtBVXPcrLlt7/bpKzA5nigQaS1zfyzEAXhSlNqL9Zug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDPHCEgFCGGP6ReaLW0hRZRETod+2pTTBif8nr2dsLouItMCZ
	+//YVozlYGGu0+3KZlTwHunBaTkVA1qh1UcCoODVp3G4LQnH6EnNrZQ03g0oaG3SXY+tXPiOa+a
	rwly9nov3PtGIZMJC6/d+HO6DDErr6bkYlECeU8fV
X-Gm-Gg: ATEYQzw71AZoXgIpIHLB4h7aWZlg1zgcXKjrqwpmwI6BNYUdL5L93an2BbAdA3Dt4pD
	IWm8oN/r08ngq/6Z1Wr8XtqlvGsVke2/QYs+yZvRZf/ebwM/GxR9bmlpLv9P4jvjc2wT3T4FT84
	EphMJ8PrX8Z3QhxEyFcwmIV3R2fhLgzIjuMfDaW0a/NhG8vip2z1W0QMMfo6V40aNPsg4zfqJTu
	8oQrr8kkLZ9F3RbzTuIqUqrJyL6DAsULNp3nw7ztzv5242vzF3K3/FiQFZU7F+6jAnSev62ljF2
	/wxpx2oX7BGEOkVYMj9ljzUoB9Qh+XNKQRVNZnNyXCOGEF6xyRwhYsbMU1MkXAHN+iyIAg==
X-Received: by 2002:a05:7022:525:b0:119:e56b:9590 with SMTP id
 a92af1059eb24-128b70d11bdmr2234800c88.21.1772669391120; Wed, 04 Mar 2026
 16:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com> <20260304193034.1870586-10-kuniyu@google.com>
 <willemdebruijn.kernel.1aabccf28abf0@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1aabccf28abf0@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 16:09:40 -0800
X-Gm-Features: AaiRm52zM5bUXh9f8QeVyqia-Ocdbsc9T02smmm76XOq5E8ccus33CYGok3mmM0
Message-ID: <CAAVpQUAmTCPACg_rAeji3oTu4bOAiH=vE78EccWo2o4JWurDLw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 09/15] udp: Remove UDPLITE_SEND_CSCOV and UDPLITE_RECV_CSCOV.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4F967209578
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264099-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 2:47=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Kuniyuki Iwashima wrote:
> > UDP-Lite supports variable-length checksum and has two socket
> > options, UDPLITE_SEND_CSCOV and UDPLITE_RECV_CSCOV, to control
> > the checksum coverage.
> >
> > Let's remove the support.
> >
> > setsockopt(UDPLITE_SEND_CSCOV / UDPLITE_RECV_CSCOV) was only
> > available for UDP-Lite and returned -ENOPROTOOPT for UDP.
> >
> > Now, the options are handled in ip_setsockopt() and
> > ipv6_setsockopt(), which still return the same error.
> >
> > getsockopt(UDPLITE_SEND_CSCOV / UDPLITE_RECV_CSCOV) was available
> > for UDP and always returned 0, meaning full checksum, but now
> > -ENOPROTOOPT is returned.
> >
> > Given that getsockopt() is meaningless for UDP and even the options
> > are not defined under include/uapi/, this should not be a problem.
> >
> >   $ man 7 udplite
> >   ...
> >   BUGS
> >        Where glibc support is missing, the following definitions
> >        are needed:
> >
> >            #define IPPROTO_UDPLITE     136
> >            #define UDPLITE_SEND_CSCOV  10
> >            #define UDPLITE_RECV_CSCOV  11
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> > diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> > index edca3e430305..195041ffb7d8 100644
> > --- a/include/uapi/linux/udp.h
> > +++ b/include/uapi/linux/udp.h
> > @@ -29,6 +29,7 @@ struct udphdr {
> >
> >  /* UDP socket options */
> >  #define UDP_CORK     1       /* Never send partially complete segments=
 */
> > +/* Don't use 10 and 11 */
>
> Could use a bit more detail. Something like:
>
> /* Deprecated, reserved for UDPLITE_SEND_CSCOV 10 */

Indeed it's more friendly to future developers.
I'll use that in v2.

Thank you Willem !


>
> >  #define UDP_ENCAP    100     /* Set the socket to accept encapsulated =
packets */
> >  #define UDP_NO_CHECK6_TX 101 /* Disable sending checksum for UDP6X */
> >  #define UDP_NO_CHECK6_RX 102 /* Disable accepting checksum for UDP6 */

