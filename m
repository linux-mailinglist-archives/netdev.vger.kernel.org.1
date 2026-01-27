Return-Path: <netdev+bounces-253899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NBXIITEeGmltAEAu9opvQ
	(envelope-from <netdev+bounces-253899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:58:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3B5953CA
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C687F301859C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E0735A94C;
	Tue, 27 Jan 2026 13:57:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD835B15D
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522248; cv=none; b=G/Ug1z3yBthc00sHLyZLqPhtii0B+Hzmy/i26Z9HNAj+PRDopwa8cLbhrnrxae/smH+Wq2Fe2S4l1rkS+DUj4LETt7vFsLCP9lYb+dzd7A6P8d/ZXhYOKyAilGFiJG37m6K1hWnvyCNwYOKs4m7QTpdo6bA7six6d8udpbkmXX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522248; c=relaxed/simple;
	bh=CqxlbIALm6Hh+VY/KHyTOXJyg+eOFZZgrK/8Nd9qlfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWn+NpG1svd32QkFLFezoKki8n4nK81pzyCcWTJtqI7qeje+cNznDTcMf3M55Zwu0wYVMGqvR20gCYgGqvW4RCISuMcUSlbIRylpATcEgpW+suX1LlRlKz40p3+wZXycxz+2Q5bm345WD42EKO631fBPhMGkX9jGWcMtI1lw7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5636784884eso1221620e0c.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 05:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769522245; x=1770127045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75PQCFMMISya6miWyFTo5NFlD+yMTmEC4MBoTSgZA6E=;
        b=ggyLCR1ER/Ap7H2gfwBgNb4Fgb7wAABhVWObhKogb5TwLAkKWkg5xdtj+joEgFN0jA
         QNvk2lGQ5jn2ayjf9lrNVJWvkmEJyWVH5w6fXibyJXb9xhEJLdTXtWANT5PbYl3jLcyi
         BVihDbS5TPAU7O6qkKkclk0z3tH5O9LKwhFHlaRwFdbjQPPvZj/JBg6JKzZLsuq0IXCp
         n326iuntjp9WDvVHrMVe033P3yOAW8ym7KgP0QeYL10nOB7dyheIqfaHdARkQTwFSLn3
         e/+GYh8LUKzc/eE+LdwGvDTx3Ma0UGQfbkd2rP2hKlyFZv4MJSFYObKImDrszED/yJ5N
         5RwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMff24GkELC8CGy8CP2yL8daYo/6EOKdjYTMGrnLVS6kM76jyjVFeGATAJ3FA3UpZ5+nkHLV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtsHTS0aKxwwEyKhLgrqzwLHZUc8C+1Q9QpPJq+OZd0tumShLZ
	mQu5k2bkjItizXHKOWG2iePRy8ze4HUEg8QFfmP2hyQmazGi6aOXzmcQzwqnsstK
X-Gm-Gg: AZuq6aKavNkbwKBNe8viGo2Amml63w2AoZ5gAKo3j6NgxgvKr+8TdYCGaS7LNOwEUiL
	lx68XDVkAbZaq1FJzczLdm1bGhf/iiuLm+4b3YSLebnnE4YWGScRTPxUofEXiVdg9VEGva0H+1K
	KFkGK7Mx8CHciyT9r9LV23/kWpWZf+8F/SDyA2+h1au5diJ1WNn71IddYqK320lUXwk8JhGVMwb
	6DmG7/fUEQvN4DqO6jxlz4olHKlPrg/upQEmm/tnEDdMHW/l8rJJg+12CFq3ZuE3PWAcY9RADGq
	wLECkiBElsH+UKYgapSi2G9BnTToTSX1TuF30s+SdusKZ7+Dbx8RT/b5IaI4xZ8hdYBtlxsGhx1
	KLbAQjoasI6ZJqsdf39nuzabeXG7/Cw8C9qJBHJjmNkCK7lRY4kFOizFMrCuKfRrMblZHOkYgC9
	L5btvL6T0645MCIr/M1cwHoZOq1YyVTYCwNsANjHLhckh1YJV5/+c647j2g+GAo4c=
X-Received: by 2002:a05:6122:2a4e:b0:563:4a88:6ecb with SMTP id 71dfb90a1353d-566795ebe77mr476994e0c.18.1769522245129;
        Tue, 27 Jan 2026 05:57:25 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5663fb584ebsm2264846e0c.11.2026.01.27.05.57.24
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 05:57:24 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56638fca064so1417600e0c.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 05:57:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWp6rEUPUDbt3USPFGEajimijkzx696FuiwGgfM6WamzxI2vTRXItrwnDPKURKNi5+ewqUrhz4=@vger.kernel.org
X-Received: by 2002:a05:6122:78b:b0:563:8339:6201 with SMTP id
 71dfb90a1353d-566795e7f59mr418577e0c.17.1769522244153; Tue, 27 Jan 2026
 05:57:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126172503.238724-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aXeuR_YLoAFYEAVi@shell.armlinux.org.uk> <CA+V-a8t5RKY9vyFDg0V3AWcBovBdWbcvqdPeiPYmHRA8v2=UGQ@mail.gmail.com>
In-Reply-To: <CA+V-a8t5RKY9vyFDg0V3AWcBovBdWbcvqdPeiPYmHRA8v2=UGQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Jan 2026 14:57:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXOMMyYrbPr8H3O+oj7QeGg324jXdV1QUaUhQF4sxTyfg@mail.gmail.com>
X-Gm-Features: AZwV_QgbBo9gCTeM_9WEMxs9EnfZIFfAoe0fWXmaoPkXJK4PoXh0OCn_st1Xl0A
Message-ID: <CAMuHMdXOMMyYrbPr8H3O+oj7QeGg324jXdV1QUaUhQF4sxTyfg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: stmmac: Preserve bootloader MAC address
 across unconditional reset
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,pengutronix.de,glider.be,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,bp.renesas.com,renesas.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_NA(0.00)[linux-m68k.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-m68k.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EF3B5953CA
X-Rspamd-Action: no action

Hi Prabhakar,

On Tue, 27 Jan 2026 at 14:39, Lad, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> On Mon, Jan 26, 2026 at 6:11=E2=80=AFPM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> > On Mon, Jan 26, 2026 at 05:25:03PM +0000, Prabhakar wrote:
> > where "local-mac-address" states the MAC address to be used for eth0,
> > as specified by the boot loader.
> >
> Thanks for the pointer, I will use the above-mentioned method with
> which we won't be needing this patch on the RZ/T2H platform.

This should already work out-of-the-box, as
arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi already has:

    aliases {
            ethernet3 =3D &gmac1;
            ethernet2 =3D &gmac2;

So just make sure to set the "eth2addr" and "eth3addr" environment
variables in U-Boot.

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

