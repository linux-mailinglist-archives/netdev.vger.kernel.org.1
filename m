Return-Path: <netdev+bounces-20850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C23976193D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974091C20E45
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090081F170;
	Tue, 25 Jul 2023 13:05:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB61F16C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:05:51 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29570E4F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:05:50 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so4716322276.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690290349; x=1690895149;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5tJzMlchMGvZ+T9JwV3tPym5EeZdFxlI9guvrrUmmhk=;
        b=jCFQ6Y4bYcEDzy/p6qgLw90rtdZ3Hh30FW2hjrlxQUImuaJ3Y26BClVajbvGVC5aEu
         em4SfOLA8oRLm9cAhXGV13PZnVwZB/Xzk9vBfyG6BiKsLPemx0S5PGa9jEqhJ5lLEpKZ
         Bgkqc0rAYTVXrwV+KOFqM7TqNWZMoT+hkq5y2eChtoxpwGFnwF0h74dfVzzfrM74Alvx
         zNqS+aVvR2eJsv85h8Y1S6sJWlYDfkyONrzU7R2OHOTaFrdp62n5a8gO5h27PuDDm8x6
         BXytROdQsd1QkhdtMEkePC2HhqZmmrWm+VALKrIRGZpg8iyHWxKMVyRuskWl6jU4geS4
         gaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690290349; x=1690895149;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tJzMlchMGvZ+T9JwV3tPym5EeZdFxlI9guvrrUmmhk=;
        b=UWk/uXxcdFRB/pP7KcflRcnV+JZ73Ez6PIn8veLjQGmNFJ6TEJVWPL/sE87edPwabk
         mThTtGhKjN1cAwZ37BopWwO33Txls786Pu81SDLk75SeoQRdFiYtx2dfT3i08dS7r/Kv
         ZkOtdFpjNc2hiriROxujfeqFfpmAgfXnPoygRdZqTgmUzNqekyA+lMxmwrHmfsUAbujQ
         PzxrDwMy49/7leX57SexJf7FEAkJl+fLUbUA+l92Gd1ctWaxsK48O1pv2izgaYJzTsSZ
         F0Rr0ExN+DRqHPequaDZlMOD31LP8CfL7htm8GF/qj60o9de0e26YEknAV09+NrmO2PK
         MquA==
X-Gm-Message-State: ABy/qLZRrEF8SWZwgPHtl/fKzrMbPLigCnTp65X3L70XFoFdbE9+IoGs
	6pn4qbcK8CRIRYV90LpE8i9mWiEp2J2gzVXzRGUEOw==
X-Google-Smtp-Source: APBJJlHP4Y3P++g+2unMwlOMB60A5WtMws0pr+cPcYoFFKwMaorlYfI3QPWuUf7oTXPSwxNZn3JVr03TK2rithbw4j8=
X-Received: by 2002:a25:7489:0:b0:d10:493:f6e7 with SMTP id
 p131-20020a257489000000b00d100493f6e7mr5172136ybc.24.1690290349182; Tue, 25
 Jul 2023 06:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Jul 2023 18:35:34 +0530
Message-ID: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
Subject: selftests: connector: proc_filter.c:48:20: error: invalid application
 of 'sizeof' to an incomplete type 'struct proc_input'
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Netdev <netdev@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
Cc: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>, Shuah Khan <shuah@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

selftests: connector: proc_filter build failed with clang-16 due to below
warnings / errors on Linux next-20230725.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

clang --target=aarch64-linux-gnu -fintegrated-as
-Werror=unknown-warning-option -Werror=ignored-optimization-argument
-Werror=option-ignored -Werror=unused-command-line-argument
--target=aarch64-linux-gnu -fintegrated-as -Wall     proc_filter.c  -o
/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/connector/proc_filter
proc_filter.c:42:12: error: invalid application of 'sizeof' to an
incomplete type 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^~~~~~~~~~~~~~~
proc_filter.c:22:5: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                         ^     ~~~~~~~~~~~~~~~~~~~
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:48:20: error: invalid application of 'sizeof' to an
incomplete type 'struct proc_input'
                hdr->nlmsg_len = NL_MESSAGE_SIZE;
                                 ^~~~~~~~~~~~~~~
proc_filter.c:22:5: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                         ^     ~~~~~~~~~~~~~~~~~~~
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:64:14: error: invalid application of 'sizeof' to an
incomplete type 'struct proc_input'
                msg->len = sizeof(struct proc_input);
                           ^     ~~~~~~~~~~~~~~~~~~~
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:65:35: error: incomplete definition of type 'struct proc_input'
                ((struct proc_input *)msg->data)->mcast_op =
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:66:31: error: incomplete definition of type 'struct proc_input'
                        ((struct proc_input *)pinp)->mcast_op;
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:67:35: error: incomplete definition of type 'struct proc_input'
                ((struct proc_input *)msg->data)->event_type =
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:68:31: error: incomplete definition of type 'struct proc_input'
                        ((struct proc_input *)pinp)->event_type;
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
        char buff[NL_MESSAGE_SIZE];
                  ^
proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
                         sizeof(struct proc_input))
                                       ^
proc_filter.c:245:20: error: variable has incomplete type 'struct proc_input'
        struct proc_input input;
                          ^
proc_filter.c:245:9: note: forward declaration of 'struct proc_input'
        struct proc_input input;
               ^
proc_filter.c:264:22: error: use of undeclared identifier
'PROC_EVENT_NONZERO_EXIT'
                input.event_type = PROC_EVENT_NONZERO_EXIT;
                                   ^
9 errors generated.
make[4]: Leaving directory '/builds/linux/tools/testing/selftests/connector'



Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676HpK243gMBLYJCp4OXDmWl/

steps to reproduce:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676HpK243gMBLYJCp4OXDmWl/tuxmake_reproducer.sh
--
Linaro LKFT
https://lkft.linaro.org

