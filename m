Return-Path: <netdev+bounces-286473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBV/GUuBAWqebgEAu9opvQ
	(envelope-from <netdev+bounces-286473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:12:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF330508EBB
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20015301ECE3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29E03101B2;
	Mon, 11 May 2026 07:11:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3430C62E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483493; cv=none; b=FQs0cqV5SFsuFIy93BNz5OL9187E9Scm8McIt2/rJg7QJvdTrM4oN0uQNJ0fRmENImQH/XUvLp7SYBbVIvHDW0ohiyPz9RHT2RYpG3/3uQEU6q2cORP8VzzkPGRK0auFljuZTPTJjn+if3scGs/c3lWgdfG+z2Nmqenj1074410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483493; c=relaxed/simple;
	bh=O0Um4gJrLPGzHaxOQVL384l150E1rq+F8gd24MkfhgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgMKvYXRnMlw70JER6h9/pp8Ro1yT6TcYgVCUNlNxPwQtiJg/g8UI0rs+AjN8Bb4AWCsEeYaI7riWn4KliHMAnFrT+nPHPd62/dh4rCiUY20ZtJlkjM2ahK9HL2/aXBJCZtPhEO82szMpzrzT4cTUVpDzAYLayLI85RFcjnBSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-57513733658so1169588e0c.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778483492; x=1779088292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kRYUpsuhYWuz84JGxnlH83ZqNH3dWqhHNFOtz4SaUPQ=;
        b=s9xnRTJsTO9/OIRlM1yR1mQ7v4iJrZTGgv+JE0JbUEuzJB2eEHFcPHi2He1Pg4WWFB
         ENohOG/tIPR902yqg4fDQ1EPqXD4C07XjkG5um85YCJuFRVIUCNFYsOCryp1a5CeVRwr
         RHaXgmekNskZk/vBFokxcXRV/2EIDdTY5Xgm2TZ2Nzxk3s1471S1/WzPuxJVkm4fd3iH
         GkTDBA0UU5+4ss0tAnFKBY6CxRLrFQ1DpvWhsEG0JPkf/Fo2Q2NFgiANNbDgeYr5Dy57
         7asiy7r+qcLAskHxe99hUmsIKeW+MvBUg6DtGhPMLnc0cX3DZN1MJDXrkB/Gg6s6gHsX
         vCmw==
X-Forwarded-Encrypted: i=1; AFNElJ9s11lqClZi+kY9/awG9MJn13h3ifbGxaQG7UxZylG/0/SATwiNRdChxCLAMXmo/ndl65ptbhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoW5vTHigoWT/yzktiqlsy/JwErZI3Mndj7wqRDC36rhJB3ZGM
	Yt6wPXvbsJPWUuFwwSZmRIAB0fZtB8RSZ4DYoIU3RSre1+mdpxnCENgpzH1J02yF
X-Gm-Gg: Acq92OGHmdLjNGQYD9dXnUVxNhsbZR2X6y9pC0Li6Tt53+QJoJHUiP1tA20e0ygQiVe
	riPWmGO+5Ve94gwH0kai6MKqavcB7fECfPeEmmpn2AqU5RJapigrQfd1KdpkEG+SzCSlK4FVgOH
	B4RLdYzrBiV5J0816VqB6lUJZGQnPCafImaFtr2Mrz8OzhXKsgLxycFkXKJOlosndUdkMHhHfZo
	T4vSGniR4bClIMBEjhSg8rLyu+i6A0P2X1NnJn0k3K7ijaJLhimAp4+sXKcmOX/Vq37s67qrME5
	zMvykc8Zjuk3cfU4ah233G+fFyRMQ9sSoSLYL0gwDuQObJRQu1misswB8Y4PE3yfp1h9vCDu1N3
	PZR6RzHg7JJg4qw34Zn1R98PcK+7cxdbCsVgygIea00hLpix7l006+R9kpXnU7XBLFlh3YmwBya
	BiHAIflSpLHWjf/by3ezsAnjQLoYhNhKlSVRHzo9ajk/cSG+oCQ+6KFZefWiT1o1Oa
X-Received: by 2002:a05:6122:3784:b0:575:24b5:88e7 with SMTP id 71dfb90a1353d-575596afa83mr11664997e0c.11.1778483491631;
        Mon, 11 May 2026 00:11:31 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6ee065asm18397692e0c.15.2026.05.11.00.11.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 00:11:30 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5752b279662so1160868e0c.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:11:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+o1oLXKjbBtFT/jGTcUSWflusmlQhPBp33a/aiWHneqZZq8qiv/TPoVD0/+PYx8r220n2nxEM=@vger.kernel.org
X-Received: by 2002:a05:6122:e16b:b0:570:f670:587d with SMTP id
 71dfb90a1353d-575596f452bmr8339823e0c.12.1778483489786; Mon, 11 May 2026
 00:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510103017.613773-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20260510103017.613773-1-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 May 2026 09:11:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUKkP8gAsLFzV1Z98zxx60OLiR_-7=WuVeihWwd8J_aeA@mail.gmail.com>
X-Gm-Features: AVHnY4KX4L2BgRpFKacIW6Wf2uX1AhP8UA3ovWs0KARjMtrfpefScdS90azHI1U
Message-ID: <CAMuHMdUKkP8gAsLFzV1Z98zxx60OLiR_-7=WuVeihWwd8J_aeA@mail.gmail.com>
Subject: Re: [next-next,v2] net: ethernet: ravb: Do not check URAM suspension
 when WoL is active
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Sai Krishna <saikrishnag@marvell.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BF330508EBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-286473-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.887];
	TAGGED_RCPT(0.00)[netdev,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Niklas,

On Sun, 10 May 2026 at 12:30, Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> When updating the driver to match latest datasheet to suspend access to
> URAM when suspending DMA transfers a corner-case was missed, URAM access
> will not be suspended if WoL is enabled. This lead to the error message
> (correctly) being triggered as URAM access is not suspended even tho
> it's requested as part of stopping DMA.
>
> Avoid checking if URAM access is suspended and printing the error
> message if WoL is enabled when we suspend the system, as we know it will
> not be.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdWnjV%3DHGE1o08zLhUfTgOSene5fYx=
1J5GG10mB%2BToq8qg@mail.gmail.com/
> Fixes: 353d8e7989b6 ("net: ethernet: ravb: Suspend and resume the transmi=
ssion flow")
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for the update!

I wondered what changed...

v2:
  - Add Reviewed-by, Tested-by.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

