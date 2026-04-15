Return-Path: <netdev+bounces-278837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEQVHXm832mOYQAAu9opvQ
	(envelope-from <netdev+bounces-278837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:27:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B766A4065D8
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D895B30182BD
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE46C3E3D83;
	Wed, 15 Apr 2026 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsTzk/9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE13E3156
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270333; cv=pass; b=kad2oBHTP2vFLGMdNaJV+N3BysYpUQy0FLSv0W6ceJ6CADxB2dol0WyggqrI55til/fELv8OIZHjazXMcMZ6Igz6Lfd46bPIRntI6KFQqoCiAQInwwozJCbSXxS0Vz5l/sJuQZTVt8odls9flN6I7gKRNn1QHaj9B9aFlJ8pmAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270333; c=relaxed/simple;
	bh=QuR3dKg1TN4OsmD9xO6pEl7fFdVxGN6DcoplqgRVEBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8mpBRo/UFEVGn3QAB1TtiHBqepFO3Y490cM57583yg4qsH74+eet7OhUJrEPuD0GBnehI+qBxM6eBv/ADL2jDqYQFFgtrsMcGyCbaiOtPsQo+9bGWBMekpswmGbFrx8IPLh1HUbmnvGpDaqfWFkYqWkagGLqX/Nzj2JlNdKu9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RsTzk/9M; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d59d249fbso72677841cf.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 09:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776270330; cv=none;
        d=google.com; s=arc-20240605;
        b=HctnMYrN2vKvu66IclUPL/9bqQd5jXd4cL/dodfXtuVipL1nS6yACBrDWddihVP9M/
         DE51Nl0WqvTVHqefjXt7F6yTVzsX2D2hoIjgOXTNMvE3QjE4Kn3sktrz0AyEbZuu7EQe
         xDlUfvG9aj37qEmN3CMT9o9nrOiuxj8eZdTAFegxyC5AEGaf3pyspWx0+0ktHXP7na6c
         qk6+HWK6t3rayPwvQ8InQ+IRkimBYKYaiJ+mewA4ThGSWLj10+Ix1W4/HkP8KEuwPPkL
         Zh9MuVzITZyfjYCZbWwdY9cMTpiNUpf8Fo3Q880ID7FQdo3EJfeh6MT+nzd94zJExhHD
         8L7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9LatLcJoEtbPVDtUhRCMlQQauytEzpa6+Rv0uEn5Yp0=;
        fh=mPPXmuklY8iDgab1VxZuKd4VR2l+Y6GCZ1EE7QWUSrM=;
        b=O+Kqrr9dThsDVFeH2u4dOnH1kzeI1DU1EPlZMF8OlryZZi8JNLnh8hIEO4Tj9D8faB
         bVJB1G+2zFmBJRa3oMg066OBChushSs9jkVs58FPuIqKvwMVxLhl0aMnDt5sJcuNCSnx
         wsi5Q0XU0MoIyafGxQFkWHboKoF98RnPXCQLNYgpBiOOMGpWwZFEdekZgbcoMeq/5iPI
         mOOSP9BPeGNs0YlKISnj18pR60FeV01jVrzkzoBJMbFpIKdkxQtE4Mi6g3RLaKdWNPY8
         HSid2V6YVN0WqPNUMWxRurpM60+Wxx2tLUhmospz9bB45GhY91Z9p5o4aTk6I/MnAWZW
         r9lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776270330; x=1776875130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LatLcJoEtbPVDtUhRCMlQQauytEzpa6+Rv0uEn5Yp0=;
        b=RsTzk/9MuJhqaB3rzRLkdkXFnpJDcA/FH2+YG7TxcXx18vTfkZaCbl4csrwTIJSBo6
         970aBbOgPlhAUcSHdy7SJgwMXGNc2zkfp7LLnLSI42Lol+V2GuYws9YAYd/x5O3zX5Rt
         IJmcbi1OPtz4U8jHJHlnc6ZrRDUkL64Yzi5k3UYL3rfOKL+avewjBw53pq0CbP9Hzuh5
         FhZchGTQAPt7mOtnsLoAcr2xjZQMqI8ZMyEi6ECJdLX1xuZ1Iy1QUZz0rRdwpqm73W0X
         7LStzP/6keOXh787eF9xTZJf7G9IcEVFMcYUxI4WQt8F77S2I6a0WknK+zMVCJx7st4Y
         slIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776270330; x=1776875130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9LatLcJoEtbPVDtUhRCMlQQauytEzpa6+Rv0uEn5Yp0=;
        b=aZObyezUSJh6jrAkGvp4gMpKX8phtWANRlTbijTswKiuoFIxBt1r7oNRm2QuEWBs7i
         ngU7NZ/jwS7Ix4nyhDEahmZeO7CiknLlMW8jT7OR1JHW/VpipAX3drkpGx/mDQXnC+DF
         UmhpAKFcddGQkhABquq02uj2ycPszp59oDAdlEcFxQkoZv+87iX9rXK0sQ9fNWj62xFO
         dlrW9iJ7QmV18pVx8oX8kKalkyJj6f2BgGPgfBhqIgl/StNHAzA6JwuEvqrSs6601RJ+
         1Y3qRfx7o550G+lE507ZxHBrQwmNoTQtFFD03hr8d+fybAkHD6N/RY1BggyVvFObIvUm
         qeOQ==
X-Gm-Message-State: AOJu0Yyfb6c0bE8U95tn3IT5/ssju6LBY+L61QOx6xiUXjx4lEMHRgyB
	c/LXKvG7nO8yOsKuTjvzyNMKjRIRe8fxxJx2CJK/IGc9ZyuDy9SWo+VgdsspKp+7Qjh+c7LAtUJ
	p7GK18dGxSdC6x4zO8wimH1X4qeiXe+1AW6WnAB4r8QZxd8zmSnw3kn5M
X-Gm-Gg: AeBDieuZYRwCMa9J4mgimZ8e3L/UI3LpMTahN/7tcz4dkYyJXFVAHTHxfnRye3rS+Ma
	fcezeR940R5cu8FaaiA19PoHRp4Sa4ixF6ExnR75SXJBZlZ5N7HSgWtWJT08FXQmV+WcXG17PRh
	7gEfNOElY7JnRwGyNzBVaBwmlCZ75vn98ZM+WXA2lhNGGrF25xAK3DaQhSkdKM9iciEsWSwdBeV
	XNwCxtHSs+PvtZ2zOzmfwC0WYFggiuUOgdtYoz7KwpRsrqznAFkJ3BZ05VDBWB+sH2LqbvJOAxc
	+/71l9lnpbfv/tgSWUtIyqou7N+/DTsRXH6aHQxioj0dOCL9AQ7jrE4ylZQskJc5mESt0R5SH4y
	b2yY1jdeJ
X-Received: by 2002:a05:622a:148a:b0:50d:a8f5:d51f with SMTP id
 d75a77b69052e-50dd5ba8ab7mr343845901cf.45.1776270328690; Wed, 15 Apr 2026
 09:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776039122.git.ylong030@ucr.edu> <b877895cd02d35254b5c05d3c40abbf130cd87eb.1776039122.git.ylong030@ucr.edu>
In-Reply-To: <b877895cd02d35254b5c05d3c40abbf130cd87eb.1776039122.git.ylong030@ucr.edu>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Apr 2026 09:25:16 -0700
X-Gm-Features: AQROBzBAq3jqMsg7bTVat29ER8is_ga6cXuUPzs1nGW_FH2POXzPZcKEtzurtkk
Message-ID: <CANn89iLaE=c_2CKPek=A+hi0gc2os4U-a3aawzBA2NkVsb6+fQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] 8021q: free cleared egress QoS mappings safely
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kees@kernel.org, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, yuantan098@gmail.com, 
	bird@lzu.edu.cn, ylong030@ucr.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-278837-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,lzu.edu.cn,ucr.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ucr.edu:email,lzu.edu.cn:email]
