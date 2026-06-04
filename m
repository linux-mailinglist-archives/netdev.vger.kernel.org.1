Return-Path: <netdev+bounces-295195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8WrdI35jIWpeFgEAu9opvQ
	(envelope-from <netdev+bounces-295195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:37:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A763F7C1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:37:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ezmqC2iN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295195-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295195-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B217303D377
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25641B372;
	Thu,  4 Jun 2026 11:30:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577AE413D87
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:30:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572655; cv=pass; b=Ou8FTPC4BjKEqs5na9NM9KzQfaIKcSG/xYuYQaoleDUpVql80n90mj+AGLTFiE6PAm1J6F6kfqF6St3FFJWU6Sd41j0aMx/dwBGRUjx3M2btO8swGvIIKht497mqwP2zTcd8IEtSIF0oJrT+eEEMaRrmtS+VeW5oyjrxUAp/yYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572655; c=relaxed/simple;
	bh=IgaVd4/D/neWcGaYdf4+CIF4yFVYz7Eh1SsiQPIdiNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjsZnnNZCckL6gSnRB4ZlazA86XkvwK7uswprR2UJDTTkeaRxcuCDn3g2/J/GPX4mkqVmvc9tb0GVZlwoZoy23FDwqIITS1oiqhVDRXw2+Fz+QsShivdMDKkCWnizPiRGGRJDc21xdh49/tWK0bg7wKB3jnKBKnyDJRSVsFVDwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezmqC2iN; arc=pass smtp.client-ip=209.85.221.179
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59c1bacf871so174547e0c.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 04:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780572653; cv=none;
        d=google.com; s=arc-20240605;
        b=TyRVZsHQNqdXxVd9qiINRq1uZ9W0RqnKcRT2s3mOuQCw6hQ4tn9b5ImATdJa6kSIEZ
         3Uo0qtjDEOAOiB7fqucHFgFySDLgsUMDsGDaVC/g/7uhA0SlQGpkFQUrnv/DCugoE86J
         fcyWkIn5+RLMbX1Dq49XDh/qndN7Hwr540mLxRMUo8YN6KjfpbQflbJo6D7gW8n9TQ64
         t8BicM+ptdHrJ8hE63nhodFGMY0MBqw+q6JJl8yt7K2tKaG4cMFs8lzwyZ2lZGguC6Zq
         GQ5I0cJUbmcgQDPnulxJ9uR5RYSjBaIXQy/ucS18WHNxgj3iqEKp2PaW9HHIJnb3PWfC
         3m9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fpp7hpo+duJ5Snlj5PG+EfICta9eCWIZjou+VYQUVQ4=;
        fh=mhyzYzRgTx2JnqG4TJFwTltdE4ePG9W+WNCeDJVrADY=;
        b=iG2KFV1LY8OY4Ilv6YTm6UkTLEbq92LfY+zfULUuOmJcIM7lyEGVirsAQuNV2Er2NX
         3oK36X7CWndFHvFZlqlK0QuGFHJQEVKyA6G9Pp3uRs6xWF29sR2l7gj/ON6XGZjP2rwy
         ynRHFxW56Cg+f0ZWZRKC9BoGJ/sivuBiESpQC9l7K7C4uECbbAcmeku2+p5pb/Zomt79
         hPREtFTDuOKGJiiwODXetx63hMmHBrk4ts7mId+s7WwNDjNkWYsUZl2L6xW1kFmpCQ5P
         qU2ye1qoTYS5l/ciGUo2Cg8XM/ITxJzPBBlmre7pJu9Pj6jD1vsV+J7IlAazUyPqV9vm
         J7ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780572653; x=1781177453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpp7hpo+duJ5Snlj5PG+EfICta9eCWIZjou+VYQUVQ4=;
        b=ezmqC2iNUUfJwgeZG5pY77k+XsOPGlvqQzmHybpNLf7TgfVbhGzWR/k7Etygx2EpSE
         Z6JruUu6i+sXQ1MdiNIQhWdtKUBevMu8VDIVGDED/svPKd88sD3WWuf3fk9isG8+grfP
         z7luiITciUECenfvw++v6qu+35n08EKbcfbTDepHUszlgloxnAYu4lxHmiJNISX9VVfi
         ccRz1vwWyVrp1N09BchOhOSHIdePyMAbf61zuPrbhf4qJkOn3BCKIrle7JrKLAL1hMzD
         A6UnlLA3ubDJiXX/X+bf+KGPz0FksE0UYBQZ2TTOcZ8zXrdCZo2ulqws8wYwRrqbdVcv
         evpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572653; x=1781177453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpp7hpo+duJ5Snlj5PG+EfICta9eCWIZjou+VYQUVQ4=;
        b=MKa9f1uf1y/+5oyVN1U9gLwwoxB42LUhdY/F6Ovq8GsF2+o6tFFqzXENbZy/PfNCQT
         OlHuGXLVO1g+DFZl1jMUK/WH1UNfuUzdyo7VHgitO1Ml6WjIQVI2IDRyD5GQpiKmUzD/
         pz9NIsyrknZmzmYud31QtlmL2gPp9im8EQD8YZ2+r/67lT/vzPHiMqkmTji9GHbwFJYu
         EYG4K3ja7cuYArJYSk4zb49wDuuBGA4/LE94kz+0bfsRUjqLbEeK+Z6ZZaGeQoX2zfV4
         qIFejBCR/bRQlhfju5+OoGtpS7v0XMqcGzxrdo2ivRG1y6m/ZRa+7onhP6dqZ7v26w60
         zKrg==
X-Forwarded-Encrypted: i=1; AFNElJ+oyu3dMdpmHiT+Lo2842GSXEk3+KJ9RPOD9eloHFIErNSvgDEC0Je3t53yVDImtYWV+q8mQuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydlHueVciYZzX67H3/LvICvUB4XTjnz4hBXBX/2jTXOoUfTbZM
	CmGr0XObEezh7Nn2ntAf2/1Mih6YqDR5FLXwlItqp9Pi3x3/KgGIL2qgI5lB+qCmRUPmIUdSlmR
	DNyQK+kUQNN+ZeD+5g6pPyfZCiusueoI=
X-Gm-Gg: Acq92OFU5eSJNN2bMi1KlDnJy4Az2LxOqn0zOF6+sboYcRfXy7i5NIq5VYmAibByXaZ
	eEQgpzOgXYbOzGz6zxmPgUVFs2QVcwGbKzBn/xs4h5SvCLKiZ9sDFtkDPKiVsufHG8jO6i0rkM6
	uWqbNH9RHUFzbNhWdpaO08zVuiOJe9ux97l8FI0AZp1MHIkrIggoD67YQ1sp7sl1iP331lO9Rje
	pwLjG40jtU2SeSeLMtufHW+4oDMaR+NkxcqcniK6CorvaQMZ3vqBpE4/K7/4ErT+tGsIt1EZu/k
	BcrV7xrhO2R+vS0M
X-Received: by 2002:a05:6122:6e0f:b0:5a0:c38e:61a6 with SMTP id
 71dfb90a1353d-5a6e64b8500mr3995715e0c.8.1780572653233; Thu, 04 Jun 2026
 04:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602164635.62517-1-mail@tk154.de> <e80deefc-8467-4ec2-b61e-6cb064802473@intel.com>
In-Reply-To: <e80deefc-8467-4ec2-b61e-6cb064802473@intel.com>
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Date: Thu, 4 Jun 2026 13:30:42 +0200
X-Gm-Features: AVVi8CcDjNH2_4RpELI_VLhIrfYWmPteT4vvqOayjCSlCrLru3IZfh7g7MR56sg
Message-ID: <CAHzn2R2uvJiJM8UNw2+QEU7yqnqdJqcsDo1gBq8FKRBGs9DsDg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/4] net: mvpp2: fix XDP RX buffer handling
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Til Kaiser <mail@tk154.de>, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Matteo Croce <mcroce@redhat.com>, 
	Sven Auhagen <sven.auhagen@voleatech.de>, Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:aleksander.lobakin@intel.com,m:mail@tk154.de,m:linux@armlinux.org.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:mcroce@redhat.com,m:sven.auhagen@voleatech.de,m:lorenzo@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295195-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[marcinswojtas@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcinswojtas@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[tk154.de,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,voleatech.de,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D0A763F7C1

Hi Tim,


=C5=9Br., 3 cze 2026 o 15:55 Alexander Lobakin
<aleksander.lobakin@intel.com> napisa=C5=82(a):
>
> From: Til Kaiser <mail@tk154.de>
> Date: Tue,  2 Jun 2026 18:46:31 +0200
>
> > This is v2 of the earlier XDP_PASS fix. The XDP_PASS change is retained=
,
> > and the series now also fixes related RX/XDP buffer handling issues fou=
nd
> > during review.
> >
> > ---
> > v1: https://lore.kernel.org/all/20260524122334.1730451-1-mail@tk154.de/
> >
> > Changes in v2:
> > - Fixed RX DMA sync range to account for RX headroom.
> > - Limited XDP frame size to the actual RX buffer size.
> > - Fixed refill error paths so retired buffers are not returned to BM.
> >
> > Til Kaiser (4):
> >   net: mvpp2: sync RX data at the hardware packet offset
> >   net: mvpp2: limit XDP frame size to the RX buffer
> >   net: mvpp2: do not return retired RX buffers to BM
> >   net: mvpp2: build skb from XDP-adjusted data on XDP_PASS
> >
> >  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 38 ++++++++++++-------
> >  1 file changed, 25 insertions(+), 13 deletions(-)
>
> Series:
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>

Tha changes look good, thank you.

Reviewed-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>

Best regards,
Marcin

