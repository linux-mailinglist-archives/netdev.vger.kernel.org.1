Return-Path: <netdev+bounces-63301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0271C82C2FC
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 16:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B77E1C21653
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7372E6EB5A;
	Fri, 12 Jan 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DUYn1dJK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6586EB4E
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso7470272a12.3
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 07:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705074260; x=1705679060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d64BUGlf77A+r+W1fHkui3CvSSW+q1os2OTtKAp6f9I=;
        b=DUYn1dJKK4rvfyxCGELWtk+1e37AXhMQIDV5OUs7VczR+FGad2P+9lCPTi3bF5fmMq
         9yI61jDT0+rievknod8Sgmw5fNUhmbEsxwUlgwawIdyFsISBC1r7hw0MA4L2E79aB4Xc
         3f4OkhXe7yBdRQ6gS7tGoCgcV3CtjnL+xN7S72jA2LxTiTv1v2v2Pk7545DJjmQZnB6y
         Cvn22pRDe+XCho4lB7eCTTUEwc2JTwDixfwN0bXCbAjpBIShv+StSR4dY7CPUh8b2ANC
         80WsUoE6XYhf+azlocTRAZLeC3rxAc2fYt9cWWU9aGq00hlQzV/AmMMKxiBD00uSFRki
         ZopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705074260; x=1705679060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d64BUGlf77A+r+W1fHkui3CvSSW+q1os2OTtKAp6f9I=;
        b=D8rzPhVih2kOCZ/XDKJDJ0UqWVAIFWgPPyOBk90TxJTrmSTS6Ch/uD23mffzhQDSNY
         gPIUUdkA57Kgf0WO9VjWvIiuchnplmagO3Q7LGSrI3FPBhOIU2itffVqI7cFiZZptq4j
         yaWnOAQyQZkuIQGr11WMHNWY5OlwnP0HbRXLdl4jYa+d4l9z4WY2xwZNy8hiYyjX3aQq
         rvRj+Aj/Yn5DqHEVefI/OaT7DKRC3zlOwV5yuZzP74fFugBhO/bh5e8uE8Q4bIzutyu+
         j+wkC5Apn698N/Sl3D8/RClFd3zbg22tMyvOr3dO86+82IJUEcw8DYa0pzaB9x1j3Sga
         T5RA==
X-Gm-Message-State: AOJu0YwzYYN7FifqentYISA1CQquC2U7GXn3llknLjDHRbw7vajOOqjY
	8hT8FCgkhL4J/5dWbOWziOYmnYiniKu4SPbqpPePlZpZZlY=
X-Google-Smtp-Source: AGHT+IHgH/K5hVbBPk5nml7vOg5sO7SqXF00RHFgO98fkJPmzdZi3MLLO3nVqGaF3f0JqrNv6xAWKw==
X-Received: by 2002:a17:907:c242:b0:a28:bbb8:cb4c with SMTP id tj2-20020a170907c24200b00a28bbb8cb4cmr542607ejc.50.1705074259656;
        Fri, 12 Jan 2024 07:44:19 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q5-20020a170906388500b00a28a297d47esm1910052ejd.73.2024.01.12.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 07:44:18 -0800 (PST)
Date: Fri, 12 Jan 2024 16:44:17 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: add more sanity check in virtio_net_hdr_to_skb()
Message-ID: <ZaFeUZ6F4hWUu4FU@nanopsycho>
References: <20240112122816.450197-1-edumazet@google.com>
 <ZaE39F93nKy4NKqj@nanopsycho>
 <CANn89iLam6JDbJ3NJ3cRs1fnDz2HAN_gMhAn0SewoYbqBLbW4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLam6JDbJ3NJ3cRs1fnDz2HAN_gMhAn0SewoYbqBLbW4w@mail.gmail.com>

Fri, Jan 12, 2024 at 02:11:43PM CET, edumazet@google.com wrote:
>On Fri, Jan 12, 2024 at 2:00 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Jan 12, 2024 at 01:28:16PM CET, edumazet@google.com wrote:
>> >syzbot/KMSAN reports access to uninitialized data from gso_features_check() [1]
>> >
>> >The repro use af_packet, injecting a gso packet and hdrlen == 0.
>> >
>> >We could fix the issue making gso_features_check() more careful
>> >while dealing with NETIF_F_TSO_MANGLEID in fast path.
>> >
>> >Or we can make sure virtio_net_hdr_to_skb() pulls minimal network and
>> >transport headers as intended.
>>
>> You describe "either or", but don't really say what to do. Bit
>> confusing :/
>
>Not sure I understand your point?
>
> Patch title is " net: add more sanity check in virtio_net_hdr_to_skb() ",
>and the change is implementing that option.

Right. Patch desctiption does not clearly say it, that's what made me
wonder.


>
>I am saying I prefer not touching gso_features_check(), even if we
>could just do this.
>
>Had I been silent about that option, I am sure some reviewers would
>have raised the question,
>given the stack trace ?
>
>Apparently you are saying these kinds of things should not be ever mentioned,
>because of some "imperative mood" request that you often raise with my patches.

I woudn't dare :) I just find it hard to understand from time to time,
sorry about that.


>
>I have not written a novel, only one sentence, admittedly not written
>in perfect English.

