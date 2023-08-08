Return-Path: <netdev+bounces-25432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A6C773F2C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32C91C20F46
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1140414AB8;
	Tue,  8 Aug 2023 16:41:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063461B7F9
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:41:54 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C77AFF631
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:41:38 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99c1c66876aso816979766b.2
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1691512570; x=1692117370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bw2MRgpkFm1vILiE0Y5MYyZNNxscMVN+eqSvqqHwK4=;
        b=EePW+ss015g11YgFFHMy90Z5WBj/PCKy6a/lhF3ExOntSwvl8wOFfJQ1JbeQoQrrOx
         xGv9mUGakIoi++O8fmZPptc9lYFC2bKDg9uXW/+1Mxi9bbiHs3cBrG5MKCqPjOigSNk/
         6O3T2Scei8koWcY2M/Eaj3ZH5HH0kvS2OwUipqKRF44XHNPvdm7NRKse4GbRIsRU3CNw
         MHRQ4gStC0CIZh/3TmsijzYoIO2grgcREPRoC80135uNlMXE9RheTTzhehwkkqfMOILw
         IG+BZkUNI0ZVxYlQC6LMviOYgjd4hQSn16di8r9dqB6kv/iUsDpTXsLNS+LLy0b/jFrX
         XBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512570; x=1692117370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bw2MRgpkFm1vILiE0Y5MYyZNNxscMVN+eqSvqqHwK4=;
        b=jhpL6pFUQzNzToYF+xDNbchRM2ORnN8pHxGdV7lniaBUCeigRjPjG5E68qtvCzo84X
         tqE9zOBjRIYqcz0IQSfJoCzq54ZUXAdmt5oU4yy/No/q788CJdfXKAN8WY4n25sVo+xu
         WnGHGpqn6ib32kT9IRg39a0+ReGA7LzJlqj+Or2MUplfv6ejBDgO5kb31p6jcfZ5M3i0
         uMHWd2W9far9KwZYAWJ/Pjlnc7ZQzDMmXqi3wVjMfjh1pu1dBC9B7ozyzICo6ePFq56j
         Jg9NOyA5yNiHbaU3d17lhuoiUXlCYbaf28+qQzUBGlXVXRpHDmjKlCAXH0X7CiWVNSU3
         oCsA==
X-Gm-Message-State: AOJu0Yx4UwdWKKpuqQ2JJK2CMlp4JxCHb2penESCL8SHmU6QqBjM3ThP
	9Lu9HBwW5S8EvMWsi/WXyZxG/+y36cHluXb+Jfa4Jg==
X-Google-Smtp-Source: AGHT+IGyc5YFMEUdUm3mgxMUbhzIYZxUjCAeYEgPYwAXs5W80a27H3BIhOB0Da8QtwlqT/aZI8FmyxUNTteHqh8I214=
X-Received: by 2002:a17:906:217:b0:98d:4000:1bf9 with SMTP id
 23-20020a170906021700b0098d40001bf9mr85402ejd.65.1691512570147; Tue, 08 Aug
 2023 09:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
 <20230720-so-reuseport-v6-7-7021b683cdae@isovalent.com> <CAP01T76fZhrELGxsm5-u85AL5994mS0NGZd6gw-RYaHE8vKfTA@mail.gmail.com>
In-Reply-To: <CAP01T76fZhrELGxsm5-u85AL5994mS0NGZd6gw-RYaHE8vKfTA@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 8 Aug 2023 17:35:59 +0100
Message-ID: <CAN+4W8j7Lyh4Zm1neabe2f+DJWbP4zRrATM4rwD3=EBS0s1CjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/8] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Joe Stringer <joe@wand.net.nz>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Joe Stringer <joe@cilium.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 5:23=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Hi Lorenz, Kuniyuki, Martin,
>
> I am getting a KASAN (inline mode) splat on bpf-next when I run
> ./test_progs -t btf_skc_cls_ingress, and I bisected it to this commit:
> 9c02bec95954 ("bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign"=
)

Thanks for the report. I forgot about struct request_sock again...
I'll have a fix shortly, I hope.

Lorenz

