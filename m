Return-Path: <netdev+bounces-299570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z//bA79KMGrSQwUAu9opvQ
	(envelope-from <netdev+bounces-299570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:55:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9DA68951F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:55:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nY4Kqkkd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299570-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299570-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FD013098BDA
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927723AD510;
	Mon, 15 Jun 2026 18:55:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A83AD52A
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 18:55:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549751; cv=pass; b=iPYb1RDl9lnej8mNdb/ry+WBfXxiTtJEvCIcZKldYWF0Ux9U8faVoMYA8FlefNasGJ6vSJv2XI7N8kjUf8KGjK90kz/+u7lLQc1CML7AZuXU7BhNfS94/0ind98uQoPbqPR+o4qG1dIfqi7x5SBRJq06UJwdo/v+s4Pu30E1NKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549751; c=relaxed/simple;
	bh=vLCniGr3jUAF4SUhojgPfBj4jsmKNiPA3QI7j2zXINc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuiX+5enq5iVYlEI7UzIWLHQab/L0c/Pvf18i2s/DkC+i94ehO1xs/eWSzDEnRmgQ0Whj8O0oYqjvb1t9u6BRgkrcO15XtnK38qvACyyqtPqQnNKSzLezG/4MIN8SaPMwNOMNaOPUTveDcsBLIdFns52RLr+IeVWfO2u9uS4My4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY4Kqkkd; arc=pass smtp.client-ip=209.85.210.47
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e74a827212so1714698a34.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 11:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781549748; cv=none;
        d=google.com; s=arc-20240605;
        b=IYD0P20yQwi/ofLiLtNeVdyQJuRG0DsmFkivopQTnqKBEN8d6M0z/hQfrqKLhkxo0r
         JslJioTi7rqg5hLcJ5MI77CjCCt+kGoM9igxuUF5YepeZJomDSxhxinQNFGIY+BxaOFz
         dGGOHfbtJrGeaw40oSHxcf0JAsU2y/p/HKGgsvkRvXzPEwYe8wMsOO2EpjHRfQfqQOvs
         CBk09KVcl3swMjfCaQQapIuzcimJ1eucN8n3dj7jLisAkzrmayX07CY/JfPYl3fyIXdK
         Ej7/xa9m4oxTupSJtdNw13+iWsDzueYK+4dMX6KYviNvuGLjSAAHTg5+wcchmYo0tO/L
         JGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i7J8fMSlrWIjXS2aOLf4cXmSe6hDWy6GGcHTsPgwVzU=;
        fh=EM8dwEyY+Ms7WCigjypTdyAM5hVy9KETVBEIEeYZQhc=;
        b=OqI6ngAlwejB0IQMtm9KPUQpCfH0SBdBVW6dVZ2b9mVoJMo79jDfZaLzqKT4gq2JZj
         wLRzKPcHgKJ05g8k5f/LBBVeanrrUKaS15ckgQpAt2uzV+eLzm4AfJnuMi8zuXATH3GU
         emieN/hJjglFLstWvzAn8TLIO7c4FE7n9o2WApa0Lqli8Cl3BQwQegU15MbkCfQTZLXg
         VR8/ylZ2mRwBxcO/JYL3Cvk0m0hY++kUsLnxvtoIRJ9XpYvAzhe6X0jQ030vBhme6wQI
         AZcsLpu/+sNmnaSyie6e597O/BD4iNJdeRrX4Aq6OoFcP3m7MiZO0Labli0c/NGx1za7
         JJNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781549748; x=1782154548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7J8fMSlrWIjXS2aOLf4cXmSe6hDWy6GGcHTsPgwVzU=;
        b=nY4Kqkkdw0lZq0a/7CeEfoIBI1vdNKAmx9G4RMEV+i35SjcN8fnFSKlVngs+/sWPqP
         4ZyBUiyvz6dMsCHUZXBr9uZZu9wwIp/21tcA9LmN1tmnB0m6Unwp0zR+ub6fsZbaCVT5
         o2gZcyTJRogjH6iO10ZCwp6k+hOt/TssXUyWAnnss1Pcrar8ghA/PbtLd/vc+PZapiaQ
         C0iFAdYmWWRkmlOUWYsbLrXZ/+DJkBshNc+QdyW9TKu24od/yIQu6UyeFLxfxIyyB06b
         FAV2g0gCE8kDMWMlmEgbsPWeTawzvKKzlcXjlCZKQ3BDZzRrXEQZ/GfBzMFFW1vH0QBG
         gfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781549748; x=1782154548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i7J8fMSlrWIjXS2aOLf4cXmSe6hDWy6GGcHTsPgwVzU=;
        b=jVfWx5oRdwE305+tWlyZc2mKLWXrRoe9SH7f+Y/ehtxYjtBOGRUiwfBx1Usl+K60ze
         rBHrcOyzmArpyGDpNJ014VRyX2am9QJGqkTO2uJ5yK6Sc8eIBqBPSNx9F/d6VnoOun7W
         KafZLBSxylsLlx+r1TONkFVVKOTebRz6Gy/+Ds2lAoQ/sd0AShFOogp+A9zoMghBDVq9
         7R2guvi8mb8tjs4QbSfcFcdziX6ypryFvXSmQyjjysuIoCezQ4GOcp7qHbJb1GMEospe
         2Vmq/5PAoI2Htr9xhAFAaFquT6A/uJPeSj6FIutfTsItbViz2VwqnTWSLYp/87iUnTuW
         KJxA==
X-Forwarded-Encrypted: i=1; AFNElJ8QDqQgbIRq5Y1/CAWoO3hpJ7WdkmEthXEV5wCq+iaF98oAKynd44euK7Qtxz1HvbXH5OgTwe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8TFlckgscxIfc+XSH5zUfmhbktk21v26Mba09Z8z6X/+2imb
	i5ovR6pm0XOQOrD8Sbp1ol/qdMyspAQs55t4EI/mcOSGemBe4WJUkhShFqlgFe/tJMpZ8LlNstT
	rUDbOkthPX79jYlA5tJ9UbaIF+MmmO5E=
X-Gm-Gg: Acq92OEGVD3Ow1+qUxUuLkwOkoJ5B/MQcq2SUxZg/x43H6tNAuGqFGfK/pSs7D5VW3y
	p+4u3UN513IY3EhDfy33aOG41bkz7Ss2b4mO3Bvqy8BgkvPU7d3Q92XWhZ1F2uI+7Q3NsVOkrIz
	LWsxdhl+uF3xlfwFtJeCBlmCTQoQKY/P0UQjrcXtMZYiz3LkQqlPKy29MxNHw5+70PWc+0diwyq
	lWoOHqxQrdR4XURILKscsYYV2r2HFcRWRrek6nd8fRnP0UiqdAisMNIezFGjDZ/cDKqbpng5tQr
	r2W4nWpXDXdM2lcRoU4G1hMJaUVzneiGGSy+DMw=
X-Received: by 2002:a05:6808:178d:b0:482:a7bf:dbf with SMTP id
 5614622812f47-4872f36e787mr10712922b6e.15.1781549748011; Mon, 15 Jun 2026
 11:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
In-Reply-To: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Tue, 16 Jun 2026 02:55:10 +0800
X-Gm-Features: AVVi8CdrZaD0SOg_nJJVZcTMzMOYFp6XHbbAcOob6BWYyIeepmq5d8cMNet21fY
Message-ID: <CAAXyoMOp8mYLUx4CQBn=9R8rNqEsb8ybWD0z+=FJgh2j-F0s8A@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ming.xu@motor-comm.com, 
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, de.ge@motor-comm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299570-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kyle.switch@motor-comm.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jianmin.wang@motor-comm.com,m:de.ge@motor-comm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,motor-comm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A9DA68951F

On Mon, Jun 15, 2026 at 7:12=E2=80=AFPM Kyle Switch <kyle.switch@motor-comm=
.com> wrote:
>
> Add yt92xx dsa driver supports yt921x and yt922x switch series.
> To support more switch series in the future (e.g., yt923x), the most comm=
on configurations are abstracted into switch operation interfaces, due to y=
t921x and yt922x share similar register layouts and operational logic.

You are blindly plugging existing code into your SDK, without sorting
out register operations (for example in set_mac_eee and
port_change_mtu).

Do not post code you don't understand. Ask if you are not sure.

> +#define CMM_PARAM_CHK(expr, err_code)    \
> +       do {                             \
> +               if ((u32)(expr)) {       \
> +                       return err_code; \
> +               }                        \
> +       } while (0)
> +
> +#define CMM_ERR_CHK(op, ret)           \
> +       do {                           \
> +               ret =3D (op);            \
> +               if (ret !=3D CMM_ERR_OK) \
> +                       return ret;    \
> +       } while (0)

Do not use macros like this.

> +#define GET_FIELD(value, low_bit, width) \
> +       (((value) >> (low_bit)) & ((1U << (width)) - 1))
> +#define CLR_FIELD(value, low_bit, width) \
> +       ((value) & (~(((1U << (width)) - 1) << (low_bit))))
> +
> +#define HAL_FIELD_SET(low_bit, width, entry, data)                    \
> +       do {                                                          \
> +               *(entry) &=3D (~(((1UL << (width)) - 1) << (low_bit))); \
> +               *(entry) |=3D ((data) << (low_bit));                    \
> +       } while (0)
> +
> +#define HAL_FIELD_GET(low_bit, width, entry, pdata) \
> +       (*(pdata) =3D (((*(entry)) >> (low_bit)) & ((1UL << (width)) - 1)=
))

FIELD_PREP() and FIELD_GET().

> +/*
> + * Macro Definition
> + */
> +#ifndef NULL
> +#define NULL 0
> +#endif
> +
> +#ifndef FALSE
> +#define FALSE 0
> +#endif
> +
> +#ifndef TRUE
> +#define TRUE 1
> +#endif

Nonsense.

> +       /* Print chipid here since we are interested in lower 16 bits */
> +       dev_info(dev,
> +                "Motorcomm %s ethernet switch.\n",
> +                info->name);

Stop copy-n-paste.

Please, start with a minimal patch that only marks functions which use
different registers/procedures and makes them virtual, and implement
them for yt922x in the future.

> +       {
> +               .compatible =3D "motorcomm,yt9215,8bytes",
> +               .data =3D &yt92xx_chip_info[YT9215_8B],
> +       },

Do not change devicetree compatible strings.

> --- a/include/uapi/linux/if_ether.h
> +++ b/include/uapi/linux/if_ether.h
> @@ -118,7 +118,7 @@
>  #define ETH_P_QINQ1    0x9100          /* deprecated QinQ VLAN [ NOT AN =
OFFICIALLY REGISTERED ID ] */
>  #define ETH_P_QINQ2    0x9200          /* deprecated QinQ VLAN [ NOT AN =
OFFICIALLY REGISTERED ID ] */
>  #define ETH_P_QINQ3    0x9300          /* deprecated QinQ VLAN [ NOT AN =
OFFICIALLY REGISTERED ID ] */
> -#define ETH_P_YT921X   0x9988          /* Motorcomm YT921x DSA [ NOT AN =
OFFICIALLY REGISTERED ID ] */
> +#define ETH_P_YT92XX   0x9988          /* Motorcomm YT92xx DSA [ NOT AN =
OFFICIALLY REGISTERED ID ] */
>  #define ETH_P_EDSA     0xDADA          /* Ethertype DSA [ NOT AN OFFICIA=
LLY REGISTERED ID ] */
>  #define ETH_P_DSA_8021Q        0xDADB          /* Fake VLAN Header for D=
SA [ NOT AN OFFICIALLY REGISTERED ID ] */
>  #define ETH_P_DSA_A5PSW        0xE001          /* A5PSW Tag Value [ NOT =
AN OFFICIALLY REGISTERED ID ] */

