Return-Path: <netdev+bounces-260445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KsvDeF7nWmAQAQAu9opvQ
	(envelope-from <netdev+bounces-260445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:22:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DDF185423
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DBC730AB0D7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A2F36923C;
	Tue, 24 Feb 2026 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Risea3hd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647BF3783AB
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928540; cv=pass; b=TPvu/gGQGQT8p58g2fCil3dq1b5yPMiHXQUj+mV7Gb9rApOXYbICFJ1Tcx3K9PVTJbYgWba5kaLhuOKSELM3nZjMDFm/rZn3l0ds5OuzUncLtwyncy+cGBTJJNHrFNxM/4dlSH9s5+tsXJOni5jieZgT4Xm9NtE7LIxXYwi9A+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928540; c=relaxed/simple;
	bh=LoA0gd3Q7D0WIQQHGz6q931aQElRYL18j9ESlnOGh2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrjAZc83iSFQETkTK394fYb0Fg6cx53gorGQxGOoe9gph1zd7qQVQ4RZjvs1MkQLo9L0bwESptR1J3w9XRsf8Sc8OyG/kQLieWputR4vMfJDUvEomSseK9Vd9eRcwpXco2yyikPw8ZURPpCsLgDd3BKXyXdrGmChOMaOkKnR9ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Risea3hd; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-502a789834fso47564621cf.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:22:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771928538; cv=none;
        d=google.com; s=arc-20240605;
        b=jF3lC8fFvHKRbRxtpYabFGIcoWLzxzeub5VirQEWqqhVC9P87FjbK7lImvaPBLcxUO
         Utytac1XgfGLsL2Gti9wChq8m9a4+xfH+MED1oDLLXTCuHCp7aixzfa3usx6ZjJqlXfd
         ytuNTyhR1r2Gag+jUpSjyFKLCXHkJyYuWdzyYsSiN+ehTJARlvOYzF+O3laxhzm5T1Eo
         GdGEoDi8IrO852pwMeF/p2uwvVqwmdKrHsKhVBOxd9vCPyXyE+hIAAVSqg/6z0eCOQv8
         617l5Et7qlC/NjEenyihFIHQNioL3lmAk+HOhKEKhxDUr6Rb2S8Td4Ytdh9La+UT0zfo
         E+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LoA0gd3Q7D0WIQQHGz6q931aQElRYL18j9ESlnOGh2I=;
        fh=aj4AYIXqGkVVJ+jM+lKIPVbh6vJbMg97a7VNSlUKOg8=;
        b=Rw3PV2NcjU884vRYvgTYPRK3zXZf6mpNvS3VVnBlzP6mXoxlwtf1lbDgOhdZu+Nflw
         RQJ67/kqXyOfvp9iJiSAcUzyfxL7ejWkybapv8Xg7qKT6Ix4IiHphqM4aPlvrPLNULkD
         BvqKCffTtHpu2QLsra1mZC19aJw4WM7LkufOHVf4xpqlf0peNnZFnl7MijhSFhRBRx8O
         4GXZeQ2HLv/ZHOsQidaLQk97t6Rn7TGDXxCCDTTIV6eLdspUUi4+62mPHFjuYZiPQ9ro
         hJhfTjE+Ad8SsY4RjhDnprDYDj6EEGzS/LbQfzFRTIdEdhzQ73rHjHpH9X8DpTgmM6K6
         SLlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771928538; x=1772533338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoA0gd3Q7D0WIQQHGz6q931aQElRYL18j9ESlnOGh2I=;
        b=Risea3hdvRndcNXUmwoxm966SVXACAgPOQemk9FtkrPmc5FVfoORNDS30x5rB231nZ
         Zcx8rTDLAfvvOtqZh19qErQvtRnGAZCcoexgo9fcG2GNzjxGGplW0Eq/+0OjaU9M/Dxt
         8ErkvjkPwUSy8jq4ynAjEbqosHzc0I/WFSB8+ONll0pF7H6Y4wZyuCskTy3f/E612NYX
         mdYJv6zd4xienQXHqCQLOd84vZ9UABR4jlNvB0/K+ZWguZN/AnWoeoVNWL9SMxoNjiJZ
         +NyUygWS6DUe3CpuWskZ7qr92bV7j/IaPS11HKU/6naL0vMrbo4WRmOKV9NoWzkeHEdn
         O+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771928538; x=1772533338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LoA0gd3Q7D0WIQQHGz6q931aQElRYL18j9ESlnOGh2I=;
        b=aUc2DYC9rdvTdn9K4hGpg8fTyvTAMHW0gQwB2OUI49pEcZ5PLHnWrPx0zIQyt+T/tl
         rA7nDPF+6jNgmwiKo8hX/Fuo3nOQ9X0bvgNX9c2FormzQqJn8rhjuYQlpPRklAi6YgAK
         130j6DU0s7fZlZb5RO60Uj/Oeu0XMB767g10QHZI41GOyuQar6t+Ov4cA72AtRopdJe+
         XWdGtSFX+jCdiGno4bf+r6X9wpby5tpuwd2MwCwE0FezM0yWNhhbR3UC3/zU4/kP/ysu
         G2SJr4XJr7zR/EAIuJKahMbUMmZN9HzBM2ekWf9w0owFdPOY1+1Axmi456Kk/ugMSR87
         3Azg==
X-Forwarded-Encrypted: i=1; AJvYcCUQgTsGrpr+GHjc6iNLeOxL9EzS0AocdZ5fzo45xHq8AJanOTmoa+qcGdP40i4ZAZ9t7kYNi0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ02PWmpQ3CqmDFEAMijXKf43bvOFtmebg4Uhoq0S7YcO5a8Q8
	YOawNOy7ynH3xnfYoas0a171//ovDyrsN8Z1hu4Om+hTbY6/5KC8uGQXxeb19DzEnUtbvXf/w0L
	uvfm6hRFe/Mxbc0q9Y2ARY/6vVHBX4PNhnYXaTKcH
X-Gm-Gg: AZuq6aIBAukk+SAl9MRH9/5nJeqrRcBKHTSKgQ1SUkKRchnjlYheg36JpAVOsb+BEvX
	QZlbelWXevQoT504bhd8GpFIhpWoySxBpuG82v3cHgSzfzIF/AM9C2PaItJRWxzbsH9wgC2RTyc
	2Yig32oNeWPMrFTv11pVC25BZthS+hxbzSAtTJCVq66FGTvS+AdKW1zZ11YX5DxP3yj+3JCPB7p
	/3Aaod0LPMFmzED7koMCmHyhNw4boTVTNVRtp67gCObU09LO/go3WO++E4E+cYBcdwc+6iWDd6v
	o1O9NN5EGy+lIvr+yFFugOfDw7bI/Eeewefryv/H0b7lkIzBSpir
X-Received: by 2002:a05:622a:2d4:b0:506:b77e:5431 with SMTP id
 d75a77b69052e-5070bcb52c8mr160299231cf.55.1771928537721; Tue, 24 Feb 2026
 02:22:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-fix_zero_wnd_fin-v2-0-a16677ea7cea@gmail.com> <20260224-fix_zero_wnd_fin-v2-1-a16677ea7cea@gmail.com>
In-Reply-To: <20260224-fix_zero_wnd_fin-v2-1-a16677ea7cea@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Feb 2026 11:22:06 +0100
X-Gm-Features: AaiRm51TafJQC2hYO4iQ2Oifkc5ftCbKvt2gFRRO9OSQG8DdaeCe6QkzNpscBHg
Message-ID: <CANn89i+iqQWy2QcKi_wFS2nRKcygwBUPWmSTtr2dp9Ey+jORHQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: re-enable acceptance of FIN packets when
 RWIN is 0
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260445-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A2DDF185423
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 9:20=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> Commit 2bd99aef1b19 ("tcp: accept bare FIN packets under memory
> pressure") allowed accepting FIN packets in tcp_data_queue() even when
> the receive window was closed, to prevent ACK/FIN loops with broken
> clients.
>
> Such a FIN packet is in sequence, but because the FIN consumes a
> sequence number, it extends beyond the window. Before commit
> 9ca48d616ed7 ("tcp: do not accept packets beyond window"),
> tcp_sequence() only required the seq to be within the window. After
> that change, the entire packet (including the FIN) must fit within the
> window. As a result, such FIN packets are now dropped and the handling
> path is no longer reached.
>
> Be more lenient by not counting the sequence number consumed by the
> FIN when calling tcp_sequence(), restoring the previous behavior for
> cases where only the FIN extends beyond the window.
>
> Fixes: 9ca48d616ed7 ("tcp: do not accept packets beyond window")
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

