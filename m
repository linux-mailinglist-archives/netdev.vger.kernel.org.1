Return-Path: <netdev+bounces-28462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D1E77F801
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2301C20F22
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8714A84;
	Thu, 17 Aug 2023 13:44:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF51427B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:44:58 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C375F210D;
	Thu, 17 Aug 2023 06:44:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc6535027aso65058485ad.2;
        Thu, 17 Aug 2023 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692279897; x=1692884697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AJ7QLlmj+oGDMTqfO6aXYK60zhhXJovQvJlQtGQ9e8=;
        b=W/znyf8dHxEwrJ+G4FyeG50KXu1NTCMemB43KO3I+E4ESqiV5Nx7Fb3xiuv0jyAzOR
         hwbKJZx2Mrj4eijnNB3JD2PCgjaz8By87PX8G3e7iOBSIphO9BToX/K0r8pf9KIhKLQ3
         ge6KQeOYHmgwFYJRziww3cIbdWV+K9w+7zr6f+ZDQyCFYx7ecgaVIa1Kv7KrJyY0etGa
         sr4t63jW7n5Agk9KZXHkH3VXjAzwraTJ4UucuuiC1d3fxKMwfeS/4wkCSx23cOD0Nj6l
         NVfferGUcvFTmeLBSfoyL6FisFLgHLaz7NTTAiKFF2mc0or/7qmuC+2CUsIiPWaW0X9r
         tvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692279897; x=1692884697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AJ7QLlmj+oGDMTqfO6aXYK60zhhXJovQvJlQtGQ9e8=;
        b=cmSqmZm4P/AHRBwgHV7u5xOO5yQOalXQ2LvHaqPqERPPY1v2WXN4H0lRC6UTkKZUjn
         +cbi/2YEgh05eDAPNF/pRTpNrRScUpeYt+tBOOfEjOMfDvZhZ+swlH19BzQvzBPxfcxf
         JR5RmCyRJ8oK+fTta3yRimlnsCaMPoGCPWqidSLHJVkgwVBlO9vxofU3ceStNj5lPODJ
         XkuCnJa9qJ5YHr3zkqv80aoTKY7zpaGZVdDirkdTB5WVdFvKxC1pa8CaBJjMGrlCB0Go
         t0sHBL0IumJNvh1a98cVrfrxOYk4aPrqnXqxOnLKSFeOcWX/Bzif/HcwmNk/uRtUk5Lq
         KBFQ==
X-Gm-Message-State: AOJu0YxJuUy547IbPwoK++/OngFJpnu7caxz/vQi+w2sX3vJTgtDDupe
	Z5FG3ZM8CNQ6pyUc2XocOrkNgSCKBhk=
X-Google-Smtp-Source: AGHT+IGqhIw/APeEonkgb8bQb6CijRLdxsPsJRYbkmPdS8b8JwCLMZYbC940ZVCb4GVYactqT0KAGA==
X-Received: by 2002:a17:902:82ca:b0:1bb:a522:909a with SMTP id u10-20020a17090282ca00b001bba522909amr4725511plz.37.1692279897239;
        Thu, 17 Aug 2023 06:44:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902da8b00b001b9e9f191f2sm15227205plx.15.2023.08.17.06.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 06:44:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 17 Aug 2023 06:44:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] bnxt_en: Expose threshold temperatures
 through hwmon
Message-ID: <c908a4a7-7e76-4a0c-9003-435bda0653a7@roeck-us.net>
References: <20230815045658.80494-1-michael.chan@broadcom.com>
 <20230815045658.80494-12-michael.chan@broadcom.com>
 <c6f3a05e-f75c-4051-8892-1c2dee2804b0@roeck-us.net>
 <CAH-L+nM4MvWODLcApzFB1Xjr4dauii+pBErOZ=frT+eiP8PgVg@mail.gmail.com>
 <3d70325b-6b6a-482f-8745-36aceb6b2818@roeck-us.net>
 <CAH-L+nMSZUtDcG9qFSLMJ7ZGDNz91cp+nw0Le7yoxeMkQg9qyA@mail.gmail.com>
 <d6e093d7-0ff3-4545-9ff8-1c342879fe40@roeck-us.net>
 <CACKFLi=o9g8iBeJHzhCYHXBQvdwT+sy6PKCDRGaqATZL0jMurA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=o9g8iBeJHzhCYHXBQvdwT+sy6PKCDRGaqATZL0jMurA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 11:28:07PM -0700, Michael Chan wrote:
> On Wed, Aug 16, 2023 at 12:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Aug 16, 2023 at 09:42:17PM +0530, Kalesh Anakkur Purayil wrote:
> > > [Kalesh]: Sorry, I don't quite get this part. I was looking at the kernel
> > > hwmon code, but could not find any reference.
> > >
> >
> > It would be non-standard attributes, so, correct, there is no reference.
> >
> > > Can we add new attributes "shutdown" and "shutdown_alarm" for tempX? For
> > > example:
> > >
> > > #define HWMON_T_SHUTDOWN BIT(hwmon_temp_shutdown)
> > >
> >
> > Not for a single driver. You can implement the sysfs attributes
> > directly in the driver and pass an extra attribute group to the
> > hwmon core when registering the hwmon device.
> 
> Thanks for the review.  I will drop these hwmon patches for now and
> respin the others for v2.  Kalesh will rework these hwmon patches.

Alternatively you could keep the standard attributes and add the
shutdown attributes later.

Guenter


