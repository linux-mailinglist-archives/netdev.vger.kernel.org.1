Return-Path: <netdev+bounces-274669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s19lCuq/zmmqpwYAu9opvQ
	(envelope-from <netdev+bounces-274669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:13:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 736A638D92D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 21:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DEA93014C3E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7033D9DA0;
	Thu,  2 Apr 2026 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpYatVaY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E329B224
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157219; cv=pass; b=KDVo6zXN27UP4YM8HLtKnxxdtvqgB33acoj1z0njt6y5gJ45ZK2RDog4OSX5JqEyN/nawZLwKelBPXg0k9LUEpWxGFOev94DY3dC2hqFpYoBKO5dzYTTPz8QkhFfKKUOdXRfN3925v+Nj8AETEMXAt/S518RkNsshU2evQSQwpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157219; c=relaxed/simple;
	bh=kbdroWpZEMKTTAqDWbBammpetQN187fleojAyiGM9/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pq9WLlUgZPLp/Dw8tkwCkfGDT19p+soTSJ03OgdL3l3DjCgyjDiGCQoVt+gJ2GoqKsTUiMXGcmzos487E6yXyxCkzlTVdU+Lk/HMXxm4akq7aQdinPlSozMBJg9+rWbMCQg5cvqnPOzN7vpSogo62LM4U4aqs+88WEL4PhIBHCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TpYatVaY; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6501725d888so1040559d50.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 12:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775157217; cv=none;
        d=google.com; s=arc-20240605;
        b=eNu34unS+YzRWVn6G6x1v079nA9Vfdvq5adxrh2rMqoKem+gpbwZOFBASlOhxnCoud
         T44Beu+lo84KXBttVHFh+L4a/RxiPUVhqZgrs6rHHwKOU7UFVNdBO+iKGsaeAEtdvfUr
         TDgNp9A4DV7MzG2ke96E+J987kbz/BlahNfwLAaA1kR7qPogeU8DgiqrGU1hqT4GmP61
         fwn5lxkHRUOIQwRW8pI9Al3/24HJfEU1sxRasNlCVbUDM9bIyXZ2gV3kOdHIf8/gWa6O
         TiakyVbA2EFQz7q7EYSZckOBSjH5LGulXmU15oyqwQYorlc9WDTER/mZpeP60UQ+GQhU
         rzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DTIBlLEpNAQHphhX4QRSQjCX/tO4T/H0V6TBXe0t2+c=;
        fh=p78vUy2fJDkcS2s8euRBMg097jB5aVw5sqwbTIhWv1E=;
        b=RCo74Zf9Gxf9ID5D41tP3lvfhS0ONDT6tXjZvrDLnjoALIo1uqo4kDUUkNqVuu+A2z
         RiRCyx51N15f5SuScABKcjHXb5bgstKBwC16qHnf2aydFrwbpDw/mpTL3BINvmcxGrIp
         0xkyH1sQEgOVXcCeIdYT5hZ+RZH03v1scpPF333q7RicoWQ2zI5rdxeyPoIZuYorv21b
         XH/BnkNY1gBo6CY4z6A9IgNCG+SOiVyhFkhtmyIhUgbHczMm/I79SerMWt2on3ksfYQ/
         gzujO43PWLLGpSXQKGFbtqX7MoPYrdokn130PH7ya3fg+I7hCe/FMt+OvXcBQtiuIlG3
         i2LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775157217; x=1775762017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DTIBlLEpNAQHphhX4QRSQjCX/tO4T/H0V6TBXe0t2+c=;
        b=TpYatVaYkkQeIEdZCcGBDTWfoKuHi2HXU6TqpIt7ml8i5SOtJK1FWg0fOdGSVEU87s
         RRChXnic9ctQ6IZY53FxXZgajBsHs7tOycL6KRAQBqkmXn3qOkOgfJuZezx/He1S5h1U
         /O8aWJNPU3y8dE4/VrWSG4aPIs9lp5Hhr0FTT3SRVRr6RvXj9rY/i+fE10F1VwH4WfdL
         w9kUxJhm59bSqWHu/ek92WupZC1x0ILc7GHdkk8Bc+7P8fj7oAPGr5Mx66/wXNb+dtax
         5+BkDdfMd48QaAYT6lK3Kveu9C56pkqljzerxMuSkrVQ+fOxbCd1eUMhLAS/WUvFPQa/
         gbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775157217; x=1775762017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTIBlLEpNAQHphhX4QRSQjCX/tO4T/H0V6TBXe0t2+c=;
        b=kHPy4wVYxa8rAOycptGM+IpO5ta7kNBGYEDVJytgoszx33PcAxUIhgarGZ2L3h3HLu
         YGUNVhZllsYfOa+wxXhotNkjx0p/+EknsII6zMsNEXDmlGQh1iKu5pnd9RAxZZG81tin
         V5mjSpxBJ1htCxH01MEZ1GAD8lxps/cIIvMhEL9bB96oLV3DdItGXOGv+hV/jciI8jDu
         +AIOVK9pa25gpNJI+yYg33vIFZ+B8x9Mf9+wHhobJ/8NdLLQ2Lg6Z1C8m6sZUzlRng5e
         8ioJbzRdRuBEt5L3MoQExdxvQUlkLL1m69zDpfTFHGG+908Fpl+b2nh9EqMM/8rgAEex
         R87A==
X-Gm-Message-State: AOJu0YwLWv2zPkwQ+kuoLd9+EfR0qHIqaSlXfak5XX8b3xAd3W/+Z/IY
	LmB70JOd/EWOTilelxnIBlI9cMP7fMSWesGt+m2jKWvUqrQzh2b4oxcDRlv0lhRQE14dBD6jXqU
	d2v0vnPaYfn82xbFGHJPchsofrUL6Vtc58/UpqvGCrw==
X-Gm-Gg: AeBDieuSZOPQw0OC8abCpBka/v9ggZ/pmOuEcbZGkI+Bm44MaJQ2nfs2cUI35Cuj+5o
	ptdLu+s2UnJ7f1F1AoLl7yz+/jzWZk8vLIAP4c5dC33MPgc3megrt07UT9OluVnWnFu1xoduo+d
	UsZMkdeXWjA1oFVvhL7fyvhwoy1HnqIz04WnLSPthf1ZiiTFM5q+Vv/Rri368GztoCukZR8pkiX
	h04Yei4+vhg4E+52PV7ZOu0UisLZPtnA0sU2STrgJSaDNkl9t1iilMHboYpeoE+Cb25d19yu/d0
	AewhcKrlJRJtc2FWKINRnAo1R8u5sJUYymGmfxaHngYwQ/4n1uzDML2Ce0GzLU7ZOjUM7tDij9X
	7337L9Q6E15X4A8AVIXbp/u/o9EFsGjhjtf/WkiDQJyIMGTPD4VgGSjEew2S62zWk6My5cofE9A
	IUWE1cChtXOIkhUUqy2DxXkdNRENQ7l+haNtyTswhrHSRNlD+h4ePUs39eEVnZd8GmtEqhwTF/8
	RvTwzYGbTeyBh/hVHEPB/qOAfIuxQt9Bt41R2A8I8lcXa+NCbF9ycj9GE28WJ7sB2pkg7lzGHDn
	VXWiA/VYRYHwEz3xEaIXHEUE/VgM+REi2RFtw4mLPrE=
X-Received: by 2002:a05:690e:4142:b0:650:367f:7f3f with SMTP id
 956f58d0204a3-6504885f0a0mr104144d50.50.1775157217199; Thu, 02 Apr 2026
 12:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402184726.3746487-1-arnd@kernel.org>
In-Reply-To: <20260402184726.3746487-1-arnd@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Apr 2026 22:13:00 +0300
X-Gm-Features: AQROBzCYBRGvnozxFzTvK5IcNSvZvT_9cSUVFQZZjVD30n0NBtqh91pIYRAmGH0
Message-ID: <CAC_iWj+vjZ0WnKUuqeFfaPeSoj5ovxZiEmUD5R8hPsRfkqMihQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] [v4, net-next] net: ethernet: ti-cpsw:: rename
 soft_reset() function
