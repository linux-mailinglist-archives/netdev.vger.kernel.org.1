Return-Path: <netdev+bounces-262640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN/oEBWEpWkeDAYAu9opvQ
	(envelope-from <netdev+bounces-262640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:35:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C296D1D8A73
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93271302513D
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 12:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECE936E47C;
	Mon,  2 Mar 2026 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbjsxksc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7036DA16
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454905; cv=pass; b=VpvKXDQbriSuVvxNlMSBzmMt028ewzsbJ+7nGmvSvhGlc4q/lNCFKVyi6MH9nT5gPNcBVFEA+okcRMRn+UEnX7/13+i6eVgvYHi8nydB3CYFRe/jNMG9RWr2mr7Skf8LBqz4pHxrrMGAY8aYKiywnSrPb0zUsfOUO5sZDrCn1D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454905; c=relaxed/simple;
	bh=G70396z3AR1gdLr1p/d3TOCXm8lo7vVkhM3DQeoQpBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENvRGSQS/i8W4F67nUa8B9R60udMpirsW6/VjVmLly+5Ru66cz7m3cNIkgx0QBkcKVh5P1FmTnldoKQnb3lFsebe5/sfw8lD5GBhhJ4FkKld5QDCUTKPSoirf4+OvBH28ojxW+ZR/xMtyC345BdunAqxE4KzRxooiI7sx6t/Xp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbjsxksc; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-389ff3f41f8so42584281fa.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 04:35:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772454902; cv=none;
        d=google.com; s=arc-20240605;
        b=R7uJn33Dstqkevcon2xUmCCfiv9lKnw4mmfUJbIsyohlQvD/VDaC51wF8Ctd/k3E6q
         vEQk5ahLtGKHzF1UG9IlZi4SkCEPzjXuDUjMIj6NTbqT/JFHhGWIaRAhQBkRZYC8KVBI
         mhYz7twA7X4FWcje+RXQUZ8eKWheTCw88hbFDb4fEL2O269q3h/eAMowqAAEQ1q2GM4i
         cR/C/xUP4OchIKjtMjiCQjaQjodTLZEglt2bsldXIFXCb+oMZG2IJMq/DIMtolOazh4s
         H/2VcxjkFR/aSrQEXIqV38WzZfK3hzqF0f+mysVLijtqTWA1SgzU1KqygT0s42mmAcW9
         Anmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=clZw4QkeWYi5fKm9/ZKxtsBsrt0kQs8tiw90UPIa0PE=;
        fh=iEUO4pJeq+zZoKN9X7EZ/ebngoTlxVFEERfpPjNBVGI=;
        b=G6VqxU3glnCTLusmN26rDQMhng04Xa/WHRSXQG8sMu7YuoOY4dCU6fSWA4u/PVs90n
         0p5P+e37oy9UL/SdwlVu01+C+01lOg/OHo9QB1zxi+vnTvmT7E8cAi/lUXZUiO0uaHYy
         K6a2u+j9szPuc0G0hgIjOmcFoMQ/3E/2oE8l2WzCBqQfvG1dznmnqoH6wmsy29E5bkk0
         YagjRatEmQQkjV1fH9yJjtF6aNKY5BTKVzid81lBtgqvOyxIyyX2QucCiPB5LpdOQ0ae
         4qAA1V2/cTyXT1dFSc2NMS3DJ1TQXKBgzdeIPK8YxBOqfVd+PcgQ1HIHUFwO6j/mGWNx
         CHTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772454902; x=1773059702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clZw4QkeWYi5fKm9/ZKxtsBsrt0kQs8tiw90UPIa0PE=;
        b=Pbjsxksc/oCFh7szxQEoitl1E8M0M2n/Vb/EZwOfzau1G8AVsyfSk0JeulDhDuVGTb
         we+n10y+Z4jCf0NnQ+Jc98PwYGz+waajZYPOMotPyETqnaJGgZKitD9Bv8FrkULVxev5
         buyxaAQw2m0bsNxQyUw+EskDNZbktXl8KTwAyNeZ+vpIg+XrhN3LQox5bFWctgHUR5m5
         yCrslBrdFoRpAkgEvfXCtCIIrqVmToUvQonBsJ3E8U1Mx0VYnByJW4jWFzRZFgYLCEoF
         zrN0fN2nqARJ9Gwcpu9vAKYNWJLbLyGqy7Vw/tZKL15UwKhiEJfDBJmJMIUCIHrdY39+
         ryTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772454902; x=1773059702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=clZw4QkeWYi5fKm9/ZKxtsBsrt0kQs8tiw90UPIa0PE=;
        b=ckUUfy+kfwnGlSWg1KgEqHddHUMnQaVkzUymC7zuqlIs+JnRMwxC84WZJ7JGR52WET
         pATChD0Tnox7GBz2rO5ZS+Zlq/q1foATpRXHPcpmrsuVCjOc0S5Kne3RtySj3vCyO2Qt
         QIQeDoi3g9I5wzUDIoBToBAHTkT65HfUaQqVk05vxR2aRirnplQyTsUjkYmf/yCb9k8T
         rQUuKLOJBpkHfIyt2avBryzMiNDdycmDC7BSkm3XSdNb+BDm0yqArT0GvdMz30qPYrW5
         B4cNdkn1b1PVrIHyzbCvD7g4Lfb4T/97QD9xcDvzjLkijAGzUp36io14FDwEHXB+v9Wx
         yiog==
X-Forwarded-Encrypted: i=1; AJvYcCU9o3nCBASq7TP/rBlSpM3KsCIt8cGBWTf+tSCPcuDjaI9DcMpGnUNpTXNu9hJvaEDkVBPOnvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNC403A7KnsxfgTyDG/JMaJ7QVAWpHh+RCAE5yrmrtF19jg188
	+1woGxUCB6pOF+XhJuWCeXQg5TiUwjyRjj2JaA3bP5tfJkFtMBmvdFJElasIlbMLJApX4ubPNG2
	ZjKV/zOLXYBN1WUK0gUmcTXyyTAsHIA6GOgIp
X-Gm-Gg: ATEYQzyDYYPs5EG39MSH8rV5UNyCg6yqE8XUzzso9g9qtOhaFMfnYgfDovZqXULIJQI
	trSyepGHANTKkZHl+IckzBXh+SOhUKVtcB/wSjR9mX2jd9NqXRL47TXWY16rL5qIv9t1JgAvvI5
	77vzZYXxiAKazkK1k9XFfJJDFSzBq/g34NXaF/xKP7EQthSYqP9l1rIIfxWY4Jn6efy+d9NK4Pl
	NvPZIvaJ+FgEg6gVBcL5dLjT6M+yAk4ShTj9T7yoL70VZ9zo/ueJHu82iGuFCta3QTcaFsdDvJr
	SUPSYMI01yJjooKud/eUwpyiwF+svx40/5NVBQ==
X-Received: by 2002:a05:651c:f17:b0:385:d0b6:6c44 with SMTP id
 38308e7fff4ca-389ff14567amr85086081fa.18.1772454902009; Mon, 02 Mar 2026
 04:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508091424.26870-1-jonas.gorski@gmail.com>
 <ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com> <d7f9775e-0af6-4294-837b-47e31e0d30d7@broadcom.com>
 <CACna6rw1kF-r40dr-nxouV9E0AigmeVj9fxQm_Px34Z_n2up9g@mail.gmail.com>
 <CACna6ry9B9LiPbWdXzi7FCcaU1YC+HPkor53AiSEaRSNUMcLwQ@mail.gmail.com>
 <eccf1d40-e4f2-4ea1-a8e2-328606fc0860@gmail.com> <CACna6rzi3_pnduEphRBY3NDKrNqhK2i5TdVTNeEGb4nHm+vOMg@mail.gmail.com>
 <CAOiHx=m9JQkm3pMj_mEMoVwCApB=Ef4J7FBzOf9_8o9eiYbCjg@mail.gmail.com>
In-Reply-To: <CAOiHx=m9JQkm3pMj_mEMoVwCApB=Ef4J7FBzOf9_8o9eiYbCjg@mail.gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Mon, 2 Mar 2026 13:34:50 +0100
X-Gm-Features: AaiRm50D9FqhHAassIvdOW8FehtPuVSmQ103pPMnBpXXYTiN6uYhacNovGiASMk
Message-ID: <CACna6rwbzSSbWERs2QFrUwn5sEuUYhEBe+kbXQJuj_RU1tT10w@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: prevent standalone from trying to
 forward to other ports
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262640-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zajec5@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,hauke-m.de];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C296D1D8A73
X-Rspamd-Action: no action

