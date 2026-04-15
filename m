Return-Path: <netdev+bounces-278752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAxODlB532nFTgAAu9opvQ
	(envelope-from <netdev+bounces-278752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:41:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E90AF403F0B
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F923307102E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E18346A1C;
	Wed, 15 Apr 2026 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEbb8nn9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3933F5B5
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253068; cv=pass; b=rN6nU88tlmG18+ZCVBIqvWBnp/68iq3S24AFbrzQrAXFwoU5RfCMbNs3YI3OCkWRPW14jq/WSp3WEYdSP1j23JDf7/aKdD4paf/X09qwF8+wMha+i1rzEcnYa5Jq8vOF5tT0pFOu1qv5+OCHspTTnmyD5f3jPMrdwGBEK/rMSW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253068; c=relaxed/simple;
	bh=F2FcUY86YrgVYKMUZHJwSgNKCRODsQu9nRb8mO6KJ/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSrsT4szYK8PlhdbQmXYIByxoN6Y/6CLPyJVKUSeSdCKh8kjxy7qtw8oM9CuwTj3tJjFceoY3Dy/M1QYBgijvQg0wHaKYXDjGJREZe4S5eqdtGOekLe5UpGSelBizTertWMJZOSSVWitr5cAA+R814AUrg4llwhRm3kyZsv+ONY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEbb8nn9; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50da9a7928cso54655021cf.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 04:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776253066; cv=none;
        d=google.com; s=arc-20240605;
        b=NdAsX1MnBOo1Ix+06hpxefpihZdEQh6hFz13N5Q3GMhsqb9T56j8w+TO0iJv37Ljv/
         o6gOnnVZ79lz0ptbeonvwBhVdm4TvNTNzGkocf0yBGfN3wnYVdrPZGHwmH5hRhmDJC+6
         CYUh9a4wfzanDdHmuuoQ7ek5JEFidSubW+HcdJfMP3BwEPfSzn7uozkYwXKMVyJwhXXL
         ArMDbONhCM+krHlJ2cipQGF5BCoBKnxJuj/Iwt4hQVqJOP9LmzA8eGdvV/bD2LgvXar3
         k4QJFJj0Cwc/y0WA0KBzUA/JAR9uJdPgEb1dyfxJ4b20O/W9g6I0CfY0yjlcfn9HW4K/
         fH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3layzgo2NWtRymn6C5MvhyLuoFv1OOzS5ddSVv+wVBw=;
        fh=8153a9FiQTSUQH81jfIMyJq8hel2/5FxKkOQ7RC2evY=;
        b=QKDT4XCS9+3vgW2Pb+Pky3zRcy0vatULUXdxK0YgeFhKEMPVJqmv/m95VP3JaQMwPq
         HczRDPAufyBV0Tlq+fyIfAnz395XO4jCflAoztbkhCyP2cX2h+oEfHLFIjkAhtRXm8YI
         9z0YGMtxzu1fbd0UVW8AyyEsnfAYhVT0Ay5w33gTqaGe1eMJtNaWfp4+ORCwCqSjeDH5
         tuDqx7WdOBYOl9Wt/qGhKYnFXU9eKBrN91lvMj2B001YZ8SKTn6+QT9AoJFX0GZfCIWP
         WT/62bmTgyRp/uFBFhWP9yiNXyskzPJi5wnX87qCbHotB4IpWpa7hIFS2e0lcWCy2Rpy
         Gs+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776253066; x=1776857866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3layzgo2NWtRymn6C5MvhyLuoFv1OOzS5ddSVv+wVBw=;
        b=DEbb8nn9sgjOUY5wofGeXsMDouHHp6LLMz6SDSaagLhmNk73Y8BcvWJJ6PLHDroDl5
         LmOON8ckGWMJW9UB0sM4Es0Y2kEGws634J0Fq3Bc7HiKyAzo0jrvtG9LrBcROYTHwa1G
         /0KEZIyy/8vkhfJl4gP7iqstzIkfo2ZiDhiW4EIhokVyGcGP6P0PS8hGKhmf90D7ey0Y
         zjxN/xG0sug7vVrAGDn+bcZYyXH6GdLq/l4S4irnj89rphWA0exRKzQx9u3C1KZEg7z6
         QN7Tbc1oCYV+8Ko0JvefubAk/cFnFhy/hQlEprkYzPh7c2SGXwXFfw3z7PVO4ga8MCIf
         Hoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776253066; x=1776857866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3layzgo2NWtRymn6C5MvhyLuoFv1OOzS5ddSVv+wVBw=;
        b=qCkSgMfDzWfyImFwX7DtXxhMSYaS1XmIPSyPCD/CTYabdxLyNQ9O6B3KNE2MPP5GeW
         9A8Hsf8eRD0kFP/3H9XHwaxr/YpuBIa1OFR05eD481bFOUIruLqckYkUWQAo/e6cvcWU
         VPL05uMgYxR0ZcA43eBOcadIaF+at/z8J4Vc9MH4u0L1g3domZS+QeD9cHPjt48aTCAg
         +qJ1ZJdbVoP2hOhxz6abKsTvy6UN/mFZcPwO31PhFlQqDCus7ftsWbDxjPWIYhdsIR6B
         o25wncOwkPE7elDdMcApHh7i/R5JFq98ycNvohVebTZ/Jand5pdtHW7SsefkE29eGxEO
         xfag==
X-Gm-Message-State: AOJu0YwP3llc3nQRKSyiMSO5F1WlYYnMhqZ1fRlBqZMJG0ZSREWsptVv
	mMqCQFb6ZjuZ80V8dcoe17f+/aHqUX7xAWzCsx+jTI8SZUOlkQsY+tlmWYyr9LFQpWtuDkMH2a9
	UrINcd1G1oZA6RbgeodwwjvIRrjRgguWeBOjvdfAh
X-Gm-Gg: AeBDievwXYDDMozll1sE4xApD481isFWCnHI7aUa6+UkSsD5tZZSj8AbA+EYWw9N/1L
	3pSDjuKTZsmBhbIoY3gQHVThbgz1o5xxEEYD8d6h8M1cHXHM0Gz+7vGRPuaxnkL/JBfmsQ+RqjK
	e0z1hplhkDvFLhPM1DCKW9JRK8tVwOEckM2Qr2oTA7/V/vqqE6fA2SUBfRZWymbM/9dMPu2xOmO
	pCzml+b0Gbz3yVYmMfR1BfbjwT/zOk3s3LOiV0AoejCxV5BmB7KccG6VEB70nJGq/1lK5AWdDZ9
	JxTUqCsiULYyA5OAYN8vQsgetTWhTkDJRX5KS9N2/UWrO3O75giCgvME+oKdAHIhL5grQCctqro
	VPgSZkw==
X-Received: by 2002:a05:622a:22a8:b0:50d:6ef4:b3ae with SMTP id
 d75a77b69052e-50dd5aab62cmr316511711cf.7.1776253066134; Wed, 15 Apr 2026
 04:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413085349.73977-1-phx0fer@gmail.com>
In-Reply-To: <20260413085349.73977-1-phx0fer@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Apr 2026 04:37:33 -0700
X-Gm-Features: AQROBzBfWQUO6q2jMwqajV-_bBvkNwwUzZMo6nVAp0boUHp_1AzSEdiNULWZnaM
Message-ID: <CANn89i+oSN-tVfGQW3LWaenh64YTNq4aw81UT=kou_izimAm2A@mail.gmail.com>
Subject: Re: [PATCH] macvlan: fix macvlan_get_size() not reserving space for IFLA_MACVLAN_BC_CUTOFF
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278752-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: E90AF403F0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 1:53=E2=80=AFAM Dudu Lu <phx0fer@gmail.com> wrote:
>
> macvlan_get_size() does not account for IFLA_MACVLAN_BC_CUTOFF, but
> macvlan_fill_info() conditionally includes it when port->bc_cutoff !=3D 1=
.
> This causes nla_put_s32() to fail with -EMSGSIZE when the netlink skb
> runs out of space, triggering a WARN_ON in rtnetlink and preventing the
> interface from being dumped.
>
> The bug can be reproduced with:
>
>   ip link add macvlan0 link eth0 type macvlan mode bridge
>   ip link set macvlan0 type macvlan bc_cutoff 0

Was this generated by LLM ?

AFAIK, iproute2 command would look like this

 ip link set macvlan0 type macvlan bclim 0

>   ip -d link show macvlan0   # fails with -EMSGSIZE
>
> The bc_cutoff feature was added in commit 954d1fa1ac93 ("macvlan: Add
> netlink attribute for broadcast cutoff"), which added the nla_put_s32()
> call in macvlan_fill_info() but missed adding the corresponding
> nla_total_size(4) in macvlan_get_size(). A follow-up commit
> 55cef78c244d ("macvlan: add forgotten nla_policy for
> IFLA_MACVLAN_BC_CUTOFF") fixed the missing nla_policy entry but still
> did not fix the size calculation.
>
> Fixes: 954d1fa1ac93 ("macvlan: Add netlink attribute for broadcast cutoff=
")
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
>  drivers/net/macvlan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index a71f058eceef..80f87599a503 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -1681,6 +1681,7 @@ static size_t macvlan_get_size(const struct net_dev=
ice *dev)
>                 + macvlan_get_size_mac(vlan) /* IFLA_MACVLAN_MACADDR */
>                 + nla_total_size(4) /* IFLA_MACVLAN_BC_QUEUE_LEN */
>                 + nla_total_size(4) /* IFLA_MACVLAN_BC_QUEUE_LEN_USED */
> +               + nla_total_size(4) /* IFLA_MACVLAN_BC_CUTOFF */
>                 );
>  }
>

Note that skbs have more tailroom than requested, because kmalloc()
power-of-two roundings,
so the bug does not show in practice, just in case someone tries the
repro and sees nothing wrong.

Reviewed-by: Eric Dumazet <edumazet@google.com>

