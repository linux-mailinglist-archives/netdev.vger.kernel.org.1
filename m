Return-Path: <netdev+bounces-59848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CCE81C3A9
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 04:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015C01F217A7
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 03:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56D46D6F9;
	Fri, 22 Dec 2023 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="CKsInn/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55F17C7
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e75005bd0cso16141747b3.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 19:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703217141; x=1703821941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX+s+xxsJSFiXqCRMbxcM3vWwIgmpi3wCqWLp2B/Wlc=;
        b=CKsInn/bxdluo/xwBlBG/o7w44Q64j1wjh50TJZHVLMUTtpt0CfV7NFpC051sxNMvF
         NBNl6xex07QlsBdJsCZCVsaYZsv42sW+VE2Y1D0QAMZg7YgYZ6YBF08uhnwrw8WF/Qgm
         yZmiqK1cIIJzPZWLlXGRiJPCK7kgdJF2VdqGMCLEDKI5olrJ9SxWc3m2dmyxuRFciDmV
         QbtafCFZ8pRKAfYdjGOqaG0fFLjeffvhoEMy6L5BzRL4Dj78FP4rIV4FZhcVqjoAicpJ
         0Sl0uJ6zimJgfgZPLmc5jYzniF0DF3sqaJ1bx93ouMZ6XuRQ749so3c2/W6VIC9Kg4T/
         /Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703217141; x=1703821941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZX+s+xxsJSFiXqCRMbxcM3vWwIgmpi3wCqWLp2B/Wlc=;
        b=oSv58E3OzS6FyZvbIrwGRpMlOXrowPsnW80gR7NpxGSTaJl2nDbB57YTdwOqIdaxEq
         Jxe2Qou4IQWoZ0IGRQjBUFORaOYmeIAeqaG9QWwSLnHdNRcNotwPWSIzvQUcJJ0t3mmF
         BvSYvIz6GAe/8k2vyiwS8nJIar5EfEwBxeU7tASjbxX9Df8c/7JEKgUulifvV6K7FljH
         putRjW8onLnazyN8vWtel91uYxIRYbYOZ8Ne3fzdDCxoX76goXFXkzPBNqYVy7rsNJJQ
         CSDaaWlxiPikDxCOfwqeJoEP4R02bLNzXYFDP8gYLHU5Rq13F6S4VVvNZqra5ujE5IzC
         e4OA==
X-Gm-Message-State: AOJu0YyQXX0HqcMxJodW/AagXCIL/hRpPH+T3FAXV+vkkV4q2os3PW3J
	j9TfgAapb7PmgAqT2xzgK7DSOrE5q1ugbw==
X-Google-Smtp-Source: AGHT+IEvuFLpNcX8o/vC6t0uzsboPO5dkqs2MMMaqx1vv6G/HhNg/kmA1+v8f5nU4gvF61e5UI2Xug==
X-Received: by 2002:a81:8a06:0:b0:5d7:1940:b381 with SMTP id a6-20020a818a06000000b005d71940b381mr783222ywg.77.1703217141765;
        Thu, 21 Dec 2023 19:52:21 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902c70200b001cfc35d1326sm2427111plp.177.2023.12.21.19.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 19:52:21 -0800 (PST)
Date: Thu, 21 Dec 2023 19:52:18 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@gmail.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, fw@strlen.de,
 victor@mojatatu.com
Subject: Re: [PATCH net-next 1/2] net/sched: Retire ipt action
Message-ID: <20231221195218.3fc45303@hermes.local>
In-Reply-To: <e17d5e1e-acd0-4185-ab9d-3efe2833cdd1@gmail.com>
References: <20231221213105.476630-1-jhs@mojatatu.com>
	<20231221213105.476630-2-jhs@mojatatu.com>
	<6aab67d6-d3cc-42f5-8ec5-dbd439d7886f@mojatatu.com>
	<20231221171926.31a88e27@hermes.local>
	<e17d5e1e-acd0-4185-ab9d-3efe2833cdd1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 19:02:40 -0700
David Ahern <dsahern@gmail.com> wrote:

> On 12/21/23 6:19 PM, Stephen Hemminger wrote:
> > 
> > Yes, it breaks iproute2 build if tc_ipt.h is removed.  
> 
> iproute2 header sync would need to remove it. It only breaks apps that
> do not import uapi files from the kernel.

The problem is that when tc_ipt.h is removed, there are defines still used.
Will need to coordinate removal of ipt support in iproute2 at same time.

