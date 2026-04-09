Return-Path: <netdev+bounces-276863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMBHDOlS12kFMggAu9opvQ
	(envelope-from <netdev+bounces-276863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:19:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4473C6E71
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 103313014698
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7443368B1;
	Thu,  9 Apr 2026 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVGQ1dAl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573034D397
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719127; cv=pass; b=UR4oLuuvg/fcobzPD2VCvQqf4LXi35OH0yxlSn2DTkyBWWNCs/63Allw4OeU0iPYiwFyzwuS/sVgTdjCBANtk58Ut/hdUUjuqlRwp2Zxl8ZWUSihSHRTUBFpJKi0md8aTqbUOoXHWyMmJ4cG66FC2k6ebIJg4qGRYknEAzOaC+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719127; c=relaxed/simple;
	bh=V33fbzj5xTzbEm7yrIuyKhbRc0gQ0rmNSx5Wh14vJ10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5TZJo5HN54uWXgAR+giIrBefenJ27zfu6/zk2ZDmujrDfHhWw8ZnarhChhiktffwEZLKwW7iQfbk1bxFrBD/eM21rb9vMgyk2kPQ/Alni0J32lcDSRuAvBRjiDQL7eus6yT3BxdDyzhjQ78LgKDwp4sHunSfnIWR2/+oaNEzBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVGQ1dAl; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d8da3e656so6021291cf.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 00:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775719125; cv=none;
        d=google.com; s=arc-20240605;
        b=MDYezr9xlfliKUthukNB0TRAD3cWVw6lLMKk952spxApqVilXeQrf9xi5ybpjeP5Ch
         HE4uzuU/+OfrRi++IFqY0ibFch3QfFJWj2CAGraJF8DE9fyhW7t3o/fBY4VsHdQrZ7fu
         rVOl1iHwU/VSTTgIeWFD3uIQLEZ3C5ZtnqoWCoxyMSzqzznprDQI2000KVtZHBRtnW4O
         gpX4CYk+RHu8TGSSzChHAxt7CghNge2zd1Vhox558YfPrttNaxRUl+qNe9uK2/ica6Ww
         BzE6LHy4hL+JPmVAns0GPZY01TfxIO/YuaQQaIdek0eKrL0gG3VjO08rvLZuKkZmndUC
         FoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MHX63UpbuJfkt8TSz+vhS1tQGY0W/7drntvhqjvQ2cQ=;
        fh=R19Ya4Es2bFXigoknl1CDkvp90z982EEgHFT/zk2zX8=;
        b=WroR9/HNBT9gJg8f9NTuYBwldIyxMMnYupCFELTyt1k3IcJDRPoftDwN6rV7Eku1kw
         YqNyYiuCT4ce2T8vi0M9dI2k+xpORV39FbXBCbyfQiWUTJ2H1dv1oLiRV1Rmg1PZ2Ka3
         w7nKLiM4VcJTA4uTXzlr4+eRO8lxQJHiAkJMLwn/nlqzlDRoP0bGShpixn7H7J5WCanD
         AfPh4FP8ELxKO6Boenh+AVT1XssHYpcomxUeI/7+xd6Q1cMGwYTZlngiRACuik6kdYXO
         2PN9xHiYXJyxvCd2vYUk34GlRzPvBVzsHKfi0c+3ynrIqGlhZ/plCofGzkTGT03F3vJx
         a6ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775719125; x=1776323925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHX63UpbuJfkt8TSz+vhS1tQGY0W/7drntvhqjvQ2cQ=;
        b=YVGQ1dAlgtzsymA6LlhgsSERf3lVsAea+BWKR8MRtsGKxXgixyo4xKzxbElAtTlJI0
         e7LtOt8UbqlZn1cfPqfjJOFA01BznQAT4Y7npncYCSqMc08OqERWMh9kKv1yCmYcdaw8
         gcnjkR8FZffRHr4ijeCXDpaPfhCLExzt8kzczTvUcDYMgVtG/reme+nxANIs+jh2TJYj
         2ZxWZ7V/NK1h73UQgxZqTVIev9cqWWxArG+V+A7SdkRVrTRtwMq3SCMuZ2N7EI6JFBEY
         iWZ7pMtb7oppH8CgPYQFikj8k5twI88CD1ZebK+W1IzzC1KDyceUQJpUBmONBqZhBLwv
         jwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775719125; x=1776323925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MHX63UpbuJfkt8TSz+vhS1tQGY0W/7drntvhqjvQ2cQ=;
        b=Vw8I5fEm73we3m3fpfqsMn0NzBuAGrTU7LnrxIBN23YmrgaAWygRNXgC5wYcCrisDi
         hvNQKve9h+3f2TC5mF1wclviG4oKfyAzegGbKrvUygW5Nl73Dsy7epQFSEoeipnCzY4H
         TbvVMZ5V3Bi927lKWok4SLVSGnElzm4wAC5QtzQD5Dber/TZjz3PJB3GCIT6ToJoFBjf
         ZiTUKO1NyQuga+MrAdmcFu6dPVEvaWEWWdezm+ZkKYndCFO43c3ZL2YwXP4jiCjDeyFg
         YVGi3gyOhAU2NdUwCWZ4X4irGy6hhBtEa/WsHlyZJ0tx8n5aUyCixnl7x3JeJxs1FIL5
         3V8A==
X-Gm-Message-State: AOJu0YwP8SmCBfBF4ibT12h51uA3jzamyXGoEiWC07bFofrgGtCBywM4
	ABH5w3afIoUp+STmbdSJT/U0I9kgQJWSSh8sJ562aKe6A2CtWE4gtZ14zvXk8fPYlImZFwolVhC
	7nwYWC9y/ZQLCMQAnM/RwbKvodmx3b6NrmRyGiEDy
X-Gm-Gg: AeBDiethnsBV33nwD4V3pAfVT4xbkiKaSn4D4kAbK27KAowsJwP0LEYcex7hnqlCNJ9
	OFM/x/hdJtwFADw8N5GVzI1afzyqO+uI82zT+XHsLg4Q/iG8Ot29ZX+OTZmNaZtOO6AtaNykbj3
	Btsh3Dh9BnD1TX8G75PAdnxl1PomrouXX3Zf/Icimml/oUscuXeFLOQD3JnVT2PqXuVK/WhzYJr
	hMhXLY96LAckcx7YUEjgrTTC0BGH8omVICM6fqnvX7DMUYu20ktmQdXShXuCuMALYEPTI+2NUsK
	aqlaGBY=
X-Received: by 2002:a05:622a:550f:b0:50d:a466:6d11 with SMTP id
 d75a77b69052e-50da4667327mr141152041cf.33.1775719124336; Thu, 09 Apr 2026
 00:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409035344.214279-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260409035344.214279-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 00:18:33 -0700
X-Gm-Features: AQROBzCBrSFz_fNky2oRmRFlJtTuudv4zSWZGQhSCskIXjdCtwr-zR2LdxvTwxU
Message-ID: <CANn89iLEpVVo=q4FPpBQ5FomoLmdrfW3su7Mb0ZES4EV9=Q4xA@mail.gmail.com>
Subject: Re: [PATCH net] net: fix __this_cpu_add() in preemptible code in dev_xmit_recursion_inc/dec
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-276863-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,lunn.ch,linutronix.de,goodmis.org,gmail.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F4473C6E71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 8:54=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> dev_xmit_recursion_inc/dec() use __this_cpu_inc/dec() which requires
> migration to be disabled. However, some callers like SCTP's UDP
> encapsulation path invoke iptunnel_xmit() from process context without
> disabling BH or preemption:
>
>   sctp_inet_connect -> __sctp_connect -> sctp_do_sm ->
>   sctp_outq_flush -> sctp_packet_transmit -> sctp_v4_xmit ->
>   udp_tunnel_xmit_skb -> iptunnel_xmit -> dev_xmit_recursion_inc
>
> This triggers the following warning on PREEMPT(full) kernels:
>
>
> Fix this by adding migrate_disable/enable() around the __this_cpu
> operations in dev_xmit_recursion_inc/dec() to ensure the per-cpu
> variable is accessed on the same CPU throughout the inc/dec pair.
>
> Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functi=
ons")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/linux/netdevice.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 7ca01eb3f7d2..6b1cd5380d70 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3591,14 +3591,19 @@ static inline bool dev_xmit_recursion(void)
>                         XMIT_RECURSION_LIMIT);
>  }
>
> +/* Non PREEMPT_RT version: inc and dec must run on the same CPU,
> + * migrate_disable is sufficient.
> + */
>  static inline void dev_xmit_recursion_inc(void)
>  {
> +       migrate_disable();
>         __this_cpu_inc(softnet_data.xmit.recursion);
>  }
>
>  static inline void dev_xmit_recursion_dec(void)
>  {
>         __this_cpu_dec(softnet_data.xmit.recursion);
> +       migrate_enable();
>  }
>  #else
>  static inline int dev_recursion_level(void)
> --
> 2.43.0

This seems wrong.

The migrate_disable() should happen before dev_recursion_level().

