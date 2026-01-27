Return-Path: <netdev+bounces-253930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G8KJfTgeGkGtwEAu9opvQ
	(envelope-from <netdev+bounces-253930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:59:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5F97447
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A6C830082B4
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F56D35CBAC;
	Tue, 27 Jan 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE3dOsbI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C935CBA5
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529328; cv=pass; b=rTFwExOJZetn4Zn/mqQGPKHVXdF2z4UWN7sJ3ypvhNMLXmMRMGIxTAhdX8ImQpYPte8PS8Hw1rr3mSO8I4nEMyuq17ICc3Po8vQ5UtqkdqhKn/JxPiy8LP2jSQBkbMGcb59P8C1JG8SDG1kwXL+YBjOhNLwOKMZJZVlbKD9pZM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529328; c=relaxed/simple;
	bh=ECZkfdjxMvGWu1OAl5cFKgNEi43tNjoGV2hwyoXo1R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9mXg7k8wV3p4H0EK/3BTrmZMSaG7I2uV1VRNntN4TpBIzeUlrCJD8slRv+BrZp5ZjMdEEugpkyNysBobPl19OiRQ7I57COIReaif/JBo/BWoN5l7CYMiQUiOe/gOOQceRL7dQLfSDHrPZ42sg544CwSNdS/cEBManLxTNMv4N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE3dOsbI; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so57009055e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:55:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769529325; cv=none;
        d=google.com; s=arc-20240605;
        b=iidLG82fZ/KEJ7jAyrK1OMnqPRUBJX7sf0XGJmWgO6MkQV97LIrai/3QIbyKZfnnWv
         QvvJ2Vad+N9yv05O8huHwjkNInNv508vYmOvoi5rlMJhoplVtji2fMTKJVdlnDreQAM4
         sPTVlndi6Dqt6ghWWKrt2okvmN3kar4qu6VY8IZmYgP9nV32Yaa4rWpoLctMgeIhZLnL
         Pouh5oGQhyN1i158uOjnmm3bXv1ky1fzFNdSiO1aKTQ5dySvCmAyxCUL/YE7oY01nMMN
         iJrqsVNmuY5+GOeW7pJYq0ssKp4uJf4kQwsZ94y2yUyNjHQb+e2uLWdKJRHxhP3W3EXD
         +UNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mdjGxuEW0WnDn6G9gnMVeIPJ3u/i1K8ZcFBcJ8h4M4U=;
        fh=oq79D0XdL3RBdm53pxIWNF1iOUfmYySPnRZIl8ppJiI=;
        b=LOAWgowhYOtAsAmHKFn91qCYusLPuV0YSadbgyLylD6+uOxwfHKzMkfdjruB2k2jCy
         ekawb9svdfxxBPtcTVBihbi3maQl3OHFcdUVLJBdXMJwqyqWPFB8ZrdEnPeoEZYHD+AT
         HV192MC72GI9HzaxQRd0ov9C6obrf2+IqwfZpu5uSKYxSHpzT5ittbBe7lBpwZMFnBP3
         OmXiItGw8naK5+qUhNJMwVetD7pUE+7+HlSSiZjO6N/1pc5BGIx6OD2LLXEn3Bd+nKAG
         JNgNf/FVYS9+UchMFrhfRgn0m8hG7rm+idfy9YBWeVEQugxhk95LO5wBn/na1aQ3zHT+
         eo1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769529325; x=1770134125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdjGxuEW0WnDn6G9gnMVeIPJ3u/i1K8ZcFBcJ8h4M4U=;
        b=cE3dOsbIcFUpRc95Rrkfl0bgcoGDZj/8Ai3+dCg/Vv2Tfz7gK2KFwwcJbXZDzWzdJt
         GHBIflOmi2MWYaaf4qWPtzsVO4cbnxSFu3LtZC5ERVKpxZjXdysS3tgYZqwrq1VGUfhl
         /hBcu2SOBRQ3ugCKLNfhpfy6r6ZpQ+b5HzIsoXJrn6cpyZuP9W+4L1MpkrAoKLBl+IQJ
         iauuAm4rADa2Cf+eiAN17hrMutuhPwO0sbTeL0QQrXM5X625ZHXkAUFqMLrBkllVSVKh
         zPiFA6JbV8G2EHojKTyuUa78wJnKW2xtsO2DbugYsqRC08ty63E02psep9/Ds/nvasw1
         RkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529325; x=1770134125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mdjGxuEW0WnDn6G9gnMVeIPJ3u/i1K8ZcFBcJ8h4M4U=;
        b=jzWGxd+XUMjR7kumnOb8rjhg6yMvyhzMEgzeTD09/i0Xp5U8RkoCopFkj0ZyL3cMxB
         AwZ1cdhSGtw/as7oKtMgYkN9JGYW5jDdJNd1qL8p8CnYTD/oLuHwHV0RIbg0NJhRzTZW
         Tj2gUM32I4nw0RKAwsGeFbu6iANMXgqIONpi+n6wgsYCxc3lehwrzKDBk7k8fsbfPzhJ
         TBVAnba+k5Y35SyC5HxNRx95ibhROlTbhlEEc2TaF9oj5RAH3cnFFBZAZvZGONqtkStY
         nP0a9u52dFziOEe4jpIt68NFC+9u7qxjlSYkIwklfuIhT+jiKWMxKOZIaIvJPkZRxA4c
         euQw==
X-Forwarded-Encrypted: i=1; AJvYcCW/9sPaWnHWXodIZDEtYwKnFZ6W0XHz4edquFpiJ93bvFL+Xio1AuSjrAfkzwF4DxP4hGkIA/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVSmUAeF81iLrueZMA23B4BAk5Wl5IIxZwnSuINFTSKqGud0dg
	f9r/FCSlPQWJplZ1pSpv/BvO6aoETWpSKV8P2WQCkf2hmlN7MO/vKTXQV0DnPiTKRuD49lBS7fj
	dHl69yXCEup1QzN1OMuuI9mTLHYdEs0k=
X-Gm-Gg: AZuq6aIvbAojQM5jj/GIfEgTPnFGIexNhT0jQBiSjMHa55fFAbje3Ny4Tf3F7uqLvvB
	9TrOPqqtWk1YN5XO4cn3P6npcSGxUJJ0xM58d+9PgECHyQC2H5WmqcammADgYWgkFfy3fuqgn+R
	Iywwby36TiHQLVVjp9I5wVmMFjLX87DLGVJHzB5UY/ELxZof+Tg7inqIWRrjRbVTsV3+Wd8o6Uz
	/1OGFt9jo7/hN6RHQwLgVDKqnHZ34Mlwmf2wHF6VGUmCa50F3C+Pf3Palg87U8PM2xUDt1JWHNH
	Slt/eWpW5kvgjqAILC5l0w8hTigoEXkwRoo10x1P++Zw6PwT3nml/Srwag==
X-Received: by 2002:a05:6000:186e:b0:42b:55a1:2158 with SMTP id
 ffacd0b85a97d-435dd0304a0mr3286115f8f.17.1769529324882; Tue, 27 Jan 2026
 07:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126172503.238724-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aXeuR_YLoAFYEAVi@shell.armlinux.org.uk> <CA+V-a8t5RKY9vyFDg0V3AWcBovBdWbcvqdPeiPYmHRA8v2=UGQ@mail.gmail.com>
 <CAMuHMdXOMMyYrbPr8H3O+oj7QeGg324jXdV1QUaUhQF4sxTyfg@mail.gmail.com>
In-Reply-To: <CAMuHMdXOMMyYrbPr8H3O+oj7QeGg324jXdV1QUaUhQF4sxTyfg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 27 Jan 2026 15:54:57 +0000
X-Gm-Features: AZwV_QiFFOxc86MsSOA1lIfzqIqjtoa3ZePZV2eq56xOKDzBCZT0iVVI9LGkicc
Message-ID: <CA+V-a8sQTRZOFk=KASum4Gi4cKK7NdLZu1W0n4ZyWPuKGSc9uQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: stmmac: Preserve bootloader MAC address
 across unconditional reset
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253930-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,pengutronix.de,glider.be,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,bp.renesas.com,renesas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prabhakarcsengg@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-m68k.org:email,mail.gmail.com:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 0FC5F97447
X-Rspamd-Action: no action

Hi Geert,

On Tue, Jan 27, 2026 at 1:57=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 27 Jan 2026 at 14:39, Lad, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > On Mon, Jan 26, 2026 at 6:11=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > > On Mon, Jan 26, 2026 at 05:25:03PM +0000, Prabhakar wrote:
> > > where "local-mac-address" states the MAC address to be used for eth0,
> > > as specified by the boot loader.
> > >
> > Thanks for the pointer, I will use the above-mentioned method with
> > which we won't be needing this patch on the RZ/T2H platform.
>
> This should already work out-of-the-box, as
> arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi already has:
>
>     aliases {
>             ethernet3 =3D &gmac1;
>             ethernet2 =3D &gmac2;
>
> So just make sure to set the "eth2addr" and "eth3addr" environment
> variables in U-Boot.
>
Agreed, it was just that the aliases in Linux and u-boot didn't match
up (Ive notified the BSP team to update it accordingly).

Cheers,
Prabhakar

