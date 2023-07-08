Return-Path: <netdev+bounces-16219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF43574BDD1
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 16:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11A52813F9
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D902C79D0;
	Sat,  8 Jul 2023 14:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1653C04
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 14:29:45 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F71B170F
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 07:29:44 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40398ccdaeeso11245391cf.3
        for <netdev@vger.kernel.org>; Sat, 08 Jul 2023 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688826583; x=1691418583;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q2Zs9U1nHuxMGTO/F4BqZr1WSmNpO+1aao/ZMCR9+k=;
        b=cTGidDZLs00MhdUTnfbJG5cBdwzjRaTDO3lb+j9rS1w3i+8XC6uXK2P38gkPvUevWu
         J/bOh/femrq4y3K66n2144Q3TkmsW82RQ+bPzHrwKZVWUmALeeBJ6/eeafNCRlmlo/Fj
         V1uPjqwwZ3nInYYK+Wo2Cbh7qEKzDz54JxktEHmfjGNNYtVZcBNJD8sbF9Ef9Pclw5ZK
         H6NP6Q/v33AQJda5jOpkD3GKHBFntq6iXZUZtLqpjhmbe18mWSUOB+Sy9CJdYul2X/Ch
         kyVAFP9ZgrWE/AHglW8vI+WhKfC6XcxOBlQBRzQnfzmGY0X8WPxpMtx1gTEj5QEidkd+
         qSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688826583; x=1691418583;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Q2Zs9U1nHuxMGTO/F4BqZr1WSmNpO+1aao/ZMCR9+k=;
        b=QQugYOZb9Nsr0+3x6T4M3mfLbLNppzc72l9RGRNwbjAvegUPesEmgMEsQluqSRGQIm
         nOLZ/SxukqtEdd8x5GiV14nnG6RLMbQWc58Wg4om4ZH7pPwomu5jmapm6y+zRyymxQlD
         +xv/UGSylwyfDk5bOymU7dsFV2GPMYUF95uj6w5uziwl2xcrLbrphu79dfopowui+vnO
         CchwpDX2ODz62Zn/SxBaHgIReS/3/8xdK9dRx/Ara94DB2vGZywrbFP/yc8L5yB5yfbr
         FryaOy5mdBJ0GzOStqPLsMack+ewv9mOLVd8uBuXBRIfRwhgTn1JcVmmrF5jj1FF20XF
         kyhQ==
X-Gm-Message-State: ABy/qLZuq73TF0O13JNLFeZd+eq6rJgF1Kk6X0pUcMV+mzOPE9G5l0oe
	bwSZG79Q+IfUed5C1vNtBGU=
X-Google-Smtp-Source: APBJJlEpICIJrOMT6bx41REHLJ+mdiZ+WzrNfG4k47AjRvN0Is+o7DJ9gYcB5RQnf7icpWgn6ULxLA==
X-Received: by 2002:a05:622a:148d:b0:403:9cfa:2dcc with SMTP id t13-20020a05622a148d00b004039cfa2dccmr4747888qtx.42.1688826583598;
        Sat, 08 Jul 2023 07:29:43 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id a20-20020ac84d94000000b003eabcc29132sm2806212qtw.29.2023.07.08.07.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 07:29:43 -0700 (PDT)
Date: Sat, 08 Jul 2023 10:29:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 Amit Klein <aksecurity@gmail.com>, 
 Willy Tarreau <w@1wt.eu>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <64a972d6c7e72_39f26a294ef@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230708082958.1597850-1-edumazet@google.com>
References: <20230708082958.1597850-1-edumazet@google.com>
Subject: RE: [PATCH net] udp6: fix udp6_ehashfn() typo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet wrote:
> Amit Klein reported that udp6_ehash_secret was initialized but never used.
> 
> Fixes: 1bbdceef1e53 ("inet: convert inet_ehash_secret and ipv6_hash_secret to net_get_random_once")
> Reported-by: Amit Klein <aksecurity@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

