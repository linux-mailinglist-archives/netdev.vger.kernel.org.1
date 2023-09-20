Return-Path: <netdev+bounces-35277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647BE7A882E
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D69B282A51
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0E23B7B7;
	Wed, 20 Sep 2023 15:24:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7783B2BF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 15:23:58 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFE9A9
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 08:23:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c46b30a1ceso34765505ad.3
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1695223436; x=1695828236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WkLLZC/rBPsJdYG8q+EC9kd6uS4bKvRBbUtgVbYmxo=;
        b=OJpKIdXgqpig9ii5pOcF91eo4CCBNxyRsj0hQLWnQdR1TO/7EaXK4koUeQBr/ChWHb
         tw6Xokg8120ics9Om5uJNM/BF5pmckFFWwLKLk6MZMtoixMPBCpq6z6YWeaFCS372yFn
         Rk9SyjvTyEpWyhH6JLf6sPadGXK2EzuMbH4VA9YwdRkLPwwG17irkWH+ovP8GYsCAoSQ
         KTHWp7CvLF8FkUrs7Je+p+pj359LJMZMNwxV5N7MUsAlzY72uzlxRgDKH7y9Zl1hdhIL
         PtgiT0evGKZ/2UPqvWucHuWVlA5u8TyIVJJX7foZk5CvTp7akBrYCkssL61VKNQBpNX2
         t/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695223436; x=1695828236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WkLLZC/rBPsJdYG8q+EC9kd6uS4bKvRBbUtgVbYmxo=;
        b=nRfS0i6QZJ7J2ii7/056em9qmPN2kRXVhyGNXFy309rCUkSw077uEmai1VA3NL7Evy
         RdniGVaAXhySAFVItM+ZTJmOvyC3QiRFbA3DmGeSROj0Z8x+7QI1tvVnYGwizFl9pcH0
         OIRuJr/DrO4+6YTXi7vyysxB+oPfA9v7ZsZkkKWtmt9BRDA8HNUFZOw6JAMfG992AzZJ
         U/otRvGSD2KNk28Y93ekDUW2jjXm+rGZGo++zVqtAJKKdKeVbT3qZ3IRMfIM3nSeIz1a
         zO6G8b68VfzAEbKN9DBJtYmjNRzOOYkvAwid9lfb6rswYzDm6HnABAYKGwfsypEL8/qc
         M8Ng==
X-Gm-Message-State: AOJu0Yyx2UbI0TOB5O8Sjh3UgLQ/HNB2C1zm/7zkVzSJ7//LJAJw+FBU
	3C0BTKTz4kBlB29dHpZB5DBKV0DMXPlfKUPeaWM=
X-Google-Smtp-Source: AGHT+IE+i37pzzDXzPfT6xWZQcF6lsngVoOWVq2+oHoj1M0DrvBKc4eB8pO65tFJmR66nFfHZU/ftg==
X-Received: by 2002:a17:903:120c:b0:1c5:a49e:7aa with SMTP id l12-20020a170903120c00b001c5a49e07aamr3016789plh.27.1695223436099;
        Wed, 20 Sep 2023 08:23:56 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001bb9aadfb04sm11934690plr.220.2023.09.20.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:23:55 -0700 (PDT)
Date: Wed, 20 Sep 2023 08:23:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: skakishi <skakishi@yahoo-corp.jp>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] Improving `ip link show` output in iproute2
 for PF/VF association
Message-ID: <20230920082353.6a6cefcb@hermes.local>
In-Reply-To: <20230920052826.22211-1-skakishi@yahoo-corp.jp>
References: <20230920052826.22211-1-skakishi@yahoo-corp.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 20 Sep 2023 14:28:27 +0900
skakishi <skakishi@yahoo-corp.jp> wrote:

> Hello all,
> 
> The current version of iproute2 does not display clear associations between
> Physical Functions (PFs) and Virtual Functions (VFs). To address this limitation,
> I've added the following enhancement.
> 
> Proposed Changes
> When the 'detail' option is enabled, the command will display additional details,
> including VF IDs and their respective names.
> 
> For non-SR-IOV legacy mode:
> $ ip link show -d
> ...
> 1: enp6s0f0np0: ...
> vf 0 link/ether ... name enp6s0f1v0
> vf 1 link/ether ... name enp6s0f1v1
> ...
> 
> For SR-IOV switchdev mode (including VF representor information):
> $ ip link show -d
> ...
> 1: enp6s0f0np0: ...
> vf 0 link/ether ... name enp6s0f0v0, representor enp6s0f0npf0vf0
> vf 1 link/ether ... name enp6s0f0v1, representor enp6s0f0npf0vf1
> ...
> 
> Technical Details
> I've taken the additional data from sysfs.
> 
> Current Work Status
> I am actively working on implementing this extension.
> 
> Request for Feedback
> Do you find this feature useful?
> Do you think getting data from sysfs is an appropriate approach? Are there any
> alternative methods you would recommend?
> 
> Best regards,

I prefer that functionality in iproute2 comes from netlink.
The kernel may need a change to put the vfinfo in the current netlink data.
Sysfs becomes less likely to work in cases where containers or other security parameters
are involved.

