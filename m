Return-Path: <netdev+bounces-258818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDP4LsVrkmmMtwEAu9opvQ
	(envelope-from <netdev+bounces-258818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:58:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C60140832
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4A8D300F9EE
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 00:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5DF256C84;
	Mon, 16 Feb 2026 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uH1olnn1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C31E1DE9
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203522; cv=pass; b=G6MB00YDXdhc3JnRu8+ZXv3D1XuoCG9Yv39fj5z60MHRlmuKJX8DjGrbkP3+1n2Y233A8o+YYd6mCx1922fGc95nZbOmyBbMn2PwXjxH1mKLo9hZdwQI66MJjlZVxAGLenz0qN6reEWT4AqX9CxNDZs6IoR3KedtKkeeM5ikLW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203522; c=relaxed/simple;
	bh=og4JsS5z4kOCVJBNcAdyq1178Nx8kI78dIrbBEtr5Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmru4utGO1GGooYErc9iawE2xwyW+hiqFfXCBMcPDWD+anLpOMb4GCX+RD/nDmTielOT+1PsztL8pnfhL3HHfTbsoMkNaSIMuVZ/LwsoNCTMSTRYga5FmyW84QiOmXXHthIvZk3amGiigvQGBAxELCKEmFVjdf3+poK8LDAbfhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uH1olnn1; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-124afd03fd1so3943286c88.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 16:58:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771203520; cv=none;
        d=google.com; s=arc-20240605;
        b=ZpKXpTTVqpSG+RjFPB9GfkNyB1FyMUAl0L2hJm/uUjtkJ5WCdJR5LcyUByc5f9No6h
         6jT3n9WMv30dF4JSC+v4UgnW1TGaLyUyB5D+CUPg+V1O9Cb6deAafQ+K+815MmONCvB/
         4pUr1n+GsUae6nnYKRYuja+m716V+wrc8cN48RUdSBp7wC6ciNOGCuNHWNci5JkJNzi6
         DIm++xSIEuwCp3buGJ4CtRCIymQ0NVFGnM3V+QvIcD/HHZunGx/FpssNgMQPmrjYQLNQ
         4oSbv1oLSP5XLe5m/kThJ22n5II4XhBY3TNt5bCLvHznFfQRQt/UJNzyS4Sz+2RvhWuy
         zRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oEGgMLnLEuZbZRlshSbh93eB665lEoc46ei4cXwaQms=;
        fh=HEqNHpzMPp9NdUZKN2A/nW0ePUIBR1PU07lor+s04yk=;
        b=OrRrW2NroS9cQvXnv/71WOy2jfD0KEHXnUCauxZw/ybPFxZncARb05Mp/iR70RB3sq
         mwuy8f+bOoZ1WVX01wP2k2VSJb0cGveQwy4o3FJZihA0i+0hOGxaMPD6EPkjRylR/0gU
         nrKspNzgGR+gglusOZNfo4T0vfYbaTXWWwS6QZuG2BzM87ZiscU7awN5euY+DIwfizGC
         ZXyPvbGX/l+6NUD4aH5PNyFRHSoXplhIyirz5sC5O253FRZL0hf/ocjRSdkLFmyHnVMz
         Ulwgw39KTBbEQVL6ZCMpbyh3Dwj1g+HDZj5bW3KpENb7H2sNuPIwkYmry9KzBWfFcm9c
         Or4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771203520; x=1771808320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEGgMLnLEuZbZRlshSbh93eB665lEoc46ei4cXwaQms=;
        b=uH1olnn1ULc003LaYnyLsC/sP7S8YzgHf2+A8zx7kfC+q7IcrXp8WkfI1l8yLJ6ICy
         HnjbgoHNXMjO6Hd0Oz1Z72NJb7Bg/3YqGxwH2kFQ17zyKWF3g0hMwFo01rbvWFGn97s5
         KGKXLMXuOVuNCO1JwEbt6Ugu039FaR776WbpuFu/EdH/a95bLlEeGfNXHtKvwoFzuJly
         TraWg+QHpCC27jbeGd2C2dvDePlloJSAkPfSlBKlMDEMzCmYBw8bDBwXsI7kdReeAew9
         zPtBVVfiM69KLW3qK/YlpDljfEQpfBhRpPvOBZrEaMt4m5XKljaRvMJtDISMgt+RQF0f
         Tqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203520; x=1771808320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEGgMLnLEuZbZRlshSbh93eB665lEoc46ei4cXwaQms=;
        b=kIKXsabhwjFMFffgeXXyIcwD8OF1bTaFyFP/1tseBhH7beqRox0gzrrSkfZJ+8hZ2J
         nDu+Y554Vkbb37wkgNJq9XYJLr52hWZtWDoeTcSqz92fEn4EDg/1spvZSr71fLCTupBB
         IURY6fn95UmjiVpN19ZMutURlxsXnVOL1mydt11/XvSucItO1gw8vLkEOr2//WwALLzw
         KhQZ1yokLvVRK170ybP+X3vMVs4bR/6IURHt01k9yMML5PewnWkMNGaHo74XlZ/LUksb
         Nf8mzgFlSO5HS5X2AM3l8ooHk1q9bx91os1e1lbg/M7DYShvacjwZVEj6rwts2zL2sKS
         ZIfw==
X-Forwarded-Encrypted: i=1; AJvYcCV5a28abNeABMtHNfOkgDxRK462ZOwvgbK13F3EwSN44BF+zxMTQJJ2oGeyMJ6NjLkr9Kcf2z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2w3ctGBzgSjq8kvJe6pTpAJMMzfgINeGXSMcUqV01BWItZAV
	Yhg/kpkcNKcYJZwA1NJIVbiEbYeF7fNgPgiSZItbN0re5WiNEFQVHh5QdrOjpxvgfmxrGIjUTrb
	AG7BEaxo99Buo4e87Uqp5er+sMgjzQJMiLg/I2NXF3S6HZPo5v4OAWG9j
X-Gm-Gg: AZuq6aKx7cfkQcTIFaBYQdQ3h3fvWt3HTrzexxa3iz4FdUDXrdQn+s7UtShq0LQ5dhm
	4MObkia/cao8RnT8+8+PB1bxgmj1mer2t1suj90rt2dnr57tPrzadde4u8jgNCW2ukD3WdgcgSx
	RxKyXv84cK/WTWQAEEn1i6CuxoHyKpSVPMrhyt2CR0WbLfvUbUJzQ056X5o6+wrncOfGGe+Quh1
	EP+ev35i2ksVZ3z1XI93VHoIerS9aIhsFBe3Yoo+TnoN5UEU6ShlVmHY2zIMmy5FBz+E1oLz9QQ
	BLYuMLWItxs9CrS9BKqEXrMBvBM89trfvCF1abOPaNCyzfjJj4P24QJtPwujJGy6Vf5gdg==
X-Received: by 2002:a05:7022:622:b0:11b:923d:7753 with SMTP id
 a92af1059eb24-12741b62a99mr3629153c88.3.1771203519515; Sun, 15 Feb 2026
 16:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215143821.2330791-1-edumazet@google.com> <20260215143821.2330791-4-edumazet@google.com>
In-Reply-To: <20260215143821.2330791-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Feb 2026 16:58:28 -0800
X-Gm-Features: AaiRm51htKusHoTpdvMPt3299djkU6GjOoeey8lTqsPtY3LZgjbsOoG4lEqAkX8
Message-ID: <CAAVpQUDeZwwbnJ7vxhtQwX17rPHbtdfjJ=naTjWY8vWh8kOKkA@mail.gmail.com>
Subject: Re: [PATCH net 3/5] ipv6: icmp: remove obsolete code in icmpv6_xrlim_allow()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258818-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 21C60140832
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 6:38=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Following part was needed before the blamed commit, because
> inet_getpeer_v6() second argument was the prefix.
>
>         /* Give more bandwidth to wider prefixes. */
>         if (rt->rt6i_dst.plen < 128)
>                 tmo >>=3D ((128 - rt->rt6i_dst.plen)>>5);
>
> Now inet_getpeer_v6() retrieves hosts, we need to remove
> @tmo adjustement or wider prefixes likes /24 allow 8x
> more ICMP to be sent for a given ratelimit.
>
> As we had this issue for a while, this patch changes net.ipv6.icmp.rateli=
mit
> default value from 1000ms to 100ms to avoid potential regressions.
>
> Also add a READ_ONCE() when reading net->ipv6.sysctl.icmpv6_time.
>
> Fixes: fd0273d7939f ("ipv6: Remove external dependency on rt6i_dst and rt=
6i_src")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

