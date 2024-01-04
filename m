Return-Path: <netdev+bounces-61667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3788248FE
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 20:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739401F2315A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 19:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8FD28DDE;
	Thu,  4 Jan 2024 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DsnE7kk5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5912C68F
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d426ad4433so5826305ad.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 11:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704396421; x=1705001221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmJ4SspDkwE4woJzZdInNwDFpZEnKt5LPEN/LE3uE/0=;
        b=DsnE7kk5/XYlh6hBDVjUEUlaK5ngQRG2cgN9K+RjpnD2l1GUrq5mzt8YtMgbHF6kyf
         co2NI5Ibs2aJ+mNmJDrDmzjt3C4NNMJsFDR+pmW71cR8rEjQTYxLiSSMnc8XDolFcn4n
         /MnWt+5xuHiJxHjvhhMKtM6fw5eCH0et/6S6oOK83KsA3byCfYCGfEOUMfRxwJNuAX1Y
         GesRWpkoexRhmmdVtKRm3vD4sP5+P3OQLu+OepwtzvctY8MTSgk1u7e6HymTw+y6q3PC
         WlT7cK+NvRLSDJNIQSMulSlJwp2bM0sTowfl9t75mzJ6eOnEqiNBVqxc98HrrQv17GA0
         DvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396421; x=1705001221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmJ4SspDkwE4woJzZdInNwDFpZEnKt5LPEN/LE3uE/0=;
        b=nCeO9fkzL2oqxhO1SB2PMKaZciq/7eoIpmpS8bJBqRZ6uLQSJrvgHgoi1vqj/JpvGk
         hLEof8We5/VKNuJkYLxb0cFr6UXJd9k84husACaA7UDEZfyXE3Nxr/bWBjz6qxsnl27I
         PNFm60VWZ5dzggkcJwTejb2o/PaAW6zgUKJRhJiu8CX9hxT8iCRwH5sRdv6CxoKssavo
         7ymqE7Zx9Y8+fJwjkrEnxUp3+3FTXKdPdz7RUPQWXX45gNgdI3NABC+/9cvIRYdQ8BlK
         gJ1IWiX7WeYzT4pr2BJH50RKt0dUFYiXL6wCdvq/Bj9biEm93b2mfVciGhtOxi/DMHf8
         5ZeA==
X-Gm-Message-State: AOJu0YwXdn6dfzZUHM8rio1K3Yhb4+LcxPu3gMMoFD2hin06HTOJeu/S
	18vWN8M+MH8RZAxbEZb4wJpO+HCGADJi
X-Google-Smtp-Source: AGHT+IGOKMJQogjb72/poohLRAShQ6fx9z6Jb7GTZ4kD4h0NbnJ/QSak10rTqsVBev1C82uO2GOT6A==
X-Received: by 2002:a17:902:6507:b0:1d4:ab6b:f102 with SMTP id b7-20020a170902650700b001d4ab6bf102mr1075862plk.85.1704396420853;
        Thu, 04 Jan 2024 11:27:00 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:aba3:7663:8830:3d6b:aa9f? ([2804:7f1:e2c0:aba3:7663:8830:3d6b:aa9f])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902ec8a00b001d33a7fd3fcsm25936593plg.16.2024.01.04.11.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:27:00 -0800 (PST)
Message-ID: <b0a7aa1c-9767-412e-8f79-8a703a9a05b5@mojatatu.com>
Date: Thu, 4 Jan 2024 16:26:55 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 pctammela@mojatatu.com, idosch@idosch.org, mleitner@redhat.com,
 vladbu@nvidia.com, paulb@nvidia.com
References: <20240104125844.1522062-1-jiri@resnulli.us>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20240104125844.1522062-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/01/2024 09:58, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Inserting the device to block xarray in qdisc_create() is not suitable
> place to do this. As it requires use of tcf_block() callback, it causes
> multiple issues. It is called for all qdisc types, which is incorrect.
> 
> So, instead, move it to more suitable place, which is tcf_block_get_ext()
> and make sure it is only done for qdiscs that use block infrastructure
> and also only for blocks which are shared.
> 
> Symmetrically, alter the cleanup path, move the xarray entry removal
> into tcf_block_put_ext().
> 
> Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
> Reported-by: Ido Schimmel <idosch@nvidia.com>
> Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
> Reported-by: Kui-Feng Lee <sinquersw@gmail.com>
> Closes: https://lore.kernel.org/all/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com/
> Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
> Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
> Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>

