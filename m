Return-Path: <netdev+bounces-22642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF3B768670
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 18:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161212817A2
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 16:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEE0100A4;
	Sun, 30 Jul 2023 16:27:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF402D535
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 16:27:31 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7DE0
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 09:27:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so2375943b3a.2
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690734450; x=1691339250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnkNEXQBzN0S91yvVLGlVg17Tv+qIHtuj8OqBTv0BgM=;
        b=MYosjIHo9334qsfVsYV4B7dx4PccptIIrQdWm5YUj+tq5SYxfpxSVdL6PAS+n8OKbP
         YNdD65YX6RE+q89pdUcvgRjr35EFigfyQMAH8AmNm5o9nHHURaLceIB0i2Jt5kSLRFzT
         YMdupV7AF9vX9ADJwVY3+7FW/PArb9jEYsPxnyZ56/lrOU4XkEnnT1cSQObZ0gw5tjO6
         /2UXbXWwhp24bDxyBq7jxU0LEGBXoaeWrGv5Z5sUDDagvtVJ0GYSK3AW+oHNKv+prd18
         +88w1cbe38JflRMva4YMVaEJr5T2URMgrKgUKfZgVQBXsvhf4z5xu+EAVlgKmlYo6VIV
         GcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690734450; x=1691339250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnkNEXQBzN0S91yvVLGlVg17Tv+qIHtuj8OqBTv0BgM=;
        b=Yz2F/pwkhlv1tYX8U7vtUu74IsVAV4vYvMztb7RFRwcEyzyGqdy9S6OhEAkeRwGIIr
         e4v7Dk8klIuMa9sDTX5YH5GrEYQlrA1holUtvktbhMiCm86ftZSOFq9O+sV2qjIhOn2M
         LQsK8Q5Wi1fHsnklV2W0RVjfkyHdC79JZpSda2EMlf45/7XgpRapGrRnPH2ch9wEMFPg
         4ngkSgCHVXMm3tWE9YuxP1zoPj9X2M7wJdB4kOaoF+iQebwQzeLbVdydsTu4sutZwnB3
         HrFiODfevMPT5bnRWs/Non9ZLr9N+RTd26Prv+C4M+uxieUU8dhxB2OGsu3of3u0C7pC
         pUcg==
X-Gm-Message-State: ABy/qLaBJe9lEL7OHm8xUFdbn0Gp230OjT5fPFqvN7UTaXyRLLRTKKTr
	UVwk7UXAtYEdiM4YIxlyCfKW/g==
X-Google-Smtp-Source: APBJJlF9cz98PcfxhokeLPZeiYDsXIcJc8xPp6veHhlt/j8W8vF76J15hhBLSFMzzcoqXpO0abfsqA==
X-Received: by 2002:a05:6a21:66c4:b0:132:87ab:42d5 with SMTP id ze4-20020a056a2166c400b0013287ab42d5mr6329662pzb.35.1690734449763;
        Sun, 30 Jul 2023 09:27:29 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id fk25-20020a056a003a9900b006833bcc95b0sm6142169pfb.115.2023.07.30.09.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 09:27:29 -0700 (PDT)
Date: Sun, 30 Jul 2023 09:27:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dsahern@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] ip: error out if iplink does not consume
 all options
Message-ID: <20230730092727.5c4c64b5@hermes.local>
In-Reply-To: <20230728183329.2193688-1-kuba@kernel.org>
References: <20230728183329.2193688-1-kuba@kernel.org>
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

On Fri, 28 Jul 2023 11:33:29 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> dummy does not define .parse_opt, which make ip ignore all
> trailing arguments, for example:
> 
>  # ip link add type dummy a b c d e f name cheese
> 
> will work just fine (and won't call the device "cheese").
> Error out in this case with a clear error message:
> 
>  # ip link add type dummy a b c d e f name cheese
>  Garbage instead of arguments "a ...". Try "ip link help".
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Looks good, but then the latter check for lu->parse_opt in the if
clause is redundant.  Coverity would flag that (assuming I get
Coverity running again on iproute).