To: Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Grygorii Strashko <grygorii.strashko@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, linux-omap@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Kevin Hao <haokexin@gmail.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274669-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ti.com,nxp.com,gmail.com,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilias.apalodimas@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arndb.de:email,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 736A638D92D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Arnd,

On Thu, 2 Apr 2026 at 21:47, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> While looking at the glob symbols shared between the cpsw drivers,
> I noticed that soft_reset() is the only one that is missing a proper
> namespace prefix, and will pollute the kernel namespace, so rename
> it to be consistent with the other symbols.
>
> Fixes: c5013ac1dd0e1 ("net: ethernet: ti: cpsw: move set of common functions in cpsw_priv")

The patch seems fine, but why the Fixes: tag?

Cheers
/Ilias
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/ti/cpsw.c      | 2 +-
>  drivers/net/ethernet/ti/cpsw_new.c  | 2 +-
>  drivers/net/ethernet/ti/cpsw_priv.c | 2 +-
>  drivers/net/ethernet/ti/cpsw_priv.h | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index b0e18bdc2c85..aa3531e844e8 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -706,7 +706,7 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
>         struct cpsw_common *cpsw = priv->cpsw;
>
>         /* soft reset the controller and initialize ale */
> -       soft_reset("cpsw", &cpsw->regs->soft_reset);
> +       cpsw_soft_reset("cpsw", &cpsw->regs->soft_reset);
>         cpsw_ale_start(cpsw->ale);
>
>         /* switch to vlan aware mode */
> diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
> index 7f42f58a4b03..c5be359f3c66 100644
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c
> @@ -573,7 +573,7 @@ static void cpsw_init_host_port(struct cpsw_priv *priv)
>         u32 control_reg;
>
>         /* soft reset the controller and initialize ale */
> -       soft_reset("cpsw", &cpsw->regs->soft_reset);
> +       cpsw_soft_reset("cpsw", &cpsw->regs->soft_reset);
>         cpsw_ale_start(cpsw->ale);
>
>         /* switch to vlan aware mode */
> diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
> index bc4fdf17a99e..c6eb6b785b0b 100644
> --- a/drivers/net/ethernet/ti/cpsw_priv.c
> +++ b/drivers/net/ethernet/ti/cpsw_priv.c
> @@ -275,7 +275,7 @@ void cpsw_set_slave_mac(struct cpsw_slave *slave, struct cpsw_priv *priv)
>         slave_write(slave, mac_lo(priv->mac_addr), SA_LO);
>  }
>
> -void soft_reset(const char *module, void __iomem *reg)
> +void cpsw_soft_reset(const char *module, void __iomem *reg)
>  {
>         unsigned long timeout = jiffies + HZ;
>
> diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
> index acb6181c5c9e..fddd7a79f4b0 100644
> --- a/drivers/net/ethernet/ti/cpsw_priv.h
> +++ b/drivers/net/ethernet/ti/cpsw_priv.h
> @@ -458,7 +458,7 @@ int cpsw_tx_poll(struct napi_struct *napi_tx, int budget);
>  int cpsw_rx_mq_poll(struct napi_struct *napi_rx, int budget);
>  int cpsw_rx_poll(struct napi_struct *napi_rx, int budget);
>  void cpsw_rx_vlan_encap(struct sk_buff *skb);
> -void soft_reset(const char *module, void __iomem *reg);
> +void cpsw_soft_reset(const char *module, void __iomem *reg);
>  void cpsw_set_slave_mac(struct cpsw_slave *slave, struct cpsw_priv *priv);
>  void cpsw_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue);
>  int cpsw_need_resplit(struct cpsw_common *cpsw);
> --
> 2.39.5
>

