Return-Path: <netdev+bounces-52867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E826F8007F3
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E4E2809D6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82451C6A9;
	Fri,  1 Dec 2023 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MyxwMCa+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE75170F
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 02:10:48 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9b5c12898so23975901fa.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701425446; x=1702030246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n8E0QyaHO2zChIxVOU0YYWJPMrzFVG6nS9T0+zfhmyg=;
        b=MyxwMCa+LQg+Chnv+l/sUiHgtt0sArwJ1k5N2HZQNt8TTzlV5FC8y7szKbkstOBRzw
         j2DNAqo8dj6j2Xbs22sZdoebIC0hZci3kTpCi3VzcApzb12x/J7YVXjYeKPHlGn6hfsk
         Vq05MfyAu/f+Cx56+SU7n2QPy7BneaqxvnDC4seLD+isN6bR2aqcIpnPROBOmOQgHxXN
         RJhMhNb4VsXDIdvYP80CLxeDQYeYxrWx5MWSKLm35ZjMTxRocEKvPyOFnhh1lo0DWY4R
         RsEj4PZFMOYKLiRwpN49GzjhmSjG9pjCc8auyb6McZygbzfUcjEwmtwfkPEEVCO8xc8D
         SbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701425446; x=1702030246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8E0QyaHO2zChIxVOU0YYWJPMrzFVG6nS9T0+zfhmyg=;
        b=C/E9ezQCohjAylMAlbhCo/lWqehqvybjABQlgQ+K6WrxowVO/XPm3supcMvNmPmgZH
         oZ47aUzmduVyirImfTk7FU9VxU6juMLpZoCIS2eTO1x3VSOx00iF6zy7JIcZMpwjdZSm
         lClqe9uVqpAYOMAPB3E3m2jlDgGHULx1QixjSc26VWBXhLaTMdnRr/UW+kkFg04TJwjO
         su0eG3fNtLPoSDR5b/cZ0vNCAtzCI7/6klEXNZcbaQJ6NuTLJzU8UZ0mDtXr7naLl4Q3
         7lehHWJNfjW/IJydDAtX5oNY3VY4qbWzyLbuTIWiXb7+mDmSgJYRs5vwHkdvzB/gVM6m
         PRKA==
X-Gm-Message-State: AOJu0YziCVPz/qj+jd8IUlEUssfxwGi3h5RrODrPbVsQmgJleYRCelGE
	v5kJEAs8Ssm0p68zGPdFXbbs6Pu7bof7kBDeYYuWXA==
X-Google-Smtp-Source: AGHT+IEjiIKL1J883D5OEhe5x4clQxaJAlHkMh9GOJjhv1wGD6i0tPElWfosSDTJz8xNMDxIfxZ61sqNJrax1MKZWwQ=
X-Received: by 2002:a2e:8803:0:b0:2c9:d874:6edc with SMTP id
 x3-20020a2e8803000000b002c9d8746edcmr745747ljh.57.1701425446677; Fri, 01 Dec
 2023 02:10:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130115611.6632-1-liangchen.linux@gmail.com>
 <20231130115611.6632-2-liangchen.linux@gmail.com> <CAC_iWjL68n-GRN7vs_jwvzbnVy8sPh4_SP=wVDq0HkFOmSU-nQ@mail.gmail.com>
In-Reply-To: <CAC_iWjL68n-GRN7vs_jwvzbnVy8sPh4_SP=wVDq0HkFOmSU-nQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Dec 2023 12:10:10 +0200
Message-ID: <CAC_iWjKBE5s9iiTPKgsoDx5LSWjsSXE-7SSPSk+EVJXLC10-GQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/4] page_pool: Rename pp_frag_count to pp_ref_count
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"

re-sending as plain-text, apologize for the noise...

On Fri, 1 Dec 2023 at 11:59, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Liang,
>
> On Thu, 30 Nov 2023 at 13:59, Liang Chen <liangchen.linux@gmail.com> wrote:
>>
>> To support multiple users referencing the same fragment, pp_frag_count is
>> renamed to pp_ref_count to better reflect its actual meaning based on the
>> suggestion from [1].

The patch does more than what the description says and those should be
in 2 different patches.
I am ok with pp_frag_count -> pp_ref_count, for the functions I am not
sure the rename makes anything better.

Jakub, are you ok with the name changes or is it going to make bisecting a pain?

Thanks
/Ilias

