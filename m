Return-Path: <netdev+bounces-58512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70172816AFC
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2501E1F235DD
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 10:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E5E13AFF;
	Mon, 18 Dec 2023 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2lFImiYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DDD14274
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d13e4f7abso11492685e9.2
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 02:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702895149; x=1703499949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAhY8aDSbSHyfdVv3a4e8tb7OVTCiD6h7HXkcU1kn/k=;
        b=2lFImiYkfDP6OAXDYKvnBvzjI2offdHyM8ugQPOohPDi2zBKS1mUy9OacHgESq1+G1
         AjCN5JUaldQCEMFibuLTk4YCfFRJiZ+3/AGZnHrU//+SmJ+DKmFVed8cnrwao0NJG0hr
         4bf2uUYtuCqSrQ0YadNskLhpAWtF/p9Zh1Wm/Q0DUyoRwXUUULrECDX4d3tS8ve7lKpa
         Vp4V+Ljq0gOZ6rrioV1eIAL7Sj7/NeNmgMV7uUa35R5cyVgxZIhXofGMcJbfxXUGq7VO
         Ws+6qXVfsE5x5QL3QwwFVMu3Yep0V82+cyDLjXrIzQpTTQZ51jqfzLyMQvuifuFDW+iS
         njPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895149; x=1703499949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAhY8aDSbSHyfdVv3a4e8tb7OVTCiD6h7HXkcU1kn/k=;
        b=FZxzD8hVkUPoRjDtZkkwMlV8sSD8VhDG4qZ7yu9X3eny1v0yEUwMeSaEW5Na7T2Q/q
         mt1mQXDsyED2EEir/QAgdVg4JyIpLaGkgv8WiUDyFbIBVKDzAz8qRZ7rQZmFFb+EU78s
         s+/X3RI3KpGiHkjMNPIPom9dS9g3T3CpJ0ramqBIU1caIHGktJpKFdfXGFygKAN6o/s0
         RDSyRfWm/YciWxflxVKUd9xQxpuf5xWOrpKQailtpiDxrnz5GU6jHaRbDOyOgh5cj8O6
         +lXwc+ZjTH1d37m80KuTGpy4tn6WdnRy+NiyUkoue7I76BRsgIs4WG6yH74wGiAhuboZ
         Cytg==
X-Gm-Message-State: AOJu0YzJzFLHZaaGPYtSyo0AJv40/EILfso2hxiDiLJ+EzeitEvibQXx
	7ORrVN7uwxAgP4er7PSPbey/bB0BjHm1y1SCQWQ=
X-Google-Smtp-Source: AGHT+IGJMxQMX0Eoscu3sLkJq6SNkKBPwM2Ver4NRONwd+C+57if1FUNlfPi8M6NlcM1V6yyiEKZBg==
X-Received: by 2002:a05:600c:44c6:b0:40c:6204:d595 with SMTP id f6-20020a05600c44c600b0040c6204d595mr4532968wmo.99.1702895149603;
        Mon, 18 Dec 2023 02:25:49 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d1775dfd6sm5777864wmo.10.2023.12.18.02.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:25:48 -0800 (PST)
Message-ID: <f1d6b9bc-da30-4df3-a97c-b5808a8c14aa@blackwall.org>
Date: Mon, 18 Dec 2023 12:25:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] selftests: vxlan_mdb: Add MDB bulk deletion
 test
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-10-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-10-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Add test cases to verify the behavior of the MDB bulk deletion
> functionality in the VXLAN driver.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Acked-by: Petr Machata <petrm@nvidia.com>
> ---
>   tools/testing/selftests/net/test_vxlan_mdb.sh | 201 +++++++++++++++++-
>   1 file changed, 199 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



