Return-Path: <netdev+bounces-41435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D587CAF0A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3A2280F87
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976EC30CFE;
	Mon, 16 Oct 2023 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsrcyoMs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565E2C87E
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 16:21:39 +0000 (UTC)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCF53AA5
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:19:27 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7a25040faffso206279439f.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697473165; x=1698077965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lh3AjXT0SxXJ6SrPzkR8cT6Aj5jcW7MvNVnQwFXAj4=;
        b=TsrcyoMsRt3oEk0/rSxtqu5HNfE3YhTqfS0uccH5BDKnRjgxZ+l61Us0ZjzatGTLvA
         VqSBHqAavuuhwGQWi2c6SZBflm2XNiiWQt/aBrrhY277KaxLU86ILBozed2Se9NV7sHC
         O7dHJmmfzzcJ2mFvDqlPy+LyN3Vso3gRc/RvmlDckPhBlVo8vNP+WS5ixKSA66J+EHKH
         wbg4DqeCnoFPt1LnZHSiVofXtyAp+Wm6jLNY3QkbO/1dhRSlnlkJx7Ca2/SFRuRX7Nrc
         8wvCcjW4IKbKzwIzU/zeM8rE09bJ2ZUSaTXeAU5eAZjiCG0iemwsImcvdganPcRnFtLv
         3Rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697473165; x=1698077965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lh3AjXT0SxXJ6SrPzkR8cT6Aj5jcW7MvNVnQwFXAj4=;
        b=cgUEGoK/tnhqeHdn6zdorx3r891aF6tvvKsXQZvdgkJXIpPJfnBEkkUJo3KblCM2Df
         wK/Lcrrrnizg6zqACOd+rDMgPGdzayJTGzbZo0P6nQ5tBd1xEYIZmTjgMlZN2Cp8wN8N
         rwKVL11ecsGxzfBnCz4KgCffdlc8cQnzE5UHyek3wOipYj0zrjOkHmGHQ9HRXFV14xcX
         9GqUEEGW23ucN35VX4THvM/TVIvM1YBt7MjNJKL+7r7t3AowMA14Fmz8Lb8V1hlFFjTC
         NGt7ajE95uYpRMc1yynaoUg1ryvY01VkoRRvbDE/HXHeAjbTHfxyILk+oILVC5giThL/
         Y/eg==
X-Gm-Message-State: AOJu0YwU6y7BdkrJErU0dlOwgWrJMW7erebGEMJ6vkVCJIgR6K3mc36P
	izH8f8hUwwPmJUgkBE49Sso=
X-Google-Smtp-Source: AGHT+IEgDrcreqAVg7AFqA8Kree01qna5bayNJkBaFZC1VZsWRk4vke3gmvNby67bqPDO01IvrnVqw==
X-Received: by 2002:a5d:990f:0:b0:783:4f8d:4484 with SMTP id x15-20020a5d990f000000b007834f8d4484mr36858350iol.2.1697473165189;
        Mon, 16 Oct 2023 09:19:25 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:6964:515b:e2e1:e1eb? ([2601:282:1e82:2350:6964:515b:e2e1:e1eb])
        by smtp.googlemail.com with ESMTPSA id br13-20020a05663846cd00b0042b62a31349sm6462850jab.146.2023.10.16.09.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 09:19:24 -0700 (PDT)
Message-ID: <9c0d9c44-c32a-92c3-860f-e391468b8eed@gmail.com>
Date: Mon, 16 Oct 2023 10:19:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH iproute2] bridge: fdb: add an error print for unknown
 command
Content-Language: en-US
To: Amit Cohen <amcohen@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 mlxsw <mlxsw@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "razor@blackwall.org" <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>
References: <20231010095750.2975206-1-amcohen@nvidia.com>
 <169716482325.8025.6745747640034207795.git-patchwork-notify@kernel.org>
 <BL1PR12MB5922484EDA55CD9363B0D673CBD7A@BL1PR12MB5922.namprd12.prod.outlook.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <BL1PR12MB5922484EDA55CD9363B0D673CBD7A@BL1PR12MB5922.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 12:36 AM, Amit Cohen wrote:
> Hi David,
> Can you please merge it to iproute2-next?
> I want to send patch-set to extend "flush" command.
> 

done - merged main into next


