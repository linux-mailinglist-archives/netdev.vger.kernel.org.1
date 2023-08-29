Return-Path: <netdev+bounces-31283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B878C712
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 16:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34821C20A30
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 14:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C283117AA0;
	Tue, 29 Aug 2023 14:15:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5687EADC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 14:15:09 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CD71A3
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 07:15:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so273128a12.0
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693318504; x=1693923304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xeDylU+kXIFI8VAdQQpgMmEQl8NnsxokpRjlVOYRtKA=;
        b=AGSVVljt3aRF4LN3ayyc9rZw4RtXnf0clXTLwGTTzTYEyhZTPUeDuMqb1fzmSQtbA/
         7RQBRB72SCWz68W7Z9JIBXvxVcoB0beIbop+Cft+2xoHSk6BwUfi6C0YfabAuyYlLVJy
         OjZRDTyikVOaBj1/RAB0J/cTXd0HsPT97FkTPQBUNe10kzmDo1yVy/RoMyUjwtNUXgoY
         yFJazB1tS5lZZjLnX/3JsnHEWQ47nBmMXmfogb335h4VtXWM/E0Md93JwtQWQiEfzfMG
         MgdkvvKBx496dk0fz75vpKOLbaAEh8I1IG9fAyhKTHpyuLrerdIrwehDItTrfWwb7GUJ
         +jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318504; x=1693923304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeDylU+kXIFI8VAdQQpgMmEQl8NnsxokpRjlVOYRtKA=;
        b=A96Y7PhNOEuKMypCyS7gmnNWYgJspn1JlW6z+7tteLbuFZtxiv+dM6Qw7eC7caFmdM
         4vmbX7k4z7P1JzOus6rjVoeqI2hZnqqBHDLHIAeebzOyJXMEnt+0PC2b3LVAkLdwbzTv
         9nkt2QRToodFejWYcdFR72ipSy7FnDC/hyqDdwv2KAuShwgj/rLbH0TdIFOuEQ0Fi3up
         T3vh8qQYhGufPr3TDR9FzzQmMzxZ3FbkHSFcadYVg34fM4fpbZsyIGdwaQwMbRX3S7Z1
         aVAv5UtsvwdRc6M9eY0Cr7qbgbPM1zSqkpNZaR3aZ7pmRK4KM528WP7p80O6dpoAUGAr
         6c8A==
X-Gm-Message-State: AOJu0YwTcJEArKD6U2QXY7GJrzGGyId7yZrs69SIs77fAGT/MfpRx70e
	qBwJf+EoRckObizHPbKsft4=
X-Google-Smtp-Source: AGHT+IG0hnW9A6TptY6/hdALT2AqqXTwK8YH8j4HVLGl9OI6OPvKnHGzHhHrVsjpvLcjEPcZA1ikXA==
X-Received: by 2002:a17:90a:3041:b0:26d:412c:fc3c with SMTP id q1-20020a17090a304100b0026d412cfc3cmr26759955pjl.3.1693318503990;
        Tue, 29 Aug 2023 07:15:03 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id t20-20020a17090b019400b002694fee879csm10854513pjs.36.2023.08.29.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 07:15:03 -0700 (PDT)
Date: Tue, 29 Aug 2023 07:15:01 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	netdev@vger.kernel.org, ntp-lists@mattcorallo.com
Subject: Re: [PATCH] ptp: Demultiplexed timestamp channels
Message-ID: <ZO39ZUlbLPp2py2O@hoboy.vegasvil.org>
References: <Y/hGIQzT7E48o3Hz@hoboy.vegasvil.org>
 <20230829114752.2695430-1-reibax@gmail.com>
 <20230829114752.2695430-2-reibax@gmail.com>
 <ZO37vZvXX9OPDLHH@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO37vZvXX9OPDLHH@hoboy.vegasvil.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 07:07:57AM -0700, Richard Cochran wrote:

> > The operation can be controlled via sysfs. See file
> > Documentation/ABI/testing/sysfs-ptp for more details.
> 
> No need for new sysfs hooks.

Just add a ioctl that adds a filter to an open file.
The filter can be a simple bit mask of say, 1024 bits.

Thanks,
Richard

