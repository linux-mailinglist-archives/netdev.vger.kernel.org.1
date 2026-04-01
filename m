Return-Path: <netdev+bounces-274168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMFcDzA/zWkkbAYAu9opvQ
	(envelope-from <netdev+bounces-274168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:52:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E8337D7CD
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9912530BD4D1
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 15:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A4443D51D;
	Wed,  1 Apr 2026 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx5iIZAk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC1407575
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058359; cv=pass; b=gXjAZbNQ2Hm2zzg9SFpTmNwlgAt0oJv3Nduq3RH+dICO7agvw8QBIXb6dDuiRLOyLgtyOgf00FOxpcLgbUEwAS/Z9sRRdZr6+ipcZJbe2kyB7xXxuQNIJdVPGcy+4AxrS+6ahJ+z4YDfv7iw6FCBPBWX+Fg97mmrtQ+9HVFZ4pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058359; c=relaxed/simple;
	bh=Esi9wO43FQaxJx4NMB7aYQXsx9C91N0Mmye513u0YKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iphmPpAtxi0y/kpcnaLiSa20cnv6Oq0g1ZdUYb8wZZ5XnLECbKKH/AJd918aRLUQwzHUYENZz+Jkk5CF6IspIObB0VSTxnZ/5FoSflY8FskYXfs6pEFLAebhPXpeN5V3aMsSxVJbODtb0xfxeamrA2XOM0Sgsl7HBmMO6yT5Bj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx5iIZAk; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79cae2b9fdfso12441817b3.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 08:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775058353; cv=none;
        d=google.com; s=arc-20240605;
        b=M8Sj6IecamfK+2yguJ1TwsFVpfWZsINRDiij8ncew35tHQexje4GzmYWj9WRA85GtL
         V3FtsOOEDtNEH9jKvKbznVmLJ+HDiYjon2Vs6Pdta2G/dC4WiwP9xghpKYJy/+t/cota
         KzjmsBHDYlBh0cB0IBQUVFXBn5jKL2YeMGvxsOpf756/NEaLzNA+zAWUJfQ+gH+LDcmp
         1wojOD99T3Y5jkWykTaSZJMm1Xz2lBAGCLA3RTMqY2Edmm9stQVUGW5ZA+EBlngN53hF
         6TZwYmXeyVcmMUcfHYQ9GtS98KWLGDeli4HrWm2dErkbvvreDIEk3tYzM6qy2eDSPdsb
         +7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rTGAJWv4JOiM3HwPkO1OOuIYpA+0TL54i8InJFWzsWQ=;
        fh=RfWeac5kOVcOHSBBj3vU80MvqgC9CyCp+sp80fj41Js=;
        b=EyQW1vwLtzHdQivkz6spXbAaP+CMcXfPpJNc+svn7+HxWXk9j+/YO1qBL02Z2/GDE5
         sMF/xGbbIBndwUWrj0z2jMxmlSSyw+ZE3GBRDU7qsWqHTHbhfLvr44RiwmOknim2J0Lx
         VRm59OINHpYn6C8+M0PJYlytTjlXYo72/zCftTsnsmRBZ5MW9sjgv7zuObDqgBkgH9IJ
         iPUgRKP4TYURe6BgDrm41Eqp70t9DyeepMPuULymhGMfjnoyqYzGAaqcdoAVDJym/imt
         z9kjqUiccIwwzcC+f4YYZvxz8ju4hjuH6ca0kFSFs7uirzTSa4A5BQUyd46mJzZAHzLJ
         X0Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775058353; x=1775663153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTGAJWv4JOiM3HwPkO1OOuIYpA+0TL54i8InJFWzsWQ=;
        b=gx5iIZAkZSP7OOBNHaL6XrF5y7/BQnSrPLwGqwKlm5sPejjpLvsRRU/Y984Lze24Bo
         Lk0i3p70fe80fNQH9v0i+Rr0ghokHQxEVTsfIItOk69AAWg6zJbl1L9g0CXYvhTeyN24
         TVWk95m+qFTbBSgwih4plH437afxucD3fvtPl5a6DYf9h6oPgHErNCySOpRjw6h1Ikvs
         2LS91pQjtI2f+tSg3izZC11aQ6zv6jIUeKCzHnBCwUxMEw9A97LVU2S3slx3JsShmyOD
         a5MyHSQ+aK9qZIm26PvBEF2nHh63ECQin7Rh9nxNrTm2H0u5ianugmA9TbeiENjb9XKM
         eOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775058353; x=1775663153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rTGAJWv4JOiM3HwPkO1OOuIYpA+0TL54i8InJFWzsWQ=;
        b=mlN7Nnm2bq9IBXSzl7WM2OZSlea1931ioJOlcA/kVCyUnuH9RcXf8P64TP/2bcbS2S
         TEe+ANLgfOHiCy6DkRtSoNkBgt6MVMXvyJcXr5no0sDPCTXsg/LyRrTo/tx6YAG+KQ2Y
         iuLazvnOs+Uh6Gl+YAxS4tLciG6Bqi40G+nQr5Kb6r2rY2InmttWFJejHzPBxgkVCykR
         OhH1GMhYGwL0jlBM720oYn9mkj0eatYt1Z0q4nopsIU02OP/4SwB9VhY8q8qj1nZAEuZ
         kfDFG+zlze6vn1jPht9yMnuDOwSSmGY7oFLar6Do2Bj4BlrmMOYgO1dpkeKyeFkXhbfp
         wLNg==
X-Forwarded-Encrypted: i=1; AJvYcCX78DwzZfpAxgg8L4rdEkxS2tOq91WKelIuVt7uGp5dtQcDykQJX2vx+K9eDCx+A1x819LW/80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF1VRJIiC01ZOscLeC/L75L8Qxz1UXoySeJd/aDBi60V7HQ9Xn
	G3lRfFto3GTpt8qTjtU8Hq7JHZMotF1Y8RmZIIwS0LYSHA9uIhw2cfZrdqhEm7yN9LMzZiYsemU
	QWklI6rHYNpALdtz6vDNt9CnCoH0uKxQ=
X-Gm-Gg: ATEYQzwJSFE3sVdVtBp/6fT9I8DEJmXstuJj4VP9c9d2lHjqfjM6mS8oxoq/a26mupM
	L295VPEp21Af7YcfovRFDweMFHI/cJlFz2JF86gpitIXnEqXj/i4ImNuFrehwPPL4/j+FonaC4U
	xEAi4dE7SyDkgUMzaY6XqFS/369ACkKYap5MyqGQSvjrPNDcsWTlcsFzJ4jhZSS/1rGtsGZgHhv
	AGgBXDkVxTycrOnAfqii6iQJgrqPmUBzoSEA9uRk3QKW0ACsQl7W4f1uatdM+jiFxt7A+5A6C4t
	L7e2xO9Z5DnzgqUETf1oaLPg03k710K49dm6
X-Received: by 2002:a05:690c:ec5:b0:79a:b330:a8c5 with SMTP id
 00721157ae682-7a212338856mr46397647b3.38.1775058352686; Wed, 01 Apr 2026
 08:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330035604.133073-1-dqfext@gmail.com> <20260401081030.29b050d5@kernel.org>
In-Reply-To: <20260401081030.29b050d5@kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 1 Apr 2026 23:45:38 +0800
X-Gm-Features: AQROBzDs2PPqt_rboD4nSJbhKsxG4xBUkUV-LUDRPkPIF5__1EilYpl7BBNQO7g
Message-ID: <CALW65jahWApDnVmFReW+Y3HDxBEmCwzsT1oyh03SW7X5ry6PzA@mail.gmail.com>
Subject: Re: [PATCH net-next v7] selftests: net: add tests for PPP
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Felix Maurer <fmaurer@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274168-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pppoe.so:url]
X-Rspamd-Queue-Id: B1E8337D7CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Wed, Apr 1, 2026 at 11:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 30 Mar 2026 11:55:44 +0800 Qingfang Deng wrote:
> > Add ping and iperf3 tests for ppp_async.c and pppoe.c.
>
> Hi! I added the new TARGET to netdev CI, the pppoe.sh test does not
> seem happy:
>
> # timeout set to 45
> # selftests: net/ppp: pppoe.sh
> # Plugin pppoe.so loaded.
> # PPPoE plugin from pppd 2.5.1
> # Send PPPOE Discovery V1T1 PADI session 0x0 length 12
> #  dst ff:ff:ff:ff:ff:ff  src b2:36:d8:0d:61:83
> #  [service-name] [host-uniq 9b 08 00 00]
> # Recv PPPOE Discovery V1T1 PADO session 0x0 length 73
> #  dst b2:36:d8:0d:61:83  src 4e:f5:66:23:13:38
> #  [AC-name vmksft-net-extra,debug-threads=3Don] [service-name] [AC-cooki=
e e5 e4 8c f0 87 72 d8 3a 60 66 4e 32 e4 ee af 6f 9a 08 00 00] [host-uniq 9=
b 08 00 00]
> # Send PPPOE Discovery V1T1 PADR session 0x0 length 36
> #  dst 4e:f5:66:23:13:38  src b2:36:d8:0d:61:83
> #  [service-name] [host-uniq 9b 08 00 00] [AC-cookie e5 e4 8c f0 87 72 d8=
 3a 60 66 4e 32 e4 ee af 6f 9a 08 00 00]