sob., 28 lut 2026 o 14:30 Jonas Gorski <jonas.gorski@gmail.com> napisa=C5=
=82(a):
> Does this affect all ports, or only the wan port?

Problem affects every standalone port (one that isn't part of a bridge).


> Have you tried to check the hardware counters if they get sent out a
> different (cpu) port? AFAIK they should be available as ethtool
> counters via gmacs, though I'm not 100% sure.

With your patch:
1. "rx_packets" stays 0
2. "rx_bytes" stays 0
3. "RxDiscarded" goes higher than 0


> Can you check the contents of the EAP Port config registers? Maybe
> some extra mode is set there by default.

All my B53_EAP_PAGE / B53_PORT_EAP_CONF(port) registers are set to 0 by def=
ault.


> I don't have NS(+) device, so I can only guess. Though I always
> wondered if the setup which CPU port (5/8/both) to use is just a
> software thing or actually a hardware thing ... .

Without your patch, 10 s after connecting cable to "wan" port:
NIC statistics:
     tx_packets: 13
     tx_bytes: 1998
     rx_packets: 2
     rx_bytes: 1180
     TxOctets: 2052
     TxDropPkts: 0
     TxBroadcastPkts: 2
     TxMulticastPkts: 11
     TxUnicastPkts: 0
     TxCollisions: 0
     TxSingleCollision: 0
     TxMultipleCollision: 0
     TxDeferredTransmit: 0
     TxLateCollision: 0
     TxExcessiveCollision: 0
     TxPausePkts: 0
     RxOctets: 1188
     RxUndersizePkts: 0
     RxPausePkts: 0
     Pkts64Octets: 0
     Pkts65to127Octets: 0
     Pkts128to255Octets: 0
     Pkts256to511Octets: 0
     Pkts512to1023Octets: 2
     Pkts1024to1522Octets: 0
     RxOversizePkts: 0
     RxJabbers: 0
     RxAlignmentErrors: 0
     RxFCSErrors: 0
     RxGoodOctets: 1188
     RxDropPkts: 0
     RxUnicastPkts: 2
     RxMulticastPkts: 0
     RxBroadcastPkts: 0
     RxSAChanges: 1
     RxFragments: 0
     RxJumboPkts: 0
     RxSymbolErrors: 0
     RxDiscarded: 0

With your patch, 10 s after connecting cable to "wan" port:
NIC statistics:
     tx_packets: 14
     tx_bytes: 2334
     rx_packets: 0
     rx_bytes: 0
     TxOctets: 2392
     TxDropPkts: 0
     TxBroadcastPkts: 3
     TxMulticastPkts: 11
     TxUnicastPkts: 0
     TxCollisions: 0
     TxSingleCollision: 0
     TxMultipleCollision: 0
     TxDeferredTransmit: 0
     TxLateCollision: 0
     TxExcessiveCollision: 0
     TxPausePkts: 0
     RxOctets: 1782
     RxUndersizePkts: 0
     RxPausePkts: 0
     Pkts64Octets: 0
     Pkts65to127Octets: 0
     Pkts128to255Octets: 0
     Pkts256to511Octets: 0
     Pkts512to1023Octets: 3
     Pkts1024to1522Octets: 0
     RxOversizePkts: 0
     RxJabbers: 0
     RxAlignmentErrors: 0
     RxFCSErrors: 0
     RxGoodOctets: 1782
     RxDropPkts: 0
     RxUnicastPkts: 3
     RxMulticastPkts: 0
     RxBroadcastPkts: 0
     RxSAChanges: 1
     RxFragments: 0
     RxJumboPkts: 0
     RxSymbolErrors: 0
     RxDiscarded: 3

--=20
Rafa=C5=82

