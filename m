Return-Path: <netdev+bounces-278380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLcCFwUV3mlBmwkAu9opvQ
	(envelope-from <netdev+bounces-278380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:20:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E20FF3F8978
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 691AC300DEE2
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C53D3CF5;
	Tue, 14 Apr 2026 10:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5843D47B0
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162037; cv=none; b=UQi79sMelQNXdKtUq6vYAJ+yEFfF0OOhnJgZXLZQL5uJqwBYPeHEKCh+RnhnFJ+04u1bR9keEvmfTEGn5vGGCVW1QnWy/73nLsEoL/AgZbKkjYJd4TxtvupbtOdtTzsQjOvzzfiLGKy/Xuy5ccDhDo0nCN2awnvNdSQY/4ZTV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162037; c=relaxed/simple;
	bh=w4RU3LbA8U81TCj411ChOJb2AxIw+5nh+I9X8CndoHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDXwc+UJ1fxCawWMriiGa3R707PSO00pBL4CgwQpYLvvtHTOVzqu60oVHO+K//XgxEOcQ/r6CY5ac8DEL/lJprm039zzSP7erFt82LXZYppViK1R9No2HnX9SaVJr4yT1dgXnwNWBmz9XWzr/qFDyQAAhAje0ju8EwBnfUsQnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-953ad5a55b7so3292446241.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 03:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162032; x=1776766832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1PSSGgZqIviWrUMA+aGkWAd7pcIuv8HlmdSZUkq2R0=;
        b=nZ+aNDE6TX8aDCU9+H4XY2m5KvZQhFTWKLnGo6K065ATQmev/2BWspz69l0fzHMuYv
         a33nnqe9RjpN04pSr/t0LVWK521PkCe8aObT9egiVmWQ3CiQI0GH3vAxhdkKqZjdY7ps
         wbfuQ/YXWIUDjyeAMDMDHdfjImcX8u62qoIPoDry4RkqdoA1WyjvOtIlzEFFUK1AlP05
         g25Wk0edx5QPzteAK3dlOGMrsyhv8ROdldjX86kd4oHIAeNXK3yaLEF59XKW4WpPTSeL
         EwesAWp/2ndcybotSAAJKvgSVEnH8fkwNtpF+ZklR0eeIQ3UElcHYDja9I6NgPbR3bo+
         bDbA==
X-Forwarded-Encrypted: i=1; AFNElJ+HriUki0JuR7hue4QSm9pUtgRwACtvyQci5oslrotn3xfBRQmcSqTYLeDEFMfAjtL+ON3Y950=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT2JNLjq65T4oJQJTN33ns/WAbyzBqJzQw8XGgTf4KY8HQ8xx9
	zdKt0gQET480wrBRaw5tSt1I/tjzUD721w1vYGYXz2xXXAihPJEgHc7JebKFINz0
X-Gm-Gg: AeBDiesORkAwMJb1ETeEU0w3XeoseGI6xFWgIheECHgkOqwurr9Dga8gH2PLMVSl0qg
	ZKcXCkRsFogg3kQ9HZe2rMBfHXfumU1OfbxDqTkFvoPVKtovZ8PBd5mTfgxUs7iVoLiP6kDSRDW
	w5JFNUJR393FeR+KAtwjV5gadzLLsKkQvJ0LukFDLAn9h0296ltn/GqMJUJIuvm+b0O+17A0c8T
	JQvdvP01CbdX4LMLoHt7hxFSjrkevsXNFGprKxSV9gSrzrfdFlTgZsd6UbXbTQThIyKYlklZRvY
	aG6gA+xOpCU6tp8cVHMFGfDnHv6CVE7f2xVU2s2hU2LW+CaF1QNLVZLkf/XgbOCM3Ban8YaPE5L
	2U6lzHvXqRLP2M0IHWQCvlEadfSgPVLAUOxlpZjgNQe6wHrmFyrHMmI/PYoEefUkOJNeNc/208u
	1Vwh7vreZeKkZCyGSj9+8zi1882OH1Qno46LfNX1rm0+l5rPZXyJUPb5YG1H59GZILO9RCoeE=
X-Received: by 2002:a05:6102:a51:b0:605:2df4:c5dd with SMTP id ada2fe7eead31-60a01885ff5mr7444849137.26.1776162032009;
        Tue, 14 Apr 2026 03:20:32 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6103c881cbfsm2319393137.6.2026.04.14.03.20.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 03:20:31 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-605def5b7f8so3351246137.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 03:20:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+jllnAI9rakz2lbZErfNWWg8S2OSGMBfEaOBq3BDgfeAjrEAzx1ErVSOotnHiDx0UtWpeYgmM=@vger.kernel.org
X-Received: by 2002:a67:e70d:0:b0:603:1a8a:c84a with SMTP id
 ada2fe7eead31-609fecb952fmr7637834137.2.1776162030603; Tue, 14 Apr 2026
 03:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412173213.3179426-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20260412173213.3179426-1-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Apr 2026 12:20:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWLp=vz5qgOx-N9Pf_FC9o3AsdDXq8Uhu+rW+h6__4vFw@mail.gmail.com>
X-Gm-Features: AQROBzALmSC5WPRkCgFTwaDsUgYaBeV27KPyK6fy-gnOYEKtgB1RvcJLdAOt3Hg
Message-ID: <CAMuHMdWLp=vz5qgOx-N9Pf_FC9o3AsdDXq8Uhu+rW+h6__4vFw@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: ravb: Do not check URAM suspension
 when WoL is active
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-278380-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linux-m68k.org:email,glider.be:email]
X-Rspamd-Queue-Id: E20FF3F8978
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 12 Apr 2026 at 19:33, Niklas S=C3=B6derlund
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

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

