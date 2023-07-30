Return-Path: <netdev+bounces-22589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D4D76843F
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 09:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31CF1C20A70
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F907A34;
	Sun, 30 Jul 2023 07:44:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744B4810
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 07:44:47 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4551BD4
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 00:44:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso32801495e9.1
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690703084; x=1691307884;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVo3CfAiIbWB71Aa1pCPCFeo34GyO2aM4zhYiffV+Ms=;
        b=54F3mc9lenPK1PumBnXc7qs5+G4KfmHN9WNbGeZTERPfIjsvRE0sH/oCAEcLT/x7+M
         30IMaVtm5R6tX/Zyy+QEiq3BoZLSPkqLi2Hzo95F5ToambRYGK0LCxNJUeGXsTjtubZx
         ZRnwGGxaW3qZFcfO3CEV3xIekblVPQyUey0PiawhWHz/EvR3zd650pUTU+OtQ7WMKnFp
         nMRlwR8sZXxa1h7XUiPrt8bqRMRgFiKmd6rxG+y45h6X9taHkYlL6bCLQUpbzwX/p0In
         0++6EbeErEmI1VFE5W/ZnINP+U8j4euj74ngEJWxFXoGx26gKJcj+zJVGvESKjH7xHI2
         92gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690703084; x=1691307884;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CVo3CfAiIbWB71Aa1pCPCFeo34GyO2aM4zhYiffV+Ms=;
        b=GFRaoAgUGCLNmRaVTxpvn/u3i6VBXU17bj8gzIPQnNB0Qqs5QwCGqjMnGPjCxevxp2
         s3M3GSFVUOjHibXpDaZl/yNCJ6n8NnXdTavJG7BdVSsLdXIvAhjVViMIhTHryD8em4rL
         09Qmud7aNbozv7EEu3dmHfgJNeRpmRaKqF8fQm/haIIfexJuUV2seCoOvWZ0XTRaa+tX
         medsoGKOrxzqG3Xz62ubObAM0tnx9JMAvX2WC3zWJDJuza6ao4SeeXIDTL4AcBpYovQh
         YuKL8DWN7ia2m5o0YT/yKFYX8aciWlloxpUO9jQcfu2iSr6C7GozHICjggKemGtn39Sh
         t71g==
X-Gm-Message-State: ABy/qLbfrIiJkh0w7chUQG41pED6DGNaa00M6hfH9MlTA4VbyoV8dXXE
	u8OL3zx2eatrXkuZkvFXgnfkEg==
X-Google-Smtp-Source: APBJJlGVnh0dt8CdW4cH8aiNqSYqTvvflLJc+P6IYRN5jWzLA7Ys9gdhEmdrhRI3dC71ag73R4NBjA==
X-Received: by 2002:a7b:c34d:0:b0:3fb:be7c:d58a with SMTP id l13-20020a7bc34d000000b003fbbe7cd58amr4121302wmj.26.1690703084098;
        Sun, 30 Jul 2023 00:44:44 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ff63:f08b:38ba:2ce1? ([2a02:578:8593:1200:ff63:f08b:38ba:2ce1])
        by smtp.gmail.com with ESMTPSA id g22-20020a7bc4d6000000b003fe1cdbc33dsm1311812wmk.9.2023.07.30.00.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 00:44:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------zwp0fCzMyu0iFZNErjcJV0YJ"
Message-ID: <c2cd0101-85b5-39fc-801f-8a3eb0f8a0cb@tessares.net>
Date: Sun, 30 Jul 2023 09:44:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net 08/11] net: annotate data-races around sk->sk_mark -
 manual merge
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230728150318.2055273-1-edumazet@google.com>
 <20230728150318.2055273-9-edumazet@google.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230728150318.2055273-9-edumazet@google.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a multi-part message in MIME format.
--------------zwp0fCzMyu0iFZNErjcJV0YJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 28/07/2023 17:03, Eric Dumazet wrote:
> sk->sk_mark is often read while another thread could change the value.
> 
> Fixes: 4a19ec5800fc ("[NET]: Introducing socket mark socket option.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  3c5b4d69c358 ("net: annotate data-races around sk->sk_mark")

and this one from 'net-next':

  b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting
multi-buffer in Tx path")

Regarding this conflict, this is a trivial context-based one: I simply
took the modifications from the two versions.

Rerere cache is available in [2].

Cheers,
Matt

[1] https://github.com/multipath-tcp/mptcp_net-next/commit/083975145b2e
[2] https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/0616
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--------------zwp0fCzMyu0iFZNErjcJV0YJ
Content-Type: text/x-patch; charset=UTF-8;
 name="083975145b2e4fcb837c9c0d694b8967bfa91271.patch"
Content-Disposition: attachment;
 filename="083975145b2e4fcb837c9c0d694b8967bfa91271.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIG5ldC94ZHAveHNrLmMKaW5kZXggNGYxZTA1OTkxNDZlLGI4OWFkYjUyYTk3
Ny4uZDRjY2ZmY2FiOTgyCi0tLSBhL25ldC94ZHAveHNrLmMKKysrIGIvbmV0L3hkcC94c2su
YwpAQEAgLTY4MiwyMiAtNTA1LDExICs2ODIsMjIgQEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVm
ZiAqeHNrX2J1aWxkX3NrYihzdAogIAogIAlza2ItPmRldiA9IGRldjsKICAJc2tiLT5wcmlv
cml0eSA9IHhzLT5zay5za19wcmlvcml0eTsKLSAJc2tiLT5tYXJrID0geHMtPnNrLnNrX21h
cms7CisgCXNrYi0+bWFyayA9IFJFQURfT05DRSh4cy0+c2suc2tfbWFyayk7CiAtCXNrYl9z
aGluZm8oc2tiKS0+ZGVzdHJ1Y3Rvcl9hcmcgPSAodm9pZCAqKShsb25nKWRlc2MtPmFkZHI7
CiAgCXNrYi0+ZGVzdHJ1Y3RvciA9IHhza19kZXN0cnVjdF9za2I7CiArCXhza19zZXRfZGVz
dHJ1Y3Rvcl9hcmcoc2tiKTsKICAKICAJcmV0dXJuIHNrYjsKICsKICtmcmVlX2VycjoKICsJ
aWYgKGVyciA9PSAtRUFHQUlOKSB7CiArCQl4c2tfY3FfY2FuY2VsX2xvY2tlZCh4cywgMSk7
CiArCX0gZWxzZSB7CiArCQl4c2tfc2V0X2Rlc3RydWN0b3JfYXJnKHNrYik7CiArCQl4c2tf
ZHJvcF9za2Ioc2tiKTsKICsJCXhza3FfY29uc19yZWxlYXNlKHhzLT50eCk7CiArCX0KICsK
ICsJcmV0dXJuIEVSUl9QVFIoZXJyKTsKICB9CiAgCiAgc3RhdGljIGludCBfX3hza19nZW5l
cmljX3htaXQoc3RydWN0IHNvY2sgKnNrKQo=

--------------zwp0fCzMyu0iFZNErjcJV0YJ--

