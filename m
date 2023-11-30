Return-Path: <netdev+bounces-52613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7607FF794
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE441C210C9
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BEF55C06;
	Thu, 30 Nov 2023 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7blsx8b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F945D7D
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 08:58:46 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5b9a456798eso906300a12.3
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 08:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701363526; x=1701968326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCE4UAawdz6ryz0eLD+dP9c05mbkDhPO13DKRyqBzZk=;
        b=m7blsx8bvce+VPhlVj1xDrX6ZxP2K32jOtks5vY81tALqAKMZuUu1HeVoCm8xo7Mhe
         MacWeFDfZAvVmErbGTei3h5sdev+slR/N6fvqzoUw6jw3kt4gWGVcQGLnoRdJ9Zgap8l
         gbtU0oJWzk4mBYhiJskt0WpACHbFCKwNt68m4/0c6Ix2l4vYJCQVO/mCwtnvrjI5FANs
         8itZc0sTwiWS3mVY++v2hRro9+sN9kgQ6PCQseoLVtqWly8qotZ5bGADbJhJ1NBWocZX
         SnLRB/wCmcM0RdwKJEoM4kuBQreS77x4FP9TKF2L36//RZv9JBAn8DpaoNRpacS7DjUK
         hb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363526; x=1701968326;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCE4UAawdz6ryz0eLD+dP9c05mbkDhPO13DKRyqBzZk=;
        b=pXfvDPATJwNKDbHQvtrXhAWZsuEMxdnKyV3XMnN5ytKkxiLdvn+Zzs1MAsNB81hFHU
         8+Krp7InsrSXk4Pg9wgQZetPwbo3q4Ta9IyBm3umeb5Xvk7czYcFazClzgVdHWBK7V1L
         q3rlYJOUpuPTMX29A4CA22DOXRJPei7uiCP8YfSX0hj2NWN1SKAPFk7ojD3LD9dXQXgd
         I62ZMDAn+3PhZiVkwkFQZSo4uZdQ9ESCzTQK+ueMfIj9IXz9OmLsILldI8V2/EmCFy2Z
         zbZSdJ1frdUQLpko5aX7TSIhMZu/1FdR33Af92cb6/6sm11XbUzHlV9OqVzPcSSQiZ5a
         H14Q==
X-Gm-Message-State: AOJu0YxNdQMGevfkednLooijAKPpAdn3kuAtEH9uCDqI+Sap7vm7OUVX
	6jrHvWzKw9mNeSdVgHkpgS0=
X-Google-Smtp-Source: AGHT+IH5sI0DlC5Af8wEmNLFjSnHuWpFuTaAtPtD2+Ra9szVwJockfITiojL6quvEbLOEh7pgv7pbw==
X-Received: by 2002:a17:90b:3846:b0:27d:6d9c:6959 with SMTP id nl6-20020a17090b384600b0027d6d9c6959mr19882036pjb.25.1701363525960;
        Thu, 30 Nov 2023 08:58:45 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902a5c500b001cfad1a60cesm1611984plq.137.2023.11.30.08.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 08:58:45 -0800 (PST)
Message-ID: <0f782e66-bb23-42ca-927d-59f2978cb90a@gmail.com>
Date: Thu, 30 Nov 2023 08:58:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mvneta crash in page pool code
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Sven Auhagen <sven.auhagen@voleatech.de>, thomas.petazzoni@bootlin.com
Cc: netdev <netdev@vger.kernel.org>
References: <ea0efd7d-8325-4e38-88f8-5ad63f1b17bc@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <ea0efd7d-8325-4e38-88f8-5ad63f1b17bc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/30/2023 8:53 AM, Andrew Lunn wrote:
> Hi Folks
> 
> I just booted net-next/main on a Marvell RDK with an mvneta. It throws
> an Opps and dies.
> 
> My setup might be a little bit unusual, i have NFS root over one of
> the instances of mvneta, and a Marvell switch on the other
> instance. So i included a bit more context.
> 
> I don't have time to debug this at the moment. Maybe later i can do a
> bisect.

Does this fix your issue:

https://lore.kernel.org/all/20231130092259.3797753-1-edumazet@google.com/
-- 
Florian

