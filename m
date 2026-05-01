Return-Path: <netdev+bounces-283135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFF/DtNY9GkvAwIAu9opvQ
	(envelope-from <netdev+bounces-283135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:40:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E833B4AAFFB
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F019C3029A4B
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 07:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE1836C59A;
	Fri,  1 May 2026 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEJ5aEQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F9363083
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777621186; cv=pass; b=AezBbyc8X//RwTp7zm5KsgOOj6jlrPOCKjMikfUVyy6iLUrAC59AgWLEV+BCf6Sh8fZiKISd2YZOaO0hPXRcLVJiUZ8MQmEf6NTX/q8NiLo6JwaDEE1i1ZdnUT90W5ESDo8U+BoOHfV/7GA5fuPkNj6NXVvdU+DHdjBFVqP1hcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777621186; c=relaxed/simple;
	bh=TbLaoWYohHPqj/XG/w1dzsXdf6YqFfSZc9edl1STeRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlddusP61vLU7HplXbji44ZBil1O2sIKkJ2F1CvYDPjAXp2scSWOu5/ZLaV21TjkwsMG//ObcB7YQR922zl4wPd9v6u2MG5xmGEtQwQV+ufIElK21TR4QcUsgd1EXZUe/k76TGKRixXEcQ1QAFMmXlgmMUIbIJah0gNhYQ4SrQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEJ5aEQO; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38def541b0bso14474711fa.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 00:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777621182; cv=none;
        d=google.com; s=arc-20240605;
        b=NEtLPuSN47M1QDH8PcMg/n8+CzYvUXcQGrYdHDQbV66EWP4EmRXIW2K1Spywtl59Ci
         6ETuAV0W13y43MW7LK6/7sG3tyKlwfKXywdjB/QVa6FYaAk3qlpnRXyJYD/uKR+2eD1U
         6dyg5VnUQJGnwZX25qjgjwkx+mZqPHghau8YZWSvKa/nQCpHSHTIRrkk9SvIV1lW/RqQ
         N/1MPNwRjw2xN+jNiu0BhnGdMeleYHDaH3dRVPPwnqVQUv4PbnZEg92JRfiA+MF5jLZE
         kIVt+k9XIVuVJJLvK3/ok1wlVt67A88UdwD2LuIWQtuqYUtL2h/d++nLej+2QEaE9NaA
         434Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N5yIG/VNV+70xFszkANHVR8rh10LtJp9VdT7AZQOrpQ=;
        fh=wH6crwP0QCfqe6RRdn5ZboEeTvrMl6eJi1eIl3Jfc/c=;
        b=ehO5CRRRghFozDkn26jeotzOLngRl0vsDn4SzZyvtjmJPsnfHBSSei2sWJrKMO0/vN
         8dsJcYW0Ugr5zYt4TAZDCImzuJhcvW3qjKkpM24ohq3CdolfIR1c++aeU/b5VMlJ2kqw
         jansXNiv5pBJzJ8mTHTNqmpKXaqIMngP/kjt1vYqIjrFCVNPMEG6BP8pxozs6WxopDJl
         EuHVvoRznNHq9q3I0zz+lIgbZYRzu7xW/hWJ4Km3XgTGqS9ttc5naN2kaPhsD/Xwcigm
         z8Yxiql3o0GPtpx2K6nPys7gyupaQ0YRtUuNvnxcFM6CqJP69Kp8vkPzAV/xsWBDroOk
         P1hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777621182; x=1778225982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N5yIG/VNV+70xFszkANHVR8rh10LtJp9VdT7AZQOrpQ=;
        b=GEJ5aEQOu5JLBc6QAEWPXNoNw5rmPtGCkkwJVDi/4RVZt6sP6NLm0N1Lb2skecFh1G
         L/rEjbj4kT6EpiQjScndF2ADL8GtmfTPVyJjRNj7BchFBe/LNOnOOjsFfv2sEyzNItz3
         YcSaTJAZSuRs1tR0HNPvdQsXclUK07kLBy97rFTq8tsydXZzpk4HZ3kNVo1/sXrPXk6o
         b56vqWt8Zq267NZrYGdU8K1sKJ/AS7E8XFXo0i6p0YbFri7CyTs11oATh3kcAJoWbcHj
         mfl6nOFQrX7qXQvFdUF+AjF+6AOrga66G5QTACPftbBl1PER3WU09VQUXP83j46+7eaz
         8wgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777621182; x=1778225982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5yIG/VNV+70xFszkANHVR8rh10LtJp9VdT7AZQOrpQ=;
        b=jy/0Piww+ttY7LhQsgavrn8h0EwzOMwv72vTPzZZADD24VSRFjzZvZFMoW5bhV45Pw
         xAFwdfb+rdLdBMNjQg+LyQj6tflrdHUobQorjIvPN+qmfOUWabycS/SevYor5rLZMJdX
         42vXKjYuz0Rck8cowcRYGkMKTpIiBsvQg/rH4qKszG4dHbd4R3FlPP2rTpEXO0RT0Of6
         XR2bqK2dqLXADo7f25nxUMrHo0gCuLq4ASG5o2088LJEJwLXVGGMj2cCV9kbobK89+NO
         frEGcNdATG08yYvy9ggKKiHZ5sJGvAHkvzi8fjtlOZv+MYVobrnaC0HOVyCny6WqBphT
         SvrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8E/c+PtQTogFw0XlLUGbGEpt7j9x922Mf/CVnYiVtYK/6Nji49iDwOQXmGpMDfzJBWni1CAms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkUp6W/zncV+4SwFB1dnAENHxAXtDKBqF/y34zHljs6dLD6yyF
	hX1UVOOAnKIA33viMzyAXH3KY9cmOsFVrqsHQPKRNcsO5euAenCs30qofZevpVqI9FdJsxGtjfq
	K+I5LFp5+wuDIpEMS4stnXOtqK3IUhcMz1uhPVBjJ
X-Gm-Gg: AeBDieuGzIh2SYgw3cpxWaAy8q5X+ZvIKKzlWLzgNCpmMkxgamz4WkhkQa/Mr/CBa0N
	ShA6dOAoGZYDkTyI+3f837TVWyrgy3N4XG4Kz4VKLDqD0gLltGugyIlDVcGAhM1P609L2Q9l65E
	r27wl2juw5ZA/8St4wK6E6NQsYoH8cw+tk+gxD87XxKA5gyfSRu9ZTNL4SREfQgLA3cb2g1ZTl/
	J5epT7enBJftviBirqK2iSEEqmbYO3upzZYOXz/SPhUyTNxZQtQCC8lCNV2EyvTX1RjvQsQDs53
	MlaU3fSSGNxYmu0uDyeX2Ae4KU5f5OUZiotR4KIBWd9lbwkfNjjUgLrLF5OAS7Gef6Z67pDLMpE
	G4/ZnIqoxhths90mPlQ==
X-Received: by 2002:a05:651c:2114:b0:38e:186e:350e with SMTP id
 38308e7fff4ca-3934dec7039mr26121991fa.7.1777621181309; Fri, 01 May 2026
 00:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
In-Reply-To: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 1 May 2026 09:39:30 +0200
X-Gm-Features: AVHnY4LuOCyhbkG_hl8Sa5NNYS1SbIPwYG33VO-fKmuVe5zr0rpNYf2arYcAEvU
Message-ID: <CACT4Y+ZMJs0-9N+tcAa7Yi9-r5wshy0BAD1cdYRxBBPvOtMpZQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: refactor common handle ID into kcov_common_handle_id
To: Jann Horn <jannh@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E833B4AAFFB
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283135-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,googlegroups.com,linux-foundation.org,google.com,kernel.org,linuxfoundation.org,zenithal.me,vger.kernel.org,redhat.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dvyukov@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 at 16:15, Jann Horn <jannh@google.com> wrote:
>
> Store common handle IDs in "struct kcov_common_handle_id", which consumes
> no space in non-KCOV builds.
> This cleanup removes #ifdef boilerplate code from subsystems that
> integrate with KCOV (in particular in usbip_common.h and skbuff.h, see the
> diffstat).
> This should also make it easier to add KCOV remote coverage to more
> subsystems in the future.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks!

> ---
>  drivers/usb/usbip/usbip_common.h | 29 +----------------------------
>  drivers/usb/usbip/vhci_rx.c      |  4 ++--
>  drivers/usb/usbip/vhci_sysfs.c   |  2 +-
>  drivers/vhost/vhost.h            |  2 +-
>  include/linux/kcov.h             | 12 ++++++------
>  include/linux/skbuff.h           | 14 +++-----------
>  include/linux/types.h            |  6 ++++++
>  kernel/kcov.c                    |  6 +++---
>  8 files changed, 23 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
> index 282efca64a01..be4c5e65a7f8 100644
> --- a/drivers/usb/usbip/usbip_common.h
> +++ b/drivers/usb/usbip/usbip_common.h
> @@ -282,9 +282,7 @@ struct usbip_device {
>                 void (*unusable)(struct usbip_device *);
>         } eh_ops;
>
> -#ifdef CONFIG_KCOV
> -       u64 kcov_handle;
> -#endif
> +       struct kcov_common_handle_id kcov_handle;
>  };
>
>  #define kthread_get_run(threadfn, data, namefmt, ...)                     \
> @@ -339,29 +337,4 @@ static inline int interface_to_devnum(struct usb_interface *interface)
>         return udev->devnum;
>  }
>
> -#ifdef CONFIG_KCOV
> -
> -static inline void usbip_kcov_handle_init(struct usbip_device *ud)
> -{
> -       ud->kcov_handle = kcov_common_handle();
> -}
> -
> -static inline void usbip_kcov_remote_start(struct usbip_device *ud)
> -{
> -       kcov_remote_start_common(ud->kcov_handle);
> -}
> -
> -static inline void usbip_kcov_remote_stop(void)
> -{
> -       kcov_remote_stop();
> -}
> -
> -#else /* CONFIG_KCOV */
> -
> -static inline void usbip_kcov_handle_init(struct usbip_device *ud) { }
> -static inline void usbip_kcov_remote_start(struct usbip_device *ud) { }
> -static inline void usbip_kcov_remote_stop(void) { }
> -
> -#endif /* CONFIG_KCOV */
> -
>  #endif /* __USBIP_COMMON_H */
> diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
> index a75f4a898a41..a678e7c89837 100644
> --- a/drivers/usb/usbip/vhci_rx.c
> +++ b/drivers/usb/usbip/vhci_rx.c
> @@ -261,9 +261,9 @@ int vhci_rx_loop(void *data)
>                 if (usbip_event_happened(ud))
>                         break;
>
> -               usbip_kcov_remote_start(ud);
> +               kcov_remote_start_common(ud->kcov_handle);
>                 vhci_rx_pdu(ud);
> -               usbip_kcov_remote_stop();
> +               kcov_remote_stop();
>         }
>
>         return 0;
> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> index 5bc8c47788d4..b98d14c43d13 100644
> --- a/drivers/usb/usbip/vhci_sysfs.c
> +++ b/drivers/usb/usbip/vhci_sysfs.c
> @@ -425,7 +425,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>         vdev->ud.tcp_rx     = tcp_rx;
>         vdev->ud.tcp_tx     = tcp_tx;
>         vdev->ud.status     = VDEV_ST_NOTASSIGNED;
> -       usbip_kcov_handle_init(&vdev->ud);
> +       vdev->ud.kcov_handle = kcov_common_handle();
>
>         spin_unlock(&vdev->ud.lock);
>         spin_unlock_irqrestore(&vhci->lock, flags);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 4fe99765c5c7..0192ade6e749 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -44,7 +44,7 @@ struct vhost_worker {
>         /* Used to serialize device wide flushing with worker swapping. */
>         struct mutex            mutex;
>         struct llist_head       work_list;
> -       u64                     kcov_handle;
> +       struct kcov_common_handle_id kcov_handle;
>         u32                     id;
>         int                     attachment_cnt;
>         bool                    killed;
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 0143358874b0..cdb72b3859d8 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -43,11 +43,11 @@ do {                                                \
>  /* See Documentation/dev-tools/kcov.rst for usage details. */
>  void kcov_remote_start(u64 handle);
>  void kcov_remote_stop(void);
> -u64 kcov_common_handle(void);
> +struct kcov_common_handle_id kcov_common_handle(void);
>
> -static inline void kcov_remote_start_common(u64 id)
> +static inline void kcov_remote_start_common(struct kcov_common_handle_id id)
>  {
> -       kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id));
> +       kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id.val));
>  }
>
>  static inline void kcov_remote_start_usb(u64 id)
> @@ -99,11 +99,11 @@ static inline void kcov_prepare_switch(struct task_struct *t) {}
>  static inline void kcov_finish_switch(struct task_struct *t) {}
>  static inline void kcov_remote_start(u64 handle) {}
>  static inline void kcov_remote_stop(void) {}
> -static inline u64 kcov_common_handle(void)
> +static inline struct kcov_common_handle_id kcov_common_handle(void)
>  {
> -       return 0;
> +       return (struct kcov_common_handle_id){};
>  }
> -static inline void kcov_remote_start_common(u64 id) {}
> +static inline void kcov_remote_start_common(struct kcov_common_handle_id id) {}
>  static inline void kcov_remote_start_usb(u64 id) {}
>  static inline void kcov_remote_start_usb_softirq(u64 id) {}
>  static inline void kcov_remote_stop_softirq(void) {}
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2bcf78a4de7b..a3fe418f7ced 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1082,9 +1082,7 @@ struct sk_buff {
>         __u16                   network_header;
>         __u16                   mac_header;
>
> -#ifdef CONFIG_KCOV
> -       u64                     kcov_handle;
> -#endif
> +       struct kcov_common_handle_id kcov_handle;
>
>         ); /* end headers group */
>
> @@ -5437,20 +5435,14 @@ static inline void skb_reset_csum_not_inet(struct sk_buff *skb)
>  }
>
>  static inline void skb_set_kcov_handle(struct sk_buff *skb,
> -                                      const u64 kcov_handle)
> +                                      struct kcov_common_handle_id kcov_handle)
>  {
> -#ifdef CONFIG_KCOV
>         skb->kcov_handle = kcov_handle;
> -#endif
>  }
>
> -static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
> +static inline struct kcov_common_handle_id skb_get_kcov_handle(struct sk_buff *skb)
>  {
> -#ifdef CONFIG_KCOV
>         return skb->kcov_handle;
> -#else
> -       return 0;
> -#endif
>  }
>
>  static inline void skb_mark_for_recycle(struct sk_buff *skb)
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 608050dbca6a..93166b0b0617 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -224,6 +224,12 @@ struct ustat {
>         char                    f_fpack[6];
>  };
>
> +struct kcov_common_handle_id {
> +#ifdef CONFIG_KCOV
> +       u64 val;
> +#endif
> +};
> +
>  /**
>   * struct callback_head - callback structure for use with RCU and task_work
>   * @next: next update requests in a list
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 0b369e88c7c9..a43e33a28adb 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -1083,11 +1083,11 @@ void kcov_remote_stop(void)
>  EXPORT_SYMBOL(kcov_remote_stop);
>
>  /* See the comment before kcov_remote_start() for usage details. */
> -u64 kcov_common_handle(void)
> +struct kcov_common_handle_id kcov_common_handle(void)
>  {
>         if (!in_task())
> -               return 0;
> -       return current->kcov_handle;
> +               return (struct kcov_common_handle_id){ .val = 0 };
> +       return (struct kcov_common_handle_id){ .val = current->kcov_handle };
>  }
>  EXPORT_SYMBOL(kcov_common_handle);
>
>
> ---
> base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
> change-id: 20260430-kcov-refactor-common-handle-25178495b2eb
>
> --
> Jann Horn <jannh@google.com>
>

