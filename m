Return-Path: <netdev+bounces-41674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F847CB9B5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 06:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1121D1C20910
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 04:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E7DBA48;
	Tue, 17 Oct 2023 04:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJ8AHRFT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B84BE5D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:21:20 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DD68E
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 21:21:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-406609df1a6so50670685e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 21:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697516477; x=1698121277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSCcyJKKhe9oQwQDqf1wV5AdygiSe6A+VMWBZelRBOg=;
        b=YJ8AHRFTCYB/cJuxDZZuLSMHm/C4yD8PzX9WGV1FWQoS67mkZ84DC4d69VIYNyHjMh
         UnMe4OwlfS82kz9s3jpqQIDmN/+u+JfjLjd/TczbN5VzyUfCtZaafXpHcYqVsSz3RQHu
         f4lnonVwQ1+q2kfMKx1Qz0z7pU6RkBroQWF25v8/gKHY7z0r3KX4H88nqERn9TebRwOJ
         CHHzqq8O4O2xyuwJcGbuPazTJ6vd18AQQ8IYU1Y/7tKGQdOoAn/Ju2ZGuY2RwtODw2Rl
         orpVVG5P/l732H5YLM/uKkNLQlBvrxdUxziEiu6jS79BUi6pWSTr8MkDeTZrsrWAxxie
         Euvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697516477; x=1698121277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSCcyJKKhe9oQwQDqf1wV5AdygiSe6A+VMWBZelRBOg=;
        b=XtKltbhzAbtYDPG5dS51u0GP1DiG9RFes8C0FCnABjFrAKwW27QO8dZedhXA1SFIyY
         yahN7Tx8sEwdvWuNXW/qAh1r/gXBDVKpMBZktj5v5ppjZPjRB2EOPiSc2mgWwzlqOLW/
         UQgbuXvFRKlmer4KfOhdr9OFq49YfNrOQD0I8oVFOMRfakKdwegKRwph8ugwkKK88CfR
         lqhMCURFJZGE/bgbVDbbfkeJZ0yA3QjaY2hzkafjfXWwRk4biAcXA7eSyggg1OQtHmcv
         syhR9lvEzc3Z9OvcRIcTvC1fB8JESzKluRhIPfJhD5woVwMg1fooIioJBkmAnkfKiGib
         F9Aw==
X-Gm-Message-State: AOJu0Yw2W9YbWB7Tsb1DVB7T7vaEpujp6p+elAV2cnGGPeS9h69imEBb
	2zhsn0ZDI8RtTAdtbM5P6gmo8Q==
X-Google-Smtp-Source: AGHT+IFXi6U+vu92ahA0dSTkSUF4s/rRSRQ+VtC9Ir5a0Pm9QEmodyk0y5hzOYvsChcxJgVJkeg+wg==
X-Received: by 2002:a05:600c:4744:b0:403:9b7:a720 with SMTP id w4-20020a05600c474400b0040309b7a720mr886510wmo.1.1697516477154;
        Mon, 16 Oct 2023 21:21:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b00407752f5ab6sm758943wms.6.2023.10.16.21.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 21:21:16 -0700 (PDT)
Date: Tue, 17 Oct 2023 07:21:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Gilbert Adikankwu <gilbertadikankwu@gmail.com>,
	Nam Cao <namcao@linutronix.de>, outreachy@lists.linux.dev,
	manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
	coiby.xu@gmail.com, gregkh@linuxfoundation.org,
	netdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Add bool type to qlge_idc_wait()
Message-ID: <32b0e468-6943-431c-9f71-68fc41727914@kadam.mountain>
References: <ZSoxLxs45bIuBrHg@gilbert-PC>
 <20231014065813.mQvFyjWb@linutronix.de>
 <20231014071423.UgDor1v0@linutronix.de>
 <ZSpIPippZFtMw2aG@gilbert-PC>
 <78f321db-bc09-06e8-b4ef-ac56ab91e187@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78f321db-bc09-06e8-b4ef-ac56ab91e187@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 04:19:09PM +0200, Przemek Kitszel wrote:
> On 10/14/23 09:50, Gilbert Adikankwu wrote:
> > On Sat, Oct 14, 2023 at 09:14:23AM +0200, Nam Cao wrote:
> > > On Sat, Oct 14, 2023 at 08:58:13AM +0200, Nam Cao wrote:
> > > > On Sat, Oct 14, 2023 at 07:11:59AM +0100, Gilbert Adikankwu wrote:
> > > > > Reported by checkpatch:
> > > > > 
> > > > > WARNING: else is not generally useful after a break or return
> > > > > 
> > > > 
> > > > What checkpatch is telling you here is that the "else" is redundant and
> > > > can be removed. Although your patch suppresses the warning, it makes the
> > > > code messier :(
> > > 
> > > Ah wait, after reading Julia's comment, I realize that the "else" is not
> > > redundant at all. Seems like checkpatch.pl is lying. So ignore what I
> > > said.
> > 
> > Thanks
> > 
> > 
> 
> Could you consider fixing checkpatch instead?

Parsing C is quite hard and checkpatch is never going to do it well.
It might be fun to start this project but it's kind of doomed.  Doomed
projects can be an educational experience as well.

The way to do it might be to add a new in_else_if variable which tracks
if you are in an else if block.  You would look at the indent level and
try the curly braces.  Then if the previous thing was an else_if silence
the warning.

But also it's fine that checkpatch prints the occasional incorrect
warning because it teaches people to be more careful.

Another thing is that when you introduce a bug, you should always
consider if other people have done that before as well.  Perhaps do
a `git log -p --grep "else is not generally useful"` and see if everyone
else did it correctly and if reviewers caught the mistakes.

regards,
dan carpenter



