Return-Path: <netdev+bounces-61616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58896824675
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0861C224C5
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E39286B9;
	Thu,  4 Jan 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="cL7OfEtV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C077286B1
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33748c4f33dso582692f8f.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 08:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704386370; x=1704991170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=thmY8lEIRd+jFMV+ra1STaVYpRhrBCGqZj5k6sfmjzM=;
        b=cL7OfEtV06UXhqGTvnk+FCIP0t8rGmy2SRCQeMTO16c1QNaHqgs2ZHpMXEpsYo5NU8
         aHuK6z+fh+WLfIiUTCbTrwmj1oeB71a7JZinT5pjiR4xLNizoeOhImToZyAFzYtiDD/N
         bIqdUsAquFT17HCItbR6V5NCnBWCK/yfkYsyOYgWCO2jHUA98G65TvEybowsOWsrn/5Y
         GOtBzjiSl/5OJqjb3scC5YI5yVvyFHkYpc3nwrWotY4k3M3HL+2QhqeZunb41ibnujgN
         r1Sih8UCDSQEBmex2m5tYDRbADrec/ijaO6+YVz8f9VoYeTmgWEHp8dTjQSWbXDLTXi7
         MD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386370; x=1704991170;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thmY8lEIRd+jFMV+ra1STaVYpRhrBCGqZj5k6sfmjzM=;
        b=rgNOKcKszeZjYmeYrqQ5kiSswhRGHWko1L6oMLqe0nqtWU6O33/7A1x1HMF02quVR3
         /RT9tPRN1+XsYbuhc3GjH9AaspWQfgUcmbFCsSeD8TIZiKdTiU9lwLLN7gGwXY8EFiZF
         z4A4ig8tSk/yTLGu9oq8IkiUvPJoMgIgP2wYsgz9+O5I3LqM1Va8AdmkA+CdCbFenqIO
         EgyVipm5U3WXC8bLv0a7wzzcLVY94IbxMF5/Sa3jhqH+Th5xAo5fRiregbiVyef80+0G
         92fqQKHABQXmpijK3cRmK4II+d3doicraKAMp+yyV2mWW8EREFDLArc2eGTP0eLA38wM
         7StA==
X-Gm-Message-State: AOJu0Yxe+Fba6Clsxy4CEbd4UX/ShSWWBcWElNvp+h/RuErDeMLPgc8I
	hCOM7mIYDE5JzhDFtLqsN0fhO7VDsNlVPg==
X-Google-Smtp-Source: AGHT+IG6AZv/pMRqS14Z6mISEsjuuMM70q2hSCrFhVvyqHBsWA//SBan0/x5nrQo5i7TBVCuxDVEYg==
X-Received: by 2002:adf:e3c1:0:b0:336:77a8:3e40 with SMTP id k1-20020adfe3c1000000b0033677a83e40mr433209wrm.103.1704386370498;
        Thu, 04 Jan 2024 08:39:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:1b61:be9c:86ee:5963? ([2a01:e0a:b41:c160:1b61:be9c:86ee:5963])
        by smtp.gmail.com with ESMTPSA id y17-20020adff151000000b003366aad3564sm33464974wro.30.2024.01.04.08.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 08:39:29 -0800 (PST)
Message-ID: <dccea5b2-ceb9-483c-9274-b3e33f92c949@6wind.com>
Date: Thu, 4 Jan 2024 17:39:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 2/2] selftests: rtnetlink: check enslaving iface in
 a bond
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
 <20240103094846.2397083-3-nicolas.dichtel@6wind.com>
 <ZZVaVloICZPf8jiK@Laptop-X1> <0aa87eb2-b50d-4ae8-81ce-af7a52813e6a@6wind.com>
 <20240103132120.2cace255@kernel.org>
 <4e1d5b11-6fec-4ee2-a091-479e480476be@6wind.com>
 <20240104071752.433651ce@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240104071752.433651ce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/01/2024 à 16:17, Jakub Kicinski a écrit :
> On Thu, 4 Jan 2024 14:51:08 +0100 Nicolas Dichtel wrote:
>>> Looks like the patch applies to net-next, so hopefully there won't 
>>> be any actual conflicts. But it'd be good to follow up and refactor
>>> it in net-next once net gets merged in. As long as I'm not missing
>>> anything - up to you - I'm fine with either sending the test to
>>> net-next like Hangbin suggests, or following up in net-next to use
>>> setup_ns.  
>> I will send a follow-up once net gets merged in net-next.
> 
> Ack, there's still going to be a v3 to update the error message, 
> tho, right?
Right, I was waiting for the conclusion about this patch ;-)

