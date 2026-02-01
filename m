Return-Path: <netdev+bounces-255666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMJjL4qcf2nwuQIAu9opvQ
	(envelope-from <netdev+bounces-255666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 19:33:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A31C6EAD
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 19:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83E393000FE6
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 18:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1682F239E9A;
	Sun,  1 Feb 2026 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuxseuYf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780232749D9
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769970824; cv=pass; b=aGYQsJjC2RCAwVQumueAaWycH2/ULmldC3esJ21K1M10JgYC4S1ZGEiR8XjoQnXsCWwuCG/iiVz/dSkkHkxd4mNFfENB9/PlrLNFkdXBhg6Wb7gYDm+tgiTIvzAug1DS53E3FnPjmt1LdnYyl0BVICCuN0f2hg22tcLIO5Ly1js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769970824; c=relaxed/simple;
	bh=hFea+MpgdlgMUUjAVsq/4Azz3DGpM7IngnTvBlvhvMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDwKjJLUaXhrC1fPdsNUo6K+j0mOcEae9w6BS93l43fSwbv2vBaPB83pMLLjEbnEnrndjxo63IIv4Xlteyt3iUHtHbIipUD/1Hqx1wnk+pXzaG+bsJHdo6dOd0hEpztfdoBUm4WTrrg84ZnylI1d6NlslmPy1rkPBvaU/TVwYKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuxseuYf; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432da746749so2094564f8f.0
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 10:33:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769970821; cv=none;
        d=google.com; s=arc-20240605;
        b=RvKzNIVq79HQYaqXfJ8UR+kE/kjWBdGGTAopxnt/WmbvHOGgR09YXXgjJc8Jkce6sw
         HmZM4OSiTefaJs1iwASdN2I8JIV3BFzFOcXWQla1AOc67N7X7wpmmoIHLMhPER5AJYuQ
         keWZeafqhnIJOEQb+ondgxAW+rHxUt8XfI/+I6JUrpj36y/G2Y+baRelYwwOATETBcJT
         l+uijxjjkSrfWj9X3JDSrCO71EikShyz+qZdQnGZqhBGHUsKAneL7pVoIhvI2SaS8iPN
         c/mU97NNnM+DAj0KnNCd76onJjsEP4XLj6M5VRrtNmIA4wYgFok763I+Uf3yI8cli7RS
         XKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ya5yGFEaw5toM9HVuI7d0yc/AabXJ23lQu580Ng5uVA=;
        fh=nSLWEUJ8PJGXXlrP0vQryznIEZ6AgIP8BH8VhTmSVFo=;
        b=BQV+bwlHJOJhx2K8sfh6xYFnwUN56r/NVgMcLKCyu/XGm4g5u/3eF3qe1sMHvQtVAY
         xQjpc6HSQtbrw4gLKv19GT/ke/+vL0viJ6k6ITSBKgLcbjeG9xyx+hmZ7zrfiaXLrFlU
         471/AQeqcHjlUkyQKyrreQoZh/1I8Tf8M52a8flomHKbtt9kWl3aGBckZveP1yDWMoKJ
         QhfChxLWoUmoaqZqELOao9p2vf8qp9F07Ex0H9kloRFRnaN8QPIyCf4fNh6+Lc3CwTo1
         qNVQ/0gp/AH8vlqhhty5xYlB2v1MU14UcFL1KKvOfoD4RTNWhy5lrKfdMhUS/kOsgCoH
         TPkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769970821; x=1770575621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya5yGFEaw5toM9HVuI7d0yc/AabXJ23lQu580Ng5uVA=;
        b=KuxseuYf8ahudiTkyssDYtKlr9EKCXGru+Lxcl/rA9U08fZqwM+zlRnSlcPuJuxKiu
         LYh3g+VhDn8mYtGRm5/VbOkQn+nvwNLZOR3BTRxjs9DZVKKJsKjK2IJoR6JYvu3ZvX4y
         iADRiJqdV3Ah4JCKVJlOcsXNpgWjgd1f/gk9bjyWFiUrKdSAhhCoUOMAM27SX22GNKol
         /BspzLMb9nrOwKdURdNtJqBQF2J1JA89XX+FR2/74VW2ZXhBjMQXrQUAL+b8PFcHKnvX
         B9dXZ8f7wXSpzltMg1c15vzE3cSHUVJSaZm3Au/CW3jX8H9bxfrR0yRp/aWEm8Ei32nQ
         nshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769970821; x=1770575621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ya5yGFEaw5toM9HVuI7d0yc/AabXJ23lQu580Ng5uVA=;
        b=dZuTJREizvmoO6Kr6iEsokv1SctZQs39tFxo4YpYTNQOR+PWufuT4l85ZOUQBd1Id9
         5hoh0hM4f1uDG612u7y4J8W7BN+r+hSnFgjxmzl7DK20EJJzdBQ06uZy+E70MR2WVvE4
         QkDRZ1IjbS3LGfw+XKL/SA4LSQEcuV1yIglHfDS495wH22wnkoYlHiKBozRISKJ9SZPj
         a4yQhQHTrfyzS3doCMhun3K3WvyBzbB3Ba3/gW/oBCA2YR4iy5iVNfdbRzGuBdi2W4KO
         E8IlDDGFtLyS/N7fdIWHintcmSdsV65HKliCQpdJhSK5/DxrivKmD6vbWx37ocAcWP9M
         2G8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1r3wOMX7jgP6FxFaPpnb/J/m/CjsxjN/Q8IY4f3b78G/ynrh1MAvBFMgmyug7A9NGCRFyyYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFWQiZlP354Y69rAzCMcoB0Bwp4HSa4eHWr1vuRC6GEyk7bSBu
	A800+R08JUgD6eoNskspFhve98YPvHoQq9l9bs6gj4vVNvfnvuufaIQPk6CvDx4jY3uvjKZDZgN
	yglRTxGH+Iq+DgiENZGqVWqWfSzm+jCg=
X-Gm-Gg: AZuq6aKfXadofgMgN9gUEPB7BWPs202v4ngqm8IKgeJETl1QOPnZo8KgFhG7zN9wHDE
	AC9Nl2B8AhTtGj6e4hpN2MI5KOZqtfwGCTT/5HZxx+b/4/nPSUpKf/XXWQdyNP16ZIzJRNQPWFR
	n7eTzkOFuaqyUxDCWHwdpp+flacAudnq63We+HqBlF3idvvz3OjljOzf87tbzAftqj7qNP/T5ec
	hqH3bKKbuTyddO0MuQvY0+sS/TYtspxlYtlLMex4pbYi90tgRR0Tdh8LlPuKMrddL5bVF27JFzx
	ZUunG6dmkvAZv69osnFb8aUs8EoLoo+NpGCC8/bFrwWwRVNXjwseu23p2OH05I6Ha4vz
X-Received: by 2002:a05:6000:1ac8:b0:432:8651:4071 with SMTP id
 ffacd0b85a97d-435f3a8873dmr13278042f8f.18.1769970820751; Sun, 01 Feb 2026
 10:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131161250.5047-1-biju.das.jz@bp.renesas.com> <20260131161250.5047-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260131161250.5047-3-biju.das.jz@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 1 Feb 2026 18:33:13 +0000
X-Gm-Features: AZwV_Qj_oRyCrNwk1d4EkOcOrEcSe3PZ-OQGreA6B9xVWTkAhiCPU1GA5dw0no0
Message-ID: <CA+V-a8tj74WYJ=i5y4rg4OEtr_rXh381w9+s+ycn8qjajC4QxA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: dwmac-renesas-gbeth: Add
 support for RZ/G3L SoC
To: Biju <biju.das.au@gmail.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255666-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prabhakarcsengg@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bp.renesas.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,glider.be,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,armlinux.org.uk];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,renesas,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,renesas.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 56A31C6EAD
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 4:14=E2=80=AFPM Biju <biju.das.au@gmail.com> wrote:
>
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Compared to other Renesas GBETH stmmac glue drivers, RZ/G3L GBETH IP use
> the version Synopsys DesignWare MAC (version 5.30). It has an extra clock
> compared to RZ/V2H and has ptp_pps_o interrupts. Add support for RZ/G3L
> GBETH by reusing device data of RZ/V2H and can be extended to add other
> functionalities later.
>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Collected tag.
> v1->v2:
>  * No change.
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c | 1 +
>  1 file changed, 1 insertion(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c b/=
drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> index be7f5eb2cdcf..19f34e18bfef 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> @@ -214,6 +214,7 @@ static const struct renesas_gbeth_of_data renesas_gma=
c_of_data =3D {
>  };
>
>  static const struct of_device_id renesas_gbeth_match[] =3D {
> +       { .compatible =3D "renesas,r9a08g046-gbeth", .data =3D &renesas_g=
beth_of_data },
>         { .compatible =3D "renesas,r9a09g077-gbeth", .data =3D &renesas_g=
mac_of_data },
>         { .compatible =3D "renesas,rzv2h-gbeth", .data =3D &renesas_gbeth=
_of_data },
>         { /* Sentinel */ }
> --
> 2.43.0
>
>

