Return-Path: <netdev+bounces-38468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB227BB120
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 07:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9813F282023
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 05:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7183FF5;
	Fri,  6 Oct 2023 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwgeUQ2w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB8EA1
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 05:14:57 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A471B6;
	Thu,  5 Oct 2023 22:14:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690fe1d9ba1so366718b3a.0;
        Thu, 05 Oct 2023 22:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696569296; x=1697174096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbvIh4emsC61M3uO5AOYSm7p42KtRtYejorlTut5jfM=;
        b=WwgeUQ2w2ZX7rKl/E334zUIoUyEvnD3Prw3Z7TcUlqhLVXbfbhZLcxupLApgXqu8Vu
         0Vr2TZThHwo/gy2Rd6064VZK6c9e9McazhRHahWOV0pJ3XUF9zK1QzGkZ9J+Rn3XAoOq
         Jerq2PcU691+vZSLB5rk0NzjTiZ577RRV56E7LRQFwXrQQmDumaf8BewIuUzA1FRA7gR
         q7XhEJOTVORkqvOTxFYeNNuUgXoi9g8YFW+JaEPrY2a+NGMKuKuXuKJcPvKl7UMChpBV
         YwW/tXIlvRJ9c3sM2nTb2oSCi4USLm4xi4Vj/tyHOffhu0iH0LzedrPJnSmKm5sRIEzh
         abTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696569296; x=1697174096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbvIh4emsC61M3uO5AOYSm7p42KtRtYejorlTut5jfM=;
        b=eEwwbbIjP87f0gjQz8RdEBK3XXu8t0pS/NTWaUtqaZsiKBcsXP6SW6PF7hH3iQzXfy
         Ygf1y4qJbu8egGNEyRdbyNbMCMhbX8JyikV8ySaNF4zw5fi+mMCS/KO7YZR9Ei66AARb
         pIV9W5Q88Qlxl5yimLYmqfhXQZbrMKDhwyIDmELgp0lKSxAey9Bl37N5kHUbpJqt4tO7
         i6ykRw6Zs2+gHosx9t3ytMSlQvhwL7LpFKh7OwV15+f5z6XifFcZ8UoLfW3RQCNuHa05
         wS4U6r98bIOphfY4lAHKIpCg4MCGv/sYbBpwfsFV7eId1HEv38hUvmRB5gRtKuDi9etV
         mbdQ==
X-Gm-Message-State: AOJu0YzmpcF99q0no8Z2yb5wFhh0ZwLXlsUxJ0x2MjJjrqRK4ls8ZZ/C
	NYlNNNu/G48s5Ocn+HWomz0=
X-Google-Smtp-Source: AGHT+IEWDbnhjGmpng9/dYTbeZphpz6QPuIfmRBR1OEe70CidIVIg/suP1vxru1ogEz0gYaYhDrLbQ==
X-Received: by 2002:a05:6a00:3ab:b0:68f:c309:9736 with SMTP id y43-20020a056a0003ab00b0068fc3099736mr7495840pfs.3.1696569295715;
        Thu, 05 Oct 2023 22:14:55 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id p25-20020a62ab19000000b006936d053677sm502912pff.133.2023.10.05.22.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 22:14:55 -0700 (PDT)
Date: Thu, 5 Oct 2023 22:14:52 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar =?utf-8?B?KOCkruCkueClh+CktiDgpKzgpILgpKHgpYfgpLXgpL4=?=
	=?utf-8?B?4KSwKQ==?= <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
Message-ID: <ZR+XzKrxgpURda/i@hoboy.vegasvil.org>
References: <20231003041701.1745953-1-maheshb@google.com>
 <ZRzsWOODyFYIxXhn@hoboy.vegasvil.org>
 <CAF2d9jh46s=ai1Ykgk3Lsg8Nb6qRNY6bWPV3fVCTC_S95csyag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2d9jh46s=ai1Ykgk3Lsg8Nb6qRNY6bWPV3fVCTC_S95csyag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 04:23:27PM -0700, Mahesh Bandewar (महेश बंडेवार) wrote:

> Probably it's fault of my mailer-script which finds the reviewers for
> individual patches by running scripts/get_maintainer.pl but then
> coverletter is just sent to the mailing-list

No, it is your responsibility to ensure CC list is correct.

Thanks,
Richard

