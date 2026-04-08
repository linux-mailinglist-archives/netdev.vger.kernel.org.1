Return-Path: <netdev+bounces-276458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIBiOug/1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:45:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 621433BB6C8
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FFC830364BE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853B83B583C;
	Wed,  8 Apr 2026 11:45:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F52FF17A
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648742; cv=none; b=a+K3rtpNGetnVrwsIAj9PyjoQGzDPCq08FhhvDMlmKH6moum3ENMI/HWaZ+QdTFWqpaZAW2PHe9RydOoxLlllC0u8ViKfPV+ldQTXtdtPGZFFe03kUYNpGPsH1s/COJI/Mox02h0lA8sqydC1Sip6DYu5m4Upn6+lo2jZ0nA6Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648742; c=relaxed/simple;
	bh=tMoYbEmWbo19OX+Xq3VZmzh7ETPBDAACXNQrrg9Kxr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a23IhkHiCqr6eaJ3qE4uJpwPWK+fRffdCEjsjPpBc69voq/b2X8pPTMw96ZO+ibyy2VxQ+1RbRn7a/j+pWKpYSVjCFJf61aeJljeSKsCfk/iJfAQpY+G4TfncPnpuBNhp1UzQgvBsk1aXVOvUTqktxRc1+C8ggIYTib74SsiYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-953a2a4761cso3478203241.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 04:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775648739; x=1776253539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsFx8UqI7O7MvtKnezUqmqXPysfihd7yNwHTW94peVE=;
        b=e7juV4bwMvttOvxjp10d/1AMEil6ltjRg+miFDo+cFyRKq1phpASVKrapSc+uz9plV
         6eC8d6wFZzB3IFSxR/gzUXOl1+AiQCYUQq2DOVjmmLR4EaK1WYlJcpoNzmTZlXgL1chz
         NwzOL2xB/pzIeuBcACW3z7aeB2MregsAT4/+fZiIFMMUUOMYzlWM1xvL9FaQMWbbPwlt
         WCVrAXp6ncx/EaLjwkJDqN/sDtviXW6MsgfkbzhnuFJz7lP8MY3ojlMaUUuUUCu0e6iJ
         DZ/mX449ZjzK329bINdHjFpIdyXo3fbhdfkDz85LaPCF2JFNn+MKTu0sPSAvveIfuFoG
         cbvg==
X-Forwarded-Encrypted: i=1; AJvYcCVJW7gXPfifZX8WH9ApL8cXY7pmol6rvGSY2BQ4UTwG0fhKBsg7Fn/dljmXWNwvfOP3ofpDFzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzwihk+JCtGOWoXG1mTjHGsX306ellz83cx1swhXsVNQ5Lf7NI
	ljuTSWJ2b1VFszujCKwBzLPsNCIWiGLDr05xE4Edkf2XiJIbMjrmEFZDvqBPu+JJ
X-Gm-Gg: AeBDiev0KNAxyIqjcUB+G6g3kBRHuHg3SKgerXnPDKM3aE5WSHVCt9YMoX3ETTv/pQo
	vDVzfgI70D1eoHCFpvuQKP/emAOqwy+ITdUKz6ji4eOo+qv7f6nGAlZh0T+CxSrkGmZCn3NcZxb
	FowYV5RXaErv5PKLaMKABP2wDZTMbXcyJIe8cBjOkbVTjcvqfNl9FqKD55URLiMfM14tIk62f40
	pIoXqEBFnkLVgJHOELrk/rgdqp+Iu2cCRMi9NJ8CqVR3GI04TUosC7u1XifgK5EbR87to4MaBur
	P7E53+LcusHBrrP+H1MvF54IdTEVzR7JjijYEfObn4ckRbXIxCfKPNn5xme+Y3TJn/s0xfgXHMB
	TB+MRLA6Q7g42h9ILmjRwybf9AmaeI7ufTxZQz1c596vMI6EGNAP0riIs5kmF+H4ysZ+RYGrA1m
	xzYYnWODZX/ABvfWo6zpYcVRcT2sl2f5kd56EvspHOvRlrh03SVqkPet2WLPUz2E+K
