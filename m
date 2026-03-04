Return-Path: <netdev+bounces-263540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPCcDUeQp2lKiQAAu9opvQ
	(envelope-from <netdev+bounces-263540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:52:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECCC1F9B1E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA40A303EC3B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65633168EB;
	Wed,  4 Mar 2026 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmMYle0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D730FF27
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589122; cv=pass; b=XSRkAvma5AiPLqoi/pI0A4lBuSMPu9oOraC6QTwANS4ZAHDduyG/fzm1bR7zOVzvlueJx4ljoEKoaq8H7ss0753mDA9xuUUU5TiQjzz9knQQUvnqjiDuaQke1cHywYwLsij0OlHug+a8C8ZoaVJ+Uy0Vmc2mFMx9q84/1it68Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589122; c=relaxed/simple;
	bh=QTscViB8grxAPCOC78xs5ygdoQOVpxF68NTIhCjZGd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qrk/gO0rOHUH/fi7HCyGyw66uSs36r5aKVWEVwwRE55JsSQdgzAYhKY/lWhc0vLisQh5aKODXcu9UOAfsaJ902dGB41xqnUZ0i1CdgGJjnd6qnAjHVXQAtGVGspzu8GvMiBW4fkpfLbLn63P5Mor25AlQ8Am5mTKm/VHvlIgjoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmMYle0/; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4c4cacf78so3156148a34.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 17:52:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772589120; cv=none;
        d=google.com; s=arc-20240605;
        b=la2ixBbUiQADwM82cjD/18mJxgExM50bzhKbEv/tqT9oF7de5HtWJoAnOdUi6Zn7Yi
         k/BIZqWkCOxqQ6VDBkQglrT0J39Mfgm1GoftqhC6PKfRIYStVod28nTJuzphSg7REZki
         Op+sFvUOWeKiiAvCf0CqPbIXa/F+77jao2Xp5irU9lkSgpOqF4496RTpbuSewkoHqmOX
         yvNxBKyiOzhQT4jpSM5ZohcHnMuuV7qKUQzzub3884b6/AT/IuzGuV2emQdgmX6NActp
         sTozeUkI2QBTRIPLLyjvNqJnviKE+QvWkDhQFma9LhPBXd9DsRBuIrFL5HXezCIZn0zx
         D9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M6DDwwLbvNw2aNPI0sJJsmh0LIhfNj8P7L/0HpfFzVA=;
        fh=3x7Eswp0HSMcAa2gSsrTigEU2vj97m6Jk7rXWNu/Mk0=;
        b=U0BZDd3CuqEO22u/vfHiEFTmkkreFvD9zv4EBBM7sOA5KRD/qK8A5JxwdEuM56+isv
         Eeu6Zci+6+kVmHGD4RFIhCjcnUZIO8bFgJ7nNbuiGWbw1bpbEcC/41fi42+ULgstdpyV
         5U2peIs0/tq57L8QXhOZZQ9dieN/rkoZOulSIy0SodcqvO+ovcwmsffXjQDSIYz0WeVF
         H1wqaD8tSMgJlR5wvkb7Y9LXOktnR6N+Mle3tYLicJ5cWM8uQWU0Jdz9Wm2iSPSaGqFE
         6I2DWvXKcWTZOXgE78cHCzKzbbzhnY+IhaB4CvCk3T27SHmOUoXa9S0+WVRqFIjt+zks
         nPBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772589120; x=1773193920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6DDwwLbvNw2aNPI0sJJsmh0LIhfNj8P7L/0HpfFzVA=;
        b=bmMYle0/IHWlDUnHnDZZuuGRBBgdaH7No47+rVSbx8RxH+htECLHCuEnoqenVUOCLT
         cC1eGTP6EBz195pxJbin/CPALxLxO4feJ+Fw4djgHNRn6y4h1hKXC0rZuhViFR2CXsYh
         t7iF9RKKDxHyk1qJcAhj8u1vrDUlkwgirE0bVt9theGI1Hr8VkBJI/A1ewsIt8ck1FD4
         cwHRE6odQcKcv+0yCX27RTe+yLtSmkhrvVYqi/UB5rGhFgQSzBChAcGS8BIShTrFClzn
         yn58r03OdaDZHu+n4FRVC1eChWDrI9PxjSLMwVmnCjwKM50TAKHVtp1kd+iOtnjK6xmL
         WZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772589120; x=1773193920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M6DDwwLbvNw2aNPI0sJJsmh0LIhfNj8P7L/0HpfFzVA=;
        b=ZDHNDRAMZNx2myW2AqNUifPkSw26NB5m7TI1vYkLU8qhfBB4xnnD2HfUf4hh7gCtJH
         y8mph5qkMr6kerKQReF5auVztUjH9RlAsvcOYh837jaJzDiUNxS0qH8VMVDvpRe+Pl7M
         5nyR/PziMTDmUdUTMhKkt3VBd3pfIOLMrO8z4cs2jMpjY/n/li+e0PiO+P/RtRKTs5Vt
         DOjWT74gcDz6jVQygpxda/56Um4M6VTQcKEz70Lr3f4zYh8nOxVwZM9yBayiX0YAXaYS
         N5EjRFjzFYgt1LExEOY1CNqyd1Lg6qmzdnxFFxxCZixlOyOfyfRUxvkyM13GvM9ymJQN
         3kgA==
X-Forwarded-Encrypted: i=1; AJvYcCXKsGVjkEfmCfYs2cEjFZcRyTws6Kx0WqCo8/+GwYne3mNhJQndMAZr8tJQc4pL+nwVNrhcKEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6C/Bv97kCdkEJbrl//YCORX52+uSCN4n9fIjBD1+ru/tuYLZ
	LE1941qSYMFOKtuA1gOjCb4ORE5xETbnj7+oK9RtHislfTpp9DQJMsL1FJm/FxTLVA55wI+8Wsy
	lnjyObh98Cy4mtCBa+wuEc3cD+ZqCU+E=
X-Gm-Gg: ATEYQzwHBcsAsxM/H/OwD4jkJqhYTzHMaoOLJwfPvMkht+gUMg9eECC5i6tbHK92HzN
	HX+tIsg4kJWY7ihDeDUOAnKJoeqkJbxYlKJwDr6ZUmtaedydHXbuEkjKA0IhAgobx1QzMDOZskd
	aKWwbKwBtJn/n94gpVLt0APxtBazOBvgvQP1zUdOzGp7YFLNEMlsqGMqwz7oyA9ONwX/j3JfWYP
	oKbStHlDm4gCB8EzktDx+gBvZmzO2IBmk9q7ISXUSeTEb4oRWBgFoGz+wW15f60dFqHAt+38Pu9
	WwHc+hjRxg==
X-Received: by 2002:a05:6820:2103:b0:663:40d:48a3 with SMTP id
 006d021491bc7-67b176e6077mr466708eaf.8.1772589120344; Tue, 03 Mar 2026
 17:52:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303143750.57741-1-zcgao@amazon.com>
In-Reply-To: <20260303143750.57741-1-zcgao@amazon.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 4 Mar 2026 10:51:49 +0900
X-Gm-Features: AaiRm508utMxlCnXWm0XMHauHt_ar85nHp82rxSyqeJ69Eb5S7fy7_qQQswNDEo
Message-ID: <CAMArcTWhzfPCAz1XNv1YTTbRKahiar-W1jG6sHW2RP=74LXKWg@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] Revert "selftests: net: amt: wait longer for
 connection before sending packets"
