Return-Path: <netdev+bounces-266323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCDAJBSDsGmwjwIAu9opvQ
	(envelope-from <netdev+bounces-266323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:46:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D9258000
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF28308AF6C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8124279DCA;
	Tue, 10 Mar 2026 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuaSybL1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCAD13C8E8
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175569; cv=pass; b=OW7eUyNuH3yA73fbqIUY/80f0W+l9eAxnbImW4INLaXsCYg6nrfvBZirQUSJZYl48gKK8xvjajwvrtSWEAw2GU2yOcg+7AdXSGZDPxNRj7demX1NMimEJ2Pj3NDdIhLIVaYAEry1LUgnZZtwLFdiu1BI2wVJj93ST/SxaEOaWak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175569; c=relaxed/simple;
	bh=P/ZOhjOYfLW7J1OcemUF4N83gxInILjcvIRXme4e7MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6T+2xaP2vQGks3rlpZe/kNUiWQuzzb/ZzLt9cB3N5KRzgb4ROTOwuPAtcpEP7qQWOA/QvTcOuZDejVM25lRaGMabU10v1n84Onn5Y8VQ3ulV+R8MRvX+HPrsbTe98Iymq+eG5np8qWkTa3s6d4tALASrjRXgJXlVT6LtpIickU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuaSybL1; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d73ddad3ffso340673a34.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 13:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773175567; cv=none;
        d=google.com; s=arc-20240605;
        b=cvrlFUedCyOnDCV1v4v6rJpgX1yWZxjYT1x27Cfgb3REssPGf2ZnHUpLGeSWWzoF6V
         0mdwfyia7w3WPbHvBxBERTupeVC4x2yib+Et5WnGT9HjUPvqZPNQwc3a2AxsO+vqGFkg
         J9vfkeYijvOJquZJma8f3YEuUbln9H9xo5Y8vuTSxZ0Ojgil8+dYeNcvksbPqny6qQJd
         ur19RhATa8uuAx9gLzlQKcRKSBHNNebGG91aeMTRydsixCK4MkPiRsozM6i+ztkkISB3
         ySVZlj7lQB+0DFUOqpqPdzYDnv5lk3jTxCfE+Y0AvYjUZJH9tklScecFL7mz/tjMd1dd
         rePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AJGv4pC+bVNUdyB2YkXSP/tAtUPNvGtncqLxZh3YPCA=;
        fh=tRdMTyfcvqPxAC+jYvKVA623MnWj9stzVR5WGrZbrh4=;
        b=LsiQ2gazc/xg4mGXfLj4CalDna0ikQhtsZFPv1ZNWiT2H197j1F8EhQz2mNXAWmFI6
         NAiYPQLav0Oo/9DJtjFhkMwWdqs0nkMa8uc9rCPyHebZQxmzO1/Pv/uUimgfHGaqXS3E
         hbd3USXXIsPUSXmWLyj++r60pUG2jPQexkAoNdELWja9WEcjnPosHutxO6aqAMb6/moL
         Xm6JMBMKAENFeuqUEciHKTonUw9Ncrf5eTt9dRjVX+8CESwHbfnPc/33WpaIxUYamokn
         Qbyj4ebQSlS6y7DabUzBW/PWJuDsw0p/1ZL8olRfK1X+yrOpf9MoZMIKo6ULRhYViy2o
         +g5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773175567; x=1773780367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJGv4pC+bVNUdyB2YkXSP/tAtUPNvGtncqLxZh3YPCA=;
        b=KuaSybL1ZlCg9vxXF7K/P5sS4rYWSZhHPjQMMI+kScYPW2bzdvLcrIt0vUSVC1BhqU
         982ovVF+SHfoyaHSJuxuK8CgLKnNJdKl+LTDz30RHuenJkQ0tDtlZtahqbTgHvC0Vuc1
         tx03U9wWudqYO2gFYcQHbIV4TbVXv9w0ITcz/Ji/m6wvkZqBX9Ak24EJwbYJr16aDjTQ
         3BJl5MZirKa8oxNAfZhHkZwv4rDo//ghbwKPUBxNA3YEB6PN+b3YGpBm+rvBuRhcrGzn
         +LB5BU1w1KmaGCntDhEFIfIE/vjV/lnvi/GZW7QUFhoF52RhS5hEerOoZZbqNeOpguCC
         6+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773175567; x=1773780367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AJGv4pC+bVNUdyB2YkXSP/tAtUPNvGtncqLxZh3YPCA=;
        b=I+C3wDRYCDGMP7DyhZj+aP94Gap7RY8HIObOzOeVWM6hvABGnF6xbOUPJGnQpUGGE9
         FaQ1AGqHsU5fWVgzCPRkcKHl4FkpeGFrU9ceHRUn1v1vtzYsqzRIjpCrW4o+NJ6XFrMG
         Qsp8c0J1PMQJhi5uFdnNf3uyMvLINd5J1xqdRh+nLoY+EsjeFHO5VNfwtf/N/Jq4SLWp
         eS+RCg7IhV1XthTipb5UPIYyStIZ9o7GKnAsWR0svqw2aifrv5Z/XqcalCl9i8+AuwV8
         2que74RtM0h3+G92T4IMzgx/6i87eHr8j8xDKUMUNlF95p+t5k5gYYqTN59vyLuT9aXh
         pVZQ==
X-Gm-Message-State: AOJu0Yw6czQF2hxKWZGRKgAq6CN0bOx4xFO7UN1pFcLyMqKyFnUiOk4G
	vlDVD6MansaSp4MAgYShIekLOijdhule3ajp6mL46xKSareHG0Z28SJPzmWprwmwD17l2yg9ryC
	B9fOBA0+t0NuhhvAIMGCTJAh0dk0G4F8INPHS
X-Gm-Gg: ATEYQzwa3v0DRtZc1Mae+Y6YT1WhOP5P/X/9ldAkKiVgzmC7u4uFRe1z+yU3PLjIiSt
	X4KfYnsvuRGejslvzFT9z2AhzByZ30fVS5TmzsW8pOa8mNyKl3EupaO9Y4m36xEjBneQWmQm3r9
	9odpOdJg19vQdLrPaJC9WYyo+2nd6KJ55Bd5aJuNu0Pz4nxUOLfz0uFI3xZjxBsc/iTOEKBc6Kc
	GG7ecOqeXkxFpDpYJ8T8rvoybbkInlFQPBsh/rFr1LZfip/lWoSW82H6+JP8h7QXDgtyxwE8nYP
	UxywfmoAlZTn30fwvGzeVTg=
X-Received: by 2002:a05:6830:348b:b0:7d7:3adf:a732 with SMTP id
 46e09a7af769-7d76a5a9c63mr197745a34.2.1773175567432; Tue, 10 Mar 2026
 13:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
 <20260309183454.2872967-4-weibunny.kernel@gmail.com> <willemdebruijn.kernel.21b0d6913512b@gmail.com>
In-Reply-To: <willemdebruijn.kernel.21b0d6913512b@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Tue, 10 Mar 2026 13:45:56 -0700
X-Gm-Features: AaiRm51BFTF_Hz2nJ6C-QAYE83J0XJnRBFDEqXs0iugOfE28VZyVWgXtKGAGWY0
Message-ID: <CAGqc4nU0Fo6fVdCSZTUMfXhdsTEFtx6w=9gJXZLu_umD3rqOEA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/5] psp: add a new netdev event for dev unregister
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Daniel Zahka <daniel.zahka@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E35D9258000
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
	TAGGED_FROM(0.00)[bounces-266323-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fb.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 5:37=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Wei Wang wrote:
> > From: Wei Wang <weibunny@fb.com>
> >
> > Add a new netdev event for dev unregister and handle the removal of thi=
s
> > dev from psp->assoc_dev_list.
> >
> > Signed-off-by: Wei Wang <weibunny@fb.com>
> > ---
> >  net/psp/psp_main.c | 64 +++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 63 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> > index 178b848989f1..8e00ade706e4 100644
> > --- a/net/psp/psp_main.c
> > +++ b/net/psp/psp_main.c
> > @@ -375,10 +375,72 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, =
u8 generation, bool strip_icv)
> >  }
> >  EXPORT_SYMBOL(psp_dev_rcv);
> >
> > +static void psp_dev_disassoc_one(struct psp_dev *psd, struct net_devic=
e *dev)
> > +{
> > +     struct psp_assoc_dev *entry, *tmp;
> > +
> > +     list_for_each_entry_safe(entry, tmp, &psd->assoc_dev_list, dev_li=
st) {
> > +             if (entry->assoc_dev =3D=3D dev) {
> > +                     list_del(&entry->dev_list);
> > +                     rcu_assign_pointer(entry->assoc_dev->psp_dev, NUL=
L);
> > +                     netdev_put(entry->assoc_dev, &entry->dev_tracker)=
;
> > +                     kfree(entry);
> > +                     return;
> > +             }
> > +     }
> > +}
> > +
> > +static int psp_netdev_event(struct notifier_block *nb, unsigned long e=
vent,
> > +                         void *ptr)
> > +{
> > +     struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);
> > +     struct psp_dev *psd;
> > +
> > +     if (event !=3D NETDEV_UNREGISTER)
> > +             return NOTIFY_DONE;
> > +
> > +     rcu_read_lock();
> > +     psd =3D rcu_dereference(dev->psp_dev);
> > +     if (psd && psp_dev_tryget(psd)) {
> > +             rcu_read_unlock();
> > +             mutex_lock(&psd->lock);
> > +             psp_dev_disassoc_one(psd, dev);
> > +             mutex_unlock(&psd->lock);
> > +             psp_dev_put(psd);
> > +     } else {
> > +             rcu_read_unlock();
> > +     }
> > +
> > +     return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block psp_netdev_notifier =3D {
> > +     .notifier_call =3D psp_netdev_event,
> > +};
> > +
> >  static int __init psp_init(void)
> >  {
> > +     int err;
> > +
> >       mutex_init(&psp_devs_lock);
> > +     err =3D register_netdevice_notifier(&psp_netdev_notifier);
> > +     if (err)
> > +             return err;
>
> Defer this until an associated device is actually created?
>
> In many installations it won't be and this notifier won't be needed.

Ack. Thanks. Will fix in the next version.

> > +
> > +     err =3D genl_register_family(&psp_nl_family);
> > +     if (err) {
> > +             unregister_netdevice_notifier(&psp_netdev_notifier);
> > +             return err;
> > +     }
> > +
> > +     return 0;
> > +}
>

