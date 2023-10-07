Return-Path: <netdev+bounces-38806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578867BC8F3
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EBF281E40
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F57131A72;
	Sat,  7 Oct 2023 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Gg9ObMRa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1D18B14
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 15:57:39 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2025BA
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 08:57:37 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1dd54aca17cso2278325fac.3
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1696694257; x=1697299057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXMnBmVZNTmd1/teXe44k/LwLmaHAv9BZ0ZKFmAyKxg=;
        b=Gg9ObMRadsaGYu/j7A1/ANcwoQF2aITIaM4BT9grkiRNtghblCzuY4qUSp0tunl+OB
         XH4FS5At7RLhF8yFU24WC2J87G544iY3tyidTvquQf4ocOh8DPIhuPUOTrFafM1KkX67
         rA/Et8etFio8n4sgd7Uev98wq1xlSRkOb5ViOp5O+HxYy52qdSImez8GCU8XvODlmFgz
         YIP7L3GfiUxYrkhzMuXfp6uCVgHeIhON0QkGIIVvpyoHSk8mWQ2Shnisaldf3W+Sm/wZ
         g7I6sFwqVQ/JUHuHtnAB9Es+labyw5dpy6KRKON80i+rzCDaoAJXGBCBuDr/zrn+7OhC
         /h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696694257; x=1697299057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXMnBmVZNTmd1/teXe44k/LwLmaHAv9BZ0ZKFmAyKxg=;
        b=d8bMYK5YRioDqZEOmKxws9Q0K7/hlSpfUOo3m5L5IhzCXTmipRY0ks20PTd4JO1Tnl
         NjXXp8lqUvpOHWpjI5lybX1BEtbCgCFYuHw+eb8poD5sTC1Nk4hV9RK8gkCzltPxKd0G
         cMTuo59CO6e+aEwUZmbBy3s7MfsUlTPizDgDP/r3616D3N0fh0LHH90A7r4lF5rlk4ej
         7d1WONz4gTG9WzW8lgAo9jV9NHjfuF6HbKjDNmLYg5HaiPLLC+6m7FyggMnohxmTF2dB
         EpDn1iACWMiB4ct3NLe+HfTnj2hPJNoVahUOa3T2LcVW83PL0S9ym7umcgzjXeBhMWo8
         ECfQ==
X-Gm-Message-State: AOJu0YyQAMzHL42NPdqHu+SlhDgtldgkIPMz3W5W0WJhnkorH1c4QzLX
	k5H7Evujb9QTDA0CXBkgwxvKsfZJwKEDtPTctu8=
X-Google-Smtp-Source: AGHT+IFH7hzEINq4xpkKSRr5z6v7uIuhLvhZrcLRo9XounHbUQI6Naa/DyuXgkj+oek8BYcmmAkaDg==
X-Received: by 2002:a05:6870:1814:b0:1bb:83e9:6277 with SMTP id t20-20020a056870181400b001bb83e96277mr12289709oaf.33.1696694257158;
        Sat, 07 Oct 2023 08:57:37 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id b20-20020a17090a489400b0027732eb24bbsm7312901pjh.4.2023.10.07.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 08:57:36 -0700 (PDT)
Date: Sat, 7 Oct 2023 08:57:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Willy Tarreau <w@1wt.eu>
Cc: netdev@vger.kernel.org, rootlab@huawei.com
Subject: Re: Race Condition Vulnerability in atalk_bind of appletalk module
 leading to UAF
Message-ID: <20231007085735.1594417f@hermes.local>
In-Reply-To: <20231007063512.GQ20998@1wt.eu>
References: <20231007063512.GQ20998@1wt.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 7 Oct 2023 08:35:12 +0200
Willy Tarreau <w@1wt.eu> wrote:

> Hello,
> 
> Sili Luo of Huawei sent this to the security list. Eric and I think it
> does not deserve special handling from the security team and will be
> better addressed here.
> 
> Regards,
> Willy
> 
> PS: there are 6 reports for atalk in this series.

Maybe time has come to kill Appletalk like DecNet was removed?

