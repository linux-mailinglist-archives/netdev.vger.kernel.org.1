Return-Path: <netdev+bounces-273061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD3OKeH6yWlg3wUAu9opvQ
	(envelope-from <netdev+bounces-273061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 06:24:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A2A355439
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 06:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A191A3001F90
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101E37C921;
	Mon, 30 Mar 2026 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4IzGVJP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B42BB13
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774844634; cv=pass; b=jyYpn3esELdabZeOgyVoXse7km0HJwS6TfLJf9fshoe/9dQNAHygHMtkKlfiZ1YByBJaB4el89+4Z/K1LOT4I7qaa5rK5U0UMFcyG2tMcQdhbXarcI0zrfd3hwVYYj2bPojxYtkYlb49kBVW9YlTArNmGA1u25fkicuHOswwj5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774844634; c=relaxed/simple;
	bh=47k2KtJLFlgZV7BeavIm4W309ubp3tqc1s1bO+AnlXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjlSeIktvVMpUTd4TSsxNFOsiIEVVN2/OjYBYCYAPbkaOR+0oeHthsQnLzcvPeM9KAP5u67O3km3lj67vvHr63EgShvEAr1IMOngTCdpU9LgxY57uDIXsEXzc09VmSnjyUeyw61/Xah6+kfvu0Vv9e23ZpyNuotmzNEmumz3WPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4IzGVJP; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6501d242e2fso515095d50.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 21:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774844632; cv=none;
        d=google.com; s=arc-20240605;
        b=VKq8kHA5UVF2W20h9LGYtR1FLvC20cUCCMMSFpOFC06zZazrdZMCqvi+VBFtpz/o+5
         z34QTWFT6k+R3fBN6BjxtxquQyLtWUVZMQvidvmr7PBot1bbhrCYUh3jvD4rp5cj7ei3
         kRi5wPJ05O08FS3FK/lT9LVsdDGsxZok21q67IQ7DfPInd3qr9up14kB+H+PQ25KT9CD
         YY7ZFWlsrlb+CFyXeeABbMO1kaKONRKP8vkl8eMuAWpIVjre+n5WcimHtms1CFguWfNd
         mKEGKPVzyuQrODGE439VymY2GqcdrAkR/uTSIlXifNhBvnFmIvDeLHoROi0MjW5o3csV
         MTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=47k2KtJLFlgZV7BeavIm4W309ubp3tqc1s1bO+AnlXE=;
        fh=eT+XNxNuy6L1m9QCeMZMbrWmtuPPDVOpIXQzQkJ1ano=;
        b=Bp0JyuQYSdC8ekdV+v4GbTUnseNc3AbrOhRAI84OmesP7jLZaC8GLfNN/PE7shLOUi
         8QOrkhWnLkmdvabhUlJ65xm9024pZNvqAqA+2yIll1pqPkeXDAjPWP8UHVAbPjsSXBhS
         jgzot+UFxbrVg5H/r7XU9oEZyCSU82vKVlB+tozZWqO4JZJshXSdA/wG6IgMFNVwYIQT
         g84i8XhuIFS+fxIZhrTusO1f1W7Pi/wYCTmaFM+zX2wcgKBeneF3wU2R+4M9lWf0F6SB
         NXjCQsPQ/YFia5JuJ0zlMve+5a+SXc3eC/LdIv63C7BTTT8ohSX+HWqqdY7yb57b/Bvu
         6cHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774844632; x=1775449432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47k2KtJLFlgZV7BeavIm4W309ubp3tqc1s1bO+AnlXE=;
        b=O4IzGVJPphyFOlthwcYwsJrrr22cGIHGWNjN3ZgCcYdeHDCpP3r+vz6lHrRxj3UxVm
         gPr1oAXQ3OVnppktqAha3ZIWRj/nkmf/H+Eewu8rjtquRjhi8rPbQYxWKXP2iHSy7sco
         jAih+k1Zd4M2PctyqRIS/toh+KpEklLv6wIAJoZM/IYHuh8HoxNzuSFypk1TJHUhqLL7
         ipjqUv5ps33r0lKOcO7nq5W5eOSoHi8MHJaI+rwkCYguVrq0U7iTqQRuwbQakwYKucMI
         uvlOxtb+rVymg4B71V3VekQ43NP2Ez6bFdL6kuy539RpSOLGDPwG0VCy6rvvManRudnK
         pRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774844632; x=1775449432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=47k2KtJLFlgZV7BeavIm4W309ubp3tqc1s1bO+AnlXE=;
        b=Ug2XKVZJvzHRHmBVZQgKx8iO48SL3kHw0A7Ad811AAo5FTubqRNfd4dIkkCU3q29Hz
         yis9hWPyHQKmWMluU8qsUYuUho02x3zWsiANRAsYPvvI+wgOVim7UKFPZfQXcDJVlBLm
         UDt9K4TAf8XZhEgh/E3SqbVvnp/Gy1sU2UBg0BSnJa9nXkYoRg8F0NWnrOpqRooxGfki
         ijfNejrlffGE2E/xmnYl8pgJkSiG7ATk6qU2ab2bG2TbZKSbC2FHWTWKvXR7GV+jI4IZ
         v0xgYoSHHwQ6Vdto5i4b6Xe+FE7qORPDSaCuBANTV/HB2ipjHRgzq100w5pQQl0n8oxr
         rRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZolH0wr1goWNXfok3TaZ6ATHg4kuSmkhm0CfBqfR6L/nlSB76cnjfRldiCkGoi5ghiwQFjXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwbd5DXW83CA08VrV0ZN1YhKnNm6lPNPD9lKytBCtRI0u5bh2
	ELE4poiTOoRO3RD/qQVSAI9WwGt2ruIxycLMm7NytAcOI9K8wWQTCIUHkdJM0jwOrkE1MV7hxsl
	hRhydd+LBgKFtfaY+WkYsaU2zuTtuNqo=
X-Gm-Gg: ATEYQzyBxGN62EAkDfHj3gSr/VnHB4y8S1zZ+A//OJ6HVtjoQRuhMT8jYsCW2OH4KqV
	90sZEddfB/PVrmSk2baNWNJpITFJ/aEvj14XMfC7wJwatyZqiVI8Ca/zmkrhErWIQ9UqU8+jaf4
	JOOEkzPVYQQPQHmwhMwwuMzW2w8YOke3iLsZTinTh+LXLu578WSdih5xzW0AfhFfpAkbmSi7I3G
	IzMiauJdqRYXNW4ilWyL6/JEx3gl/EpKWvkYAmo5lt7rVjIk6kvwPhmB/r9Qy7qa5cz5v9+9s+p
	1BGvNQvMqqG5Mb4uKrplIdyVXuEdUyM5LJELOWogUwO6W0fcMJI+XnYiC2I=
X-Received: by 2002:a05:690c:18:b0:79a:b00d:c863 with SMTP id
 00721157ae682-79bde07ce0fmr108242067b3.47.1774844632115; Sun, 29 Mar 2026
 21:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 30 Mar 2026 12:23:41 +0800
X-Gm-Features: AQROBzDnXYc-BWZEQKIqLDNt8-oBOgGJ0Q32XePgq7J1_YTx1z8kBI9nA7aPypk
Message-ID: <CABFUUZGmNR_xEsECjhF=WtitTHiSxM91-xDobo_h1AAYNADRvw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273061-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A9A2A355439
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Syzbot has tested v2 and the reproducer did not trigger the issue.
Tested-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com

On Mon, Mar 30, 2026 at 12:18=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com>=
 wrote:
>
> bpf_prog_test_run_skb() derives skb->protocol from the Ethernet header
> through eth_type_trans(), but it does not verify that the provided
> linear input is long enough to contain the corresponding L3 base header.

