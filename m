Return-Path: <netdev+bounces-253876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEgCMEnBeGn6sgEAu9opvQ
	(envelope-from <netdev+bounces-253876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:44:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B157950D9
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4729309FC04
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F553596F3;
	Tue, 27 Jan 2026 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZodmSZzS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8C3590DE
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521199; cv=pass; b=gG8KvuOoLnhGGpeJaZFf/h65J276VxnfdQgbyKLyrw2xcus2xd/Thv+4CH4EdPzhL1ugGg99iF6Jof01VJw4jhvpS5fpRTSwfrS9b6g42rBTg6Ik3GhjiYkqXH6YRJFFWoRN30lykZ7L1my5nGHyGz4oRwU+7vgodxicRHcGj3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521199; c=relaxed/simple;
	bh=NmJ64+sVhRlTVy+n9tWimJPXuaBxwQ0/c9YnNJraOrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmNDN15G6ULj6o36fkkeqy/0qPgmZTocSzpLjmiWpMtU/B43Bw068OaDpd2nyepFJahBZXs38FCr+tdVUHS8QA0osnXNSD0/JqqZrK+78dr/JfUkoQYl1ZWwgmn0zNxMJiPg5bPzIhvGD4fGbdA8cRqoLSmAgUUB4ALEOw+d41g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZodmSZzS; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so5780313f8f.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 05:39:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769521196; cv=none;
        d=google.com; s=arc-20240605;
        b=ITi9b3KiYJRgjhoUvVhA8hnC/XikJ8MpbVHEIH+unTfucIjAgZ7Tb7P4zAmjEu5phW
         jGbwPf4sw5TOLD6WBRf0mU5v2PJBJa23UV4qWQ2Mr6/qxFKPpEcxhKgDXaWIshyGzyuz
         RHEMqs7Ezb0c9ZE48Csh1G9VncYgueKp12JErftOu5mBQPT+iAZbtMuY0KgNwLjYlJhB
         gVSRxbJKj9qh5FKTXoyjzJLUGnqZQjhdk/E4U8xddLJDJx+9MLEzZgVlYEYHhSf+2spm
         Njoq1uVuhTeI0MQBkJlC2Po1BFlyDCOyB5eTOF/Hhq57Yr5g3/mlXH2LrU9+hIM5KwpD
         MpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IlR/WA7RxT5C3CkoKZj7WZ73vofWrh2up1KlQooa0gk=;
        fh=hFXwb3kKEWfCwNDbptwAirBjSZ7HduAxhNcnXzFSbFc=;
        b=f42OUOkI+K/5NVKdQRMby0RNkrn3mZHPnoJwS28KnLFG8bl01vEpLefRU79YNZE3kf
         QwcFWBLfaVjBsYPTH4tEciqeHb/0ssHrtDzjGWk44iXfhhCrFeLjdh3zSwT0JmyF7kC4
         //i3eW34RCpyOQSev6NDgUS3+WezX4x1Qs2iuLId6IYJZezY+zs/89OWEqBF3VyRWZ59
         0Mt17vTBo0MEkkJ6k6Nq0U7WnCpTV+rr8Lu4RI7dYvgQMan6+UJJVnTm8DrwotK0PYhI
         hsulkn6kZedYfSb5Qob0HVOjl0beucsd+oHUymrWMKzTS51cDGO01aWxbfPL3EJqtIic
         aL1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769521196; x=1770125996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlR/WA7RxT5C3CkoKZj7WZ73vofWrh2up1KlQooa0gk=;
        b=ZodmSZzSDYtfDQJ/jQ3DpEwSD+iD72VXGhwhrYczJwLOXuECKPJjTMZwNzxS6peDM1
         16svGQOUZbXze8r+g9Yc1VupRRYt/mk0vxyilxggtF/S9pydvqxNJX7V5us8s9TvLt51
         dTxCICmwGwjdL5mqFQJYRZR2Fl6pzo5CyFlH5iPcGz/BUsWv70xhtwX9lcdzw7kyu0Dt
         tf+g5r32mwYmQIF/VchhD53vXUakjA424uOGuveu51N1/AaFF5CjYmLvP2xXB5lOHqY7
         /YWuyJXl/mhDfU/Kd8/2juVoeuajX5qpq2DMoZELMs9ywji+lkCd7o6C/IKktUAOdMT6
         8MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769521196; x=1770125996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IlR/WA7RxT5C3CkoKZj7WZ73vofWrh2up1KlQooa0gk=;
        b=EGajHvZBX4ihCpoNvpKKg1Omel9J8mV1QDejqOV3ph77vusd9GfV+IFMK/71y1Iqce
         mxzM6zYEjmoI13gLjKe3XbRFJA66AibYD8IttACnLyJPt+8esBsfUWjgTjObEbyED8R0
         61e1A5jxVKmYaLUNxJc0QDBjr0T3GGI2Mjbsn/v6RSQJ9J2Tl0Voo7jIi5ooRVfo0zNo
         fw0htdOSRvDfzO+x0hVxsmJNxhaGHUPC9yeQy+usvV9dxcorqh6W019LkLhm51JIiv7K
         2DfJ8vv24mJAs+Su7Ip8bWwnP21PO+kaX8B/SgVrz8J8X7/+byl0SLKyjp8boncbIWru
         Gu2g==
X-Forwarded-Encrypted: i=1; AJvYcCVsk/DQFXN61WOdB4nM+2ci9NfRihBboB3AdZ9Ay5KYKEDCGYysFBRzQARFw7FYRDjir79ttC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0VHOUXgXkREW1qDLaMIiepNdl0nLBEcnYUw2NOcNWf9YEi67x
	et5mIfb0QtoYeQ+cG4RzCDSGFkWpJ0h1PJZdIvamyUAmjmkH0DYTGSERiczodFkHu2mgughWli/
	3pSHk/Z2CRPkRmolIxqCrMq7gqc32R6Y=
X-Gm-Gg: AZuq6aJUsyNKM8BoKnA9Q5yJc/9WAdXiU+8MJGscxuGpz7mQ3skv4RnXQw3q5RRoFDa
	ZxjPqOdUC4oAYRCJTgJ2TgBIjti47TcGfqOV8g6pge7eVbwhIN+n/DOqicKmQ8XED3szWwYUIE3
	PSMio2M/pnU35B+RlNOJvS//vklL4eWC/iS82U/Mgm9ppUh6/Q+BxeiFXn1ZD5yYnH7QTzVWvHN
	toZ+80Se04nNQRjWiLj21zpNW9uKWmXJ/zHl4Bxq3dSB1njLwuJckKn80B/1yVLQXBTPDqy6ttc
	glzSwrMeLWzEmL3uffp0DuiWa9+g7Um4664f67lp5e9czP8i6xOeJdjtHQ==
X-Received: by 2002:a05:6000:26c7:b0:435:9691:d525 with SMTP id
 ffacd0b85a97d-435dd02bd66mr2596133f8f.13.1769521195749; Tue, 27 Jan 2026
 05:39:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126172503.238724-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <aXeuR_YLoAFYEAVi@shell.armlinux.org.uk>
In-Reply-To: <aXeuR_YLoAFYEAVi@shell.armlinux.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 27 Jan 2026 13:39:29 +0000
X-Gm-Features: AZwV_Qi7ONuSH5cnoHQEqydQB-V8V2QfAv3cVDqg-9__qb79RGS2Oo_Iqp8eszA
Message-ID: <CA+V-a8t5RKY9vyFDg0V3AWcBovBdWbcvqdPeiPYmHRA8v2=UGQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: stmmac: Preserve bootloader MAC address
 across unconditional reset
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253876-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,pengutronix.de,glider.be,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,bp.renesas.com,renesas.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	SURBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prabhakarcsengg@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,renesas];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 5B157950D9
X-Rspamd-Action: no action

