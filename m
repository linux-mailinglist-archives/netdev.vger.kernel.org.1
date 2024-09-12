Return-Path: <netdev+bounces-127932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4AA977153
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F1E2832E3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05AC1C2DCA;
	Thu, 12 Sep 2024 19:13:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198081C0DF2;
	Thu, 12 Sep 2024 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168392; cv=none; b=Cyw1EdJe9cBFE6NZpUP26Wtv2K8XHk27Dw4w6V/RJCNNeBbm3z/ud66IfLr1wxOwkXkFu+gvnA/AJGiMus85WTnEcp8fvOk6Hu/GS3tDHU8MlkEzDVW28kxF5UWQyB1sqU0T2y/t1ITkqokCUUUoBboSdi2cECjiS9/2CWeRgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168392; c=relaxed/simple;
	bh=WRju272pTZ7NhkWxRs310l0StzvgQIROwLsQfYUxzYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWBcigABLI91WcXx2gBNeZcbdnCqg6E3D6vCfIdlHXznW8llKnjW6Rd+Li5JQ+VCkFSB1qDzU5spOciJ3aIbEj6bywn4UFnCuza1CjeTeMld7/SJ8PRTb+7ZY/1aYMpqXSv5hYIOTXryYRzTI0EL4gL5FFQQOH49t8MJcBsp9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so13014166b.3;
        Thu, 12 Sep 2024 12:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726168389; x=1726773189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5g7HdhRWtGfViUDG8qP5vBJy6BU5ARrq9CLb0k5rVYQ=;
        b=gqeaw8T8P6mG+26/A8tFHJf2WWo47LCvaW8KbKrTyO6ub8UhiQ6LBhjjQPESUM+ABg
         liM5bAQl7kWm7IeesXpDaB298sPer/wu+KoufE7hi8qdKB3uAYTDlOjT1wyHmRlGNr1m
         gRP//1Ba1Ne1SYo/0+cXY0BSjJWaiaISNLCcNCWFugThScPoDpPtfuTsxi9Y/xwZaE+M
         KLywFBRff1xMJqDmg/hSuzdjrodwYm0HV2VcRpipckzgy/YqD/ASdzOx+XOs5xN/BNsb
         tRCCuX8lQIDvabL2HxelLQUAkujbzRe6Cn9DqvkFv04OMPyAqOKc1dKU6WBBl35Bq4IA
         evxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL8b7xiwnKeOup0fLF2wsvRM0wwUQpdJ2JDQTttyeCMZCcbL+wZwenbIeZpUQWRABTCpwFF0Tg@vger.kernel.org, AJvYcCUhNAHA8Qe3CGHd/fbiG/XpeX1aYBM6bCjr3am3MgjS8cOKhGf8HHkuSqyepXuVRXeAF6PGLCXiomszf88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVzLm6UPksaHp4ArWH/OB7f/U4ALHLAQxRoRZP/djnKv0eCII
	bhw1zw6OrLU0BD14jrsrVG2jT1fYa7SnLnsKpId7ZLBrdrKG8TFu
X-Google-Smtp-Source: AGHT+IE0vWwcjZwVgBj4i9N5XnLPwLYvJcD93FlB/F/gpm94SJuKTney/6WPiFYHCW0wudiWgQ87xQ==
X-Received: by 2002:a17:906:478c:b0:a86:8863:2bf0 with SMTP id a640c23a62f3a-a9048044a0bmr7346966b.48.1726168388390;
        Thu, 12 Sep 2024 12:13:08 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d259f56f6sm767484566b.81.2024.09.12.12.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 12:13:07 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:13:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] netcons: Add udp send fail statistics to
 netconsole
Message-ID: <20240912-optimistic-tourmaline-snail-1e5aac@leitao>
References: <20240912173608.1821083-1-max@kutsevol.com>
 <20240912173608.1821083-2-max@kutsevol.com>
 <20240912-honest-industrious-skua-9902c3@leitao>
 <CAO6EAnWOrzOhHNURLct1tsxLL_gaNT+nWttTk4oPcD66h-xAZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO6EAnWOrzOhHNURLct1tsxLL_gaNT+nWttTk4oPcD66h-xAZg@mail.gmail.com>

On Thu, Sep 12, 2024 at 01:58:12PM -0400, Maksym Kutsevol wrote:
> Hey Breno,
> Thanks for looking into this.
> 
> On Thu, Sep 12, 2024 at 1:49 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > Hello Maksym,
> >
> > Thanks for the patch, it is looking good. A few nits:
> >
> > On Thu, Sep 12, 2024 at 10:28:52AM -0700, Maksym Kutsevol wrote:
> > > +/**
> > > + * netpoll_send_udp_count_errs - Wrapper for netpoll_send_udp that counts errors
> > > + * @nt: target to send message to
> > > + * @msg: message to send
> > > + * @len: length of message
> > > + *
> > > + * Calls netpoll_send_udp and classifies the return value. If an error
> > > + * occurred it increments statistics in nt->stats accordingly.
> > > + * Only calls netpoll_send_udp if CONFIG_NETCONSOLE_DYNAMIC is disabled.
> > > + */
> > > +static void netpoll_send_udp_count_errs(struct netconsole_target *nt, const char *msg, int len)
> > > +{
> > > +     int result = netpoll_send_udp(&nt->np, msg, len);
> >
> > Would you get a "variable defined but not used" type of eror if
> > CONFIG_NETCONSOLE_DYNAMIC is disabled?
> >
> Most probably yes, I'll check. If so, I'll add __maybe_unused in the
> next iteration.
> 
> > > +
> > > +     if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
> > > +             if (result == NET_XMIT_DROP) {
> > > +                     u64_stats_update_begin(&nt->stats.syncp);
> > > +                     u64_stats_inc(&nt->stats.xmit_drop_count);
> > > +                     u64_stats_update_end(&nt->stats.syncp);
> > > +             } else if (result == -ENOMEM) {
> > > +                     u64_stats_update_begin(&nt->stats.syncp);
> > > +                     u64_stats_inc(&nt->stats.enomem_count);
> > > +                     u64_stats_update_end(&nt->stats.syncp);
> > > +             }
> > > +     }
> >
> > Would this look better?
> >
> >         if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
> >                 u64_stats_update_begin(&nt->stats.syncp);
> >
> >                 if (result == NET_XMIT_DROP)
> >                         u64_stats_inc(&nt->stats.xmit_drop_count);
> >                 else if (result == -ENOMEM)
> >                         u64_stats_inc(&nt->stats.enomem_count);
> >                 else
> >                         WARN_ONCE(true, "invalid result: %d\n", result)
> >
> >                 u64_stats_update_end(&nt->stats.syncp);
> >         }
> >
> 1. It will warn on positive result
> 2. If the last `else` is removed, it attempts locking when the result
> is positive, so I'd not do it this way.

Correct. We could replace the WARN_ONCE(true, ..) by
WARN_ONCE(result,..), but this might look worse.

Let's keep the way you proposed.

Other than that, the patch looks good.

Thanks


