Return-Path: <netdev+bounces-281949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAgCLXjR8GnDYwEAu9opvQ
	(envelope-from <netdev+bounces-281949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:25:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0398C487C7E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A386303BB21
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18DD3793D0;
	Tue, 28 Apr 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJZFUSIC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777503ACEF1
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389852; cv=pass; b=HhQtPwPA83tw13twBVJAyieUw62HeLTEvgIzvC7C4kkuDEEDy4eWV6/WJ7Bjj5H4Ioyrn/+oU1Rszn21oNOdla8gnroB2uWVIUMbPlzMjcktMbRuueiQkWQoutgZxtXYOhWnemDRuCgqN02yxTA6GsJqLnO3EmFVIJFYiBVZriI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389852; c=relaxed/simple;
	bh=9AyvW0eHFQ0T1vrhlMVDtiVf9P1skRo4JRIODXHN8eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5ez10NEcAx08B5iL6pxyB7Ft+P5aOg7cm+zpI5dkiKUwa71OyX98N63VvPXGFKo3MowzmBZ295Hn8uTW2dx8pPwAPuJwsUfD410HmzrNCh8lvmA+W70s+wqMeoMiPf7UlvwPqsfnL1inmzxIKbJstVizMZ27V4AG5hDDqHyAVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJZFUSIC; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8aca0469204so111054186d6.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777389850; cv=none;
        d=google.com; s=arc-20240605;
        b=R4v04AGv8wa2nn5Qsz9kHoqVQOLLw14NBsaYFLsvSUWe7/6fMpRw2Zot/jNvuLumf9
         qu+y2oOm7kvX39t0FS0VZP9Ln28Qxk83zCGiCV2Qik+V+lVxqmo8KXdz4lflS2OLDn9g
         yBO7RCqpGxzJEgHDw8jd7YhfywnJANPA3mKS+NlwKK5u0YlqLB/gT4/yECgISsR1oHhH
         7cnOFTPxEib9Y2UnWVN6IonM5Q1UvioFHByiGO1kB8ekJG7w6XkUan/bspJU2df27G7n
         XicZNilanBRU9NKmbONWhpM1qOoFI7PJl4Ps6ujWKo4lIxpEH8hFqEDjQrej/p/qr8wU
         au/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4cn1QZMqxEODDfUtBVouh5tkVnN3cpzhVnp+VJgXwwY=;
        fh=yGppE8XE/bgKs6tCxffDcGfX/Ruj0AWr3hZ8RKmpTRs=;
        b=MWbt9efaQGYIXgbehzRwBAFlKFXOXFUhtzMJ1Jp2gJhvlgqSrdNx89+Szr4lKvqP+h
         9JaMrh+lrV+VBui6FSL9G6PTb6kJdAoknTtVj+iRom/0VfSBeidJZ2RqTKf9YLsaFQNk
         yAOgl7CVTVA+IZzxQ/eJJS6mPy+3fnlxrDJmGR1zO8R+vcWFsMYmg/Or9UoLfXD6Zcsd
         E5zUvA0vSCSfbzK9BmakP5GEFUPxhv0cNRAhMOhrI+5LM6p3ME4VkAlAH5HoGnsuqrPJ
         o7IAzE1DjKWimV14M4xsIxsLf5i4/pAGrFWP42YjRT5YoE1/fajAn7XyEsJtS76ggpLd
         V7hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777389850; x=1777994650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cn1QZMqxEODDfUtBVouh5tkVnN3cpzhVnp+VJgXwwY=;
        b=vJZFUSICBuuqStfUOFqHw6ZWCpvNB2SrWDtqRGsNfPK5GUw3XocNCwDk1A1F+h5sMm
         To9y+NNV/dHaf0gXt9gLbST4m8T3z1nK4m1otnjutHRRwkkK/Cu0scQ+obFNfi3joCXh
         tSZsV4rUiDSUlJfZn5bK54ypUy1wIdAA357c5mx03OEUzleZ2vakfPhh0/hcF09Qwc2e
         aifWquswx5eTUp3n6cFdm8dD10zRoDh/numBVsGVqIkE6Q1Sj+Sl5sQ79RjVwW12QsZa
         qvROrdSIfsFsgk48yD50ki/C2t/wYg+j06cJJtPWIIfEqgogbgzXwQeD2SGpn91t4nKm
         s9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777389850; x=1777994650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4cn1QZMqxEODDfUtBVouh5tkVnN3cpzhVnp+VJgXwwY=;
        b=lZZkoDglhhTwdC8srbk6YK82UPUjDLaKmQLTj9AQyZG9YNXM1nPtHM9nKKt7NTUjyJ
         XUoQuPtcO2CtH+l3haLEzhE2b9vWA1aJ8T1FC/0dVOUUq7YVaPdSAOZBe1ICptGhK2Ya
         prqe9tp+6gbjCQQRrJ88AKTyzr+zvJXJlSG1cWw7O2y2R19QeU08qvmSSdEh7Wncszwv
         vt2Zt7jYppxBZ9ZWMTEa7gBoZLutE9MDhTCIjo9UqfyTNAZRXxHc3hzjxv2iZV6BLdkn
         aAM8RSbnnTgRsHbv4cJMKLiaAUhAn+2tznMq9kt/A/eQ6oPCQm1dD8bpMEfoMKUSnBpL
         LhyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9B7+KWbWIn75BCEzut5Fo1sqxhrjqLu4nI6Be175GDC5n+5l9U92nySZtbbGKkotNKxgq3nqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPRBx1hlDZCQ+c/Lu2YwG0YR1cg17TJpyJfYNf5Rea2A7TuHdM
	YmYac83iBLYkrf1/6Se6DictjpO2RefnPA7PEsWeLyP+BX/ZEli7p6fUfNKdXSp86zm5ncMgNTD
	u9mQfVv4kuwoVY/g1VN0lE+7kkWObsNy0pGme0NRR
X-Gm-Gg: AeBDieulQJQduFWnBX2oQrL6Weq36C4GZigxbyy9686cib7Hu3crQ8O6FSWzMBc1qjh
	YLFSMfrgu2tpP0RZQnaCobTm89v7HCtRIWEO3Mgshn0RCwhBVMUdw1NDJeA83jrMw8dSTdekKnX
	gkmV4lvToiL+xo4a8dnYpdwCPTUUQc/4ltUGKvKlLJyZQRzCfqLbFRs/oWjMBYX5RTfIY1BZltQ
	5IzzMbaHjmMFo6rky9k8SPJ+K2+f5HS72Bm7qp1//Sxv/ToTQwBaldfBp8rkxXjrcgRWzNYE7fN
	jYY4NGLp95OQ/4tD1wpKUuoIIGeRB0Paf3lq/I8KVtp6pYxsYTf6RptvVFmLXLbJ691yfDbDZwg
	a5MSoJJPB
X-Received: by 2002:a05:622a:1e8c:b0:509:1b76:e9b2 with SMTP id
 d75a77b69052e-5100e1e8c8cmr51932451cf.55.1777389849779; Tue, 28 Apr 2026
 08:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427093633.979310-1-edumazet@google.com>
In-Reply-To: <20260427093633.979310-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 08:23:58 -0700
X-Gm-Features: AVHnY4L23Zx3CEHh5yaHSGZ7jcxnL3vK_Y0q0NAb8kEVIbMpyBmjCCzl1A1PU3w
Message-ID: <CANn89iKtmRcw2RsoofCnSf7kQhBWMYNhjkhSyqdaPcuQw3ZyyA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipvlan: use netif_receive_skb() in ipvlan_process_multicast()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0398C487C7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281949-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 2:36=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> ipvlan_process_multicast() runs from process context, there is no
> risk of stack overflow if we call netif_receive_skb() instead
> of netif_rx().
>
> This avoids some overhead adding/removing skbs to/from a per-cpu
> backlog and raising/processing NET_RX softirqs.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/net/ipvlan/ipvlan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan=
_core.c
> index 1be8620ad3971d281fb36fd0770efd67b566ae60..7ad12dc7845c836bdd04395f1=
53b2b4b397797d6 100644
> --- a/drivers/net/ipvlan/ipvlan_core.c
> +++ b/drivers/net/ipvlan/ipvlan_core.c
> @@ -286,7 +286,7 @@ void ipvlan_process_multicast(struct work_struct *wor=
k)
>                                 if (tx_pkt)
>                                         ret =3D dev_forward_skb(ipvlan->d=
ev, nskb);
>                                 else
> -                                       ret =3D netif_rx(nskb);
> +                                       ret =3D netif_receive_skb(nskb);
>                         }
>                         ipvlan_count_rx(ipvlan, len, ret =3D=3D NET_RX_SU=
CCESS, true);
>                         local_bh_enable();

I will send a V2, to limit the number of netif_receive_skb() in
presence of large number of ipvlans.

pw-bot: cr