Hi Russell,

On Mon, Jan 26, 2026 at 6:11=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 26, 2026 at 05:25:03PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Commit 90f522a20e3d1 ("NET: dwmac: Make dwmac reset unconditional")
> > asserts a reset in probe when a reset controller is present. This reset
> > clears the MAC address registers, so a valid address programmed by the
> > bootloader gets lost and the driver falls back to a random address.
> >
> > Read the MAC address from the hardware registers before resetting the
> > hardware. Keep the existing address selection logic when no valid
> > address is found, and program the selected address back into the MAC
> > after probe so it remains consistent in hardware.
> >
> > Export stmmac_bus_clks_config() so the early read path can enable the
> > bus clocks before accessing the MAC registers.
>
> I don't think this is a good idea. stmmac_bus_clks_config() is specific
> to using platform devices, but the core stmmac driver also supports
> PCI that doesn't use stmmac_bus_clks_config().
>
> stmmac_bus_clks_config() handles:
>
>  - plat_dat->stmmac_clk
>  - plat_dat->pclk
>  - any clock handled by the plat_dat->clks_config() method
>
> For platform devices, stmmac_probe_config_dt() gets these two clocks
> from DT, and prepares and enables them both. So, by the time the
> probe function is called, these clocks are already running.
>
> For those handled by the platform glue, the glues that populate
> this function:
>
> eic7700: eic7700_clks_config() - this is called from the init/exit
> handlers. Will be invoked to enable the clocks by stmmac_dvr_probe().
>
> imx: imx_dwmac_clks_config() - called by imx_dwmac_probe() to enable
> clocks prior to stmmac_dvr_probe() being invoked.
>
> mediaktek: mediatek_dwmac_clks_config() - called by
> mediatek_dwmac_probe() to enable clocks prior to stmmac_dvr_probe()
> being invoked.
>
> qcom-ethqos: ethqos_clks_config() - called by qcom_ethqos_probe() to
> enable clocks prior to stmmac_dvr_probe() being invoked.
>
> So, I can confidently say that all clocks should be running by the
> time __stmmac_dvr_probe() is called, and thus there should be no
> requirement to call stmmac_bus_clks_config() in this code.
>
Agreed.