To: Nathan Gao <zcgao@amazon.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2ECCC1F9B1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263540-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ap420073@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 11:38=E2=80=AFPM Nathan Gao <zcgao@amazon.com> wrote=
:
>

Hi Nathan,
Thank you so much for taking care of it.

> This reverts commit 7724036d4804222007689cd69f248347eb154793 which is
> commit 04708606fd7bdc34b69089a4ff848ff36d7088f9 upstream.
>
> The reverted patch introduced dependency on lib.sh under net selftests.
> The file was introduced in v6.8-rc1 via commit 25ae948b4478
> ("selftests/net: add lib.sh").
>
> Without lib.sh, the amt test fails with:
> ./amt.sh: line 76: source: lib.sh: file not found
>
> The whole history of lib.sh includes about 50 commits and considering
> the file never landed on 6.1 it may be better to not introduce it.
>
> Signed-off-by: Nathan Gao <zcgao@amazon.com>

Acked-by: Taehee Yoo <ap420073@gmail.com>

> ---
>  tools/testing/selftests/net/amt.sh | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests=
/net/amt.sh
> index ea40b469a8c1..7e7ed6c558da 100755
> --- a/tools/testing/selftests/net/amt.sh
> +++ b/tools/testing/selftests/net/amt.sh
> @@ -73,8 +73,6 @@
>  #       +------------------------+
>  #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> -source lib.sh
> -
>  readonly LISTENER=3D$(mktemp -u listener-XXXXXXXX)
>  readonly GATEWAY=3D$(mktemp -u gateway-XXXXXXXX)
>  readonly RELAY=3D$(mktemp -u relay-XXXXXXXX)
> @@ -242,15 +240,14 @@ test_ipv6_forward()
>
>  send_mcast4()
>  {
> -       sleep 5
> -       wait_local_port_listen ${LISTENER} 4000 udp
> +       sleep 2
>         ip netns exec "${SOURCE}" bash -c \
>                 'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000=
' &
>  }
>
>  send_mcast6()
>  {
> -       wait_local_port_listen ${LISTENER} 6000 udp
> +       sleep 2
>         ip netns exec "${SOURCE}" bash -c \
>                 'printf "%s %128s" 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6=
000' &
>  }
> --
> 2.47.3
>

