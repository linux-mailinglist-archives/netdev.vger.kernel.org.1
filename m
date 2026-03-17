Return-Path: <netdev+bounces-268478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMllMMMKuWk/ngEAu9opvQ
	(envelope-from <netdev+bounces-268478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:03:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 389552A53F2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B54E307A651
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01013396B6D;
	Tue, 17 Mar 2026 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF3INkj/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E516396B7A
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734400; cv=pass; b=mddsfb1a4e5NO+m4wNcK3eLmAimBNUtkfUK5rrG/2On5AgaMgh/AjBtY2MiQaIjNCdd5nYgsLsFtHobY4CGm4qJ4PYefLmlhv8lZS6VgBlaajgJ7YNiUstQAv5zybjryrxgvl9SnkO9Cn3dsm/kJEBMrGV0hMiETtwE8JwFKAkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734400; c=relaxed/simple;
	bh=/BsGzULjrQvHMcdk/aTc83nOJrMTcjHqMKB6iwCFKVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJb1kZWskWzJ/yJ1FOXTE9wxBdiALuQpAPS7d7AV8psI7CN5OJSyfxx4E8R7ucwBh3isAzzGIUJwMWGjjbutjE0PHS/nGyF2DN4Dwa1cOFp6VUL59yU7RezSLkmukDtuMK6kJY2QCCXClhgyGuC7KlZnqn2EX1P8iFKq/i8JGek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF3INkj/; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b941762394aso685782866b.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773734398; cv=none;
        d=google.com; s=arc-20240605;
        b=UhUc4M18E0sypR+d/ahvR9QAqNr1YiR1Dv9HIqV9v39K+pk7OgW+qaw2KENB3ZV9ng
         ZvaFBPMmCK74hBMmzV877eRZEnlNao7wY+WnDsNCEC2MTn5RFbSORexMtCrsPxWT2+JV
         yLkacMTp5MJJEg26Kj2L5n/Uc2KcdNpIcxvdiWJOo1hZnn+dPFSegCmsyWX+Et+N0Ah/
         nyQc3vnQfKvSNV9lKp5oz3GLXknVZsMXmEsvdqGuKBV0AzeJc2RSMtyOD131RtFe4DO5
         av1OQeCA7H5rSxm5KEu3sjVpmLdWTjDT7LT1uuvb5Qz60bMPbzwreh98yMlBjHAuXkzk
         DTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9Of4mEBm0klTx9gd6BL+m6euSejqZNMnXy8ZsfN0BJY=;
        fh=QY3G5YHTX0uem+YseUc587f+m5ClQOlT3B0ewcF0RL8=;
        b=KJbHN0UAd53B9vpgGbyTv+02mp9g4MDx7zFtaZL2t88JV9Wdr35EW5mNxiUv1lsB8M
         RtAYoKwJ5788ZWIbt2CO7LX7jwuf3GwFCrHCuHSzVTBgOu+EjZdovVGO1rU1iIZxSYRv
         E1S3F/q9hdVWMN2Ec/Kkjp0lMLVOVYh9UckiB0zbUagl9b8pkyPy9l4DbdJCQVtjTZXa
         AVHRMQ5OKTHKs5kmSAqvlICQuKbWcVMW74RRGDFmFA/5i3D8Vj6uXmFdtiYcRtn8KVZH
         Lv5mFXaGecLbAqXPt51LC9q6Zdjvm65BOy2zQOkXnqRAW4AMh2+Tae7oLADbSyDz08kd
         3hpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773734398; x=1774339198; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Of4mEBm0klTx9gd6BL+m6euSejqZNMnXy8ZsfN0BJY=;
        b=mF3INkj/XwvmMAQIImL+YPospp6thKXcvg5HXIYbBU9GUXMtplaV85QXq7/3COM5iH
         BmT5oIbNr+FpyUqfTX1bQ36wdIvA39rl3uCjTF8sxTKXCenHRMQq+B67E0VwgKZr3MdU
         aCrN5X9XWscwczk0V2F+EmNtruNeky1u+f1FkqAFwzZP9KVj15pJeGZdMhhTSTtCRHO7
         +qJRrqUSDEJeew8Pedx0CyFWCDjQsIYD1LYfAvwaol+uT78NdFEEhIvtr8rH285TlF+Z
         ZRrn1fNEe6Aa4JUY/7GxX3lp/FF1WzPi3Py4B8ZHeF7j7OTYJbI27H/4BCcv0BORu4u/
         o7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773734398; x=1774339198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Of4mEBm0klTx9gd6BL+m6euSejqZNMnXy8ZsfN0BJY=;
        b=jbLBq/9yFyLrLDxB46aKV8kxkryvP1uwVPc9o5XA8Q9Zg1g8BmS2fxzy4IswkL/hDa
         yM6i0Or01AucExGexZz5qOUDCePN/JCyjrPLgF+4BcvCeRfTxehdGlqPHah/0Bc6r0xt
         qf+I14jfQFOh9OQJQH+qTzZASNNRdYwRQcWLSIAO7ljAD884n/WOqkhmnAnbsh/VYDdm
         XlCAnKM6Y6Oqbya7CxjsiyhtwwXj4Cm4Zq/GDmz8WH22dgq+7CBkWCO2EQvmoQQNc+n5
         KnsVa+ioNHz+tkEOqRzYhErfQEP6p6RFXxW5wCsExTiuYOm2mlQGzfLRWE+qXQpaflCl
         IfHw==
X-Forwarded-Encrypted: i=1; AJvYcCUw6Ivbs3ObqA5vWt0fMO3fTk+fEZXPLy79Y62bZkD6uYogayEcq0Kqa4wHTtbJdL8JEUwOgHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTDqF+FWA3IZUmFKTaKh5QK5E3OQtBsZ+Cr95071p0iMWgmtzw
	RVPzTtPnuU1dIB8MGtxv3Cfr5iMwWQgLu5n40RkARU7omn4AgfBt/Nw/ZJYKCSk+0F3jQUX+4LV
	4PozFVW2fDrb3yf35LtSE2kt3KCbbSM4=
X-Gm-Gg: ATEYQzxXNfdy9bkwKpUsi0/CABO7purtks+OnNp5J/qDAA3FfucA8xqmF/VN3jt7R4Y
	DbX+1jHFJSS4GgsrJIUkA+t5sY8y80CowEEvyCuAtTo165AsoT/8H1KYB89vPvYOoy0xqwMWnpT
	ipgELffvWTZcIg0YNAKf24q371Xh5vRcld99Oq5PuFpRP3YB8D7it+Pcn6PLQnWG0pJxSCz0w1+
	scq/nzpxd4srjDDPrCYoTzbI8hpiVyk4/4a3ZZONz84bcMOA/CAryWYeXA1+t3z7111aJJbZHTL
	RriIUA==
X-Received: by 2002:a17:906:c147:b0:b97:b3bc:f6ba with SMTP id
 a640c23a62f3a-b97b3bd4c6fmr434045666b.39.1773734397417; Tue, 17 Mar 2026
 00:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317061700.7734-1-linux.amoon@gmail.com> <c630aa45-0904-4b3c-a1f6-90b167741d27@gmail.com>
In-Reply-To: <c630aa45-0904-4b3c-a1f6-90b167741d27@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 17 Mar 2026 13:29:41 +0530
X-Gm-Features: AaiRm50SMElS2U9jvvuNMjfJ7e6UCMF-amgrAlbybWWI_RLjfkacjBtkFPNesUc
Message-ID: <CANAwSgTG53wD+z8KBVs4e-n4za-f3xXZELRu6c61SV2Z+4dwMA@mail.gmail.com>
Subject: Re: [PATCH next v1] r8169: Fix PHY lookup for mdiobus_get_phy() and
 improve error reporting during probe
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "maintainer:8169 10/100/1000 GIGABIT ETHERNET DRIVER" <nic_swsd@realtek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>, 
	"open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268478-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxamoon@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rock-chips.com,163.com,vger.kernel.org,arm.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 389552A53F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Heiner,

Thanks for your review comments.

On Tue, 17 Mar 2026 at 12:21, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 17.03.2026 07:16, Anand Moon wrote:
> > The driver currently assumes the PHY is always at address 0. On some
> > hardware or buggy BIOS implementations, the PHY may reside at a
> > different address on the MDIO bus. Update r8169_mdio_register()
> > to scan the bus for the first available PHY instead of hardcoding
> > address 0.
>
> No. The PHY always shows up at (virtual) address 0, due to the
> MAC register based way of accessing the internal PHY.
> Do you have any concrete example of such a "hardware or buggy bios"?
>
Sorry about that, I didn't realize. Unfortunately, my testing shows
this still doesn't
fix the problem, but I still perceive. I modeled the change after some
other drivers,
but clearly, that approach isn't working in this case.
> >
> > Additionally, switch to dev_err_probe() in the main probe path to
> > provide standardized error handling and cleaner log output for
> > registration failures.
> >
> > Link: https://lore.kernel.org/all/87bc37ee-234c-4568-b72e-955c130a6838@arm.com/
> > Fixes: ec392abc9593 ("PCI: dw-rockchip: Enable async probe by default")
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/net/ethernet/realtek/r8169_main.c | 34 ++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > index 791277e750ba..0fd735beff92 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -5427,7 +5427,8 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
> >  {
> >       struct pci_dev *pdev = tp->pci_dev;
> >       struct mii_bus *new_bus;
> > -     int ret;
> > +     struct phy_device *phydev;
> > +     int ret, addr;
> >
> >       /* On some boards with this chip version the BIOS is buggy and misses
> >        * to reset the PHY page selector. This results in the PHY ID read
> > @@ -5462,18 +5463,31 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
> >       if (ret)
> >               return ret;
> >
> > -     tp->phydev = mdiobus_get_phy(new_bus, 0);
> > -     if (!tp->phydev) {
> > +     /* find the first (lowest address) PHY on the current MAC's MII bus */
> > +     for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
> > +             struct phy_device *tmp = mdiobus_get_phy(new_bus, addr);
> > +
> > +             if (tmp) {
> > +                     phydev = tmp;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     if (!phydev) {
> > +             dev_err(&pdev->dev, "no PHY found on bus\n");
> >               return -ENODEV;
> > -     } else if (!tp->phydev->drv) {
> > -             /* Most chip versions fail with the genphy driver.
> > -              * Therefore ensure that the dedicated PHY driver is loaded.
> > -              */
>
> This check is needed. It's seems your actual intention is something completely
> different from what you state in the commit message. You try to find a workaround
> for the issues with request_module() from async contect, caused by the referenced
> change to Rockchip PCI.
That makes sense, sorry for the noise.

What are your thoughts on using dev_err_probe() for these registration failures?
I thought it might clean up the error path.

Thanks
-Anand
>
> > +     }
> > +
> > +     /* Most chip versions fail with the genphy driver.
> > +      * Therefore ensure that the dedicated PHY driver is loaded.
> > +      */
> > +     if (!phydev->drv) {
> >               dev_err(&pdev->dev, "no dedicated PHY driver found for PHY ID 0x%08x, maybe realtek.ko needs to be added to initramfs?\n",
> > -                     tp->phydev->phy_id);
> > +                     phydev->phy_id);
> >               return -EUNATCH;
> >       }
> >
> > +     tp->phydev = phydev;
> >       tp->phydev->mac_managed_pm = true;
> >       if (rtl_supports_eee(tp))
> >               phy_support_eee(tp->phydev);
> > @@ -5790,11 +5804,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >
> >       rc = r8169_mdio_register(tp);
> >       if (rc)
> > -             return rc;
> > +             return dev_err_probe(&pdev->dev, rc, "mdio register failure\n");
> >
> >       rc = register_netdev(dev);
> >       if (rc)
> > -             return rc;
> > +             return dev_err_probe(&pdev->dev, rc, "register newdev failure\n");
> >
> >       if (IS_ENABLED(CONFIG_R8169_LEDS)) {
> >               if (rtl_is_8125(tp))
> >
> > base-commit: 95c541ddfb0815a0ea8477af778bb13bb075079a
>

