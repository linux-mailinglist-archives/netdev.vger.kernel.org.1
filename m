Return-Path: <netdev+bounces-306004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9GsQJeXSTmpGUwIAu9opvQ
	(envelope-from <netdev+bounces-306004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 00:44:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1925972AECF
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 00:44:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UVKTyyLA;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306004-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306004-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEAC23042810
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 22:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FFF400E0C;
	Wed,  8 Jul 2026 22:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv2-f1.google.com (mail-qv2-f1.google.com [74.125.230.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C733F7AB9
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 22:44:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783550676; cv=pass; b=ZxDgotiIISqVebWvpaFQCApEzziPpyzImD44iYqGCbqqgbipuplewtlMahhO5U2zkY4QCO/0/2Zqqe5QGJiwa4T5jLr2xFeds0MZK6nFL1LzGhCLujJhD5WsywPVLzsvKdhIMmQu/dB7NFgbTQuCObXT+KL1u48UqRzQ8r5IGVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783550676; c=relaxed/simple;
	bh=LLNhkfWdeUPVzDAF5zUPQg/J3NffcXVnybN7CMTspwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmS0+kQeKRlOZf13yMutsaW9UFTTLEl6IlhKH7shpVP5zTOPLCJstqW/Pqu/XuAor+U6DXnM1L5bqCS4o4CQEyMuBvTegPeanwKjsd6pW7g/4l38SpOWumLhkoI9lbEy2x61b82qMvGnmY+QlVCjRef2PwKI92vIGKRShmKwonM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVKTyyLA; arc=pass smtp.client-ip=74.125.230.129
Received: by mail-qv2-f1.google.com with SMTP id 6a1803df08f44-8de1d032d56so4138976d6.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 15:44:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783550674; cv=none;
        d=google.com; s=arc-20260327;
        b=dQGg9XTekrExzK+dK5lTEf43X47jQdOC1uzKjxLa48ssiLuHhFv14hqxowibE4TGD0
         FbfOCmgwnQijCPNf6R7GiYOwjJiImDsSOiziC8ShPz5jvcJjSUDKjw27YEGtwSO3pp1y
         ZKHU4KPQX9VRPNMIJcZ2RdFldTtyihr5BAuC+vRJffO9tOGxHdTnG3s1FECFiTdSvDEn
         c19d2EvEfJwr8eZm4aSkm+MX2RTHUXR9qs7CMQ8SEBsN0aBfvrh+8BoKs1kuJqgaujd2
         C97iLKFt31c29aO/kLCZQJelYxZMFo/jpyK33QeTd2NdRsNnX+DVKpcV2rvefTly9VgP
         Btqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLPKDOeCD+1o9/Dzr4Ln1MhIdulj5ZDzLX8a0QaxQYQ=;
        fh=jsOTozTIHSP6Cza/PvpDKoCAbEZMM534UViWoD4Q83g=;
        b=NiYtPbPURoYs6pTMPxUfIAfLYctwaavGJ6089fuo8W6Xzwyq3+l0HQtBpYWjqfCb/b
         dJlZNNG8xXenP2YY1cv80lOElxSaXpBvPHAN+gF8/i4HcWvs7clqcaYe0xQxLHIxdsbS
         TDUO3YCi08cp3T6SMymy5nTqgjGeFpdERKQaG37QPJqayt7c0BqMyi2Xt98VAimu3Fss
         yx07Bhz2Gk5+ZpmbOculwzE80gdtkwxCRnO3DJFr5sodWAKT9m+IeJ8HWESMWy0Wz8eE
         2dZS2Q4jOakvME/TrMkTi9jxkSjsLaxfPBr8NNmLOk3F5i3B0EOceFzPyrYTsABv82hg
         Glvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783550674; x=1784155474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bLPKDOeCD+1o9/Dzr4Ln1MhIdulj5ZDzLX8a0QaxQYQ=;
        b=UVKTyyLAf5TiBvUWbqBDF3eV6RI96UTyaqH6aVQ7kFB30qB+G10rL+5LwNv8Dg11Ox
         ohBwxVj1bZkVucfZwyle0A4ydDciJ9V4DxXFe7TqczNnQpWX1VKwwsuKEyMJnpiNMYWp
         EUxd6932wiN3EqpvqnXd0i6o4W1XXHuIqxn7VpLSZzUoUaVfkMW9R8V0w90quCeK3XP6
         OZfWlGu//mcBguDPyxbUjro7l3ecB4dJOnjhW4Veg8RQGIZoDBKJVCA18N9xkLlE9S8D
         XWuyQ48uJ0vdKLacVyNoQ4vgo1HSQBWSFKZHBG6a8D6CLsEi2qqh4gTA5wumM0Xjdt2/
         J4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783550674; x=1784155474;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLPKDOeCD+1o9/Dzr4Ln1MhIdulj5ZDzLX8a0QaxQYQ=;
        b=ble67gRqCU1xg7ABhdodUocln+wi0wV72HGHJ3Jr4NTULKh8D0uKzZPh69yi5d/MLK
         +rLY2fofcVEPcae9Ng0dO4EOqyJs8NWTNmDRAQavj43+MPXmJxBMnOaI52MQWkLCrebp
         EIJlwM/toE1DaZAmz+3p9hZxqb8nB2ksRKEM9ouUZxWG8VvN586HgaecsTCNvnYSxpnx
         RFFL5o5RMy5Ro+5uiYMrk6pl7tlzLTRs8/lx9dRNSNqdMAL+Jtq2bdcYLjMAy7FflosB
         vDPvEIgHBaovfQf/KTh50jySr+ToJLV0LZXt8+5YGKXv1UOjoNxsIWRv3gs+IWE+vYsx
         z2gg==
X-Forwarded-Encrypted: i=1; AHgh+RpmfTYFR5ij/vQ4WfCrfThSynILujtaHzN/hHFGuAM5CWYWiaf/mrOqOOXFyLM7vTw4PMGQ/tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznJwfoUxhIkg+sv15cJDPziTx5Q+F58FWGpJNXq5HUsDYGujYq
	NRM9bMUP+AKBKJmcTIoISkbn8meOcaItz+fBU9NICnu7PV+DCR6/HHF9J5yGTRLe45CuPRE5AYM
	63DJm9Uw4WzaEmcdUJnwuP9wrdccHxzI=
X-Gm-Gg: AfdE7clsYTdA+U0aFNSsCyG/4tVTixSu+iXkOEjsl4W2L4kMCyR0qsSoHJ5KE6BX8e7
	IaQZmUW+72Aw36+7VpN0ksL4foa9xR+8+PMyctdxc18KImFm+puDR9Peo6ZZ12qiR6KuowwgeSh
	pUJkJMv+uSA5Q+yGBTkh67FSoh8kSmJuTHfsY1vsoWNkrPo8yFTc6V67v5cHGa/gTBvRc1O8SYe
	5LYLK7P3J9/LXKc1bQ4uVd2VdYQl7JJ5KFMi1Hg7iUon2rImjbGjlKMtHbe/+vwh4BM41o76R2i
	P0IXSNdlS5LysBuCk0xsd2nSVe4c0n7cixtVfNivH6aZ7O6ZOUw0pXEU8g==
X-Received: by 2002:ad4:5ca6:0:b0:8ef:a4d5:1523 with SMTP id
 6a1803df08f44-8fec2d4614cmr50151326d6.42.1783550674017; Wed, 08 Jul 2026
 15:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705083724.24494-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260705083724.24494-1-pengpeng@iscas.ac.cn>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 8 Jul 2026 15:44:23 -0700
X-Gm-Features: AUfX_mxJL2tTqyB3fiMZ9o8Nt9yyvNlGf1QmdljUFtCVK4O4T07jrTSLQnm3nZU
Message-ID: <CADkSEUigsJmMgMPGFX1TdhgC0+NVEyR2ijK8rk0yTz-UGHFmSQ@mail.gmail.com>
Subject: Re: [PATCH] net: usb: sr9700: validate receive packet extent
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Korsgaard <peter@korsgaard.com>, Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306004-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:peter@korsgaard.com,m:horms@kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1925972AECF

On Sun, Jul 5, 2026 at 1:37=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn> =
wrote:
>
> sr9700_rx_fixup() copies len bytes from skb->data + SR_RX_OVERHEAD when
> a URB contains multiple packets. The old check compared len against
> skb->len, but the source pointer has already skipped SR_RX_OVERHEAD
> bytes.
>
> Validate len against the remaining bytes after SR_RX_OVERHEAD before the
> copy and cursor advance.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
> --- a/drivers/net/usb/sr9700.c
> +++ b/drivers/net/usb/sr9700.c
> @@ -355,7 +355,8 @@
>                 /* ignore the CRC length */
>                 len =3D (skb->data[1] | (skb->data[2] << 8)) - 4;
>
> -               if (len > ETH_FRAME_LEN || len > skb->len || len < 0)
> +               if (len > ETH_FRAME_LEN || len < 0 ||
> +                   len > skb->len - SR_RX_OVERHEAD)
>                         return 0;
>
>                 /* the last packet of current skb */
>

Hi, Pengpeng,

Other than the subject needing to be clarified, as Andrew mentioned,
the patch looks good to me. Thank you for noticing this issue.

Reviewed-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Tested-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Ethan

