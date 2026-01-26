Return-Path: <netdev+bounces-253607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAp6Kdzrd2nlmQEAu9opvQ
	(envelope-from <netdev+bounces-253607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:34:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A3E8DF49
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A7E6300A5AE
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD13090D5;
	Mon, 26 Jan 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CHOrEIw4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458453090FF
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769466823; cv=pass; b=RrFT8erDnc2t6bVxkcIl0l2xhJO2R2vUnMZjohj8mxWHdZlrHuug+pe4RKGhL2K7ZEmipsUcn+6kfjd+mLt9gkhgm+5PQ8hF17BoTyc+iKgUpcCdiadUqQwegM6naKFhrPmU+uF3iPhqb49ZZyf0MWx8grWUVEgY/azPa/nifaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769466823; c=relaxed/simple;
	bh=lqktNIYdTMjsWu0O9cUIJZqK41TShWavVm6Qx5DAnug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twIj7e2pMPZZSWzyNqX/fmEs2mX3wupbpuAtpIWSDeo/Z9sBbjSVbqOaxEclYhIX9QJSmM7kMW/oExdwlHSx3GS/BkHbeeHYbgA03BeK23iWjNIaLofd3PGRVgIBJ7anWoHvQWx4XiRjZELa0Q2hV90R02j8Ti9EYBISfivHScQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CHOrEIw4; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c5f0edc20f2so1287914a12.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 14:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769466820; cv=none;
        d=google.com; s=arc-20240605;
        b=XK96XReN2qoAJQitTNgAdRD71RCZsE6aFFNZ0y4VGnp4VfjlPBxn8eeFi3de6uwoMl
         /Ik0da3nqMdkFwmE+HXPodWG0/oegV9NAMyeSpYwYS9iCD9OA96VnZvu4wC3IojHFDaI
         5XVDPW15CwZRHiZ9R3o5g4EVApxkYI1DGvGEaEux0Zi1FUuVNd0dLkr8RBJnjYXridr2
         1ZOudObXzLQ0SAIGtLWcH2AAjxMXLY6Y13dr7ZUVHGgOWj8FxApPAWBn3jBrf5EqinQJ
         FcRh8nA4rLComAR4Ob8NWfqFEPDp+MT7BT22Paftvzdku+yMUpuJDKTZlwZTeBWKlKbI
         0MqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bqx+C+qIk11wWsgmR33KllavOZb/V+0+I/Nz1DadbxI=;
        fh=4C7GUFLa0Itp/WtWiJYDatDTtORgosj9RCFHExiBWvA=;
        b=LD6KawlVsn7F+4UDtLXcDRmMPwGNb2XIe6JoIK3Ne36OPv2JbHMhDbygAvNhZHBGJ+
         2ELojasrOyWYQkKNuIYq6lnLAgAJUHP4BoO/IbCOKSz8Qzfb59pUuWbTfYUnCUOZgaWY
         unAG6zg3HDnyyp0ZIrgC+Jta9W8Sj7jg1j1zHBAclMorpCJ07uJIvov7AgkAS82HYkQ7
         HJFdTWLxkvY+reScNXxm3kcaBGnpd+NgoE6WWnpzI1MXGW3cP1uSEhlVOHU4zAPHIrE1
         L15hODkeFB243eDKXMybVgE6gOjb/sy3zKUDLnWXTJRHcl4sJ8n6R+IURmGKHiB6DFmc
         dNLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769466820; x=1770071620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bqx+C+qIk11wWsgmR33KllavOZb/V+0+I/Nz1DadbxI=;
        b=CHOrEIw4Wv29h3+6QT4reb/wOWcq6qriGJfMqVdSfjJRC+v6NkbxIMw5b3jKUjBjSm
         VePFbfH24Cbeq+NbnkQKYvW0h2W/X/Dvzk4jYiFACUD/R7fdmSeggpXVNdAUVCQfVUFp
         z+Rxzq9LBV5Wvr+cAVtlfURKglgzHMq5v8tzXPkR9TzjCxBTdnG2Zo57sl3qCQWA6AIi
         5Ja4UXnPoWqp5YEj51n3UaneqVwiavLJJiSqmYavlydzvDvPtXjZZI7EmUTON/cOvUtS
         DLRsw9/zJRlnom7kcHOFhlyLeJuBAGZjI9vstGkW95qC/78WXB6Kd4d2m5ASosAfSk2e
         Tftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769466820; x=1770071620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bqx+C+qIk11wWsgmR33KllavOZb/V+0+I/Nz1DadbxI=;
        b=p0qmqKkCB/a99hK1MS0B7mKUzPXZUksVNXdlAe9lVuGSxyCiHwb1qZ2dbu+GPNJekQ
         lAnG2U6rLcwonH9HJGalmR06/SpJFwt9pCV5O6nWf2thit051HHl4Rhax1I62MAfBxJa
         SxEL3PB3grpZmQLheT4FEbmtsAJeZasvTuWAgo83xMQQCiOqdat/2HgzoCJfXlu09rvS
         ivXU64Kp4KyD6To6RdcjCBklUIDxzRhdnJlXcbk4d0hPbRrQokEnllS+3Rzy5FnasYC7
         y+UeAe7WttqSxflgz57iweQZW7a3MNKKxQoHLkAwfk9xYLuR9YKTbaIiPKW5ZFoNNb+T
         q1jg==
X-Forwarded-Encrypted: i=1; AJvYcCXwFvcDYHvW0dlN0HUWEBso1dnydQRvi2exksLPRGzZgglYjq+mEkAfcH2Ml0aJkiwScVbOY80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZ9GoiEKHtBcuEmHeehjUfkbPBtnxeFgcpUknMOcSBcMNLbuD
	QvKovoVBi2bNfDviIZn6TLHz+W0VYyvPxrwix1XmPY/klGPs0ZFV0u/K6akCrMViev6Q+d9QteV
	MOL3lx1AKM6T9l814bZNbnSIefzxK4V5YEqXxtAlp
X-Gm-Gg: AZuq6aI8KMtCUoYbZ0RBgkBylCvvH1XmJpGZA7U9jHCJtz3pYzgCWoLcJvetzx+RSvc
	oopiOyv9qOo5hTCyqhk4Ug8Rc5oMizog2FSiAjSFwntRwPGkULeoIdiZNUl8dM0Gj0BD95v/kiZ
	ur9zb8vIO8127YbDb2m6qmPPN0eKOeeGBsjSb+fxf6mDX+HlLSWjZ/p37YSqirnR7V3/oBQsij7
	DdlH0GF8AmZE3pBU19cs63KIKSIBrM2LjIq3DMzeZ4H4mYCvggujqt0tx8Hql7fmFn8R2g=
X-Received: by 2002:a17:90b:1e06:b0:343:c3d1:8b9b with SMTP id
 98e67ed59e1d1-353c4178d54mr5402949a91.19.1769466820557; Mon, 26 Jan 2026
 14:33:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
In-Reply-To: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Jan 2026 17:33:29 -0500
X-Gm-Features: AZwV_QhFYoGZJWFWXPGpm6UGxOEvHZUszb6YUhYdp5bqZLkPloc1U3Ty7KU9dDQ
Message-ID: <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	SELinux <selinux@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-253607-lists,netdev=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,i-love.sakura.ne.jp:email,paul-moore.com:url,paul-moore.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+]
X-Rspamd-Queue-Id: C9A3E8DF49
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 5:13=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since xfrm_dev_{state,policy}_flush() are called from only NETDEV_DOWN an=
d
> NETDEV_UNREGISTER events, making xfrm_dev_{state,policy}_flush() no-op by
> returning an error value from xfrm_dev_{state,policy}_flush_secctx_check(=
)
> is pointless. Especially, if xfrm_dev_{state,policy}_flush_secctx_check()
> returned an error value upon NETDEV_UNREGISTER event, the system will hun=
g
> up with
>
>   unregister_netdevice: waiting for $dev to become free. Usage count =3D =
$count
>
> message because the reference to $dev acquired by
> xfrm_dev_{state,policy}_add() cannot be released.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  net/xfrm/xfrm_policy.c | 35 -----------------------------------
>  net/xfrm/xfrm_state.c  | 33 ---------------------------------
>  2 files changed, 68 deletions(-)

I didn't make it very far into reviewing this patch, because it looks
like xfrm_dev_state_flush() is called by the bonding driver's
notification handler, and I don't see that reflected in this patch?

--=20
paul-moore.com

