Return-Path: <netdev+bounces-253563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCk5JPyrd2kZkAEAu9opvQ
	(envelope-from <netdev+bounces-253563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:01:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B10248BDCA
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D77A300514B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CDF239E7F;
	Mon, 26 Jan 2026 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1wda3iRy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008A1E2858
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450486; cv=pass; b=m4vB1lOuGBauvY9OVsFt8bznAFOnywkXckuWZ3UNhayFyf06UOaeOvW1LWcdrogz9owx0ihvNduwR7RdQIGqW+2wFgYdc6kIkK+nqSiQeeAbj6ha3aIuLc2CZU/YywIkQNgHlv19XB7w8p1ueWnmp8BMug6WLlnJhfkIFWy+pUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450486; c=relaxed/simple;
	bh=zfiGbFYY4CM6UTlE5l+3XzYXBTEOALqGHPkhXHGGgWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8Zdw6UjoUff7TWRyW21AveywwMqWkaQFatRJhvf1VxYyPmpuxftIPgc4Ip01ztgNKTYnjnDtLU/b7+gl4XqCGQ+6to+U2rmW5TA8EevrjMUX2lpbs3fih5EHi1sF6hbekMW+JVYZHzJ+ZX7wFiWw3rWr8lmCmqmFVr2Q8wsYys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1wda3iRy; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124899ee9d3so1210342c88.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 10:01:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769450484; cv=none;
        d=google.com; s=arc-20240605;
        b=bnJg/EcZcDkobAydhvZ+uIDHHdyZB6sldeE3G1sPSWivbjyIL3tq6iK0Tsx0pHK1SD
         EtpLBqQOkJUL+e6OIuHUEFhIVOHgXDnHUxOmhm8kzF4vEOTp8T1X35hysZkjty3IcuRD
         MphmYffGdxxlKloBJALKBR0FnaHADVpVEiX5deKcuLOxMdOdAvMw0wiNragevm7inkKB
         agGCHWy+Y+j9869YcQpQ506pps557EdppgAK4AZfzgLeCiZbg09TV2dOUXzO53g3ye8v
         h0YEZyfsI6GCwXWjB6K5KBWJgKP03GRU7SuDEdeTgqixcQ00qP9Z318j83NZL4GVtM/1
         BAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MxgLpSEGg0aaQhp5m9hUFvbZY893f1cTyzABqo6reB0=;
        fh=Wcg8O9TLw7XlngOTtsLJTKreYK45mza9LnP18ci4VXM=;
        b=YckENgvOiySDLe8OvqU7lGbnSMAIYO3DwrApu3aZxOb5s+c0eb52NhDPW1fsjQvgF2
         xLK073odTJ7yKOFDOwR6SUCiR3iShPSGCG/6KePaRokWJdsMexne75k3p3p9ohrZbs93
         JQpxSjPJZ4lTNOneVLZerBI8HrH0q7RGGFhjWxhjkGTz87RcsfY16Q2StjhSeJCs1Fzt
         iNXnag03QMyJhZHRYBqtSNZmqmAw8aRZ+zmUbFC3KvJFJ7e38W60Ttqt/LC3jpny/s9Q
         +cIo8S7gBljkBcW+RtcC3jBxS0ioqoM/BrCuZPuzCumw5lBTxjca7WFLubYuE7kcno1v
         MG7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769450484; x=1770055284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxgLpSEGg0aaQhp5m9hUFvbZY893f1cTyzABqo6reB0=;
        b=1wda3iRyzZudxP3DG7M5yM3qMAilHB6OW1uyzmk2yAaI6/KcpBAi3+WbgGBOrLbAmA
         N8elgw/idx97NrhCmvRCD3zoEVSGM1O1OqS7yuRICMZ1o9bb7R7dVI4j01IwpVjMNnif
         Njt2rYOYmXzeg4K8cKLxrLtDU3PqvdPJBU7eFaHilWb15W16al8qMmKGcUSMT24hz0Vm
         Jcck8V5+BVfhv7A7zDSkjvLiCz4QVo6wRZIwgpxs3nNIZ1msQ/X3rAFMtimcTClwycMl
         vGvSEUHLCf6+YU73VYP7fprLbDJtDZPd7ps0qh+SklZiyFTtP8CvSF0ngVoYLaAiBoKn
         gmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769450484; x=1770055284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MxgLpSEGg0aaQhp5m9hUFvbZY893f1cTyzABqo6reB0=;
        b=QPh4GUjP2G6pVfCkj7DraCg3TdQzo0Z60Q7XwszuT0UJn+dZPt4KhyQW00xM4IdN8M
         Jt8M4yCheCK+c1nylIfenxP4FylLwRkSiy9lhEftLTc2TT5vYMx3ukFQEEnaSs9r2tk/
         TzHMBL/Rq9IQbaLo/16CzUypX20oD7yB1J3v8AZGS1yszM24OGyiQfFj4cHEP2YveNsq
         uLmCh5yXWE8yl3iwDTAFhLiRYxoWVPGfAcwkMeMJprRXSH/bxeyTcGTdx7ilckacO1JT
         7NUq4qDPtScQUYWq6TTso3E3CExZqcgjssKf2ykBQ0WnUiQ1+nxWdc8qLrcn0M2aVSBq
         p9Eg==
X-Gm-Message-State: AOJu0YxaWidFoqPJ7Yd1LsTOYL/M3ZwgAc8hCwhaxtGprb2n/nGq/NTZ
	Rg0xpRaV4UdXBZNOSWDHAR0oKcQaEknBHNHqDYbNukPsJAzrqrcwl0rocutg9TEWhZSMAkWeS1O
	ZoVlBKfJ8NCmYT0R9oOe2HHkH5uvE+3D1gnY6mWHh
X-Gm-Gg: AZuq6aKXN8ZLLpiUIz7F9EF9AcLXR3M4iFRS9DLpJYidY3jDkBEG1UGo/UmEJ74SRrm
	mzMxpN5+FZp8DjEiQdGSYno+pXZBiijC1rHpnJu9UrPJ1+6/Y6JD1ZNSC+PzdC7B1LGweDBEq/A
	UcJu0zl/UoN1LS84rCFHn1qPOgzSQAy/ILxQs91uLupB1eWv9SHf1sOCwzA76rmsDQn44FHQ0af
	Mv8NWPtXRB7aqwaedD8YU9K8erWKqZMIYOR4osdpoQjw4SaDL9Zwo6iyYKAHIDOnKR7GEpVq3jr
	fYp2DUJN6NtHn4wYssoNCmdHGLwhOHDsPPa0KAET74kxu4GwP7IueTtkcsix
X-Received: by 2002:a05:7022:e23:b0:11b:ca88:c4f1 with SMTP id
 a92af1059eb24-1248ede8598mr2501419c88.20.1769450483681; Mon, 26 Jan 2026
 10:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123170412.906280-1-skorodumov.dmitry@huawei.com> <20260123170412.906280-3-skorodumov.dmitry@huawei.com>
In-Reply-To: <20260123170412.906280-3-skorodumov.dmitry@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 26 Jan 2026 10:01:12 -0800
X-Gm-Features: AZwV_QgO57DjPqmP4SIvdAUAiFsOptMHTxQAJL_z4S1IS5TIHkRtnhpVQgvb32s
Message-ID: <CAAVpQUBGAitiYbXjGoU7ByaXuU9oYF3nfywu43susMHi8mSy8g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/3] ipvlan: Common code from v6/v4 validator_event
To: Dmitry Skorodumov <dskr99@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253563-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,huawei.com,fomichev.me,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B10248BDCA
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 9:04=E2=80=AFAM Dmitry Skorodumov <dskr99@gmail.com=
> wrote:
>
> Extract commond code for ipvlan_addr4_validator_event()/
> ipvlan_addr6_validator_event() to own function.
>
> Get rid of separate functions for xxx_validator_event()
> and check whether we are called for ipv4 or ipv6 by
> looking at "notifier_block *nblock" argument
>
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
> ---
> v2:
>   - Fixed warning about unused by specifying __maybe_unused
>     for ipvlan_addr6_vtor_notifier_block (used only with CONFIG_IPV6)
>
>  drivers/net/ipvlan/ipvlan_main.c | 110 +++++++++++++++----------------
>  1 file changed, 55 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan=
_main.c
> index cf8c1ea78f4b..d5b55876d340 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -878,6 +878,33 @@ static bool ipvlan_is_valid_dev(const struct net_dev=
ice *dev)
>         return true;
>  }
>
> +static int ipvlan_addr_validator_event(struct net_device *dev,
> +                                      unsigned long event,
> +                                      struct netlink_ext_ack *extack,
> +                                      const void *iaddr,
> +                                      bool is_v6)
> +{
> +       struct ipvl_dev *ipvlan =3D netdev_priv(dev);
> +       int ret =3D NOTIFY_OK;
> +
> +       if (!ipvlan_is_valid_dev(dev))
> +               return NOTIFY_DONE;
> +
> +       switch (event) {
> +       case NETDEV_UP:
> +               spin_lock_bh(&ipvlan->port->addrs_lock);
> +               if (ipvlan_addr_busy(ipvlan->port, iaddr, is_v6)) {
> +                       NL_SET_ERR_MSG(extack,
> +                                      "Address already assigned to an ip=
vlan device");
> +                       ret =3D notifier_from_errno(-EADDRINUSE);
> +               }
> +               spin_unlock_bh(&ipvlan->port->addrs_lock);
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
>  #if IS_ENABLED(CONFIG_IPV6)
>  static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip=
6_addr)
>  {
> @@ -922,32 +949,6 @@ static int ipvlan_addr6_event(struct notifier_block =
*unused,
>
>         return NOTIFY_OK;
>  }
> -
> -static int ipvlan_addr6_validator_event(struct notifier_block *unused,
> -                                       unsigned long event, void *ptr)
> -{
> -       struct in6_validator_info *i6vi =3D (struct in6_validator_info *)=
ptr;
> -       struct net_device *dev =3D (struct net_device *)i6vi->i6vi_dev->d=
ev;
> -       struct ipvl_dev *ipvlan =3D netdev_priv(dev);
> -       int ret =3D NOTIFY_OK;
> -
> -       if (!ipvlan_is_valid_dev(dev))
> -               return NOTIFY_DONE;
> -
> -       switch (event) {
> -       case NETDEV_UP:
> -               spin_lock_bh(&ipvlan->port->addrs_lock);
> -               if (ipvlan_addr_busy(ipvlan->port, &i6vi->i6vi_addr, true=
)) {
> -                       NL_SET_ERR_MSG(i6vi->extack,
> -                                      "Address already assigned to an ip=
vlan device");
> -                       ret =3D notifier_from_errno(-EADDRINUSE);
> -               }
> -               spin_unlock_bh(&ipvlan->port->addrs_lock);
> -               break;
> -       }
> -
> -       return ret;
> -}
>  #endif
>
>  static int ipvlan_add_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4=
_addr)
> @@ -997,38 +998,15 @@ static int ipvlan_addr4_event(struct notifier_block=
 *unused,
>         return NOTIFY_OK;
>  }
>
> -static int ipvlan_addr4_validator_event(struct notifier_block *unused,
> -                                       unsigned long event, void *ptr)
> -{
> -       struct in_validator_info *ivi =3D (struct in_validator_info *)ptr=
;
> -       struct net_device *dev =3D (struct net_device *)ivi->ivi_dev->dev=
;
> -       struct ipvl_dev *ipvlan =3D netdev_priv(dev);
> -       int ret =3D NOTIFY_OK;
> -
> -       if (!ipvlan_is_valid_dev(dev))
> -               return NOTIFY_DONE;
> -
> -       switch (event) {
> -       case NETDEV_UP:
> -               spin_lock_bh(&ipvlan->port->addrs_lock);
> -               if (ipvlan_addr_busy(ipvlan->port, &ivi->ivi_addr, false)=
) {
> -                       NL_SET_ERR_MSG(ivi->extack,
> -                                      "Address already assigned to an ip=
vlan device");
> -                       ret =3D notifier_from_errno(-EADDRINUSE);
> -               }
> -               spin_unlock_bh(&ipvlan->port->addrs_lock);
> -               break;
> -       }
> -
> -       return ret;
> -}
> +static int ipvlan_addr_validator_event_cb(struct notifier_block *nblock,
> +                                         unsigned long event, void *ptr)=
;
>
>  static struct notifier_block ipvlan_addr4_notifier_block __read_mostly =
=3D {
>         .notifier_call =3D ipvlan_addr4_event,
>  };
>
>  static struct notifier_block ipvlan_addr4_vtor_notifier_block __read_mos=
tly =3D {
> -       .notifier_call =3D ipvlan_addr4_validator_event,
> +       .notifier_call =3D ipvlan_addr_validator_event_cb,
>  };
>
>  static struct notifier_block ipvlan_notifier_block __read_mostly =3D {
> @@ -1039,11 +1017,33 @@ static struct notifier_block ipvlan_notifier_bloc=
k __read_mostly =3D {
>  static struct notifier_block ipvlan_addr6_notifier_block __read_mostly =
=3D {
>         .notifier_call =3D ipvlan_addr6_event,
>  };
> +#endif
>
> -static struct notifier_block ipvlan_addr6_vtor_notifier_block __read_mos=
tly =3D {
> -       .notifier_call =3D ipvlan_addr6_validator_event,
> +static struct notifier_block
> +ipvlan_addr6_vtor_notifier_block __read_mostly __maybe_unused =3D {

I think #if IS_ENABLED(CONFIG_IPV6) is preferable to
__mabe_unused.


> +       .notifier_call =3D ipvlan_addr_validator_event_cb,
>  };
> -#endif
> +
> +static int ipvlan_addr_validator_event_cb(struct notifier_block *nblock,
> +                                         unsigned long event, void *ptr)
> +{
> +       struct in6_validator_info *i6vi;
> +       struct net_device *dev;
> +
> +       if (nblock =3D=3D &ipvlan_addr4_vtor_notifier_block) {

If you check this against the v6 one instead, the if block
and the i6vi definition can be guarded with
#if IS_ENABLED(CONFIG_IPV6)


> +               struct in_validator_info *ivi;
> +
> +               ivi =3D (struct in_validator_info *)ptr;
> +               dev =3D ivi->ivi_dev->dev;
> +               return ipvlan_addr_validator_event(dev, event, ivi->extac=
k,
> +                                                  &ivi->ivi_addr, false)=
;
> +       }
> +
> +       i6vi =3D (struct in6_validator_info *)ptr;
> +       dev =3D i6vi->i6vi_dev->dev;
> +       return ipvlan_addr_validator_event(dev, event, i6vi->extack,
> +                                          &i6vi->i6vi_addr, true);
> +}
>
>  static int __init ipvlan_init_module(void)
>  {
> --
> 2.43.0
>

