Return-Path: <netdev+bounces-159772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C87EA16CDF
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F031884141
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548501E1A08;
	Mon, 20 Jan 2025 13:02:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418651E1049;
	Mon, 20 Jan 2025 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378167; cv=none; b=Z+d7CaJVSYptlxluKmEpnp1P52OQV05CZco370vZlmpc91k+R6xw0rJ3xh3dVQ6EvOyJrXY4pj5zFAaUsdV4wRx1oKkfbGtVom7oDBlyHcJ8wc6tk96ouHz84n96yeLczYVVGHrSM3F9Zc9KJ75LnSaFwlbi6VsnQjJIPQySkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378167; c=relaxed/simple;
	bh=q0twFfHGNT12guejllhSUxE3e8B5i/vTquPebJJn+7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhLHN1VXz+AQpeM8uactQ+T6kyCTtvg6KT8Mrl1PP5rPRBjEn57K/IfCr1CZLggslSSjDnsadygLvpxomMooi7qwxCzp1F6vpU3O0+Sqg26LOTpwmaEGsf3jxyEZZVXotJz/XT2RHXRN+uJYc4F3jKaktr3gHNAcCyQYaiF8P6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d9f06f8cf2so8625614a12.3;
        Mon, 20 Jan 2025 05:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737378163; x=1737982963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaO/gffB62oP/AC/Y39vqNuJAmecLo+e9irFWeGtxIs=;
        b=bB2VPRiDleptBhQ2sORy0sUDgpK2yyrjeBjUWosknbkrFTLkVqkwojpJuaPvNgyEmH
         mNma7BPAwhL7YI8TtDDINQW+EiIlwJmIi0ids9E83fwVpcVI6i+XpCOORyiN9pGHenQc
         C6+esNwBfObE4x8X1uQHeUUqEaxWTYzFW81X1rbd7T7E1CkHoMWpahHcBH0v+xTgBSgV
         X88Kw51gBDLSgpICggBDCrLD2dZp+LlCA7foG3g77Zc5xHSiOiPzCkklLBCPLGeO19Eq
         u2fRfFqmS+S+E3jxPShTo6l0YBpxPUkY96h9Hes5vOgCp5DwpL7OHQ6vAZ+/kKrDYaWD
         xWxw==
X-Forwarded-Encrypted: i=1; AJvYcCUOoo6q5kidecCHp33hbiNkcze+64JDY/77L/Fpq/tDefWnfeI0uNG1Kn7qSY5fT4pbyoHOfX1P@vger.kernel.org, AJvYcCUWm8yr8I5xW8sbR3CHRFc1FRsK9OYK0mWlUSZXAWojpX1L53KGjn9e/tPlBQ8UofiuQi3vJnSphZ7IfoY=@vger.kernel.org, AJvYcCUohBAoo39DyXRWqxe4TfvyffV+ykw15k+QbCOWltz0Nqsdk6tagcqJjTPfMtkunKr3r+S5icwcAsy9S9PFVaU0FGUV@vger.kernel.org
X-Gm-Message-State: AOJu0YwiESrrO6Ah+VxDMW/wxNjoQ6eEoiRlSP0Z8E6Y6v+fTgRtAYUC
	IdCdVaW/Ne9PaiPT5hHHe4xYy//5dlt4PWqTgtIMyosjKdZJ2KZh
X-Gm-Gg: ASbGncsQRGF4HPSHHu/F69H8CK5LbXM+UUAmr5IQG/c4qrqH7F4XJ1fFr1JGeiHLlsI
	mRuRnR9dHUlYgIAWhVbQsuBpj7a+o0hCHgdPAYvUlBFZWGTjz4ErjpYV/7ffEyBGuu0N7IVNT8q
	Qqf7e8e1djXNLFcjmh3iJZsJBqVBJS3HqB1PB26SBwf5M9+2UXWsXPSUCdN81bWmicYIH5uGR7T
	4EwifMU9XsS+Y0Nli63Oo0BknWMTnyNIAtW1jzIAOcDeNcvP6d9uek3HgJY
X-Google-Smtp-Source: AGHT+IHmQuhRKTaUtLO4nidtubuV2Y++Jzelf2JQ0AtRUPfk7S9RYiE7qRbxmQeJ5Ma0PZYzyNwU2Q==
X-Received: by 2002:a17:907:7da2:b0:ab3:84b5:19b7 with SMTP id a640c23a62f3a-ab38b52ed37mr1322292066b.56.1737378160675;
        Mon, 20 Jan 2025 05:02:40 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f8442esm609431466b.129.2025.01.20.05.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 05:02:40 -0800 (PST)
Date: Mon, 20 Jan 2025 05:02:37 -0800
From: Breno Leitao <leitao@debian.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH RFC net-next] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Message-ID: <20250120-panda-of-impressive-aptitude-2b714e@leitao>
References: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
 <CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com>

Hello Jason,

On Mon, Jan 20, 2025 at 08:08:52PM +0800, Jason Xing wrote:
> On Mon, Jan 20, 2025 at 8:03 PM Breno Leitao <leitao@debian.org> wrote:
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 4811727b8a02258ec6fa1fd129beecf7cbb0f90e..fc88c511e81bc12ec57e8dc3e9185a920d1bd079 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -2710,6 +2710,8 @@ void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost,
> >         if (newly_acked_sacked <= 0 || WARN_ON_ONCE(!tp->prior_cwnd))
> >                 return;
> >
> > +       trace_tcp_cwnd_reduction(sk, newly_acked_sacked, newly_lost, flag);
> > +
> 
> Are there any other reasons why introducing a new tracepoint here?
> AFAIK, it can be easily replaced by a bpf related program or script to
> monitor in the above position.

In which position exactly?

Thank you,
--breno

