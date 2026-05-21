Return-Path: <netdev+bounces-290632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHnwC0uVD2o1NgYAu9opvQ
	(envelope-from <netdev+bounces-290632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 01:29:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A32765ACB3F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 01:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D68803029A62
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E882357CF1;
	Thu, 21 May 2026 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBGFaaWs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D53546D1
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406149; cv=pass; b=P1fyVbsKoJI/IrOB3zYjNVjkflpXilQxGdAdwqxGQfqPmpiVVQwDCDnk2ON0mu1SWp9f5qJrhuzVK4dPzC1KHDV5V6lTZwaCqvbffP2gijr861tHwjz/zyDqagn8LWay142WdAul1+xusqoYMwFateFB5b3sOEJXDu0YcKx1Re8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406149; c=relaxed/simple;
	bh=ZRaEEtcu5aoVBQcXKQ40u2+M4zW7oY2aObDk0D7HGVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMaBonftglrpMszfrgNOwwfiqLYERli+DNx0+zlX2hWIK8dvhw/0lUwRR6U6hb9BJEcoMBRQmpU9cfjPCQIZrlX3P3qbflZaqcznDY+YElpetIda/h121zy3hVYeu++vyCPbQYIy6q1cxDYGZSn8Yn9anakHXvpEEmNQLTEMqYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBGFaaWs; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bd21ffaca79so1318784266b.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 16:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779406146; cv=none;
        d=google.com; s=arc-20240605;
        b=lfeNi2+Cm3eUCL2951Fell+EUBGOZ1YdVV+GRIdlCc009ccvXHNpR3iVw2bCb/rMQK
         0F4VJDmjxT88ibqvFQIle4hLcKTIUX8AF0I6A0An5x73GiM/VHgO42852zs2pzO3lAd3
         BUJRTZWHVAzv190Q3gn4B+zO7BduchILVxGinuX9sxf6SR3V4/i7W0uvZfJrrNOhhIQZ
         HPi+ibWQjBuCQ+MIEeABgQd2J3jIq+F6dZz/wEm0v397ic6RUWl1FAV1y6Nl6G64iMJA
         b2GTfJtmxgVlBn/EoeZiNmnbmYgZGS6L7OUu5RXWYg9+VHzfakO9uSNlBRsgckTXdmKy
         96VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZRaEEtcu5aoVBQcXKQ40u2+M4zW7oY2aObDk0D7HGVk=;
        fh=HuRMpMV7KDeDU9mr5dNRAfbTDTloQsFcv0KmriNEbXQ=;
        b=RoftdMyQmqdev8uzeteOQa2dRa15P0S8rOrEsf0jZw/YNYokAVzdtqLR6s6B81z9jU
         2rS13JhLli+UupP4Ib8eiyUSs75AQJs0TfosSrLyoRfuoR85lzKDSWYz6J83mtEQuz6d
         1+uUAfMUuLkgi5bZxJs+RA7xupVfptb5Agrmzqyb+xTRLfKjd3/hBiipreyDmzYTDUim
         1IkjWXuQ4fFIqtiXAPws5HK4OueoQCqmr3xOlnag223cTGBnH/O4IrbIkToavYL6T1z1
         dvEpY0GeckLkYZHDtY7WxB31TxNW6vvMxNZh3vnOPZEIeSlfpHYPoHWevi10NeZz1WvM
         ZPSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779406146; x=1780010946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRaEEtcu5aoVBQcXKQ40u2+M4zW7oY2aObDk0D7HGVk=;
        b=hBGFaaWsKQTdCcI6e82U6LG2PjfMSsxuD1qo2LjwSvueFB8XoqOusNQvhzBQrAAMIZ
         XLzBrMMetu+AnFqWM3dCW+2Fz844u/v5C0tbmtgVMqwo5uppNZkXhIwu6xT5jFvQ3cfK
         +19g1+0i2UhX/XwKLa9MPVfcby+fIACsMnPyfkSgUuM4+Gx240lWAcSFVteuIwgz+r2i
         7xKaVqSViZefWArdb4Fgb311m7xH6BZNmP2mqXmYr2kDntfxD9qiD2qbu19pRlWPl/sf
         oHe+2hXsuyOJgv5oHocv8MNtcXLZ+DoZqXJgqtDJ9hDq3TmzO7nRJFPNOSKne6CTi9gH
         auqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779406146; x=1780010946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRaEEtcu5aoVBQcXKQ40u2+M4zW7oY2aObDk0D7HGVk=;
        b=R+Fyga6OuBb/8WyszUMnHLwFfibnxikrJm77rGrtHCtvcZXpDB3k9ry3eUo6iIK4Uc
         bqI2lYBo0eYeH1WKsYNM6QBzTmegcMHYUN/l9vQmSz2AbOIyXSLOxZ9VsqsLTXaX0nYb
         3MmafSryCvcKWgMFDRgqRqA3b7emDKCMvZl7mNEdNlQeBBx/fP/0jNPTDCBt8Sw5ekCc
         Lz5i1x1pANH/wmDOa/uLCHXEYOZx6uSPYOQVL5wbInEA9hJgRoXfBp7f+fM83UpTY02j
         Mfpucmlknm0R+LailM+GoDxPk8W7mx+03kyhs0gLPn1G3tkkQMXL1GK+xizJUWo+s4aO
         zEAw==
X-Forwarded-Encrypted: i=1; AFNElJ8Q+0eT4eHrv0TvrGqGzE0gfZ2dSvjvigSzH46AHttVxsAi/ieT9idqcEE9xMGrcjO5I1ahdQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIkPBhpYYZDMqhtPokqQxBZP5blWXqjJyj5Hcus5R31SNwPRvz
	e5c7+/iOJiJn644gngWEKfJGAzKhcgCE+M/OBE0UoYapVqMaQub1qm8s7Y6Pf7sA5VkKgrrav7v
	GZ2NpBpdoDIKwhMPT0WFKEzL/PaEqORk=
X-Gm-Gg: Acq92OG+qTplvl5Q842JpC+g9AX7GBirW6ZsoQYK1prr1i17FIVpUdWNB9h6Lk0B5Jp
	n4hBoI4u/ARNsVSDPK/SEa2RZ3HL8YegGfp6N28ZVhfeeHZMmL2cNouVmpRmdVn1x8qfU2oSOCu
	MDiGs/DA4O0PLUcuzRHdzOgk9sI/ZN7fFX3e4dTGzAnTfpjcXwA+YId34USRBwcMSxgMDBfnO8j
	wVd6UYrk9LLQ/1uEP/hQr8tiXuD9847ZDjEpKLS3FupFBV8hnM6jBG2u/1GVDr5n7hu0TmZYX8W
	9EFw+vEWFGARA5KeeyzLxs7k2muWTh4HlZc5U7Om2ZJGD8uEXehmuVyZp75XhCT9zGwwnTx9HfH
	/EoU5VbEIB2vpoZagW3pMT/7eUkHSzxOhsfCAzlUAUwA4G3YexPj6PuXw8w==
X-Received: by 2002:a17:907:5ca:b0:bcb:cd03:7d7f with SMTP id
 a640c23a62f3a-bdc01d009c5mr253930966b.31.1779406146281; Thu, 21 May 2026
 16:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517192856.3925-1-rosenp@gmail.com> <20260520165746.7ed10c7b@kernel.org>
 <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com> <CANn89iK7i4u5nWxQCuURmSCJt8Sn+Q9x_ME8X+J0pF2_4OGuZg@mail.gmail.com>
In-Reply-To: <CANn89iK7i4u5nWxQCuURmSCJt8Sn+Q9x_ME8X+J0pF2_4OGuZg@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 21 May 2026 16:28:54 -0700
X-Gm-Features: AVHnY4IDG_uMXoWKwgJzup3yeBBTXO9-0wxM-YmzD0wTA1_WCxA3WbYMMHjzM7w
Message-ID: <CAKxU2N_63D7SFPkr9H9UYWif2DRW_qnV0SzZoRHWcRZtC_HTWg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290632-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A32765ACB3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 6:41=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, May 20, 2026 at 5:39=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > On Wed, May 20, 2026 at 4:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> > > > Collect received skbs on a local list during RX polling and pass th=
e
> > > > completed batch to netif_receive_skb_list(). This lets the networki=
ng
> > > > stack process packets from a poll cycle in bulk instead of handing =
each
> > > > skb up individually.
> > >
> > > GRO should be even better.
> > GRO will result in slower routing performance because there is no
> > hardware checksum.
>
> Then provide a knob or something, instead of trying to avoid GRO.
>
> For end hosts (forwarding not enabled), checksum will need to be
> computed anyway.
> GRO should be faster for them.
>
> Note that GRO also uses netif_receive_skb_list_internal()
so you recommend switching to napi_gro_receive even though there's no
RX hardware checksum?

