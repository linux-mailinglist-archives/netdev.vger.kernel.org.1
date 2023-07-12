Return-Path: <netdev+bounces-17090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B379E750385
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09B51C20F49
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0E1F958;
	Wed, 12 Jul 2023 09:47:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17294433
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:47:14 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4764AB0
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 02:47:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so8284641a12.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689155231; x=1691747231;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9xoV9OSsDzeAGBHAsjc/WkWlPTtUKCm7g6vupM4Sfk=;
        b=dbvSSV79144Xj4t/Ev6ulB2208F/WG5SbNt8TVEV8JuyW5jPmuG+hX+cwEOLgkyweX
         i5DwqIXMkRAtQBXiSujj2YTdrxKuuHC/ndfd8EXh+8oqA3Z2qKyZ/+aZ+K7UlyZn7TdM
         OD7vwq2DuC8MNThqh/HImUc+mXUa1EMKAlBWOjiHogsp/2Cl2IOBYcKZ3joJ1R327EfS
         FlNAqRCCXM0LVmE/V1Ab7lrPE/mPkhJL22VFLZFbti+QudYSKIVdfSuTwc6/00mk92me
         RMZE3g+wonZvVbDgUgZhK1diVO1NMfkwNIhQWKtT8+U6knEKKmm0sojfKmNCalVW+PGp
         qaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689155231; x=1691747231;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D9xoV9OSsDzeAGBHAsjc/WkWlPTtUKCm7g6vupM4Sfk=;
        b=RX4GrWtbvfFRd5heL7FSTR8oiiFnIHBYX+NsQKMB3vOqM/IZ9dCfynYCJOYvx7IDIJ
         gMknpFvQEgnlAfm2/nr2SjZ0caNZBTbUsyucMNG47vrPevaDuWume3DOkVlXpj676I97
         araLII/TTuhPYBKknVZwNjyDks3J9BwyGspoXyWLhVXTFw0buT5m52E6eSCBV4AUDpZk
         PqwfgbwMDySf/wG8RgI8n0WytufEW4p1QyQiBCGyb4/VWyWKnXDeQ4c3E8xR1k8cNtMB
         A1CFs3QeQRqC51MSZeBl460/iA+puyHZ52ZPj42XJ283socIywNjliwT027FL1RoN5DF
         Am1w==
X-Gm-Message-State: ABy/qLb2dt3b0o9LqNkIhARxt9wWm1A1CUrEOUgQ16KVIhnVKSQ8zFpl
	E1CciYqPnkGdJKM6xEaNWrHzaDCiODloxPKL9pYfVQ==
X-Google-Smtp-Source: APBJJlHynQouQei8wAh6Z81oCVycM4afm0fiJvGuTeNiTTesD4RpwSfcG9YwiibW0PnOqYh8kixCzw==
X-Received: by 2002:a05:6402:350:b0:51a:265a:8fca with SMTP id r16-20020a056402035000b0051a265a8fcamr20076101edw.27.1689155230657;
        Wed, 12 Jul 2023 02:47:10 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e63d:32df:2bec:83e9? ([2a02:578:8593:1200:e63d:32df:2bec:83e9])
        by smtp.gmail.com with ESMTPSA id bm24-20020a0564020b1800b0051e069ebee3sm2475137edb.14.2023.07.12.02.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 02:47:10 -0700 (PDT)
Message-ID: <0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net>
Date: Wed, 12 Jul 2023 11:47:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-GB
To: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev <netdev@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: TC: selftests: current timeout (45s) is too low
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jamal, Cong, Jiri,

When looking for something else [1] in LKFT reports [2], I noticed that
the TC selftest ended with a timeout error:

  not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds

The timeout has been introduced 3 years ago:

  852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout
per test")

Recently, a new option has been introduced to override the value when
executing the code:

  f6a01213e3f8 ("selftests: allow runners to override the timeout")

But I guess it is still better to set a higher default value for TC
tests. This is easy to fix by simply adding "timeout=<seconds>" in a
"settings" file in 'tc-testing' directory, e.g.

  echo timeout=1200 > tools/testing/selftests/tc-testing/settings

I'm sending this email instead of a patch because I don't know which
value makes sense. I guess you know how long the tests can take in a
(very) slow environment and you might want to avoid this timeout error.

I also noticed most of the tests were skipped [2], probably because
something is missing in the test environment? Do not hesitate to contact
the lkft team [3], that's certainly easy to fix and it would increase
the TC test coverage when they are validating all the different kernel
versions :)

Cheers,
Matt

[1] The impact of https://github.com/Linaro/test-definitions/pull/446
[2]
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log
[3] lkft@linaro.org
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

