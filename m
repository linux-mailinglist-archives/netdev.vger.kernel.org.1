Return-Path: <netdev+bounces-212294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF57B1EFAB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 22:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F913B37FF
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAC624BD0C;
	Fri,  8 Aug 2025 20:40:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBBF24A046;
	Fri,  8 Aug 2025 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685650; cv=none; b=jh4+dxF3Vbsud5YZWrp/jnCmyEJ8B9DTcf4SnWJ2J6iRVgfpwLwnTAOy2GdXeNXPTkBRxUMCP7jAHiizXQ+ITKhV1zcI+D9LZ9dcyp8qRO9LP9/FsFlIq8kc9gxmlzPSC6MC6ofh7azQkKTR7VaXsgaN4i78thxKPZYKBpr7/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685650; c=relaxed/simple;
	bh=d+2deDs4I0RozflNuTYq3IsOK0UF5nO2CS74lt/7woc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAPe9lYG8fG6w/YNdXIqYeRE/QAS6Ah+iZGO6YmyBb1UBa3izLU4WXdyjKbq/v68ryRi8x23nh1Tz+YgMRt41Kca0V4uBVo9SJ1PEfXTQKnrkGw1v1SL7ABR7X+5mXh5bDUdOwBjhjbUH89UPNqwP9dtixcOaHuZy+tG7AW0krY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-af95d5c0736so407477866b.2;
        Fri, 08 Aug 2025 13:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754685646; x=1755290446;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbVQ/O5v+3RgZgLXM+REiGbF7/qp5Rn2INVTmCn1Vcs=;
        b=wsqVIbLNAlmYvwTei2uoAk91OKOBXozVQ3BqM//HZ2A/oT/QIOXt3waJ6lUQH3svze
         kHRIYlgm2iaV7eJggbo/O7T1jm6n8VfS40FRr8vmWcEuAtfuYsNC98FBRIrcnC9wt0Lo
         DGLdgHYd1aACvBa/GfQ+p4LSlMCuzcHIlxk2yko7xqsQwMIDs8EmX4Jrm3UGBc66Q4oL
         lnTfavUzWlozGG+/UfXeyWxKtTpkr41p0vCagLWiZfOOrKJmSRc0bEvOSH+v88cv8oMB
         m1FRPAKYJVa9AMlfMnOQ3QwBt4iXw9wYnTwmwiVC6xLvC+AUHor0SgqcgOU6uWTyQSnQ
         qGKA==
X-Forwarded-Encrypted: i=1; AJvYcCXA/jNf/cT3JxRxZ0fkhPg43AKXQ00pJiEcpqDGdZWHaZ6gx06wMsfB3Vga4c/k1QS+xhEHBIQG@vger.kernel.org, AJvYcCXUMgfP8b60drl1rN48lIM6UbplQOrrkvE1T+HbWdIVuocch5a+JErTQ7AmHvbfv7amJQxO8thGosZdidI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CXdrrEJ9+loyPXPPX0pOlvdx09HC8aW+utaLj6WAqkFhXx8s
	3UaeXwh28zGogyV1/Cmo1oFG2lF0UUSM9F/RltYu3BYelXda23o+xFZs
X-Gm-Gg: ASbGncvzY+wYjlKB28l0SREvVOUgxzQUlbn7kTpXUIQn4yaq0rgFcMWWHUpK8dJZ1AI
	DsnFi1ZjbxzsBeQnsg1+B2HamGaYm0wD8EFf6yI1QnQB3K4BTauhKgBk58S47LUik/SD+FJ0wGM
	ZS/I0l6P9Lwai89GajJoQo9k3uqtyN21SB/xgOG3WKT72xqnuphaFCRvT7mBhQc6oi1i1n1zVCS
	0sn+uXAaSoWXDbQjIw+bsGamiSCqVuCdcjz7cPARAB68P92Pq1j2EidMXAxARdITCRXZIPjzyCL
	Xj+WTJ01teaj4xI9YJQGC7cLxOirpY4qn1YZsx8IgEgGRBD4dxHtmI2wgusEgSmWIFx2oHSbrO6
	kac4ioX3ok+e7n0UOMEZi4jAz4TIWpZYXbeEnXahuk8zotCFzMgzMcVtjbE2Rcg==
X-Google-Smtp-Source: AGHT+IHi5F9XT/jnFTQE6og/i5LhYBEoNQ//ZSY++LklDtkb3M25B7iYOPrX+fWn1FqjLQs50TiDXw==
X-Received: by 2002:a17:907:3d50:b0:ae7:cb7:9005 with SMTP id a640c23a62f3a-af9c64bf036mr356039866b.35.1754685646047;
        Fri, 08 Aug 2025 13:40:46 -0700 (PDT)
Received: from [192.168.88.248] (89-24-35-28.nat.epc.tmcz.cz. [89.24.35.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61802debec7sm188198a12.9.2025.08.08.13.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 13:40:45 -0700 (PDT)
Message-ID: <80f40620-e5f4-4238-995a-f9d348fb1b4b@ovn.org>
Date: Fri, 8 Aug 2025 22:40:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [netdev] htb_qlen_notify warning triggered after
 qdisc_tree_reduce_backlog change
To: Jakub Kicinski <kuba@kernel.org>,
 "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
Cc: Lion Ackermann <nnamrec@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ovs-discuss@openvswitch.org" <ovs-discuss@openvswitch.org>,
 i.maximets@ovn.org
References: <CO6PR11MB5586DF80BE9D06569A79ECB2CD2DA@CO6PR11MB5586.namprd11.prod.outlook.com>
 <20250808132915.7f6c8678@kernel.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250808132915.7f6c8678@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/25 10:29 PM, Jakub Kicinski wrote:
> On Wed, 6 Aug 2025 08:29:34 +0000 He, Guocai (CN) wrote:
>> ### Environment
>> - Kernel version: 5.15.189-rt76-yocto-preempt-rt
>> - Open vSwitch version: 2.17.9
>     
>> ### Issue
>> After applying the QoS configuration, the following warning appears in dmesg:
>> [73591.168117] WARNING: CPU: 6 PID: 61296 at net/sched/sch_htb.c:609 htb_qlen_notify+0x3a/0x40 [sch_htb]
> 
> Is the issue easily reproducible ?
> Could you try your reproducer on the latest upstream kernel ?

FWIW, the issue is likely the same as this one:
  https://lore.kernel.org/netdev/779ce04d-2053-4196-b989-f801720e65bc@hauke-m.de/
Caused by missing backports in the 5.15 tree.

Best regards, Ilya Maximets.

