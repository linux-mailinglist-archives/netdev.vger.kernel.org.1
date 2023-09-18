Return-Path: <netdev+bounces-34577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B817A4C8E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9205B281F70
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F621DA3C;
	Mon, 18 Sep 2023 15:36:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3B1C289
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:36:14 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5351BC9
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:32:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c3d6d88231so36512785ad.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1695050925; x=1695655725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iy9lIrB7mjiM95RJpTjX+gCpBVpH5d2NhywkdnHkqYg=;
        b=KFtRAv/0iz4k7/kn8akqPBi3nZAMciuD9drEtNlyN5crUZ6FqJKPeWhq+yRG1wNwaM
         SgemVuqvthnKooAlE8y85KTgnJ5xb3hryj5oZMohL4gwmnDGm33xzb9IF17NGotePzC6
         cCwtsVOlHog82sG/LEDYIVJXU6QeVzBjqxYXTZ1AyPSlRS4/UD8GRQCsJ2l5m6+BKhRv
         EOJOC/W5T+tAymHetV4mpjMBB8oAjALnD0AzDU98HUEGWJ+dj5Jhg36bFesEV55+UzRL
         9JzZTkBMdj6dguexBP7NJu+U5EnjqiTgBOR4C0GlnYyFFr0wUKrslO6xjizRq9X/c4RT
         0hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050925; x=1695655725;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iy9lIrB7mjiM95RJpTjX+gCpBVpH5d2NhywkdnHkqYg=;
        b=OVI4xvy6Iwnj05b0Lll4S1wjG5YaWd5W9mkfT75VXKMdYLI2H+ncWhypk6OQCQ0uoo
         wCsc23x5dCwHY9jn774pejUwA287+AX9gEt1mN6paDjV2KHW3DPU9TdOdubqpoFhqf8z
         wg0HXWeYE4Sal1Ybc8e5tneDABb2BU2oMLZrCYri5uDCZGnpEynpfL2315BA86kAdOqp
         np2VMQ3FvhABc70SgK+PZN5hzQsO+aQRmMB6T6GOs76qVtXfG5hiBOV/y1gjm5BVVZGx
         iRYW17SNO1Ix80tPCOg0SV8RWYGGrvjRWBtGyd1qR1lVKU+KYIgr55fSs8WSk6U4SDZN
         4PXg==
X-Gm-Message-State: AOJu0YyvktZp3do+kN73CJMyGdYplB+D+Ph/TUP97fKUwoGpUNEX+xli
	FcHpVNYIdPHCzLYUHzaEDkdqH7pYp9vgbYVpAAuJQg==
X-Google-Smtp-Source: AGHT+IHiJ130GPEb52KAhAjJIFfkh8yV8E4SUQGV/ZuHP0LWHovK6rTAfw9a55ew8eXpz1wiyxHe+g==
X-Received: by 2002:a05:6a00:148c:b0:68e:2c3a:8775 with SMTP id v12-20020a056a00148c00b0068e2c3a8775mr8914264pfu.33.1695049595282;
        Mon, 18 Sep 2023 08:06:35 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0068fe9f23bf4sm7251922pfo.103.2023.09.18.08.06.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:06:35 -0700 (PDT)
Date: Mon, 18 Sep 2023 08:06:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 217922] New: FEC driver not working for imx7dea-com board
 from kernel 6.1 or later
Message-ID: <20230918080633.02d5ed06@hermes.local>
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



Begin forwarded message:

Date: Mon, 18 Sep 2023 11:51:45 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 217922] New: FEC driver not working for imx7dea-com board from kernel 6.1 or later


https://bugzilla.kernel.org/show_bug.cgi?id=217922

            Bug ID: 217922
           Summary: FEC driver not working for imx7dea-com board from
                    kernel 6.1 or later
           Product: Networking
           Version: 2.5
          Hardware: ARM
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: m-seo@ukr.net
        Regression: No

Fast ethernet controller driver (fec) for imx7d cpu not working in kernel 6.1
or later.
Boot kernel error is:
[    1.860925] fec: probe of 30be0000.ethernet failed with error -12.

Kernel version from github:
https://github.com/embeddedartists/linux-imx/tree/ea_6.1.y

start driver succsessfully:

[    1.401249] fec 30be0000.ethernet eth0: registered PHC device 0

but have other problems to boot system.


Driver sources from embeddedartists repository compiled succsessfully with
small adjust of header files on kernel version 6.5.3. But fec driver failed
with error -12 too.

DTB file working successfully on kernel 5.15 and not changed now for kernel 6.1
- 6.5.

Where is mistake, who is use imx7d cpu with 6.1-6.5 kernel sucsessfully?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

