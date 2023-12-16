Return-Path: <netdev+bounces-58203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E478815870
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 09:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0022A287DDD
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A4F3D6A;
	Sat, 16 Dec 2023 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhYtYQu7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50B13B13C
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d336760e72so12664655ad.3
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 00:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702715745; x=1703320545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRtQJ5iprZwUVpzTwX9Ep0tq44DfbdZyRVFr7Lr97tU=;
        b=hhYtYQu7DbyjImyBbNEBLu5XytR9sLgmv/0dQ2W7FLoSs7ONof6hTtWNgAvJaRhOOC
         ui+Lrt6awbCxhrsqTlOXrBc598a33Xp1BLWqLdE57ZA0N+GAO7ApBZT9RBM7D0DhrPr0
         u86rK+UGkUB21HRVj2F70FEZ1uzbKocQ2wak2KtnCF3GBW+AL0nBHRMAJJNkb8wOu6TN
         NUHfnYX6hOJpQQ2KkNFUyE2Is8e4ljtU5PobJkNdgGAVrNRk9S5eVftJUhvSTeAc+RTR
         8bMeoq7463RblPsaIWDyE+YaQHNj6L4yjlZ9OZ+twp4E+4e8KfLBiwNQ5Qo4IHivOAlF
         rkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702715745; x=1703320545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRtQJ5iprZwUVpzTwX9Ep0tq44DfbdZyRVFr7Lr97tU=;
        b=mJ8pU+b8y8/0EFIxx+g0JhpNDOHkVVZtB/1KD/r+x4lO9FuZ2lvqENMiLtzdpVkyR9
         aH0WZYK7M/9EB2tB21WR56ZDkw1lQqWSF1HFQs93iEFtcTV/fH6VLbxTXsqxSBjZQgAE
         cifHUA9de9TEnUYlNRgLGPoUqOQtBgEf7rymcaPT+5M/RMKWop/saSB+u2FzXYO2WCEv
         Hf3EeRhtFcZ99UQevmPYASXuHF+vL6jriShu+ETcwt/o8gNeDEeDdrWszHJXPIvoKIMX
         wvev0vxyJrvb0ukgK4ZTPaasY1qOSS4BmvDlomGcTVSxENo/LEaYU4g9ELx4BTDWa2/F
         7axQ==
X-Gm-Message-State: AOJu0YwQFwGQYubkwjbMH3DqdmVHOmUbHXeOG6rL0lB/l0gA7RS/JZQy
	9u2UH9XASgSJ4c9j73fHckdHMsv+SEppnhkI
X-Google-Smtp-Source: AGHT+IF556BRc134mWIvNxrXi13x2zSK5KvCJzY+lLuabeNFi50prQer8Oefi3/LiJagz6RZf0iWQg==
X-Received: by 2002:a17:902:7d8e:b0:1d3:45b7:bc09 with SMTP id a14-20020a1709027d8e00b001d345b7bc09mr6201326plm.55.1702715744526;
        Sat, 16 Dec 2023 00:35:44 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902eac200b001d36c47b768sm4189131pld.22.2023.12.16.00.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 00:35:43 -0800 (PST)
Date: Sat, 16 Dec 2023 16:35:40 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl-gen: use correct len for string
 and binary
Message-ID: <ZX1hXMhJLwgg5S1v@Laptop-X1>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
 <20231215035009.498049-2-liuhangbin@gmail.com>
 <20231215180603.576748b1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215180603.576748b1@kernel.org>

On Fri, Dec 15, 2023 at 06:06:03PM -0800, Jakub Kicinski wrote:
> On Fri, 15 Dec 2023 11:50:07 +0800 Hangbin Liu wrote:
> > As the description of 'struct nla_policy', the len means the maximum length
> > of string, binary. Or minimum length of attribute payload for others.
> > But most time we only use it for string and binary.
> 
> The meaning of 'len' in nla_policy is confusing to people writing new
> families. IIRC I used max-len / min-len / extact-len and not len on
> purpose in the YAML, so that there's no confusion what means what for
> which type...
> 
> Obviously it is slightly confusing for people like you who convert
> the existing families to YAML specs, but the risk of bugs seems lower
> there. So I'd prefer to stick to the existing set of options.
> 
> Is the existing code gen incorrect or just hard to wrap one's head
> around?
> 

The max-len / min-len / extact-len micro are used by binary. For string we
need to use "len" to define the max length. e.g.

static const struct nla_policy
team_nl_option_policy[TEAM_ATTR_OPTION_MAX + 1] = {
        [TEAM_ATTR_OPTION_UNSPEC]               = { .type = NLA_UNSPEC, },
        [TEAM_ATTR_OPTION_NAME] = {
                .type = NLA_STRING,
                .len = TEAM_STRING_MAX_LEN,
        },

Thanks
Hangbin