>
> The next problem: you place this code to read registers from stmmac
> before:
>
>         ret =3D reset_control_deassert(priv->plat->stmmac_ahb_rst);
>
> Sadly, the binding documentation is too vague to pin down what this
> is, as dwmac can have AHB master (which generates bus cycles for
> accessing memory) and AHB slave (which would be the target for
> register accesses) interfaces.
>
> The problem here is that if some platform glue has wired this reset
> such that it resets the AHB slave side, that will prevent register
> access, and thus your attempt to read the MAC across all devices
> will fail.
>
Ok, got you.

>
> The next question that comes up is that we have a perfectly good way
> that's been around for years to pass a MAC address from the boot
> loader into the kernel for any network interface. I notice that it
> isn't mentioned in the DT bindings, presumably to prevent people
> from adding it to their in-kernel DT files.
>
>         mac-address =3D
>         local-mac-address =3D
>
> The old documentation in ethernet.txt was:
>
> - mac-address: array of 6 bytes, specifies the MAC address that was last =
used by
>   the boot program; should be used in cases where the MAC address assigne=
d to
>   the device by the boot program is different from the "local-mac-address=
"
>   property;
> - local-mac-address: array of 6 bytes, specifies the MAC address that was
>   assigned to the network device;
>
> Given that these are interfaces between the boot loader and the kernel,
> they can't be deprecated, as platforms will rely upon these properties
> to pass the MAC address from the boot loader to the kernel. For example
> on one of my systems:
>
> $ vdir /sys/class/net/eth0/of_node/
> total 0
> -r--r--r-- 1 root root  4 Jan 26 18:08 gop-port-id
> -r--r--r-- 1 root root 50 Jan 26 18:08 interrupt-names
> -r--r--r-- 1 root root 80 Jan 26 18:08 interrupts
> -r--r--r-- 1 root root  6 Jan 26 18:08 local-mac-address
> -r--r--r-- 1 root root 14 Jan 26 18:08 name
> -r--r--r-- 1 root root  4 Jan 26 18:08 phy
> -r--r--r-- 1 root root 10 Jan 26 18:08 phy-mode
> -r--r--r-- 1 root root  8 Jan 26 18:08 phys
> -r--r--r-- 1 root root  4 Jan 26 18:08 port-id
> -r--r--r-- 1 root root  4 Jan 26 18:08 reg
> -r--r--r-- 1 root root  5 Jan 26 18:08 status
>
> where "local-mac-address" states the MAC address to be used for eth0,
> as specified by the boot loader.
>
Thanks for the pointer, I will use the above-mentioned method with
which we won't be needing this patch on the RZ/T2H platform.

> I don't think stmmac needs this extra complication provided platforms
> make use of mechanisms that already exist... and I feel it's time to
> start saying no to platform specific quirks that can be handled by
> those mechanisms.
>
Ok.

Cheers,
Prabhakar

