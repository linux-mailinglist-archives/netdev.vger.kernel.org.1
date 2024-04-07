Return-Path: <netdev+bounces-85553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7A889B476
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 00:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A883B20DF6
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CEE26AE3;
	Sun,  7 Apr 2024 22:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0C45943
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712527692; cv=none; b=bEDY84u+VzZi3YdUdGCH24J+4QKQ9pgmwSiirQhC2x7i93Nqk0UtNyvrZFMuIvQ0zKgl9WGujIvFH0sD9rd9eLi8CwqwT2522o8IT/LfrJcZg20txDss8w7CNfEO/tlxFZSv1JCT6HBpd+pI3aAaw/wczfev1mUmPFYtXHPm85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712527692; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEFB614aIdoxUlon3ooFbNgmyT19HEl9qRBwT1YSB58lF/ua1C3pS65mfNToVxp/TkTWxWpkzNpLGN01vpqTO0l1a4Y+agc2fl+xWPct/OL+7ymOALy76oWrVBVlb8YE+gaKZlFEY+AsJc47QdEQZJOScDEjarpmku2h1+mm9xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4166344b68dso40475e9.1
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 15:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712527689; x=1713132489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Cmu7B15PCHEcqt0FGtYWw5ZI3NXwoTB8B/EZoGitDy3h7sgYEBlEHLeZucAt8WXxwu
         8NsGPplYNXp5xI2eUp5GJ+9Xfp7a3bpcDX/7XhUr3/LtDaqeNGByqaM8vwn7d79DTkVf
         O7sTKq6MbnNlKOM0IxZRLzHqGicizeYwpfzELiMnngy8zaB9/GkMA85XX0e/mxC6YmR3
         z/6/B4uZnDsDJBVNZgLOJ5o0DVH3hv5st4viZj2cY1C0nZoq3pOAPZdHx9Jk4WlB/zV/
         saVdmtI5Ti8eRT1CvgyXSfG7uFV5Z9WN+SmfZIq45iLhfz6Ena/YgvzruJ0ygblECWGQ
         a6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVkO02oo0DX3M3L4hffXsNGtWbGgmTRBQWK3Y3MVxwuEAfPERNLGlBEZeqc3TcndZSko+0GI6oOZkeMq6rTUVo26ON7h5w7
X-Gm-Message-State: AOJu0Ywvuh/tdlw9eq93gCJSWb5KOrNINJxBQcdZ7QcnL9nfiC7eGO6I
	b0OucGCrJWgdsE3hkzQdyap72yWW/5hfVCaIOXI5n6V8Ouyg62LA
X-Google-Smtp-Source: AGHT+IF5fHR/wnDvTesC1rRC9R2Fs/WTb/mayNQgsQq/Jxr/Ikd1TAk3vWtPwTMqvxVlnh5jV3749Q==
X-Received: by 2002:a05:600c:4f95:b0:414:f154:e652 with SMTP id n21-20020a05600c4f9500b00414f154e652mr5622582wmq.3.1712527689345;
        Sun, 07 Apr 2024 15:08:09 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b004155387c08esm6467144wmq.27.2024.04.07.15.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 15:08:09 -0700 (PDT)
Message-ID: <c9b64779-2e8d-4d32-bfc3-c1281f59fa9e@grimberg.me>
Date: Mon, 8 Apr 2024 01:08:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 05/20] nvme-tcp: Add DDP offload control path
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 brauner@kernel.org
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-6-aaptel@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240404123717.11857-6-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


