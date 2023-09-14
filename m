Return-Path: <netdev+bounces-33889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F117A0904
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADEC281BB7
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F86021348;
	Thu, 14 Sep 2023 15:09:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335781CF9B
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:09:32 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4321AE
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:09:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf1876ef69so2015135ad.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694704171; x=1695308971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLvM6Eu+/PrdtW/q7mimlLPdpi1hXjCXnz2MkgpwrpQ=;
        b=fe9ZzNpmVRpnezXoMV0uMlFMp6vFj7O/xyJSzKAQ9nSJ42CnrXqPz+/+oDREXbMBJi
         FbAlo3ayCzKn7/NJvsfMUGZ5V3FJb9wbWTVbYjK/kIsDSPvVaC2pZ8Ctooeux33oa583
         aTVFgprbu+wACoglqIRWD9gxP+7/O0V5Q9VceIXX3+XRPam+oMme0yIT+zVJ9HD1DcnP
         BFIoyRd6uX0yOfR147oiXkPORfdjUnsvX7sdYdxHJbr9+uEiLSTE/Vu4gXBkDXhFKWjw
         /iVmD5cUidcSmaHBZQQmFOjeAzDoXwDvIKqRHptmja49SKGNlBxUW3TXLLFqsBhgw28q
         NMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704171; x=1695308971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLvM6Eu+/PrdtW/q7mimlLPdpi1hXjCXnz2MkgpwrpQ=;
        b=TrYUQF628DlJMW+gvitCKm3JV+dDv3L4fuz47DZmSbCVfy4GeURapzoMUqM3lmQu5H
         fp5MpRwCHZFu+XBChHY5c6kXZFRz4FfrT1rWrGwnvKw2LWJ+QCnAfZCYWWXebHZpRH87
         oyZtODhSpB1HB9khMQJRsWcw3ZCcmrBwjHJW6q/C251v7nm3G9TAi8atzZ8uyO1LUueu
         1dJJWbBOlpW/yFXKQeDLqmwoBqn1Qt/lLfFeVJiM0yqeq/4mCDH1k64596ELdq8ltTmZ
         VXqonBWXAUN0bLYfLfZvpP2/m10JxbF0eqIM2hbNvC25mcYa8KOi2OgPYEijjDN/FAe2
         ez9w==
X-Gm-Message-State: AOJu0YwPvONUYVg+kVsUuCAzs2CJ88i2z/lyQcrr85aRk6hV8H4kaEMb
	9mRz/84XhMfwhau5vIywH2Q=
X-Google-Smtp-Source: AGHT+IGZMvME2m8+yF4FqdIn5WQClf5+a9sEJVkvEtDOhGaCFEx4bzMAwdno55uYW9O6k9dDQF7L1A==
X-Received: by 2002:a17:903:22cb:b0:1c1:fc5c:b34a with SMTP id y11-20020a17090322cb00b001c1fc5cb34amr6446412plg.3.1694704171038;
        Thu, 14 Sep 2023 08:09:31 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001bf095dfb76sm1692689pld.237.2023.09.14.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:09:30 -0700 (PDT)
Date: Thu, 14 Sep 2023 08:09:28 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Xabier Marquiegui <xabier.marquiegui@gmail.com>, alex.maftei@amd.com,
	chrony-dev@chrony.tuxfamily.org, davem@davemloft.net,
	horms@kernel.org, mlichvar@redhat.com, netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com, reibax@gmail.com, rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v2 2/3] ptp: support multiple timestamp event
 readers
Message-ID: <ZQMiKE6x/euOv3Hc@hoboy.vegasvil.org>
References: <871qf3oru4.fsf@intel.com>
 <20230913085737.2214180-1-xmarquiegui@ainguraiiot.com>
 <87wmwtojdv.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmwtojdv.fsf@intel.com>

On Wed, Sep 13, 2023 at 02:25:48PM -0700, Vinicius Costa Gomes wrote:

> Taking a quick look, it seems that you would have to change 'struct
> posix_clock_file_operations' to also pass around the 'struct file' of
> the file being used.

And let drivers compare struct file pointers from different consumers?

> That way we can track each user/"open()". And if one program decides
> that it needs to have have multiple fds with different masks, and so
> different queues, it should just work.
> 
> What do you think?

See posix-clock.c : posix_clock_open()

When the file is opened, the fp->private_data is used to track the
posix_clock that was registered as a character device by the ptp
clock instance.

That character device may be opened multiple times, each time there is
a unique fp, but fp->private_data points to the same ptp clock instance.

So the information of which fp is being read() is lost.

Looks like you will have to re-work posix-clock.c to allow drivers to
provide their own "private" data populated during posix_clock_operations::open()

Needs thought...

Thanks,
Richard



