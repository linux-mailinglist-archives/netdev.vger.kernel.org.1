Return-Path: <netdev+bounces-51361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AD27FA525
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C201F2094E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A6334574;
	Mon, 27 Nov 2023 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wQxhADxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C04BE
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:49:01 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cc66213a34so43762557b3.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701100141; x=1701704941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OZ/zaPHTOHquaBYH+lbkY1d97Oatm6ySFdaXiL8Dhc=;
        b=wQxhADxJ3YePrynaIdGX6XyhjcqrN5oAYHmr0uiWS18I1PmgQXT/oMzrQIJYIqKkd4
         4M76Oh1Bsn5n9a71RJzdsQcDUE6dLYQtJS5NZuYgit/q6zR6GDHKkF3F3evJ/+tc1Bo8
         5bduubZaE2q2IFMsQbzElbeb3iKv+1xbIqZi1Leobv/x//EP1ksADJfgohudy47E8XHj
         bRsDIb6ha16k3gRjBz/jpEIEMQhCIqU/L3jDZAZOPLQBhWUXI+hV6xMvedO7Njq3nY1j
         QK1t4a6Is06m1uI0EUcPdrQss5Mp7BsBk/tPCdlFeFArMXdi3mNYLV7Yi3nGWzBeajWm
         kIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701100141; x=1701704941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OZ/zaPHTOHquaBYH+lbkY1d97Oatm6ySFdaXiL8Dhc=;
        b=LDLW5umDkuz1CP4qbBrZuSd8CE0BYuxBmgVdMyORcWcZCEGq+WStWdagsThy6pE8o0
         7VrBqxEkiFXBSKYt5aUfWKvS4f8Rz3m5HV1mWznwYf0czIWekm/3NZF/xshwGUAxH9Va
         xWjSOA0HGsbaVq2YqBKk0asOEHdcVwgT0IJ8b/9c2RyqHnnNXk55rxYiOYkJzNaVycb5
         9ZVCjFtn4Ihnh8IzI56f3DoL3gI6si7pVK2qYdx0NMalF4idnVzg8CaAjBDw0DBjFgDF
         MdwwjJcY4iwrAygW+NG4+uQ9wpEldbjQT00L/hPHRg/Gwh4U/7+S4+ks8xSbH/AocLi/
         BQxg==
X-Gm-Message-State: AOJu0YxgpwQJ0YNkX5UJrhKmS0tB5fKxZXCA31o8CxvBBpKwCHJo+m3o
	/snGnLIdEtEo8Uh+57kmt2/aqa2shVmUuwTr0uU2ww==
X-Google-Smtp-Source: AGHT+IFlXI+XiNqcLAO9Li2OL/ymYfkxPzPfv7uyjeBxX3DjN83glydtRLaPL6pFsqlmWBZulq3Mf1wcsj0hqhBji2o=
X-Received: by 2002:a81:5c05:0:b0:5ce:4dfb:bce8 with SMTP id
 q5-20020a815c05000000b005ce4dfbbce8mr11984339ywb.7.1701100140920; Mon, 27 Nov
 2023 07:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124154248.315470-1-pctammela@mojatatu.com>
In-Reply-To: <20231124154248.315470-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 27 Nov 2023 10:48:49 -0500
Message-ID: <CAM0EoMmcPw85tQCMkg6XiMA2B3b8bkLS2TVCvxC_jrwVcdNJVw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] selftests: tc-testing: updates and cleanups
 for tdc
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 10:43=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.=
com> wrote:
>
> Address the recommendations from the previous series and cleanup some
> leftovers.
>
> Pedro Tammela (5):
>   selftests: tc-testing: remove buildebpf plugin
>   selftests: tc-testing: remove unnecessary time.sleep
>   selftests: tc-testing: prefix iproute2 functions with "ipr2"
>   selftests: tc-testing: cleanup on Ctrl-C
>   selftests: tc-testing: remove unused import
>
>  tools/testing/selftests/tc-testing/Makefile   |  29 +-------
>  tools/testing/selftests/tc-testing/README     |   2 -
>  .../testing/selftests/tc-testing/action-ebpf  | Bin 0 -> 856 bytes
>  .../tc-testing/plugin-lib/buildebpfPlugin.py  |  67 ------------------
>  .../tc-testing/plugin-lib/nsPlugin.py         |  20 +++---
>  .../tc-testing/tc-tests/actions/bpf.json      |  14 ++--
>  .../tc-testing/tc-tests/filters/bpf.json      |  10 ++-
>  tools/testing/selftests/tc-testing/tdc.py     |  11 ++-
>  tools/testing/selftests/tc-testing/tdc.sh     |   2 +-
>  9 files changed, 25 insertions(+), 130 deletions(-)
>  create mode 100644 tools/testing/selftests/tc-testing/action-ebpf
>  delete mode 100644 tools/testing/selftests/tc-testing/plugin-lib/buildeb=
pfPlugin.py

For the patch series:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> --
> 2.40.1
>

