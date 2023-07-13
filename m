Return-Path: <netdev+bounces-17723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA5F752D1F
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 00:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A5B1C21482
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 22:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3265694;
	Thu, 13 Jul 2023 22:42:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA215663
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 22:42:06 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554F62D47
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:42:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3143b88faebso1451720f8f.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689288122; x=1691880122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66oQixs0sOJ03BwYJKzyLzAVjZdZk6ZVHTMW5daqX2M=;
        b=pvGmhS9tWsWAM4bX9LyGRkltvlh95F2keTxYpyOzqrZQSSRVGFsmdACMTTkURT9/8s
         T/JFpxOyD8hHDVq6zJTkViDAYqenypzqNib59lk1mXnhNfyXr8yl1Qf43depQE/6ooqg
         1L6wp1ugWbqkPPSXZuoJY3ypLWl4IGbTN69zKoa/r0vi2vfCCfFpyEGRcJgJEZgNOJcD
         ax+sD+d6GVw6uqHc3EJsFiUkENauJh8DKPIEw5QX/BB7OZG41UG1mMEvh/XDLnbFu4bL
         tR06rXRvJgWhUbBacZHWXzCTZ7bYaUdkl77V/Xgbd/AyPUbh1AM7sA6ttphssF8+c6Iv
         YrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689288122; x=1691880122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66oQixs0sOJ03BwYJKzyLzAVjZdZk6ZVHTMW5daqX2M=;
        b=I6WcInT6vcU7oymjzkzvOa0c8w6oVBLUtD/kBU/Ib6JWpH9mYaJTi0JXxs03H5Hy1B
         1umardORCt+GW6mZE1Sw15rSVG1a94bpHs3xpN8KsHIZzraecyfoDEv1ZBDv0NcanwAk
         uwZAv4lx7nTigTw8MAK5lJlZ8og+HjL5MXQNZgxK7lbvmsMPA9mLSrRQhJ37fD7gDfMl
         YWQj6tS/5CJIPzDFDikL11qy0eCWUP1iiF6CqKkc12G/df+dtnOKNTAskW/DO9sF3dal
         nGfqndbjnCkguE1w4cgBt2S2L4JszaC5hLftX1GAEFZZ9uWcJsW3PfGNBZIDtyedC01x
         Xv+w==
X-Gm-Message-State: ABy/qLZKuVjuLj5tNFzb3lpFgl6o8duB4RX0vM1BWYZhYBLuZFkJuisu
	jTqqFt+5kvPqQMe7wfqddCPx59T1zaT4AcPkhzpvwg==
X-Google-Smtp-Source: APBJJlFs/7oapWO3mK2wFO6rXB5Ht1CL2A/vfl4PqJ1XLNNooCppcH0pS9lrQ/MK/bOgbwvx7Jl7P1HVYapHEvwGkl0=
X-Received: by 2002:adf:de0e:0:b0:313:f18d:1f2c with SMTP id
 b14-20020adfde0e000000b00313f18d1f2cmr2556330wrm.38.1689288121758; Thu, 13
 Jul 2023 15:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
In-Reply-To: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 13 Jul 2023 18:41:50 -0400
Message-ID: <CAM0EoMk4ZE6WZYCc_YkraGT5+CUbr7J9J6UEdH3=KLQ7akOYMw@mail.gmail.com>
Subject: Re: [PATCH net 0/3] selftests: tc: increase timeout and add missing kconfig
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"David S. Miller" <davem@davemloft.net>, Paul Blakey <paulb@mellanox.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, mptcp@lists.linux.dev, 
	Pedro Tammela <pctammela@mojatatu.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 5:17=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> When looking for something else in LKFT reports [1], I noticed that the
> TC selftest ended with a timeout error:
>
>   not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
>
> I also noticed most of the tests were skipped because the "teardown
> stage" did not complete successfully. It was due to missing kconfig.
>
> These patches fix these two errors plus an extra one because this
> selftest reads info from "/proc/net/nf_conntrack". Thank you Pedro for
> having helped me fixing these issues [2].
>
> Link: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202=
30711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/lo=
g [1]
> Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7=
@tessares.net/T/ [2]
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

For the patchset:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Thanks for all the effort Matthieu!

cheers,
jamal
> ---
> Matthieu Baerts (3):
>       selftests: tc: set timeout to 15 minutes
>       selftests: tc: add 'ct' action kconfig dep
>       selftests: tc: add ConnTrack procfs kconfig
>
>  tools/testing/selftests/tc-testing/config   | 2 ++
>  tools/testing/selftests/tc-testing/settings | 1 +
>  2 files changed, 3 insertions(+)
> ---
> base-commit: 9d23aac8a85f69239e585c8656c6fdb21be65695
> change-id: 20230713-tc-selftests-lkft-363e4590f105
>
> Best regards,
> --
> Matthieu Baerts <matthieu.baerts@tessares.net>
>

