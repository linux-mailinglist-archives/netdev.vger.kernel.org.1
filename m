Return-Path: <netdev+bounces-14703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD10743339
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 05:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A12280F98
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB78187F;
	Fri, 30 Jun 2023 03:33:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6033A187E
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 03:33:22 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF982D5B
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 20:33:21 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so333504b3a.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 20:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688096000; x=1690688000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jM/AUq/RMEa5c9tqz/HcfbKPNY5hIFG9GawyK28aaDo=;
        b=I14MZ3+iveLdwE4YbiK1KkbLFJRv4QCRs6SENdXvswCmqsROI1n4zIRSJo+zgrtj2O
         LKkFF0YognTaQUo9Own634Vi2ZteobJSDFasgP0aXKqAhr3h0eQzLYQujFerINpIFvg8
         qw0knzJwi5MIu3gHrXAeN6xHUfLXWqsJzNm9wvbkfHbJe/ZbJQfsudk/u1O37DNQkn1q
         dPONlxKr0fEUHT1npnzAqcdGLXN1aS93VLTNmH7PgKiNgleTVYbq5YanydgLOuVxp3bx
         bk5Jbc35QWN2ZD8P/maNEafOica3az+BoElPG+A6+Q1evoIoY7R3MyAxhoE88laFXXJE
         ecTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688096000; x=1690688000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM/AUq/RMEa5c9tqz/HcfbKPNY5hIFG9GawyK28aaDo=;
        b=Rx527xP49I/KzpHsUPboXEVBwDKb6gcO0yJ987NZcDWLqw9+yznWY0EAGqokpdvhmG
         GmMQw518rW0BEKUEZ6le0B+ki0qSZIe5O2CbPHKSIrrdw6nvSo9IUbA//DvP8KdquWTv
         hW0VgXS1yjBAgOBV+7lZzPa8QqU4TqVuyNFx/MQi5u49Pb21oHvdQ3CdoSUwaVYzpbFt
         sFXmDj6YBoR7tj99Z8GbrQyT0eYO5uYQcXyOxvOIESm25k/ERPcJ3uOs7CxvucE1atb1
         eytF6SjAbPmgMfnMDB1Dy0ts7uBIFBQ7wpsa0tDkQOIdwBb7RMI/zzgRQ1umDPnCeWMb
         XPGw==
X-Gm-Message-State: ABy/qLbH96xD0C18LhMKYKDPr43dNCd2glB006BpEJDsao/75cwAY4xd
	Ng7Z6Kc8NNrBs/kNOH/gCL/0B3SBmLs=
X-Google-Smtp-Source: APBJJlFkj6gEDy3AZXrqSAMF0josj+9BhNnXNj8jTPfmdg1Stpm1eSzwg6Snr6vyEFyB1gW0lB7IGg==
X-Received: by 2002:a05:6a00:1f90:b0:675:8627:a291 with SMTP id bg16-20020a056a001f9000b006758627a291mr1808226pfb.3.1688096000400;
        Thu, 29 Jun 2023 20:33:20 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id c26-20020aa781da000000b0062e0515f020sm9010683pfn.162.2023.06.29.20.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 20:33:19 -0700 (PDT)
Date: Thu, 29 Jun 2023 20:33:17 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeed@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
	Nathan Chancellor <nathan@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
Message-ID: <ZJ5M/aHvomJEUyox@hoboy.vegasvil.org>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
 <20230629110648.4b510cf6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629110648.4b510cf6@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 11:06:48AM -0700, Jakub Kicinski wrote:
> On Tue, 27 Jun 2023 16:21:39 -0700 Rahul Rameshbabu wrote:
> > The .adjphase operation is an operation that is implemented only by certain
> > PHCs. The sysfs device attribute node for querying the maximum phase
> > adjustment supported should not be exposed on devices that do not support
> > .adjphase.
> 
> Richard, ack?

yes

