Return-Path: <netdev+bounces-39487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09037BF777
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7041C20A11
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51B171DD;
	Tue, 10 Oct 2023 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6960168DC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:36:42 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BE194;
	Tue, 10 Oct 2023 02:36:37 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso9660060a12.0;
        Tue, 10 Oct 2023 02:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696930596; x=1697535396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+7Sp+Nctt+QTWrvypxowUN2q52OajvsMjizCJrbX2Y=;
        b=IgTIHrvsFGOhmjfmIkUX4QSmeKGxQx+GZM22JejJbS0NtNQhRRo+7EGtZFWSgyX7l+
         VhBq8LLolMqPul3mddwM5xyTjT7hFadL17WY9oiR5v46z1Rce/LbDcxqf5H7AvCVzDB8
         3/sG//oRTysIA4sWMkGRGKf4DVUifyagUPgHzm8YHux4O1OnRPgtkID+ELCsspoF6MHO
         +l698tdBaOY9kpNZishftL/lE5E8efpnf/qPd9FNbH1iikc0gl8SXx1+LTABO/Mi0Ah1
         yTWDHMgfj+8SVEvWLfpU18iFpyt0xKl5HaUT0SFuUwAkPxvkCyAqMlf0v7trhlTuSfSk
         I+/A==
X-Gm-Message-State: AOJu0YyUv+Rah3oIwlPQ+llE65yL++YIpebsdEI550rYp6rFqixTPrw8
	ik0QaSrY+aidMuKp4J2VB+Q=
X-Google-Smtp-Source: AGHT+IFDXZDlf9SrzfkKKk2dI3IlBkw7Dl8o4s+ZmG7+6WR1ioPYvVfNKmYwipN+QhwJVc8rN9ghiw==
X-Received: by 2002:a17:907:760f:b0:9ad:78b7:29ea with SMTP id jx15-20020a170907760f00b009ad78b729eamr15389940ejc.44.1696930595756;
        Tue, 10 Oct 2023 02:36:35 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id m14-20020a1709066d0e00b00991d54db2acsm8113285ejr.44.2023.10.10.02.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:36:25 -0700 (PDT)
Date: Tue, 10 Oct 2023 02:36:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: jlbec@evilplan.org, davem@davemloft.net, pabeni@redhat.com,
	Eric Dumazet <edumazet@google.com>, hch@lst.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: Re: [PATCH net-next v2 1/3] netconsole: Initialize configfs_item for
 default targets
Message-ID: <ZSUbDibPcpd4TqCq@gmail.com>
References: <20231005123637.2685334-1-leitao@debian.org>
 <20231005123637.2685334-2-leitao@debian.org>
 <20231009193158.28a12cd8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009193158.28a12cd8@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 07:31:58PM -0700, Jakub Kicinski wrote:
> On Thu,  5 Oct 2023 05:36:34 -0700 Breno Leitao wrote:
> > +static void populate_configfs_item(struct netconsole_target *nt,
> > +				   int cmdline_count);
> 
> Could you move alloc / free_param_target() to avoid the forward
> declaration? (separate patch)

Yes, this is a good idea. I tried to avoid the forward declaration, but
I didn't find this solution. Sending a v3 with this change.

Thanks for the review!