> # Recv PPPOE Discovery V1T1 PADS session 0x1 length 12
> #  dst b2:36:d8:0d:61:83  src 4e:f5:66:23:13:38
> #  [service-name] [host-uniq 9b 08 00 00]
> # PPP session is 1
> # Connected to 4E:F5:66:23:13:38 via interface veth-client
> # using channel 1
> # Using interface ppp0
> # Connect: ppp0 <--> veth-client
> # sent [LCP ConfReq id=3D0x1 <mru 1492> <magic 0x6db8fab4>]
> # Modem hangup
> # Connection terminated.
> # Send PPPOE Discovery V1T1 PADT session 0x1 length 32
> #  dst 4e:f5:66:23:13:38  src b2:36:d8:0d:61:83
> #  [host-uniq 9b 08 00 00] [AC-cookie e5 e4 8c f0 87 72 d8 3a 60 66 4e 32=
 e4 ee af 6f 9a 08 00 00]
> # Sent PADT
> # ping: connect: Network is unreachable
> # iperf3: error - unable to connect to server - server may have stopped r=
unning or use a different port, firewall issue, etc.: Network is unreachabl=
e
> # TEST: PPPoE                                                         [FA=
IL]
> not ok 1 selftests: net/ppp: pppoe.sh # exit=3D1

It looks like pppoe-server fails to start. You may check the syslog to
see what's going on.

Regards,
Qingfang

