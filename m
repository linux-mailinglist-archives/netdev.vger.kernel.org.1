Return-Path: <netdev+bounces-28079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B48677E261
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6983F1C2109C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B8E11196;
	Wed, 16 Aug 2023 13:19:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0711190
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:19:56 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46E12711;
	Wed, 16 Aug 2023 06:19:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso64063665e9.0;
        Wed, 16 Aug 2023 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692191992; x=1692796792;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wq7iS3GVqAQ19LZ3mWm5bZucgnrQuU1JSvKnXE8fh6Q=;
        b=hwszNoyGz2bHEvb3K2vl//0GT79u4E7BcxWKphNsYvaZmZsL4X7Rpe/bXblG6+opMA
         7bTQwRHfRjCRR6RAzh6lcSq9bOC2GQ7BLYVGUKGTqM+dwvdgEIY3RAIeEHO3gZaZomXH
         RvBeUxRX4o57M3v4JyLtjAC1c0k4i+rQiFMbiBbIJvYXUEdm3V06f+ZDgG0Rlvoh1LI+
         tg8cRxj+ylDsauHuY+SD4DKOwjWQCyEm/C1scI4k5Bw0vqvhmVS2F7KiTVrsUYoSeqn7
         3a5T9L8BdQizO6iDBfmm1nCZr9wHy49o52pRAIAtzUKD/Q5nXuPogCsDS+7++ht0L01D
         S9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692191992; x=1692796792;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq7iS3GVqAQ19LZ3mWm5bZucgnrQuU1JSvKnXE8fh6Q=;
        b=GqUlbSO1K0ceYAYq2M01goM2JETt3pC3FTFyfqMbmiwPy5dg7GAH/u3aA1Wtl4dbIO
         4tUtIl+uoe0ke93hqm1P+L9Mb+S4LjNtHeNw+C2QspC1OvEfRtUPGeOf/oJ2APD1i9dB
         7Np9/2CuXOU9sHc9WR1/SpIE21Uea434vRgTg9k1xlFz/BqIEQY8KN15J5+A1v7V7SSt
         4wn9UXBwsuvtVTDkHaRbRBBHFv2E367A32HsApXO0l5ZmwFrj77+PE3wGEs89jaoGKP3
         vjiEpYsje9HsAbhQJQREHqZd1bw7DKL8xoYXLG4gVXURVESwBu9BDowUljPemR7TIGq3
         H2Yw==
X-Gm-Message-State: AOJu0YzO+RkMB0pEXku890ZNlKJIPTXMHstAWp4GSYuJf/5ggY6dLpfw
	TxH+T8TPKVZtTYWKqMm/JwA=
X-Google-Smtp-Source: AGHT+IEm8fA8Hlubk22Pn6O/QADRkuN03m4HKN5kRAe1fudRdJOKGQ+YzmhUeDhPA1Qf7pslqQ3y4Q==
X-Received: by 2002:a7b:ce95:0:b0:3fe:1871:1826 with SMTP id q21-20020a7bce95000000b003fe18711826mr1434074wmj.27.1692191992039;
        Wed, 16 Aug 2023 06:19:52 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:79ba:2be3:e281:5f90])
        by smtp.gmail.com with ESMTPSA id n9-20020a1c7209000000b003fe577eb8cbsm23975466wmc.44.2023.08.16.06.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:19:51 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Jonathan Corbet <corbet@lwn.net>,
  linux-doc@vger.kernel.org,  Stanislav Fomichev <sdf@google.com>,
  Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 01/10] doc/netlink: Add a schema for
 netlink-raw families
In-Reply-To: <ZNyLqxEVDh0JG7h7@vergenet.net> (Simon Horman's message of "Wed,
	16 Aug 2023 10:41:15 +0200")
Date: Wed, 16 Aug 2023 14:19:28 +0100
Message-ID: <m2pm3ni0pr.fsf@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-2-donald.hunter@gmail.com>
	<ZNyLqxEVDh0JG7h7@vergenet.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simon Horman <horms@kernel.org> writes:

> On Tue, Aug 15, 2023 at 08:42:45PM +0100, Donald Hunter wrote:
>> +  c-family-name:
>> +    description: Name of the define for the family name.
>> +    type: string
>> +  c-version-name:
>> +    description: Name of the define for the verion of the family.
>
> Hi Donald,
>
> a minor nit from my side: verion -> version

Good catch. This typo was copied over from genetlink-legacy.yaml so I'll
fix it there and in genetlink-c.yaml as well.

Thanks!

