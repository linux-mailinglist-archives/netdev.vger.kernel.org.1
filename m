Return-Path: <netdev+bounces-28187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6777E99D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9340D1C2111B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 19:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE5817734;
	Wed, 16 Aug 2023 19:25:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8714A80
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 19:25:49 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F49270C;
	Wed, 16 Aug 2023 12:25:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6887480109bso1574492b3a.0;
        Wed, 16 Aug 2023 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692213944; x=1692818744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28lfdjuTNMCB2eFA7fWe/9KsZNdFPJBbWSQw/BHguRo=;
        b=FXSe4iUTtT9IahcwX4Ui5pY3P85oMKTnLulhPl5tg9n6g/J5MzP2m1xU2JuoWWGgoY
         d5HVnhhS3a2kTtNXw8mDaXRLwk11EmrmhKPYKNwZqsqJSpUWSRv/Spxi8p823Ry59S4M
         hyvBc8UVlbaWZaDJWIsStulIk3HetFDTgiekajpx2mIdcig+Srif/Qrl0cyHUO10ysJq
         9WZFBHhD6+VsntL6P4lKUritxzreITh3k5LG2FhkllGRCrAY7jORaZT6SCXCvtEwfZbf
         akr62eLAKnSTrmzv6gWiQ1bupKijDNj019geOYwJd9UTMd4hsihf8MiBaLGDphCacUYo
         Ppxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692213944; x=1692818744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28lfdjuTNMCB2eFA7fWe/9KsZNdFPJBbWSQw/BHguRo=;
        b=LyY8kAvGSkN9oJx5TRArioKyY9JIgHouREG39X65aTMVdyAUxGhbPDEb3IHyV4DDVz
         RMhYhIsBXe03VOpHH5LTrkgNbYh0kY6tIcnej40PFZWwPeO0g0owH7rjHAtpmfeQijbV
         bmixmS8jgAktEeXZBpca2YDgfjXunSdoWvIduemzNbFJDKIjX32pc26EcJlT523gHgPq
         7O5yi0pAp/tkzBCnGfBK5XtmAYXrf5LcDA/LS5xUYjbwv9ZUgRnKWUF731lloCJxI1BZ
         kGV0Q02vykvgPf3b3g3ywLEkhMjCaoixlMirHMtPDVq6JDTJzJeszcgoqjpXuBKOeCgR
         AXLQ==
X-Gm-Message-State: AOJu0Yyma3pbJBWBbsvRb9QCn6lSJWJkXfsUEiAKd/222tzUpSWaotDa
	+OGE990HTfy7bVvzLMYHi5M=
X-Google-Smtp-Source: AGHT+IEi8dquvGw2J9dL3nqK6MeFQvttyfZsPsAS83u2sVGyOD6RctVJkC7mHmXdoz+lvI+3K6qi9Q==
X-Received: by 2002:a05:6a21:7888:b0:140:f6c4:aa71 with SMTP id bf8-20020a056a21788800b00140f6c4aa71mr4214128pzc.8.1692213944029;
        Wed, 16 Aug 2023 12:25:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e12-20020a63ae4c000000b0055b44a901absm6344482pgp.70.2023.08.16.12.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:25:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Aug 2023 12:25:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, gospo@broadcom.com,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] bnxt_en: Expose threshold temperatures
 through hwmon
Message-ID: <d6e093d7-0ff3-4545-9ff8-1c342879fe40@roeck-us.net>
References: <20230815045658.80494-1-michael.chan@broadcom.com>
 <20230815045658.80494-12-michael.chan@broadcom.com>
 <c6f3a05e-f75c-4051-8892-1c2dee2804b0@roeck-us.net>
 <CAH-L+nM4MvWODLcApzFB1Xjr4dauii+pBErOZ=frT+eiP8PgVg@mail.gmail.com>
 <3d70325b-6b6a-482f-8745-36aceb6b2818@roeck-us.net>
 <CAH-L+nMSZUtDcG9qFSLMJ7ZGDNz91cp+nw0Le7yoxeMkQg9qyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nMSZUtDcG9qFSLMJ7ZGDNz91cp+nw0Le7yoxeMkQg9qyA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 09:42:17PM +0530, Kalesh Anakkur Purayil wrote:
> On Wed, Aug 16, 2023 at 5:43 PM Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Wed, Aug 16, 2023 at 03:58:34PM +0530, Kalesh Anakkur Purayil wrote:
> > > Thank you Guenter for the review and the suggestions.
> > >
> > > Please see my response inline.
> > >
> > > On Tue, Aug 15, 2023 at 8:35 PM Guenter Roeck <linux@roeck-us.net>
> > wrote:
> > >
> > [ ... ]
> >
> > > >
> > > > Hmm, that isn't really the purpose of alarm attributes. The expectation
> > > > would be that the chip sets alarm flags and the driver reports it.
> > > > I guess there is some value in having it, so I won't object.
> > > >
> > > > Anyway, the ordering is wrong. max_alarm should be the lowest
> > > > alarm level, followed by crit and emergency. So
> > > >                 max_alarm -> temp >= bp->warn_thresh_temp
> > > >                 crit_alarm -> temp >= bp->crit_thresh_temp
> > > >                 emergency_alarm -> temp >= bp->fatal_thresh_temp
> > > >                                 or temp >= bp->shutdown_thresh_temp
> > > >
> > > > There are only three levels of upper temperature alarms.
> > > > Abusing lcrit as 4th upper alarm is most definitely wrong.
> > > >
> > > [Kalesh]: Thank you for the clarification.
> > > bnxt_en driver wants to expose 4 threshold temperatures to the user
> > through
> > > hwmon sysfs.
> > > 1. warning threshold temperature
> > > 2. critical threshold temperature
> > > 3. fatal threshold temperature
> > > 4. shutdown threshold temperature
> > >
> > > I will use the following mapping:
> > >
> > > hwmon_temp_max : warning threshold temperature
> > > hwmon_temp_crit : critical threshold temperature
> > > hwmon_temp_emergency : fatal threshold temperature
> > >
> > > hwmon_temp_max_alarm : temp >= bp->warn_thresh_temp
> > > hwmon_temp_crit_alarm : temp >= bp->crit_thresh_temp
> > > hwmon_temp_emergency_alarm : temp >= bp->fatal_thresh_temp
> > >
> > > Is it OK to map the shutdown threshold temperature to "hwmon_temp_fault"?
> >
> > That is a flag, not a temperature, and it is intended to signal
> > a problem ith the sensor.
> >
> > > If not, can you please suggest an alternative?
> > >
> >
> > The only one I can think of is to add non-standard attributes
> > such as temp1_shutdown and temp1_shutdown_alarm.
> >
> [Kalesh]: Sorry, I don't quite get this part. I was looking at the kernel
> hwmon code, but could not find any reference.
> 

It would be non-standard attributes, so, correct, there is no reference.

> Can we add new attributes "shutdown" and "shutdown_alarm" for tempX? For
> example:
> 
> #define HWMON_T_SHUTDOWN BIT(hwmon_temp_shutdown)
> 

Not for a single driver. You can implement the sysfs attributes
directly in the driver and pass an extra attribute group to the
hwmon core when registering the hwmon device.

Guenter

