Return-Path: <netdev+bounces-284528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NUfGugo+mngKQMAu9opvQ
	(envelope-from <netdev+bounces-284528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:29:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C6F4D2027
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D15C3024194
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427B949552B;
	Tue,  5 May 2026 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qnp8rAlf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8948C8B6
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002148; cv=pass; b=OUV8G24khWnejR3RoVBZV0IRPwlMdeb2fFW4hVrn3kSAoMRn7X6f7vBLLmF6QepOf3zeq3lTCFaUVcSLL9aJdij74E6CPiZblMgJsjDi96HxUNl2qYv93Jc9mQr++wa/IR30mKBz7V6vwwMatLCT4y/SND9NRxR3d26I+wqeU/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002148; c=relaxed/simple;
	bh=O+ouXHklwduLzd+OIS3sXBJKvCNsTl97Al83paj9CqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peLVNcipwvHigMoRdUkLg+OzWTvnN4UNyoX+439ZuKzDdxrRRhWTGTf+ZyKhz75TVOOHfrk/b5JKGi7GPAzeqqEDlzTAH4+9jo5luNMP7iK0bZUW0+/yUpnuyQs3ZA93DWJHv0K+Xb3REjmQXE+A77c08FCf02K8LUhxsQTjk9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qnp8rAlf; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso10095ad.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778002146; cv=none;
        d=google.com; s=arc-20240605;
        b=Wz/yvD2gpFnPKHUGjMn+mZOJuilmbadvWS044FcV/nem2UCIUGMKN/POR71fhN7v89
         12f5gvKKM315NBAo4G5ACAN5RmNG7MeQ2u8JCJo/tLqsRqyWKJIfKpek14iAlUEm2TGt
         +Nhnaj9+bbSOaujl8VUydBWyg8Myf6X2H+kV/B1xpL9a0SC0j261bbyAhWuaEzq4J3mk
         ab8sgsCKpwjs6DqTG4KFYAbLL5eEv3jAz+thJn8cY4lpJpAnA9rMrbVps8q/+3tNri2N
         DXeK11a5TBwKltJHxtPsi0Yt35ml3+FW27gvbMX5gWlCemmvousYUFGrVcp+EDtazrPA
         7qrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tAOxeUxRTJJUrDrO8Q1IkxA4oqPbC+uVXvub7yRfbus=;
        fh=sNBTMK18oyiHji52sktZB26jRBOD8gfiRw/TCN0Nuos=;
        b=hLaQLHV8MIXJVagHQ6gytJ7NEGSbl5keGbE1PlVeOV4T1fCbKlj8B6Tkafc3DSNCCv
         FNdDn9KUklhM8qyg81QWoxnhCoUCndiB/djuVow7ugJCEgAYcbYGat/tPw5msdQPX4YJ
         sCoqeUwBMLEEbwk/i+UgVbP+M7ENYk6acvf/MQOosHMa+ZGINreT70gOUwIlYsT8bn88
         SCulubfAKnUeMrlm1kWEZFlW5ciTBNlEchNxhVciqn00IAHYtLV8q7E6AZuo+s46Gasf
         jOF2m7dXbTZovwe5lL1JvqNgY+P0Yx16fGHaQSYXC97mSvUJXV5uOYs2b4Z7iq0Ke434
         /fXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778002146; x=1778606946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAOxeUxRTJJUrDrO8Q1IkxA4oqPbC+uVXvub7yRfbus=;
        b=qnp8rAlf2NddrSt01FEokADgKOLsYvbhBb/Ay4hQcdXTf+qdTnuZq17MqKuqOJu7Gu
         z+4xIaRN9rGNnqLvPLQ4GIctRk2ARpptIdRubHpADFXuKxAuW/7GA06CyElOpK2RgyoN
         8wFqXxYpwTAbQuK8r8nkxHAXmaDaQbnXMv/sm4805ApHVrbx1r7ZG1V1y1s2D+Y4HkGX
         DV7M4a7hyPQSHElIdUhyvB+ma17z0NJALdPhXLWbnr0Kw32f3ID5DlUWQMMow134QKpB
         NiTfaI1kmO/xqPftnzxYyv+3WCXWjSF0MAzSMm7SbMHmxwU9fiDq7Xnm+ydIcM1jdgu5
         929w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002146; x=1778606946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAOxeUxRTJJUrDrO8Q1IkxA4oqPbC+uVXvub7yRfbus=;
        b=tQo+Zou7W19ghGIxheuQTIB0wDtlvwiSmPF8Jnxavgpf+6AiVeeWEYuIDLhE6oVdVb
         a0fPUa+J9J5E2Y0uQDsc5QVoyNCghPmVJ9CZB72lAqqt3VS7Qhbs2dtcL0j8tl16gi0X
         NxXIJrIsOw6x+yj8/xDPBRHqBij0JxV5LdrIB6IAN/HZ85ufMrCm7JIfoh32SnBW7rIu
         7fOxH91sVEE3ZaRUv62J5nQ6FrRsCbtIYFxSRzA7j9I8Jt/sfQA00eZoOP/NXTChUxJ0
         1je/NArBKKaqHM/2A/bZMFaM3GGJxcPSYMXqiqReK7Iju/9pI7OTk9tU46OEH0GQSsPr
         jFow==
X-Forwarded-Encrypted: i=1; AFNElJ+VjYNSl2J/F8QxRyVdGfxvDifXIQqgM117LZsiez49UkbapqVz/Y793qZo8JjcdLVqcUTEOcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95UjUMr5NtcPkt/4eTTefbC4YtLCu/RaEwl5BbNT7CJPDJdfQ
	n+SL3yVgpCih2VdgROHm4+viuCcDDAHqxNkSFVYxwDvALdggHKeUPJdIVQCuc8hgel8KWFShrbg
	5UxlqQ8/vQRpE8SLJNTmdYBgpxqmi0M+wRg18fSgfuUaRYoOjb9KmKodb+Y0vCg==
X-Gm-Gg: AeBDietCLzkHdWhibdM9bDi2/2q7KwbexL96XAjvUy7H1ez1TKe1Jd5/Cc9zHv9e9oD
	TcWpR+f5xJTvW/0+waZwuhVcxI3efyow8KhJ7e03vJkDdgIFj0NDryaBE4VXdh3GxqApbe4PDkA
	PAzgjYF9o+SFvgEamG6lhsxSBJ1X/JSMPbqY8f1OgIxixsOKuKKpkKJ2eJWOEU86RjUTVlpgBTt
	wFTCvGNetgEmlW5mOIInJITSp9g3LcLzpIrIX5Ib96q+o9+VHi+Ne3nBnv6LQ0Ncw6qCAHQlQ+G
	6Hd8jfjGUTXggD0BoXUJoPiSx3JdzFef1TVfRqYFZe7i+ONT3SUGsw7frHlMIovLz29EHSUiXG5
	4VRFSsLB69QVGlNvHnMCTIJWr0ys=
X-Received: by 2002:a17:903:2903:b0:2ba:4749:c9a2 with SMTP id
 d9443c01a7336-2ba779ddce1mr166985ad.2.1778002145608; Tue, 05 May 2026
 10:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504182139.604925-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20260504182139.604925-1-vaibhavgupta40@gmail.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 5 May 2026 10:28:54 -0700
X-Gm-Features: AVHnY4IIpUobX4WgkwjAx44akJd-kVQodyOmu8Zf9l9YJfQgTc6P0osBAL2bz4c
Message-ID: <CAEAWyHf3x=sCefMKkUvRq6hq8qd_ALM=MPvnN57xmyE5VCN+CA@mail.gmail.com>
Subject: Re: [PATCH v1] gve: Use generic power management
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Ankit Garg <nktgrg@google.com>, 
	Tim Hostetler <thostet@google.com>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
	John Fraker <jfraker@google.com>, Matt Olson <maolson@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D0C6F4D2027
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284528-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, May 4, 2026 at 11:21=E2=80=AFAM Vaibhav Gupta <vaibhavgupta40@gmail=
.com> wrote:
>
> Switch to the generic power management and remove the usage of legacy
> (pci_driver) hooks.
>
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 424d973c97f2..b7bac6bf89e2 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2967,9 +2967,9 @@ static void gve_shutdown(struct pci_dev *pdev)
>         rtnl_unlock();
>  }
>
> -#ifdef CONFIG_PM
> -static int gve_suspend(struct pci_dev *pdev, pm_message_t state)
> +static int gve_suspend(struct device *dev)
>  {
> +       struct pci_dev *pdev =3D to_pci_dev(dev);
>         struct net_device *netdev =3D pci_get_drvdata(pdev);
>         struct gve_priv *priv =3D netdev_priv(netdev);
>         bool was_up =3D netif_running(priv->dev);
> @@ -2990,8 +2990,9 @@ static int gve_suspend(struct pci_dev *pdev, pm_mes=
sage_t state)
>         return 0;
>  }
>
> -static int gve_resume(struct pci_dev *pdev)
> +static int gve_resume(struct device *dev)
>  {
> +       struct pci_dev *pdev =3D to_pci_dev(dev);
>         struct net_device *netdev =3D pci_get_drvdata(pdev);
>         struct gve_priv *priv =3D netdev_priv(netdev);
>         int err;
> @@ -3004,7 +3005,8 @@ static int gve_resume(struct pci_dev *pdev)
>         rtnl_unlock();
>         return err;
>  }
> -#endif /* CONFIG_PM */
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(gve_pm_ops, gve_suspend, gve_resume);
>
>  static const struct pci_device_id gve_id_table[] =3D {
>         { PCI_DEVICE(PCI_VENDOR_ID_GOOGLE, PCI_DEV_ID_GVNIC) },
> @@ -3017,10 +3019,7 @@ static struct pci_driver gve_driver =3D {
>         .probe          =3D gve_probe,
>         .remove         =3D gve_remove,
>         .shutdown       =3D gve_shutdown,
> -#ifdef CONFIG_PM
> -       .suspend        =3D gve_suspend,
> -       .resume         =3D gve_resume,
> -#endif
> +       .driver.pm      =3D &gve_pm_ops,

Thanks for the patch! A minor suggestion: could you wrap this in pm_sleep_p=
tr()?

Also, please include the net-next prefix in the subject line when posting v=
2.

With those changes, feel free to add:
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

Thanks,
Harshitha

>  };
>
>  module_pci_driver(gve_driver);

> --
> 2.53.0
>

