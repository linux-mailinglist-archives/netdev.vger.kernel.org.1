Return-Path: <netdev+bounces-271474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IdiEZmrw2nAtAQAu9opvQ
	(envelope-from <netdev+bounces-271474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:32:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDAB322427
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E4D3029278
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35378350A1F;
	Wed, 25 Mar 2026 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI6QvE+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC64734D4DE
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430633; cv=pass; b=gjFmsh/W5Zn55pWNUJucZeXOz2BCPHoARUOoQZSkTylHD6clcjDRlQmWnJGYrQiA57acCuImggewJGQIv9zSX6fJEJVzrfriO1RCFVnv8XYCkM1W39BzFoNeUKn+smdmIbgDQzdkWM8I0tfyPxGpact4TE1UqCEHoJj/Y42tjLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430633; c=relaxed/simple;
	bh=DUozAtuV+mXsErOqm9JnWIwOGatNtqQWfbvXsLOZVk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4fF8d816pQjt2qxwlfR3MwNAO1CflbwHRIjdvQOZwXzt6PG7M/yUrlW6RKhEpey1V8fo64nw++7AE2rB0M9DHnp5w+9//QDgHbgt7ZcbCvS90i2tmYkX91jFSlCnX56xHNifxiUoLS6U6aU1UIVVWnRKMnyYc2lxzEfjR9QHI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI6QvE+8; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79495b1aaa7so55850467b3.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 02:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774430631; cv=none;
        d=google.com; s=arc-20240605;
        b=Chn0vk2JdXCb8upwttIuj6U4xMK6jYAYlApFQxvQrtSDuBVr7HXJI9f6qezHLVBrPP
         6cVu2gs3ykhdXokyHcITdklTek3onJGtrhKDvuyL+w4eZIxlYtp0idNZqowdEBBfNtq7
         YUTkuluWS/wROXMfYyanv58xaonoqu423LfSQZTxjm+YfrVvel6CBdo4tDgEwO/gBa62
         Kyy0PddYUFvkVQC+8dK7a+0lJu1ul1eGIE7Cva0f+G8ySiC3uOxz5j2D0uFP0NxzX9b1
         UXd6SPlIHmA85r4WiDU2R7MkuZ7/1td1ImQEpC+4nu27iMKJLIqedgWKpU47agopv9vW
         OPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DUozAtuV+mXsErOqm9JnWIwOGatNtqQWfbvXsLOZVk8=;
        fh=metT8PBEUGfpU2m2VgQBjDP2hgnxduo0pPt9vjkOKKI=;
        b=f7v/Xv+dtJ1WBjlsJJ9dkNhGOPqKOo9hPYVjsjRSiik/zUiTqLf3zPjWPkrFfjmv2P
         d4EVFGwg7HWnYWl5yxUOPOGMFnp6gdLDuXuBp5AEv/73xtRnX3U2Q0hv/XFfbbEbao6U
         4Iq9JfZKNF7b4HC++7iqmZgv3seNV3SWSuegKkf7QPKKC6fEyjmBT/TdeUqgYy9Vm0PA
         +sAxNT+CGfFt9/SpEn2Z1AEs1mGFAI/Ii+Ir1pQxmqZ/3+eQ1YOoCYPbUO+ANRXYhoar
         b6f5VZO05FFZ3NCQ1PNa/NvII//8BNSQAj5FQbd4UusX2YZIWwnzEdYtldqL2daPNOGl
         bqXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774430631; x=1775035431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUozAtuV+mXsErOqm9JnWIwOGatNtqQWfbvXsLOZVk8=;
        b=kI6QvE+8xWlTaK60LvXxArJskCrToAx8B0fY31L3jPRnxzhENZ8+ZyRyZvo0aUf9is
         smi5iuJ3foKq4NhhGk0le1jGhZvb/g08XebyLG86+nggT+dH/blZqVk3DA1KGf6jP6zg
         KM6DcY0uNAudeVMMB13l8KjMw95SKIEIb+FlaIxG0d9Or4sOGzRQrWdrnXG0TxosNzIb
         pNNEEU5ovZFz5dSKPmWviE0PxhEr4wujvODkpJg59ESinRYhxNdhDGThvOwBjfxin7yj
         /Q9KlR99U0w2lW8OERC4PNK0XqFkW03lrZG+ZvNJMxSpjc7YodU+3oxrvcW5hwf7PkXP
         IYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774430631; x=1775035431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DUozAtuV+mXsErOqm9JnWIwOGatNtqQWfbvXsLOZVk8=;
        b=C9QAZxriZ0pEu0SP1Il333dhcfEwkg9eZbiuNiUUq3eaIcJQ9wz5DrrpD53O2yN3xq
         r3urS7Hsf2nFZjwtaeulgJnH1J6TKpzwPnqQqClt179Ic5BGU/v+OESlPAep94FqBh+b
         Pd+yFQQ8MQtJV8QNu+Sg+EmAzMngB8Q1S0ZGS5WGLMkyZKuKeX5Jy2R7rSm1eG4LmGl+
         1lAH+BNK8uMx5AE7dkegadXZbnyJw8yaquToETfezskdzMEq01Xo2cz72JlEsRI6/ICy
         0bziTQSnTJHc4OwFqYsdwMEzQwbROkqk8fg4nw1kS/G8cdSyXjZse9yfmhB2sxZsZ7Vx
         H0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd/h5+do5yi8KNXS9vxaKSznE50J4zDpUZvZsNmIH+PSPqLIChIc94CD5nzGxA+7ZyyrwCdYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWeIPHuC8P+bQOjN5kCOuiK8ONSVzzHwtAj1KlLltOaODFfVd
	HkdOoQZhISemV5Cgr5GmgCiY8R0cLA2mdUP/HHmKEyLDreAGm5R8Ov/ng3btcwaqfU7p/jJjWul
	Lwx3FP0LjlDuf9ak0C/dyaKoj42w5Azs=
X-Gm-Gg: ATEYQzzcYncR5ZlZTqy8wkHtxgYQeD6Ytem1o5zumgQ6z4B2OhT2GeQtl6BLJGxo2z+
	uOUGV1K2bM06O/FzqeLVQTXbHITHogwwPAHGMqeufxpAmzhrxZp+fGulbQlcYMA3ojPPLowjyRV
	oEYOH4pQpykCJjHQ+uuKBJsOAzrVvtzOoxRlddoPqLiNMIHS7/F7fI3BnyhxGLVi0HMgUaarkNw
	7qBGx5HqkcQsyp7kPIv+ARHpOyzQ6jYVzTcY1eOrMwfOQuYJcj7oRkdusE03RLWwNuLHZU9wUjF
	9EGw6C5zBFQBqF91
X-Received: by 2002:a05:690c:7242:b0:798:1637:fee0 with SMTP id
 00721157ae682-79acf696502mr25525427b3.52.1774430630926; Wed, 25 Mar 2026
 02:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305013852.3769-1-dqfext@gmail.com> <20260306170411.49912ae1@kernel.org>
 <CALW65jatv71b7G6jpr4g-6j520RjLBDJMH8uta5MPJHmEM1S1g@mail.gmail.com> <20260309140127.465b6ccd@kernel.org>
In-Reply-To: <20260309140127.465b6ccd@kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 25 Mar 2026 17:23:39 +0800
X-Gm-Features: AQROBzCVqdFuI71yt6DJNcO_3nIjUZ51UkzySbeq1qT2fwYWI3HzxJF6_wjrlMU
Message-ID: <CALW65jZv53Y4-H3civxZLT5RGypsKjb3JyiA6iy0pw-_RK-=Tw@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: pppoe: implement GRO/GSO support
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-ppp@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Felix Fietkau <nbd@nbd.name>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271474-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9FDAB322427
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 5:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 9 Mar 2026 18:46:59 +0800 Qingfang Deng wrote:
> > > Please add some selftests.
> >
> > I haven't written a kselftest before. What tests should I include?
> >
> > I think I can add a local ppp server and client over veth, and test
> > the connection with ping and iperf3.
>
> We have tools/testing/selftests/drivers/net/gro.c and associated Python
> test. (note I have ambiguous feelings about adding ppp cases to this
> file vs creating a new test, adding Willem to CC maybe he has some
> guidance)

He hasn't replied. What do you think?