X-Rspamd-Queue-Id: B766A4065D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 2:08=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Longxuan Yu <ylong030@ucr.edu>
>
> vlan_dev_set_egress_priority() leaves cleared egress priority mapping
> nodes in the hash until device teardown. Repeated set/clear cycles with
> distinct skb priorities therefore allocate an unbounded number of
> vlan_priority_tci_mapping objects and leak memory.
>
> Delete mappings when vlan_prio is cleared instead of keeping
> tombstones. The TX fast path and reporting paths walk the lists without
> RTNL, so convert the egress mapping lists to RCU-protected pointers and
> defer freeing removed nodes until after a grace period.
>
> Cc: stable@kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  include/linux/if_vlan.h  | 23 +++++++++++--------
>  net/8021q/vlan_dev.c     | 48 +++++++++++++++++++++++-----------------
>  net/8021q/vlan_netlink.c |  9 +++-----
>  net/8021q/vlanproc.c     | 12 ++++++----

>
> @@ -604,11 +606,17 @@ void vlan_dev_free_egress_priority(const struct net=
_device *dev)
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
> -               while ((pm =3D vlan->egress_priority_map[i]) !=3D NULL) {
> -                       vlan->egress_priority_map[i] =3D pm->next;
> -                       kfree(pm);
> +               pm =3D rtnl_dereference(vlan->egress_priority_map[i]);
> +               RCU_INIT_POINTER(vlan->egress_priority_map[i], NULL);
> +               while (pm) {
> +                       struct vlan_priority_tci_mapping *next;
> +
> +                       next =3D rtnl_dereference(pm->next);
> +                       kfree_rcu_mightsleep(pm);

Please avoid kfree_rcu_mightsleep().

Embed  instead one rcu_head in the object.

> +                       pm =3D next;
>                 }
>         }
> +       vlan->nr_egress_mappings =3D 0;

