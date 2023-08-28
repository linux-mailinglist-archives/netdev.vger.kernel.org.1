Return-Path: <netdev+bounces-30967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4262578A46B
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 04:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3311C20842
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 02:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F48652;
	Mon, 28 Aug 2023 02:06:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9283643
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 02:06:13 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18371CFD;
	Sun, 27 Aug 2023 19:06:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c0a4333e03so5775515ad.0;
        Sun, 27 Aug 2023 19:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693188362; x=1693793162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKYYZEyVm+BiUsLPy2rcN9Etj63llB8S5gjiMWg5j8E=;
        b=aPTb49Iyfk6AfzUdyFj1UD7ONuB3gucR0+MsrGm4JqAMsBawzcqP8AF0eaEVPuTxWm
         FAt90WGRYTXisQEiyitP+Q9C4+sNsgHn5JzhyRqcPaE5d6KzKu/LtKQb/SbqkQaB+0OE
         9NJFHXpR7jI7eRN1/ljYGdLHyqhVGd76lyAgbaIC1pW5VCCw2Ir7UW+PYOX2MDeQgsHU
         qcZvCGrlYvWknB4hVU6OrApwe8Vt96NykrOft9f6leoLFXTruizy8CMrhAHIJr4S1EUc
         CJ2p0YfsESQOKmJkpGuN5lS/OUl1nrPs+udbFLmjPL/eU3eCg1rxQt1wu7o80MmeDuvi
         iV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693188362; x=1693793162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKYYZEyVm+BiUsLPy2rcN9Etj63llB8S5gjiMWg5j8E=;
        b=W7uVm5Wp8+q7cTgwj2r1paMuLJ8YWYoZDdc+cG38Sv04E2k5VUJkG8mkkf3dJlP1Y/
         uueVZ8JPyVkmfeopPsAWCKzf+KttmvED+w27goaN60VB4i+G1/lLaK833v/aT9UebVb3
         R6u4F8D8JT/xhG0XcINxUrdK6cw8y9RwCxBOmHtOGA/1l2yOHW+hTkITMb3jXeraYTvy
         CmUWQJ1YxyCaq9qyoBTY43FY2RK+wqSVt77GG9164902p6m3JD9SwicM+lRYdCCMHXad
         +q7rwVoDtbuVb9Si0YpN7ZWHNSXay+TXAe2uWRd4pMi+Beu4tD2nn3mEHzKkEZCEBb+E
         C93Q==
X-Gm-Message-State: AOJu0YxJz7uqLymmX6QH+58mVw9QI/mdFZKZThc4nYbuZg1iuRrPuCFY
	53hz1oY9VzOLBy/fLXVxJtY=
X-Google-Smtp-Source: AGHT+IE5+jf1rQRanBF2mhIbGjT/QURbaONE4gwwEnEIF16YRCLRbOzpogstUkxWv0CwKqPi+patUQ==
X-Received: by 2002:a17:90a:64c9:b0:263:2312:60c2 with SMTP id i9-20020a17090a64c900b00263231260c2mr22013816pjm.3.1693188362363;
        Sun, 27 Aug 2023 19:06:02 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id mg24-20020a17090b371800b002630c9d78aasm5834501pjb.5.2023.08.27.19.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 19:06:01 -0700 (PDT)
Date: Sun, 27 Aug 2023 19:05:58 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Roger Quadros <rogerq@kernel.org>,
	Simon Horman <simon.horman@corigine.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/5] Introduce IEP driver and packet timestamping
 support
Message-ID: <ZOwBBjNz4IiIEr4V@hoboy.vegasvil.org>
References: <20230817114527.1585631-1-danishanwar@ti.com>
 <20230821190732.62710f21@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821190732.62710f21@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 07:07:32PM -0700, Jakub Kicinski wrote:
> On Thu, 17 Aug 2023 17:15:22 +0530 MD Danish Anwar wrote:
> > This series introduces Industrial Ethernet Peripheral (IEP) driver to
> > support timestamping of ethernet packets and thus support PTP and PPS
> > for PRU ICSSG ethernet ports.
> 
> Richard, let us know if you'd like to TAL or we're good to apply.

Sorry, I was at the thermal spa last week and not reading email!

LGTM

Thanks,
Richard

