Return-Path: <netdev+bounces-37225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEF97B448B
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 01:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 484091C2084E
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 23:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF5D156D8;
	Sat, 30 Sep 2023 23:07:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE679E0
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 23:07:34 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018AADD;
	Sat, 30 Sep 2023 16:07:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-273e3d8b57aso3212886a91.0;
        Sat, 30 Sep 2023 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696115252; x=1696720052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMD6lstC96bTqqIqisEMOIoG8c7LDdVFsbakUijz8rs=;
        b=dMvLW3ODoq++er18qOLetnkoVxk3zBYEShtEqn4W/Fk+6mjnhgpUAwpERduHoVXLXc
         h5OZI7wHlET4swtRGxXavjZ0gvwa3nTE+M82nX/EgnwsBttBkS9Qg5tr5U0HAWA1+BtP
         X7X80RsBIDgULW3q/e5LEKaB9lAZ+ypF5hjfTklGbjNZgX86cn78P1UBiFzMFvC4yXWy
         L6JC08waOfj6KE9JfYwueK+5wdZgrLKYeFdiNKdEE4wydoek4Uf6dsU+kqtxiOMP55X2
         wmJBI+vmhEDLEXlTfdxHLNE1KCFxqN8Hi95mJz/hh47ZmVjyFLmyagFowmRmBCM2OzPg
         87hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696115252; x=1696720052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMD6lstC96bTqqIqisEMOIoG8c7LDdVFsbakUijz8rs=;
        b=mv98wxkVjxgCVreF3YaKx8gTyPkYaIEixf4R+ME3IKOndnPNl8fbELMZFap681RNvt
         so6Ugiy43ZdArB+CLky74hBXhuhSgwBtdqjrL7MjYHMxKfWgpHSM5cm5Nv/cxNG4Y9x4
         s4M77oY15oNV4IJxZ5CpG5lTKZdR1iCFPaibEYPPGBt13JGgiki4SS+cQUS+/AXjzaJw
         ZmApUA5x/cFXurzDW/upftWEtYIbMZ1YbRU73YMwzCBE4c5azx5WoykNRqHHvzbipKWQ
         WDki2O+BFI/eWnK4N/zC4QT/eRhHjUGQvqSOeCm/tswHAlw56W16xJSV8MTUlMukcIZE
         Vueg==
X-Gm-Message-State: AOJu0YyCiINFOVxM5oZtxPt2HXFDTCgj24EjhVC1HyQKi8KMepZfuOWw
	FqkZcZTCcFybnLeuWRCq0QxcdVJ95NU=
X-Google-Smtp-Source: AGHT+IGpFz0JOfUO/O4JRbkLberIGrg2EuksHTgXnSdegzPALcNbE5H7Jsntcb+sN3QJirtwT75DNw==
X-Received: by 2002:a17:902:ea0c:b0:1c2:c60:8388 with SMTP id s12-20020a170902ea0c00b001c20c608388mr8645750plg.6.1696115252330;
        Sat, 30 Sep 2023 16:07:32 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001b9c960ffeasm19186171pla.47.2023.09.30.16.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 16:07:31 -0700 (PDT)
Date: Sat, 30 Sep 2023 16:07:29 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>,
	Yuliang Li <yuliangli@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH 3/4] ptp: add ioctl interface for ptp_gettimex64any()
Message-ID: <ZRiqMTwkqqXUYPPB@hoboy.vegasvil.org>
References: <20230929023743.1611460-1-maheshb@google.com>
 <ZRiSQ/fCa3pYZnXJ@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRiSQ/fCa3pYZnXJ@hoboy.vegasvil.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 30, 2023 at 02:25:23PM -0700, Richard Cochran wrote:
> But how about a new system call instead?
> 
>     clock_compare(clockid_t a, clockid_t b);

It could have a third argument, n_samples, that would only be used for
"slow" clocks like PCIe MACs.  The system call would return the offset
from the shortest measurement (which is really what user space needs).

Thanks,
Richard

