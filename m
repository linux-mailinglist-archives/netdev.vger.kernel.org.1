Return-Path: <netdev+bounces-15249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20D77465AC
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 00:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CE21C20A8B
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 22:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFB6134B1;
	Mon,  3 Jul 2023 22:13:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE914A83
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 22:13:18 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E4C1A1
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:13:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8062c1ee1so39348765ad.3
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 15:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1688422396; x=1691014396;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9Tv/Y65GMJE0GdxeJTGoA8/kAlo0+SgJo5p2FNW6eU=;
        b=TQKOnKppR65UpQxvhbka5GIa4avt1NDM83bARuCrxugNEWAbGVPufUs9dDd+ZAP8mA
         S4ZoGsYAfCK8N7mhYXIO8K5q4//KbKveTSL1pk8JG+AbR4NHND48AtTO+B0HvbuHtyqV
         LnqmNOPbtzW4QF2XaRQUZ9omx/LC/qNwUs7oh7EUNcPRZnizczsstkfXXN1iBMDVVhsG
         1f2wvntKt6c7CoprqeaSPyOuJtNWoPjNbk9Qs6ySpWO/xTRp1lmoYEysRRQ8+SH9H+LU
         jhpmWFohktfQH6o7muKaR0rH4FT4XnUZUiDjjsRXfXszulqWg6FJmLy3Gq/HRLohrcxh
         bDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688422396; x=1691014396;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9Tv/Y65GMJE0GdxeJTGoA8/kAlo0+SgJo5p2FNW6eU=;
        b=F/YbU3mWTLc4Sbg31iJyHuVGXXDmdukf/jvgdiOlBCAEWvgDyR8BCBIoDRn47XezW/
         jYzH1cFcJWybBJBYMLl2DDBUTPehqnse+pHis0FLqzxlBCT5+CxRp522uKZCV6nEWU6V
         sbl9LOl51e+9mE3+WooZPtB3DOhoikc+DOGCHLf7/WozTHMIepAv+TqrCXoe2fOIb/Ha
         AmHisP1AHgI8tkH/ZBLAQvSPMh+0ulRmKkxZqeDHEbOeMpkEgw7WQYDuoYhWQll9sL17
         iXrBecsXG6aunSDk0MuX/UWtqkU1RuFe1AcvXGuCNROUN1HJrvtGd9pWnmgSlCjJH8QC
         Z0ig==
X-Gm-Message-State: ABy/qLbk9xsGBS/Cl1iNqfk3LJ2L5BySB9ElOfulmK1B34lgceWXXEtq
	yJzrHyrxYhUUQsJAdqRV+oXsJs5+UwO1sWGVrWk=
X-Google-Smtp-Source: APBJJlHyxdu5H18VZtKeG4BO7b5Od6WNJYjVB0cp8zzAo9wC9o6xTGcsFzWNqeWQyDCqKjrZzP43iw==
X-Received: by 2002:a17:903:2441:b0:1b7:f24c:3b9a with SMTP id l1-20020a170903244100b001b7f24c3b9amr13856819pls.47.1688422396285;
        Mon, 03 Jul 2023 15:13:16 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id i1-20020a1709026ac100b001b6a27dff99sm15691867plt.159.2023.07.03.15.13.15
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 15:13:16 -0700 (PDT)
Date: Mon, 3 Jul 2023 15:13:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 217629] New: [regression] Wake-on-LAN broken in new kernel
 for E2400 Ethernet Controller with Qualcomm Atheros
Message-ID: <20230703151314.1b2a21a6@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Begin forwarded message:

Date: Mon, 03 Jul 2023 15:40:58 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 217629] New: [regression] Wake-on-LAN broken in new kernel for E2400 Ethernet Controller with Qualcomm Atheros


https://bugzilla.kernel.org/show_bug.cgi?id=217629

            Bug ID: 217629
           Summary: [regression] Wake-on-LAN broken in new kernel for
                    E2400 Ethernet Controller with Qualcomm Atheros
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: myrbourfake@gmail.com
        Regression: No

I recently upgraded my pc to linux mint 21.1 (ubuntu 22.04) with kernel
5.15.0.75 and I realized that wake on lan functionality is not working any
more. Up to Linux Mint 20.3 it was always working perfectly!
I have a Killer E2400 Gigabit Ethernet Controller with Qualcomm Atheros
AR816x/AR817x chipset.

As this functionality is very important for my job I'm filing here a bug with
the hope things to return back to normal.
There is this bug from 2013 https://bugzilla.kernel.org/show_bug.cgi?id=61651
which looks like dead thread, that's why I decided to open a new one.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

