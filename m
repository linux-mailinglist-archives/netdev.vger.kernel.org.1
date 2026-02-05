Return-Path: <netdev+bounces-256973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGyyJJUrhGla0QMAu9opvQ
	(envelope-from <netdev+bounces-256973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:33:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA4EEBF6
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 659A93005990
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D731B839;
	Thu,  5 Feb 2026 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0/L+1x/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2F331A7E1
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269587; cv=pass; b=AH5lB4QVwWsEG44XHK3ulO5I6IGKZ2HcKkZQ5Chod3KttNX5rUUlSIvDp1Kal5ZAaxvdpK27XiRUUzgbYJj6F42y6nHIlaYS4zuOgP3C1A1fJP96m9zyk7A88zpNy7jA0BYkDUb1cLQV8FuufGjnX/Fah8VDQ+Zq5hT8ZIX/DX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269587; c=relaxed/simple;
	bh=9kSaVKmbEmx7dl4mHCrwy9Jcwf3sHuVa6Lj5kVAX1+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlI5qWLCJi26r1My01W5I8ZeCJeZrnoJt9XDjKMZeMaRzZBaj46pfHc6eeqQnRq+ZECFMtUA3bsLpwE11RrTmWIMckz2o3hspHeLd+1kZhhh0PlNVcBlSIJSu/woba8GTma713O+suB49shcg6ZdqMW2fqTKPnfy6miQmdF1QwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0/L+1x/; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-66ba1095bdbso350877eaf.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 21:33:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770269586; cv=none;
        d=google.com; s=arc-20240605;
        b=g0YIOdaHzzZIsNZ8nHLJo6XYxKDRoFtx2hoq6Cxkasuik58hOjIGkqugB34HRb/jBS
         h3YpMT6+aXP+OUKeDBGhBG7SXb/TQR8eJf9XbGIeSG0jPm4n72tAfIp8CvhUxfSsCVVp
         Efqw3kJiSUWxuwYUm9cjp0doIWMcj+kiYbryyht0zH5yTiaapsjDzngxp2IGaKGJP5TM
         GiROKsjkfRfL2blPnWDsuzw3ffQduLnzmOWeN329m/K7GLdHMUIyJfXLJU8pyyQIZtye
         VBvibIkJ7dZqj0hijvspaV/ZbZP763VKeOH8ix0qybOJAGENXVO9xaQZR+JKUTA503cQ
         KaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T0p6+UU56fdoeTKiYXJhNjx4c6Av4a0mSHaMsBhG+kE=;
        fh=hpSyv81AGHSohZYPanwOHB7hcXmy9jkbnNXTwfWlpb0=;
        b=Vw0EtdWCnKhZForMneovpn3wTi0bDLYm+Ufw1ks67sYJctD7MBjgYmGfhuBLXFnCSf
         LIB/2kRLZ4VPVDr3kIYhfOGVEOpgxs/RsHPFB5sGZGkYMwXvzqcxg3AlFvhzjqnJz9Qo
         4YpGk0CuTF/iC2H9fiBqlqzmBDESUhNTfhgR/VQFXwSLjI+F8sZwvo31aySzFBITer12
         QHrV2SHTWh0LRI0Fxd4UiTdknSxqteQv+YeASZssts1jzdFnk28Da5T3iALyCBZrtvfb
         cLCggC5ytl27KuC8UCnaXbyIhTt4NYzYBIFve7KCTWihGCiBaAYHa2+AE2zJYTbO1vUf
         FSOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770269586; x=1770874386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0p6+UU56fdoeTKiYXJhNjx4c6Av4a0mSHaMsBhG+kE=;
        b=V0/L+1x/s6G2ea5MhldLF9CyVYy7CCw9P56RomJSPpcYSGTgZ81ALz5MPDmIZWATY1
         i3+tPk3miJMjQ/32v9TaeiL86KfzSbSaNvGi2JxhWL9bDVcNNW/LsNyHfFjxgZw6e5u8
         dipQXGdCtQZgQWPAPsdW0H+9s/BcewrFw+xeaFEI51gjLXlef/9sPGCpUJzsCA+NQLfY
         Wc4J3jpW6u2L2HP6nSKht7h6Q6wH/xlA6zTcX/bM3Qd7oQBUTMXv2i01Icr8wfKW/05i
         sEvFV9zyFr/aN04wHoULEEI2tCfGLspNgv29n+dzyWRYd4LxXIhaA1PVLoluh6ebQwom
         nxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770269586; x=1770874386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T0p6+UU56fdoeTKiYXJhNjx4c6Av4a0mSHaMsBhG+kE=;
        b=naJ0lbEpjlt3drIQcJ3RxtsYgDIndTRj1QQSS+BTW6EKronPq6PILm+vjEG3YtzCO3
         81Qo6+TIDWFfuXifpDyneUbbfAe1MBURrX6ziABKhHk4YM1PqxqNK56rHG8NpDKZllPA
         gpZkr+R9Xj4nYvQMtMSZQXx8yYIUR8IVA6E0HxhJvTnr8RwKI5bV9v51aCVPDB8BgWw5
         KPdKnMzuvR9dnjb0N5skDF2rmoEXJE5C1QlP5kfxSSyslmK8ZanWQlIuRoQNvpkIAB2p
         87KY7qzCHYFkqvBfQG/1s4Kv8PRNNmNuLfz65m29tb8XuqaL/UYASjAE99www1k+4Gzh
         x9Mg==
X-Gm-Message-State: AOJu0YwJn0EfEmsTUTvXU0shJo2yXt+WMtDVWb9HxR1HIup7vS4gWsUs
	fXNG2npe+Ls/ezOP88fwelg6sdEkgAdu2FwH4TJ2z6+eLnx0/LiC6SUFDkfi7ESlr88MKj5AxB+
	r6A6OBc8kfAyuXrjGiIUvjXjnrIYq1qM=
X-Gm-Gg: AZuq6aL8n8f/c/oWyztbAg6IKKPasj7j4JPSNHs0IBLqGWL6qB18OE/8zttwG8HW+rO
	/VXPuttESGpAbwkvZHGcLuC9PRulaEPAFGOcVaIjS1WnucZOpY/WlRzk8q94tKaGg2H8YSjv1MN
	cI9Y4d7JUvMeBZI9AZ2jGOiO6qojq5bEVbHHQwHuQ+GfhVvNXavPMbvWubkLambMiIzPJYmDlmZ
	TTf1e6aJfm3mYPyPwiPreiSK6LJJ3URGRcctWdXwFeJw5JeLFTzJIxv311z1fTobUO/uWjB9Rqa
	ZS5VpD109E9X0hhP9k6/zOyh0Zqvdg==
X-Received: by 2002:a4a:e049:0:b0:66b:8c7f:6c2 with SMTP id
 006d021491bc7-66b8c7f0d72mr913651eaf.57.1770269585603; Wed, 04 Feb 2026
 21:33:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203171305.95085-1-mmyangfl@gmail.com> <20260203171305.95085-4-mmyangfl@gmail.com>
 <20260204211252.71b8fa86@kernel.org>
In-Reply-To: <20260204211252.71b8fa86@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 5 Feb 2026 13:32:29 +0800
X-Gm-Features: AZwV_QiSboIcl_zN0LI4N_HOcELIAh6t0pprNBheKTrw2yOY6Udm5qDHbkSmF94
Message-ID: <CAAXyoMNUSQXNCdzLWNimvu7TPV8+60GVcQASFCS2-N3d9MAmsg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: dsa: yt921x: Use u64_stats_t for MIB stats
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256973-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18FA4EEBF6
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 1:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  4 Feb 2026 01:12:43 +0800 David Yang wrote:
> > 64-bit variables might not be atomic on 32-bit architectures, thus
> > cannot be unconditionally made lock-free. Use u64_stats_t so it would
> > still be lock-free on 64-bit architectures.
>
> IDK why we need to worry about lock free reading of those 64b values...
>
> > @@ -771,22 +785,27 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *d=
s, int port, uint64_t *data)
> >       struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> >       struct yt921x_port *pp =3D &priv->ports[port];
> >       struct yt921x_mib *mib =3D &pp->mib;
> > +     unsigned int start;
> >       size_t j;
> >
> >       mutex_lock(&priv->reg_lock);
> >       yt921x_read_mib(priv, port);
> >       mutex_unlock(&priv->reg_lock);
>
> ..when in all(?) the readers converted by this patch we take the mutex
> to refresh the stats anyway. And presumably do expensive IO/reg reads
> under that mutex. So just extend the mutex over the read section and
> save us the retry logic, please, it will make no difference to perf.

.get_stats64() is atomic, that's why everyone (mostly) is using
u64_stats_t for DSA stats.

