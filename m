Return-Path: <netdev+bounces-272499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEO1JHRfxmm+JAUAu9opvQ
	(envelope-from <netdev+bounces-272499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:44:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 46174342C66
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9454630D8F6C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEE33DF00B;
	Fri, 27 Mar 2026 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0zt0Bg5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92E3DCD87
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607881; cv=pass; b=U1NXrxcu5l6BI4EsExCVdMpgqitFFfzi7iypwOxnaR8CwFbxKU6BGuKGjKxhEzKooSmUKZiD1jd9ASkhK2rTswDLv99UVshZaw4E4HnSDCFuCxAeVifZpwMjQIlLRPVq5NgbqXT0UlzRMEdI+C3cSZPVaKi8bDZ+ReTDRdiogAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607881; c=relaxed/simple;
	bh=dL7g5B6+bEqOjoNZIsYaoVnqIJkDP5v40waj6KEcH38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crqVlPsA8rsNwjCYWwP+7xJX057eJoI+v88sFho2vHK+x/En7pozJGyCSL6QV1v9L7Bmrvkm1hPoiPgOGgAp25WVUQpbml7tzn0FdySoR5CaUTqyo8X7VNBHOvRExAboxSzfjguK4yWHwYmnxIzlHzPMBdCyPVj6OoKS1gnS5eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0zt0Bg5; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so357093e87.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774607878; cv=none;
        d=google.com; s=arc-20240605;
        b=J+oVBkYRSNrOPpDh8W8qwKSTCAeXlSqWcg9DO8lEVFr/WxbbowhnZOVLUkIDjtVU/c
         fJwpolROzrxLMcQqa9I4QqVmTDiAOamnM+N9Mrbw8kq6C46xJYTvHiNCCSnr/Y8NkrnR
         iVu9Q2VeSEzow5n3B7VpcrXENWF0UJZczujzWavgAJ1yOhP+xi1ASOfdFaxM02OLgWt+
         kkE9msyG2Bj/NI8ygNLvqQndnf/++6oOVT+EV/GidgBXNptAjjVGVOt18nLKeSoHC+4+
         zfXr6BNTR8ekEtSWxTZyvaA06Ric7bCaM3uS9x9wKaRZObc7AAnOsugJGE30GPF5Xa96
         jN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jhD1D8zHO+hBH+Nf1ekUTq2RJpwckifmx0XEo5ywQ1E=;
        fh=cGKiNixxesD20kaYjAF4sjdU7wb63T59hZb3XPQk/5g=;
        b=RzMuioj0jdkwYtQDdgl8OWNezYdo0mOqYaVVmJ79AvMpJn0fC6ADjBxM6czzJKccx4
         PaZuz4bEwSD7zi4aOvUtLQV+gNJIb4bEGKo21CTQ22aELerAbslBhn9T4wQUYPIcvCsn
         u77FMALBXwA+cJz7M8u3y0P3R6SXtKFVgDJUm1v7KS+M13d141by9zlWJpW0ehxa7QoC
         I5cTA0BRmfsSdU8Jug4vp2/fn+anvo56PXguN6VO6ixKNevWMFGB/4ugajv4I/qGyCfT
         PW8ITK7vamKhKehMwsoWD19Cb+6c8BFrbsLU+LAiyz8imYYwZT4pKB5kLZFOCrF5WcEM
         L+Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774607878; x=1775212678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhD1D8zHO+hBH+Nf1ekUTq2RJpwckifmx0XEo5ywQ1E=;
        b=O0zt0Bg5PjouJ9kW2F+RbCVnDeibRHMc+4SejttZ6Vlurg/WPRH18+xvI6IhJIA/yp
         Cou8PVfoM1HpBmnEyRfRJpBcGxp50jGbWqsNtycAf+iOvhmwT8M+wZHKAc1hXdc8jaVh
         eEnMn+7Ba6PKPjBgjENaRGdkNiyhBolpB8iprdvbbE1G6hMOcDOQ3DKQCIodR43+rrqn
         55c+gnMZifFJOEszxt8nVdgOjd7NszD9KdxjrHpHgKx8gP7MGsNbaZp0CsYEhT/rbwLA
         3pmLsmdsVRpEgCsBWhMhKFvIwfSTc6T2rEJEsY11wNsw2k25R+qd6ZDyPHwYixcZl0v7
         H03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774607878; x=1775212678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jhD1D8zHO+hBH+Nf1ekUTq2RJpwckifmx0XEo5ywQ1E=;
        b=Eg3la98rNw4CzdxZmzIMfqhKiJAkhiCTpyDE0NvFyGaKQUq1wMF68qoAXmJa4wCmuk
         lvhZkahWEGyIayxGxRI5tN9orH06WN04suTWrsda0o0yUuu/n7GO2NKIHqHLohCOVfAU
         3082Q95Q/oiNkc+a/kHqG6dpxJG44DsVuaKISY+nvlsLF37iewEJKRkLjw4+Up+RpfHD
         eAK/ICIqTixKkhIOKeFmkAaXdvN9W5wGieViWK6dxto5xypcp9cPIrckr4epZNwZjPpP
         CDachPCK7gNHLWPnrBl6Fz0/olr49d24cEPVgFyi3ihc4upkTTNqJCPWu8239ktDf45J
         A0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWbwX/jFQM34BDkmShRNbUdHjo2/dxJD6wvN4wFo937XAkjHouGjpSFKOTGYwuVi5PCelxoZTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ryfnCFbUWtiY13mc8zuT2xk1jzsMGbm+P/4daQpyTh1NuAcI
	Ns1C323/+XQf/ERMRN9Yu7ZW6chpQCLs8jA42nYZkp22woYOpLxhmUnbWu5Hq8aNvv4DJVXmUsS
	dBzYwQUR1BoQatrSjCeApLyXPkCASok4=
X-Gm-Gg: ATEYQzxhL/6S8j4jI5zqC8jmpwB8l9lBGvoFheEV73U8RztXJelHd5YL7T5NOU2EtEL
	h+26y2GqOnQrHtUwmCo/znqv324t6biTHmPPZoryjZPUzSgiIfFgG7nXBaymn8Q/StI655hBD77
	ts3IF9s/FKjkTAQjIeJBnunyhZLxH8Qqq/X6RCMnOmo4c9zGC41GRKxMl51L+oysQaYpcjAmdcx
	Jeq121IJltKxZV0nXRNCtaWiUDPbeeKRJgNU6V7HsJj07kWNxFl/Y9asOAFgOmwk1lGXXs0qMOs
	IRjA/SoVw83oCwEnHFU=
X-Received: by 2002:a05:6512:1292:b0:5a1:378c:11e8 with SMTP id
 2adb3069b0e04-5a2ab7fb871mr685854e87.14.1774607877886; Fri, 27 Mar 2026
 03:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326144249.97213-1-kerneljasonxing@gmail.com>
 <CANn89iL6FyoHBrfpwYSd5wPzFh3Y_1T8C6bVFuRRf7PP5p=WRw@mail.gmail.com> <CAL+tcoBL5+qSQhz8BO0ozOoEE0EgPpaoaPvp455e+gqrRyrEUQ@mail.gmail.com>
In-Reply-To: <CAL+tcoBL5+qSQhz8BO0ozOoEE0EgPpaoaPvp455e+gqrRyrEUQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 27 Mar 2026 18:37:19 +0800
X-Gm-Features: AQROBzDsQR6337y6G-5zUfqQ9zvpzl4RF0bF4hBNxis-N-06yGHHYBP-_yOMGZI
Message-ID: <CAL+tcoDZx9j_HuzTge3u11_kz8FmEVfw_DMzMRzRd9hv+gjTdA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add sysctl to toggle napi_consume_skb()
 alien skb defer
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272499-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 46174342C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:21=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
...
> > Seems a copy/paste of proc_do_static_key() ?
>
> Thanks, Eric. Much simpler right now:
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index b508618bfc12..a6a1b2c3f8e1 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -676,6 +676,16 @@ static struct ctl_table net_core_table[] =3D {
>                 .proc_handler   =3D proc_do_skb_defer_max,
>                 .extra1         =3D SYSCTL_ZERO,
>         },
> +       {
> +               .procname       =3D "napi_consume_skb_defer",
> +               .data           =3D &napi_consume_skb_defer_key.key,
> +               .maxlen         =3D sizeof(napi_consume_skb_defer_key),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_do_static_key,
> +       },
>  };

Eric, when I'm investigating the static key feature, I wonder if we
can replace some sysctl knob that only carries either 1 or 2 with a
corresponding static key? The merits are 1) we can minimize the size
of net.core.xxx or net_hotdata which helps put the structure into one
cache line, 2) in hot paths, the static key can be more efficient.

Here is the list that I've found so far:
1. sysctl_bypass_prot_mem
2. sysctl_tstamp_allow_data
3. net_hotdata.tstamp_prequeue
4. sysctl_tcp_early_demux
5. sysctl_ip_early_demux
6. sysctl_tcp_l3mdev_accept
7. sysctl_tcp_moderate_rcvbuf
8. sysctl_tcp_nometrics_save
9. sysctl_tcp_no_ssthresh_metrics_save
10. sysctl_tcp_dsack
11. sysctl_tcp_abort_on_overflow
12. sysctl_tcp_slow_start_after_idle
13. sysctl_tcp_timestamps
...(some other tcp sysctls)...

Some of them can be accessed in multiple places, which means they can
be hot. Maybe we can try some relatively hot knobs first, like
sysctl_tcp_timestamps, sysctl_tcp_early_demux...? Do you think it's
feasible?

Thanks,
Jason

