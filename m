Return-Path: <netdev+bounces-37875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D34C7B772E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 06:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id AC38F1F21C7B
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 04:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8931115B0;
	Wed,  4 Oct 2023 04:38:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63F80A
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 04:38:52 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0681A6;
	Tue,  3 Oct 2023 21:38:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690f2719ab2so215242b3a.0;
        Tue, 03 Oct 2023 21:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696394331; x=1696999131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbFdAsFnAZoMfChiC/oIqF+QikUCDg7eR65V7s4K6SA=;
        b=MnpROClSdP/HJbI3eeSG6MbwMOuRHsl2XwvljBGuHvhaBslARvzoIe+jPIlTTua0J4
         qsEQbvq35eBCa+LAmBOH3n8qqUj5zdSqueJKETbPMpp+zMMksnhzgo9mgjn2pf5+L6w3
         mXM2AP59G0nza48HFuisl5cNC/k3Exps+sTfrDJrJTepRXoFAI6CP7ns4fxjnOUrYV8V
         o6j3W1c9Cz6uOtyGfVwFBimpW4Ez8QB158KfaANm+3ZnN97lB78Q51jlgrFB4fq0m+f8
         PJsDyLAhO5ijzCWvv8XSvXEdifz3AlHUw8FXaWX6yKaJeSaqK1mCo7I2uc7C9kb6MuFd
         01Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696394331; x=1696999131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbFdAsFnAZoMfChiC/oIqF+QikUCDg7eR65V7s4K6SA=;
        b=dctEewWz3bMnh4zQM/tdZ0rDOSaatiaN/OA+qiFsYYYSoxo5AF+HMntLnfhAY2u4ES
         xb8DhIxXa8nrciNoea30+LasQpX+hGoHOwRQUO8yIIgT8ISN4KSvZoQM39t55QeqUrH1
         BTjJ6hzojIkPLeA5gDpC7V0Wbs9mjuuv56vjqjkExojOgjV2tVaQ6XpMmLLCePr9/tki
         Maxl0TYAsdluqkGL9QpHhlb02HwMsa3cqEkBYzbki1vfcZWaet1pHev/n4Tgc/Hk936S
         9XMaTnufJzzwmoBpEhFSmYUDpnJll6LHDDnZKWPubJr7pyWsHJtV0XJ9EwvdAvfSqJxY
         q6eg==
X-Gm-Message-State: AOJu0YyZQ1eOYthqvEVEvl6fQCc6KQwRSJvSTodpcYQA3gBGvXL5pmc1
	wMOM42qzywwIyt0/3VN6eeM=
X-Google-Smtp-Source: AGHT+IFkjzasp9QcADPIbOoxbw1hi4TWQSB6Ctlm46/WKgAoKtOrMN8hKUJ2ULQiOxrzJlgy0m1OOA==
X-Received: by 2002:a05:6a00:288a:b0:690:2ab8:2d67 with SMTP id ch10-20020a056a00288a00b006902ab82d67mr1508367pfb.1.1696394331114;
        Tue, 03 Oct 2023 21:38:51 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id i22-20020aa787d6000000b0068fbaea118esm2211958pfo.45.2023.10.03.21.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 21:38:50 -0700 (PDT)
Date: Tue, 3 Oct 2023 21:38:48 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
Message-ID: <ZRzsWOODyFYIxXhn@hoboy.vegasvil.org>
References: <20231003041701.1745953-1-maheshb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003041701.1745953-1-maheshb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 09:17:01PM -0700, Mahesh Bandewar wrote:
> add support for TS sandwich of the user preferred timebase. The options
> supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONIC),
> and PTP_TS_RAW (CLOCK_MONOTONIC_RAW)
> 
> Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().

This change log is horrible.

Please write a proper explanation, and be sure to cover the following
three points.

1. context
2. problem
3. solution

Every change log must have those three items.

In addition, this series needs a cover letter that clearly justifies
the need for this change.

Thanks,
Richard


