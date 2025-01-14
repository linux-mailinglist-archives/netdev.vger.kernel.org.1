Return-Path: <netdev+bounces-158184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A137BA10D41
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEAC18886BC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00B41F8EF3;
	Tue, 14 Jan 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4+Q4RzF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3013C3D3
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874837; cv=none; b=AaURPIH7TqzoNDVbxsUYUj6bnU3BWuIduyqM7JBWvmol3JIEoyGpnZ1lRjmq7/i2+vNyVZiU4NJN+gNExY8FIilgI8E8iAKpL6WZAWRHCLIGvcJJ+rGcZivqC+ses+MPcnF09HHfO+wUKtL0IFuiGlyb5ICDGIu46Oe6iANIkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874837; c=relaxed/simple;
	bh=6MarksYsmBV3hYGbkkbZg4JyuiXpS8i8d8u/lyfpqO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/3BXexFkSwNPZKKpxfths52DYwJ4xG+jLgKUA9SVimZNvaiG5ow3JuJQDU5Gcat0Usa3OyRW8a67vKRUgASb5AlB0lhoiy1U7KTPE0kq4WS3g0dSE1H1cEveRKowYRHNwCovIkOqr2wMbN6evlpMj4BLohxu6i2HqNCb9tcegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4+Q4RzF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21680814d42so85963765ad.2
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736874836; x=1737479636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6MarksYsmBV3hYGbkkbZg4JyuiXpS8i8d8u/lyfpqO0=;
        b=E4+Q4RzF9+lqUThIxIvCegqVaW4Lv4psTR8nssPC9heMdFM5RX55SiTe/cuZU+NCtK
         920vq/4GsacbLINeWCa3wptEoaz9FyLN6lPcjFOTAhkxlfvsufG7ZDHHrwDhlqMBovq5
         lmp25kwSG5euknSa5vP3ZE2/q073PYPiWRY2ckOXWgjjj6fSg7SUbq4Uki7hh3mn6gTU
         VQfI0CjI8J2F/XFXfFif8DHUbrQDsAtWepvwWl8pB41Hmle5dVWALwyCEwCfVtXx6xW3
         8Qhg+9w9u4gWeGinPbmnJ+kZ4sTvuNzjjR917f83WzqXRFvtJiYcaPU69JbWSbXC8Fgb
         XipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736874836; x=1737479636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MarksYsmBV3hYGbkkbZg4JyuiXpS8i8d8u/lyfpqO0=;
        b=K2VtBgE4nHdOvpnTGHqiO2zGssno/16IldpGdfk69Hw6/U9Q+p0N5YWzNoq50wuu07
         TxO+hHWy8fjcMi4Ez2tiTKxeDzsf6cVOhcVuHgNZTg0GKwr6fjYmWb/iZKrHt4N6Wtip
         aIWl9PYxzNCkWIXz2d4q++RhUPMY2E9XFvh1x0f1G81qsFocD4dqyeLKyQcwydRIbUBA
         tKA3NaQHearhxtcadHFMkbaw6ykSes2Drv8zErc4uHqJd4Xhg5uI7CMu1nn2hX7IN+c9
         GkVgKt5fDjEzFfkBrQYZMFDupkfqSsGz8fiZz4QMXpJLJ3/85viMOwB5jfoFArzZZ8XD
         MyWw==
X-Forwarded-Encrypted: i=1; AJvYcCV7r+JjVCeW/wu1KWz3Mk8dgZcDGWgSBYurJK6ivNwR0EzDyL6UImrAfWhTvR7g98ZnIIs5IVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98wN6OvplYCnH9/Pp9Kt2/glP6M0JcXHV5/N1HvLMQ7PKCw0j
	Y4OR8hoCCTZ8xkbrYc41dKoDtkHelzaV4ATDb6OExb7VoMIDz44=
X-Gm-Gg: ASbGncuQxLrX4lYU+o4bWLk8/SXH9Pk14SxidJW4pdWjzxegslF+Uv4tezNG/zGSuT2
	PsAgta6/AkQ6sdgoPVF/8MnN5Sr7UwOMpINE3CS3zX5bkJBncccFJLt/Vwn+Mg1m85fi7yqRiPy
	P4W5U0dbja6OlsCcbb9nNhGc37HE5w+GL+/PWocxjNKZm8ELnvh+RUqehMpGNAK5+0EsYT+t09m
	oC7SFBOVHogVZMlbsCcjVsxgiDz/pagCc8Qof1wOQZsyjfgAk8YyNcA
X-Google-Smtp-Source: AGHT+IHkQ52d0kN5lBo6Q7id8TqO11nHe8Y0wNa4XDyhXKgJiORZLstgEOfv5U/Z+xVUD/tnVybpKA==
X-Received: by 2002:aa7:88cc:0:b0:71e:4930:162c with SMTP id d2e1a72fcca58-72d21f4ac63mr36902229b3a.6.1736874834060;
        Tue, 14 Jan 2025 09:13:54 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a75bsm7911396b3a.66.2025.01.14.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:13:53 -0800 (PST)
Date: Tue, 14 Jan 2025 09:13:52 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 00/11] ipv6: Convert RTM_{NEW,DEL}ADDR and
 more to per-netns RTNL.
Message-ID: <Z4abUFyLfalEFCfz@mini-arch>
References: <20250114080516.46155-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250114080516.46155-1-kuniyu@amazon.com>

On 01/14, Kuniyuki Iwashima wrote:
> This series converts RTM_NEWADDR/RTM_DELADDR and some more
> RTNL users in addrconf.c to per-netns RTNL.

This makes a lot of tests unhappy:
https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2025-01-14--15-00&pw-n=0&pass=0

I have confirmed with a single one (drivers/net/ping.py) on my side,
fails with:
STDERR: b'ping: connect: Network is unreachable\n'

---
pw-bot: cr

