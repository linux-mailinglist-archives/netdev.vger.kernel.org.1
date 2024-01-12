Return-Path: <netdev+bounces-63300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6577D82C2E8
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 16:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136252831DD
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701D67E95;
	Fri, 12 Jan 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QqtHWams"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468E6EB4B
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2cfb0196bcso29571866b.3
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 07:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705074023; x=1705678823; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GUS/zWk7R/lJHGcfrM6/5naojXVMkStE3utaxE6oyKA=;
        b=QqtHWams4JmeHlj+kVIEzoUBurSTXwE6R0v5pk49ysgaJr1MWaPSXrDwR+UMSabJKx
         1PWem0GXACNtRFWSBg/E5UmiGFUPCA6qa7mZKFXOLbJGoxxcb3pvxPO0TEfiCk1vxDRv
         XtBx2cmBcYAGaYp98MdkZ75g+MDUNDg6SR95E+K8u19InBkH3l8MVT3kAgaCgVmd6x3F
         ABj2SYNi1pE7sKHJa4KGB22ctrgDqMJZPxKfpW600+sYImH0imDYVTlhPZajP4tBSJNy
         II9SiWI1Xi24ORdic2ABNS/WhAf+fDlIwwO7EoaqNWqnUBZPjlEL/j3lPCvNx6ATp4QN
         Lj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705074023; x=1705678823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUS/zWk7R/lJHGcfrM6/5naojXVMkStE3utaxE6oyKA=;
        b=tvdhNmeeE+Ow6MK5C7vVbvVrIoefEU05R+ewW3NFSUswxQ30sjdcS/+AQ8iQPmBRlm
         IEFGUM+aAnxvI7GNeCE5H6sytAYMQDOlWpnEz6kATmGAM8O81RF+EJFLFuKboPqhaiCj
         odtl+IA22o9OWs7NnmJ8jmMutdKjBmAQGyQrn6qMovpTifpniJq0s+7mLfm/c9jPbLny
         bbpdtgTQYME783zZWRmmudTdWYfxGvLzTW/xoTFTzieZDFvN2xXvARHGNtr4OssNPIBV
         eHtTfhqm+cNrBEG8hJSorVv3l3Cv5G7Tw60VGI8pneMzq6gRJPDu7TyyYIkb2Pv0eg+N
         ecBQ==
X-Gm-Message-State: AOJu0Yyz8Y1Ns2Usm8PK4AKcGoiKfz0l78DnE5zNW4pJHkLtVLV/qWzF
	gDU6NO1fsW3BMeVSF3Ad9pZ4QF37q64QzJFp0A883UOVIz0=
X-Google-Smtp-Source: AGHT+IGMhoRtdOdR9ePDSk95Aqs9Wu4nNqQ/V64fh7txv2dsN4Y+EhpMXeIwMcKBp5OQNMRipy0tXA==
X-Received: by 2002:a17:906:c18a:b0:a1d:7792:cdbe with SMTP id g10-20020a170906c18a00b00a1d7792cdbemr704671ejz.146.1705074022823;
        Fri, 12 Jan 2024 07:40:22 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id cw8-20020a170907160800b00a2cd72af9cesm585335ejd.146.2024.01.12.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 07:40:21 -0800 (PST)
Date: Fri, 12 Jan 2024 16:40:20 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next 1/4] man: get rid of
 doc/actions/mirred-usage
Message-ID: <ZaFdZFA5ebCmwaNh@nanopsycho>
References: <20240111184451.48227-1-stephen@networkplumber.org>
 <20240111184451.48227-2-stephen@networkplumber.org>
 <ZaEzpWaTLDG6Ofby@nanopsycho>
 <CAM0EoM=bAsbaNsQUbfO_yLHR2PFXBF9Zq3VXBGPhmKtWsMv5tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=bAsbaNsQUbfO_yLHR2PFXBF9Zq3VXBGPhmKtWsMv5tA@mail.gmail.com>

Fri, Jan 12, 2024 at 03:55:46PM CET, jhs@mojatatu.com wrote:
>On Fri, Jan 12, 2024 at 7:42 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jan 11, 2024 at 07:44:08PM CET, stephen@networkplumber.org wrote:
>> >The only bit of information not already on the man page
>> >is some of the limitations.
>> >
>>
>> [...]
>>
>> >diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
>> >index 38833b452d92..71f3c93df472 100644
>> >--- a/man/man8/tc-mirred.8
>> >+++ b/man/man8/tc-mirred.8
>> >@@ -94,6 +94,14 @@ interface, it is possible to send ingress traffic through an instance of
>> > .EE
>> > .RE
>> >
>> >+.SH LIMITIATIONS
>> >+It is possible to create loops which will cause the kernel to hang.
>>
>> Hmm, I think this is not true for many many years. Perhaps you can drop
>> it? Anyway, it was a kernel issue.
>
>Hmm back at you: why do you say it is not true anymore? It is still

Ah, I was falsely under impression this happens in reclassify loop.
Nevermind then.


>there - all in the marvelous name of saving 2 bits from the skb.
>If you want to be the hero, here's the last attempt to fix this issue:
>https://lore.kernel.org/netdev/20231215180827.3638838-1-victor@mojatatu.com/#t
>
>Stephen, please cc all the stakeholders when you make these changes.
>Some of us dont have the luxury to be able to scan every message in
>the list. I dont have time, at the moment, to review all the
>documentation you are removing - but if you had Cc me i would have
>made time.
>
>cheers,
>jamal

