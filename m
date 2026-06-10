Return-Path: <netdev+bounces-297589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W4dgGNY4KWpaSgMAu9opvQ
	(envelope-from <netdev+bounces-297589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:13:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EE0668283
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:13:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=co7R47cr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297589-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297589-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 379203052FDA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70FF3E92B9;
	Wed, 10 Jun 2026 10:06:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC93E8325
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:06:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085981; cv=pass; b=VjaYwM8B779cnl+/Re4wFIxZPxDExVJhiDTis0YRbJx7xQRJTQdbdGjyz2E00PIpZKMY9iPPZKyk/GpwA4IAmmGuxHYmhsyBTcbK75f29I0XIbdIUV/oSyJB0Ux4azbTLsIax5yW0WOlhCZR0MIgQ0GhyuxI/dgUeaPC7ylsFG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085981; c=relaxed/simple;
	bh=J6PEq8XHiTy4v1p9giKq7cEXYqwXv2oweqMnQHaVXK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUnnLxsQQ/YBYZomgSbpyXQOAUtbW9qjh510dDGovecH3ufmaMj2/6jsMkNxGSEEqypDOvH339eoAMcY26yQVczvaMY1ZzFzy9Mi8SbKx5Y7SC7ShSZXpoP0R1R9hmoBWtRBfqX5wt07u8x8DJchogOq8qIGBAxk3Z7vYru0RPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=co7R47cr; arc=pass smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7ea6923cc94so66614277b3.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 03:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781085977; cv=none;
        d=google.com; s=arc-20240605;
        b=JU4G14nZ8/fMlj6XBLOVjW7Cxk43xWstySmvRyM7emWek68RpJdHsBlZTyl0Zxh3uE
         ykcZA6B/hPxuWFMlL3ndV9MrEv2d+G+PFTxTzieXhJbtBGlm5ZGx9HuMC/GSDolc7J/3
         NP70dCvPaNyvUhsyriXwWkGiUt/lp4M7vJkprdQlsgVg/W2B4ewY75AORrlODUfZKBcY
         WebbvWF4usUyY+1vB1eglMEGietVKvhWdgkhG9HWQl1OAvnmG//1H7CocIBMyztKh90Y
         hJDNIY5zWKNLJkwBip04H+iyiZIKgUA93/xcF5GAzrGI3gyJZRnTYpjq6eFAbuJ1XF0n
         3nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9aoE2cvzR3L9UndfGy0Fko9NHQ4W6ziIBq/7MIgze0=;
        fh=oNffNTFsbRIIth8jVAdLvznLb9E+VKvIkG++7l+mMhQ=;
        b=XcBqy/ZEbBAKS7dbn5ZF8+98qErXr/YWjHoMaISR2dwhp69pJPFEIFTs7v+m6P8mUv
         Pv6uo4cL07buURKvC3o8uSDm3NG+kcK2EPGCJ005/IVmC4almw6k+hTnTpgTUCFP/wWe
         ihpohLLeh5rQ2PiuopgT+cCGwpptiCv/RVhdAJYyLxeQ2ATUyBsuqgRHMbJ6KpCv/kul
         Tg9gQhOcAG4LQDNYmK+ma6kJCWbbk7p8X9aOIQyc3Lr0+oMTJW028+B2A4illVs6k2db
         /5zghsGJ5/pW9zrax+mdLRMx3hiOBD/j/k430ToFldW6yE3BEBicxAP0l58lMn/p/BaY
         jl0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781085977; x=1781690777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9aoE2cvzR3L9UndfGy0Fko9NHQ4W6ziIBq/7MIgze0=;
        b=co7R47crFAK79RZ3ZoHbgb+9oZEQJ1M7KAIR/m8UU3r9zC5ygKSglykjoCPG5TF/cG
         XbKg7w4fsEOcyEV/rtLWmr6xDW+FhOvS5fpcAdmDM2iz5HDg0EaIBAC3UXSU0vdPS60D
         MwVnzg4rnd7E8qkbPSQng+aBU4i+O15PqxKiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781085977; x=1781690777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C9aoE2cvzR3L9UndfGy0Fko9NHQ4W6ziIBq/7MIgze0=;
        b=CtjDhsN3RRMigs2kfnj+w9YJ8rpq3UFY1AHT9Kv7gwpQD5lqs/AOckG6UgEjb8oSv6
         dNjRJ5FQO3W34ITJN3o4/rRUj1c0WEbCX4nSOdapVLZ19SLCIitnzDsXlt6UX8T636Ah
         2ZPMZg0IjsMCTiJr6SW/Kepk7iZHEAAE3JhzYjyYWs8jGxIbyJ+w5w8PCKzfADQMgN63
         uQp2JrR5Vj9q2rVq1YU6TrQxiMuzSPp+5OJsadzzDNTJ058II4PNSQRvBNKfrtLHCOvX
         QCv7y1AS1boTsIKwLiFVFEDeV8x8SMhy8NNTyijHAMpHQJxYDGCBvyDvN59B377QeZ/N
         I5ew==
X-Forwarded-Encrypted: i=1; AFNElJ/FWFrI3EqrNextiV8VF+9i9nw09k2Gs5I6z50mtdO4ino4RfjXseJOayGLuEvsq8BMWMJhXu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4mOG5IPJgptBoRfmzI9KKsN/kkrkXxgrTc4Bwo85MENEps3n
	C6T5x4EmLNcBmWxYfxewB7yDfNK0CEv3KYOABs7BqOidNpK290qmlCKc2+mcaBqZoxOgunKaUI0
	JAKVK+4UkBF4P3XAyKfFZq5Fy3AL7SLYJw+qpzdv+
X-Gm-Gg: Acq92OFAO9WgHBNR4yUWeKLDJ8Ute3/vOAermpA+UlYbTDJpGuSfADT48Qs6+sgMGgw
	OZE2rogufsv+eT6XH5WZVW1YkkyVYDwJAAdJUW8/WVeb5EOyHBlyLCDpElHEL+uz3KCwUPpYsHx
	QkZe81GiNsgUyAPRbjuxnOvlz9qEp85dpj26dC4yzkFSD8UFRUY2tOFNUQ3/DnNDyRxLOhNMgQE
	SRj7/kQlJ3sMSTy2EZRnLxo5Yla5Wd1yxQPAm2p4Tprh44StIUYrA3xCVL7eglEZUMDXZwW2DBL
	uovIC3QYn0pKjIVMvro=
X-Received: by 2002:a05:690c:6383:b0:7dc:2161:825e with SMTP id
 00721157ae682-7ed0b779107mr238281347b3.19.1781085977117; Wed, 10 Jun 2026
 03:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609232521.1602334.0764789957e4.dualpi2-filter-no-match@trailofbits.com>
In-Reply-To: <20260609232521.1602334.0764789957e4.dualpi2-filter-no-match@trailofbits.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 10 Jun 2026 06:06:05 -0400
X-Gm-Features: AVVi8CccE79IIi6Jl-smWcKAab3jgF9mNZ7NIaB8AezIsnc6W-TPAuXGh0gT0wQ
Message-ID: <CAM0EoMm5u9oWh8g1-TyrGvuAaCvfNBb8Jg8sWg1ZJu8kcrb0eA@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: dualpi2: clear stale classification on
 filter miss
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>, 
	Olga Albisser <olga@albisser.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:koen.de_schepper@nokia-bell-labs.com,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:olga@albisser.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297589-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,trailofbits.com:email,mojatatu.com:dkim,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3EE0668283

On Tue, Jun 9, 2026 at 7:26=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> DualPI2 leaves previous classification state attached to an skb when
> filter classification returns no match.  The enqueue path can then act
> on stale state from an earlier classification attempt.
>
> A filter miss should fall back to the default path without reusing old
> per-packet classification data.
>
> Clear the classification result when the filter lookup does not match.
>

Why not just initialize at the top of the function? Something like this:

--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -346,6 +346,8 @@ static int dualpi2_skb_classify(struct
dualpi2_sched_data *q,
        struct tcf_proto *fl;
        int result;

+       cb->classified =3D DUALPI2_C_CLASSIC;

Then you can even remove check around if (!fl)

-       if (!fl) {
-               cb->classified =3D DUALPI2_C_CLASSIC;
+       if (!fl)
                return NET_XMIT_SUCCESS;
-       }

Would improve readability.

cheers,
jamal