UAPI stands for User-space API. Do not change it unless there is a
very very good reason.

> +/* To define the from cpu tag format 8 bytes:
> + *
> + * 0 1 2 3 4 5 6 7 | 0 1 2 3 4 5 6 7
> + *|<----------TPID 0x9988---------->|
> + *|<--RESERVE-->|<-----DST PORT---->|
> + *|-|<---------RESERVE------------->|
> + *|<------------------------------->|
> + */
> +#define YT922X_TAG_FORMAT2_NAME "yt922x-8b"
> +#define YT922X_FORMAT2_TAG_LEN                  8
> +#define YT922X_PKT_TYPE          GENMASK(15, 14)
> +#define YT922X_8B_CPUTAG_PKT_FROM_CPU      0x1
> +#define YT922X_8B_CPUTAG_SRC_PORT          GENMASK(6, 2)
> +#define YT922X_8B_CPUTAG_DST_PORTMASK      GENMASK(8, 0)
> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0      BIT(15)
> +#define YT922X_8B_CPUTAG_DST_PORTMASK_0_EN      0x1
> +#define YT922X_8B_CPUTAG_FORCE_DST         BIT(9)
> +#define YT922X_8B_CPUTAG_FORCE_DST_EN      0x1

If yt922x tag format shares no common with yt921x, make a new tag driver.

> +static struct dsa_tag_driver *dsa_tag_driver_array[] =3D {
> +       &DSA_TAG_DRIVER_NAME(yt921x_netdev_ops),
> +       &DSA_TAG_DRIVER_NAME(yt922x_4b_netdev_ops),
> +       &DSA_TAG_DRIVER_NAME(yt922x_8b_netdev_ops),
> +};

If both are supported by the chip and 4b does nothing more than 8b
does, do not bother with it.

