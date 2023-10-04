Return-Path: <netdev+bounces-37856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57FA7B764C
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 03:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F0259281411
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E547081C;
	Wed,  4 Oct 2023 01:31:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A6807
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 01:31:33 +0000 (UTC)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7113AF;
	Tue,  3 Oct 2023 18:31:31 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-452749f6c47so832460137.1;
        Tue, 03 Oct 2023 18:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696383091; x=1696987891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cV+BD3Itq4BhCRKPqTWiBEJr03DwuwhyYqtmmv79ESo=;
        b=G3mIOH7lIRS7RSIElh4st2pGyWz//e8YWlKlKPlyLFp4SRm9RpH7aQHQgE5n+Pqm2H
         NGbXx/sxseUsb8pPfB9P1xl67wmHy78joNLHirqp9+ilvexiAAX9sOEOyjsBSAsctQk4
         8GCxQdltR5l8xRydUGzj8CcGHtupCLYvCcvzCOEQ3IPAJoRuqrpK+l8AViy1Cgf2bPWR
         DHtMGUOWPoneUWLpC/gDTFsW2Qc38MTZ02Updf1Dig8PVDAjc81dcvduI3+WGtkez7cL
         WZPqHNk071HSP6x4IyYMZvn88hcl7AcvZHvT5B/+WpDHpJbU0bavH33PEPkqjxc6dsGM
         4zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696383091; x=1696987891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV+BD3Itq4BhCRKPqTWiBEJr03DwuwhyYqtmmv79ESo=;
        b=SPskSCW8sxE1kPkJoi6v72axO9EPik0PI9Ujc0r+bRbiiuatJTsvTuoczwTjmwCluJ
         7JOoLFeSPxjj0jexTdaqKaHlLTlhSB20ol8oNPuyf31XIrWieyptgWlvjoarR24Ffudl
         mb6LYIgmFM2rFZcBomDSJaqtECiqaNsE7DysL0TTYncWF326XFDHGcN8+ONKKUmqONx4
         Bz18978O2LyANgnR8Vo9c7jd12VrsmKI3Ud+kYQRvvRtKhRmWZ8vZSI8b0IG3oQ8jIit
         pAt9WcA4ri9XhE3dB+puSr8GQ8GSVBeyEtJCSuBez2uA/NRIYrl5Vn310jOn4boBUk7q
         mhQA==
X-Gm-Message-State: AOJu0Yy8MuS5J0ifpF73jPZ3OckkdRiMvhdT+cOpnb9RdirwGjh7k0ZB
	dryqFUdRuR4IT7UxfOP0MlHDuYOr8OY=
X-Google-Smtp-Source: AGHT+IGeMBp6m0rTIjRjsfd6YmID2UUcreTdFzgykDkyk+nBYzn3upz1wYDiVgyaAg8QD0xn8mp6ig==
X-Received: by 2002:a05:6102:14d:b0:452:bfe3:8941 with SMTP id a13-20020a056102014d00b00452bfe38941mr955351vsr.21.1696383090722;
        Tue, 03 Oct 2023 18:31:30 -0700 (PDT)
Received: from localhost ([2607:fb90:bea0:d290:37ee:5c3d:1002:8e75])
        by smtp.gmail.com with ESMTPSA id b20-20020ab00854000000b007ab975b8eb9sm373678uaf.10.2023.10.03.18.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 18:31:30 -0700 (PDT)
Date: Tue, 3 Oct 2023 18:31:28 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	Tariq Toukan <ttoukan.linux@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Maher Sanalla <msanalla@nvidia.com>, Ingo Molnar <mingo@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Yury Norov <ynorov@nvidia.com>
Subject: Re: [PATCH 1/4] net: mellanox: drop mlx5_cpumask_default_spread()
Message-ID: <ZRzAcJInEJtYuOKi@yury-ThinkPad>
References: <20230925020528.777578-1-yury.norov@gmail.com>
 <20230925020528.777578-2-yury.norov@gmail.com>
 <2fd12c42d3dd60b2e9b56e9f7dd37d5f994fd9ac.camel@redhat.com>
 <ZRwbKRnnKY/tDqCF@yury-ThinkPad>
 <20231003152030.6615437c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003152030.6615437c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 03:20:30PM -0700, Jakub Kicinski wrote:
> On Tue, 3 Oct 2023 06:46:17 -0700 Yury Norov wrote:
> > Can you elaborate on the conflicts you see? For me it applies cleanly
> > on current master, and with some 3-way merging on latest -next...
> 
> We're half way thru the release cycle the conflicts can still come in.
> 
> There's no dependency for the first patch. The most normal way to
> handle this would be to send patch 1 to the networking tree and send
> the rest in the subsequent merge window.

Ah, I understand now. I didn't plan to move it in current merge
window. In fact, I'll be more comfortable to keep it in -next for
longer and merge it in v6.7.

But it's up to you. If you think it's better, I can resend 1st patch
separately.

Thanks,
Yury

