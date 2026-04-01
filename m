Return-Path: <netdev+bounces-273876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kARgCwCTzGmbUAYAu9opvQ
	(envelope-from <netdev+bounces-273876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:37:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C582B3746F9
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D836930222E2
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 03:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D765358399;
	Wed,  1 Apr 2026 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtANjteP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451526E711
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014652; cv=pass; b=lrbSRa/whCaA+s3VqFqBFC6qa7cNHwY8RO2a+7CHMXd2BuhGMRro8RgTnu/m31jQ/E9qRx1ifyYis3SDOmDE6Jpu8J+TNExbYAViEBgc5RC/GzwY8AtDt7zCro7ub9PaNDQ8lyWpTlumIXTQ+OYRoK7HfXnPG/amUubO3CMoBx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014652; c=relaxed/simple;
	bh=DJavs6WubNe8I3IgWdFE0PeQ3eOcea4dVFetsOrAn/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUZvsz2QjS+X8RftXvJYjCpqN9mTUHk6fS0cabXIK85czuQCTm5uobkn3TXe/i7M4KBXZ5Dm4BwxHSqJ7hy8ivTGDDZ0s7McbvtoSlihumMucAC+/gXXraBKRAJpxyjvZ2FG48We2o2ogVhrwk2pHXOi/FEnaS/ZnyVs0JhYZuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtANjteP; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a1443780c4so525093e87.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 20:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775014649; cv=none;
        d=google.com; s=arc-20240605;
        b=M27cWX5g/YkB+c7WYT1Hsfhw9J6ww7Z8pawBeUvYUQAESqicxkS1mBGBhcsFkvkvgG
         mUSX7MdvG09XyHwiXSXvb6Zj0kEt2RLRVfmv0apyGYhUeaUpMLGTQCFggA0BNOcwsK7Y
         3ssqqFlGo5iBwdwzL5W4cP143EXPvQtY5ghicEHpq3lvPGu35+4/Owmm3gzGHloqOEHy
         jfsC3J4niasVTPUIcVVE6OiZc6AEq5hKUqAoI9j3JGrdPQtMFlkC6lvSdVy+/bWncsE3
         H5HfHEv6zJHpNeHPOIH3dJeJgHdo7I98EiAa2grh4X6eUMmY1D4pOQ9RTPAv3AHslNwZ
         ySiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DJavs6WubNe8I3IgWdFE0PeQ3eOcea4dVFetsOrAn/A=;
        fh=lkMtY96ODPi2jmz7dGGDlvtbdA50oIZR+84u5rLbwpk=;
        b=khfNyQ1w7SsGM/MLN45Of0wmACBQBQGqBuyWsDUpGqL6YE72QRilDDKdoa0iJ6Ti+n
         Hcj9gUgNDo2KPcUKDWJu3fztRyXbReWCLUElB02LIDmP1hWCW9hcVNbhy/HvwMtjNDlB
         XkEe4Xd95V029VJjwPvpzcSTUSUPzSnfapKmKXyDWREUYTgseS5SzJJ2Lacbz/qz5oGB
         WNEbKLdq4L2oH6vBd6JdgCsk9FxAoebhNlYtyzNSXlOwdmwo+S9QaoOHz1WPwtcxdveG
         FuoVEuxBSG8+MgexsQPRbcMI3f9zLimNADbqr4DUtcHWqvLZTwQOzVeahlOsdy5zOqx/
         oJOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775014649; x=1775619449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJavs6WubNe8I3IgWdFE0PeQ3eOcea4dVFetsOrAn/A=;
        b=mtANjteP94FJCNqdk9wVi0FOpVryN44C4S3BoXRKOsxNSBuiFe9PvnUV/uXSq9BCAa
         z4QpdizC37O+kOIlshyqDTMmX6AhZg8FAj5oD5xcJT5pLGRFexEfU6wMnaJVh92XqNts
         nC2yqlZ/tnhzUzJ9IvuRiTfA1MRsg4IpePqaMzvEeHqVVKB4V7tIzePstbJz1tU+MIUQ
         vse6bUgmmRKdRAASopR9XWNQcFg9iqqR7iwngTG+LgG6z6MlZLgZoLmCjKAiAmqtItJt
         fHTJbFV8A1L+8MH/NOS9+h0DLE24BIrulIUkT/XTTUjzZCJgMZ01b5QXwnrv4raYc4Vk
         djSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775014649; x=1775619449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DJavs6WubNe8I3IgWdFE0PeQ3eOcea4dVFetsOrAn/A=;
        b=Ewm1OwxhrxZP0B6SQkbb6sXdAB6lc31xEf+VpYcl9YRpJe4KOzlT0KFgNYUxG5epHb
         IgGhi9Rw+LGmdETQ0f1oput1SV/YH5dAYPL3d5SUbZIcsosNSz5dPzuysc6EW4YtovCq
         JzcSQbJiGnasAAkURURX8t4/B/Pae7NlvmSxzvlLj2cGHrMTwNkDx+5rujwxvG3R9e0F
         gq7+EJOvfbBsXxktd3iNKk7s96j3ZUcVE49nIAgC+N0tP423XzASj4UGKfNH+/j2rumf
         vPamLOS8+FhIRWl9PA8oSaY201F92nmEsI5ZrCuXLe7XujQ7hftNiVsvNLYGPNwdBfTU
         2+ug==
X-Gm-Message-State: AOJu0YwWxp3I56wai9ZC8jaxwIsYpZhuJDGuMGG/UF5m/2oIY1QBxwir
	qP2IFGKa1gqPB8Ye2M9AzvfVFk1L2opPHdXIqLKK+VRRrIQ0kgJhg3YVdgNVUe6oHQj/2L/3oRs
	/zhVAzaRap7eWACFR48mpSzxlRIHTUs0=
X-Gm-Gg: ATEYQzx86UvYOChcfx1aK/FMuWkABY9b6zER6U06B/lSvkI7M+RiryZfBjzIr7sC9P6
	q8m/VzDehkz+G5DkIO5hCJmwT33kxpOsz5u7bLHvPz1SYDbM4VuFdlkBwgIBCp3VqkIfL4lmZmI
	B3Td0OnB8xpKhw45DyL+nOUrX9iDNJLZMaxiejZ/Z2Xfyz/yOxZymR3XEMGyJtp7nu3u35aWyVI
	rTN2Ffola5KuZOzag6A3Uq4I1HwoQp4z0V2VF9BDAgtydGARtGp4iJKH6XmN0n2cyCW1p3n6xke
	qmAZy4VYR89n7HLl5Cg=
X-Received: by 2002:a05:6512:1589:b0:5a1:3d15:2861 with SMTP id
 2adb3069b0e04-5a2c1ff571dmr548998e87.6.1775014648976; Tue, 31 Mar 2026
 20:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401033211.44463-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260401033211.44463-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 1 Apr 2026 11:36:51 +0800
X-Gm-Features: AQROBzDnJw5dELcgk4bgjzpYhlOcjJ1YHGinoZajBT9lcbk918nDf7WsaMa7Hsg
Message-ID: <CAL+tcoD=CcYNMbCMLdRFG7y3dr1b9mhyLOEPts8xB_EgBHXyaQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: advance skb_defer_disable_key check in napi_consume_skb
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273876-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: C582B3746F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 11:32=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> When net.core.skb_defer_max is adjusted to zero, napi_consume_skb
> shouldn't go into deeper in skb_attempt_defer_free because that function
> adds a pair of local_bh_enable/disable() which can be found in
> kfree_skb_napi_cache(). Advancing the check of the static key saves more
> cycles and benefits the single flow/few flows workloads.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

OMG, I realized I just uploaded a wrong patch.... How can I withdraw this :=
(

The draft misses adding "#include "net-sysfs.h""... I will wait
another round of 24 hours then. Sorry for the noise.

Thanks,
Jason

