Return-Path: <netdev+bounces-24518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C2D77071A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFD11C21524
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794441AA8B;
	Fri,  4 Aug 2023 17:29:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B83FBE7C
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 17:29:38 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC0F49E8
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:29:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso14668835e9.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691170173; x=1691774973;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irB07sqU+6FiV/rfIOutTyfQpC2d089EPvn1Nv6wMJw=;
        b=ddy3hTjxG4F+xZS0IJ31/WwK1UR8GTD2p+9uAUUKswi5Ef7A8OABt51HUxkBeERFvh
         1yjXJiB/CQOmjJ5by55GsHjqxetPCYTJjLZOWIw05L5UIfkysXeCTESsX24/oaQDvsk9
         bPexsfS9GRg9BTvac6qfWmTdRAxCfnHCtrGapzEaUNM/nDr31N+5yuOmrgUuNAr7lt7V
         5SIMbXcKjctfgGqYb0i/uD1g9x2I8e016jyWMGQ3ZIm8FMdq64Fv5/1HN2oSzwJHKdMJ
         lS3rkej1x9FT6NkmZet9JlZxI8ZV2csDXHLfA36qpM2BuGKJDPVTgyu5QjL4AZgUznEN
         mtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691170173; x=1691774973;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irB07sqU+6FiV/rfIOutTyfQpC2d089EPvn1Nv6wMJw=;
        b=DNmzuoiK60jdo2VG7CMXmDZp4HFSN3bE5ftOJWIyEhq+7Vc1bNwxHFxEl3QwSaKxxM
         mq6IY9VkBJH6uVZ9+yrxwtxfkYWZr36y2nXcO16j62KI9fmtkqTUM2Hv1sALIRPL7de3
         +GDAmQRKvUmqCje5g/mEvBnDBmgSR8KepXEltoIRQArFqEOekqonAPteMVCrZTxARBK/
         oLhpfQYv9gEvrRN+OzM3Nar4iJAyCx1jHHpIfTDf/9dYt0y3eIWxMqo1NFlqkeAlQEOB
         GwERh2Yr8OWSCwBgu7iohnEUIC7ZKBxJl7i4E319aiGHEiz5gcNPRK41qGES1qHtuI/b
         oeHA==
X-Gm-Message-State: AOJu0YwRs/VOI01SCbhyNOrjsaZ6iSrLn13Z2otHtbpIMidhxGobdX56
	E86XLQbhWH1QClyzC7iEtfNnZA==
X-Google-Smtp-Source: AGHT+IHVXhAGYDVURGKW2d0j5Qojs4povgPtVXwgPbwvHuo3Xys2qmAk9zePVY/nPLHmYXgi8JPuow==
X-Received: by 2002:a05:600c:1c1d:b0:3f7:e78e:8a41 with SMTP id j29-20020a05600c1c1d00b003f7e78e8a41mr283630wms.18.1691170173013;
        Fri, 04 Aug 2023 10:29:33 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b003fba6709c68sm2872111wmi.47.2023.08.04.10.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 10:29:32 -0700 (PDT)
Date: Fri, 4 Aug 2023 19:29:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org
Subject: ynl - mutiple policies for one nested attr used in multiple cmds
Message-ID: <ZM01ezEkJw4D27Xl@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Kuba.

I need to have one nested attribute but according to what cmd it is used
with, there will be different nested policy.

If I'm looking at the codes correctly, that is not currenly supported,
correct?

If not, why idea how to format this in yaml file?
Pehaps something like:

      -
        name: dump-selector
        type: nest
        nested-attributes: dl-dump-selector

  -
    name: dl-dev-dump-selector
    subset-of: devlink
    attributes:
      -
        name: bus-name
        type: string
      -
        name: dev-name
        type: string

  -
    name: dl-port-dump-selector
    subset-of: devlink
    attributes:
      -
        name: bus-name
        type: string
      -
        name: dev-name
        type: string
      -
        name: port-index
	type: u32

And then:
      dump:
        pre: devlink-nl-start
        post: devlink-nl-done
        request:
          attributes:
            - dump-selector@dl-dev-dump-selector
...
      dump:
        pre: devlink-nl-start
        post: devlink-nl-done
        request:
          attributes:
            - dump-selector@dl-port-dump-selector

Idk, looks a bit odd though to parse the attr strings.

Any idea?