X-Received: by 2002:a05:6102:4190:b0:603:1a8a:c84a with SMTP id ada2fe7eead31-605a4d81af1mr8380152137.2.1775648739336;
        Wed, 08 Apr 2026 04:45:39 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582b562bfsm20466049137.0.2026.04.08.04.45.38
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 04:45:38 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56dfd007d31so3076363e0c.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 04:45:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXh6urHvkTYKzjZGfp8vBFcDdExHlA2jRspYHQeMZc4Euj1py0cN4FCUOCfkIYr0M/Mdi7pWtI=@vger.kernel.org
X-Received: by 2002:a05:6122:1687:b0:56c:d582:42d3 with SMTP id
 71dfb90a1353d-56dab9f0300mr8497547e0c.14.1775648738222; Wed, 08 Apr 2026
 04:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403111738.37749-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260403111738.37749-1-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 13:45:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQiRpCVMuimOMo4Mz2EAG+gbnKyXY7oSXh7mL_fkdGSQ@mail.gmail.com>
X-Gm-Features: AQROBzB8CD0KWn3WV3oznk3HkPNWE_QHm1fcpz8CRur8WDBn-SeBp0BUAOGU0qs
Message-ID: <CAMuHMdWQiRpCVMuimOMo4Mz2EAG+gbnKyXY7oSXh7mL_fkdGSQ@mail.gmail.com>
Subject: Re: [PATCH net] net: phy: micrel: Fix MMD register access during SPD
 in ksz9131_resume()
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	biju.das.jz@bp.renesas.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-276458-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bp.renesas.com,vger.kernel.org,ragnatech.se];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.180];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 621433BB6C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ovidiu,

On Fri, 3 Apr 2026 at 13:18, Ovidiu Panait <ovidiu.panait.rb@renesas.com> wrote:
> During system suspend, phy_suspend() puts the PHY into Software Power-Down
> (SPD) by setting the BMCR_PDOWN bit in MII_BMCR. According to the KSZ9131
> datasheet, MMD register access is restricted during SPD:
>
>   - Only access to the standard registers (0 through 31) is supported.
>   - Access to MMD address spaces other than MMD address space 1 is
>     possible if the spd_clock_gate_override bit is set.
>   - Access to MMD address space 1 is not possible.
>
> However, ksz9131_resume() calls ksz9131_config_rgmii_delay() before
> kszphy_resume() clears BMCR_PDOWN. This means MMD registers are accessed
> while the PHY is still in SPD, contrary to the datasheet.
>
> Additionally, on platforms where the PHY loses power during suspend
> (e.g. RZ/G3E), all settings from ksz9131_config_init(), not just the
> RGMII delays, are lost and need to be restored. When the MAC driver
> sets mac_managed_pm (e.g. stmmac), mdio_bus_phy_resume() is skipped,
> so phy_init_hw() (which calls config_init to restore all PHY settings)
> is never invoked during resume.
>
> Fix this by replacing the RGMII delay restoration with a call to
> phy_init_hw(), which takes the PHY out of SPD and performs full
> reinitialization.
>
> Fixes: f25a7eaa897f ("net: phy: micrel: Add ksz9131_resume()")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Thanks for your patch!

> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -6016,8 +6016,13 @@ static int lan8841_suspend(struct phy_device *phydev)
>
>  static int ksz9131_resume(struct phy_device *phydev)
>  {
> -       if (phydev->suspended && phy_interface_is_rgmii(phydev))
> -               ksz9131_config_rgmii_delay(phydev);
> +       int ret;
> +
> +       if (phydev->suspended) {
> +               ret = phy_init_hw(phydev);
> +               if (ret)
> +                       return ret;
> +       }
>
>         return kszphy_resume(phydev);
>  }

This function is now no longer KSZ9131-specific.
I am wondering if this should be done for other Micrel PHYs, too,
e.g. by moving the phy_init_hw() call into kszphy_resume()?

Ethernet after resume has always been flaky on Salvator-X with KSZ9031
and R-Car M3-W ES1.0 (this seems to be specific to R-Car M3-W, as
boards with R-Car H3 or M3-N do not seem to suffer from this; don't
ask me why).

I have just tried:

-       .resume         = kszphy_resume,
+       .resume         = ksz9131_resume,

in the KSZ9031 entry, and ... surprise! Ethernet on R-Car M3-W now
works much better after resume!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

